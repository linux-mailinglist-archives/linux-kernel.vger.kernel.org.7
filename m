Return-Path: <linux-kernel+bounces-870356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2FC0A81A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B322E4E99A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CEE2E8B7E;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="R33DzFEb"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB92DEA86;
	Sun, 26 Oct 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482559; cv=none; b=DWxTXNujdsjxi96p9xWVhNhnEEvC8IDj74hNn/9zaw7uXcVlZacwdRxe7vvvEtd2TnZ88iOXGUjhiY934ttPkcQjko29TNk/V7/RwieWzg4USpHtZC3i/5L9ZK4l/AIEO1V1S7bJYsO5IE2FO3E+HA4zztE+uDaTZpT5q5ihuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482559; c=relaxed/simple;
	bh=ssVvwoFpHksR7S1yAW0o5ytD10Wjf8FwhSwY9WdtQzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6GL6pcOCWD0e143aFflW01/jX388paXR8YOnJ7j46lX1hzyxuCxdYdggUY5W7vHgwSafmrxE84GE3jmudgJ3ioYVtoZNuNrvsTsjfDMxqIqHi3YkCiKsv1zuHjq1O8X0+8EWmWn12bc38Z8WtP8tMZFxwANyEJZVRBa0J/P8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=R33DzFEb; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=wxOJZPwa+y+t+XC7Eo7yNZo1Tn0YNyHGnurlluB3qas=; t=1761482555;
	x=1761914555; b=R33DzFEbexS6mTtXMBUiY3W7sQ/aHOMkt33oO6eErJCr/Np9WCaoU/dnwyjAN
	7VHmiXiI8/aUfyvw5xNyxL3RI/nUqjgnsdS3lpEMLKJpSy34WUaH6bvGUo/UVlfBej8wRUM3ZmH4Y
	cBFc3s16UKLSUEpH7V4y96kYuxu1I8LM+SmlmRd7M1DHuQarbhnvS8GKMok8iogAhGXPazmDscmlO
	tRCjmfq9kyX98J/vpv0VCMIw+hHaYNSz3puCS5+SYgandK/b2KrzpQVkitF9G6F6cUJUmLwNqv2fr
	PcTPQZSC2HnkG8hiFWF2yoqqcbDihty5xBd+Jzg9s4f+OEg+OA==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04q-001mYF-0F;
	Sun, 26 Oct 2025 13:42:28 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 15/30] docs: reporting-issues: improve text on classifying the bug
Date: Sun, 26 Oct 2025 13:42:06 +0100
Message-ID: <72dc704c18af85ea8b5a80b9c3714588235d0797.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482555;32bd3f7a;
X-HE-SMSGID: 1vD04q-001mYF-0F

Fine-tune the instructions about classifying the bug.

This drops support for "really severe problems", this is a rare special
case not woth spending much thought on.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 62 +++++++++----------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 623feb55caae97..be0e49046ec913 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -128,10 +128,13 @@ following the others is usually in your own interest.
 
  [:ref:`details <checkloreone_repiref>`]
 
+.. _specialtreat_repisbs:
 
- * See if the issue you are dealing with qualifies as regression, security
-   issue, or a really severe problem: those are 'issues of high priority' that
-   need special handling in some steps that are about to follow.
+* Evaluate if the issue you are dealing with qualifies as a regression or
+  security issue, as those receive special treatment in some of the following
+  steps.
+
+ [:ref:`details <specialtreat_repiref>`]
 
  * Create a fresh backup and put system repair and restore tools at hand.
 
@@ -647,37 +650,30 @@ While doing so, keep in mind:
 [:ref:`back to step-by-step guide <checkloreone_repisbs>`]
 
 
-Issue of high priority?
------------------------
+.. _specialtreat_repiref:
+
+Issues receiving special treatment
+----------------------------------
+
+  *Evaluate if the issue you are dealing with qualifies as a regression or
+  security issue, as those* [:ref:`... <specialtreat_repisbs>`]
+
+Check if you face an issue that receives special treatment in the Linux
+development process:
+
+* You deal with a regression, if some application or practical use case running
+  fine with one Linux kernel version works worse or not at all with a newer
+  version compiled using a similar configuration; the 'no regression' rule
+  forbids that. The document
+  Documentation/admin-guide/reporting-regressions.rst explains these and
+  additional aspects in more detail, but everything important is covered in
+  this document.
+
+* What qualifies as a security issue is left to your judgment. Consider reading
+  Documentation/process/security-bugs.rst before proceeding, which
+  provides instructions on handling security issues.
 
-    *See if the issue you are dealing with qualifies as regression, security
-    issue, or a really severe problem: those are 'issues of high priority' that
-    need special handling in some steps that are about to follow.*
-
-Linus Torvalds and the leading Linux kernel developers want to see some issues
-fixed as soon as possible, hence there are 'issues of high priority' that get
-handled slightly differently in the reporting process. Three type of cases
-qualify: regressions, security issues, and really severe problems.
-
-You deal with a regression if some application or practical use case running
-fine with one Linux kernel works worse or not at all with a newer version
-compiled using a similar configuration. The document
-Documentation/admin-guide/reporting-regressions.rst explains this in more
-detail. It also provides a good deal of other information about regressions you
-might want to be aware of; it for example explains how to add your issue to the
-list of tracked regressions, to ensure it won't fall through the cracks.
-
-What qualifies as security issue is left to your judgment. Consider reading
-Documentation/process/security-bugs.rst before proceeding, as it
-provides additional details how to best handle security issues.
-
-An issue is a 'really severe problem' when something totally unacceptably bad
-happens. That's for example the case when a Linux kernel corrupts the data it's
-handling or damages hardware it's running on. You're also dealing with a severe
-issue when the kernel suddenly stops working with an error message ('kernel
-panic') or without any farewell note at all. Note: do not confuse a 'panic' (a
-fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
-as the kernel remains running after the latter.
+[:ref:`back to step-by-step guide <specialtreat_repisbs>`]
 
 
 Prepare for emergencies
-- 
2.51.0


