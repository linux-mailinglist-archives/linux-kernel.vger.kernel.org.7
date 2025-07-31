Return-Path: <linux-kernel+bounces-751828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE399B16DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1841A1AA682F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853A28FFDE;
	Thu, 31 Jul 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2UWelSW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E821FF4C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952221; cv=none; b=O2hzRjQhDzH+aL7HoHKDbV4FvZXc1Z85M3ycccOyLkajfMxfAsxHCmh0iCg2rXcIBm7dTC0FA531GNmoZMTzqIF1DOQGZUsvB9L0s+z54HPDsDPPobBD0LxLgRvkKWkZLzQApeY2EB+amVM1DMqLkYj5RZLf79Sn6hdoYvNgdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952221; c=relaxed/simple;
	bh=cyjPdAWpWazggyDlM/k0QQZHqIPZLEtpfpAzFTyyr+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+8KTuQKFoB1pH0ewtV5yvq2rzAxiU6l+NgAOyhkPOb8JWrz1ZREk3b4+8f8Ik5DtYHF1bqNbgjLj246g35umqPKA3/JbSp+loXg3H5i2vGPbMTSer/4xIgGVS23kcHSp4YBF9p2AjPNZQFCe+CFEGw4uZj5Kmb1NZpAHGyWRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2UWelSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753952218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+5TNyfQXvfnFi1k4pdD7pee/s+gNchOD8LjTo4BFGo=;
	b=R2UWelSWYD4k6ngZWgPfZeABCHjBoMG6e6hO74UdSTpWz8iPlWxrBcrH+IylGnNHhMvOXM
	rqy3d4UDewpz9Z3NeCU539d+1jvnZam3ugNba/UEofovecVow75zzrwaOqtEa/IuZS3wJT
	jQzn9KtwJCoTbfcAzEwcA0sc+IatQoQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-92ZhNhelMoOnwFd3MqvN9g-1; Thu, 31 Jul 2025 04:56:56 -0400
X-MC-Unique: 92ZhNhelMoOnwFd3MqvN9g-1
X-Mimecast-MFC-AGG-ID: 92ZhNhelMoOnwFd3MqvN9g_1753952215
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4588cfda8b6so1626865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952215; x=1754557015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M+5TNyfQXvfnFi1k4pdD7pee/s+gNchOD8LjTo4BFGo=;
        b=qZNyuIksStEAmcHNytGyTCZQwsYCRRnXtpZkwqwwK0AFs4Z119il4PjzlBLedZlN3p
         gjGwbF5wr/cxbeq+2QsETeinOkxype1jIkv3AjpZSRQubGrUAx3E9gqYW/c5DvDB9ZBS
         UFLhRTTIbjrUCUqM3KIU5m/evE6mVC95zLBZ0NsUS/3bBLYLijU0Q9Brh2fZ2RtxJLLR
         P1KZKJYm8pANRdh8eXavLQBsF3eE4VD2rvpTmEVNQAiJkwFT8cvj9QjofLm2KgyAO60f
         9G2jdE+2Vsrvlc6obMrtwuu/t/CQAscw65Y8Nd0NyEpWliiHB797wCAWbe3UjF+C621t
         HGtg==
X-Gm-Message-State: AOJu0YzrI4w3ne0r+g4jWWyife2tJMSHa6YcKs8QqpAzgnoTYFA+TjxJ
	cHgobE2ALSSCTFu8XpDqYZ5NPSZ4Qa3p7n6rj0xFWeBcaM1KmVpOm719zuS5dKBP1H12aoCH1/L
	nRQ8lD8Y5QzxLyICnP/sxNNZoqEZ4rOMgs45GRWGDeVjBkizFuNxO38/fv0hEmCLhWA==
X-Gm-Gg: ASbGncuKMIi833x89sRzGi9cZ1dgbKaxN/FSQtDEvpqOpIw9jEufmLvqYMtBV3eYNrP
	QLfAnumKDJZaCWdXArAWD3JZQD6B+5nlMK5mLZqLJN4kcuwGfIQC3M/r04PYOs0S9WCIDk0dTPK
	7QATMcVOflAoZEvcAd0xPuMwIJKIEKFdK3bLAVer35+OYw/m7sSO+ynsJ/jsARsWUn+bOpDL+va
	uOt31eRwrq76SCj9pPQlTDmSbrwIFYxlRDgc/ruqVZ4Ehis9f1z8AuJY8cMdO8j+DbSNDQsK0yV
	3mvFT7xswCu+Cx//IpUsbxrhlkvZIIL6gD+rMJSbjBVcE7rWDURWmu1j8XA1aYAG1WdfhxOBoul
	Iqpw0yR6su3HJWpHb1qxY1bH0urxRwupq9M/mnBKpSar6CzFP2gJrUJQqMhDvEW4Hwt8=
X-Received: by 2002:a05:6000:230a:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3b794fed24amr5151700f8f.13.1753952215153;
        Thu, 31 Jul 2025 01:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxkTppl88wvOdBwkP99hPIcrhZK2fqjIYGywzpVNBSO26NwhtR9aUcLjL2G5jko0Gp1MZknA==
X-Received: by 2002:a05:6000:230a:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3b794fed24amr5151665f8f.13.1753952214679;
        Thu, 31 Jul 2025 01:56:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c467994sm1683864f8f.50.2025.07.31.01.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:56:53 -0700 (PDT)
Message-ID: <df265383-476c-4f0b-87a0-37b5ff8e203d@redhat.com>
Date: Thu, 31 Jul 2025 10:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 00/11] THP support for zone device page migration
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
 <1fa09b2c-4845-445f-9343-3a169e202ac5@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <1fa09b2c-4845-445f-9343-3a169e202ac5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 10:41, Balbir Singh wrote:
> On 7/30/25 21:30, David Hildenbrand wrote:
>> On 30.07.25 11:21, Balbir Singh wrote:
>>
>> BTW, I keep getting confused by the topic.
>>
>> Isn't this essentially
>>
>> "mm: support device-private THP"
>>
>> and the support for migration is just a necessary requirement to *enable* device private?
>>
> 
> I agree, I can change the title, but the focus of the use case is to
> support THP migration for improved latency and throughput. All of that
> involves support of device-private THP

Well, the subject as is makes one believe that THP support for 
zone-device pages would already be there, and that you are adding 
migration support.

That was the confusing part to me, because in the very first patch you 
add ... THP support for (selected/private) zone device pages.

-- 
Cheers,

David / dhildenb


