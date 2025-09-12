Return-Path: <linux-kernel+bounces-814459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586FB5545C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B285A186B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E53164DC;
	Fri, 12 Sep 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/EL6xnA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C13278146
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692910; cv=none; b=QoP3lxv1Emjhr3z3dVaHpwe9evVg0NPi0noN3aKFt096nr5Fa/oT2XAZascB+7EsM1MWo2VTGLJ308WqMwAr0MdFKdKJ4rlfT5fei3dClDNNvzvEfK1QzYZOqmnGZji+yn9NaXbjzKUcPGt7bToJo8uMFrgcI+UWMX0JGuzcjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692910; c=relaxed/simple;
	bh=fNFA9jATowjH7DNJPyXbjv0BE8Wfe9YN2xzzRCN3Na8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGbkxkvu9TISEiS3RDsM8wXJsp+jQzvYGDKXa7+IdgaG0UCrRxTISOXPhKl4u7nHcdBCCMzYVTThJzvVFQyLnaVlMwHP47Nw9lEC4u0rumA3AMJFr20qZVWbplI21sqRvthazZNFpa2818P/Xe5prT6UfzCEhkKspItICgYCA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/EL6xnA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757692908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7PM5ZRd4S90e19FLayespygvhu/XkkjScwaGdb9c5xc=;
	b=T/EL6xnAYdwrorl40UFpb7ucL9Hbxf3Y10rxsxPTth99psIbNxcF4xpMGGCF4cR3HywZQ1
	4SbZNoVUmyX/thEpAAKKTKdglfYnM1i5mgGx8VdLopmhrqvaaASxjmboINy3mM7uriSglE
	0Xf0dapdxbitXGQll9Wo25r+uJpPJ7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Uu6DLeoGNDKRbW5_Pg8_sw-1; Fri, 12 Sep 2025 12:01:45 -0400
X-MC-Unique: Uu6DLeoGNDKRbW5_Pg8_sw-1
X-Mimecast-MFC-AGG-ID: Uu6DLeoGNDKRbW5_Pg8_sw_1757692904
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de07b831dso12659855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692904; x=1758297704;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PM5ZRd4S90e19FLayespygvhu/XkkjScwaGdb9c5xc=;
        b=hs9VrUruMc6ezhyg2XoPkasPyVdb9zc1u3ERUW7iaQIQnbb2H/YHh+6DUSl0QdHfBO
         PS5ubcABglGlhRPY1817GkUsiXb9/CZc2+mU02RNdP69VIDhdrplNKhHNxlcTxtpZxXt
         O893eMxIXCiBHpEUf/9007KLgL0f5jlUrU1f6DcyAdodsOPvDNdaaloV5qIHCIDLOqfJ
         HMBQjfcXA3zAqNpAYSyY/A3YbK3AyiVknCNK9ArLc9zEGyk6Yy7RCfm9wHzejh65WKXw
         Yoj8dQn6iuu0YoNG7N/dEAvX+83t+1uN+xH9nsucsIfiH/KDS2KsLC9AOspClS4wIjj2
         2RTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWdlE2nhzPfCeXESuvIb1+glhyoNaKWBHFXUijkeLeWUtw+SqyUdsxf7EK7gmF2oG7yDrjsVcJZqWvmas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUbF7OK7fTAQwcfJHJ5Ez6oWvLs2XY4fW151SN8mvYFg8K0gP
	q82k+jqXTj4fRpSfjEziSMhianZ5Ws9Y4Q69YzU3pGOsuzUajeU69JSRQe6hHudd4iNOPK+tNYm
	T7YT/3lnIv5kpBWaPbGXPFKAWUm/S/2f7iJXxgv2B8+pdhTsETR3h9ZM1VhUsm1eZfA==
X-Gm-Gg: ASbGnctXW7/KfJo8gNsV2EZ9wORize+/ds8z6zpQWVp9dtG1Cgy3hQfNUDdm3I/KKBG
	MOZAtghQX2uklTH7RMmK+yAwAyOtgpo0BqHbeSeMwiLN2A0kP7lcDoTr1mqWkuN6Sq6r39qMm4F
	Oyj/wDJUGXY3pqSWPaPKxJxy5wTjvDCK/ybYNuXp+5nffDEgzncxI0OC2WpTXYUqNkll12EbmSi
	bhss5kMYQPH5I5VwsCkE6bls/BXp1gEzQm2zQUZWqcWtrudMdVeEcpBifArN4iNuyMluKeI5i7G
	tkzNOElBxGeOquL8SHG9XQ0vgWiwPvQhf8Vh8VZ/Z0rkotXEKdovkdvvMcKD869OzTV5CQvNCWG
	4og8fdkqCZNqKSFQHHRnGdKYlWVt8w5M4KQSofGq0Q0I5L878CC1VWtJmEsrH7nyqMes=
X-Received: by 2002:a05:6000:1acd:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3e765a1a4cemr2586248f8f.47.1757692904285;
        Fri, 12 Sep 2025 09:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV+C0BMQnQi47+CMhL25ihOXmCC88+Ak1u1W7QF2sbOPSW+YvOWNmU0uOjOZodfLU6UMRT3g==
X-Received: by 2002:a05:6000:1acd:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3e765a1a4cemr2586210f8f.47.1757692903581;
        Fri, 12 Sep 2025 09:01:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm6980192f8f.37.2025.09.12.09.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 09:01:43 -0700 (PDT)
Message-ID: <f40a1a9d-2d37-4afe-abbd-366ff573303f@redhat.com>
Date: Fri, 12 Sep 2025 18:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] mm, swap: check page poison flag after locking
 it
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-5-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250910160833.3464-5-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 18:08, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Instead of checking the poison flag only in the fast swap cache lookup
> path, always check the poison flags after locking a swap cache folio.
> 
> There are two reasons to do so.
> 
> The folio is unstable and could be removed from the swap cache anytime,
> so it's totally possible that the folio is no longer the backing folio
> of a swap entry, and could be an irrelevant poisoned folio. We might
> mistakenly kill a faulting process.
> 
> And it's totally possible or even common for the slow swap in path
> (swapin_readahead) to bring in a cached folio. The cache folio could be
> poisoned, too. Only checking the poison flag in the fast path will miss
> such folios.
> 
> The race window is tiny, so it's very unlikely to happen, though.
> While at it, also add a unlikely prefix.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


