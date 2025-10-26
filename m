Return-Path: <linux-kernel+bounces-870348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFCC0A823
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768273AFD82
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C742E7192;
	Sun, 26 Oct 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="oolSZuUY"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4C2DE6F2;
	Sun, 26 Oct 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482557; cv=none; b=QkkiA2AgK1A3mnbX3K/OXUSOZmvjjY2hUJaPGPTfC02ZyrfqqWIMQ8lBDXZsBwIJkhNTpUeEW+vCwyDT8RaiK0YQTphUTLCXnVgFoUYaQhfibLbUNP+r4LIv78jSGsasrmbetHVrZeYgWgEG68DL9/XhAV4T3jl+ePiGvmDqYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482557; c=relaxed/simple;
	bh=Ofxx0+c/MRp/TNjJRRAi4gsRd25jUdBrB86emjyGm/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/nzZ5YZTHRKY0IreimWTZLvLs119bVL+1dqykyM0OrjnVS8Bp/lJoj5gWlLIH67bHKyYs9cE8llmcYMlJJyGkNSskDiTg2fwzWqhA0bQuHpi+8+9c5TtxSVQm0L/HR8Pjm/jSNhpsLgEFUD67i92gQ8UWGx7aJXn7VGRWzVnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=oolSZuUY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3CHjp0Wli2N5/16/s/0lV/OPy7U+/3+rC+O47XOU8ng=; t=1761482555;
	x=1761914555; b=oolSZuUYx/fb4n8g2yP3th0cdGvq2ttkahzQizFIx32u+Miuu3lAXoFL7+dzH
	nDsjdxtLBpqGkSWKVGs5lhrKcZIXtGn8zfxzlLUgRhatueUmDh/fWuFHwwojxW9giMq06gTqF2j+5
	F6cJBx1uLPy3nO97gUlzhcvdlelSVRt5pk/OXv2rPhwjJI3g6EkKmEroVOp5zKBBmrMd+kcgtYSnA
	/aOteDEH89f+T9bf26d1eHppR/gRKho9ojgMf6wRSMNSTKMa9bWfDRSSi1VMDeqSjAoeOaeAe4WoC
	sCkTfwCQ2Qdlo7qoJPYebPDeNtTqxNd0e6CW934AxOjyiOzCzQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04q-001mYF-1K;
	Sun, 26 Oct 2025 13:42:28 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 16/30] docs: reporting-issues: add fast-track for regressions
Date: Sun, 26 Oct 2025 13:42:07 +0100
Message-ID: <279303a7d230ac7c9db13cf7cf807732946badb3.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04q-001mYF-1K

Some regressions are reported multiple times within a short time frame,
so it's worth asking on the regressions mailing list: subscribers might
already known about them and might safe the reporter a lot of trouble,
as reporting it again is unlikely to do much of a difference.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index be0e49046ec913..f040ca7c0a2f59 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -136,6 +136,19 @@ following the others is usually in your own interest.
 
  [:ref:`details <specialtreat_repiref>`]
 
+.. _reginquiry_repisbs:
+
+* Do you face a regression? One still occurring in a kernel version less than
+  two (ideally: one) weeks old? A kernel that is vanilla or close to it? If
+  you answered all three questions with 'yes', feel free to send a brief email
+  to the public 'Linux regressions mailing list <regressions@lists.linux.dev>'
+  asking if the problem is known. If someone confirms this to be the case,
+  there most likely is no need to follow this guide further; but do so in case
+  there is no reply with a pointer to a matching report within two or three
+  weekdays. You are also free to immediately continue if you feel like it.
+
+ [:ref:`details <reginquiry_repiref>`]
+
  * Create a fresh backup and put system repair and restore tools at hand.
 
  * Ensure your system does not enhance its kernels by building additional
@@ -676,6 +689,22 @@ development process:
 [:ref:`back to step-by-step guide <specialtreat_repisbs>`]
 
 
+.. _reginquiry_repiref:
+
+Fast track for regressions
+--------------------------
+
+  *Do you face a regression? One still occurring in a kernel version less than
+  two (ideally: one) weeks old? A kernel that is vanilla or close to it? If you
+  answered* [:ref:`... <reginquiry_repisbs>`]
+
+This is an optional fast track that might relieve you from further work on
+reporting in case the issue is already known. Note: It are volunteers that
+answer these emails on a best-effort basis.
+
+[:ref:`back to step-by-step guide <reginquiry_repisbs>`]
+
+
 Prepare for emergencies
 -----------------------
 
-- 
2.51.0


