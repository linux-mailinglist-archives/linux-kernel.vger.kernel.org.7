Return-Path: <linux-kernel+bounces-870338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89DC0A7EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F1118A11B2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148E2C0289;
	Sun, 26 Oct 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="2LjgI+Li"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0832DA774;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482554; cv=none; b=KnR2pGNPSN9Z9kQcmWNVXi64YP42X3OeCDi6eSQPKizQaVoQtiTeEBVvqr6vfN3V3IW1toz08mO/pYJ1x/GqQTxfkCbhJMN8g+UfifxLWvP6X2w5RHTTnhVLNLM2jYe0Mlo73kUzhmT1mGBlsMTIfZ2/H22yzG5gpkqHEMhVDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482554; c=relaxed/simple;
	bh=MzQ28r/dhKKX8TM4X+PZrQvHqruMDwFGroswwwsys9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1FnU2YidmPL7ENumIgStOwIYgbI9dhZSUj/bLV8vOh2G7ewdc+cxhDKKTxEclL1+ZynAY4j7yhLkTiQUESoADR+TbFZ5x3LM1soLt/97pDHE+VoOYcP/35HzxA048TGbTEj4tWdSVLCNXsWUagCqqCe/kLO3aZUSsrtzow5pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=2LjgI+Li; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pErYh5HOsLK9BdZsfpbPa+r/6tDB+XJBSgvlVnQBtUI=; t=1761482552;
	x=1761914552; b=2LjgI+LixOHDAk69lv8VHy1dvs69ckQrKkbienw8DcLhOVgz5wYcwCkwfDcZN
	KUgcyP1ppE/v7aCfQ/ZD5kVU5oVQ1exQDovA2bBk31SdNeMyXap5kEd4xJCwZtDK6YD8CVXHK70ga
	sC+N9COKxP7Sypwba+JX2QLFcTxKrXu8JQW8NVZn9IfrPcYhhpg3hzLZuU9chqgw7l39glASVJzJG
	rno7zXKM5RafRrnklHRvBhVruTWDTgO5c7iG23ecOaFZgNKYFX0Thxt2R0NIxrKZzLAigIhy/QFiU
	OkGmywcsAEfYHpgdh7h2TC4b+LdfBru2Gd6lz1Fsc6OumDzrsQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04n-001mXP-0f;
	Sun, 26 Oct 2025 13:42:25 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/30] docs: reporting-issues: add step about processing issues separately
Date: Sun, 26 Oct 2025 13:41:59 +0100
Message-ID: <9b6e279c9d11eefe7ff01672a054783dbf651bc0.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04n-001mXP-0f

Create a separate step covering 'process and report each separately if you
deal with multiple issues at the same time'.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 45 ++++++++++++-------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2f387e8766f21d..73b7792d84cdf1 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -69,6 +69,14 @@ following the others is usually in your own interest.
 
  [:ref:`details <intro_repiref>`]
 
+.. _multiple_repisbs:
+
+* *You must* process and report each issue separately if you deal with multiple.
+  If there is a slim chance they are related, remember to briefly mention the
+  other problems in each of the reports, ideally cross-linking them in the end.
+
+ [:ref:`details <multiple_repiref>`]
+
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
    List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
@@ -90,11 +98,7 @@ following the others is usually in your own interest.
  * Check if your kernel was 'tainted' when the issue occurred, as the event
    that made the kernel set this flag might be causing the issue you face.
 
- * Write down coarsely how to reproduce the issue. If you deal with multiple
-   issues at once, create separate notes for each of them and make sure they
-   work independently on a freshly booted system. That's needed, as each issue
-   needs to get reported to the kernel developers separately, unless they are
-   strongly entangled.
+ * Write down coarsely how to reproduce the issue.
 
  * If you are facing a regression within a stable or longterm version line
    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
@@ -347,6 +351,23 @@ time.
 [:ref:`back to step-by-step guide <intro_repisbs>`]
 
 
+.. _multiple_repiref:
+
+Issues must be reported one by one
+----------------------------------
+
+  *You must process and report each issue separately if you deal with
+  multiple. If there is a slim chance* [:ref:`... <multiple_repisbs>`]
+
+You will have to report issues one by one if you deal with multiple, as they
+likely will be handled by different developers; describing various issues in
+one report also makes it difficult for others to understand the situation.
+Hence, only combine issues in one report if they are very strongly
+entangled or clearly have the same cause.
+
+[:ref:`back to step-by-step guide <multiple_repisbs>`]
+
+
 Search for existing reports, first run
 --------------------------------------
 
@@ -569,19 +590,9 @@ three things:
 Document how to reproduce issue
 -------------------------------
 
-    *Write down coarsely how to reproduce the issue. If you deal with multiple
-    issues at once, create separate notes for each of them and make sure they
-    work independently on a freshly booted system. That's needed, as each issue
-    needs to get reported to the kernel developers separately, unless they are
-    strongly entangled.*
-
-If you deal with multiple issues at once, you'll have to report each of them
-separately, as they might be handled by different developers. Describing
-various issues in one report also makes it quite difficult for others to tear
-it apart. Hence, only combine issues in one report if they are very strongly
-entangled.
+    *Write down coarsely how to reproduce the issue.*
 
-Additionally, during the reporting process you will have to test if the issue
+During the reporting process you will have to test if the issue
 happens with other kernel versions. Therefore, it will make your work easier if
 you know exactly how to reproduce an issue quickly on a freshly booted system.
 
-- 
2.51.0


