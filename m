Return-Path: <linux-kernel+bounces-805792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B76FBB48D83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908031C200C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E2211706;
	Mon,  8 Sep 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkj2NyBS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320413A265
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334611; cv=none; b=MqSTeQKRk1mGywBAFsGUuqYa/c642rNwAK/yENLlOyaKdCWg9ArKxULlcAKyvWHoJjmK52DhbbEYP1tY8fCPWT6QxWknTQQlkYmEIuukJmaF1uvSVRbxV8yaNw8/kaflushmxk/Xk1j2LsEA0WiDGrpplfbnTHbWSrv3hhD73aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334611; c=relaxed/simple;
	bh=O/v3GepieJujIkp+5gGrM4ScBpsXmPWauW95ePfFTSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czWemNCbWSDhTg7W8aVEqX08OMWjIuenyYsFlQtwbtK/9ZP3TUpbAlZcs4UYEFKTk6OPWUcFSGHE32fGB2pEs9u/zNAHpMBwEd0RQmLgbleop7wyoZzI2mwOlijZH1HqvEDYCcqlexL0Plt81Rbq0T4EgKRph+TbFvInYb/mjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pkj2NyBS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757334608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mAbu1qtNRXPF8YYyixaj0bXNlf5VN6++naM09nLWj/0=;
	b=Pkj2NyBSbaC2LhNk4WdBiH6wkE8j1GuhUuQ51Jgrp1SeLGGUUxYHcOel853QgoLRy2O7Hq
	AQuUmhHpRyJlOeeKKrhqPm0kaEyEIpPgph9gjrQneloX5Gn1IGwL8vrS1b3G+zKfukM2Ti
	aCy4ciqorFDpyi8aNWY0uNe0FdFxiJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kVKLJlFGNE6f4yg_Bcl8PA-1; Mon, 08 Sep 2025 08:30:07 -0400
X-MC-Unique: kVKLJlFGNE6f4yg_Bcl8PA-1
X-Mimecast-MFC-AGG-ID: kVKLJlFGNE6f4yg_Bcl8PA_1757334606
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so24281225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334606; x=1757939406;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAbu1qtNRXPF8YYyixaj0bXNlf5VN6++naM09nLWj/0=;
        b=LwmWXkXpBTXOfw3vZfW7x6dwC/0ZraHXLYVSszrNI8cZl8uIBIpBx9R+CcLPImu6uJ
         h9dKp5y0YNuWNHjQBd6suJ5MN8HbtP8KtEuEYGfa4g8kXYfWahUy/PI0h9WRR9gsWdh9
         dKVrr1CJRTDf9N92QASIQk3sDIR/67K9im3yJQ5UOV2cAr8T7XQ3X2Y5c2mh2HQICnY0
         0lnZTUWagZvRwsNVbk2cxJvsG8tNPda+UQ4G12aLcqTwXnQIQFXb5hsqT3gmVYrdw/U4
         4MHHgjHmcraBL5xE4Gm+9IJrawysjnnPHVj7jVPGP87ZT306N6fYszauBav5ehUIZBO6
         Qn+A==
X-Forwarded-Encrypted: i=1; AJvYcCUhWgqNIbQdCTZCAW0R9Is6Llcpo5kjJlLdU02NcGzIUFoqkXgkfupxXn6nVzUL2oGchSO3Plq9yKfEseY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnc3zqT572hZLvYh6X7oABdTUDWI+q+/rU9C3zxXgakA72OeS
	C2icu6mYkIeo0gArkgIw5WCgYuNDPT47NhA0VDNT/MVEpyOPjRpaew2gwrkpjP6MP7MukcSN7nH
	VCozTDHZPCRN8d/A0f3cf2hH+6iqG1OdrAA2SkyDPaVvo6W9Ddgpe4VqWlx2bSrIexw==
X-Gm-Gg: ASbGncumiskCjfkIXOyStaMbW8TbYOQedw2+mGiLFVCb05Hmz3SI0+QIVgEt1dgkuFT
	Qkg3vSb/8zcUNrUReWXPRMSEHu4S5Q2XLJKvLUwyrmtfqXndSUz6SmJPQ4wHgP3zcWuqh/a3m/V
	abU1grBQkpylFT5rAIhwsG5nye/GDdtBZPcykN/N0c0HbO77NRbVnFr9Szx/jXuZWqHQNUS7A8i
	cnmJnbHBMP+MfOETBbN+aiwG9JFc1ISwoheEke2vlnmBqIzDKUhYKx8F5/JPQ0/7ztIs1qtZyoP
	0uaH0g3vA0W0sj3NBEeqtOLtKB8T4Xr+hSAq9AVLgr2Xj1cLVDjE6dKOppQkG8o8EM3JkfLS9XQ
	q9Mo2uVaz/qFyomdoZQVW/d0TyKf1sPRhql3Qm5x0eZv5eQ0itpmsKtIw/7SX12pI
X-Received: by 2002:a5d:64e7:0:b0:3da:e7d7:f1ec with SMTP id ffacd0b85a97d-3e646257889mr6040240f8f.32.1757334606086;
        Mon, 08 Sep 2025 05:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPQ5u6lrJW7FYhM5BnRr+Yf5LHURy0+3MyMH+KFiHP7c+8mYlMSKgheCV33eJ2ujN2PhjoPw==
X-Received: by 2002:a5d:64e7:0:b0:3da:e7d7:f1ec with SMTP id ffacd0b85a97d-3e646257889mr6040206f8f.32.1757334605599;
        Mon, 08 Sep 2025 05:30:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2df4c8dsm171493185e9.15.2025.09.08.05.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:30:05 -0700 (PDT)
Message-ID: <c2ff433c-35d4-45e4-bf06-e725726fa515@redhat.com>
Date: Mon, 8 Sep 2025 14:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a
 helper
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
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-11-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-11-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   
> +/**
> + * __swap_cache_replace_folio - Replace a folio in the swap cache.
> + * @mapping: Swap mapping address space.
> + * @entry: The first swap entry that the new folio corresponds to.
> + * @old: The old folio to be replaced.
> + * @new: The new folio.
> + *
> + * Replace a existing folio in the swap cache with a new folio.
> + *
> + * Context: Caller must ensure both folios are locked, and lock the
> + * swap address_space that holds the entries to be replaced.
> + */
> +void __swap_cache_replace_folio(struct address_space *mapping,
> +				swp_entry_t entry,
> +				struct folio *old, struct folio *new)

Can't we just use "new->swap.val" directly and avoid passing in the 
entry, documenting that new->swap.val must be setup properly in advance?

Similarly, can't we obtain "mapping" from new?

-- 
Cheers

David / dhildenb


