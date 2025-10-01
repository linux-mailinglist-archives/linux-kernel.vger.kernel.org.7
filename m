Return-Path: <linux-kernel+bounces-839428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B19BB1983
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5794A08D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D83054C3;
	Wed,  1 Oct 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFg+pFuI"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D6303C8D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346821; cv=none; b=NNXOvMEdu6JFB1r9VEbGmyM5amjp0IwRduoQcZ52oPMKQf0h1VsFGQPtlFybZJfA2ZNJdDz/Wh1J7meSRzkfe5KcJVprwRM1nzZnSH6AvUVSQQDKS7f61d/ltg1NYDErqVZtuP36zuke0Xk+ZxTVnkuvLLP0fx4NLFYPVxbz8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346821; c=relaxed/simple;
	bh=5W64q7JqsQ31eJoMJDFs0Iex3EGFmVJC2o273KNKjFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgrgDdQkioQ3aBqfDIlaZio4lji3/a0NrU9ie9w7GJFEyh1vbsMw+Mkztx4miIdEgAUaQYt/vfX6KY2tMNMYv2YAh/ziKV1M+lOWoylzunZCbA2oeavxLzb/VJF0/KGiWBcDb/k9Jp1Ftl5DU7zn6D2uqhQHi2Twj75jZwUIuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFg+pFuI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso1969421e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346818; x=1759951618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGcXmCAAujJZjKkzb6sJy5VjUrvDSK+t0JgV9AfB/HU=;
        b=lFg+pFuIMtCRv7IdAWQjOZbVoH0noDbD8Li9DnktpxyPZScg5yraOTVBk96iX3rDFv
         KUluvM+Oc9NrNpJTkhxKngIHc0XhqEGNYS7roTl9/wSBOgx/yUhe7A65HjC4F75OONaA
         zmHlKw1c1vclVpdBTkKbFyxQqwWtZYci/trIQpJVBUar+dR4k5KHdyEWL7hCj1v29Bhe
         L7d8eRX1XpesHsdMNMEzlGnWtKCx2f7X+hKvwSvQQMkfftliIwAmtpmBS5SFx4F/11Z1
         jo+BqY+FrQ6Kz5TGz+rNU8InY46VonZWaOnNY6gLYiKrVZTtxixKhkNPS901Cmglrp9J
         fjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346818; x=1759951618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGcXmCAAujJZjKkzb6sJy5VjUrvDSK+t0JgV9AfB/HU=;
        b=KroO05qc8bQxQVTVHilL0Z1mpHjexESDsmdrfc2gYybRuq2M3x3JfsGufcgG3SbQJQ
         JJQUw9X/4GIA25O0FD0fr/UjIHqRroxl0hdsT2IVHSxe6AuKk+jxgAEpKQUuwDK+srDm
         8bJ3eQ5aGRWQhIZep79qxu+A2I6rGD4YOldUmTdO6ZsvfMqrxygap8b/+ttcGskSvkPi
         CcM6y3eZjEf9MfYaOWvu7IHXEiFzj27T9kDurb7iawBOQhAE7mSrSqDLwZKoKLh20AGj
         y6UkgexEU7pHLc05l15Um0IclPlWfsDpRePQ54xKzVMjtf3c971Ru5xzhx25qWqnylj/
         fOfw==
X-Forwarded-Encrypted: i=1; AJvYcCWwObB9EkQqD+CD90ePXbUzzXiBz5E2zgKY1pcpSdYL0B6qLy6M/WcvyRfDYhyFpdxBB3SAS3CsOgEZpzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWmIVWeZCpOZscaXZDY8tcmOZ8xsY3tjY6OyOFKmB5emOlZLR
	ZRDY758FplBRQD71vGXwOItcBWWoa/JOXjoBz6xbfkaN5nrvdsXv7Ki2HfcCACV3XD8=
X-Gm-Gg: ASbGnctaeXa8iX2w+3R7p0JdJOQxRrN9fjH6TlDDAeOw6rPWr6sBkc72/1Ds2kFqWIq
	Dm6SdN73bL3Zx6i98/5WX7CbxmOvoIAh97Sim/K9+4/nCPMOkI6g0lmQNaicmj0k9f33QK7vy68
	gxCSIqhSu9ReZ5lueBHeookSeeqGIV7MbgJUtKE5CNsmx+kAbKf7fz47QlJzhDEFPWsG9hEJDeN
	xr0iluIm3YcIJqatOMFEFgR0EK9o+5r2Z5dbMx2hLbFiPD8d8MurokfFLb3mlPKeHEWml8FJ1xI
	MGsc1SRhtBEGA/qCugESapATpRByvwg0G+m9/3cs2c6nSAa7PP1qfvUnxN/WAe6UojGMZ3JrKxd
	iBwsdc5K1aAGsotQyFTCuRehxVYOtXcmeU+de7xnd
X-Google-Smtp-Source: AGHT+IFj81R2vtq1WyCNBYlhGONs/CusB8poOp8hUY/5PYbf+QgHwaSgauT7SatCZSoEjPU1zHqd6A==
X-Received: by 2002:a05:6512:3da6:b0:585:1a9b:8b9a with SMTP id 2adb3069b0e04-58b00b5eb5cmr248354e87.9.1759346817420;
        Wed, 01 Oct 2025 12:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:56 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v3 10/10] mm: kvmalloc: Add non-blocking support for vmalloc
Date: Wed,  1 Oct 2025 21:26:46 +0200
Message-ID: <20251001192647.195204-11-urezki@gmail.com>
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

Extend __kvmalloc_node_noprof() to handle non-blocking GFP flags
(GFP_NOWAIT and GFP_ATOMIC). Previously such flags were rejected,
returning NULL. With this change:

- kvmalloc() can fall back to vmalloc() if non-blocking contexts;
- for non-blocking allocations the VM_ALLOW_HUGE_VMAP option is
  disabled, since the huge mapping path still contains might_sleep();
- documentation update to reflect that GFP_NOWAIT and GFP_ATOMIC
  are now supported.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slub.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 584a5ff1828b..3de0719e24e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7018,7 +7018,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
  * Uses kmalloc to get the memory but if the allocation fails then falls back
  * to the vmalloc allocator. Use kvfree for freeing the memory.
  *
- * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
+ * GFP_NOWAIT and GFP_ATOMIC are supported, the __GFP_NORETRY modifier is not.
  * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
  * preferable to the vmalloc fallback, due to visible performance drawbacks.
  *
@@ -7027,6 +7027,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
 void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 			     gfp_t flags, int node)
 {
+	bool allow_block;
 	void *ret;
 
 	/*
@@ -7039,16 +7040,22 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-	/* non-sleeping allocations are not supported by vmalloc */
-	if (!gfpflags_allow_blocking(flags))
-		return NULL;
-
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
 		return NULL;
 	}
 
+	/*
+	 * For non-blocking the VM_ALLOW_HUGE_VMAP is not used
+	 * because the huge-mapping path in vmalloc contains at
+	 * least one might_sleep() call.
+	 *
+	 * TODO: Revise huge-mapping path to support non-blocking
+	 * flags.
+	 */
+	allow_block = gfpflags_allow_blocking(flags);
+
 	/*
 	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
 	 * since the callers already cannot assume anything
@@ -7056,7 +7063,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
 	 * protection games.
 	 */
 	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
-			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+			flags, PAGE_KERNEL, allow_block ? VM_ALLOW_HUGE_VMAP:0,
 			node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(__kvmalloc_node_noprof);
-- 
2.47.3


