Return-Path: <linux-kernel+bounces-888783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F5C3BE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2303ADCB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FA158874;
	Thu,  6 Nov 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzrKvwrC"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506F3203AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440738; cv=none; b=StsKJiqmApYD08zvQg9Z+x02eunPBLn5xMHxeE6d51lnffzIF+5HDsjOS2SrIS3l4lqr3AhJnVae6ILsWjwYa9kphvFEDC6XUqcziO7G9b5O76oDkj5vTA4RrmpxZvx5id9FC/2BuNcrw6VU7gMu44PGDRLHcttOq7F9i+qDAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440738; c=relaxed/simple;
	bh=dAoak8iwf0Fm/YyIMtLFLD7XPGq/ThJgvczcM7IhDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXGL21mUIOq40Y3s0Lf0FkuzkSkIHncYDY8wO90Qlim9GZYcfhlnZvae1cAeTojcwPKTkBovxoJ9vxH1ERAVqVwIVGR/p2cDgZhobHsKhE6j2kPSz6lG9lV1qZSijcwcp1t274fVaqY0VvCDV7m8gTibPMa4BJYD6ACg0pwk9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzrKvwrC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso1824479a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762440734; x=1763045534; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDdygpEaHGMoa57zuV/aMoSnBxXhLlVU6zzsPP0T20o=;
        b=MzrKvwrChCqozTBR129s+QWX5qczo+V6yYXt/08OI33p1LwylgRcnibfAb2QcgYwq2
         siDEU080VVpgFlb5liTgPqS4aqZJ2UxjXzUuYfu35ogAR7KVsaDumUlmJtLrDkPb/XJg
         fJY9Bct8rfIHuyzVr6NTpHzYzrEX6CPaxV6N8IzAeFtuFECJ4TB8ppngcRE599w3DE9w
         KojszPnDN5HUI7aY0+2arGKkd67m7b6Fyzva7YKAp45CAzTt7nLh2NVdiKF36zGLMd9u
         Gtrt/V9uWt1aM1ipyxl0+I2+pRyfbKcNPM+e+OJ3B+D3ex4lkL7QFNYqFeUVoAC0gZjU
         h1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440734; x=1763045534;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDdygpEaHGMoa57zuV/aMoSnBxXhLlVU6zzsPP0T20o=;
        b=j5sjxqlXjuVqplE+riwuMR+gE9Ueo4UM37yawMMRgQDuvHUOWLSLSYjw3OCzpv7zvT
         8kgV4FFbBUgyu05s5rKMqAzD7UB4yry7zffj8AbOva9neOC6HDmPBzIBFtyJTDU2dVI4
         whNhOPZ0RR5d0cYhPGH/rtd/qeTmr0yJR5hjCVVJUbzwKxjSdM31kxzKDeTgIIOzXET1
         WpGT0Jf+Wn7Od86UgpsB+22/JgsPMrKEFDlsp5t9JbNhht0jVwaCFjLoQXCtjM/HEHRs
         WTR064WDuz9MPbHFr/sHupK6ntJrIOw65zO4IBIWzo0U2cPLEDypBUPkuBDJH7uDhN3U
         YUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbsCXkcLZypGKwQKQOADlECFDKcnN4eO/aqOlpuLKPRKiobnw/w901xoPxh3FG354u7JQSjvPRYtqxmcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6M0aehVyQOA9dA//TDto0VW00Wq/vymrbPkvsOFn6Ij+Py1gp
	Jds0Dg5EpqjTO4Gd98qQMYmsghemqg4cPKtDUfJRojxw4ipUPqoHfFRt
X-Gm-Gg: ASbGnctkwusqvYm9GmuQ8QmPJs/b5mgZeq9E2XcCM+ZWwFQl6Rq2eA6r8RGYHGAXmVQ
	73gnkZ2QyHyVwV+5PRSTrPyCYWIUykdwFi/QW1Y5/jmgW4MOaKeSwhNIRBGa/qqLH/V9vRfHs5f
	NH9Med4EZ83mBG1B3EwLGNyXWT0ToId9+7DMsO+uw67V8j7AAeNVV0J2X7kuCvhcdkltYdNT7+X
	0CKtnNhQOjCDFjVx5TomeAzWKdNenHn/Qwgb39Bl2e0GfNdIaSWZNVpVjYOYCrxSxoDlTJFAy/K
	B/7ea2UQ5jivjaMM8bDqmMat6TFoZ0P+dN8hbVVo4ItfMoAayfYwP0TQ9zMIqh6tlqmG7gyRXVp
	l7m3yldZsI/uLMEa+VHeWCYXYDOCB/Ro80IAIxWVttcbvQ0g+zwmJZTKEHOBoGVUf8AoGpIt4ek
	ZfBOvF8GQJMg==
X-Google-Smtp-Source: AGHT+IGgp/wgiZUKTPVZE3gj8111Pcf5itf4K+msOi2yemcqfhoEzuV1DpvFFwMSKzQh7/JzEeOngQ==
X-Received: by 2002:a05:6402:34c6:b0:640:bd90:350d with SMTP id 4fb4d7f45d1cf-641058899e1mr6623598a12.1.1762440734161;
        Thu, 06 Nov 2025 06:52:14 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578d4sm1999441a12.18.2025.11.06.06.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Nov 2025 06:52:13 -0800 (PST)
Date: Thu, 6 Nov 2025 14:52:13 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-ID: <20251106145213.jblfgslgjzfr3z7h@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
>From: Muchun Song <songmuchun@bytedance.com>
>
>The maintenance of the folio->_deferred_list is intricate because it's
>reused in a local list.
>
>Here are some peculiarities:
>
>   1) When a folio is removed from its split queue and added to a local
>      on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>      updated, leading to an inconsistency between it and the actual
>      number of folios in the split queue.
>
>   2) When the folio is split via split_folio() later, it's removed from
>      the local list while holding the split queue lock. At this time,
>      the lock is not needed as it is not protecting anything.
>
>   3) To handle the race condition with a third-party freeing or migrating
>      the preceding folio, we must ensure there's always one safe (with
>      raised refcount) folio before by delaying its folio_put(). More
>      details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>      split queue not partially_mapped"). It's rather tricky.
>
>We can use the folio_batch infrastructure to handle this clearly. In this
>case, ->split_queue_len will be consistent with the real number of folios
>in the split queue. If list_empty(&folio->_deferred_list) returns false,
>it's clear the folio must be in its split queue (not in a local list
>anymore).
>
>In the future, we will reparent LRU folios during memcg offline to
>eliminate dying memory cgroups, which requires reparenting the split queue
>to its parent first. So this patch prepares for using
>folio_split_queue_lock_irqsave() as the memcg may change then.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>---
> mm/huge_memory.c | 87 +++++++++++++++++++++++-------------------------
> 1 file changed, 41 insertions(+), 46 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index a68f26547cd99..e850bc10da3e2 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3782,21 +3782,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 		struct lruvec *lruvec;
> 		int expected_refs;
> 
>-		if (folio_order(folio) > 1 &&
>-		    !list_empty(&folio->_deferred_list)) {
>-			ds_queue->split_queue_len--;
>+		if (folio_order(folio) > 1) {
>+			if (!list_empty(&folio->_deferred_list)) {
>+				ds_queue->split_queue_len--;
>+				/*
>+				 * Reinitialize page_deferred_list after removing the
>+				 * page from the split_queue, otherwise a subsequent
>+				 * split will see list corruption when checking the
>+				 * page_deferred_list.
>+				 */
>+				list_del_init(&folio->_deferred_list);
>+			}
> 			if (folio_test_partially_mapped(folio)) {
> 				folio_clear_partially_mapped(folio);
> 				mod_mthp_stat(folio_order(folio),
> 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> 			}
>-			/*
>-			 * Reinitialize page_deferred_list after removing the
>-			 * page from the split_queue, otherwise a subsequent
>-			 * split will see list corruption when checking the
>-			 * page_deferred_list.
>-			 */
>-			list_del_init(&folio->_deferred_list);

@Andrew

Current mm-new looks not merge the code correctly?

The above removed code is still there.

@Qi

After rescan this, I am confused about this code change.

The difference here is originally it would check/clear partially_mapped if
folio is on a list. But now we would do this even folio is not on a list.

If my understanding is correct, after this change, !list_empty() means folio
is on its ds_queue. And there are total three places to remove it from
ds_queue.

  1) __folio_unqueue_deferred_split()
  2) deferred_split_scan()
  3) __folio_split()

In 1) and 2) we all clear partially_mapped bit before removing folio from
ds_queue, this means if the folio is not on ds_queue in __folio_split(), it is
not necessary to check/clear partially_mapped bit.

Maybe I missed something, would you mind correct me on this?

-- 
Wei Yang
Help you, Help me

