Return-Path: <linux-kernel+bounces-830392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F19B998A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB04E4E0600
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D6C2E62B5;
	Wed, 24 Sep 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUunRzO1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212472580FF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712245; cv=none; b=C7945jqdgHpPvo1JWUMYWzwx0rgg8Df12xFSXYjmmfaiP4b2TvUvQxh1QDFFg51WxmqS+sQEhoFpF8WA7m2cH7tHZysOX17f7au+k6sUQ9OdU5cLlqpaidywKxWbbyhRakoNkS2+SuB6p71PGvWOzjCpg3O1t5u9PaZa2HJK/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712245; c=relaxed/simple;
	bh=zZcEtHinWISw4HB/VAm+aJSzsYIAylkeYP/a+VaiYJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8bJ1J9dIUeXDo6wBC2/fuHiJOY7oNoqLRDIQEca83u8QqYBOUTwtXniRXCux/LIp+1gyNjxseOTle9YdihJauOcLAODtAHHBNYZ6ANd7V4mchIEucFwZwffSdgEopwwUrt7wpU7xW6qruviUXSYbINFKUtC6qAN7vxs8QULG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUunRzO1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758712238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QjizJOtIasCre17yrgz49+y54DCATqZxCDyv3+Ah6yA=;
	b=XUunRzO1IGTYkP97FsLby+sxUjMej4TvXK8Yl4ng4inL0rksJuHC3HFafzvse3SUI+xD+6
	/rOZ3XCPmgsvPhcGwZ1BdVVg4vUIDOi7hPjZUJOEO79tSvpnjmdH+kODcugYj0U3NW9/ee
	6NUSf+OPFfhPF9RukbnoeFq3K9hZCaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-EQBNWnRqO9SRddIVA6BsQw-1; Wed, 24 Sep 2025 07:10:36 -0400
X-MC-Unique: EQBNWnRqO9SRddIVA6BsQw-1
X-Mimecast-MFC-AGG-ID: EQBNWnRqO9SRddIVA6BsQw_1758712235
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e198ddbc1so5202195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712235; x=1759317035;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjizJOtIasCre17yrgz49+y54DCATqZxCDyv3+Ah6yA=;
        b=o6A0huzh3Y6fMAwWaw8QvxhSz1xMkfV4mDwc+XyL2t6FVzOcKtE0vrGuCtsG6lnSOj
         OAEZGwUNXVE4+3O6Q/8fxDx1/un32nx+GyNe64m4y+0iqmZNnLTMQ0/b8wt68XxYjuqP
         sDVZjA4D9spGIJOrVLYNMVVt4vdCrotHi7Y3RK2PUV3bimHw2VTRKT9aOmX4cObY0SPP
         TpcKtRjtaKDHfH8lUnKnsVk7K9kyYDWYiAVEkQQ/BpU6bjTVzX/jmY5PPCSq/4gOT+0s
         QnjEIyjKC4efbo4wiiVdRMZFkINZGlVSVzf55QockFHGfmIz0x5GRL5wPagRxW1z9yQT
         OxRA==
X-Gm-Message-State: AOJu0YyzN5W22czzOnsfG1mYoz356CqLYg2EuxlSHe+fQfnVJmNZjYVO
	jyIIs/rQRDIoSgGs6UM0GaozJKTlfl0JtxgYd5JhiHmZlJB4uYbHObAL5KRNGZPUZZmkWKzE6h8
	ZSZ0hNaItr5ytWQ4Och5r66L1Ruuvz9RLQuxEd90ExktNIU8dozMnHgPZjBgJ5xRKyA==
X-Gm-Gg: ASbGncstQSsG3iKxfq1oy7lDmxX+trO88VwmKma3A5tuTB45o0E/h5nxrw2TgIk7fj/
	E3mOu5FNQ887d1BflsUixfy3qfnwf/AZEVBAebnJeGj9qVqZpIyD4aiCH6gOh4h3TuspW82kHln
	UsyPTrDIVYq0jXhd7SZC9eA6jDxXeoxw0sUFSU6zk7PmYTMhAYxtx02Jp86IA/7cjDRgba9c/1k
	eFgHZ8+GEk9KG4Drg1XuARrbg8SI8CxMvenj7gMS0an7t82/91AS81q2AdT8PU8keR/ZUrRAv3v
	u6psoaQ+i84ks/tSj7f3PLyneWKVVTRd/9xFg7pMz7ldg5zYw00TsNOHIDHiZNDeRGhoZpXi1Kd
	SLnfFh3drx4ifoXZ/ImbMBv1BcgDG4/PPY9XebN5p+eLaCRIFxZcEFVs84u04PGfTHg==
X-Received: by 2002:a05:600c:a318:b0:46e:1b9d:ac6c with SMTP id 5b1f17b1804b1-46e2b5ae650mr15221345e9.17.1758712235553;
        Wed, 24 Sep 2025 04:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfjm0wZkVbwQ1ssygwylIahTNFeY9nCpNKyJLOIN5at81FhLNCYY61YbcAmW3vmCGWGRo8/g==
X-Received: by 2002:a05:600c:a318:b0:46e:1b9d:ac6c with SMTP id 5b1f17b1804b1-46e2b5ae650mr15220925e9.17.1758712235127;
        Wed, 24 Sep 2025 04:10:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aaea069sm34696585e9.24.2025.09.24.04.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:10:34 -0700 (PDT)
Message-ID: <d03dd7ab-5237-4de6-8872-a8ae2e9b7c5d@redhat.com>
Date: Wed, 24 Sep 2025 13:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/16] arm: mm: define clear_user_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-13-ankur.a.arora@oracle.com>
 <d2dca02c-ec5a-4b3d-92fe-2b3a3614b5df@redhat.com> <87jz1obyd7.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87jz1obyd7.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 00:25, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 17.09.25 17:24, Ankur Arora wrote:
>>> For configurations with CONFIG_MMU we do not define clear_user_page().
>>> This runs into issues for configurations with !CONFIG_HIGHMEM, because
>>> clear_user_highpages() expects to clear_user_page() (via a default
>>> version of clear_user_pages()).
>>
>> I'm confused. Can you elaborate once more why we cannot take care of that in
>> common code?
> 
> So my definition of clear_user_highpages,
> 
>      +#ifndef clear_user_highpages
>      +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>      +					unsigned int npages)
>      +{
>      +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
>      +		void *base = page_address(page);
>      +		clear_user_pages(base, vaddr, page, npages);
>      +		return;
>      +	}
>      +
>      +	do {
>      +		clear_user_highpage(page, vaddr);
>      +		vaddr += PAGE_SIZE;
>      +		page++;
>      +	} while (--npages);
>      +}
>      +#endif
> 
> assumes one of the following:
> 
>    1. clear_user_highpages is defined by the architecture or,
>    2. HIGHMEM => arch defines clear_user_highpage or clear_user_page
>    3. !HIGHMEM => arch defines clear_user_pages or clear_user_page
> 
> Case 2 is fine, since ARM has clear_user_highpage().
> 
> Case 3 runs into a problem since ARM doesn't have clear_user_pages()
> or clear_user_page() (it does have the second, but only with !CONFIG_MMU).

I think we should look into having a generic fallback version in common 
code instead for that case, and not require the arch to implement such a 
loop around clear_user_highpage().

-- 
Cheers

David / dhildenb


