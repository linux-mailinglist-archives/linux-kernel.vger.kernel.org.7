Return-Path: <linux-kernel+bounces-805782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B840B48D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A243B8EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1A2FB0B7;
	Mon,  8 Sep 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW5QbaWW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85E2264B6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334248; cv=none; b=Zd+T0mkERNiPzgyJja2ipvlOsVCFH8proO7ZiOJfWti3adwuM8n11lXmW/PCrdG6pBKXTAzZZwXEPozmGGd9GCMzFyEjRM3nPq0g0yStLcNX+WmnSRjBA4pxkuDr88FG598PyPeNiqIMqkftrYZ5+mYnsr5gmXuIlVNJLmxrH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334248; c=relaxed/simple;
	bh=JdvOZ0DZr1/XJnmnaEhpR1K24zinUVlHlWRQZGuGL5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFBmDAuJOUlBmfFwmtfulEPlAsP+LaacoIhB2by6nOxM6sDONJV0RAyqxXsmYWmwbftaExjs0WipUIoiFALMYSS8rMHfMyBwc7udZcWfPDbtQXn5QV3tdzVn+Y+dBArO85mLTTQ4cU/rog8INMeekr/sTj8WA1uiySP7uhJtalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IW5QbaWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757334245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CdqcOVNfhfInUmZEaYcYwLepJjAK+fkXnYq/58G69P4=;
	b=IW5QbaWWfzFwRPHJ+JXtIVVs9X/XRLDABMaYVU6TtYkxajQDIfpvF5/JujDr+7YdA1nOkd
	qihAygR62yjGCemAbSI2JNNQSlIK533icmUa0q7v71pSV/EKXW6VhTEugF9tou5BXJFrnH
	XJweete0zTwG/y38ReXl9hf5wazHh/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Qv_fOFH2M2-MlDLHpCBPTQ-1; Mon, 08 Sep 2025 08:24:02 -0400
X-MC-Unique: Qv_fOFH2M2-MlDLHpCBPTQ-1
X-Mimecast-MFC-AGG-ID: Qv_fOFH2M2-MlDLHpCBPTQ_1757334242
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd5c1b67dso21405045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334241; x=1757939041;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdqcOVNfhfInUmZEaYcYwLepJjAK+fkXnYq/58G69P4=;
        b=pheIFGW+mt+tExkyOcsjOZsyRNEa0uQeMtlxGZFikQJIXZ9CgPObPDNYaDJ3I5xEJw
         hOBWjHVio/ZHF//ROXL3eYQ4XtZKD0GrTIOyAwoXbaXkUFjr8myfCiCGOIPY0K7xzLnO
         F5d240RwQwiaWXSNPm4NRngJhS6NpgxgJsnwCkkLub1IXQuluZH/32gTbHWYB1mMIy11
         n3zGSq6Wa3L8GnUVnt5r5AkZbUJdDDUPDWUBC6ot1GjULa3Ou+fDGaZZhHnVDqh4U7Xy
         nCwEmY04mrbsNMy7Lb3PQvs83WE90kAYua4QIa2qc0IQaB00eet66eYEW+jKS1hARPNr
         Uc5A==
X-Forwarded-Encrypted: i=1; AJvYcCX3zs7YLHVQ3u6QERI2qikE/ZkvrPiQgucU1UD372Z0qtXWt1Qq09db7ygBxAq3oDljkqe2bdck7C7wHAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym47lylXOgfNjaWI/NZYrpHguOYfmMiu4jsKNAGGB6/pRYRDnT
	j8p8BDnYvAzwKNJAZATueGC6P4KH4lX24ENemRjZrn0mOOcI86IhCC61LsIDcFzRQ6FX9FTqvgx
	aimZWXU24Jdu7EgMAAalBje7bTi6NXC8ZbV9tWTComR/HYLonW4wjQ+Vy7aNaoBR/5Q==
X-Gm-Gg: ASbGncu5QLnk3zZ+agcHXMdlXdAmBoYQNnKcd2jEAl5VB/c89gnhE88gbzUUECYc48t
	MUxLqHdZoUm2WRgZqyG3+LXol1UQv04WqH4my79F1ZOeJ82uNi5hG1Hk4qEH0xYGG+Mn0X4O/Do
	3HAxfIdFPJf1QHNvt5Bwe6vvic0RDYyFFXassVes9IxN7FwAjPbdIpsPej78HYR61CAHStdiJ3w
	1GEgNjmJsP8YbaquzvSwF71DhWauzytiYcpYeHwBCFswvI1+v1xB9Q7eRqdbbZthkyV2sU0ux05
	bbU7qrYuXopX+Q0yEXY+JcieuAEemdGODo+eFWCQhuFzk6s2t8RIWwqmN5ZIaqLLAx3JQn3nvRL
	qmjAVA6OGyKDQ/5uX2409G+OQMI0Mb0XOXcV6c4ByJ27iRObJaQs9QYhDT6VLClPB
X-Received: by 2002:a05:600c:4fcd:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45dddee3ae6mr70426885e9.33.1757334241554;
        Mon, 08 Sep 2025 05:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjTYoOJ0FQMtRVKXmzpvinwY+4Y5/zvK6JIFXjMShyLSR0WIJjevW6Zcl9Pes3QYHfnyRMwQ==
X-Received: by 2002:a05:600c:4fcd:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45dddee3ae6mr70426445e9.33.1757334241187;
        Mon, 08 Sep 2025 05:24:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd063fc8dsm88565895e9.7.2025.09.08.05.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:24:00 -0700 (PDT)
Message-ID: <41fd5c4e-d9cd-4906-900e-2a6ae50ef12b@redhat.com>
Date: Mon, 8 Sep 2025 14:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] mm, swap: cleanup swap cache API and add
 kerneldoc
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
 <20250905191357.78298-10-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-10-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> In preparation for replacing the swap cache backend with the swap table,
> clean up and add proper kernel doc for all swap cache APIs. Now all swap
> cache APIs are well-defined with consistent names.
> 
> No feature change, only renaming and documenting.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


