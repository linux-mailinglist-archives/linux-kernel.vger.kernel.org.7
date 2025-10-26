Return-Path: <linux-kernel+bounces-870339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6579C0A7F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D1C18A11B3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30AE2DAFBF;
	Sun, 26 Oct 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="eSdU1W95"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13D2DA775;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482554; cv=none; b=D0iMPGT4KM4Rd10mSJCBy/4n7we6ABT8pnPFU5KYoWdq0gTWwfhwmmPOa2arCTmLKT3eVb3wkR9MdO/X/uyWuWFjvEJSvRFk56VYaez54btuvu3Pn8LwzHeZzNPEVsKyTEhds705Y+TYdANZzp3vESomfZXGa7tvhULrR3M+ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482554; c=relaxed/simple;
	bh=aF4gOaHOL8y1v+VRh/H7S2DB1AvexVZI1NARJ9TVlxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWp0Y2dR9B13+FI7yJK3+uJ3+KIiYilIv1li015zy/1ddwUcwutFHOQ68ItJkKO5vJR0OrqzFQgmo8jhi+YSUiQQE2TZWYdK/34K4/yMuS0S/yCoZCs1ZLhQ/JgLykKyqI04wKT8mNh2AIKWTxFhp+74Axa4F8OmYGAn9QwDh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=eSdU1W95; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/qNrJQ0s2Mn0UJ5/hqRz3OJdxtP95JtfkjCzxkzcl7M=; t=1761482552;
	x=1761914552; b=eSdU1W95gc2qXtwDs/ZaUPx2Nl1Dx9k9JF7UHEfO1OQcVAxAuKA1PVRhkK63L
	SN5GvD8xGny+vY5JLZuYjKj6jcGpkT5GPrUfc2wo0Obj3FcohjhppcqgR0Xm1jQ0RBOYN/yNFIyv8
	XFMn+fqwdgrxHge0M8Td+8sCUPX57lGcTNJ0utONAcCshU7IgoyTSaolh5VAT3lOd6xPZwYhsV9HP
	qprO6ChhJfBDhygxNa7j+B1YCtmyOxn7Dwde4azzTDAi4BqJFwsoHJ25qMDIFt169QkUlgCCh8aeY
	GmSyQ3HCQYuM3IkwsdKI43me9pQsEgXairR7N0/7Znb+s6zHOw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04s-001mYe-1q;
	Sun, 26 Oct 2025 13:42:30 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 22/30] docs: reporting-issues: move text on 'initial write-up' upwards
Date: Sun, 26 Oct 2025 13:42:13 +0100
Message-ID: <769d2d492ac273f66a1e867bb17a14f32dde0d27.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482552;81a32109;
X-HE-SMSGID: 1vD04s-001mYe-1q

Move text around to improve diffability of a follow-up patch.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 824b7b5394440e..a5c40e75833638 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -183,10 +183,15 @@ following the others is usually in your own interest.
 
  [:ref:`details <backup_repiref>`]
 
+ * Write down coarsely how to reproduce the issue.
+
  * Ensure your system does not enhance its kernels by building additional
    kernel modules on-the-fly, which solutions like DKMS might be doing locally
    without your knowledge.
 
+ * Check if your kernel was 'tainted' when the issue occurred, as the event
+   that made the kernel set this flag might be causing the issue you face.
+
  * Write down coarsely how to reproduce the issue.
 
  * If you are facing a regression within a stable or longterm version line
@@ -926,6 +931,23 @@ operating system as well as everything you need to restore the backup.
 [:ref:`back to step-by-step guide <backup_repisbs>`]
 
 
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
 Make sure your kernel doesn't get enhanced
 ------------------------------------------
 
@@ -947,23 +969,6 @@ module not part of the Linux kernel. That why your might need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.
 
 
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
 Regression in stable or longterm kernel?
 ----------------------------------------
 
-- 
2.51.0


