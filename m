Return-Path: <linux-kernel+bounces-839903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2DBB2B11
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9855432375F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F72C08DC;
	Thu,  2 Oct 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzde3X2c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0B33F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390186; cv=none; b=gAbRfwcxSySWov9SIBJkRfNVvrF6YpcPUsnuI/rePuBxsCu74baZfgL1BMnAtUa2QeyWelloLVTV8Go5i09qgvxZyY0pUE2UgDhCnsORNGDcMo/ar+Bn3rUfLFkBxkLIEQsOdSJOpzrhdlv6LwIzl+zWW7/StkK1QtDMr9YbHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390186; c=relaxed/simple;
	bh=I0YxMAN3GBIQJQXHdtFLoeNuETwlyn6WQTQnc4sgZ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2PltUdV3Dfk6bYvwpuLM+4XlwSYXbA+sKGc8vYjeINzG3uUT4ENbt6be9DQL1U2yD9fPcNIZIlGZhmT33PyWF8zlE4ibCzyvCIu9ZzWBJq62npjkTOAF4KCQdlnvke6qTAjdaJjaHCyNnLc+6iRQgV4gsSJhhs901yeiIskCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bzde3X2c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759390183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0CSDnRn6hYSzmKVQfh+M23X97GCdHbW5ItsaS7LSYJU=;
	b=Bzde3X2cSpw+E4R5ZiP32RrbikHKioPRFPsM0b2Ekr+W33D4pGjmrZUgDXz9+YaSYqfRgZ
	wyPu6Iu+fgB7+m9zfnq7vHiygcS8md26evAaU6WvZQOLsp/S3FGoCQ1j6Ln7fnod0mq4la
	lsYdeutIJkm4X9CC5r2NhcbHgHuhw0o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-94XqiBayPwCu2zGTDMd3QQ-1; Thu, 02 Oct 2025 03:29:41 -0400
X-MC-Unique: 94XqiBayPwCu2zGTDMd3QQ-1
X-Mimecast-MFC-AGG-ID: 94XqiBayPwCu2zGTDMd3QQ_1759390181
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso2810735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390180; x=1759994980;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CSDnRn6hYSzmKVQfh+M23X97GCdHbW5ItsaS7LSYJU=;
        b=WVzXoVUtiI7RuKHdUxyORWXbxoAOgga7GNCLVcovUUMeetV5yQ3VlgsFC/JXL3xc98
         ykpPPULPBfJDepTpDvnC49GdGP0ffAFLFDTiyyT2HcaCndiJkc91hO5mrjDFB2RQD720
         Od7J7RykTabm1iTJcQz0+sVZjx+qvAIbMB7tMGuyxKsJUPd35dLmA+iyMKI7aURcliy3
         FADoCjiLY+DEKOTZtQjJrRhkIuHzHykXyseT1XEPScaD5ccPThnurZ88EniAQprxYYxg
         WK6Du8Ia3nr6ydaXIyWdO2snXXTS23Img75Lkc5nktfGDGzA6eeQ9k7GUck2XklAqvGM
         VZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU5KIl1EZHDf6bDE2I/tuWmkxd6d3rTZUVZEG2ZK+o4lZPUDWQqgDKopOwTDPgp5GL0334FMHwTbpZBPl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfxPXaCQz54Gkqnv+GnlNbzqFdyA7BPbckTmA6dhhgJcaeB7b
	FOX+i5G+J+ZNlybFr/1S0IytnC+UJF5Sfyd/sRMHOrDjif6UmS7lOZqJ0x8Ov15/RGAPpQw4Fpu
	N0Lv6LDvAaJQwX+gAm5EYisihW0XUxtj8Bbxr6WXJuvq1Hxk3yAmTDCHNM6lcGqvHFw==
X-Gm-Gg: ASbGnculy3XdovGTMa5Sn27I5OQF87RC9WSTnRvHXiSh+JHHeEbBz3KEZVgPaH7RCo1
	L8Xzem/iEIhY+p2KsPCGlY/RDlnjxooWX0iY5XVDoCRKnYutzKiDSrgNukgsaT/rBcfgBCd6uds
	hnIwMyIvwKRPUBAqYDWI6B/f/pORFdRrPc2LF7PBCApgncwfXsrb4FD4lt/P/98a+XYcsAK9V7r
	6bO2bfGL+CIHaHXfLS++/nf9IllMGkt1/2bQcG+Fs0qIRHZXhuKUCZDd7/Fcz0yRp80D/IqT+yF
	6Ra4Q5ZVwUYSncjMkydpzzCOYTTeJzIQEY8VodDqG0JBJFs1dhPnnSUVHv5aMQVvTKYwF6ZgxOm
	CU6zOPePR
X-Received: by 2002:a05:6000:2302:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-4255781a637mr4368079f8f.42.1759390180567;
        Thu, 02 Oct 2025 00:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6WQwGgDH0BtLI/Rc2UQozJzaeNJMjTwQlnd7GumY5IaNv36BcVqxzwSGHNhnqsScbI2ZF5g==
X-Received: by 2002:a05:6000:2302:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-4255781a637mr4368052f8f.42.1759390180165;
        Thu, 02 Oct 2025 00:29:40 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6b23d4c5sm14487845e9.17.2025.10.02.00.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:29:39 -0700 (PDT)
Message-ID: <fc539c61-7a28-42ee-a28a-fef987967958@redhat.com>
Date: Thu, 2 Oct 2025 09:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: redefine VM_* flag constants with BIT()
To: SeongJae Park <sj@kernel.org>, Jakub Acs <acsjakub@amazon.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev, peterx@redhat.com, axelrasmussen@google.com,
 linux-kernel@vger.kernel.org
References: <20251001165121.54258-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251001165121.54258-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.10.25 18:51, SeongJae Park wrote:
> On Wed, 1 Oct 2025 09:03:53 +0000 Jakub Acs <acsjakub@amazon.de> wrote:
> 
>> Make VM_* flag constant definitions consistent - unify all to use BIT()
>> macro.
>>
>> This is a separete follow-up fix after we changed VM_MERGEABLE
>> separately to isolate bugfix for easier backporting. As suggested by
>> David in [1].
>>
>> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
>>
>> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Xu Xin <xu.xin16@zte.com.cn>
>> Cc: Chengming Zhou <chengming.zhou@linux.dev>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Axel Rasmussen <axelrasmussen@google.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/linux/mm.h | 66 +++++++++++++++++++++++-----------------------
>>   1 file changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c6794d0e24eb..88cab3d7eea2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -246,56 +246,56 @@ extern unsigned int kobjsize(const void *objp);
>>    * vm_flags in vm_area_struct, see mm_types.h.
>>    * When changing, update also include/trace/events/mmflags.h
>>    */
>> -#define VM_NONE		0x00000000
>> +#define VM_NONE		0
> 
> I'm wondering if it could be more consistent to use 0UL instead.

Not really required, and if we're switching to BIT already there is not 
a lot of consistency to be had. Would be different if we were avoid 
BIT() is in patch v2.

-- 
Cheers

David / dhildenb


