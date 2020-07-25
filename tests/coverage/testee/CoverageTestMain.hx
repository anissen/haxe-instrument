package coverage.testee;

import haxe.macro.Context;
import instrument.coverage.Coverage;
import coverage.testcases.IfBranches;
import coverage.testcases.IgnoredCoverage;
import coverage.testcases.MissingFields;
import coverage.testcases.SwitchBranches;
import coverage.testcases.TryCatch;
import coverage.testcases.WhileBranches;

class CoverageTestMain {
	final includeTestCases:Array<() -> ICoverageTestee> = [
		IfBranches.new,
		IgnoredCoverage.new,
		MissingFields.new,
		SwitchBranches.new,
		TryCatch.new,
		WhileBranches.new
	];

	public static function main() {
		var testClassName:String = Context.definedValue("test-class");

		var reporter:CoverageTestReporter = new CoverageTestReporter();
		var clazz:Null<Class<Dynamic>> = Type.resolveClass(testClassName);
		if (clazz == null) {
			Coverage.endCustomCoverage([reporter]);
			return;
		}
		var instance:ICoverageTestee = Type.createInstance(clazz, []);
		instance.run();
		Coverage.endCustomCoverage([reporter]);
	}
}
