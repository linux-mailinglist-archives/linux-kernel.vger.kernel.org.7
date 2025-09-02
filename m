Return-Path: <linux-kernel+bounces-796117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11721B3FC21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB447AD1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0C2836B0;
	Tue,  2 Sep 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oaa+ABHx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2B283137
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808505; cv=none; b=XYPQTcRhHZv6hL+NspmdOf+cogypf3hMbc1jo7nJcq4NcDH6W40BvWXs47OPkeGgg+vHjTCt+igVkUDdTrD+TN/nR2fkH5wAupM3/lxOePd6JtfG7wghl+JDedjclNsQO8FiXtpCuiDXOXmfMF+eOmTh3iR2LS0OrBo1I5hFi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808505; c=relaxed/simple;
	bh=B0GvfGsaTN63/+z5SFAeDk0Tfe6MILeF1i9ssD86acU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cpSI+eNyaubrOON8F7FskaIBRUkC17AM0MJ0HirlXkBEHoBsNEPvYpXFlQCe1iFWa6L5/opOjMbX2gV4ye35036Za3tWKr04cev3+u1Sh/Bdsd1uyfg4/W3InZ5Sw6EBil17FzgxugPYSzzeXFIipqeBiuormP/m+PwBWM++OzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oaa+ABHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756808503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MGigtSodY2ufJETuQQ6JObO7ddBHNbjmaKCUTXaU8Xg=;
	b=Oaa+ABHxRhdmN6p8TwhOif2LT/RIxq3EG87gWGOucihO1sXPHTBaMO2BFI0Wg+a6EC4KHU
	ncpH92czL2IR15sQlvh6LuXuZBnTwgHhE4l6ZWW9fMxmWAFoJjGBDkGZ45R9YAYePqU6Cb
	kwrHteHZyF3YCYorR1xCvJTeb7DI1XM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-9G-EWlb5NUWPm25ZG-A9IA-1; Tue, 02 Sep 2025 06:21:42 -0400
X-MC-Unique: 9G-EWlb5NUWPm25ZG-A9IA-1
X-Mimecast-MFC-AGG-ID: 9G-EWlb5NUWPm25ZG-A9IA_1756808501
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d2edf6af18so1383960f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808501; x=1757413301;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGigtSodY2ufJETuQQ6JObO7ddBHNbjmaKCUTXaU8Xg=;
        b=CXQn2lE++6Is/AipuBeBuLK0PGo5HWbRTfksYC+eIz/5Dbt5e3M9P6eYcrBDFC1FYe
         d0XOtQ/S1cLbMyChCYPSEPIADdW5fWZ+82YEH4daj3uXEE1CGyYX5D7/Y4R6Tv1sJRwe
         nLMn7GjTn4pbKXav6cjYckuZ4Lt0bR2xnVlxea6i3PDK4/EpzvSTVaMIGcvbpE7xvIYR
         tR9qi09zLMeWtMoVpHjz/GDqbviOIO2w0rHUMuHFHGJ3jDH1tHG/Soj+xRR0qwHPf480
         GO0JLZXzTV4WazW2GESstYlg20iX8TivkhEXcjOBh3n4V0qOx6p8ZKlYcfynhXDW/uk1
         hRPw==
X-Forwarded-Encrypted: i=1; AJvYcCXDPo8gNaQbkWSnGF2dPUp454PkHz13y5PZ3B8anqbRdClO8qsUuNu4c1TJcBnfoKkCuilkWnLgycjo5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSM6t6zxLtRCRwFIWcWPqMHeAH4Tjwe+FI1Xk+TdnbxtN3+Y/
	lCzEAJPGmKl0lUbzCQKqHhEo1m7vhImhld34BYvv8Qt9VAmUaMMp1+hThFR7CHReZPWtjGifxgj
	BFoK1TQEy3S5Rt2Zx2fgBf6D6HUFaTvAV87I4JalMlkALqL6U4I4fDCWtD2hfnlzVjQ==
X-Gm-Gg: ASbGnctnpBE39PeT228Dsy1cb1CFDKpTtp4HQFkw9KD0iAy12IfJ56Zg4O6+Ek30IUp
	nd9skTI0s8hysqeSrFScMEiACFn2ac3xUKOt3/SpGaJgt5YfRL83NKmTR3GaCjKr9hThAbuUE/d
	MHutj7KpCRoS1sL1eTJyl7JCJxriGYLvvz1vku1rogihwGI/Kva/YEaHFJF+Lx1W5xWuW4saUnL
	6Ra0SHuU/4G5IGZhFOXAvjzevW2KKy97yNHB1S4xWdGxsAgOXUQEsAwQRxTUg5UHVShxidFVQwc
	/rjQl4wOkrDPIkKH5sxfecLi5MC2K2yYwxvUWT+7AkXTTT3pSAfgAMfvkSuVaRSZci3v76LnR/i
	piNyLgCsrlo081f/h6T3on8UYr1FddQA5Rl64W5YDapUQP92iOpMSJFKxi2R3DY2klMw=
X-Received: by 2002:a05:6000:2886:b0:3d7:7def:8424 with SMTP id ffacd0b85a97d-3d77def8cb3mr5101942f8f.24.1756808500772;
        Tue, 02 Sep 2025 03:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuwAQ5AtqvG7eXO2gkUyF/tXrtUAMsjJ9ZGj6VVfhIUzEBqb3ntAVaiYHv3ttfnME/tutQ5A==
X-Received: by 2002:a05:6000:2886:b0:3d7:7def:8424 with SMTP id ffacd0b85a97d-3d77def8cb3mr5101917f8f.24.1756808500236;
        Tue, 02 Sep 2025 03:21:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm274580235e9.1.2025.09.02.03.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:21:39 -0700 (PDT)
Message-ID: <387271d8-7ad3-4f56-b6da-b0deb0a6be6b@redhat.com>
Date: Tue, 2 Sep 2025 12:21:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
From: David Hildenbrand <david@redhat.com>
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
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-3-ryncsn@gmail.com>
 <911dc3b4-c511-4ef2-a159-091780987965@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <911dc3b4-c511-4ef2-a159-091780987965@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 12:18, David Hildenbrand wrote:
> On 22.08.25 21:20, Kairui Song wrote:
>> From: Kairui Song <kasong@tencent.com>
>>
>> Swap cache lookup is lockless, it only increases the reference count
>> of the returned folio. That's not enough to ensure a folio is stable in
>> the swap cache, so the folio could be removed from the swap cache at any
>> time. The caller always has to lock and check the folio before use.
>>
>> Document this as a comment, and introduce a helper for swap cache folio
>> verification with proper sanity checks.
>>
>> Also, sanitize all current users to use this convention, and use the new
>> helper when possible for easier debugging. Some existing callers won't
>> cause any major problem right now, only trivial issues like incorrect
>> readahead statistic (swapin) or wasted loop (swapoff). It's better to
>> always follow this convention to make things robust.
>>
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>> ---
> 
> [...]
> 
>> +/**
>> + * folio_contains_swap - Does this folio contain this swap entry?
>> + * @folio: The folio.
>> + * @entry: The swap entry to check against.
>> + *
>> + * Swap version of folio_contains()
>> + *
>> + * Context: The caller should have the folio locked to ensure
>> + * nothing will move it out of the swap cache.
>> + * Return: true or false.
>> + */
> 
> I appreciate the kerneldoc.
> 
> Intuitively, this should be called "..._swap_entry".
> 
> But I wonder if "contains" is really the right term to use here. It's
> more like that a swap entry "belongs to" (was assigned to) a folio, right?
> 
> Sure, we store the information in the folio, but the "contains" is a bit
> weird.
> 
> folio_matches_swp_entry() maybe?

folio_matches_swap_entry() is what I wanted to say :)

-- 
Cheers

David / dhildenb


