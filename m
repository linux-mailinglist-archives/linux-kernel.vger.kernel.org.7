Return-Path: <linux-kernel+bounces-851109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F27BD5906
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2A3A92E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127933081B2;
	Mon, 13 Oct 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hotYCoAM"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1E19CCF5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377348; cv=none; b=HxPXHYGnVXB1e0QA0Oqy76GEQCVygtGTkQJAGIWT37ZStsoTRjAzXlGgq3UcDRCdFCT9kQL3Z7QsENRA3Mkxlf2ZXAdWhNKbnkry0CtDpGqKP6AzGGZ7O5Y1gdFvY9HlCNvABwumlayQD/I5qryyYBeWyjUBTcNMDiuw7afosk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377348; c=relaxed/simple;
	bh=aaJrfOD4VVGWTp2fLfv7HESXSnsd73PpK1DLU4oysK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Entb/kwDh63T7jZ2uJWCqubPRxko6lgVt2J3S+zFGXf5rdmTl2t0w+u+GGKtdmdHCeb9EIqI2SEd87rpx6bT6895hslxYVAwmBbtfvEijA6/ixYo5CNwK6MmnjNESNOQ0wbgGiyuH36b3ZQ+O822dxrX5QRWoH1M3ybk+wW8YQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hotYCoAM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so4519194e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760377345; x=1760982145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMykzJJayvn6YeEpKV9Q3LgMXzXdoUHGdFnIA0ikh+A=;
        b=hotYCoAMOXS5MU/a5He0Sk1MaDFKz5pd0clOHEhumytI8UmmPErdA6QiVNNcPtMMA/
         0Vx2P/w22ZIL6iDLHJzUJpOzCjJkJoBSJLd61P4rZnTcCIsTPLeYbUMoM50fEs+2VEir
         CbfzzUn5DsvUFMm1MybZRluM4FGGvsIIeMjE42ooJIPSxfrsMjeFZ7CBg4jNV6Nx2f+C
         daNwTmvCiLqTA3KExvQIwy09Gpzrg6Md4M/abGOd/+pX/YyM8Eq4Ww2+nHgBRAwaQPq3
         3kfTACbBhL+snERdyAXpv6OtMz1COKrqm5jIzUDYIFVdrcHpUVh/tMEGFutpvJGhC2cf
         oFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377345; x=1760982145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMykzJJayvn6YeEpKV9Q3LgMXzXdoUHGdFnIA0ikh+A=;
        b=M5QA8tGkE0L2WFPUH6Qrvnt+vQyiJeus65qPxT31VskX2zl9Tk6dAmIZX2EAsbx7o6
         Sfi034VyjLZZ6DlEYlFtHYzVOsfF2jKfFDvLjAeihCC2kCTIx/UrqFb+xo31w1/wjFpY
         80op+2aia4MsqZjKJsXxygbXtCcs+2wwYZFMQlaCdD2EyyB8YgMgb0Fw4WkEI3Ap0QgW
         JwGagnzZQyuCyp+7y10svJ2UQk9Csc1w/7IJrlw1WYn5nqvKPCQv0HCSIojhFX6YXOD2
         5mcRiU0u+xsOc1nN8gPQssehxiiqIvIjl8LBkSSxVg2xN6uuuqFzovPpAvTIH0Ivff4O
         IOYg==
X-Forwarded-Encrypted: i=1; AJvYcCV7oTwOIVvIHzGlilbMpQc5/GOY1xZWaSx916n4mwLudxnuAiZD0JOyzpyrFMQGkSUfq0Na3dNxWDi/1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHLMeOL7koW1M/K6s2aD/40Be8dcCxp/btQXm43hZmrBW/mCR
	UjAK+98FuOXSFzrbxMcdlEfxuajWlLAJW94LyfKl8v+K92UYloXeahxL
X-Gm-Gg: ASbGncvxAGG2W9VFWaVL3J3xM7H+hjsVEoQLRUQv4zDOt5oC/RRJOjgjUVoryGS/t+/
	e2q6IaHjmFuFBG8cCOBsYcO8inadicK8BtzC5kjbGqSrnNaqIyCbBOhtwk8djchpJEK0kxnCQY9
	viE0OMdL/u8fpI9+wIpzNtdVDeUzIZ+XOP6kZXwO8JVRPqa/F7TgzeHS7lT9929uawHWgjny8XL
	iqfz1IaiS9xeqGoSua987JDjrmireYg3JF+kP4ITpXGIs8MP1y3c7HYYt3GF3t3Aja4rMvvWvNb
	X54vFNpml4pugTVXz4u+DJc8/887q9xRWGjdI0lToNcNI/bMqkdkC7njR3QnC+GH8w7nectnRk8
	TsI/8PQ2/Mv9qI9UTwsDPnThum4XJS/SZ9xhaEEZJZSVaDw==
X-Google-Smtp-Source: AGHT+IHW/Y/7efeNDjninFHG1sZiCXUgN1QMIuHHkc8N9haI/EiByB0KPd+AScoYy9IdrEiFHiC1LA==
X-Received: by 2002:a05:6512:b10:b0:577:9ee:7d57 with SMTP id 2adb3069b0e04-5906de88ee4mr5720691e87.46.1760377344510;
        Mon, 13 Oct 2025 10:42:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088584812sm4313857e87.122.2025.10.13.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:42:23 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] vmalloc: Update __vmalloc_node_noprof() documentation
Date: Mon, 13 Oct 2025 19:42:22 +0200
Message-ID: <20251013174222.90123-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for the __vmalloc_node_noprof() incorrectly states
that __GFP_NOFAIL reclaim modifier is not supported. In fact it has
been supported since commit 9376130c390a ("mm/vmalloc: add support
for __GFP_NOFAIL").

To avoid duplication and future drift, point this helper's doc to
__vmalloc_node_range_noprof() for details and the full description.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9a63c91c6150..c31fa69cc530 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4027,11 +4027,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
  * Allocate enough pages to cover @size from the page level allocator with
  * @gfp_mask flags.  Map them into contiguous kernel virtual space.
  *
- * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
- * and __GFP_NOFAIL are not supported
- *
- * Any use of gfp flags outside of GFP_KERNEL should be consulted
- * with mm people.
+ * Semantics of @gfp_mask(including reclaim/retry modifiers such as
+ * __GFP_NOFAIL) are the same as in __vmalloc_node_range_noprof().
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-- 
2.47.3


