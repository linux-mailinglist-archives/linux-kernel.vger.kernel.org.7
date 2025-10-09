Return-Path: <linux-kernel+bounces-847114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E838ABC9E28
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B2D188DB2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59B2EBDFA;
	Thu,  9 Oct 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmIh6j6/"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065121CC4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025260; cv=none; b=CUL7i48YsQb/C0iUKLxdXgcNwf6C02wozh1ODuWb/Ic2wdBz+B89+rxOXNrb4PteB3SmHT9C+lsJ5LCFUvu88V9WBGErl3080jr/U4EVFRlRZG7Wp/sV7i7EV1r/NQMYj3wMw0mEG8+d94W9TO2zGcTJ59HVBNqCsL7wacOPB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025260; c=relaxed/simple;
	bh=YL5KR2gWXKKDOeSg1DoG1pqwjnEHg+EjdZmdVduK9Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acldb206B4AuOywGQqJAddJo0LZqr1e8T1r2y5lOpE22Ae3a2l7tckVW+LuKL2krm4NAIG6QrNpOn/qOWz6LbGj/QoMhh26PG+kCj9sPirLcBNb+OJrVNA5Orl3oGCQwc8z6vHPOWfbZp4TJ2q8S7kCmUkw2PzhY0TwS5Iw7HcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmIh6j6/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso13458451fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025257; x=1760630057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fCQnX2ZVKzE0uz1WnlkQnY2HwKIpXcbR9mszFR+OOY=;
        b=cmIh6j6/EnPScvBlYO9Gn+VObHc3EVNKYp9stknTE5c1dvK3GiXr64YHO3q7LZuPN6
         hU/sQHqPIdiMO0Nrw2D1X5n8Daa8/Up7hg8BVFGKVzXZe2sgnOgzm7v45uhg0BMiPrZd
         YFDM/iHwHj/LZHTvArATPnGgJh3Q5Jm2FbsIBAf/KlGKRcncTQIFQrYlXYHFPn4FwFUx
         /p/z8WCUNjvJ4+LADx0skvETVKcUMPxE/i5mgELY3pCYkVbiZxvyDQG2LuQRq/maKWjR
         drWluHpJGhE9MUP5lJmq5tnUdxWBtjz9Xd5st6Cl+ZkrArHCB773hPQXiblsFezy6Mrl
         hvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025257; x=1760630057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fCQnX2ZVKzE0uz1WnlkQnY2HwKIpXcbR9mszFR+OOY=;
        b=akwi2fPgIk1cNMeTARicTkQJCij/UZ6BfgYr19gu7id8qVuVKLM6DyZ7Mi86kPt9p6
         L1QnhfQeWjrtRe1rLPoxm/zaip7fndUsUEL4PrCxetKxMMqYntvyQeZDyJhMLZ4/FDEi
         2nnpLjvrVzHuspWTWzvPUjhO/pIDbR8P84Lfn1RiQnY1wOW8Q6X06I84YIUdgM2vDntu
         NiKTwt7448igkdabzsm3U4I0MBvCNJV3+YNRfiFoc0XOIdXHJ8l7CgYaikMVp4lBeeOB
         1DxSJDdB0dSMwW6fvrfBQFEv2ioFa4y2lxoSCmR+PD3wH4X5NKRPfvQ2701YP3+FKHD0
         T+yg==
X-Forwarded-Encrypted: i=1; AJvYcCUaymDfyn4n4znY+3H5m8QwhvflWGwQXeu6AM4UFDaSAB5tjCW69Jwn+UBR749fKQEs2rZU2oysfVtyV8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UwhMsn1V+Hv5qO4p1l+3z/Pmhjungi7jAH21G73Z4zIHMiyt
	CBuXb/NecdY0lUw52q2uoLxvtLkrRHwQ49oOxbLp/4KqGzF6XZrhXimU
X-Gm-Gg: ASbGncv3uSWBhkjQvdqeorTepXoScfvjgAQOalO1CEEfdFBCTXW2hBM/nfAWCN0kCAi
	MDK/jVPFXRjtvBUQ2lYw9EUDg3pkPwDamgIiu+y9uIbe9boGMRe+cQTKdrqnTiu44WAULJYa41c
	oinjNPKD/7woM0SLLcSajGQjOWtjzDDyCUoaRJ3SQ35iDe1U/t9JHmC+UTB4tOC0KCcQQM5QmMN
	IYiv1gOH+2VMTU4m5BNWLN3Z51RScL1JvWRiEqbtZe7N1evnID2RAvrPhZmmYEl0AV4DCwXJV4S
	KyDv7VaUGM7oyKrJJAtJdp+nI1OAxwmMtF4S/6B7Z6S7LSlGdU1POPtkWLdwiJ6Z2AuFxlQuqT8
	1IfeflT+8Yt76nHjjLkvd3RWnTMc3KKEzpLxY5uBHF2Z47QZd6f0gc5/NQ9TktKRa6WUcZAzP8o
	HSN9ll7Lnc
X-Google-Smtp-Source: AGHT+IG5zD/iaWcaQEpSQxQ0CS24v+eDZidfw5pMSXEN19I74TQY1ivV+1T/jtwqPwPDcSEDgzcY8Q==
X-Received: by 2002:a05:651c:1509:b0:336:d0f8:5a7a with SMTP id 38308e7fff4ca-3760a2f9e1dmr20889251fa.6.1760025256534;
        Thu, 09 Oct 2025 08:54:16 -0700 (PDT)
Received: from fedora (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-375f3bcd2a8sm29499831fa.55.2025.10.09.08.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:54:16 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	bhe@redhat.com
Cc: christophe.leroy@csgroup.eu,
	ritesh.list@gmail.com,
	snovitoll@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] kasan: remove __kasan_save_free_info wrapper
Date: Thu,  9 Oct 2025 20:54:02 +0500
Message-ID: <20251009155403.1379150-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155403.1379150-1-snovitoll@gmail.com>
References: <20251009155403.1379150-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need a kasan_enabled() check in
kasan_save_free_info() at all. Both the higher level paths
(kasan_slab_free and kasan_mempool_poison_object) already contain this
check. Therefore, remove the __wrapper.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Fixes: 1e338f4d99e6 ("kasan: introduce ARCH_DEFER_KASAN and unify static key across modes")
---
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 7 +------
 mm/kasan/tags.c    | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index b413c46b3e0..516b49accc4 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -573,7 +573,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	kasan_save_track(&alloc_meta->alloc_track, flags);
 }
 
-void __kasan_save_free_info(struct kmem_cache *cache, void *object)
+void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	struct kasan_free_meta *free_meta;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 07fa7375a84..fc9169a5476 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -399,12 +399,7 @@ void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack);
 void kasan_save_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 
-void __kasan_save_free_info(struct kmem_cache *cache, void *object);
-static inline void kasan_save_free_info(struct kmem_cache *cache, void *object)
-{
-	if (kasan_enabled())
-		__kasan_save_free_info(cache, object);
-}
+void kasan_save_free_info(struct kmem_cache *cache, void *object);
 
 #ifdef CONFIG_KASAN_GENERIC
 bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index b9f31293622..d65d48b85f9 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -142,7 +142,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	save_stack_info(cache, object, flags, false);
 }
 
-void __kasan_save_free_info(struct kmem_cache *cache, void *object)
+void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	save_stack_info(cache, object, 0, true);
 }
-- 
2.34.1


