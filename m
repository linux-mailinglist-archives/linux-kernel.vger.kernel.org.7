Return-Path: <linux-kernel+bounces-752477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA2B17605
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45C218C38E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09028DEE4;
	Thu, 31 Jul 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZfdIelj2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30B4689
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985694; cv=none; b=sTYfgvFZGQRyHvSE+zTcFgA6oifgT6aZq2vJ1UQBW5KB93oEKGPVQTkT5akuahJVAs9yMygFghXG2AnuTDOHrila4rkSGu5tFug6JrjKzvezELhm38DyBHtcumM4hm0uUY3KpT7OKwPQBfBE14Q1ilvvWEUmalNOAlg8JwxYW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985694; c=relaxed/simple;
	bh=DCNWHVRu9GsBD957OEULXbmCa3LGIolYw64ampkBeAM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tIfpyGYotafzV8b8JVPHvTs+4JUpsCYdatQX7O+GVHn3BFFblt8968gQm+miKksvyTwQW9YIuE7kE4w4tUq89FciUzp4+0gmtT1pvDE5Vo2pVnOsG2anpGYOgBX13ehW96AsGuxZXsaEnFBJDbF2M1SyCwFnAAFNBaJQaG0VQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZfdIelj2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b792b0b829so2388f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753985689; x=1754590489; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIqzai1S5uHb7ftn+Ac80FEw0yXaIMJIHXMVatWhvgs=;
        b=ZfdIelj2tHBOZrg7TIBwLTJVgt5HJS8c0h3eMyY4q4YIyDcton6aF8zKGLM4DCrHGM
         VSKUDmyTH3TJjd9yrLU0hOy3gUXVxzvErfePXq+LtySZjMG+MUuJ8RdroUznG245iJGT
         qqtcMD6Q+/5TXPHcDyzQxqY9ylGAArHfn5xuIMxxhKNtH0THUREtG6gHoDA2ThK6AbS8
         JAr6VKJaUj/oxRlIe+7J3YeZD3FvuwIBZThR/8bKNk1OZ85NnKGOk9Z78sxU94kqoI3G
         L6cSRo0cY9/VTirVli2mWr7e7A4R8VsxQ89hDMjIbLMM+cXPwTx3Ay6/nwIJ5zAJ/w/F
         I3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985689; x=1754590489;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZIqzai1S5uHb7ftn+Ac80FEw0yXaIMJIHXMVatWhvgs=;
        b=Y9oDT2FCXwhI/mZu3L4AYl7lLMSAVy9FPRwiaDWOaMuLEN8svUsDzG54UFuASiey/7
         HOrnEK7iJpZT9GM8FCAYzWYCOzF9nSr4VEY9L26CNQzK/pEHZEv+YMNZGXBG/4EnnbiX
         N7Ypm7+5A18r5muFJudK0t1XYyh446QNy7xKSHh1oUdshtCeHwjp8lP8ho8jX7naXSKt
         qptomSD1Br9ICRsrtwGuN1mGm3VPn/addaWCAQKPoqJQZr9SgV5AG4Pcu9rDImLV7lRP
         VAWeDBt/HlsRwI8NEWve46PSb+DAFLkVO5ExutWSND2OX7aknCeLCD5i1VW7HivzDyc4
         nVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjGX4aDbi4Y8ApWGBIVYRRbDB9MxWB9/KyBFEG+D3fOyQP0kDOaYISGgDbO/et/Rg0qyevmq9z04m3CAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgbU64+fGyDUHYMzaBXyI6OOw340uwFsLvj8VepklKIYDG2wz
	aAC+5A6tGz62UMN7PEfHmf+X5uW+hZ2q4AkkqHbrgzlHHLAkBlP30Md09pCWWw0DRt+ITCX6Qns
	YHD09GQklDjSU
X-Gm-Gg: ASbGnctqZjdPs5f06bplowiSTD/rdWrU1yYpDJH3aBZ5/Ecqx5KSRi9zLp0hXk+PNSf
	jxJs8Bnj271Bwtdschl5fMx8D9wZgqeoC0sWw/HJJiSkzP7IAKKgHSFHMeod/1R7w01CPy5wERZ
	oj67ZzqK/lAUberO6YkOMocBdVKeefYqOLGoqn/lT3XkG+q+887QudOgD7/9ajSJcf3NB8ViEhs
	hDA56khSIyyWvaEMGRHLIBfHWZlM/5I1FetzxYoqcThyLCKBDszbpfFMnQJ0t7r9Qot/fccwe5Y
	VHntQRlQKmuy042rPLigg5P2ZMDksAfXngPw6f1mtam3kincQBx8ejcLNXlwaBrOcAs4LjiPEwy
	nTTpszIPEovW7C2BD57Q=
X-Google-Smtp-Source: AGHT+IFeofDn7ogmwOU3MtfiWHhybEkCJ88/7m6CVUsHaJvOILW/zxTP69inhurY03UjuZHfi/YP0Q==
X-Received: by 2002:a05:6000:25c8:b0:3b7:9c35:bb7 with SMTP id ffacd0b85a97d-3b79c351143mr2995476f8f.46.1753985689387;
        Thu, 31 Jul 2025 11:14:49 -0700 (PDT)
Received: from [10.211.55.30] ([103.172.41.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe8f90sm2192921b3a.127.2025.07.31.11.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:14:48 -0700 (PDT)
Message-ID: <e01f00f3-58d9-4ca7-af54-bfa42fec9527@suse.com>
Date: Fri, 1 Aug 2025 02:14:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Yadan Fan <ydfan@suse.com>
Subject: [PATCH mm-stable] mm: mempool: fix crash in mempool_free() for
 zero-minimum pools
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The mempool wake-up fix introduced in commit a5867a218d7c ("mm: mempool:
fix wake-up edge case bug for zero-minimum pools") inlined the
add_element() logic in mempool_free() to return the element to the
zero-minimum pool:

pool->elements[pool->curr_nr++] = element;

This causes crash, because mempool_init_node() does not initialize with
real allocation for zero-minimum pool, it only returns ZERO_SIZE_PTR to
the elements array which is unable to be dereferenced, and the
pre-allocation of this array never happened since the while test:

while (pool->curr_nr < pool->min_nr)

can never be satisfied as min_nr is zero, so the pool does not actually
reserve any buffer, the only way so far is to call alloc_fn() to get
buffer from SLUB, but if the memory is under high pressure the alloc_fn()
could never get any buffer, the waiting thread would be in an indefinite
loop of wake-sleep in a period until there is free memory to get.

This patch changes mempool_init_node() to allocate 1 element for the
elements array of zero-minimum pool, so that the pool will have reserved
buffer to use.  This will fix the crash issue and let the waiting thread
can get the reserved element when alloc_fn() failed to get buffer under
high memory pressure.

Also modified add_element() to support zero-minimum pool with
simplifying codes of zero-minimum handling in mempool_free().

Fixes: a5867a218d7c ("mm: mempool: fix wake-up edge case bug for zero-minimum pools")

Signed-off-by: Yadan Fan <ydfan@suse.com>
---
 mm/mempool.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 204a216b6418..1c38e873e546 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -136,7 +136,7 @@ static void kasan_unpoison_element(mempool_t *pool, void *element)
 
 static __always_inline void add_element(mempool_t *pool, void *element)
 {
-	BUG_ON(pool->curr_nr >= pool->min_nr);
+	BUG_ON(pool->min_nr != 0 && pool->curr_nr >= pool->min_nr);
 	poison_element(pool, element);
 	if (kasan_poison_element(pool, element))
 		pool->elements[pool->curr_nr++] = element;
@@ -202,16 +202,20 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 	pool->alloc	= alloc_fn;
 	pool->free	= free_fn;
 	init_waitqueue_head(&pool->wait);
-
-	pool->elements = kmalloc_array_node(min_nr, sizeof(void *),
+	/*
+	 * max() used here to ensure storage for at least 1 element to support
+	 * zero minimum pool
+	 */
+	pool->elements = kmalloc_array_node(max(1, min_nr), sizeof(void *),
 					    gfp_mask, node_id);
 	if (!pool->elements)
 		return -ENOMEM;
 
 	/*
-	 * First pre-allocate the guaranteed number of buffers.
+	 * First pre-allocate the guaranteed number of buffers,
+	 * also pre-allocate 1 element for zero minimum pool.
 	 */
-	while (pool->curr_nr < pool->min_nr) {
+	while (pool->curr_nr < max(1, pool->min_nr)) {
 		void *element;
 
 		element = pool->alloc(gfp_mask, pool->pool_data);
@@ -555,20 +559,12 @@ void mempool_free(void *element, mempool_t *pool)
 	 * wake-up path of previous test. This explicit check ensures the
 	 * allocation of element when both min_nr and curr_nr are 0, and
 	 * any active waiters are properly awakened.
-	 *
-	 * Inline the same logic as previous test, add_element() cannot be
-	 * directly used here since it has BUG_ON to deny if min_nr equals
-	 * curr_nr, so here picked rest of add_element() to use without
-	 * BUG_ON check.
 	 */
 	if (unlikely(pool->min_nr == 0 &&
 		     READ_ONCE(pool->curr_nr) == 0)) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (likely(pool->curr_nr == 0)) {
-			/* Inline the logic of add_element() */
-			poison_element(pool, element);
-			if (kasan_poison_element(pool, element))
-				pool->elements[pool->curr_nr++] = element;
+			add_element(pool, element);
 			spin_unlock_irqrestore(&pool->lock, flags);
 			if (wq_has_sleeper(&pool->wait))
 				wake_up(&pool->wait);
-- 
2.48.1

