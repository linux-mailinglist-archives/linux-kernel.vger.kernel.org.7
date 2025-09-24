Return-Path: <linux-kernel+bounces-830391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D6B9989B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034DC3A5587
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FA2E613B;
	Wed, 24 Sep 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVZkYSwp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1E28136C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712013; cv=none; b=b2Rcw/EyDz4wQr3RO399ucXy8Z1WQLLBp9S/nMmOXTVe8Rzynepa8Ruc121TC+mjaU5eUY1I/CVNcMOiFi9qm+JorvZyN9riFBMjZAzVgx+S0zlCN9REyUb6vVcDNAE5j3tE/3AIGaU1IxaYXtLbD3SocmfVyk+Z6Fc3uQnrP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712013; c=relaxed/simple;
	bh=CcPtZaoo08foBKqlcPJlV+AkP6+/DlKpNpplHT1YDIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlmDCaVp41s2X57za5tqkB7zy9qTn495PnbHExq+KIoCWSN+3yPRhmRnqL9AmBauSQsZTyn8zb8Lmq9uLbOZdGzsqun6YS4Ho0Wgu+WGhWXCL1/XbmWp75e3rfdz9u/K7j7W/QzkkU2X2osAOEjBGizk6bvsXCzD9H4jihge1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVZkYSwp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758712007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=klMbSfuXzMxOJQRVHD/MHPSONQrqHt6H8wwjZzCAfEs=;
	b=gVZkYSwpTx2mC47ldlpL0ABsWvKw34PikbTVDLcq26teuC+VaIEPW7ShUwNcnjCKI0YGDj
	WOy/zNjHD7WgN71jSCLVRakfOfyA+cH1UYtj3jPa+JJoNiSoOWCuDd/zn0GL9ZcTIAiAcg
	pnnPLcde29agAlrvih1zrhJUJA/+0Kk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-zgc9HzWjNMq4IYpvNmsQuA-1; Wed, 24 Sep 2025 07:06:46 -0400
X-MC-Unique: zgc9HzWjNMq4IYpvNmsQuA-1
X-Mimecast-MFC-AGG-ID: zgc9HzWjNMq4IYpvNmsQuA_1758712005
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so63485225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712005; x=1759316805;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klMbSfuXzMxOJQRVHD/MHPSONQrqHt6H8wwjZzCAfEs=;
        b=I/8IM30kTRh40T8qtmGHhxeW73plIQrrkLupXASEos/Rr3xEJyjyL2l+7/K4szsMrI
         YFZnH2mU8KNm0SU00nviP/bKv9qHR8j97pHh82qWewR5ZHvNqdJBDxwGef0YgOuoMXxD
         7sUbmVwt0z5VPjGHsdgFicDqehv0ZhHpMVvT4GOEFGy7Mpqp3IouEVfl+buh/gh3keHu
         dGnffiWQcDjedWYOf4Ojr5nElek5KV0dkFqOZmgWHSVRzvP0Fsi/WWHMuVXAIeIKd4VR
         nNzdOFKbRG1t6MRB9H1rrIaa129arohUwNiYypjyRUraxvS2mk64fi+ZojdvQ0E54ZIT
         nWXA==
X-Gm-Message-State: AOJu0Yy2vpqybf79MaEZ72v36ihCH1dL/vyj4/Hzzb88O2Gciv4YMizJ
	EfK4H5LoVMcEaoGJtRmcpUmQWt/bxflZtgMqswI6NizgS/XRTJ3MexW6xlMdmgDwL0yYXG3Ve7W
	/Pq0FMLwF/4sYyVxdu3JncVSxlSYg2U5wNKCL2+5FsIP++8XkACim1rDOHsK+nRA2uw==
X-Gm-Gg: ASbGncuyJllyeovaqZsjKYon3AIlvAThC3JZo1KaRfVNu0FWDvCz+nlP4+6g7PjcgPN
	CSuyJHJ4PiEnq1BLEkid1BFvVV6hbr0IqG5eeWAFx1ksJ+6+0MlrnMs46DiuWgGm2lOTK3BnRA+
	/vAYNlN4bbNgX0Ul4IHYqNjAwQX7m59ji1d5HLbvJHDj6yJftv1Baa2PQMUU4PHbc4EvBQl651N
	NapeIEbEJQenr0CE5KUb69cYJyYTeIIaTSkdzS6BRWYdynopZYD2pa3PBybcNijIoLF8jBJgO1A
	21fWlrW4nHsGm1rS+/PdF/tmToqMZZ3dupbvmObr6wpgDZg0UN2BnsFvBr7CFaEd7KR2aOIwTfh
	sU8E7jeWEzxT/kr6b+uQ1zJiLQgUhPEVn/gRrR51epkoveCjPrAKyTUuVdurR4caIig==
X-Received: by 2002:a05:600c:46c9:b0:46d:f3c1:684 with SMTP id 5b1f17b1804b1-46e1dab52edmr56566485e9.20.1758712005001;
        Wed, 24 Sep 2025 04:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJLkhVz7awCPGzynHsrwSrqhRsmoA+KtGCiPRp3uPSe+N8fOH1QDxH0RgcAuMsM0GCOSJuRw==
X-Received: by 2002:a05:600c:46c9:b0:46d:f3c1:684 with SMTP id 5b1f17b1804b1-46e1dab52edmr56566125e9.20.1758712004586;
        Wed, 24 Sep 2025 04:06:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm27890308f8f.18.2025.09.24.04.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:06:43 -0700 (PDT)
Message-ID: <4e061f4f-cd57-4df4-a001-9eba80d1ded9@redhat.com>
Date: Wed, 24 Sep 2025 13:06:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-12-ankur.a.arora@oracle.com>
 <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com> <87ecrwewn3.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87ecrwewn3.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 22:34, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 17.09.25 17:24, Ankur Arora wrote:
>>> Define clear_user_highpages() which clears pages sequentially using
>>> the single page variant.
>>> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
>>> primitive clear_user_pages().
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    include/linux/highmem.h | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>> index 6234f316468c..ed609987e24d 100644
>>> --- a/include/linux/highmem.h
>>> +++ b/include/linux/highmem.h
>>> @@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>>>    }
>>>    #endif
>>>    +#ifndef clear_user_highpages
>>
>> Maybe we can add a simple kernel doc that points at the doc of clear_user_pages,
>> but makes it clear that this for pages that might reside in highmem.
> 
> Didn't add one because clear_user_highpage() didn't have one. Will add
> for both.
> 

Doesn't have to be excessive. But even I have to keep reminding myself 
when to use clear_page(), clear_user_page(), clear_user_highpage() ...

>>> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>>> +					unsigned int npages)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
>>> +		clear_user_pages(base, vaddr, page, npages);
>>
>> Single line should work
>>
>> 		clear_user_pages(page_address(page), vaddr, page, npages);
> 
> Unfortunately not. The problem is that I'm defining the fallback version
> of clear_user_pages() as a macro in the previous patch.

Yet another sign that we have to fix that instead. :)

-- 
Cheers

David / dhildenb


