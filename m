Return-Path: <linux-kernel+bounces-826776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0975B8F51F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7637AC5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3322D9EB;
	Mon, 22 Sep 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3uSviET"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC50265292
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526904; cv=none; b=XGr5ZiFuvlsSumT7Wkm+vIN6MvAd7ODgVcny8bbbj2GW6EKGx66vhgDSMEmpVbzc3y6ZmGzNdA3u6mClqWzxj9f6nB4dB5xRzd9QtYMwEmBxn3D5F352CD9F9aw7CyDe1L9xJHqBlk1Rxza2B5PA+3uf54H7NRtn/JmY02d7z50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526904; c=relaxed/simple;
	bh=CIt7mNq1V/GTrRk+v/G9FSEyld+lWE6vvlvl9cPEqkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in87e+3qwwWC29leQgFFTV2AgGo6t4i7kcJu13wZju5XrzIrMGvhZ+8yyca9dgG0CdpSpiAaGW6A5JL6YWAosDSmHS1cN72ikiuNqNKUB0E71+SZyabR4siybu77jYrrjEM8gxc5TE/mhyBZNwRSRWii/lFdF6+++FMEBjR8TrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3uSviET; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758526901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fzHIUQbJNzpGAehghm14zuXxtLTVpwy94eSLphrZ324=;
	b=U3uSviETBw9QvzfoBI0ae571TW/RjiTeHaxS03i3UM2nwDFurXdtw2vOaRgtuHwE3mmSGK
	d1KvQx8ZgJBV2Q/NwUNli64Ul1D67NE2tibP9DFs32VDKL41rblAT05FCfbNx19zVOKlFR
	GaeTeP111etg1U7qsn9/1WJANx5pYRM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-0wa4RYWgN0GOe_VGfiVTYQ-1; Mon, 22 Sep 2025 03:41:39 -0400
X-MC-Unique: 0wa4RYWgN0GOe_VGfiVTYQ-1
X-Mimecast-MFC-AGG-ID: 0wa4RYWgN0GOe_VGfiVTYQ_1758526898
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f93db57449so705306f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526898; x=1759131698;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHIUQbJNzpGAehghm14zuXxtLTVpwy94eSLphrZ324=;
        b=WYdlAmuKSRJAO/mRwPpDWla3n7BPlI7ypaM3InxT2bGYSyKSsoAH3lhsjzjD4MRRid
         tXu/x65kDB8NCxiB00djd3FgMlt7CDASrcihtCMoJMN3CHjFgpZIE3eL9XIMoEspDsUX
         +RbrcUnrrK3l8CfXlr/HGYKJUeGciYIVgBcWx8UkWLxJlL3xZqG1BO8AUgn+YqSrFe1J
         uLXVctZE2BosaOdWIbfd3nmnZ6Ps/akJaktLtJzCtdxJGpZu8WbX7PzpMi1D1ycgJx6j
         /s+IH7Yc480ms4GLnvBhAzoLAnxRmOg35JEGzrYN3zVzKWiqm8phc8TZOHG2JAuSaSBk
         RORg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJJRbH61yiPSOPC7eXCo8VzQuLApwPBbWcvPlqOXZ1JT0Plibqtwtqvb1dSyddI53CwTH0yStMkJljus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeY2Qnqlkau8c8MSx8Iw6N4L/vdHlvtFm4zTRBEsD5FiC9kTRe
	r8CQmxih9tRAAMbyO8JzL8rJY+0yRb66sgPqxs+oH3QVpu3lIDZED2NIA9eTac09AXZiZDUiOtR
	bt8qlaN9Doe+baJlg5CG731r5sBSm9C1qadVb42uFATY6+haeiiKg59EIOObKYFvk3g==
X-Gm-Gg: ASbGncv1i3C5CU8xLcric8j3/112nQMgxy73kWX4HHr1QJAXyPMYQR0Jo+bgpjhTHAo
	oI0WEKU7wO/IKzDOaLAtkW1gnARlcJAOYJl1pI75TwwGZAp+1C9sfdyDdzflFNQC+9i9ly0fc1Q
	LlVhyju4wqFnXkD1Eq7e/GerZ9BjHJA+hQ62LJOikTorppaU8jKdWahwHUtYILYCc6AEymE0B6P
	MorziAXP3PmtaQ/vtpl35biHnaO/UGlXWNAyuqpg/T+51WOWUxzD3riYOU+H61OzO/cN3q29X20
	1qazPqPT4hxufk7nHLl14z70dJlM6We2k7D+6PSLzyYsm/vPefrwYvWdv/Yg2tHD6m70baxKPrt
	fbulOMvrAwMbALWmZzQORXAakFLEfXW15FRw5pO7Vy3n0ltvDDO6/vSETLeFLl0o=
X-Received: by 2002:a05:6000:2203:b0:3ee:1296:d9e8 with SMTP id ffacd0b85a97d-3ee7e1066dbmr9258915f8f.17.1758526898185;
        Mon, 22 Sep 2025 00:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9B1weiPfO6bMVbHAqxOgbive1f1Crq3xoi47kw3u1f8xvVepvQI2XfzLgozHSVwVEVQfJTg==
X-Received: by 2002:a05:6000:2203:b0:3ee:1296:d9e8 with SMTP id ffacd0b85a97d-3ee7e1066dbmr9258869f8f.17.1758526897678;
        Mon, 22 Sep 2025 00:41:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407cffsm18716189f8f.16.2025.09.22.00.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:41:36 -0700 (PDT)
Message-ID: <111b1bfb-e2e0-4b2f-a559-9803828f3406@redhat.com>
Date: Mon, 22 Sep 2025 09:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
 Liam.Howlett@oracle.com, catalin.marinas@arm.com,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, kaleshsingh@google.com,
 npache@redhat.com, riel@surriel.com, roman.gushchin@linux.dev,
 rppt@kernel.org, ryan.roberts@arm.com, dev.jain@arm.com, ryncsn@gmail.com,
 shakeel.butt@linux.dev, surenb@google.com, hughd@google.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, qun-wei.lin@mediatek.com,
 Andrew.Yang@mediatek.com, casper.li@mediatek.com,
 chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250922021458.68123-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 04:14, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When both THP and MTE are enabled, splitting a THP and replacing its
> zero-filled subpages with the shared zeropage can cause MTE tag mismatch
> faults in userspace.
> 
> Remapping zero-filled subpages to the shared zeropage is unsafe, as the
> zeropage has a fixed tag of zero, which may not match the tag expected by
> the userspace pointer.
> 
> KSM already avoids this problem by using memcmp_pages(), which on arm64
> intentionally reports MTE-tagged pages as non-identical to prevent unsafe
> merging.
> 
> As suggested by David[1], this patch adopts the same pattern, replacing the
> memchr_inv() byte-level check with a call to pages_identical(). This
> leverages existing architecture-specific logic to determine if a page is
> truly identical to the shared zeropage.
> 
> Having both the THP shrinker and KSM rely on pages_identical() makes the
> design more future-proof, IMO. Instead of handling quirks in generic code,
> we just let the architecture decide what makes two pages identical.
> 
> [1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

LGTM, thanks

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


