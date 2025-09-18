Return-Path: <linux-kernel+bounces-823589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E00B86EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD623B226C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B622F2607;
	Thu, 18 Sep 2025 20:35:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997A2D63FF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227758; cv=none; b=HZNAEO+xQjWqEP0zLWtUDUn+ATNfFh88zrTO2dIvubExZBTcSvePyzZTXyTWje+tvN1u3Y0YWkp6dsE0YmpYOx5gISO1LG6NVmPoHjDmI/K//dYRPN0uzC8Q+K0kRGwfMIeRqf+Bw1lUNKV/qB6uiKYFdDPZaZ2+Ap0Zuw5bvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227758; c=relaxed/simple;
	bh=6+gwOstLAb+z3XgkGf5uMWSysG2PM5RQMJisVfTXFWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FRtAMZbjhmZiJI3CjvhiTBxxS4pg/L07Ko7oOV4RJQvm7pbOv21lG/Se8T1IAwgGVQrqubvx2ZQScZqW6E+Cri0dFq6cn48MkbGnKl1yKomV1QHX4L5oPAnNvDIl/uLdLZl9VMi4gEdmaBltzveEDIKlpPaZW8gQUcqcUsTxjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 7E42386CA9;
	Thu, 18 Sep 2025 20:35:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9FFCC20025;
	Thu, 18 Sep 2025 20:35:52 +0000 (UTC)
Date: Thu, 18 Sep 2025 16:35:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Nam Cao
 <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Zhen Ni
 <zhen.ni@easystack.cn>
Subject: [GIT PULL] rv: Fixes for v6.17
Message-ID: <20250918163551.3e4254ef@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9FFCC20025
X-Stat-Signature: apddioo4hy84g6s8ohary56eyordu65m
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OYEb2vFQC7wvvIBqTS3jJDiHrc4Mf/Zw=
X-HE-Tag: 1758227752-58823
X-HE-Meta: U2FsdGVkX1/sZks2+1UiW7e4+rzbBgBmUG3hOsy5NciFScq7lg8LyaKxqDwHyGTZCIreFaibDlgfQjtFN7GR6G5C3jO5WO9z0A/PsdrzDPQBJicwNTEyZYjgwE9tZTLOrCmP7NG8rU/z1X5Vexxd0w1FC/8hePiqOBNI2bYkjcUlStcAavtZg9XhS2CnAVKnnlAIDy085W+Y2DtvCArqp0ZkfaknwcUy1KbfTpykMAqcaxNpP0WihSGMqJoqsj153hYezHfo3uzM62x2fJxMuFp5KROOGTxSR7nhGHmzhYY8HgIV6KtiD7Rf6KxBjloqonWTSoQipZLTJgGW8uguX9oUAgfugv5CveNdU5BH82SgDO+eJzCAfBxQeWDvFDEAQA2JXhP05m9PNBwzeP/l4gR5UWjoJ+09UDTAM3ixiXg=


Linus,

Runtime Verifier fixes for v6.17

- Fix build in some RISC-V flavours

  Some system calls only are available for the 64bit RISC-V machines.
  #ifdef out the cases of clock_nanosleep and futex in the sleep monitor
  if they are not supported by the architecture.

- Fix wrong cast, obsolete after refactoring

  Use container_of() to get to the rv_monitor structure from the
  enable_monitors_next() 'p' pointer. The assignment worked only because
  the list field used happened to be the first field of the structure.

- Remove redundant include files

  Some include files were listed twice. Remove the extra ones and sort
  the includes.

- Fix missing unlock on failure

  There was an error path that exited the rv_register_monitor() function
  without releasing a lock. Change that to goto the lock release.

- Add Gabriele Monaco to be Runtime Verifier maintainer

  Gabriele is doing most of the work on RV as well as collecting patches.
  Add him to the maintainers file for Runtime Verification.


Please pull the latest trace-rv-v6.17-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-rv-v6.17-rc5

Tag SHA1: ecf198bd883bc43654e237c91bb2964f4b89dab6
Head SHA1: ef442fc5c1a9a2a232de85a0e6967f388b6c0c8e


Akhilesh Patil (1):
      include/linux/rv.h: remove redundant include file

Nam Cao (1):
      rv: Fix wrong type cast in enabled_monitors_next()

Palmer Dabbelt (1):
      rv: Support systems with time64-only syscalls

Steven Rostedt (1):
      rv: Add Gabriele Monaco as maintainer for Runtime Verification

Zhen Ni (1):
      rv: Fix missing mutex unlock in rv_register_monitor()

----
 MAINTAINERS                            | 1 +
 include/linux/rv.h                     | 6 ++----
 kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
 kernel/trace/rv/rv.c                   | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)
---------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..17073c075bf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22048,6 +22048,7 @@ F:	drivers/infiniband/ulp/rtrs/
 
 RUNTIME VERIFICATION (RV)
 M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Gabriele Monaco <gmonaco@redhat.com>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/trace/rv/
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..9520aab34bcb 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,16 +7,14 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#include <linux/types.h>
-#include <linux/list.h>
-
 #define MAX_DA_NAME_LEN			32
 #define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
+#include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/list.h>
 #include <linux/types.h>
-#include <linux/array_size.h>
 
 /*
  * Deterministic automaton per-object variables.
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index eea447b06907..c1347da69e9d 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -127,7 +127,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	mon = ltl_get_monitor(current);
 
 	switch (id) {
+#ifdef __NR_clock_nanosleep
 	case __NR_clock_nanosleep:
+#endif
 #ifdef __NR_clock_nanosleep_time64
 	case __NR_clock_nanosleep_time64:
 #endif
@@ -138,7 +140,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
 		break;
 
+#ifdef __NR_futex
 	case __NR_futex:
+#endif
 #ifdef __NR_futex_time64
 	case __NR_futex_time64:
 #endif
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 1482e91c39f4..48338520376f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -495,7 +495,7 @@ static void *available_monitors_next(struct seq_file *m, void *p, loff_t *pos)
  */
 static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	struct rv_monitor *mon = p;
+	struct rv_monitor *mon = container_of(p, struct rv_monitor, list);
 
 	(*pos)++;
 
@@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 
 	retval = create_monitor_dir(monitor, parent);
 	if (retval)
-		return retval;
+		goto out_unlock;
 
 	/* keep children close to the parent for easier visualisation */
 	if (parent)
	

