Return-Path: <linux-kernel+bounces-727509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7BB01B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D4617540D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED62EA488;
	Fri, 11 Jul 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEMCaM6A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757E2EA48F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234264; cv=none; b=dfTwN+LCCY5dXV2ZQjOFI01O5sCnFQD73l2YoRiGjlUdHKg3B30F9AH77pViEw82SUbK1dx5sL7agPhcLvpodM6C+SG29qJQGdUyyd3XFbnCaPl/kq1TwAI2NAgiKpVVJjt5GLPD226Pu09xk1Zr85ZmQMPeVtauwclQ+euP088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234264; c=relaxed/simple;
	bh=ySGXInnQPgEg327s4+dt7MeICD0KzBb7/vomuiuioys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE4MSuQ6KS0YvACsmGqdO5wnRNjxL/jLds1sdhcqUsrzbqMqB2i0ReBq3MARoyvJRnwwpvAxCaV/AxGnUv8nyBBgyIU0nsEBz4RqXW1dSUpgnbqLnD1Z2JTBvNXtZR8tTGQ59A5PbXNIt6fhynq6XbDPbWcmmPiDG6bePSKOdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEMCaM6A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752234261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WxxiWerHWt+9Ao7V3z3Uc4mwArsknSc/15t11+OZDRs=;
	b=FEMCaM6AQBWtSHDDi4lTJ09IwcgRcd11wDiGSfvEEBfvLDNLrSvhoyRmuJqHytpsU4LbAW
	I3DmOg3nsqc/2vNNodnn7aqnI1Zo/xgklAly9pP01TOEeCV7e9JGuwE7M5zmMuaogvRTIh
	rBzyGStoKFN05R7v09wFP7YGnA7GoF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-UrUrFJeLOCWPW89B2bUoLw-1; Fri, 11 Jul 2025 07:44:18 -0400
X-MC-Unique: UrUrFJeLOCWPW89B2bUoLw-1
X-Mimecast-MFC-AGG-ID: UrUrFJeLOCWPW89B2bUoLw_1752234257
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532ff43376so17784745e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234257; x=1752839057;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxxiWerHWt+9Ao7V3z3Uc4mwArsknSc/15t11+OZDRs=;
        b=kfopGLKBVFzHs6Ct1heBIYFD5S2shNtHUQMcoOp2QIQdcfuoTQT5GSFks2GAn7F1zT
         c13pHjPg2oAwhtslON3wKZK0kiI+YEED0Ug8w6H/sJtQma8ZhjtnfOeZ3x4Ampg5yH06
         rmcVkYCP+fTj1biK62q17FSIIT5rsSD0d3tYnTC0P966z1tRilXj6LOkR9QHs6vp1K6s
         NK89ZtWWB77YTQU0UsByqmCRHWYZIr/RzraqkxPicjBzYQbMMByTsjGCgNaYFrtKL0UN
         VV0HqzclSEkoLWTy7Ma7cyjybKTo6mNOugS74avN4VPAEXulC4Us33b7UrP4SaVhnYix
         CHHA==
X-Forwarded-Encrypted: i=1; AJvYcCV0iR3/inIZVS2gdFd2Otv09n+tDiCHfJBd/hT0Pag36+ER3H97cicsMHd+GcKajrnd8cHTLKttFe4Wd7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBFbBqShIhRUD2ikKY98SffsoxzGn3u70S3nKlrEUAlz5pJ37
	IPjeWQqhB5KcuTaholuQxOJ/fMc7yXfei+brB9fki53NuT6LNYF5lNlmzHNuIZjlSJfkLInG4+j
	pgYYV3GcoUuAaQzMoKMDC0AXC7v0/hcq1j60NzAfTHg3auKhNNEjj1Ehq6uKfimBdSQ==
X-Gm-Gg: ASbGncvEQDNCtua7Ff6ju2K8Wh0Hv+kJYMBgRbePkT06waA/baxGNIpvNXNXsKk2hSb
	xmjx75zkOroCdZP1oB8bRCYaq7n5gfM94+XNlmR5+uJlCVt+3I22npcFn4DpZCvC4yqbfAPRQJE
	154g/mst+DocrvdL4wJRgZycf1CUsSAf60hOnvOUvFlcHwBMwPaVG7KNwYmaB2W2n7woNprG5Fb
	jxkw2xFQDUxRez88QzgOCQQhSojbvvHLjVurB5PzYeDFdHw0yA+CGRj8/09xWDo/fjK9yDmdy3L
	J+jt3HImVIJ/tcBMOGZ+kxmF6ouq9hKbnj75IDvU7zWyMJgTI5WjHJOXRgJchvjxNwzEEl2DeH3
	xx8APQZgTs5vuncafvA+TWW7UVaeJmOYWSbU766XAhwdccOLmHDe3qTO9Q+7ULPFo8j8=
X-Received: by 2002:a05:600c:a03:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-454ec14d7a9mr23815455e9.6.1752234257395;
        Fri, 11 Jul 2025 04:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa126UL6/dra3q49R+ea6zyflhWI6jhHkJbllOqD3EYzzpbt/ubQvUpDRPrfLlAghSxeAytA==
X-Received: by 2002:a05:600c:a03:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-454ec14d7a9mr23815025e9.6.1752234256924;
        Fri, 11 Jul 2025 04:44:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d512c2bfsm82539525e9.39.2025.07.11.04.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:44:16 -0700 (PDT)
Message-ID: <4fa268f0-d56d-4b6c-aced-06e7002efd28@redhat.com>
Date: Fri, 11 Jul 2025 13:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710005926.1159009-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 02:59, Ankur Arora wrote:
> folio_zero_user() is constrained to clear in a page-at-a-time
> fashion because it supports CONFIG_HIGHMEM which means that kernel
> mappings for pages in a folio are not guaranteed to be contiguous.
> 
> We don't have this problem when running under configurations with
> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
> longer page-extents.
> This is expected to be faster because the processor can now optimize
> the clearing based on the knowledge of the extent.
> 

I'm curious: how did we end up "page extent" terminology? :)

"CONFIG_CLEAR_CONTIG_PAGES" or sth. like that would be a bit clearer 
(pun intended), at least to me.

We use "CONTIG" pages already in different MM context.

"page extent" reminds of "page_ext", which is "page extension" ...

> However, clearing in larger chunks can have two other problems:
> 
>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>     (larger folios don't have any expectation of cache locality).
> 
>   - preemption latency when clearing large folios.
> 
> Handle the first by splitting the clearing in three parts: the
> faulting page and its immediate locality, its left and right
> regions; the local neighbourhood is cleared last.
> 
> The second problem is relevant only when running under cooperative
> preemption models. Limit the worst case preemption latency by clearing
> in architecture specified ARCH_CLEAR_PAGE_EXTENT units.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---


-- 
Cheers,

David / dhildenb


