Return-Path: <linux-kernel+bounces-820490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC44B7EAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973074E3036
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E728489B;
	Wed, 17 Sep 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHQy4n/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137361FCE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105156; cv=none; b=tQphN0FrlVVGqZiFo7Wign00a7EkaVdWmNZ7keXfZl87iwIwYs7RDHdRS882vCw6jG/f5IElAVYuSGL5jk0nV9bn6wpKybsHyVPTL8oiUofiIWIxYzsxnDF3sPvVnXgXV5eI4Do2aOgdjNyP1rVDbNR3W8J1K2rQ4xsuu+h3mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105156; c=relaxed/simple;
	bh=XeTO+9GPKv+RwSMb/j6hPoBz2m7AXPMe82RZklcGEks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBkJKMoiEkPzQb1UtbEB63v9dPTHCHWbQwrRXh3zaW/6R4xJ6o2e6Gc6lrSSCZaoM9mdQs8SRq3pBfs3nhhtpOLLmNYX56TkHC0jIznh7A7etVen+Na1VFPCJC+dg2jmnqDLL/5qZUCeFW1igfXhL1im6ruMJ1fOssJi6VCAd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHQy4n/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758105153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BlRZ+feMVJI9HrMKZRZihA3w6aJ6vv6AK7D0hZyyfXU=;
	b=IHQy4n/23l+5XktAwOrazWxdS62bfi5YSaOrL4mHRhyaL7Z6iMgZSAbblFNvxRBvnRxP0X
	0cMETVdIfyqjKiWlfCE3/657TGMzQXsyajgSrYE5EUjAYcS7A/0YYWFOt370k2fhOrKFaP
	CCaU9lxoP13ZZIOw2ngbU3ZxmMCaA10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3uaS-MxAPiuc4ZtKLVozGw-1; Wed, 17 Sep 2025 06:32:26 -0400
X-MC-Unique: 3uaS-MxAPiuc4ZtKLVozGw-1
X-Mimecast-MFC-AGG-ID: 3uaS-MxAPiuc4ZtKLVozGw_1758105145
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2f15003aso20422665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105145; x=1758709945;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlRZ+feMVJI9HrMKZRZihA3w6aJ6vv6AK7D0hZyyfXU=;
        b=hF1Eb1/AT5MEj60wZc3eBLZ8aUrlfk5Q8HbBgnHEHxUOb0ySdqWFh/S+2Ga3cBAzNq
         VETqeWf8OkUt6yS4BDVGY4us6Y39VM4ZAu4uDX2aF16HxCBAV8KH0RipBhmwDp0c0Wze
         Wl2fhdbuq6kEc2ZucBbRD9r6x2GZ4DWbibRiM5rPrgrPw/YI9ZjJdqCY9jp7NwMCtxma
         JJ+gain3R9uttMvZwuzykPf0ic0X426PamvNRvnd+VoKJYPcy41I4nyy1CMjqPC4Mgxa
         82Xb+k371gqUPov2d84oqrsruUfq97xq06NMIvtBMdWZTq/BBImB+pxYUL8MYdj/AjTF
         mtBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMpU/iAHhBX01QRX0qsSb6nj6IKhCByz1Gxv93cpha13p+NZGXXmpuTm3a0KNSQGG/J63WgI8aDfMZaiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJgWl8X8ShMx5Qbiv+jU8fQ4a5+q4HpFapWdPXc2XFRIBONmt
	ycfX3H1RmVhodGrP5ObMqiqg0/WT7uJSkh6Uq5qIGgjLvIh4uyqKSTr1d0apzFGKFmuu78b7hl8
	JnR6z4eyRr7ncLaT9hGfSZEnL6Ji7MM+BN2ON0H3zmJ8LuqcmdfrCFKxBI14kixTQCw==
X-Gm-Gg: ASbGncsUZtRWmYzaU7PV6EXfaPwRj5sD4EAWveuFg/dLcbB8XCTwRTnk02Xp+JT77bZ
	k7ywmN4OopVzVeC76xiYputhos4KNvySwUQzX5XLpGHIY97IB+7LtHU08xl67Qms6E04FW6ZiZl
	9jtmb8Smvj+8miDz8NTtWQ8I4jYK6ZC+v5CUuj0KcuOaDJNMrLcUFsNfqJDkjPGDasyoR16EHjx
	g/MeXGrOX6Vk5hFEWu6YZ9kHaVb/eaIrlV2pbuFtfBXAIP0xuJ2UjWT2hMMuIGOEPLD17Y8/p1D
	W0MpWHDTk6LdVmkJG+Woa0Xb7K7f2HM5bI17dQH8gyIxdO0J3L6ffzZeXNAtz0HDHFsLwDKAX/i
	4Ba9YWp2/yZXLbVOCgLgNp2ajOT+tC9XcGzpr2D4Nmc2EmQs9xfhzI9DVXG9fvGEt
X-Received: by 2002:a05:600c:350d:b0:45d:d2cd:de36 with SMTP id 5b1f17b1804b1-46202a0e76emr13132455e9.12.1758105144872;
        Wed, 17 Sep 2025 03:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpso+eMJMa9j+B9L21VGPP9MNwi9qIP4ozFnYckAdJluKclxzsmvXDG22KG/4dHXM6tBuXAg==
X-Received: by 2002:a05:600c:350d:b0:45d:d2cd:de36 with SMTP id 5b1f17b1804b1-46202a0e76emr13132085e9.12.1758105144387;
        Wed, 17 Sep 2025 03:32:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3211e8c7sm36470345e9.3.2025.09.17.03.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:32:23 -0700 (PDT)
Message-ID: <ee7e0841-e9b6-4a91-8b6c-43252432516c@redhat.com>
Date: Wed, 17 Sep 2025 12:32:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/3] mm: clean up and expose is_guard_pte_marker()
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Kairui Song <kasong@tencent.com>
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-3-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250914143547.27687-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.09.25 16:35, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> is_guard_pte_marker() performs a redundant check because it calls both
> is_pte_marker() and is_guard_swp_entry(), both of which internally check
> for a PTE marker.
> 
> is_guard_pte_marker()
>   |- is_pte_marker()
>   |   `- is_pte_marker_entry()  // First check
>   `- is_guard_swp_entry()
>       `- is_pte_marker_entry()  // Second, redundant check
> 
> While a modern compiler could likely optimize this away, let's have clean
> code and not rely on it ;)
> 
> Also, make it available for hugepage collapsing code.
> 
> Cc: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


