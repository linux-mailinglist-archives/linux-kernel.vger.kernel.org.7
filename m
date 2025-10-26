Return-Path: <linux-kernel+bounces-870346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B327DC0A829
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0632D3B1B19
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BE2E719C;
	Sun, 26 Oct 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bYzu/IjO"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B12DC766;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482557; cv=none; b=kJaRE8GaG5RXc9pLp+anChu/GZG7rj12E9iCVNJv5sDe2KisVD0JfvVbVZC3wqk32z5igSmMur4AewYGFO1dOAuvUVpEpImr/jUbKD4vDBvgWKgV9eOtKa3XuCR4ADHWCYnWKhlTrgT6N0ZKGQEZqiGl44dMxWDEjEe3C/hjpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482557; c=relaxed/simple;
	bh=517i2jj1FP1eA4gNNSFn+t3wDqkwPadIwOLbp+tJV7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKrPyDlmH6pt1aHcmKgBNHggOD6tFn6PHxeEG3CT7/5j9+a4gOvLZ6Ogs69ACVVhC6c9VaF6LhbY3UKycdqXEJODPZwGlpY8N6ItBdP/kXJznXj6ItSDe6HFOSlmWDTgdyYwKsQjLDIJvlsC48fXFokftiOuQdd3qKkPwYNyAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bYzu/IjO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3sCIFxfR/3bAfkz3RVepSUlcaCv5Ie7/jvVe7/s8Bmk=; t=1761482553;
	x=1761914553; b=bYzu/IjO7C+LbBcj1+dDUSDS0+KtbTHc3tmNsN7cWczmZyMTb/0ztGNQbePb/
	T9gdo71iJrUGyJdtOUGoiZeXGXbZnpCFHBQPFAyZ6SDH45rBtaI9iu1ytXWRbhbfwf3KMXQBUczMj
	e7Us1NOivOeUE41Tv3zV8PAnYFBHXrHPfbJjX1c9jeis5sbhX4cS/BDGZJiJj+9n8u4Slqso2R5rp
	3CxPzwa1MkhcvEQe/9LT9xRl91oA/7a7bYyapJFCyf/FCusR/YEJCHdJ2YXmBeG0Tsbqd3dZR12Qg
	M9LcseMthhZJNwrO+2zYaUMGH9ZAUXeEEDmPClYdosLB+Xeavg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04o-001mXn-0J;
	Sun, 26 Oct 2025 13:42:26 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/30] docs: reporting-issues: move 'check tainted flag' upwards
Date: Sun, 26 Oct 2025 13:42:01 +0100
Message-ID: <93cac5463d1e51b57b7cf74181397039137bcdb5.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04o-001mXn-0J

Move text around to improve diffability in the follow-up patch.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 142 +++++++++---------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 63ce6ae51df266..19f1ffabf5ae30 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -85,6 +85,9 @@ following the others is usually in your own interest.
  [:ref:`details <checklog_repiref>`]
 
 
+ * Check if your kernel was 'tainted' when the issue occurred, as the event
+   that made the kernel set this flag might be causing the issue you face.
+
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
    List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
@@ -103,9 +106,6 @@ following the others is usually in your own interest.
    kernel modules on-the-fly, which solutions like DKMS might be doing locally
    without your knowledge.
 
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
-
  * Write down coarsely how to reproduce the issue.
 
  * If you are facing a regression within a stable or longterm version line
@@ -397,6 +397,74 @@ to set warnings and errors apart.
 [:ref:`back to step-by-step guide <checklog_repisbs>`]
 
 
+Check 'taint' flag
+------------------
+
+    *Check if your kernel was 'tainted' when the issue occurred, as the event
+    that made the kernel set this flag might be causing the issue you face.*
+
+The kernel marks itself with a 'taint' flag when something happens that might
+lead to follow-up errors that look totally unrelated. The issue you face might
+be such an error if your kernel is tainted. That's why it's in your interest to
+rule this out early before investing more time into this process. This is the
+only reason why this step is here, as this process later will tell you to
+install the latest mainline kernel; you will need to check the taint flag again
+then, as that's when it matters because it's the kernel the report will focus
+on.
+
+On a running system is easy to check if the kernel tainted itself: if ``cat
+/proc/sys/kernel/tainted`` returns '0' then the kernel is not tainted and
+everything is fine. Checking that file is impossible in some situations; that's
+why the kernel also mentions the taint status when it reports an internal
+problem (a 'kernel bug'), a recoverable error (a 'kernel Oops') or a
+non-recoverable error before halting operation (a 'kernel panic'). Look near
+the top of the error messages printed when one of these occurs and search for a
+line starting with 'CPU:'. It should end with 'Not tainted' if the kernel was
+not tainted when it noticed the problem; it was tainted if you see 'Tainted:'
+followed by a few spaces and some letters.
+
+If your kernel is tainted, study Documentation/admin-guide/tainted-kernels.rst
+to find out why. Try to eliminate the reason. Often it's caused by one these
+three things:
+
+ 1. A recoverable error (a 'kernel Oops') occurred and the kernel tainted
+    itself, as the kernel knows it might misbehave in strange ways after that
+    point. In that case check your kernel or system log and look for a section
+    that starts with this::
+
+       Oops: 0000 [#1] SMP
+
+    That's the first Oops since boot-up, as the '#1' between the brackets shows.
+    Every Oops and any other problem that happens after that point might be a
+    follow-up problem to that first Oops, even if both look totally unrelated.
+    Rule this out by getting rid of the cause for the first Oops and reproducing
+    the issue afterwards. Sometimes simply restarting will be enough, sometimes
+    a change to the configuration followed by a reboot can eliminate the Oops.
+    But don't invest too much time into this at this point of the process, as
+    the cause for the Oops might already be fixed in the newer Linux kernel
+    version you are going to install later in this process.
+
+ 2. Your system uses a software that installs its own kernel modules, for
+    example Nvidia's proprietary graphics driver or VirtualBox. The kernel
+    taints itself when it loads such module from external sources (even if
+    they are Open Source): they sometimes cause errors in unrelated kernel
+    areas and thus might be causing the issue you face. You therefore have to
+    prevent those modules from loading when you want to report an issue to the
+    Linux kernel developers. Most of the time the easiest way to do that is:
+    temporarily uninstall such software including any modules they might have
+    installed. Afterwards reboot.
+
+ 3. The kernel also taints itself when it's loading a module that resides in
+    the staging tree of the Linux kernel source. That's a special area for
+    code (mostly drivers) that does not yet fulfill the normal Linux kernel
+    quality standards. When you report an issue with such a module it's
+    obviously okay if the kernel is tainted; just make sure the module in
+    question is the only reason for the taint. If the issue happens in an
+    unrelated area reboot and temporarily block the module from being loaded
+    by specifying ``foo.blacklist=1`` as kernel parameter (replace 'foo' with
+    the name of the module in question).
+
+
 Search for existing reports, first run
 --------------------------------------
 
@@ -548,74 +616,6 @@ module not part of the Linux kernel. That why your might need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.
 
 
-Check 'taint' flag
-------------------
-
-    *Check if your kernel was 'tainted' when the issue occurred, as the event
-    that made the kernel set this flag might be causing the issue you face.*
-
-The kernel marks itself with a 'taint' flag when something happens that might
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
-
-       Oops: 0000 [#1] SMP
-
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
-
-
 Document how to reproduce issue
 -------------------------------
 
-- 
2.51.0


