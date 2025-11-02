Return-Path: <linux-kernel+bounces-882375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA9C2A4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990E94F00CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D32C2366;
	Mon,  3 Nov 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX8X5Y+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C92BDC17;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=f5ZKVDjW2VW6QiZt7dG5MW8oEGpTOs2/DUbtDEo7I+A3Fp0cHEFaM4ER3MCTRs71C2FjqPlsi68XJlDl1dkansHx2XSv6hz1lKWc/hSppscRSHm0eSDd3e9pEnVPRbQKj4s6HcAEqARSPfAh26Y8d1aumhJXZehCVVgFJIz3m50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=bdRaLOeGRlaNeOitkkHmPDSe++KDC1F2xKdPiknDIIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9ccBynwmh87m2Wt/Xf+0yZtRQa4djKM7kfwLTL7a+RiEwWkIE4sFW5fMMhQWBFr9rcAZcCymb2EyfmDIxBAO4ohG8cW3U/22pu+n4C1FWYhTO9HvJlrQKsSXgqSY9uRzgvN+3cDvTEaA/MLEnoqjbha6WM6oMoYafv5o1JGVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX8X5Y+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC67C2BCB1;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=bdRaLOeGRlaNeOitkkHmPDSe++KDC1F2xKdPiknDIIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QX8X5Y+XjNONvZGxUZ5cFd2dqftYoo6Wlat18tIy4VSfj7WAzbQlblGnv/skppqeO
	 Ei3T/ngRzPKfS8dxff46Kcc2YMFQ1snHmg7FIA/1pWLfVl6bey+nC5zUPxpB7ULAQo
	 /4FHXMePvLVZv0SkMcgx/BEpwhSzqTUJvy9wWR6Amv4wOmQUeRxOflgl+ioMBXU8uC
	 21KoqL/NZHtF5xPPIkwqggUVEaWg2y3PDzLtmfBlMXFk1G0O4i1kWaa65TZXhpADiR
	 bEghWBgc6RiiT9+XLo58dq2288I06xWjTsbzYTWSAX50ynqOibIvox3cDY5Nn77SFj
	 +tgfrOWfTNTpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96CDECE15C3; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 12/19] rcutorture: Permit kvm-again.sh to re-use the build directory
Date: Sun,  2 Nov 2025 13:44:29 -0800
Message-Id: <20251102214436.3905633-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds "inplace" and "inplace-force" values to the kvm-again.sh
"--link" argument, which causes the run's output to be placed into the
build directory.  This could be used to save build time if the machine
went down partway into a run, but it can also be used to do a large
number of builds, and run the resulting kernels concurrently even if the
builds are based on different commits.  A later commit will add this
latter capability to kvm-series.sh in order to produce large speedups
for branch-checking operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     | 56 +++++++++++++------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 88ca4e368489..b5239b52cb5d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -31,7 +31,7 @@ fi
 if ! cp "$oldrun/scenarios" $T/scenarios.oldrun
 then
 	# Later on, can reconstitute this from console.log files.
-	echo Prior run batches file does not exist: $oldrun/batches
+	echo Prior run scenarios file does not exist: $oldrun/scenarios
 	exit 1
 fi
 
@@ -68,7 +68,7 @@ usage () {
 	echo "       --datestamp string"
 	echo "       --dryrun"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
-	echo "       --link hard|soft|copy"
+	echo "       --link hard|soft|copy|inplace|inplace-force"
 	echo "       --remote"
 	echo "       --rundir /new/res/path"
 	echo "Command line: $scriptname $args"
@@ -121,7 +121,7 @@ do
 		shift
 		;;
 	--link)
-		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
+		checkarg --link "hard|soft|copy|inplace|inplace-force" "$#" "$2" 'hard\|soft\|copy\|inplace\|inplace-force' '^--'
 		case "$2" in
 		copy)
 			arg_link="cp -R"
@@ -132,6 +132,14 @@ do
 		soft)
 			arg_link="cp -Rs"
 			;;
+		inplace)
+			arg_link="inplace"
+			rundir="$oldrun"
+			;;
+		inplace-force)
+			arg_link="inplace-force"
+			rundir="$oldrun"
+			;;
 		esac
 		shift
 		;;
@@ -172,21 +180,37 @@ fi
 
 echo ---- Re-run results directory: $rundir
 
-# Copy old run directory tree over and adjust.
-mkdir -p "`dirname "$rundir"`"
-if ! $arg_link "$oldrun" "$rundir"
-then
-	echo "Cannot copy from $oldrun to $rundir."
-	usage
-fi
-rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
-touch "$rundir/log"
-echo $scriptname $args | tee -a "$rundir/log"
-echo $oldrun > "$rundir/re-run"
-if ! test -d "$rundir/../../bin"
+if test "$oldrun" != "$rundir"
 then
-	$arg_link "$oldrun/../../bin" "$rundir/../.."
+	# Copy old run directory tree over and adjust.
+	mkdir -p "`dirname "$rundir"`"
+	if ! $arg_link "$oldrun" "$rundir"
+	then
+		echo "Cannot copy from $oldrun to $rundir."
+		usage
+	fi
+	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+	touch "$rundir/log"
+	echo $scriptname $args | tee -a "$rundir/log"
+	echo $oldrun > "$rundir/re-run"
+	if ! test -d "$rundir/../../bin"
+	then
+		$arg_link "$oldrun/../../bin" "$rundir/../.."
+	fi
+else
+	# Check for a run having already happened.
+	find "$rundir" -name console.log -print > $T/oldrun-console.log
+	if test -s $T/oldrun-console.log
+	then
+		echo Run already took place in $rundir
+		if test "$arg_link" = inplace
+		then
+			usage
+		fi
+	fi
 fi
+
+# Find runs to be done based on their qemu-cmd files.
 for i in $rundir/*/qemu-cmd
 do
 	cp "$i" $T
-- 
2.40.1


