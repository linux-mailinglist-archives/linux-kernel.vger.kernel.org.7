Return-Path: <linux-kernel+bounces-878695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E34C21484
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C14F1474
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4982E339B;
	Thu, 30 Oct 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWyfVhLr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A352366FCA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842629; cv=none; b=do139bvM3fULMvmRSsLeyRedtXgFeL5T8raRLU0oU7haMzP5F68PY/ElXH5zEbZzn6TV/yBbiRJmo+jV2KI6gG3UmmgWEX7yZ7mLm2gHjk5SApuwLP5yHLd79RdFJw008j6CTn1eGE9dlQ0PldkZKqDxSeSbKGHPseJB85Ww4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842629; c=relaxed/simple;
	bh=zTk2sbUca83YGGftMUsV6r3EJVD2vTBgPrBfhyGOki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O38zRK2jsxNEeDMGckxCIKjF/xaIe61l1sAe4EqfczNV/8g6vWnFP08QgZosJ1NI2NaNDoNYXBAkQhbdCULx7rxXTOgvbu3cM1nmWp/4Cd9+yn1BnRJHq7PhImA9oitVrbbT8vh/Nmw11h1Ha1ILB2q4+kN/8+Hoet4B1J3gIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWyfVhLr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so8242025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842626; x=1762447426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=103xEl/pexX8xypusx6RhvZj5X/kVNtPLhx7E2RNbUU=;
        b=DWyfVhLrq41zjkxOnraPIt6/4Xp0VNAdUwX1yuRMAw3Kj+9FdbRl58ssVc6Jze/G2j
         9qH6MmAiI5P+cNeOv5U5xUN8PBMDYAIPbeAMdQoqLpEFjsZ84Esx0XMS/RuwLjdAP2xO
         tgB9Ww0wOi40k/C7K/WIVD5bsJuoCCHYPlIXqQb1+nwQeJ1Q7B72Xnm1xc9u8ZGUU8oG
         iCuzlKL1OYgHhxZHyfDapLB4IMk/TpHTzmTDq44SqAV2/4k+KXKhHLqu61htOAxziXrj
         gNUHaWAGIUVBN6LpbuVdTsVwV1n8+7QHN2wsflzKE3udCxu3LWzsbsmX7ZwSxc1I/Js4
         1Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842626; x=1762447426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=103xEl/pexX8xypusx6RhvZj5X/kVNtPLhx7E2RNbUU=;
        b=RoTC6k2grqKJKenLjD++VYSgipuS+K+YRQ9vDdRPHXPTGee8Hz3t9zN20nPj3eyCqX
         X+fK/XiBdIo8bpE8BIaD3diC6genAGfJNlkChTs3iTE2QuZoIfO4J5SZEKpLz8Z/4mbk
         6ZQdWze2a7fGwFoKqX2qNKlXr8uyy70htDDXWMC4qv7sG/pnRdlIx5TMuO9uU2mJIYyN
         MpSLHO7ALxUnflqqueI3VxI0XfbwG+4Y67A9Oct2HUEN49rds1KlcyPw1ZpdH78MkGiu
         w72XrAE9N+szqtX6hsQ+8p6IExUWxg6eQm4RTD0X7qQlquYU19zYgFnpWpc20zsoKoga
         MFLw==
X-Gm-Message-State: AOJu0Yyo6UinicWQw39HJCmLyAiXR88ADoPDq0fpi+0IX3cvGOpaAfzi
	GawBLpFdOyEN4ZxfGnTWn33mC6qJ0ZriIVbcysjGTaQE8Wg5Nlpi8WTaMc/l0IcRQ20=
X-Gm-Gg: ASbGncsYRKCgjzUnybqIAdRfnv9WlVHKU5K9oODGXly0USRWZUI5NZsTiJo7XqiGnb1
	d1rxxtBGScnjBmbSI1MDFM8T/gl1kpVyi5o6hIq9zx18Ibiqjh/+aNBFVtcUh2/t87s7BjbWg2a
	0snaKrJ+o8yIuD9aTThNerys6WIgKB7MggWIW0dWNqZH0UKLtM4F2HntiYtXG34eXTMfMyoImnP
	Q7syZZCz9YYXWQd46Kgk1mAZoMcHf/3Jy7S920RU2+v5l8V4O9Qbmiyw/6098iDFhodXdQW7CzW
	+dvZEA3/B/tJ8oA4qPxF8SLqw9nZqKtR3GKQsFd/v4b8Ux+byDpUGseVYN/z0tyPLMrqxEHCmGb
	xhW4pa7500n0T6TB54FS7fmkPhBpvKmMVXp6ifr+1X81hXTJ6552QN8kqn8vJoPBqc5LM4IZ4PQ
	gckm7qwduF/Isu0zcnOBM8HdAFuJfRkTzKYB0hqtHE0z9UQAgYRgs=
X-Google-Smtp-Source: AGHT+IGv9V6jKOeGhub1sfwVcOG64zM8D6Y6u1YJdObQiDL7PyVDiQwFi7I9EwmD+aig4nvikK+6Yw==
X-Received: by 2002:a05:600c:4695:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-477308be7b3mr4313525e9.29.1761842625899;
        Thu, 30 Oct 2025 09:43:45 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm36796839f8f.45.2025.10.30.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:43:45 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Thu, 30 Oct 2025 09:43:30 -0700
Message-ID: <20251030164330.44995-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030164330.44995-1-vishal.moola@gmail.com>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8ad0451a7bd7..0259cf59e6a2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


