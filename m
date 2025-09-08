Return-Path: <linux-kernel+bounces-805898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD02B48EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BAB7AEE41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C730AAB1;
	Mon,  8 Sep 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwCsaa3j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604212DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337145; cv=none; b=T3WG81s44Qhqekhvok9UWEjy9xgpHd3Fo8OOIXHVWSHaSHFr41+yEV8az3Wh1N0GWVhTSzn6ipU1RohxL+vmjoyRZrTJjgD287/6rBPQisUZ0xxqzu091sCrVs032XKzS+ZNaxJ4HBVwEW/dMKXnVLMgyiLQN6fJuquh0TWG6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337145; c=relaxed/simple;
	bh=1RP336khMn5fZ31ExTEK4Ux0wujBoRCDsXGwwXOg5nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3WzGOsbN0PJhwIZLE2nhphuvhFiwVq0sNIbWB2RiyMEeju+q7IgLNs86yobxBnj6AeLC+JnGq6urDzzVyqhdBSe5qkiIK39i0AcRDTVcu2L18Asdy5TJLXuYzUlgImTRzV60qrDmxq48E/cI6/k5/O/hCVCWEuEzIkWTFxn2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwCsaa3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757337141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NVdkFKCmPF7g5530FhEEA3tNftM3aZu7xS4MKSbP0Fs=;
	b=JwCsaa3jyP3qzPN96BZmktbvapjSIzL5OSmRiyyCab8BiZdlZkhXFgVSztIFNIIrssxk56
	QUvSREOqCTQU9SdPJXD0vdJQrtQEH9pYcFnU0XN/rtWIpe555Luwn2IJSfpG1NH5mdEMum
	1FP7FspGUvBua0u6At5coijYZ/xjIXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-gfwtpdPdPB2UsITFxSNTlQ-1; Mon, 08 Sep 2025 09:12:20 -0400
X-MC-Unique: gfwtpdPdPB2UsITFxSNTlQ-1
X-Mimecast-MFC-AGG-ID: gfwtpdPdPB2UsITFxSNTlQ_1757337139
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb6d8f42bso41711285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337139; x=1757941939;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVdkFKCmPF7g5530FhEEA3tNftM3aZu7xS4MKSbP0Fs=;
        b=Qw4Svnofe2FfyJqf1JjJ3z4hTRsnuG22Rks1xnwN1DMxhw9NHwdNbbdbrFiF9h+VHc
         I6Oms/BTGxFLZUORQZlFH72EpzU3ZMhDZCjNoUU09pTJtIBcHNrAMHBDg5y7xB26HsOv
         9sy2Xn7zSNgD4c7SBbqEZdk+F1JQBtJlZSOlDdcHkz9U2z5neU9aoxF42MhGoMpGRCtw
         K4eqOXf01HLwC3REiw8TbsSm0jnDsx8D5VK72wgIBwyZJxT5O/2y9l1Bp8ZOeNVWPsIz
         Xdb8DzUb+x/804YrRt5RB4YPtwit5d0gWI68DxoKOdx2YOLVY0tBH0ICXVjDlt9ava69
         o8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWMepfe4yVpTlRCK1iRDVORuqJ3tzA3wRrKxHo247oiFn6Vy9CLyXQUh/Ac4qLs49ASUNP8ewWhrJ7I2no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4XwmkOjdZDga6WRuZWTeO4yn38eD9oeB3lb+pr0tYxaXIHlE
	Kc5ZuLCfaSnQG4VHQmUWbnr5lMEINg/6emWbDrFJTSCgV/sv4qeZtbRb+cVyO2nkRE8guA7bFEj
	uK8NLiR9gOjzLQoq9UGMrYO4p65WvA4y6pA/zYf8t9ONLF32tyT17tlDH0Mqe4Fqj2A==
X-Gm-Gg: ASbGnctDK3unNWbcEIswGEPhhJh81g3ACPkF4LKDu0U6NNk2paNXbDEG7bUZaW4KYAI
	cDkACqSiDrdesnrzzbIGilOpnHFTWN3lD87fjw95O0izTGr3VWZcOo48EPsc2KwGPkMXf1Kbf8P
	bRRONGnDR91FPKBTMVMSMGmiDKqWOJNNNig+/s9TtQ71VfBmxFJl1mkiK/cr0PXZOfAdT0xx60D
	Dci/o2SaTDg298wbiDjH+xej6o5N8qUgPZKJ6VZqEc2WtzLA8rx802kSWxsXFG+GJwgXD1RhG0x
	VayREbqDxZXo/T8TH9tQk8dnk5cO1zxHbfkpMNCUZ9VKBDxHkgRHZ55nViwyvmTh2WK+okmPWMm
	IBo6urwqUrOyPDvluyrdx1WlcD5KkKT3HNIJ0+qVrgjjiPOja2ru97Rn3NC4yy8CS
X-Received: by 2002:a05:6000:178b:b0:3e3:24c3:6d85 with SMTP id ffacd0b85a97d-3e6428cd370mr5582424f8f.22.1757337138439;
        Mon, 08 Sep 2025 06:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMHzY77T3B4Be+/wcknia2scoADUO2Ag/j0PAcMwAKcnKc9IwA34MqvzbL3j0SNw5l5SMTQg==
X-Received: by 2002:a05:6000:178b:b0:3e3:24c3:6d85 with SMTP id ffacd0b85a97d-3e6428cd370mr5582379f8f.22.1757337137985;
        Mon, 08 Sep 2025 06:12:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e74b2e0511sm2643510f8f.62.2025.09.08.06.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:12:17 -0700 (PDT)
Message-ID: <2100bf81-e9c0-4440-8c19-b04acd3ced31@redhat.com>
Date: Mon, 8 Sep 2025 15:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] mm, swap: remove contention workaround for swap
 cache
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-14-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-14-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Swap cluster setup will try to shuffle the clusters on initialization.
> It was helpful to avoid contention for the swap cache space. The cluster
> size (2M) was much smaller than each swap cache space (64M), so
> shuffling the cluster means the allocator will try to allocate swap
> slots that are in different swap cache spaces for each CPU, reducing the
> chance of two CPUs using the same swap cache space, and hence reducing
> the contention.
> 
> Now, swap cache is managed by swap clusters, this shuffle is pointless.
> Just remove it, and clean up related macros.
> 
> This also improves the HDD swap performance as shuffling IO is a bad
> idea for HDD, and now the shuffling is gone. Test have shown a ~40%
> performance gain for HDD [1]:
> 
> Doing sequential swap in of 8G data using 8 processes with usemem,
> average of 3 test runs:
> 
> Before: 1270.91 KB/s per process
> After:  1849.54 KB/s per process
> 
> Link: https://lore.kernel.org/linux-mm/CAMgjq7AdauQ8=X0zeih2r21QoV=-WWj1hyBxLWRzq74n-C=-Ng@mail.gmail.com/ [1]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.com
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


