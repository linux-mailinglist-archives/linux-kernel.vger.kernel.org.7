Return-Path: <linux-kernel+bounces-797808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E5B4159A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB291B61FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372602D8776;
	Wed,  3 Sep 2025 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euQ2cGB/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020B2D877A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882363; cv=none; b=PfxrwtNageM35a7NWpZV6XyP9SMVJ4+cmyvs6asjj5G5Q9k6/1728PkbkG6tNQlDacymjC6uNWA+HaA8aGRIY8Bu+m+dr6tBs5n0pGL7wvfldu5vrgAqEBHEzJxhFMf4GLhh/TB4aprV7y1mcIR2iFiP4dgQjKr8cr0GK26qaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882363; c=relaxed/simple;
	bh=jOfd352FpnGe9nL5cCMGXhVqWxfoPIOhiHFwVrWPIlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4r2Us2Cnu3c3ScBOYKCE7sQCtjKqddf6UCo6EJ0WeJIPT6XW/wiDtubK6xcqlE6gbF9doIPqBKgAQxq4JE6iq2aUzQleiL67FXtuOUJXVrhhcQcd+09Un3kYpAhiRGjCtj5tgA1jxwoCzhMZ3N3t3NGj6KegC3d9WQ3L0ydrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euQ2cGB/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XO0RI0g2PcjH/Mi0NTM9HS4GzVWZNGinRmDvcNi+eAg=;
	b=euQ2cGB/ytnzRbbhdN8w9IJ+AwQv9Qk8yEbUNEeY0RE7CkHxgfRwAdhFIbduqh9s4OVCzl
	h9t+QpQEPSGmKsVqVcKajqVQxWRRKDE8JvUe7f9ZtnVl7WEeXmiTZnfxNPwqqXiS/tVN0O
	iKDInHOBb+eZxC9BkCBIoa+blXvAyys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-SdtgTeSGMpuWXrVTKS9ong-1; Wed, 03 Sep 2025 02:52:38 -0400
X-MC-Unique: SdtgTeSGMpuWXrVTKS9ong-1
X-Mimecast-MFC-AGG-ID: SdtgTeSGMpuWXrVTKS9ong_1756882358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b9912a07dso7931215e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882357; x=1757487157;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO0RI0g2PcjH/Mi0NTM9HS4GzVWZNGinRmDvcNi+eAg=;
        b=GdV01mQ7WSsGevO/qGLMzRY2uDe4AcxhkFGKuNVJO9El92kskFBwO/iZtcRq+sOaGo
         sheNyGrRtzCdGUpBVrI9firMpNrLcNO8JrFFcjhjjV/NeBX0IFg/B+wCASdH2b3TRo5q
         kjsztHeQrVWzGP9TERisCBUIjmXVtTlOP8++W2kQB+lUBEUju4SLYdxq3KDPO96ScAKo
         uUTchmbQpqxay5uWj6lbM1m9SzzZPtYrcApFyjYT6vqDbRTNHzykTD9cBtcpvWHvmGqV
         ztCl8dKGh3YIJzxkwNvHNFXi9UQ6ht0bWguVYSmWisB08YxNrMqIeR4+Sb3A7P3Vlakv
         BaeA==
X-Forwarded-Encrypted: i=1; AJvYcCXwb2JJdh9hWj1WVqyWhXb+6mH0UXp7TxOpEHLh5OHoMTBYQW8U2Jqp3SX3s8TEQH3pJfaK56XQw2bZJn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfG3eXm6Jl6Y6owxt1f34kh007GENkQrzY8rTgqBg2ozYTTCH
	uon135nSFCVc/FspGcbHJzW3QH9GtJA7YJxvhxpyrZpG34c//x4i3Ne+cFWgzMuDpAz+7n47Ps3
	5T1p00QM8Zos/w1iNUbX1RBWTFB44cIMZlfYwHS9U0mhCtJMqGhDFJgaOBZk6Ved6Dw==
X-Gm-Gg: ASbGnctKYIHQX5eRwA3ZPsNbj5QH26jYJ53csPJ4VSzmIPkcGmvOpCe8ohPvZoQRviv
	Kz91yMMgTYR9UfUMNf78wBln3MEEzi9TZzkws2MS/NBvTZjHdCkUZIaYgDPDj3NpRurfkoqccDf
	i6bhkw3AV8szrgqi2oTCtUVy6cL1n/vqd8Hb3QRcGJbVXhER3J1mNGoxAlH5BEgkoIHAS5w2rch
	kboNJsN6iBGCLiqGhItt+/Xnnxh7DnJm7dTELpIAvbuQey8DXdxdtZsaScApteEICAghzvGOwMB
	3nkTj3hNmKHdZAyzNWJp/5EbGWOEZcDyOmJQLCYC4cjnzB0Q5uu1dJMu5uUj4pyk18m5JWA=
X-Received: by 2002:a05:600c:a45:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b85598614mr134948815e9.24.1756882357487;
        Tue, 02 Sep 2025 23:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG82XsrKBdBKXFiQ5caYIfv5UU9SJ+wvI5cP32dJdf+EaQZPmn3EUQKNyCx0iR71ou6s1l70Q==
X-Received: by 2002:a05:600c:a45:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b85598614mr134948575e9.24.1756882357056;
        Tue, 02 Sep 2025 23:52:37 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0fbfb.dip0.t-ipconnect.de. [79.224.251.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2722sm22600275f8f.19.2025.09.02.23.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:52:36 -0700 (PDT)
Message-ID: <e0f9754b-ef24-4821-8b41-acb8a1d842f3@redhat.com>
Date: Wed, 3 Sep 2025 08:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, kas@kernel.org,
 willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 07:46, Dev Jain wrote:
> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since non-writable VMAs mapped by
> the application won't benefit from THP collapse. Therefore, remove this
> restriction and allow khugepaged to collapse a VMA with arbitrary
> protections.
> 
> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user knows
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
> 
> On an arm64 machine, an average of 5% improvement is seen on some mmtests
> benchmarks, particularly hackbench, with a maximum improvement of 12%.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


