Return-Path: <linux-kernel+bounces-874350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A628C16180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08834ED1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761E346E54;
	Tue, 28 Oct 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvxoeYlq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EE32E125
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671775; cv=none; b=m7q4GcXyUgk/8e4MQ0zNcLyBgX34d4IOfX2Neqdfge7uGYOsYLJ9zY4+McILR0BeimYzy0UobniwDJAkpYuslUmubGbTpsdn/m8HOB9riKSG6r7fwmLKlpkq2RjoRIQFC4sPTua7RnlLCy6fg3PMce1pPj1Whk6+Spjpm6QfDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671775; c=relaxed/simple;
	bh=nS8+htJjqSEedj7KXDtv5XvZ98pBWn2X5YD5S56Ge9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhu7Tv4mOBU9jV1z4ZcpYDdOBpF51vFMK/G4D0Fbwhu970/4hDJ4Qu3XdNfySjbWgnhzkJ13q8T7YPA0V1DM3rPzhZw9qVWNwK/pKRIivYzwVBF6P9/ERsesMfGjWUWgkaUZxu/YWFunrETeQwY+V7JfW1u5htiPT6o5/KDfCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvxoeYlq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761671771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZZJmYzbni2EVKfNXfjvDYvkFMG8WiEx1VqOApMIszw=;
	b=UvxoeYlqvP17HjxyG9qcd9VcG1r/VWvaTvVJK50f/TPBiYM5k9IJyT/a0y4PZ/qwAF8ORk
	ze2psaMtUf91bc7GU8K2ZoD725X0dYoPdHBNLuOEJn4uQ+7Og4dRSw+0NmWziioxdCPW89
	6NXVR+e7xkRgfg4sOy7l+njm9N5Ackc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9-QQeEszMTeIsE2Thu0zLg-1; Tue, 28 Oct 2025 13:16:09 -0400
X-MC-Unique: 9-QQeEszMTeIsE2Thu0zLg-1
X-Mimecast-MFC-AGG-ID: 9-QQeEszMTeIsE2Thu0zLg_1761671769
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e5b6f1296so135197686d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671769; x=1762276569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZZJmYzbni2EVKfNXfjvDYvkFMG8WiEx1VqOApMIszw=;
        b=YqHUaNyqUrSDnSiej4T1lesVkkHiw/4mfH0++PTL1+Hp3m2H1+2ctV0MGJneaOnm9R
         dOqcdfWTko30mlaRkZ+17wveb2Q7tliQGNKyo4nc/k8d+QNh0F7EliqXkirwNOKpmZpJ
         yykHHloZbXn1vSLthhUhYoJPto7Dey2e2xDjREehDmQi/W42dNXnZzfXAdAZgpgk3tsM
         Ffxr0/y2bPjquyRJt+PZABo/xvGHmU9lWYJtiH9vejp/yrWFVstBOVni82bO+7wfBK09
         GBoKYVKBkd3YcKBC2/PGfU9ay0/YHZ2Hq/gPs+FsNwAtPsrEpNjfQce3NIeAvRgRuD5T
         /uWw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Zuj+6sVO6YMadSAWGzn/bdRi9gk/s0IMCSIk51cV8f0PwiFVE2kaPVA94PvXj+yJVfLl870y8lKovY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8+5A36p4lyqUi8g/aUU3Yd6iUi3rZQ8zjDQdQQFk6vBkRXfA
	GjdLYWH7rJqZnAh7vFJjTwFmDDyWXkInyXLF8UrpE5a6c5dBKDMidilnwBXCcCU6S7bFgVlYm9S
	TKosXdJk/6cyqZI2z59z8XS3PavQNuwdcZrfs+y0NCkWd1DCB6tO2rxTtbOo3iWOivQ==
X-Gm-Gg: ASbGnctw6k6//B9JwlrMIMUvAXH/f6QgRyaHXTtroAFjNaAPJ+uiOWXwxNkMC6emd3z
	DIXLRayd5qUSN5HyJaDrfZL4i3zcL6C7jPc/CcwxK6RTRJru5PlIB80mYA0da+rJvhLFYTBkZB6
	y5/ML5sPiDf8wuKC/Vw0k6Mk4gQZIy5Tu52cVTCKy8BAy3uUcHeQIuy17QEjUzylRz5E3T6wXA4
	/xA9VUAAuYpLjgvvRIjsBWTr54gXAI8YMbY3OfrbLg2/E99SQC8+Hi6nmGe1LmD0JezyDt+9Q/e
	hYVuiPgG5ZDXI5zyCdLmEyC0F26RFCGKXWwgz9+iPS8CDUTEOzQAVx3sfKSEHmm7N80bGaRZXH6
	b/Q==
X-Received: by 2002:a05:6214:20c4:b0:87c:20f1:359c with SMTP id 6a1803df08f44-88008764b84mr5742786d6.11.1761671769236;
        Tue, 28 Oct 2025 10:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJPAT5x1RqJKPB3Gg2m0808ux1QN3Uf5oB2BMADrFvGcoIldW5zFHxqfitjG7zUSDb9gzyhQ==
X-Received: by 2002:a05:6214:20c4:b0:87c:20f1:359c with SMTP id 6a1803df08f44-88008764b84mr5742396d6.11.1761671768836;
        Tue, 28 Oct 2025 10:16:08 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48d91a2sm81157926d6.17.2025.10.28.10.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:16:08 -0700 (PDT)
Message-ID: <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
Date: Tue, 28 Oct 2025 13:15:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Heiko Carstens <hca@linux.ibm.com>,
 Joao Martins <joao.m.martins@oracle.com>
Cc: osalvador@suse.de, akpm@linux-foundation.org, david@redhat.com,
 aneesh.kumar@kernel.org, borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
 <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
 <20251028170251.11688Aa3-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251028170251.11688Aa3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 13:02, Heiko Carstens wrote:
> On Tue, Oct 28, 2025 at 04:48:57PM +0000, Joao Martins wrote:
>> On 28/10/2025 16:14, Heiko Carstens wrote:
>>> On Tue, Oct 28, 2025 at 04:05:45PM +0000, Joao Martins wrote:
>>>>> +static inline void vmemmap_flush_tlb_all(void)
>>>>> +{
>>>>> +#ifdef CONFIG_S390
>>>>> +	__tlb_flush_kernel();
>>>>> +#else
>>>>> +	flush_tlb_all();
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>
>>>> Wouldn't a better fix be to implement flush_tlb_all() in
>>>> s390/include/asm/tlbflush.h since that aliases to __tlb_flush_kernel()?
>>>
>>> The question is rather what is flush_tlb_all() supposed to flush? Is
>>> it supposed to flush only tlb entries corresponding to the kernel
>>> address space, or should it flush just everything?
>>>
>> The latter i.e. everything
>>
>> At least as far as I understand
>>
>>> Within this context it looks like only tlb flushing for the kernel
>>> address space is required(?)
>>
>> That's correct. We are changing the vmemmap which is in the kernel address
>> space, so that's the intent.
>>
>> flush_tlb_all() however is the *closest* equivalent to this that's behind an
>> arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
>> when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
>> (these days on modern AMDs it's even one instruction solely in the calling CPU).
> 
> Considering that flush_tlb_all() should be mapped to __tlb_flush_global()
> and not __tlb_flush_kernel() on s390.

You're right.

> However if there is only a need to flush tlb entries for the complete(?)
> kernel address space, then I'd rather propose a new tlb_flush_kernel()
> instead of a big hammer. If I'm not mistaken flush_tlb_kernel_range()
> exists for just avoiding that. And if architectures can avoid a global
> flush of _all_ tlb entries then that should be made possible.

Should we take a v2 doing your suggestion above for now and work on
the tlb_flush_kernel() idea as a follow up improvement? At least we
go from crashing to flushing more than we should...


