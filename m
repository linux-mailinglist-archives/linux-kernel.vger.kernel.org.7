Return-Path: <linux-kernel+bounces-898254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E7C54B36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4B35348973
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F12E6CC9;
	Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER/6Dmnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1F35CBB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=MQsMUf5dy7hNCrjxzGcAQJ67cnNHaeuLX0G8BstriD6VPzNkEleuMgnNvvjLvyUe0BjMFeQujx8A4yevxlveiXvk1Gp7hyHOWINbfTF8XHApcZKCxq8LMDGoBPHDgVthfK4J52aruT8WZ9ciegGMuUoJwnFk/knpbKwGX7fDehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=p6zGcXkXOXZOM6fntSB2PcOW7ci/r7QO+B/3UUeuicA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=I12vM4bchdmsMiXOqiLLNXFgYApcbHhVBV4LH7Rz1kplXqZrS3LLDe3URsLmNedtzvmmNXoYq7A8o6bJhEeft+m97tkSkvJjGZ9v6NqfjDDnnaeVFduCj/GKbCI2YnPT1lQtdR7jyD+2TJ2e097mQfjMGbq3vyhVKBwuakNXolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER/6Dmnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919F9C19423;
	Wed, 12 Nov 2025 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985992;
	bh=p6zGcXkXOXZOM6fntSB2PcOW7ci/r7QO+B/3UUeuicA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ER/6Dmnvv46tjcTwP7oN79ieg0jErA6DxhAv73dPej9rOqHAAcwL/YBZB0HFU3IOT
	 Z6ZEa7jzvLoNx/dIYZhRUuAy6v1jgRT/CEabLJdrLGIgtG2y6bcwBKo+aiu7XM20mi
	 PbMG2rdTc1tgUBKLMBZVnCcjkHwwG6t3FHMwWM3pTBh0fqYec18tHmFL5xiaoHQO20
	 g2BuQN26ODEetX55lpCd02AE6kCBs6XLasapIWIOZadpLeZ14neQ1gdQxueDdLRDBt
	 OKEVKQzIUPSBqXq/8GAgV77gSmcnBWF8yAXla+In+qw5ylKDRoGHpmm3GGhfTuHiHb
	 V/QuNLUzECWRw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCA-00000001EVr-39Sq;
	Wed, 12 Nov 2025 17:20:06 -0500
Message-ID: <20251112222006.608234586@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:47 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 1/5] selftest/ftrace: Generalise ftracetest to use with RV
References: <20251112221946.389142361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

The ftracetest script is a fairly complete test framework for tracefs-like
subsystem, but it can only be used for ftrace selftests.

If OPT_TEST_DIR is provided and includes a function file, use that as
test directory going forward rather than just grabbing tests from it.

Generalise function names like initialize_ftrace to initialize_system.

Add the --rv argument to set up the test for rv, basically changing the
trace directory to $TRACING_DIR/rv and displaying an error if that
cannot be found.

This prepares for rv selftests inclusion.

Link: https://lore.kernel.org/r/20251017115203.140080-2-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/ftrace/ftracetest     | 34 +++++++++++++------
 .../ftrace/test.d/00basic/mount_options.tc    |  2 +-
 .../testing/selftests/ftrace/test.d/functions |  6 ++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cce72f8b03dc..3230bd54dba8 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -22,6 +22,7 @@ echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
+echo "		--rv       Run RV selftests instead of ftrace ones"
 exit $1
 }
 
@@ -133,6 +134,10 @@ parse_opts() { # opts
       LINK_PTR=
       shift 2
     ;;
+    --rv)
+      RV_TEST=1
+      shift 1
+    ;;
     *.tc)
       if [ -f "$1" ]; then
         OPT_TEST_CASES="$OPT_TEST_CASES `abspath $1`"
@@ -152,9 +157,13 @@ parse_opts() { # opts
     ;;
     esac
   done
-  if [ ! -z "$OPT_TEST_CASES" ]; then
+  if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=$OPT_TEST_CASES
   fi
+  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
+    TOP_DIR=$OPT_TEST_DIR
+    TEST_DIR=$TOP_DIR/test.d
+  fi
 }
 
 # Parameters
@@ -190,10 +199,6 @@ fi
 TOP_DIR=`absdir $0`
 TEST_DIR=$TOP_DIR/test.d
 TEST_CASES=`find_testcases $TEST_DIR`
-LOG_TOP_DIR=$TOP_DIR/logs
-LOG_DATE=`date +%Y%m%d-%H%M%S`
-LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
-LINK_PTR=$LOG_TOP_DIR/latest
 KEEP_LOG=0
 KTAP=0
 DEBUG=0
@@ -201,14 +206,23 @@ VERBOSE=0
 UNSUPPORTED_RESULT=0
 UNRESOLVED_RESULT=0
 STOP_FAILURE=0
+RV_TEST=0
 # Parse command-line options
 parse_opts $*
 
+LOG_TOP_DIR=$TOP_DIR/logs
+LOG_DATE=`date +%Y%m%d-%H%M%S`
+LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
+LINK_PTR=$LOG_TOP_DIR/latest
+
 [ $DEBUG -ne 0 ] && set -x
 
-# Verify parameters
-if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
-  errexit "No ftrace directory found"
+if [ $RV_TEST -ne 0 ]; then
+	TRACING_DIR=$TRACING_DIR/rv
+	if [ ! -d "$TRACING_DIR" ]; then
+		err_ret=$err_skip
+		errexit "rv is not configured in this kernel"
+	fi
 fi
 
 # Preparing logs
@@ -419,7 +433,7 @@ trap 'SIG_RESULT=$XFAIL' $SIG_XFAIL
 __run_test() { # testfile
   # setup PID and PPID, $$ is not updated.
   (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x;
-   checkreq $1; initialize_ftrace; . $1)
+   checkreq $1; initialize_system; . $1)
   [ $? -ne 0 ] && kill -s $SIG_FAIL $SIG_PID
 }
 
@@ -496,7 +510,7 @@ for t in $TEST_CASES; do
     exit 1
   fi
 done
-(cd $TRACING_DIR; finish_ftrace) # for cleanup
+(cd $TRACING_DIR; finish_system) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
index 8a7ce647a60d..318939451caf 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -28,7 +28,7 @@ unmount_tracefs() {
 	local mount_point="$1"
 
 	# Need to make sure the mount isn't busy so that we can umount it
-	(cd $mount_point; finish_ftrace;)
+	(cd $mount_point; finish_system;)
 
 	cleanup
 }
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index a1052bf460fc..e8e718139294 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -104,7 +104,7 @@ clear_dynamic_events() { # reset all current dynamic events
     done
 }
 
-initialize_ftrace() { # Reset ftrace to initial-state
+initialize_system() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
 # no probes, and tracing on.
@@ -134,8 +134,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
     enable_tracing
 }
 
-finish_ftrace() {
-    initialize_ftrace
+finish_system() {
+    initialize_system
 # And recover it to default.
     [ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
 }
-- 
2.51.0



