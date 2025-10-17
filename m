Return-Path: <linux-kernel+bounces-857125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25FBE5FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE9E188AA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2B18C011;
	Fri, 17 Oct 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FApuJBvm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60822F01
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661976; cv=none; b=oVr/RcKt/Z2jv5HVLWS0rdFYTDqKKfHYTDWYidfiR2QnlItvgVJqHqcdT4JQllfbV8YPljFeHqJ/TEQuDk3FmmNj3DCZIdVdokTK904tDRlhQUDmFIk4f5ItrDNB9oog7FcJq4vnOZcQR3oD20jlh60odjlaLQDuktWYVfKvnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661976; c=relaxed/simple;
	bh=x3ENAolDhGepo8Lva0Y8IQnpFONqZhyhxoMK7eF5O1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYYjs5H8kNpmO7qFpLPZXZ73Bqd1lHbVHiC/xOAgdGKrNcmcHJvc3x2GdJtzhJHTDpU/rFyjWKSw9RG+ionDlse6UjuKHx57O+wWmKCPqe2culu93aFJq89aYVPPDJnaKCJwuLqj1CSFhcmcl107uxvfF8MAdKpun/Sk8nZ0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FApuJBvm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so2038012a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760661973; x=1761266773; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B/rNIxGB0E8lYNQb7e+4S76Mddht/U4IBaRSdc7uX4=;
        b=FApuJBvm7hfHwLlh+ODwe6/PM1E1ZEO1YFVo+OCtCk7O33BtokEmQHIq0dgl1e9Khy
         MqzWLnBDgcCCHXuZIQg263siFP4xjFIZRNT7Y4vT7EpQ9CttUGulc1uztMUT8XeArscw
         WRgL7iUECIzrzIhkpFnaP0edDYw7ej198F8FDDH16WxJ98FwVaKM0wlYaJZ+5dCUxd0b
         bqxtrUAWvP218IfrN9M4YDYVwb4DAaQyrFkvB/AINK9rSh1nBEtD2NUrIwTY7MbUND0R
         FMmXprNYRq3F0ahO0HWeMdxtHTVNND4G1ZvK4740GanwuBjW72pLRK4B5iWiU7az62S9
         bkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760661973; x=1761266773;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B/rNIxGB0E8lYNQb7e+4S76Mddht/U4IBaRSdc7uX4=;
        b=oFy/+AQ4xyhhOrrErHBozRzScrDoEEM1mgXtneMWp1BPiMDlBv5zO1Z5oB+7z/HTzl
         11ue/Hkk5EKUgArdW6kLRAu+cQ5n9K3kTRSYOVODHOYXhPKJo8kEugXiLnHwGxjMM86S
         5At887swp1W4OlMYrgofrTWRekcXmaGXzjHMpqpPNhE6jqvS3/HkpLErCbta2P0N29il
         qmlXYuibNvYSSxT1jfpgOtUWnv/O5VpvCIHPAItihc7z+x6qlyFEaVRD3iYJQEjmfDS7
         mleI3RslUszog/GEJrK3p2JCce7nRXcOSonGd3mS18ZjliHG6MflRbWV42CVgRrcblC3
         EMRw==
X-Forwarded-Encrypted: i=1; AJvYcCWFSMj+3WRHovht//sw0QqnrOy0D6SdrP/Fy1a2E/4ML24K69vSw+4PywWTGLTygshiJNpSMUUti/S/LLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzzJCRmQbAPgvz9OklTuR0StDUUB8O9uMDktkGFsmdutOfYlh
	8IHPm5J4TIpW5a2SuRdSbXaEiPYlMGPgPJURwkpWrF2FJzfk9wGY9Dc8
X-Gm-Gg: ASbGncv4SWv+RE1Qlrlv+WAOSQOFiKdcV4MiqMADqWtP2ZExFSYH8WLuepOYHBScla0
	g7tQpYFiDz3A18s4N+k0fW0JB9NpipYWgsBtoCByOCTX3PrhIYDM43aI3Mlu3FmPoADrM1VGLwH
	O+y0upctto/qqeURbnATNuTuZ/Cqh3v0z+NA1o+P2Q1TRdKn3pu1YvQsL31mlbPHFkpLfuVQ2Ek
	ENL7BfEpV5GjARlqiacfzBco2tSRGiOX8fbIIUkrna1OFPKY71XDRKGyBBrCI1GABqN3eYnGnbJ
	54FDkJzXPjkqQZ+DSoDQ6DyQt4F34+VyWPm7PjAaRdYe2NNFH/0XQz+Az0i/UoN3M8Ma+tUiH/g
	HKlN7EzqIjDzbU9C4fkj2l9rZm5g8u0REtIzFXWnXFTZ/0pDLSgnTQ7wYx493NjVpFzLreIPHCz
	t4ka8Q6CRTkGO9vQ==
X-Google-Smtp-Source: AGHT+IHIrzM9nmQS/QH3e+TBJNCq5g1hcZGI45fz5wnzA+TbcN3hecCz0LjMxm3I+m+5Dg3KP8R8Xg==
X-Received: by 2002:a17:907:3e85:b0:b3e:8252:cd54 with SMTP id a640c23a62f3a-b647395033fmr219806766b.32.1760661972374;
        Thu, 16 Oct 2025 17:46:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06b7f6sm689297966b.30.2025.10.16.17.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 17:46:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:46:11 +0000
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
Message-ID: <20251017004611.ccjq2343v43mimqq@master>
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

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

One nit below

>---
[...]
>@@ -4239,38 +4245,27 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> 		}
> 		folio_unlock(folio);
> next:
>+		if (did_split || !folio_test_partially_mapped(folio))
>+			continue;
> 		/*
>-		 * split_folio() removes folio from list on success.
> 		 * Only add back to the queue if folio is partially mapped.
> 		 * If thp_underused returns false, or if split_folio fails
> 		 * in the case it was underused, then consider it used and
> 		 * don't add it back to split_queue.
> 		 */
>-		if (did_split) {
>-			; /* folio already removed from list */
>-		} else if (!folio_test_partially_mapped(folio)) {
>-			list_del_init(&folio->_deferred_list);
>-			removed++;
>-		} else {
>-			/*
>-			 * That unlocked list_del_init() above would be unsafe,
>-			 * unless its folio is separated from any earlier folios
>-			 * left on the list (which may be concurrently unqueued)
>-			 * by one safe folio with refcount still raised.
>-			 */
>-			swap(folio, prev);
>+		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>+		if (list_empty(&folio->_deferred_list)) {
>+			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
>+			fqueue->split_queue_len++;
> 		}
>-		if (folio)
>-			folio_put(folio);
>+		split_queue_unlock_irqrestore(fqueue, flags);
> 	}
>+	folios_put(&fbatch);
> 
>-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>-	list_splice_tail(&list, &ds_queue->split_queue);
>-	ds_queue->split_queue_len -= removed;
>-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>-
>-	if (prev)
>-		folio_put(prev);
>+	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {

Maybe we can use ds_queue->split_queue_len instead?

>+		cond_resched();
>+		goto retry;
>+	}
> 
> 	/*
> 	 * Stop shrinker if we didn't split any page, but the queue is empty.
>-- 
>2.20.1
>

-- 
Wei Yang
Help you, Help me

