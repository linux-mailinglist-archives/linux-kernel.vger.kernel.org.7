Return-Path: <linux-kernel+bounces-870337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F9C0A7DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0603318A0F20
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554E2E172B;
	Sun, 26 Oct 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aHE03fLk"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5C2C235D;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482554; cv=none; b=Xj1WHKxJkaRu2zz5kCKRr8YvRpYrYw33Kw2GamiguBBY8J/y8aB+4tu84amfVr1mEnw8/kSIBuP5sqnOESVAaANdDj/d1lHxSQrgAwuOYQztIIEJ7z9CvxaNgxZsUtf+H+IGqEnCdAuuKDLsIGDWpY50t9RKseTAh5assFyvihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482554; c=relaxed/simple;
	bh=EB4l20CtlH/TKvx8+1SQADxqp/5ETrJBw4utKo1I1YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daza3aThDYYSxRmARlcE56IXgizld1X9bJBRHr5qFGlrJHfbEtTIQmew8cR19KCjQsyHkx/7vr4rREZdVXvcG7qCqnPF2H8o/70bNddFPZ6rbeGzCJl2sdFjNuynpcg2GBSzL8zd4cISG6CTT+zWPv2VjoePOYfuvXKmcAr2Y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aHE03fLk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=n3DgjLvDifCmg81+qUxSYOLFkhBea1gNJNz0eht+0gI=; t=1761482552;
	x=1761914552; b=aHE03fLkagRB7iN0nzPP8FeKZdey/YnvOPft3W0ZKk8V7wb0VTRY0f672MLFs
	8hlxiTf8w4quWxcuPGKsSWUxvP11ssoVXq6iLtrWQaHzLWGwTh0XHYnvBardY+cRb1kbTzcrsHL+4
	me+U8O6L15Ph1FOUYxj7VURq2IaaxcR2co8Nyd//pOkqjw5/G5r60gqbSk38WyTNzF4eqoiC5hoZo
	SxgomC03tNdey+ENsTm8ZAZ85nNzXkW89bLvmKvCXaKOUWxNSa83wXZPgthSxo/c/y7u4ufcBNSXI
	amsxiOevS/uGhHaU225s30EFGERwaOKugM1CzMyRx/UUypcODA==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04s-001mYe-0l;
	Sun, 26 Oct 2025 13:42:30 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 21/30] docs: reporting-issues: improve text on backup et. al
Date: Sun, 26 Oct 2025 13:42:12 +0100
Message-ID: <13046cae22b876d818a8c49939bf5daac0437c5e.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04s-001mYe-0l

Fine-tune the instructions about creating a backup and preparing for
emergencies.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index c34a95d5af4ac6..824b7b5394440e 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -176,7 +176,12 @@ following the others is usually in your own interest.
 
  [:ref:`details <otherplaces_repiref>`]
 
- * Create a fresh backup and put system repair and restore tools at hand.
+.. _backup_repisbs:
+
+* You might want to create a fresh backup and put both system repair and
+  restore tools at hand.
+
+ [:ref:`details <backup_repiref>`]
 
  * Ensure your system does not enhance its kernels by building additional
    kernel modules on-the-fly, which solutions like DKMS might be doing locally
@@ -904,17 +909,21 @@ or even more time can save everyone, including you, quite some trouble.
 [:ref:`back to step-by-step guide <otherplaces_repisbs>`]
 
 
+.. _backup_repiref:
+
 Prepare for emergencies
 -----------------------
 
-    *Create a fresh backup and put system repair and restore tools at hand.*
+  *You might want to create a fresh backup and put both* [:ref:`... <backup_repisbs>`]
+
+Remember, you are dealing with computers, which sometimes do unexpected things,
+especially if you fiddle with crucial parts like their operating system kernel.
+That is what you are about to do in this process. You thus better want to create
+a fresh backup. In case you need to install a kernel during the bug reporting
+process, also ensure you have all tools at hand to repair or reinstall the
+operating system as well as everything you need to restore the backup.
 
-Reminder, you are dealing with computers, which sometimes do unexpected things,
-especially if you fiddle with crucial parts like the kernel of its operating
-system. That's what you are about to do in this process. Thus, make sure to
-create a fresh backup; also ensure you have all tools at hand to repair or
-reinstall the operating system as well as everything you need to restore the
-backup.
+[:ref:`back to step-by-step guide <backup_repisbs>`]
 
 
 Make sure your kernel doesn't get enhanced
-- 
2.51.0


