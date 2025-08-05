Return-Path: <linux-kernel+bounces-756279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46747B1B23B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E783AA52E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0923A58B;
	Tue,  5 Aug 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6/W2ZEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1527461
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390864; cv=none; b=LuDfsLAtfD6a4+c3AfCqS+wU4JzOvuvNJKje5ZxUo6rkDupwH18/3Wqa+1MSvrDC/OrUg/KkefJChSjVO/9Z+DtxP2hm0tycy7EH4FFmc5Vpwri/T0p8TvFHrDO7GMp7jttYRHLZIJfpMaBYk5/lk2ZrThOUflZQ3nxE2tUmBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390864; c=relaxed/simple;
	bh=ckK2nMUa9vmRKb+J85KyJnsQL0SjbjhG/b7KnspVH/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG+1MrcBqgbg5xQ8v8QXUhBMeOYLwyrvQOp09aqinmU/LuCcytyRhhb38lHsBTX0TRduIa0uEgitYx84pYWcLw2KZhgADlaOE6019iM5XVHKOyQg+v0aXkfG7AZm6a7yRwkuhx1AyL1no0jYoQzWgK+z/CNxTbSOmHpEzoT2dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6/W2ZEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754390861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dTTeUXpaEfmXOu2q1XspDyAZDWPFExfM5BjlRehMDhk=;
	b=W6/W2ZEyuAgYYzPR9VsLSDRIECMS18G860MrpGd/srBssMDyR31FpphJfiJkcIfRUVTrhq
	n5k4fnI7+AjBF/2YUWUmpC85NjLnR26WQdV9SB3hJYYdSMCQvK4nXfory4RxdB6bLanvGw
	uEYyz3i9YiQY9ZVh5zicBw1PDWn6a/A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-ufRdYmWyOHyNgYK0XgM60A-1; Tue, 05 Aug 2025 06:47:40 -0400
X-MC-Unique: ufRdYmWyOHyNgYK0XgM60A-1
X-Mimecast-MFC-AGG-ID: ufRdYmWyOHyNgYK0XgM60A_1754390859
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7892c42b7so3331054f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390859; x=1754995659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTTeUXpaEfmXOu2q1XspDyAZDWPFExfM5BjlRehMDhk=;
        b=bQKY04hmKAqsiFdTUChmU922WUXZ6Zn2SJhDlnoCUjZncjBUYPF6dgWrDbz17iee0j
         S1FIxuVXwYCtQFl+K3W3iTmENLHMtH53KTsVkT8uDxktmFmWV2lHl0bvSrTs3oIDCkKk
         AStPwiRiP0Z08bXkaLaiJMhy6gi++wzzhlQKl7N/HvAn/T8Yp9aTGIbvnyUwGmr0hH+Y
         mmDZ++Qqjlqh2CX+NJfH4de+R0xx04IPF4+qp6qyvWnGavJHo+ka9vWmkqgx8fdYex0M
         eyzvtJ1/5KC5utA/Y6gE4xeAX/Nsmieb0fh3uLX3+VxmbD3AyYWKTBvI5Eav8oL6TiXY
         V6dA==
X-Forwarded-Encrypted: i=1; AJvYcCVxXcz1xsNh/MgpmJYTF8yW7q+pIdlplaSn/IdpNNyT7t5XsLs4GdbCl6uFw7CqEX+Tqy7t5McgGWxgHgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vp1Q4+cgm9BDN9GwKS2AiwlonpbmfFedDUSaDetazK1012gb
	/Kf1AwkIcuqukpaBSF7EQrBSC2NmLufp0VPPyTPAxWtLS5fB9UTjjrFclFGgmRh3iSh2d19yp0A
	qHPsMf7onepE4CcwZbZGyTIt+ncgWxmJhmnmVMmNcMpxSCJMZnnl6rPqh/sd7RSTVOA==
X-Gm-Gg: ASbGncuBkW1vA/jcIHEcloDEhOpHCCA1Lt85Hzi5jk9SrKtAaq2ltu1PBoa/Nop6eWJ
	Sng91aWDLhzJEPV3W94QZB4I/XCT6OP3zvR2xooUoBKivNRA5+GeRUVQK3wmr7xrnPYWZXItIJI
	TsILtKWMR+rybB4bNdmlgaTdtT3Ek56IlaNTIMMlw9D8dCpufOhbMhNFzEyYy7MWOieaQd7xIFd
	NNtLtHFAVO0mVdmaKErX4cM/xJNSFYnhIKEU2ZMRcHd+iQi+U1ezZ2h+sLFrcW32hRVtapOKVd3
	5LRRXgimLXY11jvsvsPAdCzJELaOS/ZU15JvymPcEbWEcBbu2M9ydUrKHgn9t8ynUAu8MkQ0BZv
	0STQLm7MSYwKy56Aoczyz1an+LqB8ab4EB43PqfuUljZD50mYxAiHmYv6ID7eJ/zat5E=
X-Received: by 2002:a05:6000:178f:b0:3b7:901c:92ee with SMTP id ffacd0b85a97d-3b8d94cf1cdmr8432080f8f.58.1754390859337;
        Tue, 05 Aug 2025 03:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBnG3gma3djOJ58PE9KbMw2YKFxWRTijeMo7qV2ngyd1xQZLcK0FpBmhAOFea+867zmz5tg==
X-Received: by 2002:a05:6000:178f:b0:3b7:901c:92ee with SMTP id ffacd0b85a97d-3b8d94cf1cdmr8432060f8f.58.1754390858853;
        Tue, 05 Aug 2025 03:47:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm19096277f8f.24.2025.08.05.03.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:47:38 -0700 (PDT)
Message-ID: <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
Date: Tue, 5 Aug 2025 12:47:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Takero Funaki <flintglass@gmail.com>
References: <20250805002954.1496-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805002954.1496-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 02:29, SeongJae Park wrote:
> When zswap writeback is enabled and it fails compressing a given page,
> the page is swapped out to the backing swap device.  This behavior
> breaks the zswap's writeback LRU order, and hence users can experience
> unexpected latency spikes.  If the page is compressed without failure,
> but results in a size of PAGE_SIZE, the LRU order is kept, but the
> decompression overhead for loading the page back on the later access is
> unnecessary.
> 
> Keep the LRU order and optimize unnecessary decompression overheads in
> the cases, by storing the original content in zpool as-is.

Does this have any effect on the movability of the given page? IOW, does 
page migration etc. still work when we store an ordinary page of an 
shmem/anon folio here?

-- 
Cheers,

David / dhildenb


