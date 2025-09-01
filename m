Return-Path: <linux-kernel+bounces-794306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF09B3DFD1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EFB16258C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECE30276A;
	Mon,  1 Sep 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEGgGXNB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE722FB995
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721460; cv=none; b=tqxoySGysTdGDmMROboKYICbZWAIznUX4qiooEbGLtWC7vmGCzsgDFDCpsXwIJGJZNTQ9v+9LboDNzcsB0GzYLSMcw81ZQwjLQW/P6g7FzhO+1YtClNN5lzejvCTC7Gq7Oj8eHLPZJiq4yuIG0+r/orAuQoNE1RLffUIT5kEgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721460; c=relaxed/simple;
	bh=wuw5HwKKAAcdMYrx1NIRsmUE/IHsppWJ/58eY464t6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hHwn1tAGyY4eylrJMV6CbEKZYGvjK4JL3BnUxONFXmpTsXZYdhPJCDuRttyKMTgI9V6vNn8lcCMy3n32nwikx0R0c3AoxAymdVsHIgrf4lRywCrVz2vF5iwr6jWaBc2mGAXjO5AYlxdXEBPN+DnnTsMgPNQsiJKGKeSWFQQTsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEGgGXNB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x1r77G1I+YAhnNLUu7tbtbLLJ0PDDPLqHjMHvRWNWBs=;
	b=QEGgGXNBkF4XBX0n/FZRBgP/BueqT1kj8VtehWq5Wt8tC/+/AlkPsMFN6Jf5+V6Is7Ho6m
	NFZ/yqwvZVliSM3PAY3SsjdORWwsL0lvZCHW3AbEtcCsbNFbIBG0SfckZvflnCcljQa+FN
	n4JlftMAMfnZVodNDC+pv4qVv368dYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-hstLtisONauubM3q-3D9cA-1; Mon, 01 Sep 2025 06:10:53 -0400
X-MC-Unique: hstLtisONauubM3q-3D9cA-1
X-Mimecast-MFC-AGG-ID: hstLtisONauubM3q-3D9cA_1756721451
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b8dde54c1so3743745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756721451; x=1757326251;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1r77G1I+YAhnNLUu7tbtbLLJ0PDDPLqHjMHvRWNWBs=;
        b=m5Tt+2u/zifhs6chSxBycdfgk90sW9miy34zscw4EJh2SjrGI3wM8t5aDIc2AOga4z
         M6AZ1eJPXfVYdrC4jZdA+rckzBgTps6GeYOyAVICDZ0sJASz0u4kB5J2cT2/frxk+CeI
         umeIGBZhiO+LKR7a3sGzS6+9ktbq/g0DMDtNJv10sZkyUpMA11NUFI+IFWfQKRHadfvH
         DZY4Gk1CbWym7z4DkwAGrGXZl6r04xKZOWi9yGzoFsT6LHr9DlxAaou6ADGskhKoZg5i
         e1xvnbQtlYqJEBdtI1TfU9vo+J6/KXD2tR1hlUrkICRMlYnrCttT/7U3p7Odz5DLZf3O
         C2gg==
X-Forwarded-Encrypted: i=1; AJvYcCWw9ecDLiOwtrq6mKHnceBNCS0XzhLTk4ZUVcEHCeZIoru9NDDXst9lj+jxwj8PYyvFN6FuyFVGsHvTl+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIUIlx0DNTHWqosHWgp3sK3zK/zPb3F4SI9imc55TXxsC1gq7
	LL7OJ5EENf7h8pkUm+1HaD6Wwg6Tg1SYo8aF65q9yXrVRcC7iv40vFeQ4xcp3zil8bnovIIoMyW
	gpajgrp6CAoFlDxBUMd1z38JpKoingos+p+em8QgQ3usIFHrOz3dM0jwTJLPuu69Brg==
X-Gm-Gg: ASbGncsWUAIdQw1bPkdrkKf5lEnYFQtJK7Zn1xjgdnmWXyJw04RKPkgA/DBJ0TLoGTf
	oe/JcJRt074FGygtylVothQoTtea4MIUmvg0pqbOV1z3q49FzMX0RVah96lXz3V9DeQwTQQwTkS
	cdMBt8Mo345UbfZ/tioxp9dkQp1Eo1cBf9kpU/psBXCcmpbcan7TGn3L9k/zeIkDZdBfKlAcRrx
	5NVYsz6FaLYSUJEzvIjiir4pKtVSjhktCtNmH71WBuJ2lVr1odi8inBYNHZke0JyYLZdfaqETZB
	vcVAafD456niQGtwLHHum6LOWyuVimwDiMQCAxMIaCZdmtXqVedxjKb2B5/vn+7HYVEsNQVmdAy
	s+XRrJiwxyAGvAkrBBmy3PEePtTu26oq2w/xWqyFBcNWmt0DRvU4vOD+KVfSKR7Ab/Uc=
X-Received: by 2002:a05:600c:4513:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45b8553365bmr59920635e9.12.1756721451086;
        Mon, 01 Sep 2025 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/pB/nOXPtBGdoQkiiK9Gd1JB7dU2H/elG/tgXsoU6tepvnwbb4MgRHWoeOy6qaR11jLv+LQ==
X-Received: by 2002:a05:600c:4513:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45b8553365bmr59920425e9.12.1756721450637;
        Mon, 01 Sep 2025 03:10:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm147030765e9.10.2025.09.01.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:10:50 -0700 (PDT)
Message-ID: <9a85a903-ac8d-4198-a8d4-01d70f23b443@redhat.com>
Date: Mon, 1 Sep 2025 12:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v4] mm/hugetlb: retry to allocate for early boot hugepage
 allocation
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, giorgitchankvetadze1997@gmail.com
References: <20250901082052.3247-1-lirongqing@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901082052.3247-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 10:20, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In cloud environments with massive hugepage reservations (95%+ of system
> RAM), single-attempt allocation during early boot often fails due to
> memory pressure.
> 
> Commit 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages") intensified
> this by deferring page frees, increase peak memory usage during allocation.
> 
> Introduce a retry mechanism that leverages vmemmap optimization reclaim
> (~1.6% memory) when available. Upon initial allocation failure, the system
> retries until successful or no further progress is made, ensuring reliable
> hugepage allocation while preserving batched vmemmap freeing benefits.
> 
> Testing on a 256G machine allocating 252G of hugepages:
> Before: 128056/129024 hugepages allocated
> After:  Successfully allocated all 129024 hugepages
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

Thanks! BTW, it's interesting to see such extreme hugetlb allocation on 
machines :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


