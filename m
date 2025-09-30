Return-Path: <linux-kernel+bounces-837363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26461BAC22C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F8516D4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B452F3C32;
	Tue, 30 Sep 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/KpBEtW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18A256C6C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222447; cv=none; b=Liwl/WNAQJEP2cXWBcU8b/vWis1PAZEFMadPi5DvPwE+DPwX6xIwpU+clOEYBzx/xV4PSclR37irZqt57cndp+iKn74XBmwfyOdmXN2PLGg9VxM6yYYzEn4vYhtEeJJZJHGE5T4qAVP2TDCpcQv6IS3cpRGIkqXJRAgYl/gU+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222447; c=relaxed/simple;
	bh=H/hlPYSrqrOgdSVbBUf41gBoK+8lMx8DTuxeStbe918=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCV4CPQwGR+t+QMCU79Nrx+mDo4q3ueng/xILTAfIQ9ak6/cECOd6yRewNbA2rbjUVKDO2jU9Z7sIymJZnQzEUxSC48wxymVjOdeGy4FGxMWNLeFWFJnf3mf3J3ImVhutGC4Ruri1MJuxgYCF+GKZ/tePEPijxb4Yab4bJw1lVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/KpBEtW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759222444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HHYIX55sfVLVhuTSx6IpeMzw2EcC24ufO7Z5N6eDhnk=;
	b=f/KpBEtWyyQWI2ZruK4w6fXlUQ9Xjqgo4HYxG9JIs3VurVKpEWZAVPfjaSjksJRWR4t5rg
	YwzqMLkrLBqr2y3a0q+RJWYh2tZ7D4o/JSUmsJXzhcJ5l1lkvyabMNCzEsozTJabcu84Uy
	bcmdlgwI5OQjT73gKGMlBTSF6qQt0c0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-q56cDAiZOpSHZXOs3hYDpg-1; Tue, 30 Sep 2025 04:54:03 -0400
X-MC-Unique: q56cDAiZOpSHZXOs3hYDpg-1
X-Mimecast-MFC-AGG-ID: q56cDAiZOpSHZXOs3hYDpg_1759222442
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3eff3936180so2143331f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222442; x=1759827242;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHYIX55sfVLVhuTSx6IpeMzw2EcC24ufO7Z5N6eDhnk=;
        b=XkZxaXrIvWfz0u/z9q0TblcFsc4y3q7WDhePkTQlsdq2mMoEoVYIE/XXUzrGphWQsw
         d+3nO/CHFw1T1GyDbmPE6njLAWAuokUyJ78/+xV94YyCO8moLhFMvii7erZDbaDVG3rB
         FihsMISjUStMPpCmVDHP39ZoFb1zRWaqs2J++DmyhugMFv+j7bgBYbte1IBxQ5slkAfk
         VOVfdQnfPV8IzsQ7/vW5d2Y+yXEEVNqicSnDdBBrCiHeRiSLcPRdTay7scErff5ywCjS
         xUKAJxwJ5ul1PWMNVNFWJyGhUXcE1GXPg8KDaMSOliy8GXjglxNaXdG7AXR1q/FkPb50
         QnwA==
X-Forwarded-Encrypted: i=1; AJvYcCVRA2Bn26VF4SpSEoDvrVtaFZDk9EG/5uxwSa8AkmdmCTeI02fFkEqox2GsNVNBk+1DqpFPNutejQEhZxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4sfu3DyWGX3tCdJSjMTOsuSqELeBLCH4XBA27F3ghX9QMk67
	ZPM/v58rG1nHFRhWZKG7nkpsR2NOJPBpOyr2LNE6sxZriISD/n+aBj7kc6aTIAFmXxM514Exadf
	X0sN1XDXPE9HdrDvTlS2GTgPTnlKEdBQSDqpV9rbdZ7BEDWbeXd9s1D2k0E27Jo+Pcw==
X-Gm-Gg: ASbGncuOX0CZ80Vr8owRTqt4a1LYQgAUK6nlq74dgQxTglKNfyMer06Tcq5ZOBlEYgD
	UFrXBMw9jNz+g5dTLDrSXGf2dOgPeA+BBXCzikThJDgp2NDmHraNeXyFipM89TtsenPAjgGudSs
	O0RCA3z+5qiR6Cto4AfT55hiCSvLs+V6RjYJ60OXOILjtXPcYuALgbJ7V7cdEzbTfNm8ZeuXblT
	885NlNJ0O3Pq5+P3hBWF7MJYP8bPc2tF9UEw0H/oBp/8HKcSAdLY6okZ/SjlAboPlIWCM8wfeW0
	OMGE6P1VZx0BqYeWeU4PuxA15Ngn0NipMEJYTxHfB4uJBFVUlUiQ0cUvheHBQgpfcOW9GgQtPWN
	qCXmNbkXE
X-Received: by 2002:a05:6000:1884:b0:402:a740:1edd with SMTP id ffacd0b85a97d-40e4ba3a51dmr18681153f8f.39.1759222441979;
        Tue, 30 Sep 2025 01:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC6R/XmmrHeMyW4Zs/2Re/vavWpGlrPLfb9nEQvvZzsfwcAir5u+bovZh6m70scQKSNO6HOA==
X-Received: by 2002:a05:6000:1884:b0:402:a740:1edd with SMTP id ffacd0b85a97d-40e4ba3a51dmr18681110f8f.39.1759222441480;
        Tue, 30 Sep 2025 01:54:01 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm21447278f8f.58.2025.09.30.01.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:54:01 -0700 (PDT)
Message-ID: <c980f6ae-ba44-425b-b7bf-511cb6957c2d@redhat.com>
Date: Tue, 30 Sep 2025 10:53:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: Lance Yang <lance.yang@linux.dev>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "Chen, Farrah" <farrah.chen@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Zaborowski <andrew.zaborowski@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <SJ1PR11MB608350E5169EE77F86A51E2FFC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SA1PR11MB713082CA93E9B1C5F22CFBBE891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <c1294b63-eeee-4d99-82b6-93eb3a6d0af9@redhat.com>
 <CABzRoya5wuXoMWuGb_+F0oBc0mCDVrjbXTZsoMwcfRT99Y5z7g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CABzRoya5wuXoMWuGb_+F0oBc0mCDVrjbXTZsoMwcfRT99Y5z7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.09.25 03:48, Lance Yang wrote:
> On Tue, Sep 30, 2025 at 3:07 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 29.09.25 18:30, Zhuo, Qiuxu wrote:
>>> Hi Tony,
>>>
>>>> From: Luck, Tony <tony.luck@intel.com>
>>>> [...]
>>>> Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting THP
>>>>
>>>>> Miaohe mentioned in another e-mail that there was an HWPoisoned flag
>>>> for the raw error 4K page.
>>>>> We could use that flag just to skip that raw error page and still use
>>>>> the zeropage for other healthy sub-pages. I'll try that.
>>>>
>>>> That HWPoisoned flag is only set for raw pages where an error has been
>>>> detected. Maybe Linux could implement an
>>>> "is_this_page_all_zero_mc_safe()"[1] that would catch undetected poison
>>>
>>> This sounds like a great suggestion to me.
>>> Let's see what others think about this and the name (though the name already LGTM 😊).
>>
>> The function name is just ... special. Not the good type of special IMHO. :)
>>
>> Note that we'll be moving to pages_identical() in [1]. Maybe we would
>> want a pages_identical_mc() or sth. like that as a follow up later.
>>
>>
>> So in any case, make that a follow-up work on top of a simple fix.
> 
> Yeah. IIRC, as David suggested earlier, we can just check if a page is
> poisoned using PageHWPoison().
> 
> Perhaps we should move this check into pages_identical()? This would make
> it a central place to determine if pages are safe to access and merge ;)

I would have to go into memcmp_pages(). Would be an option, but not sure 
if we should rather let callers deal with that.

For example, in some cases it might be sufficient to just check if the 
large folio has any poisoned page and give up early.

-- 
Cheers

David / dhildenb


