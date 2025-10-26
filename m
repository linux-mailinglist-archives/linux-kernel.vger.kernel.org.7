Return-Path: <linux-kernel+bounces-870343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08800C0A811
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BADE04E7A52
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5B2E6CC6;
	Sun, 26 Oct 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WcBO4AJO"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E42DC76B;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482555; cv=none; b=dMh9Js+YcpFzoO1LlOcaroSHC4HB4R2h3KkI6HtfauDmJtjKgNsnsHhPPxJ7LDRcxgwv82jrp34iZFT3RB2rB9PhqJ4ZvlCuKuy1U7zXzOTzL+x/ngTTp+xm9bXaeKg9s1AwfyGsNONAFbKrIWUosuCL+T1KIo4D6R2jh0kyq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482555; c=relaxed/simple;
	bh=9RlaPYJbqiM2OFxkSIEpzf6QXLP5GS9MehP4KTaVRHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdcvjDV+Fgd4sZHIdU1+YhyTLe7+MibZPQnmRYqOdWI/IW2uaXQvw5UDQvdSLKw0nvTKZVSayE1TDXYBQlbZahGv9iZhumKt2NCTQW9/XKFR7Xet93hFzYOaBf/pwdY8Biv8zBJ4MEPiTzRBfX1NN+aixNxKqA2PaKAPFRqZKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WcBO4AJO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OVOHoODjbTBKiS2pRJUZZiaxPXulh2JYJvHA1xkr8fg=; t=1761482553;
	x=1761914553; b=WcBO4AJOs80Vd0tFMCNg6QkVZIG5ez0L+koWej9CyeeBguc94J7PNxG+er6oS
	DummpkRzWoIPuSm8oTX28GWdJPU4eouXAzy2SvP18Spz4Z1Q1vJJqLtGd1cOJ5MW4Eaqg2bc6uJNv
	HgaXxksUOsy6EtpULz4vlVcPwKNinRJeITlCv2FK4mu2MOIBzCJAc1waC3ME1yOpCl7fKajurEeAP
	QgUmN/LpBJx/2BzZ0i63MlgFrgXRA7Zxfw1smPMKcI9lNpJTF0Xfr2NI4qR0Rn2txyPqmUNtpP0e4
	jIaRH29PXXUuaMj+kTOlh/6V7hULYLu29WGEu0jkNyLxiLS9qw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04o-001mXn-1a;
	Sun, 26 Oct 2025 13:42:26 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/30] docs: reporting-issues: improve first tainted check
Date: Sun, 26 Oct 2025 13:42:02 +0100
Message-ID: <aad21ed1bc8d8d54653c3ff03c2b69220e4801da.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482553;4a80bc7e;
X-HE-SMSGID: 1vD04o-001mXn-1a

Fine-tune the instruction regarding the first tainted check.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 136 ++++++++++--------
 1 file changed, 76 insertions(+), 60 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 19f1ffabf5ae30..452733669debf5 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -84,9 +84,14 @@ following the others is usually in your own interest.
 
  [:ref:`details <checklog_repiref>`]
 
+.. _taintone_repisbs:
+
+* Check if the kernel was already 'tainted' when the issue first occurred: The
+  event that resulted in this flag being set might have led to issues that
+  otherwise would never happen.
+
+ [:ref:`details <taintone_repiref>`]
 
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
 
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
@@ -397,72 +402,83 @@ to set warnings and errors apart.
 [:ref:`back to step-by-step guide <checklog_repisbs>`]
 
 
+.. _taintone_repiref:
+
 Check 'taint' flag
 ------------------
 
-    *Check if your kernel was 'tainted' when the issue occurred, as the event
-    that made the kernel set this flag might be causing the issue you face.*
+  *Check if the kernel was already 'tainted' when the issue first occurred* [:ref:`... <taintone_repisbs>`]
 
 The kernel marks itself with a 'taint' flag when something happens that might
-lead to follow-up errors that look totally unrelated. The issue you face might
-be such an error if your kernel is tainted. That's why it's in your interest to
-rule this out early before investing more time into this process. This is the
-only reason why this step is here, as this process later will tell you to
-install the latest mainline kernel; you will need to check the taint flag again
-then, as that's when it matters because it's the kernel the report will focus
-on.
-
-On a running system is easy to check if the kernel tainted itself: if ``cat
-/proc/sys/kernel/tainted`` returns '0' then the kernel is not tainted and
-everything is fine. Checking that file is impossible in some situations; that's
-why the kernel also mentions the taint status when it reports an internal
-problem (a 'kernel bug'), a recoverable error (a 'kernel Oops') or a
-non-recoverable error before halting operation (a 'kernel panic'). Look near
-the top of the error messages printed when one of these occurs and search for a
-line starting with 'CPU:'. It should end with 'Not tainted' if the kernel was
-not tainted when it noticed the problem; it was tainted if you see 'Tainted:'
-followed by a few spaces and some letters.
-
-If your kernel is tainted, study Documentation/admin-guide/tainted-kernels.rst
-to find out why. Try to eliminate the reason. Often it's caused by one these
-three things:
-
- 1. A recoverable error (a 'kernel Oops') occurred and the kernel tainted
-    itself, as the kernel knows it might misbehave in strange ways after that
-    point. In that case check your kernel or system log and look for a section
-    that starts with this::
+lead to follow-up errors looking totally unrelated. Your issue might
+be such an error, in which case there is nothing to report. That is why it is
+in your interest to check the taint status early in the reporting process. This
+is the main reason why this step is here in the guide, as you most likely will
+have to install a different kernel for reporting later -- and then need to
+recheck the flag, as that is when it matters.
+
+To check the tainted flag, execute ``cat /proc/sys/kernel/tainted``: If it
+returns '0' everything is fine; if it contains a higher number, it is tainted.
+
+In some situations it is impossible to check that file. That is
+why the kernel also mentions the taint status when it reports small (a
+'warning' or a 'bug') or big (an 'Oops' or a 'panic') problems. In such cases,
+search for a line starting with 'CPU:' near the top of the error messages
+printed on the screen or in the log. If the kernel at that point considered
+itself to be fine, it will end with 'Not tainted'; if not, you will see
+'Tainted:' followed by a few spaces and some letters.
+
+If your kernel is tainted, check Documentation/admin-guide/tainted-kernels.rst
+to find out why. Note: It is quite possible that the problem you ran into
+caused the kernel to taint itself, in which case you are free to ignore the
+flag. But if the kernel was tainted beforehand, you might have to eliminate the
+cause or rule out that it is an influence.
+
+These are the most frequent reasons why the kernel set the flag:
+
+1. Some kind of error (like a 'kernel Oops') occurred. The kernel then taints
+   itself, as it might misbehave in unexpected ways afterwards.
+   In that case check your kernel or system log and look for a section
+   starting with::
 
        Oops: 0000 [#1] SMP
 
-    That's the first Oops since boot-up, as the '#1' between the brackets shows.
-    Every Oops and any other problem that happens after that point might be a
-    follow-up problem to that first Oops, even if both look totally unrelated.
-    Rule this out by getting rid of the cause for the first Oops and reproducing
-    the issue afterwards. Sometimes simply restarting will be enough, sometimes
-    a change to the configuration followed by a reboot can eliminate the Oops.
-    But don't invest too much time into this at this point of the process, as
-    the cause for the Oops might already be fixed in the newer Linux kernel
-    version you are going to install later in this process.
-
- 2. Your system uses a software that installs its own kernel modules, for
-    example Nvidia's proprietary graphics driver or VirtualBox. The kernel
-    taints itself when it loads such module from external sources (even if
-    they are Open Source): they sometimes cause errors in unrelated kernel
-    areas and thus might be causing the issue you face. You therefore have to
-    prevent those modules from loading when you want to report an issue to the
-    Linux kernel developers. Most of the time the easiest way to do that is:
-    temporarily uninstall such software including any modules they might have
-    installed. Afterwards reboot.
-
- 3. The kernel also taints itself when it's loading a module that resides in
-    the staging tree of the Linux kernel source. That's a special area for
-    code (mostly drivers) that does not yet fulfill the normal Linux kernel
-    quality standards. When you report an issue with such a module it's
-    obviously okay if the kernel is tainted; just make sure the module in
-    question is the only reason for the taint. If the issue happens in an
-    unrelated area reboot and temporarily block the module from being loaded
-    by specifying ``foo.blacklist=1`` as kernel parameter (replace 'foo' with
-    the name of the module in question).
+   That is the first Oops since boot-up, as the '#1' between the brackets shows.
+   Every later Oops and any other problem that happens afterwards might be
+   a follow-up issue
+   that would never have happened otherwise, even if both look totally unrelated.
+   Rule this out by eliminating the cause for the first Oops and reproducing
+   the issue afterwards. Sometimes simply restarting will be enough; other times
+   a change to the configuration followed by a reboot can eliminate the Oops.
+
+   Note: Do not invest too much time into this while you are still on an
+   outdated or vendor kernel: The cause for the Oops might already be fixed in
+   a newer Linux kernel
+   version you most likely will have to install for reporting while following
+   this guide.
+
+2. Your system uses software that installs externally developed kernel modules,
+   for example, kernel modules from Nvidia, OpenZFS, VirtualBox, or VMware. The
+   kernel taints itself when it loads such 'out-of-tree' modules -- no matter
+   what license they use, as such modules can cause errors in unrelated kernel
+   areas and thus might be leading to the issue you face. You therefore have to
+   prevent those modules from loading when you want to report an issue to the
+   Linux kernel developers. Most of the time the easiest way to do that:
+   temporarily uninstall such software including any modules they might have
+   installed; afterwards reboot.
+
+3. The kernel taints itself when it loads a module that resides in
+   the staging section of the Linux kernel source. That is a special area for
+   code (mostly drivers) that does not yet fulfill the normal Linux kernel
+   quality standards. When you report an issue with such a module, it is
+   totally okay if the kernel is tainted; just make sure the module in
+   question is the only reason for the taint. If the issue happens in an
+   unrelated area, it is wise to rule out that it is an influence. To do so,
+   reboot and temporarily block the module from being loaded by specifying
+   ``foo.blacklist=1`` as kernel boot parameter (replace 'foo' with the name of
+   the module in question).
+
+[:ref:`back to step-by-step guide <taintone_repisbs>`]
 
 
 Search for existing reports, first run
-- 
2.51.0


