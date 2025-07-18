Return-Path: <linux-kernel+bounces-737687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3EB0AF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0484E3A90D0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656E23536B;
	Sat, 19 Jul 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XtT8k3yz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2F148838
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921285; cv=none; b=F8Til67C8wq9m057DNN7DFgL7rq6y6BL+VQxkPAEVbBG6yvGVg1BIWyFdkEgg2i4U0rKkHYFu29J343Qzosn9boctU/tqEeIGmd2BoBxjekdF4757tnrfXQA8GcoSAEfyMmFC6sVlRnuqOZMApSzk/fJM8eFKwgKweKbhx+5Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921285; c=relaxed/simple;
	bh=a/IXCcrwkfXluSvxApQiWCEVGvpphN1skM0BVfiGI20=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HBAd13nbnSR2MEfq9r2MS2aWvkPhxm9zQ1317mK0KpUQTWUuUCGLAt6czq54dulKDlKi6gkNxX8rQa2Jrgf/4JYVhMjgdqb6lxkK9skG3Z/OT2CebVWaiZRMNpuQpccKRyOPoRHnc0WHBi6F6R5peb197SWBfWhXxbw7Hx31NHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XtT8k3yz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1280035f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752921281; x=1753526081; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLPSgROEAhCnKRwI31RE1TO5M8HQINGoz4GugGu3XKg=;
        b=XtT8k3yzuwx8+WjWCtv5ajJ2jiIpfTCwSDiMyZIeQ8AJYzFwlwMlGPoYye/6p9sfjt
         lniGfEz6GzABT579AvUxdiJ98IoM/6lbhaElFyF81Bn/IR0KLwxqGqXC9fIUErctNm2D
         PbLLjHU++zgmuVOHXnqbomaj1cKd5ekaUjRe8LQgVQX2A6V1/EY8HQ6aYXMqn37GvRei
         PKziszGp9Exv/7Mwob2wB4fYeVjyv2xT28C9YuabkbNFlFNAms21DZ6jyPP4PPB3kzGx
         lj2o7QJ2lm8Bnj0ql7M6jUj6rzhFfo7gwgaRhgkim1pF89Z7B1H7o0yaMW4sU4/2031p
         qQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752921281; x=1753526081;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLPSgROEAhCnKRwI31RE1TO5M8HQINGoz4GugGu3XKg=;
        b=sNnftqi9W0XQTzcM0vAEr1phcjElugSCVOz95ywbl3pvBx7EtB8My5PhVwjkkBey2G
         NqNKUinex5VwuIEUXpsud9J5LVh9Z1lt+uxyHWZZTSiWmCGQqH47dRuO5iIfhJv94eYB
         hOafR3AkBzF1CM2hjZ56WRzeUEx7NAKrT78EGGb4MgxtpbAjFsGN6fY/7cMwer24JI2k
         NE+PL/+W5tQvze97FBg5pbRw7/tZzxJLuoZ6AXkkIOA0T9dJxispHtXoZ22EaPF1Xrej
         AMU4hA2QSbVcr8cDl8nxmGJL7Bhh8s9GkasvvMuNGv8dJLb47VefgLfdoopImac2wRP0
         /YHg==
X-Forwarded-Encrypted: i=1; AJvYcCW363vFbuVVWF+PYtiu/0XTjon24siFEWpGwMtOR63+SXzzTQyJPyF/+LaDNTZ8zqId+brzhOuyYSUhIfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyb4kX3w6dms2ABtUD/cKPRr01jpCyesk8DlyCg2qHMN7WRDXm
	oWrUp1Vfv+fNCjlFncNDwQD7bVI7sHxX+eUeH+pB9Qq/KdEgkLtU529sd+mFr4+JCf+C4DdzuA2
	DOmX2Rm8++g==
X-Gm-Gg: ASbGnctxu0pfyuAbw5OqmgWAA9RIhv5TgzfH0tlxb93NV+Ai5fNWv473kQm/sSqW2AS
	bNZryY2ZUZssaDRh3Oy0BVS20r2DBHfwmZLTS+HhpaLH86CmgfmO4Zo45SwahFsAmS7qE/ZFFrv
	JnW4V+f2wTbtFzr75nntCnJ6UCtxR81ppfO3nyy3ypTA7Xv8gOAY4s5+LGWuZ1d47Vzdd8ss6RM
	hFYdn9UWHzV5mqfy8M2Ul5+dutuXFp6lkL/ri/CQugNdB51rnUPG+yV4j8Ja6UwXY3NVMR71Sya
	KY+CINWS10OpJ8i9Y7ZMbFTMrI5asE+muSEbuJixkpUsfAchYBz0sQ44IpQbs4OtyoxyYEDP1f8
	KJFx/IHEjk4yV9p8UNAI=
X-Google-Smtp-Source: AGHT+IGjz3rNU3dd+9li05K6Tq18JANydrGITOOvXwZniSAWqrMVuX0mS/Ho0NHEf170VZRNEMycHA==
X-Received: by 2002:a05:6000:26c7:b0:3b5:e29c:190 with SMTP id ffacd0b85a97d-3b60e5134e6mr10245430f8f.29.1752921281247;
        Sat, 19 Jul 2025 03:34:41 -0700 (PDT)
Received: from [10.211.55.30] ([103.172.41.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e9efbsm27098825ad.5.2025.07.19.03.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 03:34:40 -0700 (PDT)
Message-ID: <f28a81ba-615c-481e-86fb-c0bf4115ec89@suse.com>
Date: Sat, 19 Jul 2025 06:06:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Yadan Fan <ydfan@suse.com>
Subject: [PATCH v2] mm: mempool: fix wake-up edge case bug for zero-minimum
 pools
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The mempool wake-up path has a edge case bug that affects pools created
with min_nr=0. When a thread blocks waiting for memory from an empty
pool (curr_nr == 0), subsequent mempool_free() calls fail to wake
the waiting thread because the condition "curr_nr < min_nr" evaluates
to "0 < 0" which is false, this can cause threads to sleep indefinitely
according to the code logic.

There is at least 2 places where the mempool created with min_nr=0:

1. lib/btree.c:191: mempool_create(0, btree_alloc, btree_free, NULL)
2. drivers/md/dm-verity-fec.c:791:
 mempool_init_slab_pool(&f->extra_pool, 0, f->cache)

Add an explicit check in mempool_free() to handle the min_nr=0 case:
when the pool has zero minimum reserves, is currently empty, and has
active waiters, allocate the element then wake up the sleeper.

Changes in v2:
- Inline the same logic from previous test for zero min_nr pool to return
  an element to the pool
- Inline the necessary parts of add_element() to avoid the BUG_ON which
  refuses the scenario of curr_nr == min_nr
- Use wq_has_sleeper() instead of unconditional wake_up() calls for better
  performance when no waiters are present

Signed-off-by: Yadan Fan <ydfan@suse.com>
---
 mm/mempool.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 3223337135d0..204a216b6418 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -540,11 +540,43 @@ void mempool_free(void *element, mempool_t *pool)
 		if (likely(pool->curr_nr < pool->min_nr)) {
 			add_element(pool, element);
 			spin_unlock_irqrestore(&pool->lock, flags);
-			wake_up(&pool->wait);
+			if (wq_has_sleeper(&pool->wait))
+				wake_up(&pool->wait);
 			return;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
+
+	/*
+	 * Handle the min_nr = 0 edge case:
+	 *
+	 * For zero-minimum pools, curr_nr < min_nr (0 < 0) never succeeds,
+	 * so waiters sleeping on pool->wait would never be woken by the
+	 * wake-up path of previous test. This explicit check ensures the
+	 * allocation of element when both min_nr and curr_nr are 0, and
+	 * any active waiters are properly awakened.
+	 *
+	 * Inline the same logic as previous test, add_element() cannot be
+	 * directly used here since it has BUG_ON to deny if min_nr equals
+	 * curr_nr, so here picked rest of add_element() to use without
+	 * BUG_ON check.
+	 */
+	if (unlikely(pool->min_nr == 0 &&
+		     READ_ONCE(pool->curr_nr) == 0)) {
+		spin_lock_irqsave(&pool->lock, flags);
+		if (likely(pool->curr_nr == 0)) {
+			/* Inline the logic of add_element() */
+			poison_element(pool, element);
+			if (kasan_poison_element(pool, element))
+				pool->elements[pool->curr_nr++] = element;
+			spin_unlock_irqrestore(&pool->lock, flags);
+			if (wq_has_sleeper(&pool->wait))
+				wake_up(&pool->wait);
+			return;
+		}
+		spin_unlock_irqrestore(&pool->lock, flags);
+	}
+
 	pool->free(element, pool->pool_data);
 }
 EXPORT_SYMBOL(mempool_free);
-- 
2.50.1

