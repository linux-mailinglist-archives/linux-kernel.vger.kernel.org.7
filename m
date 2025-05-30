Return-Path: <linux-kernel+bounces-668722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959AAC9639
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 21:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7059E7ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBAB2609D6;
	Fri, 30 May 2025 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYaoe/DD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17D2F84F
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634774; cv=none; b=Ee/UzcBx6MTpIvgjUjuv7vZkhzLQtcesXP/KnIGdEf4ddqy12joeoFNc42ah5VFKdii6tPauI0TIvA7A8mLMaFdUwKeS2BacR30dhj+RPylddHKOxVAn/ouUy9JrV6bVVJ4/PWzH1sjbQcr5gRt0OzHrAoIng5e+4Hf7NlgvUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634774; c=relaxed/simple;
	bh=KJYtJGwFBnKDAjVIC+U68svl180EkjfyxhhmKmz/MYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzWDifxaAv1wVvK5QyXPhS/pF45JjcYfFU5qh+ZXqxyF0/ib8rtSYn8gyPfFK1k8kJhqjdu6NyB90tkCLciJzAxm1H6RLACZdY8Hg1MpiWsyz5HVdU90l6Yg/2zPsiuXbIvWmSVnbFN3pBxYQc4zzIVpOkaIDU/0vP8ZLFRZpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYaoe/DD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748634771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=96jjxFEHZGPlrOW+4VgbtcPkDz4sPKCIYqYJQxu3cyg=;
	b=BYaoe/DDC2lwgP7Uwkd5KmkB75A1F5emHXP++z7mkqvhcQft1261/h30T2N6pJ7ryeypwl
	iDyyIRFc3iVzZ4hZun5KNG7phTkQpDvCikDDMfIeyEp3wdSETPUDroEVP10mh+QCW1lz8o
	iPR9144pWEfDZQJso837PGCIW/sJRWQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-kEjPPRDqPK6Sdhnx40CEEA-1; Fri, 30 May 2025 15:52:49 -0400
X-MC-Unique: kEjPPRDqPK6Sdhnx40CEEA-1
X-Mimecast-MFC-AGG-ID: kEjPPRDqPK6Sdhnx40CEEA_1748634769
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so14135105e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 12:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748634768; x=1749239568;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96jjxFEHZGPlrOW+4VgbtcPkDz4sPKCIYqYJQxu3cyg=;
        b=qRSdME8l96JrUK4/EWqR0kVv6aDmVY4bIvJnHAjRD7+Sy1HKP0Bwb+KWsePuXjYG1A
         9+RctJ8wANUhy6tjlsVwP9ALl+zzGu2g7Pa0V3eJRCDt8XE6I527SLBcdMeXhEYlZa10
         J5G8k2hRhDZKlXBLYERIiUjE3OwPnMfvYIQUswKOkKRYA/+AWH7osX7SbZkxAVtHFqmz
         YplzyXreQ5a655/pRmMnf1OR9uRNQQcgMKx9tCV4vgcrFi/d2e84ssyh3J1tW7Hfg4KO
         ZvNhaq3Dhl9T3nyc0MwZugAPI08H6g6WNKMBY/OMhruRMM9/4qIncA7+Cgg2h2KsdaRt
         TMvA==
X-Forwarded-Encrypted: i=1; AJvYcCUg4NNC9gkVvoU+43QmkpseeDoNYs5F9PMK0aSeWLJ0NvoY4nCpYMax9VVj94NmdqlE/nuq0LlK2juNw94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKFtBvRK4ni+u2JexWBVkYX24aX0Dsu5SU3oXzVhdTiltyIc3
	59dr/4g+XJpatiZAuZErSDyWCyECVrVxi0GauUXFjUBqCviNaSNRu/6fTImqLMNZ26jqHK/XcGE
	V+VO/RjKJhEGDekAZidIhdALD4jUTDqKP7ARShUGOkB7F2O2iN7u/64h+VgRubUsLnA==
X-Gm-Gg: ASbGncu9jFdDjHRHImVbJHBrahSmvnB8JDeFhPmR2/4f00XvvvXC0tilexSo70RlfUi
	htWqZmWEtF94niILsMCMhWhcnLLy0tN5oqldTjnrBXTuaTuaUnj0XV4Jtq0tqKEnvg76j6YUwnX
	z55NhYHtJ+qG7aOOQMA5naAP0m/b/NZAj/vdmD5KPSc4eRNlTDdkN/n8tHKkalJqpgpCdvDa1g1
	Ov+4+YiufjoT83rKH24waTauFQJ17AcYh7Apmr8xk73aKAV1HHWrXCZjXhC8VywrzdF9+JYkxPk
	Aw56NN4Nb2JQbk3qUhBSF/u77L1FaR8YKt7L/iiPGoH3RkDNrBC7VvpEgcxaqI4A/R9Qrf7A4Gn
	8EfLug4DCZQfXZCW2pCLVTDHGBd4qc8vH55hX8qU=
X-Received: by 2002:a05:600c:4e44:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-450d882b3c3mr35763135e9.2.1748634768678;
        Fri, 30 May 2025 12:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqT2fQtlryiIiwgLZjsVbyHznyCR0OAafR1TehdhYnrQM/DYdVj9cYIRI3Hrzz8b/JkSF0w==
X-Received: by 2002:a05:600c:4e44:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-450d882b3c3mr35762935e9.2.1748634768290;
        Fri, 30 May 2025 12:52:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d620c544sm22252995e9.2.2025.05.30.12.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 12:52:47 -0700 (PDT)
Message-ID: <41b9f35e-6ce9-4d2d-a2d5-f1021648ac37@redhat.com>
Date: Fri, 30 May 2025 21:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] mm/page_isolation: remove migratetype from
 move_freepages_block_isolate()
To: Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Richard Chang
 <richardycc@google.com>, linux-kernel@vger.kernel.org
References: <20250530162227.715551-1-ziy@nvidia.com>
 <20250530162227.715551-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250530162227.715551-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.05.25 18:22, Zi Yan wrote:
> Since migratetype is no longer overwritten during pageblock isolation,
> moving a pageblock out of MIGRATE_ISOLATE no longer needs a new
> migratetype.
> 
> Add pageblock_isolate_and_move_free_pages() and
> pageblock_unisolate_and_move_free_pages() to be explicit about the page
> isolation operations. Both share the common code in
> __move_freepages_block_isolate(), which is renamed from
> move_freepages_block_isolate().
> 
> Add toggle_pageblock_isolate() to flip pageblock isolation bit in
> __move_freepages_block_isolate().
> 
> Make set_pageblock_migratetype() only accept non MIGRATE_ISOLATE types,
> so that one should use set_pageblock_isolate() to isolate pageblocks.
> As a result, move pageblock migratetype code out of
> __move_freepages_block().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

>   
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b2fc5266e3d2..08f627a5032f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -188,7 +188,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>   	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
>   			migratetype, isol_flags);
>   	if (!unmovable) {
> -		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
> +		if (!pageblock_isolate_and_move_free_pages(zone, page)) {
>   			spin_unlock_irqrestore(&zone->lock, flags);
>   			return -EBUSY;
>   		}
> @@ -209,7 +209,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>   	return -EBUSY;
>   }
>   
> -static void unset_migratetype_isolate(struct page *page, int migratetype)
> +static void unset_migratetype_isolate(struct page *page)

The function name is a bit misleading. It's more like "unisolate 
pageblock", right?

Maybe something to clean up later.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


