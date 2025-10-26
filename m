Return-Path: <linux-kernel+bounces-870330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C0C0A7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 820DC4E75A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B42DCF46;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="djlp42xb"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B182C0289;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482552; cv=none; b=XI/yjRO5yJoTq5fmaPpBhIt92MwH6sl0gvTsgUoQ2glaa/gtdczhAcQ7iR03lX4MwbxbYMQrz3SMmBfxM0I6sbekIP0KCJ6rlXBh3XJErJjkeK45p/kSxD7sZdYpae39G5m9+Dp1bpITaP260lAgZvklZafgfBhLDuwu9k/1peQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482552; c=relaxed/simple;
	bh=pigXJFEk84kaIiULbwp7KdKvqomNcO+IDSl4650sWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4lqi8GSHGuCglzQ4s6ylJsBwwb6ykQpelA28yOze475B6A/YbxyApxY+bjdQAMWkorMxKQ2uxP+Mu35s1y0qpCb3EuVRqTCQ7jj0sV3e8E3T+LIbEEmHeZWwu3CWYf4gub7vWTGmH5Y1l+dnJMqm5n+Rm+7wruP43+ICCtXcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=djlp42xb; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=2YS+YgaQrR4MfKIsndWYMCSVGSnj2HS6wx9rm7xWb7Q=; t=1761482550;
	x=1761914550; b=djlp42xbwhGjtrFG6Jfe3jkrZLd1wb1pCa6ZpwJVjWDqzdl2fthKONBDR1nI1
	BKs+UBsylD9nu9Feya+WmNogVciBmbNd44bZND1vgBiw+u9cO9bDMBAxYyq7Tzcy4EbMKOO1j0fpU
	wQqTiSm+GwQ2hAyy8Cd7h37IO1JKwOOoyfGuL8vECo2EjHGogDAk41hGlK8OcxsVWADFz3P5HQ8Z9
	xtoeEMAHsp+8qy+aJ5YoWWDM13FK3u90OuHFH8B7pryfCyEMERgBSegDc4TB+wiD5xxSMGjgpkb9J
	xVg9yDYYKGFs9N/uDdMBMxB/f2wiGMSod38I2Hdt6KzQ5AIGEA==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04q-001mYF-2G;
	Sun, 26 Oct 2025 13:42:28 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 17/30] docs: reporting-issues: move text on 'check MAINTAINERS file' upwards
Date: Sun, 26 Oct 2025 13:42:08 +0100
Message-ID: <e5e8f1c554e922cbcd34a98811a8e900c72cf434.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482550;db804c08;
X-HE-SMSGID: 1vD04q-001mYF-2G

Move text around to improve diffability of a follow-up patch.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 162 +++++++++---------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index f040ca7c0a2f59..e9d304040e3b54 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -149,6 +149,11 @@ following the others is usually in your own interest.
 
  [:ref:`details <reginquiry_repiref>`]
 
+ * Locate the driver or kernel subsystem that seems to be causing the issue.
+   Find out how and where its developers expect reports. Note: most of the
+   time this won't be bugzilla.kernel.org, as issues typically need to be sent
+   by mail to a maintainer and a public mailing list.
+
  * Create a fresh backup and put system repair and restore tools at hand.
 
  * Ensure your system does not enhance its kernels by building additional
@@ -161,11 +166,6 @@ following the others is usually in your own interest.
    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
    'Dealing with regressions within a stable and longterm kernel line'.
 
- * Locate the driver or kernel subsystem that seems to be causing the issue.
-   Find out how and where its developers expect reports. Note: most of the
-   time this won't be bugzilla.kernel.org, as issues typically need to be sent
-   by mail to a maintainer and a public mailing list.
-
  * Search the archives of the bug tracker or mailing list in question
    thoroughly for reports that might match your issue. If you find anything,
    join the discussion instead of sending a new report.
@@ -705,73 +705,6 @@ answer these emails on a best-effort basis.
 [:ref:`back to step-by-step guide <reginquiry_repisbs>`]
 
 
-Prepare for emergencies
------------------------
-
-    *Create a fresh backup and put system repair and restore tools at hand.*
-
-Reminder, you are dealing with computers, which sometimes do unexpected things,
-especially if you fiddle with crucial parts like the kernel of its operating
-system. That's what you are about to do in this process. Thus, make sure to
-create a fresh backup; also ensure you have all tools at hand to repair or
-reinstall the operating system as well as everything you need to restore the
-backup.
-
-
-Make sure your kernel doesn't get enhanced
-------------------------------------------
-
-    *Ensure your system does not enhance its kernels by building additional
-    kernel modules on-the-fly, which solutions like DKMS might be doing locally
-    without your knowledge.*
-
-The risk your issue report gets ignored or rejected dramatically increases if
-your kernel gets enhanced in any way. That's why you should remove or disable
-mechanisms like akmods and DKMS: those build add-on kernel modules
-automatically, for example when you install a new Linux kernel or boot it for
-the first time. Also remove any modules they might have installed. Then reboot
-before proceeding.
-
-Note, you might not be aware that your system is using one of these solutions:
-they often get set up silently when you install Nvidia's proprietary graphics
-driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
-packages with such software to get rid of any 3rd party kernel module.
-
-
-Document how to reproduce issue
--------------------------------
-
-    *Write down coarsely how to reproduce the issue.*
-
-During the reporting process you will have to test if the issue
-happens with other kernel versions. Therefore, it will make your work easier if
-you know exactly how to reproduce an issue quickly on a freshly booted system.
-
-Note: it's often fruitless to report issues that only happened once, as they
-might be caused by a bit flip due to cosmic radiation. That's why you should
-try to rule that out by reproducing the issue before going further. Feel free
-to ignore this advice if you are experienced enough to tell a one-time error
-due to faulty hardware apart from a kernel issue that rarely happens and thus
-is hard to reproduce.
-
-
-Regression in stable or longterm kernel?
-----------------------------------------
-
-    *If you are facing a regression within a stable or longterm version line
-    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
-    'Dealing with regressions within a stable and longterm kernel line'.*
-
-Regression within a stable and longterm kernel version line are something the
-Linux developers want to fix badly, as such issues are even more unwanted than
-regression in the main development branch, as they can quickly affect a lot of
-people. The developers thus want to learn about such issues as quickly as
-possible, hence there is a streamlined process to report them. Note,
-regressions with newer kernel version line (say something broke when switching
-from 5.9.15 to 5.10.5) do not qualify.
-
-
 Check where you need to report your issue
 -----------------------------------------
 
@@ -886,18 +819,18 @@ to find all people to contact. It queries the MAINTAINERS file and needs to be
 called with a path to the source code in question. For drivers compiled as
 module if often can be found with a command like this::
 
-       $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
-       drivers/net/wireless/ath/ath10k/ath10k_pci.ko
+   $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
+   drivers/net/wireless/ath/ath10k/ath10k_pci.ko
 
 Pass parts of this to the script::
 
-       $ ./scripts/get_maintainer.pl -f drivers/net/wireless/ath/ath10k*
-       Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
-       Another S. Human <asomehuman@example.com> (maintainer:NETWORKING DRIVERS)
-       ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
-       linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
-       netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
-       linux-kernel@vger.kernel.org (open list)
+   $ ./scripts/get_maintainer.pl --no-git -f drivers/net/wireless/ath/ath10k*
+   Some Human <shuman@example.com> (supporter:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+   Another S. Human <asomehuman@example.com> (maintainer:NETWORKING DRIVERS)
+   ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
+   linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
+   netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
+   linux-kernel@vger.kernel.org (open list)
 
 Don't sent your report to all of them. Send it to the maintainers, which the
 script calls "supporter:"; additionally CC the most specific mailing list for
@@ -915,6 +848,73 @@ modified during tree-wide cleanups by developers that do not care about the
 particular driver at all.
 
 
+Prepare for emergencies
+-----------------------
+
+    *Create a fresh backup and put system repair and restore tools at hand.*
+
+Reminder, you are dealing with computers, which sometimes do unexpected things,
+especially if you fiddle with crucial parts like the kernel of its operating
+system. That's what you are about to do in this process. Thus, make sure to
+create a fresh backup; also ensure you have all tools at hand to repair or
+reinstall the operating system as well as everything you need to restore the
+backup.
+
+
+Make sure your kernel doesn't get enhanced
+------------------------------------------
+
+    *Ensure your system does not enhance its kernels by building additional
+    kernel modules on-the-fly, which solutions like DKMS might be doing locally
+    without your knowledge.*
+
+The risk your issue report gets ignored or rejected dramatically increases if
+your kernel gets enhanced in any way. That's why you should remove or disable
+mechanisms like akmods and DKMS: those build add-on kernel modules
+automatically, for example when you install a new Linux kernel or boot it for
+the first time. Also remove any modules they might have installed. Then reboot
+before proceeding.
+
+Note, you might not be aware that your system is using one of these solutions:
+they often get set up silently when you install Nvidia's proprietary graphics
+driver, VirtualBox, or other software that requires a some support from a
+module not part of the Linux kernel. That why your might need to uninstall the
+packages with such software to get rid of any 3rd party kernel module.
+
+
+Document how to reproduce issue
+-------------------------------
+
+    *Write down coarsely how to reproduce the issue.*
+
+During the reporting process you will have to test if the issue
+happens with other kernel versions. Therefore, it will make your work easier if
+you know exactly how to reproduce an issue quickly on a freshly booted system.
+
+Note: it's often fruitless to report issues that only happened once, as they
+might be caused by a bit flip due to cosmic radiation. That's why you should
+try to rule that out by reproducing the issue before going further. Feel free
+to ignore this advice if you are experienced enough to tell a one-time error
+due to faulty hardware apart from a kernel issue that rarely happens and thus
+is hard to reproduce.
+
+
+Regression in stable or longterm kernel?
+----------------------------------------
+
+    *If you are facing a regression within a stable or longterm version line
+    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
+    'Dealing with regressions within a stable and longterm kernel line'.*
+
+Regression within a stable and longterm kernel version line are something the
+Linux developers want to fix badly, as such issues are even more unwanted than
+regression in the main development branch, as they can quickly affect a lot of
+people. The developers thus want to learn about such issues as quickly as
+possible, hence there is a streamlined process to report them. Note,
+regressions with newer kernel version line (say something broke when switching
+from 5.9.15 to 5.10.5) do not qualify.
+
+
 Search for existing reports, second run
 ---------------------------------------
 
-- 
2.51.0


