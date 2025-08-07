Return-Path: <linux-kernel+bounces-758788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F61B1D3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E441718EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305C2E36EC;
	Thu,  7 Aug 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlQq0xq+"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B254244679
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553501; cv=none; b=KXFUSwCIbJPoRsgI3/LjHnvC4zRecF8sYvjb8DBTlkCdheXgBbgB7PhZYDZ7bkkjFQkzJ3sbqk9zcHwidPtkspy+S3XmKQWY6RTGv6Jo7V97UxMhZ9NUzEshHKQndlpLfUzjXQCZbcKQ/EFc73S7hVuHY89tnWtHiPsVDEXAsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553501; c=relaxed/simple;
	bh=StcpdyJ1gYyaSLGPjjN463sNq0rkXv8qZ4VH/a76lW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhY29qmn9zk96pbnF7CmQRsK04hdaTROs84YyYbwgicUd+hOF7nWZOyIfzMzLPRahKyiDp+R5NXK28PGh0cDD5rYZEFTUfhg2i85NeAUAzM5QwH+z1L8TGoGqrM2pG1Jg8SumSNpd1dBUXFm0H/Vfk586Dz9Gdm0MMiyldPItSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlQq0xq+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b96b154bdso727745e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553496; x=1755158296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KydXFGAE7W4DpoPvcZ+Z0Di5zFlR75RWumBb0izMzE4=;
        b=PlQq0xq+4te2m17AsPfQIamGRDCeUNCs2Ubdif8b8PlkHdNxpymWY/2GoJkUl5diw3
         Q1G4qt0Emz5+9Son5l4/66q37ox2cxms2nlgrJljmKxJrFCkLlbHNsBjGkS5QvuxB+Ww
         2bxe21NGuvSkWvcIqzkERerPho5aVmQYxshYJJhKiMG87S2Wszjz2KZFDl55vRfKJJa1
         6j5PsP9/jiRn0m8jgG9WLDqcgSeo6DfwaRQpHyh8PPqVQmyLfLe+atnLfdlga2ZDyZiv
         7sf21MM+pUA79+QK6Zx3susv2VIRGGzwit3h0Yu3uFk5V8pakE0LMCvnSo9iv6cjrY3/
         KVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553496; x=1755158296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KydXFGAE7W4DpoPvcZ+Z0Di5zFlR75RWumBb0izMzE4=;
        b=myjqpnx/GkSJ2mkQTpDW0TWgmLyAV3dEhHMqDffG4fH/Z8Hdm3xkWjURZ+vdSGdhQX
         3rJ6k04BkFk/g/k/1tGuz6SlrVpHwKdf2Vl/csur5kmhRZwfcvLNbJgoPSpcRaEvAKeB
         cbInRlgqFVQbzSCZn+vgJr5VpAWvxgQCIsjP/zWQCn0UtvH/1cdmfvLjib71Z+2P9qEd
         e45Q0BLBk369/zuMibxduPgB2AEHO7ZuLkMp50/wwI0lSVqsKtnf0z0ud0OsXYQ3DX1c
         37+QEwmnKhAbzJnxuesPn5IZWrfaWONWe9TwBgwrJTPu2+x7gUFvsaDs4ku2aUXIxaor
         C//A==
X-Forwarded-Encrypted: i=1; AJvYcCWMkw0MYxWqW1qsUqiZUR2Qg7ErWL5mY4jHsLnq82ep7/wwEBz91eG9OavJicxqnIOowlXqmZRVWUHIfnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRHCyKn02TK26oPMfQcYaKdOGlbdVD28b3byHVuJWw8f/1y7n
	aCNux3/SvKHbuFxUSw6giVg+HYo2wQ+/gOCiGqL/oy0O9QPdN67h8rE5
X-Gm-Gg: ASbGncv4KSUUjtVi1O6EfmeqadDSMH6VTvA0eRuit1w0D/j5vHMt+G9u+bBWjy37zwx
	/ALd1PC9mR3TF610TeSWPr3EofsjQEunJWp7t8iWcAyRm9sUds+bwhiKxZFFPZedlHFvLyH3khF
	ZueBExAoti5wIN07WWazLnsRrSRnyEXvxV4xYgruIa7b7IEZDKp3uy/6pRCQB4Ji2Vym7MMKP9f
	WOmGAonPGk8zUlmANd+M20asYbmi9DbxUdhRNAsnRWwTJl7+KXta6OHxTz49Ra41NVGH759eNBO
	N1WgaW+VllYLAvTORDd2PS3cjO3BIqm4Dbq+l/AWCLBEaXlpi4Y8dbETX7G2tlEVMjTVS8lXIGB
	phrrqn6wvyun3HF7HCX3HVYO6RaPw
X-Google-Smtp-Source: AGHT+IF0q6rKChZ6oen9fNvbhVWsws8Z8fn91x3v64lQHUln2uy58X56NwoWxrXywEBePWrOTHfQTQ==
X-Received: by 2002:a05:6512:3da8:b0:55b:81cb:9e5d with SMTP id 2adb3069b0e04-55caf3f37fcmr1726894e87.52.1754553496035;
        Thu, 07 Aug 2025 00:58:16 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:15 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 4/8] mm/vmalloc: Remove cond_resched() in vm_area_alloc_pages()
Date: Thu,  7 Aug 2025 09:58:06 +0200
Message-Id: <20250807075810.358714-5-urezki@gmail.com>
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

The vm_area_alloc_pages() function uses cond_resched() to yield the
CPU during potentially long-running loops. However, these loops are
not considered long-running under normal conditions. In non-blocking
contexts, calling cond_resched() is inappropriate also.

Remove these calls to ensure correctness for blocking/non-blocking
contexts. This also simplifies the code path. In fact, a slow path
of page allocator already includes reschedule points to mitigate
latency.

This patch was tested for !CONFIG_PREEMPT kernel and with large
allocation chunks(~1GB), without triggering any "BUG: soft lockup"
warnings.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 81b6d3bde719..b0255e0c74b3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3633,7 +3633,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							pages + nr_allocated);
 
 			nr_allocated += nr;
-			cond_resched();
 
 			/*
 			 * If zero or pages were obtained partly,
@@ -3675,7 +3674,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		for (i = 0; i < (1U << order); i++)
 			pages[nr_allocated + i] = page + i;
 
-		cond_resched();
 		nr_allocated += 1U << order;
 	}
 
-- 
2.39.5


