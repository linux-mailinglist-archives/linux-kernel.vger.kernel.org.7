Return-Path: <linux-kernel+bounces-758787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DDB1D3D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD62B1AA077E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B625228C;
	Thu,  7 Aug 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckIcgFRm"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2D246BA4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553500; cv=none; b=MmcdIwKOrAO+Z7uV3Zwom4hOb8Y04z7UX+tRBa9UVJ3HE+aPWeaGDmBxQG4P1zJx68x0odbhc9Io9skX5oMEkoxw8lIW52mWAs9V+bx2P1WKoq5sJfZkEv13+ay3JeJOW3erlnGXbbW9T4dH73StSyxVtR2GhGxRPbu5yHLkJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553500; c=relaxed/simple;
	bh=5r+RNMQi8dZuy+pKbnq+Sw7xVkYVTe33iZQ90lvhbJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Il9DmxvH4Sg3AjJd7nzoEYkmeq1UbWTw/oKcQE115X8HBsJSXfBXYKIwkGe2YpKROHhcc+XUYl6ee6tD46QDfC4sSXpw6enUK1vEYZmBItFezwIq/tJQPWjdWJN0A2xea5iOKuk7Z7Q1+Q64MVlH6vuyFQRuUPIoBkKhyQXrktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckIcgFRm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b7e35a452so775498e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553496; x=1755158296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkgUcN0etkmDxWZW74kDtO38nl/qqGRKhgYS9gb7Qoc=;
        b=ckIcgFRmeVNoyh/8CcAGcKlgFAVW/CKtHtMUUH4X78CvTaY8/VavWw8KEymCBc3JXr
         6XI3DIN2JF/vjlqtjK/fCWsQImfkEIh0dNZUvizJAFRGnumFSrpSQnk1v6Wm3r/lw52x
         ASrnW5nwk272x9b1+nOz+054BdbyX8UyR1Y+axYSBzJ+tqSkIMJlWAGMPMfyJ0wRm4S/
         31GkgEviMtJ603+/CwfmRocoRIv/F9OsYHVDUQAC8H4Qm4PZg4++A/uq/r8lZTdS6fna
         w1z2xk3Rys7j1o6ktl9zEhxTsYLCuCmBCiBsVM5rd0K/LoTfIDYVAi0QyKF1Z+ko6lR2
         poXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553496; x=1755158296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkgUcN0etkmDxWZW74kDtO38nl/qqGRKhgYS9gb7Qoc=;
        b=YCE+5Xpbh41RplPhAAciAuFxmDeT1W8GBv3iThlZurTWbe3rpbHFLKhEJsQFKzp1VR
         wMMOx827E+m+VUa3RLAbLsAj06sc6e8OytiUhQtidMOvGjBrnMrIyvserzATmJMTMc1X
         kXKP0T3n2o34Eh/tIopRs5Zt+8hlAar0HVhcJKGOhRageWFmIRSNVE5iLYfWHUi/pk01
         GugiUgztOQcH4d1WgpRYRT4xWtlj/9pkaMeiqltuLPpy+aKuRw0AQqk2yhu8LXHcW4BT
         /xcizanm0L4mr76GRqsRz8vjkLOV4QXUnFrRoi13UGFYx2uF/xsL4XC3uuwnSCYEnO7X
         IFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtpqemJep/tXyYoQcRbjdO1VxDC/vcRSKl7+m8ZRg64ppeRoaQwzBRObTepqAs0eulrWYmP2qLn6gnxro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkQ8SRL80DHzpQxmVoNHUIqrG25X8SLNGaE3KPjuWN+4YH/zu
	eObqDpBhoTrRHjc/Ihu2b0fYHqLaPEWi1X1mYgE9Mdp2JnrdupCjnVtN
X-Gm-Gg: ASbGnctq8AjVaLvkKZ3DDYOcXh5fL5cEOepYjutyL2RzUxE552eSpXocTguSjKD5vbo
	h2K608DGlBvfBzgam0Z0Q2J82W6gzLxblUP27YlNJZeuWLD8FUpuWHbT2g+/ToIopRa39/cOC8j
	10phUosOn7RtbI5I3lQfMb+S3scl0jYjzgcsrdPqT2Wmmj62HvF3buTz5DgXZnk41HS8QSA3UoD
	lNGksifuUAN5fAOGejlbXMMK+yEAIy+SSR1dVDBy48iH+qKSKj9Em+pgQ7Au2Vip7D8GYggl9Oq
	JosiMebAaH4zPQVSa+Np3vX/z0X0ziZye3sXQdgXU3H/ElYsdNGv9+hwjAkLahFaxkXsGWzu9xb
	UQoJbdvkmUW0ymyeOtvP1OBQAt6Cg
X-Google-Smtp-Source: AGHT+IGOcjP64D4GBMntjoVTHbHQlu7XVmla/+hekZ0Qvmh6kQrGAI+YoPjVAMyHSPY9JesHz+A3Jg==
X-Received: by 2002:a05:6512:1591:b0:55b:8afb:e638 with SMTP id 2adb3069b0e04-55cb688b657mr632064e87.28.1754553495200;
        Thu, 07 Aug 2025 00:58:15 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:14 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 3/8] mm/vmalloc: Support non-blocking GFP flags in alloc_vmap_area()
Date: Thu,  7 Aug 2025 09:58:05 +0200
Message-Id: <20250807075810.358714-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..81b6d3bde719 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2017,6 +2017,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	unsigned long freed;
 	unsigned long addr;
 	unsigned int vn_id;
+	bool allow_block;
 	int purged = 0;
 	int ret;
 
@@ -2026,7 +2027,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
 
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
+		goto error;
+	}
 
 	va->va_start = addr;
 	va->va_end = addr + size;
@@ -2116,6 +2126,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
 				size, vstart, vend);
 
+error:
 	kmem_cache_free(vmap_area_cachep, va);
 	return ERR_PTR(-EBUSY);
 }
-- 
2.39.5


