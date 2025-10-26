Return-Path: <linux-kernel+bounces-870355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC026C0A817
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBB084EAB6E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654B2E88BB;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GhKRiPti"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE82DC34D;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482559; cv=none; b=twq/3WyzmzTJE6WWeS3iwJLj6ZxWbuXYH6e6Vx5Mpk9M/Jy1elAaNOUTB7fYWZQm9xfVyZztFMrPXh7W+ePv6Snyk2WYL3rvCMapxQ8dQ4HZ15c1SRWctcH2/CGOwW3I0Rs4oKH4iNTDfXTfMrZOEnBorCwl+7Wms+sfdnWOk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482559; c=relaxed/simple;
	bh=Ji8LR4L1NHfBVq73Eli0Sw59AUqjJ6VV3EUKjCfyvCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFusvtT3/MzAzlBywnBSqAl70cDNvykFyAiVYal9mTaszspSy35c4Ff4rNeys39jOY9716hjrYuchxETsU8ZYowkCoOtHPeYsxaG7mpqo6u8keaV8IPPYwfWxzBuDp8jS38YwEVzgfg1Yx4vBgQ/e5pQNhGQwA0UEb3C7pF4XWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GhKRiPti; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=05X04SjdCEaNS6JET3myuOA/oFj+Hu0euZBhdtro2oo=; t=1761482553;
	x=1761914553; b=GhKRiPtioRgb72mN6crmdHhjOBWp4djJJsgMJnHwkEdELf06MZRhKEsN18wUL
	QG0aM7da03lVU/4JebjRntM18o6YYOuhGos7fBh7CTKGhl8cBx60rpJzmYnvBx1L3QCJnTkhpAvZx
	JedzUanHgZvDhhkqlSu+12aKNB6fGcCtqRSbBRMwBIEUnqfPOYLhp4FQaH0BTv3GgWScGQs4hNQkp
	Yj986PSuAkoSbdXtoaTvW3C/EVESM+vGLSYBBEDAjFT08mcKn593BtZC+diHzEyH8c3Cj6IknJy+A
	/DL7LiBz7jQs6VbnA4Ji/O/saqSMbZzNcZCOBLZneXkBJVTp9g==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04s-001mYe-3A;
	Sun, 26 Oct 2025 13:42:31 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/30] docs: reporting-issues: improve text on initial write-up
Date: Sun, 26 Oct 2025 13:42:14 +0100
Message-ID: <a532e8207ac9dac67641b51239d1a0d984e7c164.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04s-001mYe-3A

Fine-tune the instructions about coarsely writing down how to reproduce
the problem.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index a5c40e75833638..f891764d4f64ce 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -183,7 +183,12 @@ following the others is usually in your own interest.
 
  [:ref:`details <backup_repiref>`]
 
- * Write down coarsely how to reproduce the issue.
+.. _coarsely_repisbs:
+
+* Write down coarsely how to reproduce the issue on a freshly booted system in
+  a straightforward way you can easily reproduce.
+
+ [:ref:`details <coarsely_repiref>`]
 
  * Ensure your system does not enhance its kernels by building additional
    kernel modules on-the-fly, which solutions like DKMS might be doing locally
@@ -931,21 +936,26 @@ operating system as well as everything you need to restore the backup.
 [:ref:`back to step-by-step guide <backup_repisbs>`]
 
 
-Document how to reproduce issue
--------------------------------
+.. _coarsely_repiref:
 
-    *Write down coarsely how to reproduce the issue.*
+Start documenting how to reproduce issue
+----------------------------------------
+
+  *Write down coarsely how to reproduce the issue on a freshly booted system in* [:ref:`... <coarsely_repisbs>`]
 
-During the reporting process you will have to test if the issue
+During the reporting process, you most likely will have to test if the issue
 happens with other kernel versions. Therefore, it will make your work easier if
 you know exactly how to reproduce an issue quickly on a freshly booted system.
+And for the report you need a description anyway.
+
+This obviously is impossible in case you want to report an issue that happened
+just once.  Be aware that it might be fruitless to report such problems, as
+they might be caused by a bit flip due to cosmic radiation; but if you are
+experienced enough to tell such a one-time hardware error apart from a kernel
+issue that is worth reporting even without reproducing it, skip this step and
+the verification.
 
-Note: it's often fruitless to report issues that only happened once, as they
-might be caused by a bit flip due to cosmic radiation. That's why you should
-try to rule that out by reproducing the issue before going further. Feel free
-to ignore this advice if you are experienced enough to tell a one-time error
-due to faulty hardware apart from a kernel issue that rarely happens and thus
-is hard to reproduce.
+[:ref:`back to step-by-step guide <coarsely_repisbs>`]
 
 
 Make sure your kernel doesn't get enhanced
-- 
2.51.0


