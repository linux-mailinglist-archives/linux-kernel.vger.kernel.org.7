Return-Path: <linux-kernel+bounces-809351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C196B50C54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25509465372
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB15263892;
	Wed, 10 Sep 2025 03:33:14 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A125B69F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475194; cv=none; b=U7U1zBilGpzKl4ZvwMLaV2y/coz3zpPr+g+vfHK2zA9CJ5TNoQbeZfc8lT6fKqdcSZv8pY0cgiPKjEqQ7/D1AEfaBxzoiHHhMN0SUQZVuLexGK56uYCshijVyu1u2P33yegUxeswW2HWXnkTvyBbONlfawDUHsRC1GhDyTb2Y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475194; c=relaxed/simple;
	bh=gNqSJfbSx0ggWHnz0FnjAuFrwifiUc6ruI3bSB++ovo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Owpqj45yUK6nU6bCWFHE3yiL2F+oJJiRHqcblZ5JSANn977ztH/8c8sAiKYZ5psnFTiv0/UgmlOtoV+xCGGkxBAup7mEBSp30biQodrWSPaf75rZd5A6GetlIlVVKWcBgYCB6TKFUbpsHg2S03vF19vf5QDO1fEr24MFL9CviYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee268c0f0b3310-f43f0;
	Wed, 10 Sep 2025 11:30:00 +0800 (CST)
X-RM-TRANSID:2ee268c0f0b3310-f43f0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee968c0f0b41c9-7ed92;
	Wed, 10 Sep 2025 11:30:00 +0800 (CST)
X-RM-TRANSID:2ee968c0f0b41c9-7ed92
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: karolinadrobnik@gmail.com,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools: Add a return value check of malloc() and calloc()
Date: Wed, 10 Sep 2025 11:29:50 +0800
Message-ID: <20250910032951.2897-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Add a return value check of malloc() and calloc() in lib/slab.c

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/lib/slab.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/slab.c b/tools/lib/slab.c
index 981a21404f32..07c98926c0e4 100644
--- a/tools/lib/slab.c
+++ b/tools/lib/slab.c
@@ -19,6 +19,8 @@ void *kmalloc(size_t size, gfp_t gfp)
 		return NULL;
 
 	ret = malloc(size);
+	if (!ret)
+		return NULL;
 	uatomic_inc(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from malloc\n", ret);
@@ -45,6 +47,8 @@ void *kmalloc_array(size_t n, size_t size, gfp_t gfp)
 		return NULL;
 
 	ret = calloc(n, size);
+	if (!ret)
+		return NULL;
 	uatomic_inc(&kmalloc_nr_allocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from calloc\n", ret);
-- 
2.33.0




