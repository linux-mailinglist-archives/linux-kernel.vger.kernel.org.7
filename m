Return-Path: <linux-kernel+bounces-844240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689CBC15B5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613944F5641
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A642E0B68;
	Tue,  7 Oct 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoTF9xBz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D252E0419
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839653; cv=none; b=arkgvO0WORBcnKEgV3uulG2vc4gVagkzkaDVvdNFJEAo50Id6iA8FTNe2UaBWeSesyE8RSGkPq2o3eQH2qKChZLRy81Nzt9j3T6udUCuz99AEegI/5chPa712zJd+5HJl7FkBVIjrGgJQ0gJP11XrYAnJnDdjDFqdC+++e1YSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839653; c=relaxed/simple;
	bh=9old03yzUQ3erpbW11QQhj3dq0A53A24gdFeeqB4raA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYsEtyorWQ1XrEUp7MZY0Tp/UdpE92NZ71hamMoJdTeSKyffRDppR/2GF+eJ+abCDt2ia86z5IEgTa9MU3QEg5MLIBZWkxHKAD/NPJsQqRjevdGuEUpX7CjVvwAccy2u9N2bMg6QARI3WMNNM52mgVuKiKUSWSDSs3lK7Avr4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoTF9xBz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso8183484e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839650; x=1760444450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLik2R41JKKg66R9u/7D437C5tFPGxIDYan0Bcp5bSc=;
        b=NoTF9xBzfOd7ou9w3OcTCuJVYNRHQMEvgRLmtalS5JSmOFRpDdoHibMm2ukQQ6BH1f
         QQFq5nrtLJCosNPhftMOjQ00CbPaILi+nLDVGBv9/R0Ki+Oy0ivTk1jhwBN8mLz8l5hZ
         hHpjBUrs2vJtokvQ03V7Q+/KINLyOt30N/9dnG3WXkKPsXl3D/SnB/0WoctZJuHJ5h+X
         qtS+sVW5oyBpCK8ZY/bCTwD6cja0yyYx4T55vuCZBKZIRKjHFVo3x3qu2/od7SnpxZhH
         m1T9cyZTSahn4hDqxQ3tpL5edgK3Z+iaVUs48I3QFGL57IFoQcCRYw1MGng6BwZSnXuE
         FqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839650; x=1760444450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLik2R41JKKg66R9u/7D437C5tFPGxIDYan0Bcp5bSc=;
        b=tOZ70nzyPX7id+d4EUeO7vV6uitA0Eacqt4XGzxeUBBOn7dgKK+axqK/8Uok9OptWC
         AVYQRyo28F6E34vK/eJV6amGOhLQuPjcaFuqYdSMBnzZzy/l+vNWBSujywnI0sdL34+e
         INr5Bi/TycBM42QW92lG+vxYfOO+Qb7feoCb1YIu+O8TX3LIWAteq5AfgNRi4hKgv5Rj
         X86kqHMwo1/YHYvF505YjRzsEH9lYEo7HPzdPWbksEu3+JaYJXNxRmEiuERAN3uXI4tM
         u++gbNefJ77RLSod9+bpSziBhfJHDfEZCDBcBsc1IQyI51xBs9oJHedKdrdk1+l1ZV8U
         RhrA==
X-Forwarded-Encrypted: i=1; AJvYcCUk6g9x/u580H2+pYiRkbl5PYL+YhiSaEhovVg4HwxuVtHfqtB6T4kZ6ih75MMv0vOTYlKhVgUZ5ALwArw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ilPTtJSH6Awn6pQembaeMIuYqjX2V1iiOlUR+PZZ6iINdx1u
	4Y/5G+IhlumvGKkectGiBKZiLW9hn+bnXYbZ/UpO83zG5T+UhZJQ5F74
X-Gm-Gg: ASbGncvbt7y2+y1K+B+3ET+qLny1MbP8ZYgj5/W/p8YR8Z6qSCR+ZmPPomJB4Iqsg5q
	SGiGAVUiNeLYZgr9AQJBNFxzzXwbRNOSnKsjEQ0lqaUKUnzu5i+Jf4IjJJp2rjOwA5Z3PWsMGPn
	nFh+yQxAAV9mqXntkDohP1XbF96XLsWuHr0la1Aa4+YDZ9UG6hUCQnFHwoERK7yELxf0+emFycv
	pIfCITMp2LLfBWRMNnIm1qLiXpSXw8ksNUQINO9QoMOarB44D/1TJ2FPffcMfYGVzmm2NqTy+n6
	DGw9SFZr5NT+C+OfBnaQlkI7BhxI9SjDZ/wKz/dwO/6KYGobhwi2aWkhs6qNDhM5Z7LL2aKydCJ
	h0P4ENxWKPkMEYtn/vLV3eY7VmHNF/j4ZZvBGL3Hi
X-Google-Smtp-Source: AGHT+IHa1fO8cLLeRNsClbO4Do0jlv/6LzDieia1Qj8zuoJTvM9U/A0btWcUHfi7JFPOE+OrJ7f71g==
X-Received: by 2002:a05:6512:3a92:b0:586:2e4b:22c5 with SMTP id 2adb3069b0e04-58cbbfc331dmr4623770e87.56.1759839649666;
        Tue, 07 Oct 2025 05:20:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:48 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 09/10] mm/vmalloc: Update __vmalloc_node_range() documentation
Date: Tue,  7 Oct 2025 14:20:34 +0200
Message-ID: <20251007122035.56347-10-urezki@gmail.com>
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

__vmalloc() function now supports non-blocking flags such as
GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d7e7049e01f8..9a63c91c6150 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  * @caller:		  caller's return address
  *
  * Allocate enough pages to cover @size from the page level
- * allocator with @gfp_mask flags. Please note that the full set of gfp
- * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
- * supported.
- * Zone modifiers are not supported. From the reclaim modifiers
- * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
- * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
- * __GFP_RETRY_MAYFAIL are not supported).
+ * allocator with @gfp_mask flags and map them into contiguous
+ * virtual range with protection @prot.
  *
- * __GFP_NOWARN can be used to suppress failures messages.
+ * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
+ * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
+ * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
+ * by __vmalloc().
  *
- * Map them into contiguous kernel virtual space, using a pagetable
- * protection of @prot.
+ * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
+ * and %__GFP_RETRY_MAYFAIL are not supported.
  *
+ * %__GFP_NOWARN can be used to suppress failure messages.
+ *
+ * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
  */
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
-- 
2.47.3


