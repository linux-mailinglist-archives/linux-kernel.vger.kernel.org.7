Return-Path: <linux-kernel+bounces-870350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342BC0A814
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDB134E8078
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250D2E7F3A;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="x/AwPDbE"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21A2DCF5B;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482557; cv=none; b=bcwmG9V0xSWznEFsJXSiUM9kOOXGIwaXHmhbAGKCTqElnBaTkE4OZJYOA42nWVUg7L467MA16n/dwaiwuyuHwZ3lFtEyRoVDmAMtHgBM4HXlY6k/mfgLaQf2RfuMtyOK1Xp7MHHF67SlivIVrhP2MEMnhl/N+YJlMaTmiqCPUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482557; c=relaxed/simple;
	bh=gOfqGvqqIFHcQUAZGpfPCA8S3+jH7XYY2zmzOE4CeME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ8o4TOjHx294f+BbMXDabJ8eaIgBXy70rwEwclrBf7fJAjc6l4vEvcoQNmVjGHRYjuxqZnxqRZZluoOebYfghY4lyK6k1L+PKXTjYboCIIOngAuIesVwiNr4LUIzNEwGIFZx1yniIO/xpKHyhYGw7L7QExYL8UY4o8xnTYitgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=x/AwPDbE; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=cMBWfq9UPEX71weT6EaVXza2Wgm0L5xENSgTv1nRzqE=; t=1761482554;
	x=1761914554; b=x/AwPDbEKR9BYItc/yaSl9YmhlIz7rgVNpiv3gh/Kffco0mDse3BtEQ/eNzVs
	A82GGcqcfHETB2BOuVhZRjy078A7dE4lfwylMmBHQBkmIJi9rk+NlvOYpymYLIyPSYOsem99AjV2W
	y0zNwblCm7Gc7uyDpAKxx6iV362nnRgDrzfcGiQEhQEM76r42bdD+oleurB1a1zAsjPO8IsRPF74P
	g3RYdnopL7Hr326pDY/cA2D39mf5OhojlZmT7cQI4/7xd1TgKzwU1C+YgEpWqWQGpm3QLLwgcY+fH
	yicdubTuoYR3qBgfBknIvt4In0x3MjBzfVPV4vnV2gZTPY5XwA==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04o-001mXn-2f;
	Sun, 26 Oct 2025 13:42:26 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/30] docs: reporting-issues: move 'check environment' upwards
Date: Sun, 26 Oct 2025 13:42:03 +0100
Message-ID: <2fc7c4a2c721826bc01d6616fe54ed6136362a31.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482554;2f8dc1da;
X-HE-SMSGID: 1vD04o-001mXn-2f

Move text around to improve diffability of an follow-up patch.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 452733669debf5..861237aaf94126 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -93,6 +93,9 @@ following the others is usually in your own interest.
  [:ref:`details <taintone_repiref>`]
 
 
+ * Make sure it's not the kernel's surroundings that are causing the issue
+   you face.
+
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
    List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
@@ -102,9 +105,6 @@ following the others is usually in your own interest.
    issue, or a really severe problem: those are 'issues of high priority' that
    need special handling in some steps that are about to follow.
 
- * Make sure it's not the kernel's surroundings that are causing the issue
-   you face.
-
  * Create a fresh backup and put system repair and restore tools at hand.
 
  * Ensure your system does not enhance its kernels by building additional
@@ -481,6 +481,41 @@ These are the most frequent reasons why the kernel set the flag:
 [:ref:`back to step-by-step guide <taintone_repisbs>`]
 
 
+Ensure a healthy environment
+----------------------------
+
+    *Make sure it's not the kernel's surroundings that are causing the issue
+    you face.*
+
+Problems that look a lot like a kernel issue are sometimes caused by build or
+runtime environment. It's hard to rule out that problem completely, but you
+should minimize it:
+
+ * Use proven tools when building your kernel, as bugs in the compiler or the
+   binutils can cause the resulting kernel to misbehave.
+
+ * Ensure your computer components run within their design specifications;
+   that's especially important for the main processor, the main memory, and the
+   motherboard. Therefore, stop undervolting or overclocking when facing a
+   potential kernel issue.
+
+ * Try to make sure it's not faulty hardware that is causing your issue. Bad
+   main memory for example can result in a multitude of issues that will
+   manifest itself in problems looking like kernel issues.
+
+ * If you're dealing with a filesystem issue, you might want to check the file
+   system in question with ``fsck``, as it might be damaged in a way that leads
+   to unexpected kernel behavior.
+
+ * When dealing with a regression, make sure it's not something else that
+   changed in parallel to updating the kernel. The problem for example might be
+   caused by other software that was updated at the same time. It can also
+   happen that a hardware component coincidentally just broke when you rebooted
+   into a new kernel for the first time. Updating the systems BIOS or changing
+   something in the BIOS Setup can also lead to problems that on look a lot
+   like a kernel regression.
+
+
 Search for existing reports, first run
 --------------------------------------
 
@@ -563,41 +598,6 @@ fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
 as the kernel remains running after the latter.
 
 
-Ensure a healthy environment
-----------------------------
-
-    *Make sure it's not the kernel's surroundings that are causing the issue
-    you face.*
-
-Problems that look a lot like a kernel issue are sometimes caused by build or
-runtime environment. It's hard to rule out that problem completely, but you
-should minimize it:
-
- * Use proven tools when building your kernel, as bugs in the compiler or the
-   binutils can cause the resulting kernel to misbehave.
-
- * Ensure your computer components run within their design specifications;
-   that's especially important for the main processor, the main memory, and the
-   motherboard. Therefore, stop undervolting or overclocking when facing a
-   potential kernel issue.
-
- * Try to make sure it's not faulty hardware that is causing your issue. Bad
-   main memory for example can result in a multitude of issues that will
-   manifest itself in problems looking like kernel issues.
-
- * If you're dealing with a filesystem issue, you might want to check the file
-   system in question with ``fsck``, as it might be damaged in a way that leads
-   to unexpected kernel behavior.
-
- * When dealing with a regression, make sure it's not something else that
-   changed in parallel to updating the kernel. The problem for example might be
-   caused by other software that was updated at the same time. It can also
-   happen that a hardware component coincidentally just broke when you rebooted
-   into a new kernel for the first time. Updating the systems BIOS or changing
-   something in the BIOS Setup can also lead to problems that on look a lot
-   like a kernel regression.
-
-
 Prepare for emergencies
 -----------------------
 
-- 
2.51.0


