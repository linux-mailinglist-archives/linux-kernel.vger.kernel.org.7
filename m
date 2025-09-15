Return-Path: <linux-kernel+bounces-817069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F071B57D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3CE3BA579
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93731D725;
	Mon, 15 Sep 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnE6i71U"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951A31B804
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943649; cv=none; b=ayN5wRL/9+vxem47WaNAF6l3UubrhsDK6Z0hL+ROPHjQIYHA5vFKU2mbOjmbgwN+3JM68dlH85q6iyHm2UXBz9TbucybkPYymMwvJwNjoauKwb6uAfPT96ZcI+zMtZg27JKZ3i2Y8oI+y7udPaM1KNEV9s8IazG2Fdsrlos1PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943649; c=relaxed/simple;
	bh=FBq/DDez1sx7se+2qA7U/NKGp3nbD5QcIkERwmMC/c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxwdL4jyM1LlDOEeLnGYVFxGo4E/pVV3qxLweB1S/pmgOQHBZsMLQw+YxHmbtzljyXKSCSivqUwmgw/Izmlx9mkXXkIGkL0O7294lcEQDpUyPDutzB58GdndpDyUpL2eZy1YwA9uSkPUZIuKrlMws3Z1OTD8YGx4AvzQTvSXaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnE6i71U; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso4055618e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943646; x=1758548446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV1e2VNq+22/ypAjT1R5Vw3M7LwIDx8IopA7Om2mhzY=;
        b=dnE6i71UGQE+vama8PXnPMBbAiZxVI8zmtBBzwWy59J5ep+LQoqZSYWYWc4Ejxf2Eo
         DdBTqlS5cn4VqF2TJi+EWSjuLTn+bWXDU2datDt8XAmFLu0bUdBtci0xO53q7gPNTp2W
         OnCiSLObblrOb85DZNJj46/u03eOJ48iyLJpGyH40vHWpig+emrBapKw6Uz4O0g2Xdx4
         /kvbtYE74YQ6pnYVWTRaGrY91GCbHIIUrc1eVl4D/9Vz+/95oZSp+wtdfCfn8xM4xK3O
         e3oKOT7TD7ZaEjJW7Qvt0CFyDCKxLmSLP8tvBj4cZ+nlziPtAcrQAwarCBVTso9zlpW3
         6nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943646; x=1758548446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV1e2VNq+22/ypAjT1R5Vw3M7LwIDx8IopA7Om2mhzY=;
        b=GzLP7RGN8RVYW6DVBkdjHH+4PlFQO5KPJE7hmUaZC3Ep3V8NdoYxTU77FipekY+/Xa
         9th2GnmPmSVTgnISAgMDwq50AYG6t9yYIaMD1s1UdyRrG1Uuys3TlP2RH6JFxluyeiPm
         2eN7cW8fyPmZW9OcX4zQO7xY6SGgUb7GbUBHjRblWWyCMILkPXKz1njy0BbU1UFWYpGn
         5tzFzkm9h1zZtsn8kqss6QmaXcVF4Jya6cqnQjWKuvoFFNePkjYRVgH4lMf4lqj+UcI4
         XxEa9yf+tOWbeQZNdBFeRhsZiYOv/t6gHmvre6hP4/WXVpCvAKz00q3C6i1Y7B1ZFbt0
         sx2g==
X-Forwarded-Encrypted: i=1; AJvYcCWzBD1qiifkiRRlJQ9omACm6xJFaFnzZoWOOHssLq6SfGngnLoIYxsBgx9Zn9YzRkYrUGSpteYjD6tLDDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuHxRZClCInasqpodJfuGSZP98PDyMymiGw10XOxwZqNsf1Fi
	2IoT8tx4YitNR/YeAZARC482D2Ttze4jNpcNQ+mWTxoOPJFy/EDS93f0
X-Gm-Gg: ASbGncu9rKQa5Fphf7roiMj2PXZ+v0J0Zp6NbiMUIgKtELpPMgP4R6yyNX7XoJx2Nw6
	eVnKvvdYIYzfZ9XfPWMJYbsbiDm428bAVCtCdp07++z55Cc5vTs1B9oxwbMFArVt5TNwK67B3lO
	Ox9Et/OGR19bGCMVHvBQQLwoO8GboKiCOjXKFlGMxwYQYsA2kFy42+RVY0Yu06zNmFW40LnkXl6
	eT4JCRCWcPADO6tyqs3DCM6CAmmSrVCl61/x5U6iGSdqHEYi9AkHZBj0wP2BTT4Hic481eUzlkg
	CcMcshKBdEuMKh5De0S6X3KapX+GwvTQzpM1b6BfL5wElF3GhoLgEJlyCMUwVUli/sZBCDDSZlb
	vBh98eLjOq7nSTGZ1pEZn7ptQw8M=
X-Google-Smtp-Source: AGHT+IFMl/8ikQKbN8g7KTI8lfUmWOfTByEM9LJHJSKPa4fW2Bo+fguqUFOHKb+MoWYZ1jAerIJ9wg==
X-Received: by 2002:a05:6512:61cf:20b0:560:9993:f14d with SMTP id 2adb3069b0e04-5704a3e6909mr3838025e87.3.1757943645704;
        Mon, 15 Sep 2025 06:40:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:45 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 03/10] mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
Date: Mon, 15 Sep 2025 15:40:33 +0200
Message-ID: <20250915134041.151462-4-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_vmap_area() currently assumes that sleeping is allowed during
allocation. This is not true for callers which pass non-blocking
GFP flags, such as GFP_ATOMIC or GFP_NOWAIT.

This patch adds logic to detect whether the given gfp_mask permits
blocking. It avoids invoking might_sleep() or falling back to reclaim
path if blocking is not allowed.

This makes alloc_vmap_area() safer for use in non-sleeping contexts,
where previously it could hit unexpected sleeps, trigger warnings.

It is a preparation and adjustment step to later allow both GFP_ATOMIC
and GFP_NOWAIT allocations in this series.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..49a0f81930a8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2017,6 +2017,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	unsigned long freed;
 	unsigned long addr;
 	unsigned int vn_id;
+	bool allow_block;
 	int purged = 0;
 	int ret;
 
@@ -2028,7 +2029,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	/* Only reclaim behaviour flags are relevant. */
 	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
-	might_sleep();
+	allow_block = gfpflags_allow_blocking(gfp_mask);
+	might_sleep_if(allow_block);
 
 	/*
 	 * If a VA is obtained from a global heap(if it fails here)
@@ -2065,8 +2067,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the error value is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	if (IS_ERR_VALUE(addr))
-		goto overflow;
+	if (IS_ERR_VALUE(addr)) {
+		if (allow_block)
+			goto overflow;
+
+		/*
+		 * We can not trigger any reclaim logic because
+		 * sleeping is not allowed, thus fail an allocation.
+		 */
+		goto out_free_va;
+	}
 
 	va->va_start = addr;
 	va->va_end = addr + size;
@@ -2116,6 +2126,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
 				size, vstart, vend);
 
+out_free_va:
 	kmem_cache_free(vmap_area_cachep, va);
 	return ERR_PTR(-EBUSY);
 }
-- 
2.47.3


