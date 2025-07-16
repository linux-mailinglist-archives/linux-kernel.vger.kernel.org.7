Return-Path: <linux-kernel+bounces-733873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B55B07A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352C258287D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F724293F;
	Wed, 16 Jul 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bgonqf5C"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6B481CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680262; cv=none; b=LBRCgGOmiUWIrzUBJsqLnrWye0qm8xLtLRJuCOnP2IQw8T+75B+HMUS2xRdYF9CDRWkbncqsK8ZwJ+wkzud6xI83RsqeFsbqqRjIoo0AjDzXz8emiVRpNx94enrDvhYhpqNY98dOmq0GGrQQpfzdhFk01768DZFHPfe7Rc1UOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680262; c=relaxed/simple;
	bh=0gLvAFjecpAPBLvcnnoAvlSaFtWg+tB39eL/CreqU/4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=u7KhPQUjwGqDjk5t2b+dQKpOAO7C3w0zEHb5T4NM29jrkGqxMfeRAO0+rf8cHCWA4lk1MVbkHVz7VnAIXfzm838D/ONE0zjhCtvUZj962L3ANr0nwTpHwVMEzxN63gFxOH6kmPCJlr22wkbqsbuG5eBjUkNEBVsyxccxfRJ2QbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bgonqf5C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4560d176f97so44105205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752680257; x=1753285057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhScTCoErajgRG+SgtPz3ozjBNcUDPb2j8tb3iyak8A=;
        b=bgonqf5C4KN/FBsxYOGxFnDQabzstBvoiFJ0ZOfBkUMIVVAurYAgu31dKTvkY2KwJ5
         w6E9vAINe3XEsRCzgjvYwrUtLjZpRo3Rc5Ski+7f09p1KCWwvOpTuCrenWXik4lRKV4c
         B9fykJV3mkr2BTUVxDo174mOFQc1hs13opLj6sQkaLozVIK+nfPVD2Yb4avAS3ggnCrq
         5nW2TT26LVVqffE1YSKny/gddOpkrBFovvZ+9onZhFargFmvc6X1CI0r6EMQOiIpjuAl
         9uBXTeWpbUTHeFk3l+wrv4FfB7fWHAPuisTBmSbPHhN3spwrTqJ04//OO+PjfLsGJwRG
         NFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680257; x=1753285057;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DhScTCoErajgRG+SgtPz3ozjBNcUDPb2j8tb3iyak8A=;
        b=rC87Y3lOIZIkB8oZi3t5aO8p3GJSbRRJuZXMFOjd+smIdj8l5nj8BRN+H6jhjefnoy
         E8sicmwDM2mwbhY1ZbVPBEKzlJsxa6EU05qUo4JpmjyBLekSjXlmtSK8dlYpuDe7OYY+
         3m+URjkRDRJZ/5kIdYOuixDM83Ob3KWgxrh5wrX1erdiT6hlksU2wqmdabutZpM9stKk
         qOSPJFyja6M0KkZzj0FaPTWdCbKAoBdGm4FksJAWCRRBehmI6va12/nawjTTczwt3euI
         SfJXi7k1PODuPyWhuSCwzZPRh9qL77cyGNX9w05l4T8/08pFrI7AszmUhpMLGVKGKoyV
         rWiA==
X-Forwarded-Encrypted: i=1; AJvYcCUx1cDV3KrORRe3OKL7v9iXYPrsG12rAuU/fZ+lEVn7oqMgdrs6Lc1vKdvVqY//NKQD5YKOlfYeMUPjj+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUOpYxFhwJxEbxYaxKYccoUZcWtg0sKjEWMvl6oESdlzzX5c8
	z+nim5/oVyr5PFJR9KaY5jGUW74vQLX08vTm0ZC8/yiMDZa6iEczb9fE0WG+dZAecGE=
X-Gm-Gg: ASbGncuw07B30see4JlwZfiNh3SCc+oeYq4snuPdN31dEoFs+7CcgunX/79G47lA69Y
	BmIhsPJGQTirW/nbbh/+wWfCjgeOlV28fKgVuGxW0p6qgZBT93kiCBH7AjTZs2CjFGzTGnzbiq2
	Sdm0yAAIYF87OEnCmGGkRAtmIsbKShbAqwCtxdPT6LGoyahrZOtr95vEe4iLZjOd4BGYgkgl5Bq
	cABShSdCwUms4IJ3YmQXoATEPn0cbh0tWYY7jgbLR6Kq1THBhhOtKCAfdQCMeJoJnx1YuaECBv0
	bR5O6bg3MQUxbCuVkCVghLKTBJxFrgwQYJoJ0bupWrHnlBl2TntgwmO7+5y2paYNAiKo+UmWknr
	9r+EqXV4UnI8KhZ8l+lQ=
X-Google-Smtp-Source: AGHT+IHu/GomoSnqAuI86F6j7vvKxYcamd6VYGJr+0QFP2hBnU9ssYS0FmhVUx2PlFDgd/E5fDZtaA==
X-Received: by 2002:a5d:64ee:0:b0:3a6:ec1d:1cba with SMTP id ffacd0b85a97d-3b60e4c1e24mr2900002f8f.20.1752680257442;
        Wed, 16 Jul 2025 08:37:37 -0700 (PDT)
Received: from [10.211.55.30] ([103.172.41.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434d6b0sm131110635ad.203.2025.07.16.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:37:36 -0700 (PDT)
Message-ID: <8c0cdb71-8d21-497e-b793-c43ce3a16345@suse.com>
Date: Wed, 16 Jul 2025 23:37:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Yadan Fan <ydfan@suse.com>
Subject: [PATCH] mm: mempool: fix wake-up edge case bug for zero-minimum pools
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The mempool wake-up mechanism has a edge case bug that affects pools
created with min_nr=0. When a thread blocks waiting for memory from an
empty pool (curr_nr == 0), subsequent mempool_free() calls fail to wake
the waiting thread because the condition "curr_nr < min_nr" evaluates
to "0 < 0" which is false, this causes threads to sleep indefinitely.

There is at least 2 places where the mempool created with min_nr=0:

1. lib/btree.c:191: mempool_create(0, btree_alloc, btree_free, NULL)
2. drivers/md/dm-verity-fec.c:791:
    mempool_init_slab_pool(&f->extra_pool, 0, f->cache)

Add an explicit check in mempool_free() to handle the min_nr=0 case:
when the pool has zero minimum reserves, is currently empty, and has
active waiters, wake them up. The wq_has_sleeper() avoids unnecessary
wake-ups when no threads are waiting.

Signed-off-by: Yadan Fan <ydfan@suse.com>
---
  mm/mempool.c | 16 ++++++++++++++++
  1 file changed, 16 insertions(+)

diff --git a/mm/mempool.c b/mm/mempool.c
index 3223337135d0..803f8853e0f1 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -545,6 +545,22 @@ void mempool_free(void *element, mempool_t *pool)
                 }
                 spin_unlock_irqrestore(&pool->lock, flags);
         }
+       /*
+        * Handle the min_nr = 0 edge case:
+        * For zero-minimum pools, curr_nr < min_nr (0 < 0) never succeeds,
+        * so waiters sleeping on pool->wait would never be woken by the
+        * normal wake-up path. This explicit check ensures that when
+        * pool->min_nr == 0 and pool->curr_nr == 0, any active waiters
+        * are properly awakened.
+        * The wq_has_sleeper() avoids unnecessary wake-ups when no
+        * threads are waiting.
+        */
+       if (unlikely(pool->min_nr == 0 &&
+                    READ_ONCE(pool->curr_nr) == 0 &&
+                    wq_has_sleeper(&pool->wait))) {
+               wake_up(&pool->wait);
+       }
+
         pool->free(element, pool->pool_data);
  }
  EXPORT_SYMBOL(mempool_free);
-- 
2.50.1

