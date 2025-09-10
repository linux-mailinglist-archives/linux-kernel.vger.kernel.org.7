Return-Path: <linux-kernel+bounces-809797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2AB51226
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD13F167B06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1540311960;
	Wed, 10 Sep 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE1/dD9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68C20E6F3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495358; cv=none; b=ZdFb+a3GnLWXkjVmfh3EIj48c7R4rICKPJhVt8pIoGUN1NwCAsghRrEKOa3oQsd8RT2NbbJZNLEvYPYyUvLG5wI3XLkVKvsZozerDX31JLfRAQp8rK+7g/Jncaxd7rclDjQh3gcueiO/C6PeBMwJSw9ZSfEmGCDwj3YQ7ld2H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495358; c=relaxed/simple;
	bh=6ZmyTAawiwXdSGNnTRhr1VedXh3mSKi5XFcXsJWRlRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ItHNZHEZ4GuO+bFsDPoOWV2dGKu6EYsGJOl0DjBz6aHsTcrhp7zR1SwrXqJGsOZM8mzMakQoRLSR2G51HfazuchEdv+uQ+F3fF8JYemUZ5B4jg6rYKEyGtVXXfZn8TD1C8YuX7uJG9usPbBb0g8b8QeNjECMt0a2v1AeCnxf5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE1/dD9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757495355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tTNgFDBJshMShsKKr7JoAqLRJC/3PHrKgQgN+0T2LAs=;
	b=XE1/dD9MuuNRY7l94c0BnThK7LAZCHXCChycmnjudbioo9UxV83xP4Bp09i/L/dg4AXsz0
	gZbWTN0iQeph6Rs78c5uyNzhGgdaY42S4zF2A6F9Co0dTaCO8n2UZo7unO2h4Rh4A/mXEL
	nLC7S87dHZzVP4XgwLim48E2XsLvYU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-MlLWdZ4EM8aECNk3PWPqmg-1; Wed, 10 Sep 2025 05:09:14 -0400
X-MC-Unique: MlLWdZ4EM8aECNk3PWPqmg-1
X-Mimecast-MFC-AGG-ID: MlLWdZ4EM8aECNk3PWPqmg_1757495353
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so51700725e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495353; x=1758100153;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTNgFDBJshMShsKKr7JoAqLRJC/3PHrKgQgN+0T2LAs=;
        b=BQSjTE7Mzdpd9g4YduLfgBev7IoDVe/YLe3N/Llof8JS13ibxuZ4IzjHSt8/213ID+
         4yBzL0wI7lGC/6nnI77cWwOGvFUu8eAgBjoqwYjZEs2LOyYruD9aO57wdAuJoJvpK7g4
         YvB9E3wsPNKbSK0nLaRb1o/a8C5OEswrtT/e55hQ8mSvQL8AzUdYWWMe8eRIM3nM2Hfr
         f1QVzK0LTm2WMX5w/TZa9nu3lZRQvOayyqTs2Z3iaz5oIclv3gZ8sUSff0KLJzR90vc+
         iRKbZL65C+waWDPIDvyJijvFdpkjkY1A/dbRjxqJWLXYSn8BLja4ye+bYC83cdfkxcHN
         cJRA==
X-Forwarded-Encrypted: i=1; AJvYcCW0O9yK4Sb0Eah03mFNaCPTg8BVvoMCbvh4MjARYRYoSr4FobOM1SjjJxilHf/vF7hVCLinje2nr0t5IaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYW7+38O2kyMFZZl05oj9FPy4J3eBIsgtAijUIs37V3jfs7RO
	goGuZE9OmwawL55iNEWTyzAA3k4WUFvHG+ZOGZJTE7UYSVOYPgyHwRXF+VyC6QHK24qPjjUtEWv
	l9L57Nk9b0gE87LnTrlMqINN4NoXcbj+Fa29UWGNSv93mObT2UQw6vd3HoM+VyHvrkBl2SDlP0w
	==
X-Gm-Gg: ASbGncuMcCPvaTAzQwJeYajfbGvvb0/PSon1woCkm4TCZ22rz2VAYa0hgqri4FQZ1Y/
	ynUd4Tc6RpzZ+dfPwuQFV67tDV3g73K+1uLCB08U8lVvEsUW6/vv1pH5AlPMBaRxCVh5ojtVNb5
	CwBDPBCL9orBSLYB9aOPBIWcQx7mUlDH7682wGQC7FDg0H4CdjMm1xdPAtPfhQdlvxLAiAtioUn
	UxA0nqZ98N1/Tz4cyPHZmJpVq4GCNOiHjqHSaONVJJPSjffWQHWwvrt87Wtih54aE/lXCLOca3q
	D7JRqezIGBRG2gNeHZmAZtTiTNsRJ/OI4Xeeqd6gt0ynVyyz/18DHEMrd1YeCfUBSnS6bJyBDU+
	zfOc7f0SiANvyXI74kXwiCBMjfoLPq15zVDnbLdpQ+EwLjpxI3l5JKQw9s/Vf408yMpM=
X-Received: by 2002:a05:600c:1f87:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45dddebfab9mr127597135e9.19.1757495352841;
        Wed, 10 Sep 2025 02:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFTz8v2ml6j4Meo+4Bxvl5aRHnzamEhWFdxrtd/cMtm0FrmC4Ofx4NSzU59gCksg8a3qNFCw==
X-Received: by 2002:a05:600c:1f87:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45dddebfab9mr127596905e9.19.1757495352381;
        Wed, 10 Sep 2025 02:09:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd08sm5935249f8f.4.2025.09.10.02.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:09:11 -0700 (PDT)
Message-ID: <b5169886-1216-4d49-85f1-437ad7063fd3@redhat.com>
Date: Wed, 10 Sep 2025 11:09:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: skip report_hugepages() output when no
 hugepages configured
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250910090316.3406-1-lirongqing@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250910090316.3406-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 11:03, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Avoid unnecessary report_hugepages() output and processing when
> max_huge_pages is 0. This eliminates redundant log messages for
> unconfigured hugepage sizes and saves CPU cycles during boot.
> 
> Before this change, the kernel would always print registration messages
> even for hugepage sizes with zero pre-allocated pages:
> 
> [    4.118953] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    4.122920] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    4.126920] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    4.130920] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> 
> Now these messages are suppressed when no pages are configured.

Well, there is valuable information in there, especially given that we 
can allocate these hugetlb pages later.

So I think we want to keep printing that information.

-- 
Cheers

David / dhildenb


