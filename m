Return-Path: <linux-kernel+bounces-800513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88FB438A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659EE3A4E90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7FF2C158E;
	Thu,  4 Sep 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OU1pfG58"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5521917F4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981419; cv=none; b=urZhMgyYcJ4xsk7cMxwcHmEM/oiQCyOJL6INWp5OjCX6Xx0rGq/WVOM4iwMlrMsFFLLiDCoDL6X0Kb3wzHUtOnujwrWo1w+s0oCp6W25NAJUE2IEQ1EFcACNDF0IxXrwdX+TW5/jG1b51yg8hv4UvLmBkY4B28hrvmSWeWr3pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981419; c=relaxed/simple;
	bh=/Nq0rAF47wBI+nCOVbe+IZHqKyzQrkLnb+8Fv7fZw6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOn9NTb0fygBbWcnVTozzE0NxyjkysgORmmGbb7c2W6P0MTZ3gB60Fro6XErghUcavTs/pbevLMYC3t+3CWzMql/xKC79VU+v+ZKCXaDN9MmEnka6UiH5xXljy/INeYjcU2DH7cLFfS/v/wWckP1eo95Acjjxux75OA7SASN4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OU1pfG58; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756981416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HMLyLUiUh/TZRBZyhVrvLseu1BaUclOXEJcDQ74FaJg=;
	b=OU1pfG58DDCgTNfMh8ee6UkqbkRLOSyI7StFmFRwVQrErPENCQxfm8GIZxdo56l1/31fU2
	JSMzFeAVaGuCaxPcEg3D6jylPlJLd/0/hD3tFATv/Qsegzi0pzyikF3BokqBl8dGf4W621
	dwV6SR9XQdM7OWAFrK59S9RZkHGfFYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-D9oYzwOiOna-4bh-mRUq1Q-1; Thu, 04 Sep 2025 06:23:35 -0400
X-MC-Unique: D9oYzwOiOna-4bh-mRUq1Q-1
X-Mimecast-MFC-AGG-ID: D9oYzwOiOna-4bh-mRUq1Q_1756981414
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso5583025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981414; x=1757586214;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMLyLUiUh/TZRBZyhVrvLseu1BaUclOXEJcDQ74FaJg=;
        b=BSRtOWjSut3KwUw7oKQYa7sDfg3m620MoJIwAr6U5saFq996nRdTgvAGpFVj3o9tvH
         Tckh19JrfRUr3L4xnPWrCzAzMdje98kCc4PAK0DmwcVfEAEKTNaGb5Yj+zweuj2R0yoo
         +4My3Tf0d+oLEcJaK9aI5u5mVtBQ9I9aeJbo6DnykgsJDitNCWUcb+yIPy/3i/txoOdI
         tMDQl4M4CujcjUb4cNqgro7ZtulOSGgJ/YUAAKSANAq9TGtyBdJxspfGSRB6I2mRmPo0
         cLOx/4D83aS/yVtNckGeuQBXkbOcENtbnuGEexmrGXW8b/VDN2B1aJ9/WLNy0c4SB7lr
         uk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9hjCaVXn9HK6LJOI/AfVknEUts5EOOb1h76I5+fFQFSU4T+ogwM9EQUvI9g+CsID0EsU2SOwg4TV2BJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ65If/j8tTHIerkqWtARzU3pDU3POP2LwABOSS395H5+QNef4
	G1P1IhyPLAw2/806WP9z9wFbWRa4ARpkGWnSYwekALuG6OKxKkA/5irkHpcQH08DUlNA62zRfIw
	TP/IGnt5huKD1wAOPtHf38tyBzIcDUkcE76/ivBSKRyxknbrdYe5zn2Ep/Rw97aOIqA==
X-Gm-Gg: ASbGnctC5RPk4RRRPdnRJCnp1ytyo4eeSPnh4pi0sGxCuR1nbbU0HRKzlgZIOb9c6PD
	ssT4roVXBgyxrgCHsj7ZkyH5LiC3h72Rh0HgWqG3036OUnKMNqOxZ8wBwsV/CfPhHjMuFFP9uwr
	SdW1MoxfpVycMOglgmBQLNibbfWSJp29pp2wDJro66lJHomEOwdzdyt4ItxOOOW1vGUbP3yz651
	PQJ9GJTLpqWz19yQ1AcbKAslv/0IwGowf5Ziidll00dGWewCSpQpQqT4joHvhesWjkeGFz9/Vmt
	uh4AMPAiT1GpoELe6Z18JIBnc3pa/z4z2xITckQZ+/LJHDfldR9xy3XjTxXHANZclVZcx1+viFj
	DKJzQXecABslO8NG01Rv4gEOX+0zVaLFKGd5BSPlcyIVA9wyc3tkbDXxEVqtnRa/1
X-Received: by 2002:a05:600c:4fc9:b0:45d:cfc7:a16a with SMTP id 5b1f17b1804b1-45dcfc7a1f2mr20239895e9.9.1756981414035;
        Thu, 04 Sep 2025 03:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyPrZckgqxIwcSXvcmROdXN20zf4ciUTUtqMgHL+vb5j2/auofdb1B1OI/l2DtECrLUTB1bw==
X-Received: by 2002:a05:600c:4fc9:b0:45d:cfc7:a16a with SMTP id 5b1f17b1804b1-45dcfc7a1f2mr20239595e9.9.1756981413558;
        Thu, 04 Sep 2025 03:23:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm93227735e9.16.2025.09.04.03.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:23:32 -0700 (PDT)
Message-ID: <84297d37-b766-4cfe-9c3f-bff1cb3cb4a4@redhat.com>
Date: Thu, 4 Sep 2025 12:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: tag kernel stack pages
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
 <ea48bc1f-7ee7-48b4-b389-c3622fc4d3d1@redhat.com> <aLiGnSHFJdaTpMc-@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLiGnSHFJdaTpMc-@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.09.25 20:19, Vishal Moola (Oracle) wrote:
> On Wed, Sep 03, 2025 at 09:49:06AM +0200, David Hildenbrand wrote:
>> [resending my original mail because it might have landed in the spam folder]
> 
> Ah, indeed the original mail was found in my spam folder. Thanks for
> resending.
> 
>> On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
>>> Currently, we have no way to distinguish a kernel stack page from an
>>> unidentified page. Being able to track this information can be
>>> beneficial for optimizing kernel memory usage (i.e. analyzing
>>> fragmentation, location etc.). Knowing a page is being used for a kernel
>>> stack gives us more insight about pages that are certainly immovable and
>>> important to kernel functionality.
>>
>> It's a very niche use case. Anything that's not clearly a folio or a
>> special movable_ops page is certainly immovable. So we can identify
>> pretty reliable what's movable and what's not.
>>
>> Happy to learn how you would want to use that knowledge to reduce
>> fragmentation. 🙂
>>
>> So this reads a bit hand-wavy.
> 
> My thoughts align with Matthew's response. If we decide "This doesn't add
> enough value to merge it upstream" thats fine by me.
> 
> Otherwise if we think this is useful, I can respin this with your
> suggestion below.

As raised in my other mail, I assume there is no way to just have any 
stack pages in any kernel config marked appropriately (slab allocation 
discussion)?

If so, I prefer to not add it.

If there is a way to just make it consistent, then no strong opinion 
from my side. Willy is the page-type guard :)

BTW, I was wondering if page-owner could be useful instead.

-- 
Cheers

David / dhildenb


