Return-Path: <linux-kernel+bounces-750469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5AB15BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B949B5A2EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715A294A12;
	Wed, 30 Jul 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYrMDvHx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D3293462
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867829; cv=none; b=sFfOt7VrT57cE+vxVI45sZk5qfVjoBk6o5VNk6N7FvhHhY15fsqh7o4ypVPPGN8knsPQZgGRTxYpz+AjM98tNsgtPTXqxNLrya68v7VolCgnvypH9x43FWYQBdmrW5wwPENWeSkdS15dmuzu1m8kml2qyehANxSHLoWqG/xmxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867829; c=relaxed/simple;
	bh=nbz5KPAiisbkkskWQzfo8wpxO3FdiohO0O8vd5FQuoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tx3g/foW5DGMzo6w3t57r0nCbc/dxONoZ2Khc00UV8et1kRnOn2BKyU3I3uLrMtqbXhl6WXfmE74Oyq+Uw0mrb6MxiM7FddYJapMGcNk2imd54Oc09JHAiFdXKPUjNWpVFxAGmLRpLFlqBqqeqo8kULK1wm3Rss11RyZADHIqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYrMDvHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753867825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sQoSc3uTIHO11Q/Y+3M9cYKzxEMFJgl+ZKCLZTEtcGA=;
	b=JYrMDvHxsjEIUTWwJbdcvHeATZ1echErQj5D+/BrW9WwQMmX+H+Gby75v066HTq4UsX+2A
	qvRXyz7wgI11azmlmsjvZ9S/Ok3cYlN0cHt1avuzVZGBYuNLQTwn41Vb4qM5QKcJyF5zis
	Fpw1EQCUnokwBGwvXZWDiFrfI9Mg6SI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-CU_75tToPqm9jkNEI8uaBg-1; Wed, 30 Jul 2025 05:30:24 -0400
X-MC-Unique: CU_75tToPqm9jkNEI8uaBg-1
X-Mimecast-MFC-AGG-ID: CU_75tToPqm9jkNEI8uaBg_1753867823
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7891afb31so2037420f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867823; x=1754472623;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQoSc3uTIHO11Q/Y+3M9cYKzxEMFJgl+ZKCLZTEtcGA=;
        b=PcqSdRanLCGfw8mnplC41L/cyGc0Cfg0P/RpJg5vPZr6XrnsWxXMVshwrYRij4mFkP
         HLWNov4M2Ok2eMR9DRWtp91DS46Rgp5U9i0UIKad128cDbZiaWCyDBO6wseW6XEONiER
         PNDF1y2Ern+rbjrxY7GFnbl/8e573krAJCXUwPjUHJBDgbt4r6kJbbb7mVG7FRWUnvgw
         nmJWrvHoNyWwhyh6N4ESwtzYO3TvKyOOvxNOd01NLgbLC8XBkSNCjG3mgsNxzpmjRIX4
         EUmXCT1pvFcA4zBicalcz+kmX9SULikuDnBkmeklSrq29PWIk7q9kW5z3ZlaG92dkI2W
         rTSA==
X-Forwarded-Encrypted: i=1; AJvYcCXOdOECRHsXbSjIxoDOiIE6GSN8fI4n5EnVxatFtHwOjNsoD9lgnkT1wVJr+QKvQH6S1z9gwyK1+QBwARw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyW7rpvOEauSKf3ZJ2kIRRSRVsc+vH6REDHXFP1xZ6QCl2/lUS
	VlSkxvWTyKUSRFHqVFULdMSKBDrWYiyefttO/u41XxUrf43npyrcQIcbI44XXpohhevMs+WRRPo
	gFVxgClTbdBktEa8qhJz46mtcWKYNeOMwulmUy/Ck8I2Y8l7Ggx4DSpmDLxN239y4Vw==
X-Gm-Gg: ASbGncuEQUPu0S+bz0wfICVaQnXjpRumDgVXu+1nJGFWHiwqmwbziwI9c/Aq5+9P5fJ
	0KnuMwYTUoxOx2Xdhr/QJJO1HfJ3nJruFqC3Y0PriFSlKKwGGzQyiragA4ZJZvSoEnRRiAhYlz+
	URlZ4i4Hwur7rmEFAVEXUt86pJq+SR0CWu5DlOpHBAsTy8O4319Whdp2vjz+LHsrFAP1xXjtLtR
	/gQxWqO/hS9+aVUSJ6c0TnhUtIByhWbjWDIxktCODnKmapz4VUB7ETBc0bRKF/4dNXBjPLUPnBg
	VS+oOYDsAdhQSEFdDWVpEN20zpu0tvz9vKiy10wXJDBs117xVS9+xT/Hmg44Nw==
X-Received: by 2002:a05:6000:2508:b0:3b7:8b20:6fd6 with SMTP id ffacd0b85a97d-3b794fc2b6bmr2170413f8f.10.1753867822725;
        Wed, 30 Jul 2025 02:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1zXQsSsy4uimTG4SYCl268lNUyozGT87L3/S/XA4SGUEUoAEnG1n695zgsFbOoxviY57dtQ==
X-Received: by 2002:a05:6000:2508:b0:3b7:8b20:6fd6 with SMTP id ffacd0b85a97d-3b794fc2b6bmr2170372f8f.10.1753867822248;
        Wed, 30 Jul 2025 02:30:22 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78ba267e3sm7317566f8f.59.2025.07.30.02.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:30:21 -0700 (PDT)
Message-ID: <0a689e9f-082b-497d-a32b-afc3feddcdb8@redhat.com>
Date: Wed, 30 Jul 2025 11:30:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.25 10:14, Baolin Wang wrote:
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> we have extended tmpfs to allow any sized large folios, rather than just
> PMD-sized large folios.
> 
> The strategy discussed previously was:
> 
> "
> Considering that tmpfs already has the 'huge=' option to control the
> PMD-sized large folios allocation, we can extend the 'huge=' option to
> allow any sized large folios.  The semantics of the 'huge=' mount option
> are:
> 
>      huge=never: no any sized large folios
>      huge=always: any sized large folios
>      huge=within_size: like 'always' but respect the i_size
>      huge=advise: like 'always' if requested with madvise()
> 
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> allocate the PMD-sized huge folios if huge=always/within_size/advise is
> set.
> 
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> semantics.  The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
> "
> 
> This means that when tmpfs is mounted with 'huge=always' or 'huge=within_size',
> tmpfs will allow getting a highest order hint based on the size of write() and
> fallocate() paths. It will then try each allowable large order, rather than
> continually attempting to allocate PMD-sized large folios as before.
> 
> However, this might break some user scenarios for those who want to use
> PMD-sized large folios, such as the i915 driver which did not supply a write
> size hint when allocating shmem [1].
> 
> Moreover, Hugh also complained that this will cause a regression in userspace
> with 'huge=always' or 'huge=within_size'.
> 
> So, let's revisit the strategy for tmpfs large page allocation. A simple fix
> would be to always try PMD-sized large folios first, and if that fails, fall
> back to smaller large folios. However, this approach differs from the strategy
> for large folio allocation used by other file systems. Is this acceptable?

My opinion so far has been that anon and shmem are different than 
ordinary FS'es ... primarily because 
allocation(readahead)+reclaim(writeback) behave differently.

There were opinions in the past that tmpfs should just behave like any 
other fs, and I think that's what we tried to satisfy here: use the 
write size as an indication.

I assume there will be workloads where either approach will be 
beneficial. I also assume that workloads that use ordinary fs'es could 
benefit from the same strategy (start with PMD), while others will 
clearly not.

So no real opinion, it all doesn't feel ideal ... at least with his 
approach here we would stick more to the old tmpfs behavior.

-- 
Cheers,

David / dhildenb


