Return-Path: <linux-kernel+bounces-844234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B66BC15A3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA6C4F1FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB12DF15B;
	Tue,  7 Oct 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApeA/hHN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA302DCF7C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839646; cv=none; b=abHLFuWWdjolWLm8IVU7cJq046nNaZ6/3SPdgJWW6evsDJpVLokQOHRTC4um6W5IsLnIOsBE6JZifRctFPKbRcoWlWB4f1mYFFJJZwZVz8QpCRAXk8Ug8l/In2BaReqr8Fh2w8bTyPwcfmHRvyUnc40i01pt/xrcFS+D5ToaxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839646; c=relaxed/simple;
	bh=5tzWNyU3AXYCEpPLT5aXRk5UxMX97n5L3bxKGpOPArE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7JobAbJgj+v4F7IkZ2ARUu8niot5CYWyIbvaak2J+7NsHuXAZ7ITg//GRRfxkHDCD1F9dnjpH6OihizwocApBchdiJVOaZbF1uSLLlBSRrk76XEbEpkoWQwmRIwTswX33rgv7/sl7KTVIlRMyX8yEPyOIxdxQHUNSNwYqGTxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApeA/hHN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59052926cf9so2148244e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839643; x=1760444443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTAgJkdvXfIYVJGWt9rTo9DrGAL0rL30tXGrZW/Q/UA=;
        b=ApeA/hHNCPttxnm5fCwmYBtXL/7Wg2uYIivIqfiEWD6wjK8qVMiHkMXrFa+23dBcn/
         ysLphB996Vvw2oCU2xeoA4W53CrpLGD9peef3l6fEuTlPDEJt6JKubh+h2n5NhsXy+ml
         4gYTEBxdRaD4VazKBZJYcyITFHmAWK5d96wvypFhhfoz9HIUdNGhVgC/LaWhvrjtbM29
         pVoxyL9E7Af9VBK5qAWVpJCRO9PC5A9BECn1OWhOwKcjNGFFAOwWs9LhIgUS/+CxwxoM
         2PpqQadH+InHbaTgYHEnCxDOAOxnkCMdxgdrsKqfvw6TPX2bXtas1Ynexlz4XuX4UWBI
         YCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839643; x=1760444443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTAgJkdvXfIYVJGWt9rTo9DrGAL0rL30tXGrZW/Q/UA=;
        b=Grae7P+llLI5tHAta7RVgWqZ5J+HhI+5ALWI3nJ+j1g2MeX1dsKwEDQxs2g2L7aTMm
         8nnMqaLYsHjg/lM8p5WvzClgqAYpgR6MUbE2F/c7v4HyxD5EMNp1wPG//+zUEqo9UQ6x
         25vg/jV/AO9dWfC9s4tRThoCSd9lLI6TLgB1vi3ucVJ1CAUouz3YFxfexcKsWoh8Q7ib
         fj6Us9RElJBYsg8CSQB0RkYy9qrIFnpcJQmF5dqWeEfBX/WToX0PqyD+JluH8apTgy3J
         s3UheE8CBFvxlfU+TVg+4PZEjKK9v01rNSkQAu3FFrDExuMDeHSAJsb5AjsL6U9+Wy39
         sP0g==
X-Forwarded-Encrypted: i=1; AJvYcCU7CIuPIFjLG30t7AyCGw8X3MTj8rnvKaPl9L3KdNvDlQPHcQPiqjUJAQuq3mmUU7JkftfASZqVNI8UW00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkESCmhRqqSCXASMuoUiWbP0zEcEWXS0IG2EuSNpCogawPjOes
	EXcV7xXHd88x1rBFqfaHf/0iRNBaPk+/GLW3vNun+vl6V2y44KWBmhPpjFUsPMa7
X-Gm-Gg: ASbGncsnNPxwNbIbWel2JP6PTnwFZEKKeHKX1+1NVNUkz+G281hB2Xm3VTTxy0U4NxO
	J4Vh9CCfPgo9bMMbvPYWsX/iG6ixym8YyLSH5mMCitS8Xz/X6uc6zxZV6BBnOIcq07GzHZiMLq6
	RdUuKlvtCQsACDbJl5FQPNpeDu28VZS+vmt47mFHv5ntfY6r0sGOb8EHLoMOz1yRl+97trRXWro
	sxBAD6zqDvCD4NB+dREvtCPc/13oGBXYlcbQ97j4P08RqfztTG/6ji7d5SBFaiNa7cchjWmbH5W
	Fn1Pgq7HI1COiXvCcZ1G3xroOShTEGlukKuTCIIu3ljGbN83MDeYSsCQyxuPQDd1jedQkObRFYx
	1X+4qkGUARvQ6fGU8fjKTj13HAbZ44GwkZiEyB4IV
X-Google-Smtp-Source: AGHT+IFVcM3R4gXRnpw+tlnoSIwV5PNPCQsvct6ThdG/Q39YghEZIMUDacX/nHdSOJk06aKFSGKo3Q==
X-Received: by 2002:a05:6512:68c:b0:58b:2a2:2a01 with SMTP id 2adb3069b0e04-58cb984f07fmr5343552e87.5.1759839642331;
        Tue, 07 Oct 2025 05:20:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:41 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 03/10] mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
Date: Tue,  7 Oct 2025 14:20:28 +0200
Message-ID: <20251007122035.56347-4-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
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


