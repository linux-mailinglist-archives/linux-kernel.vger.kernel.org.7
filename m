Return-Path: <linux-kernel+bounces-861096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E66BF1CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF4294E823B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0C2FC879;
	Mon, 20 Oct 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2Gkd969"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5325A655
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969836; cv=none; b=ABz7/S4ZESKJS+KFarXfdXZMc/gXbz3PXyJ1Zb27wd1vQsNMoehhLh6vNNgjYRSHR/Bjkp0Vebz0N5sUw+yqwI96gRe8BR2GbkxLRJoQbDO0hxZjsxKezz+yAIiBkKUmmaldq/Dd4Kv3ulp8zryO4RUwAEL8TEBbh4XQy53KHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969836; c=relaxed/simple;
	bh=hLn4KX6C+zx+kRhAJwsP0GiYeYzEKw8qqlJ6TVXxhqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM+1D8KF98mOkFJuKUwrpdp6N/oVpvpZ45YtsaduMsDl2F9ogyYYjOTkFkxu0R/0KIi6S5RLZ9bxN22Pn2U/ExzWmw9jg5ER/lUKvjhXYylRmC7gDKDQ9oFZIfQzQTinSa4Tv2ljpV1LWpkxxWzC1EvfsQG/QdhlHeQWg7C+14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2Gkd969; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jfYAKZOWZrksi5qoX4OmGVPw0kd6k84iLxlHCLK7oEE=;
	b=F2Gkd969EpV1H/Iy6E8+zvkxj7O66rqYq2hyc87bQ0DcIyWwuTlqWTP9em/00QdHaBarY3
	QQKswp3MBd2jzRnznGROdqwO/OdlE40ufCX3ph++rD9wETNpqfPGDSnQzurd/6VCRbjFZr
	3VV3YlhF5PSrkIGDHccWUGWhCnjRXQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-t-55sHaaMRuArUu2tsXDxw-1; Mon, 20 Oct 2025 10:17:10 -0400
X-MC-Unique: t-55sHaaMRuArUu2tsXDxw-1
X-Mimecast-MFC-AGG-ID: t-55sHaaMRuArUu2tsXDxw_1760969829
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4284525aecbso1634124f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969829; x=1761574629;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfYAKZOWZrksi5qoX4OmGVPw0kd6k84iLxlHCLK7oEE=;
        b=sDuKBjXN2x88ngusnJCVARRVgC3CJz2wGCBxviVs9UeeP/SjT/YjnicBVlNmBsVpmR
         Ah9puJa/cYkr6nK0SwIZB31BccHRNBogOv3MBsouf+VH4GM5CuP79hE0JorhjPgLhtRU
         270291vDdziNb2iscMFy+QXYVkKTe4MUri15v/fzWMUHXY/wqEq+O4v5HrDXxypCIV8x
         KIpP+yx+SYWTl5Cd2w0/Y31MaIIsX9Tbl0lBlmHRvuz0L/3PFxIh9bjcB3HQWyXCoGo9
         74EfUe722rObro8XHoUX2esLXhNbcncmpczu54myAidMQd2LLC2wYgH/rSsLEt592plM
         l8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCURvkxwH1JntTuO0kk1Q2hofQ6elu9e6yuF1A6ul5attshhiYBwbvyO1KGwvn6Pkc/NiLN6zhoZ/x7ILIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwZfDUZEJCfkfALfP+rRHiuxKyGyZ4vxgjTu4WYTXs9kSfG1f
	B6zGQUaW6h16oaOHB0w8on1ENLOnIqgVcfXtHfZTZFbUE0bTRv+LbuSGV1BNDi7/keJq4TEKHKg
	7MYjLhFyYp/CHqpCbtemQz5lbS60or1MhcpPUjeoFH3/z/TaMUDIRPyJXjnNEcUIJlg==
X-Gm-Gg: ASbGncsYD9ghHar/l71QQtZ6d1n4VhUdfoVdneP1q/s+9Bf9YCh2F9sQEh7yDbCD1hz
	LKWuFrYc7blXVGXwZ277QEUtcb75EcD+upkEDNUx/WRdt73FKMfAvHekLuQi2N9keEIhcq34PJt
	Xq0Ng/UxZSU/67BEv4jjnyVDaJgfhhCQQnP8hnMuhNUqxMC0aB1rPv2frcjjWo8+vJqL6sFz4H1
	mnE0u8mlkjpiSbmkIjFn+47gGR7FHw6BcdXr/IBoKSdu5JY6IUs3pUBDOxrjGL1D4I5oWMyy2S6
	2yPvPZrBiCUMliw/5NKRYEUFSnsGQGxExZWDkqnlqEYJ743dhkkvy7zKU6nogIkpacJtbOYhXmS
	O4l2ukY6lFxth//inFgYPx2+Lx9gLfoYqOBxcFVBVQ27L8R8eqCZtHRrBvO082u79KojgJlrJbW
	oD3RvPsU7raUKRumJUeb8Oi6+RwxU=
X-Received: by 2002:a5d:5c89:0:b0:425:6866:6a9e with SMTP id ffacd0b85a97d-42704ca6ba1mr8775138f8f.0.1760969828664;
        Mon, 20 Oct 2025 07:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6OUvLi2k38V0HguToAtdytTARx3HNV77YTxzJsGCen7movSvk2GULYom+MGJGITAx0cpoXg==
X-Received: by 2002:a5d:5c89:0:b0:425:6866:6a9e with SMTP id ffacd0b85a97d-42704ca6ba1mr8775103f8f.0.1760969828192;
        Mon, 20 Oct 2025 07:17:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm15520367f8f.24.2025.10.20.07.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:17:07 -0700 (PDT)
Message-ID: <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>
Date: Mon, 20 Oct 2025 16:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, hugetlb: implement movable_gigantic_pages sysctl
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, osalvador@suse.de
Cc: corbet@lwn.net, muchun.song@linux.dev, akpm@linux-foundation.org,
 hannes@cmpxchg.org, laoar.shao@gmail.com, mclapinski@google.com,
 joel.granados@kernel.org, jack@suse.cz, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Michal Hocko <mhocko@suse.com>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 David Rientjes <rientjes@google.com>
References: <20251009161515.422292-1-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009161515.422292-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 18:15, Gregory Price wrote:
> This reintroduces a concept removed by
> commit d6cb41cc44c6 ("mm, hugetlb: remove hugepages_treat_as_movable sysctl")
> 
> This sysctl provides some flexibility between multiple requirements which
> are difficult to square without adding significantly more complexity.
> 
> 1) onlining memory in ZONE_MOVABLE to maintain hotplug compatibility
> 2) onlining memory in ZONE_MOVABLE to increase reliability of hugepage
>     allocation.
> 
> When the user's intent for ZONE_MOVABLE is to allow more reliable huge
> page allocation (as opposed to enabling hotplugability), disallowing 1GB
> hugepages in this region this region is pointless.  So if hotplug is not
> a requirement, we can loosen the restrictions to allow 1GB gigantic pages
> in ZONE_MOVABLE.
> 
> Since 1GB can be difficult to migrate / has impacts on compaction /
> defragmentation, we don't enable this by default.  However, since there
> are scenarios where gigantic pages are migratable (hugetlb available in
> multiple places), we should allow use of these on zone movable regions.
> 
> Note: Boot-time CMA is not possible for driver-managed hotplug memory,
> as CMA requires the memory to be registered as SystemRAM at boot time.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Alexandru Moise <00moses.alexander00@gmail.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Link: https://lore.kernel.org/all/20180201193132.Hk7vI_xaU%25akpm@linux-foundation.org/
> ---

I just remembered one thing, maybe Oscar knows what I mean:

At some point we discussed a possible issue when 
alloc_contig_range()/alloc_contig_pages() would try to allocate a 
gigantic folio and would stumble over movable gigantic folios (possibly 
triggering some recursion when trying to move that one? Not sure).

We wanted to avoid having one gigantic folio allocation try to move 
another gigantic folio allocation.

I think your patch would not change anything in that regard: when we 
scan for a suitable range in alloc_contig_pages_noprof() we call 
pfn_range_valid_contig() .

There, we simply give up whenever we spot any PageHuge(), preventing 
this issue.

However, it also means that we won't try moving 2MB folios to free up a 
1GB folio.

That could be supported by allowing for moving hugetlb folios when their 
size is small enough to be served by the buddy, and the size we are 
allocating is larger than the one of these folios.

-- 
Cheers

David / dhildenb


