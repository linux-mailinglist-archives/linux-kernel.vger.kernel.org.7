Return-Path: <linux-kernel+bounces-830204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F85B990CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584E918981D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CD2D593B;
	Wed, 24 Sep 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGUhDZ8Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA224E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705207; cv=none; b=SsAcxw3NFZQItr3JOXpES4oyGLLTN2OOVWj1s71WtduvuNuyjVXaRU/FY5rP9O2a6x0hdVAawkMzD/nZqYXYIsTww3HKb/4QQ1j68x6WZKQZkNy42+r4wOb9SRFhL/CI6n/IOcKTEhsSD6AdCVJ5cUnbJIbs4cUopDxnsAdNn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705207; c=relaxed/simple;
	bh=kH2XbkyhlbWqNrfqh4W2hJzZxCQXO36+tE3p3x+sTHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyhfvveFftpGOBpBIRMUKn7eG5AD6kMdNSkFxRkoP7/5Nwbwp8673P3dPkva4/HWYzDE2uJms1zrMnZ/Dijo3b4tfW0vHvLpeGTh4u0xUt3SaUXDFKHaxlJyICU8MxI1iq9R+plGx5kT9g4oTH34aBDyqbtj6zmWTOz92GTZ9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGUhDZ8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758705204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zX11camkE4Hg4H4xV/n8C7NJAv/AAjeZxxkMV/ADChc=;
	b=HGUhDZ8Q1koiE9Z88SV3s603VsvHpR1MSnGHNRNVpa+HexVOYG8DABI+f7RDmBt7SOutJS
	NIH4jMa/XPAZNoAaM6TyPoL8vZ3hmx4rtQSQt5xubqXNo0CAOHiDyqBQDP3+F8U4ol8wf7
	Abn9MK83iJNbL3hNEABAlzmkxbys10c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-lK557ytcMYGIbqOIP2rC3w-1; Wed, 24 Sep 2025 05:13:23 -0400
X-MC-Unique: lK557ytcMYGIbqOIP2rC3w-1
X-Mimecast-MFC-AGG-ID: lK557ytcMYGIbqOIP2rC3w_1758705202
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e997eb7232so2998900f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705202; x=1759310002;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX11camkE4Hg4H4xV/n8C7NJAv/AAjeZxxkMV/ADChc=;
        b=Dm43QIAdRT7sUVBfKWUpeR3/BGgZPLAof55lnhWnxGwp6MIZ+IUPhepixCYR2rzS0c
         vf5OHLxkkG08xCRk2S3BKu4vo/ATy9rDx3Y6hAGQtcPAvS1Z9f/DoosHQ67J7rQtOmjl
         /AhznPflf9JVc53GUY7byfVodbjPn8EQqOyd0CEzRNjwA9twtJ3kjNLbntL0khQ/Ws/c
         BVfjkrvq5vHmMGrome6g4/0f8X5gwZbHiPjrwwfQpxJGPCORagXOHv/66/xI3WQY13dD
         +SaDmlOsJDRsK43zuXSLMMf0ar0VMJosUTzYCisYfh223X4dIsamwh67cuFRXWzUifRF
         R6zw==
X-Forwarded-Encrypted: i=1; AJvYcCUYMAeF3u0sm+BJHRhYaHn95MAEO0MI91DrYLa8otBfc670yXw7mnYT2qe9m4SfXDrpPXpblXGhZ3BufJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIEVkrZo8+zwuxlCYHZJ+4FeSohiBpl/xOVva/COaCVlpescC
	3d3yUyOrnlgReBz2kwDhAbOQMKBhFEKpCBFs6Dr+NR9g9FIojHIJUR/sXkrKw/vsoFg/Qgiyf6O
	R6Lu7bFihdKyHSl9J3G2dali4GL0P6q/+KH9Ba9vzyPHXl4Z4+C7JPNbBhA8l1wOrGw==
X-Gm-Gg: ASbGncuLuj0t+Hz57cFD7zxiLmnh5nCHwDN4mLN2L5pLv0OwdwKQrQDGjECRqhF6D1y
	nZd5/AOeb1NXHlOQU2ofekkak9kenYKHT17riWd2u5EewZTT4jUsfCKjP005Qd1UF3ra6f1fofT
	w9Dfd3auY1i3aJva3u/20LJ/utTryaJUdvToyv9uUDlCvwzdhYPmV65cQZ0ovKichH55RaW604C
	nNNpA2EiA3RvV+5Q51VKEzTRgj1E83VJdUg55bwxTzVnH13bLrL6Fxd7UBb5URvOzh+IEwFJaki
	Mjt9TyKQvUXwpbH4ujQrPm+OIKawmZY1yJGeuOcEJJSVGekvdFZpkoMLKI18XXIyiDc/h74ZB4u
	OcyZr8W6i35183f7fEmr5dJvRO3J0Fdl7Wj0rKOqGc7uEvvAZBfct35davW/8OkmqvA==
X-Received: by 2002:a5d:5f83:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-405c3e2784emr5360072f8f.10.1758705202419;
        Wed, 24 Sep 2025 02:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBZFEPN12p6SWA1LtLwcoBT+0w/wHU0RQBUXQwTIxfVpyQEni4vEmdES/G/ydEaBnhiqp96A==
X-Received: by 2002:a5d:5f83:0:b0:405:3028:1bf0 with SMTP id ffacd0b85a97d-405c3e2784emr5360028f8f.10.1758705201838;
        Wed, 24 Sep 2025 02:13:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee15bfab67sm23593007f8f.43.2025.09.24.02.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:13:21 -0700 (PDT)
Message-ID: <17dabd83-0849-44c9-b4a2-196af60d9676@redhat.com>
Date: Wed, 24 Sep 2025 11:13:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Catalin Marinas <catalin.marinas@arm.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
 Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com> <aNLHexcNI53HQ46A@arm.com>
 <f2fe9c01-2a8d-4de9-abd5-dbb86d15a37b@linux.dev> <aNOwuKmbAaMaEMb7@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNOwuKmbAaMaEMb7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 10:50, Catalin Marinas wrote:
> On Wed, Sep 24, 2025 at 10:49:27AM +0800, Lance Yang wrote:
>> On 2025/9/24 00:14, Catalin Marinas wrote:
>>> So alternative patch that also fixes the deferred struct page init (on
>>> the assumptions that the zero page is always mapped as pte_special():
>>
>> I can confirm that this alternative patch also works correctly; my tests
>> for MTE all pass ;)
> 
> Thanks Lance for testing. I'll post one of the variants today.
> 
>> This looks like a better fix since it solves the boot hang issue too.
> 
> In principle, yes, until I tracked down why I changed it in the first
> place - 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to
> the zero page"). ptrace() can read tags from PROT_MTE mappings and we
> want to allow reading zeroes as well if the page points to the zero
> page. Not flagging the page as PG_mte_tagged caused issues.
> 
> I can change the logic in the ptrace() code, I just need to figure out
> what happens to the huge zero page. Ideally we should treat both in the
> same way but, AFAICT, we don't use pmd_mkspecial() on the huge zero
> page, so it gets flagged with PG_mte_tagged.

I changed that recently :) The huge zero folio will now always have 
pmd_special() set.

-- 
Cheers

David / dhildenb


