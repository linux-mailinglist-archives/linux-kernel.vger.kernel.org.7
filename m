Return-Path: <linux-kernel+bounces-762696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99AB209F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7166D3A7346
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4B2D77EF;
	Mon, 11 Aug 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQqpeaj2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7E2BE03D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918402; cv=none; b=vCxviDzru7JMlrpdPgECVHziVaaXRXD2eICb5cfqvJe6xwyPit4phKTOcDWJYCeHMeCEPGlDTsSY4mZhJhYRreK4rNTBVbQPjtnySywho8Ztm/H3Y6m77mojmmLE67jdFZO1UInTC7ZvCxepHjfx9eQW5MunhzUYRCaL++mhYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918402; c=relaxed/simple;
	bh=UsJ0sMLJt+pqnlPyDnmcbwJns+BrcbOXP7U7KqabjO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYXURUZenrc/8NaoadI9cEKzrdn4JzlW4UoK+JX82l8NaQND4+wXTdZeDLSujVW5v6wV7P6kwEP6jxasvMsJd2W+GuwcBTVksfA0hgbKQ5FHgu/zJ1kX3dOCA4Ke+kDa+QNiCA0wsgHo39II06OJ9pCrwgBLRsD1jwuk1UJc6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQqpeaj2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754918400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgpMULjPzZBlSeJpyHnOmxgS/ZHJN16+NEixb3vEu70=;
	b=cQqpeaj2FZcn0Oh8rH8iTuEKmRo6kiua0m/+EQOhLx7vfhcIVpGVREZVzxs1jOP0R0Mbtf
	mTatuaw8jPBHF1hhc9n8uXgxYgREP5FEljsLn8P1pnNFzo+3tXNtmtkKE2ZS6v4567ptrp
	OvYBhl6NAXaMFB6o0nDTaTAmVvK+HTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-YuzrdO2xM2CjpWkeTWG8NQ-1; Mon, 11 Aug 2025 09:19:58 -0400
X-MC-Unique: YuzrdO2xM2CjpWkeTWG8NQ-1
X-Mimecast-MFC-AGG-ID: YuzrdO2xM2CjpWkeTWG8NQ_1754918397
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so33257575e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754918397; x=1755523197;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgpMULjPzZBlSeJpyHnOmxgS/ZHJN16+NEixb3vEu70=;
        b=gfCElg0997/iFjDrQK0Lvv178S8oyHpitnWAhr877ppw/RSkGbmgsnQYMOqNPleM9G
         YlPeaYNL0FktMdu1fxuIcELaGWKyRj+EzRj81PFxteP4YGMmCsC/YxT4vQ0tGPEVbivL
         bHPqq+osaJOCeBqFd41uo3KFXEmrELDHpPpmVSA6E89TKMEN/EIlfnVr8k6q5t6dpdxu
         vEKSpn64Pf1PtDUe2GFjsD8tP+jdb6+dQ6oZkkKfjXHOH4liAHIBmkxb+LTbeQGz17gT
         aq8POkZ+4J/ABjRrturDMgV0XeB3r5ot2gAZTd462KVbdHYxM0jmoavZoN5Ho64eo2w/
         DXfA==
X-Forwarded-Encrypted: i=1; AJvYcCXkV75KXdFArj2ZFmXPTNm/R2PDxPwe3kjiKXU7zc8tSwTpXxcvKWNydPzW98dxaPMUeiZ/ib1qfbJih7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDJs01BCntkEiLUZPiOWryWpC4rDLQuMxLISsipI+SNKZr9iz
	TvxJfsq1itPkzg0MBJZfxUO+Fp7FLgEje4HLePokMIkh90IeXnni/CZbNZmNSfk5H+jXLXMJrNb
	i2Bm4K/P4DECGvXKs2O1uCxj68EIxQ2tj7wrli5yTXd7bsLqkUT1yqg1OSD/JCYNk5A==
X-Gm-Gg: ASbGncsPT87cdO3u+KlI4elFq6oQGsTW0w8nauG+00oDNSNBJPjZ8xZTVkxJcxO1+ft
	v1MgxQYZKA1Rv9fOns0SQ8yVL/6CXcPEAPzCPNr9lKB+OpjU4Rsj92LZeuGMd7vQkWCMaJlDX2e
	mxdJ3GWXsc9YGL4/VErkZ/VxEJdy/YoPWnuDb+lLvYrVW9RQMB7BtokqsZPGOD/ojYCZ5wizfH6
	qA0YlYD1E0R9qWO7M/2vjpPWEPQ2/joWRK91pX0S2JTJV9BrwpHeaiQXEM9OB5+ntyNHfMCajJF
	yTveiqvouKQGxmd7s2eUC5raESm5pyN61OYH84FnyFzTri4zVG57Ob2lMmswhVwmP2toLznO3lL
	QAMM1fs+jje0ZcPTXWsk8djYSYRtWfhjxnh1dxPt9w1FaVbjCsJCxdaDI3PaDQBEJnEQ=
X-Received: by 2002:a05:600c:468b:b0:455:f59e:fdaa with SMTP id 5b1f17b1804b1-459f4f9b7e5mr83425915e9.21.1754918396767;
        Mon, 11 Aug 2025 06:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfTab1uacg66NFWygY4dulUklcFe1ZvbKk6PpdZGtHXsje3zBsH3EhLzcZBcKFQK7tW+OLeA==
X-Received: by 2002:a05:600c:468b:b0:455:f59e:fdaa with SMTP id 5b1f17b1804b1-459f4f9b7e5mr83425795e9.21.1754918396349;
        Mon, 11 Aug 2025 06:19:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de91ea4csm309924635e9.10.2025.08.11.06.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:19:55 -0700 (PDT)
Message-ID: <7e7bfd05-434c-40b7-98ec-8ce352a8147d@redhat.com>
Date: Mon, 11 Aug 2025 15:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
 <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
 <9178bf98-2ea7-4ad8-ad43-cdcc02ab863d@redhat.com>
 <904f85d0-acd6-4f47-ab45-fbf18b80f1c6@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <904f85d0-acd6-4f47-ab45-fbf18b80f1c6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>>> When registering vmas for uprobe, skip the vmas in an mm that is marked
>>>> unstable.  Modifying a vma in an unstable mm may cause issues if the mm
>>>> isn't fully initialised.__
>>>>
>>>>> Is there anything preventing us from just leaving a proper tree that
>>>>> reflects reality in place before we drop the write lock?
>>>>
>>>> When you mean proper tree, is this about the your previous question? --
>>>> Shouldn't we just remove anything from the tree here that was not copied
>>>> immediately?
>>>
>>> Commit d24062914837 (" fork: use __mt_dup() to duplicate maple tree in
>>> dup_mmap()") did this for efficiency, so it'd be a regression to do this.
>>
>> We're talking about the case where fork *fails*. That cannot possibly be
>> relevant for performance, can it? :)
> 
> I think it optimises the overall operation, but as a product of that, has to
> handle this edge case, and that necessitated this rather horrble stuff.
> 
> Obviously we don't need to optimise a 'we are about to die' case :)

Right, so my original question was whether we could just drop all stale 
stuff from the tree before we lift the mmap write lock, leaving only the 
VMAs in there that we actually processed successfully.

-- 
Cheers,

David / dhildenb


