Return-Path: <linux-kernel+bounces-861411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A7BF2A96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D56694F9572
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716E331A51;
	Mon, 20 Oct 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQYLto2c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C2331A4F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980486; cv=none; b=JsxmcJTdSJpyR6GxC8E0szyKjBGiRbqwy+nkZsATppU64cdwMeU+QK1ADeWLcaWoLmggsC9HzHguPG6i3OzLsc87omAxVQgbqSrEEB39dDrbW67wWYFTkS6m8ktGG2NgyulX/MvcImUIJ77xIYsGiHWG5ageYzw7WW0UO3HVmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980486; c=relaxed/simple;
	bh=llulhObElUJaBGlm9QVoCSRVjAIqP4HieNtor18ZDgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0thVR9OpAJK7Mh5AYLQxOJzrWB5475yJ31Cv8Zyui4DHuUZ9Duw/GY6sqhPg2yLn+EduZzhLoMDJppeub79PCestJxN02+24sZvWlBFzuhAF9Z1zBIKrBctYMUyrFB9CjXy3kKsIv8opLSlip9LhL950zDPuWBIMBgpZv/ZaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQYLto2c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760980483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jOo8sSkjO6IqXwpAf6xmw20vCIDM4jZaCqO0cufoDbU=;
	b=NQYLto2c7olaAYAO45GpqxUpnvRhZq0mE7ltTW3JZ6uR/b0zcU6g8FmgJsYmeISA9E0JIS
	ztpkcjlpczRsNQhgqFm4xFabzTrGFltS97tV97d5/HsPj163Dud9/Zf15KP6AW7m9Z1P9q
	1wt65/ojynXAsbJlwCqT2nZStfvLe3Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-iWSJua8sMviIT3Ghu56CeA-1; Mon, 20 Oct 2025 13:14:42 -0400
X-MC-Unique: iWSJua8sMviIT3Ghu56CeA-1
X-Mimecast-MFC-AGG-ID: iWSJua8sMviIT3Ghu56CeA_1760980481
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so28674885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980481; x=1761585281;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOo8sSkjO6IqXwpAf6xmw20vCIDM4jZaCqO0cufoDbU=;
        b=PcFsGuQrWsPFu2XoRmI63eJmB2GjFZ85tDk+uSPq9KfkVlRY8JqgnLyB/c8YZQEjTO
         OA9XDnhpSKDEMEI2C9H6OyPN4/34xbUZQ813ujWecR/DUaUiuDBaIpBnU3cXqboXr3xz
         fSkq/nT3iU8C2WkgDRGSgwd2aYOa3ovhycr8p9LHGtHxxl1p20F9M70VTaiJ+k2wBMgE
         vBR9Gil44kW5wYhMPrJda++U5pDANblqQm2JZjyMyUViwsNUl6PXGTofeAix5AQheKSv
         ruwbDwdU+s6W/nv3jGRr4Ev5wzwky/2pJPvC17Ig7hysENFy84nTRnZFm48hb66AOapP
         qSuw==
X-Forwarded-Encrypted: i=1; AJvYcCWpeOxUgL4ms6SchzeAsxSSUlHq0+4Kh2F/0eXRHHefXoAWjUPH1LWyQ7/Bxg5eNiU0qyli8bXapZADJvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUX4RNPysZwpaKNHSL10u525Bczt6hhGpswDAloRl30PlhKYRw
	FVDOdYZlY0aZd+7X/als3oJ+2rOdAjDCuopsgMJN18hYNlnNrOrtlFch7qcuJ2JYm2R0zdUeANZ
	EnizuSR6qb5eJgdSKVD3QfDmKvbfUi4ODnnDJHdEHbFRVEFQ3yJFIKB4J6Pb/KP+6mg==
X-Gm-Gg: ASbGncsu0tYNw0/23sU/knkY3vSg81Kqefi4SdqpoHLer2zXw/jWvkOr1hHYved1ZXQ
	/3jzasOAFM2dX/pI2b6www1ce+HFoel+AJ+QnbzXax4N5NwO+BhdaiyOg+HmDb8IrA0qAZp+urO
	TR6/jwkO4izo+wGjQkvMXRMWqqXU5vpWoF3LL0RIBCi9MADa/LJNCgCcuqK/jGLu4M3GKsQ1vkc
	lb0GN+OQ0+fZWg+R5iall2bghQDoLd9Q9UOtFN1HKyDv8N0AlZgi1rOa9seQTn/4w+0eh9BTuVK
	lbr9Yyi/og0o9lkqPvAu+TKgibuRk0Mp2+bJG3Et5SEfGPczTKJxIPfSdGAtRlQVAX1h1DaG5ZA
	d0cO0HfwaSs8MbcfJ8uSNC240QeRNV92+8IO+L5wIEmBEKc+2PbOZheZqxGyxQHVoTo0ty90HDf
	DymXu+7SgZJQfCQPt5BQy/et7t+B4=
X-Received: by 2002:a05:600c:a14:b0:471:15bb:ad7b with SMTP id 5b1f17b1804b1-4711786d60fmr114510765e9.6.1760980481113;
        Mon, 20 Oct 2025 10:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8NRNx4nYPhA+W0IOT6snNINaoL5GUqLW2Ls3PoZCFthWEPF4dmZ6SAwarpD3VHDiHrF7rzQ==
X-Received: by 2002:a05:600c:a14:b0:471:15bb:ad7b with SMTP id 5b1f17b1804b1-4711786d60fmr114510565e9.6.1760980480656;
        Mon, 20 Oct 2025 10:14:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm241641755e9.12.2025.10.20.10.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 10:14:40 -0700 (PDT)
Message-ID: <81fc5322-6ab4-4830-9b2e-15d834b461c2@redhat.com>
Date: Mon, 20 Oct 2025 19:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
References: <20251020151111.53561-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251020151111.53561-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 17:11, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> A non-present entry, like a swap PTE, contains completely different data
> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
> non-present entry, it will spit out a junk PFN.
> 
> What if that junk PFN happens to match the zeropage's PFN by sheer
> chance? While really unlikely, this would be really bad if it did.
> 
> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
> in khugepaged.c are properly guarded by a pte_present() check.
> 
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Works for me!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


