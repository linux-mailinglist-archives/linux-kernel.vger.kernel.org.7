Return-Path: <linux-kernel+bounces-879990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D258FC2491F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35C54669B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801E342177;
	Fri, 31 Oct 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf7zFkvO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A014341AC1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907226; cv=none; b=QvNkvdr4+1Z55SZev1iELuXk8D1YE1Ze4Ta/1zgftdE+Najxz6i1niq/ndv2riq6B7xncjgsF1lIlg6OWR7qcGVypY5bMbi1fOzqq0ze2qaxi827iIlZ1NnPykQ9dAsFvIo5xRxyosXS44LDmwmoJBmVYJB/fJ8OJ3vzVJ0ov4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907226; c=relaxed/simple;
	bh=rf2hC38h6tIXRHeYGfS1qsZW2ADTB4sWMt1yf2Izvus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZcsGZbW4HaVPw860cTy8QakNcWUnmK0xZjl3guM5WHULdJfeefJqjqvkvxxOFz7s7QyfZkPOMai2RSQRD3hsTFyn0ehPn5FsVEubAp8ce1aQ5i1A02HuwJ88zBTxOEeYgntWss8EQpcqf9TxHO5lM0XeTtOK+VtpI+mGdQ0rSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf7zFkvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761907223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oJIKzzXv1KPAKlEWKXjXEzGX44uW5fHNqueLO5sqP5s=;
	b=Nf7zFkvOKw07e1Okx4V1JKBfBwhkj+v9c7prG1KwNGPu6I0lSdMGLMejuAgymZTjmMgpUZ
	e9UH8hALbKQfsKi/bGy3F1M9sGYU2TcpFQqM8idFOReTv3hclAPM2Vx/o8yWaPWNkzl3tk
	91YmC22Nz4CykvVaTi6I/HRL4gRh03Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-Evt2FI8RNE2a4Ziux2VGWQ-1; Fri, 31 Oct 2025 06:40:22 -0400
X-MC-Unique: Evt2FI8RNE2a4Ziux2VGWQ-1
X-Mimecast-MFC-AGG-ID: Evt2FI8RNE2a4Ziux2VGWQ_1761907220
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso1770275f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907219; x=1762512019;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJIKzzXv1KPAKlEWKXjXEzGX44uW5fHNqueLO5sqP5s=;
        b=n+uV5NVx4/4MtBM+n9QCz75Oie9tutG9cvaSZ0DkJDAHesXzeVkw4rlO9kD0ImTUKj
         XZg1Va024hP8ExnI/p9Ef9qEiijDsdELkYMTOEzK6A6mvRIP17PZGRnA0yKEo5RSphlx
         PDS9WGiMdYvxa5PzsFLmOiW30rBaG++RTTwLgcOnSoyjw9fopsDsvEnc3KP01DRU5i2W
         Qsv80SCQisjG4nJN3AwXWABtna4xxa4W6x+KVAz5/H1c/fsnqBq/f2ijE8ielsjq/d1i
         LLRck0FIGqGcjV1dR9T3XSNgRWyLm6g/dKk7vx8lJd7PL61qP8CUPegpzWBh5X4koLaY
         rxkA==
X-Forwarded-Encrypted: i=1; AJvYcCU4uKa8EhB1K8HrRkwFIvs4cHfe0wIYCmClKeDEqGkngWc4q/neUFDtTGJtj2LXNWhhV/lxGlk4lJ/LqW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1l0W6R+l0iR9eRSwDMAoNzkj4ow/1R1rb7xehn2aZ/cfPuCh
	TeZoedI29Zib2nurx3nWdRb3Jn2IPfTPqojzvKaQbsu6oJ3+s2dip/T0KKn6nJkFrJI9mc65Vjf
	Wu/MPPcOmr7hPJIN+fEKAzjJfH8myIwPQ9DR8ISkQJ/NtJDmzS1mv6iYrX2H8eZLLaw==
X-Gm-Gg: ASbGncscQdfi2QgJc5ZWx/jURtrrCQ0zadHAED6p/8GU6sOy9r6/piaxG+yS6JgkAgS
	DKWyz6Fe668U+gJb3DG5Co3NPzsXuwQkbrd1+vw2bRVoN50+R0ug17amc7GOa54jc5rj1J0Tg8l
	7OZ/EHC8xiAfldISMk6j3X3M6ZYo2MYDmtmT4q3uS3RICDUunaPX+CrxintjZ57dM7Svwsd+V3M
	4aMja9RDiqa1rnYmotYVwkairPNxqdoOoEVjs9pjc0oV3eswxPdkZHh0ELYU9AToowbrIzEU3fL
	bLWFU6iHPPzP1xa1jhgElFjD2I79x6PpzTBDqzp37Q+nKE5p24lUrR0Lo1Ynxo1y2Q4KzBL8FlU
	PHdB9U1t0R78P1GG4jh4sp299tWIiElwCcdmn60r16JQ3vpuN4G4byPKUwWY7YXvrJiYfhHHXza
	v3Dd0SRmHhk0hk4GV/nI6NOTQOeHw=
X-Received: by 2002:a05:600c:1387:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477262a966dmr52601235e9.10.1761907219640;
        Fri, 31 Oct 2025 03:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFNypKJqvSxCMoAKYjs9Rl2Q+K34gFvuQORJf5CmJ4AWi1A3ik+7eF/76PZ488GaIPEHvkvg==
X-Received: by 2002:a05:600c:1387:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477262a966dmr52600965e9.10.1761907219156;
        Fri, 31 Oct 2025 03:40:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm98599145e9.7.2025.10.31.03.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:40:18 -0700 (PDT)
Message-ID: <ca63328b-1c57-478c-b8aa-af0974b7f188@redhat.com>
Date: Fri, 31 Oct 2025 11:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hit an assertion within lib/xarray.c from lib/test_xarray.c,
 would like help debugging
To: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: michael.roth@amd.com, vannapurve@google.com
References: <20251028223414.299268-1-ackerleytng@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028223414.299268-1-ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 23:34, Ackerley Tng wrote:
> Hi!
> 

Hi!

> I'm trying to use multi-index xarrays and I was experimenting with
> test_xarray.c.
> 
> I'm trying to use xa_erase() on every index after splitting the entry in the
> xarray. (and I commented out every other test case just to focus on this test)
> 
> Should erasing every index within the xarray after splitting be a supported use
> case?
> 
> Here's the diff:
> 
>    diff --git i/lib/test_xarray.c w/lib/test_xarray.c
>    index 5ca0aefee9aa5..fe74f44bbbd92 100644
>    --- i/lib/test_xarray.c
>    +++ w/lib/test_xarray.c
>    @@ -1868,6 +1868,9 @@ static void check_split_1(struct xarray *xa, unsigned long index,
>     	rcu_read_unlock();
>     	XA_BUG_ON(xa, found != 1 << (order - new_order));
> 
>    +	for (i = 0; i < (1 << order); i++)
>    +		xa_erase(xa, index + i);
>    +
>     	xa_destroy(xa);
>    }
> 
> And made a call to
> 
>    check_split_1(xa, 0, 3, 2);
> 
> Here's the assertion I hit:
> 
>    node 0x7c4de89e01c0x offset 0 parent 0x7c4de89e0100x shift 0 count 4 values 254 array 0x55edd2dd8940x list 0x7c4de89e01d8x 0x7c4de89e01d8x marks 0 10 0
>    xarray: ../shared/../../../lib/xarray.c:764: update_node: Assertion `!(1)' failed.
> 
> 
> I think I've narrowed down the issue to the for (;;) loop in xas_store(), which
> I believe isn't counting the `values` to be updated in update_node() correctly.

I wish i could help, but I'm not an expert on that code and it's not the 
easiest code to read :) But staring at it a bit I assume you are right 
on that one.

> 
> Is `values += !xa_is_value(first) - !value;` intended to compute the increase in
> number of values with replacement of every slot being iterated by the new entry?

Unfortunately that I am also not 100% sure about that one.


-- 
Cheers

David / dhildenb


