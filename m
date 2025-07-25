Return-Path: <linux-kernel+bounces-746153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5CB123B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD816959F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB016242938;
	Fri, 25 Jul 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc3F547n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC068F6E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467797; cv=none; b=oVFt3Cqf8m3XlhIQTBxikImrssSwiOOHjCeSQOMSlvrrexIWnVIhTMr1locwd4XcMoXVsWLDA1WeGabGHFQJJ3T7P+8LAluCUZ5ary6/o3J8oo0rUC7QbAbOFHUiYmEeEy2L1F0IclaaOKCb6slt8FPZqAs+JNE7WKz+ZYCmT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467797; c=relaxed/simple;
	bh=r7tcOmJMLeLiXh+D6d+kurXynhXG1dwBJ/XS9evG7Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixOTAcCdszmPr1raf0rMjFC0lecHUsRCQd3QHLD8079c7o56AUcfcQp6aObJQtvCQ9Sl1QvcYZyjsN3C6icms0nZ3wjO8mezabNoFWNCjiHVG2N3E6gEIQPjclx76vdzXThWn12L9aCl2eBLLTO8RAa7OD/OGThT2pVSVx6kUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dc3F547n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753467790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3mXykL/F/ZsfIcI+5pjRPHMMuGt9p/dtOhJ8qI8ma+I=;
	b=Dc3F547n/aWSngsHibUh6B9R4wEh4JXExrMUUbqyHyeFTGxNcJHtmg3ygSEkdTqghSz0VV
	29h0fMDbM0y8oCN9DSqtSYMy/ZN9BThTX0cAB+/k6JhACMSXK/5cRrpYEaL6Y0IdVxjBwX
	NwkIhSOTmM0UiVlX83V4EVdKv1mP0HA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Wvo2td2iN8mEAu4R1fiTpA-1; Fri, 25 Jul 2025 14:23:08 -0400
X-MC-Unique: Wvo2td2iN8mEAu4R1fiTpA-1
X-Mimecast-MFC-AGG-ID: Wvo2td2iN8mEAu4R1fiTpA_1753467787
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f3796779so1354381f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467787; x=1754072587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3mXykL/F/ZsfIcI+5pjRPHMMuGt9p/dtOhJ8qI8ma+I=;
        b=WMR56l1ZY/eXYu6fduLiHFaf25ftUl3V6zzoL2S6SwUNSREvhdH+zlUg+NfkJ39zUG
         vd/vBqWER3dOdau4hsqcZ1n4OcLgRrXSgZoxfo8wofilyDEG0ia6I0fzBJ8jqMJHffqx
         AUSGLnL3ykrKKGyVrNeQ44zRAtPu9nKVoKWw2xtUPYQoeWPmGeCZOUWaFh7dKcTVVYii
         lAuZtZ12vlniztKlOyaxT9jiqJ77DgYDThfLt9Htvsnc/xa84ojlwOon5edz8h+payO1
         H0p9vpqNJxXhl3UwnwCTNUANmY71JfhuoxU9OAL5uSDAJlk8jtRrfOTIggqMVqwkXaue
         vQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXNJ+R6hvqf3cIw1py3CyizpjYt5lg9eXZvFdOJ3FGy0V4f00txMvMWZJkQFs/eD0OWH28jAqsF1SZdEQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2TaqHYgj+cHIu2qJSOQQv8UDGktvDjA1iiyFzgBtDAwACvk8
	Qz2oo8NdN7sZ0GaiY/Kz72WLcWY49SWaLhiqgkR5ss87zZLjT5oJz6T/EL/8IiwGAiaFsOyex6r
	VU+wZWZa9rSFwYGg2ZBaljChKjXNmhQUGGADPLNZgFrfIWDoWfC69MuxqsjhuVc0lGw==
X-Gm-Gg: ASbGnctuYrphwIoalx52WxmE4WVbYwyOnUgs0Tv1seCKVV2BgGeG4Jj3KAB4us2cVpC
	iZQsSgpboBi6u1pulGrRqIwYz3s0LxV9bIEz1rA6ZfKIy2+GLzrZTap+dDCkUlaUmJz/0oW56Zn
	UhG6Fe+eI1WqsEx7E5/Gh57eSU+VRFTmWHBMvZmpFVoU66skxAbzUCT7Vy3JoCg/qIX8wlAlduz
	+u0yM7kCRKqrFBCxvoQWxyQgPxxNjqTrA31ij2in6nKDPjFVkzk/zxniYRhyGaH4cpW3/satkph
	jgZI8/oKjSmK6fkAcsIQ36FCK3oRL4lfMSK5gNG+YOU1+Iqa1KHAF6I+L4G+X39RH1piXz1R7du
	I/vtFplnazZKuhgZv0Z0vvqirPmNhwxoMLq4SsilkG06YB6xhQkmoB5MPq2FawafJ
X-Received: by 2002:a5d:548b:0:b0:3b7:7865:44a with SMTP id ffacd0b85a97d-3b77865059fmr1349066f8f.46.1753467787384;
        Fri, 25 Jul 2025 11:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ZyDRXU7hDTQHV67zP/BJ6+oks9r39nLAiVs6AH4du+89qS89MMKpY9Q9iqAlOzaotxa3yw==
X-Received: by 2002:a5d:548b:0:b0:3b7:7865:44a with SMTP id ffacd0b85a97d-3b77865059fmr1349045f8f.46.1753467786882;
        Fri, 25 Jul 2025 11:23:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f36:e800:2f2e:cb5:13f6:f884? (p200300d82f36e8002f2e0cb513f6f884.dip0.t-ipconnect.de. [2003:d8:2f36:e800:2f2e:cb5:13f6:f884])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9c01sm556520f8f.19.2025.07.25.11.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 11:23:06 -0700 (PDT)
Message-ID: <a2a3b527-8ed0-45e0-be15-85ec4ef1afa1@redhat.com>
Date: Fri, 25 Jul 2025 20:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing headers to mempory policy &
 migration section
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20250725181745.2494226-1-joshua.hahnjy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250725181745.2494226-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 20:17, Joshua Hahn wrote:
> On Fri, 25 Jul 2025 20:03:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 25.07.25 19:56, Joshua Hahn wrote:
>>> These two files currently do not belong to any section.
>>> The memory policy & migration section seems to be a good home for them!
>>>
>>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> ---
>>>    MAINTAINERS | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a8bebd0886df..dec8db8b5cc7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15838,7 +15838,9 @@ S:	Maintained
>>>    W:	http://www.linux-mm.org
>>>    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>    F:	include/linux/mempolicy.h
>>> +F:	include/uapi/linux/mempolicy.h
>>
>> That one is already on that secion on the mm/mm-new branch
> 
> Hi David,
> 
> Thank you for getting back so quickly : -)

:)

> 
> Unfortunately, I can't seem to find this file in MAINTAINERS in mm-new.
> Perhaps I am not looking correctly? Apologies in advance if that is the case.
> My HEAD for mm-new points to dd811f4553a9512501205ba8e58ef1a6af4cb291, for
> your reference.

Sorry, I was completely wrong ... I got confused by the other 
mempolicy.h file that Lorenzo also recently touched in here as part of 
the MISC section.

Sorry for the noise, I shall stop working for today and enjoy the 
weekend (and hope you will do as well)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


