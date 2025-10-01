Return-Path: <linux-kernel+bounces-839421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347EFBB196E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9737AE897
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7322F25E7;
	Wed,  1 Oct 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPNFXSAl"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B832D73A6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346815; cv=none; b=H+EW1NhcK9n9jXP/K13SUE66VHbjluvRvBfwRkyHOwJGPrWfAsq4q4MVI9ouaSWwtPob9rEKATbbPf8Ap1hbm2EBv12cd9ivse+YVjqfTUQsfa7WbePn+5UtPUMtr9QeHmcdYJVT5GsPoV6BCCOkiyiao+wd7WJoiKNmmtPoSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346815; c=relaxed/simple;
	bh=5tzWNyU3AXYCEpPLT5aXRk5UxMX97n5L3bxKGpOPArE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+XSP+PX06ZOLLFeEmQ525d0BCq3liWixn/vKfR+jsOUHJLO1ddZh5apMZHExQ+bEJbvJglxCcteWOUnfyhVaYfnQoaoYvTr+KV6uRxBnLzXGH0vAJVqEagwH7OCYOd3dkE46oKBWBLTk9tguLp8OaG+eMy5CCWsKizpo2qzpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPNFXSAl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso201746e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346812; x=1759951612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTAgJkdvXfIYVJGWt9rTo9DrGAL0rL30tXGrZW/Q/UA=;
        b=LPNFXSAl7Brk3fKGac2KYCiUkRsgXc1o2LGG5er/oRxTDn96YJTENeTouvvRQjzQqY
         lnMf7TAzj+H8bl1iFlSU4x0nMPNem8qRBSeBbj+tkLTkwZH0IDAd25LmzM4br3uJltOP
         JWkd1kwmL5b4c3Q/bmkuqEtdSowWRMxzf6uDaOqGuX/1FadRqfOmNjXmlameHdpeLsCg
         Ax4e5sq0sBWjMRKDiAGIzVgQa36ZtSnWnIGOglH3agjfyf9RdEfSUWLWKCQ1IzIgckKi
         orRc/Ifp9sbtSkw07QZkLST+e44bW3WbVfaYIBh1q2qzOOKp9bQK9OFYIsFJ/gHhuty9
         6Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346812; x=1759951612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTAgJkdvXfIYVJGWt9rTo9DrGAL0rL30tXGrZW/Q/UA=;
        b=Y0JQgAuHaKxodajGsRAHQV0n6f2tt9pKPT3qXTAWAhNpchKi8MCCAhEz9mVWNPdvz/
         zpm0nKcoJSmmMeDLAjA5LiRsNnfKJuI/ziBm8yQwqOz72/QAZa86QD0cxzP/904c4F05
         E6Dj2OFxldmWFklekx2F4bwCVWPiD9Xibj297CRB4yvq4YUParCb9PKL1p+x0uQ14idq
         nHKWwR3IUQ4qh8MZoIRLK68SGSqJKgT5DT5/nOcqUzxE5kyj7adfNBdffoOsrYu0LHLA
         ANu4gQs9qG4RFo1xlZBIKEAs+4YweLtjdq2j1yNxRL6rdP0wTWEW6WdL1BSuDLu2Vfbl
         Y6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YafXwqxbqzTC7deHOIp0TcThWl4ibeWp23olY5OZuDmSJBmMk3RgYHskE6u8psU9F92xeF2XrJVPOaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbwOf76h226qNWgKs9DdlkZvK/hacfFp1/xeNEAy9Q3MKwvdV
	+Qd0CKZ5FzwJ6Bic0dFhujZlmW3ai3UTGkYWnrnXkhyPudkhHn0raJjF
X-Gm-Gg: ASbGncuJLOs8gXAxA0NWnWp6KyY4UrMTwD0TigMKOSKgLmYw/5wbiTSdOYn5SAhvHXK
	vaAYC+SiVm19e+Nucf5Gq+/grDOp9yU1vb4WnhqD3XFlToEKjix4H+GjL5JjHe1traLWJyt75Cm
	ItN8edcTkOaLZmC4SyyFFPLMbE5gW4kNltjb5c+y79QuyuD4hk9lOPKxAiD4+OzOfPpstAiWYcu
	5Xa8hZtH7qhQxPGHv042XliEH5Nm5caVeu0rqKvU4716qNrYuj/I7cYvSuRtpeQlHEASpAm+P8S
	QKFs8EKNq1l/uH/Lfk1jtrQDEsYkhQzY1cnEL9r4HtGjuqbgDU9UR/Jk0enSTdZmHcy2lxYhWN3
	xU10by5v2evJulGjclRxiYq4t69CjOQ7zCYc1gG1zT3CteY/4LtA=
X-Google-Smtp-Source: AGHT+IF0CvjRQv5Rhg8Uw4MQKskiae3bT7jASaj/mzoAEgMrKa+fqdv3aYo5M9392D4IA+uwz0Xiqw==
X-Received: by 2002:a05:6512:110a:b0:57e:65dd:9bcd with SMTP id 2adb3069b0e04-58af9ee5043mr1207622e87.13.1759346811677;
        Wed, 01 Oct 2025 12:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 03/10] mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
Date: Wed,  1 Oct 2025 21:26:39 +0200
Message-ID: <20251001192647.195204-4-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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
Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..d83c01caaabe 100644
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
@@ -2062,7 +2064,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		 * This is not a fast path.  Check if yielding is needed. This
 		 * is the only reschedule point in the vmalloc() path.
 		 */
-		cond_resched();
+		if (allow_block)
+			cond_resched();
 	}
 
 	trace_alloc_vmap_area(addr, size, align, vstart, vend, IS_ERR_VALUE(addr));
@@ -2071,8 +2074,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
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
@@ -2122,6 +2133,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
 				size, vstart, vend);
 
+out_free_va:
 	kmem_cache_free(vmap_area_cachep, va);
 	return ERR_PTR(-EBUSY);
 }
-- 
2.47.3


