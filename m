Return-Path: <linux-kernel+bounces-850501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F57BD2FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51014F136B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506628D8CC;
	Mon, 13 Oct 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjuyoV/r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7F2868AD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358813; cv=none; b=E+AbJ8Is7nOz5qyhnGUrLj5i4C7aKSwuUBPv9zmDlRcN4tU3G263mBwVXwFKJOU9ZKwlsmxceUFzp5vHxwaYj3M6t7Y0zEEGpAyb/BK1YB7bRxSmNXbj6pTJjcWPlzent2Od9SFIaI2J6VC2y/WxcJ0m86lmbXAzrVYdXPXg8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358813; c=relaxed/simple;
	bh=S+cRb0KhL7L3rl6jefN6wGy8KyGOqa+4SEzg3UK3hF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fo3JWeyyjiZMAkviQRug3+AhHqkDXX8BlZywTUimqj/kuF/JKwl2uGtLToZCUDVNsNCunVcHyL6Ffi5Q5sXO6G04ysCV5g3DaZphcilUuO21RcYWsNmq3H48xK2Hc1Q0gyJ1z7z5riSLHcHa+/cAhZA2Th6mJs22VBNunbU5nbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjuyoV/r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760358811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fApsPT1dPlpmvqc8msb+pA7TEomWXHbI3o8FT9ZOyio=;
	b=GjuyoV/rS1ztXHG8riq0yMx45bhLEgpSizZiccSLaoUeW2OP5UXzTSIlmynpGONhhGW2wJ
	ufb2JjJxNy1+iuCoA7+USJYks6pBn9gGyYtYa64wDxJybsGPOUCTC+qeQWELgp61hWmcpj
	Cl7/okj236P3UXVXDlaPn+7P5AWYNm4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-GsiwJdPAODOv3YhLgm1dxg-1; Mon, 13 Oct 2025 08:33:30 -0400
X-MC-Unique: GsiwJdPAODOv3YhLgm1dxg-1
X-Mimecast-MFC-AGG-ID: GsiwJdPAODOv3YhLgm1dxg_1760358809
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so21513565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358809; x=1760963609;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fApsPT1dPlpmvqc8msb+pA7TEomWXHbI3o8FT9ZOyio=;
        b=DKj8EUFyVjU433AJNg4Uvf0g/7Pwo3Sjfn9AbsFsnxfgTtw426rVXGPRqbWzoC7Csn
         RKzmFgCCdqfHEQ27chAoLap1vGU2S/AZjONchmxgdZhJA2/hnyOEJxHvG9WD78/O8Pgp
         hHsdCYpdT1PKz2RbiKyVIXSOuQgNmmpT1VZ/e9AUFJl08pgbDf+N9VGRmwSOO41RnXBd
         VIFXpRUuXh7SOhLuutkq4f/M2P69d5+hiRZpLveNjuzwn0Ev+Clm38CrDGw7jrRx6Huu
         wCSMWML1m7sstEvdGGS0BsEdfoVdKCEB4QFY207CoVjF4bRJcFGWku0ihGkX2T5na5TF
         TiOw==
X-Forwarded-Encrypted: i=1; AJvYcCUHW40UceLON7OkOjYzfBtF/sZ1TVdUMo5IQeM7qRYsxxOErlzuvwX/Isfhj5rcI4vn+hh+ylLrsJgyfoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrozSysKE7TgoSGGpQ+NbmS9KezdwDObPoCWzSXta1w0dCfF1Z
	BXqiIfaE+6sUIKr4x/jvQ5+iWdhk6AMCoHtcjhj824ZwInAqUThkY3eXQ40jFhucXA9ep4iL2dB
	dyTpwLOff/xW7945XpL2/27sHMM9X4MC/xOJo795i0eRFWMFibc69zcdR3iUyZRxyUQ==
X-Gm-Gg: ASbGnctOTKryn2KvblYyNyRmAz2cbb/wgL4mTRpEgrcdao/eQmeSjbCyGMoZYy/wFi2
	r6L/jkn/ZA8F+0lta+O39q3B6ix0tvlEcJNDmFSwgjCM3isgDG/wVyJpDv3v9C5mjt6KFDAnaNN
	26xiM0hroIG+/ITgaD8TEL7DaT17WMTi6zQQxlJxVCgzAcHNPLwrMJMO2ZL6Ke6pyo3Va2+TSfF
	FoFvSBlcaXvFw/3FS8AyvWv2zbD4ItOZrz+x52ACIaSj6xTTWoq1O5Hh2DEKunfJXtm69wJD8ba
	P10cFaAz3vmnbZzkr8W8maB4AMckNQPJKsUzvHWJmmoabdOBK4xA+uCkzpMSZxOh6/JQiZ9mQAk
	crp4=
X-Received: by 2002:a05:600c:4fc9:b0:46c:7097:6363 with SMTP id 5b1f17b1804b1-46fa9aa4620mr127201345e9.13.1760358808742;
        Mon, 13 Oct 2025 05:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Cy6D/fWcdLGA3C5eSuXIxdOew7wbjd/FaVN1XfyGX/j8J8IUQpx5X5iCUYz9ws1sa5Xdig==
X-Received: by 2002:a05:600c:4fc9:b0:46c:7097:6363 with SMTP id 5b1f17b1804b1-46fa9aa4620mr127201155e9.13.1760358808341;
        Mon, 13 Oct 2025 05:33:28 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm204393555e9.0.2025.10.13.05.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:33:27 -0700 (PDT)
Message-ID: <de914c89-921e-4e75-abb9-315d3def1cff@redhat.com>
Date: Mon, 13 Oct 2025 14:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
From: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
 <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 14:31, David Hildenbrand wrote:
> On 13.10.25 13:33, Lorenzo Stoakes wrote:
>> On Mon, Oct 13, 2025 at 01:12:20PM +0200, David Hildenbrand wrote:
>>> On 13.10.25 13:04, Lorenzo Stoakes wrote:
>>>> On Sat, Oct 11, 2025 at 05:30:52PM +0800, Ye Liu wrote:
>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>
>>>>> Hello MM maintainers and drgn community,
>>>>>
>>>>> This RFC proposes to convert VM_* flags from #define macros to enum
>>>>> vm_flags. The motivation comes from recent drgn development where we
>>>>> encountered difficulties in implementing VM flag parsing due to the
>>>>> current macro-based approach.
>>>>
>>>> This isn't going to work sorry, it's not valid to have flag values as an enum
>>>
>>> I don't follow, can you elaborate? IIRC, the compiler will use an integer
>>> type to back the enum that will fit all values.
>>
>> switch (flags) {
>> 	case VAL1:
>> 	case VAL2:
>> 	etc.
>> }
>>
>> Is broken (compiler will say you cover all cases when you don't...)
> 
> I assume you mean theoretically, because there is no such code, right?
> 
>>
>> An enum implies independent values that exhaustively describe all state, however
>> these flag values are not that - they're intended to be bit fields.
>>
> 
> Observe how we use an enum for FOLL_* flags, vm_fault_reason, fault_flag
> and probably other things.
> 
> But more importantly,
> 
> enum pageflags { ... :)

Okay, that one is different, because it's the actual bit numbers today.

-- 
Cheers

David / dhildenb


