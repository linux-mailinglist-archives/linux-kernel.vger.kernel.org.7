Return-Path: <linux-kernel+bounces-749460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4FB14EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E6E4E6266
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1C38F80;
	Tue, 29 Jul 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdXrFjaL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3701134AB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796727; cv=none; b=Uupk7UHgdBeGsv1hPc/V+bHMs/ns6VJLqm72ga6/S7rznBsFNV0Ufj7buQMlKqn5a7/x4ZrVn+wlIIXyNyqzN6VdE94hVm40EL23wCgEC9lkXiinX196v9Qh3xT2onbD9f54Y6ITGUvX6v6E/NkJPYXEQa8hC9uwer8c1QNQYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796727; c=relaxed/simple;
	bh=amZzapLhudpbGb05JJyPOcNGuM8eOvy7eAjJMpgJ5rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6RayNZ06J8PmQ5uZTBoDVWnHyqMDpZd4hTrlGVwZuGHwq4zJxhv/6oRjbz1kwMp5LdDcqoZBNntORt3XV3BY8Keui7LLA0IPfBxtv9LF/aE1JtfIEhuStKrgkGCyVIYGbsw+pV3YVy2hr9quMZ7BBOQOotl7fzeCZAnILBXnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdXrFjaL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753796723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snLcLONdi0upi5CF0jgStE2Ip17xSpNY+k3DJ56V7T4=;
	b=HdXrFjaLCKdnfD4OSQ8JVjOKtmbXYjr2i08uZFWpCuUbV3ropACua2+npw/XTfJFUSif+8
	4rzTPwuzurCDTxm2FRVArBVwUURlPmA3H9s/z7OzP3n6RlfXwxZjgJe4hCaH8EvrLnh88h
	9MzDki7fbzYCdoOzJG1N9bEsNDdqeIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-dgDL43ExObWlkfF-TOqpKQ-1; Tue, 29 Jul 2025 09:45:22 -0400
X-MC-Unique: dgDL43ExObWlkfF-TOqpKQ-1
X-Mimecast-MFC-AGG-ID: dgDL43ExObWlkfF-TOqpKQ_1753796721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso33877005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796721; x=1754401521;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snLcLONdi0upi5CF0jgStE2Ip17xSpNY+k3DJ56V7T4=;
        b=gkgv4RorsS7V5ShHXjwuEIeO9nzWxzbtl4Umwou9GsFJtyE4O8JuSmOTlBVgoJ30cS
         HYudOEU+IRg02pDz5e4KPTyRLYr5XRSgqMYbU/uvgor3BCdqur7JVMd4NznFWF54f8Gj
         UmyOJ2n4QjQpl36YVJAuRI3+BIoxhTaXteUE5BaNaG6k2pfO4Kw/LSJLo7yVIhODsQO0
         Y7tjEoi4IncCxZxKRtXGECSwrkc2njg1qahyIGLNbiKIO3uX7Y445Ve3HSS1BDpxO9Sn
         e+i3cyJeHNlb2gWGkthljiDeS149BHCCNRCi+bKhO15rBZZ5CdMzKch8/e8ckC1WUQed
         8hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhMh3a9dllwrDklLAKRULLuTUoMi/aiF2M6zJ7+GN1fXMlreMmtROpiB/0qOuTEMijikys1ABPiPu4sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5gd9b5SDPR2/18U8lz/9nhrljkzGWP4RXKuYpzq24O6/JTwB
	iMo1IU7HzWmCKQjCBlT1dLiWAVsjKEGVbofAY0fSW0nXYxvTwS3Cb72R7GzMStaSlF1O8F6hb5+
	rZ0WP6AHWGBfv/Z+hLEc6a4PSfHfzucBjx2jgpOtZXeBhBskUjUdAXkRa8pKLZd48wQ==
X-Gm-Gg: ASbGncsg6AA/3K8mq3mgvvKd7ZAkAGtWwGaBeBTiX0XYK5JTOZk5snVAIlNSEFsE6zX
	XVZd5zpFErldH92KWaszrIZvUIr/B+tCf6VSTFxN/NtjY2zMnj8sTg6CFlwdTz12pkkVS4YcOBL
	Vu5oJ2ocK9sxlUZapm1S7+lFy53EAMyo4FrOozlAO6N8gOO6cALSVqpyIFnxahdcjbKPxATF6et
	US2TQrv28oqI/s9whgH6OTuJuuQQqhhd6BjliQ0Vphmf76/MLVZkJMpM1WW3rQy/Cs+FQLuKWpV
	zqWPwm1WwOwVPUGi4V8ydl7UKVK+mTEUMDOxFQGBhIjkmZakZM77ECGkcHgRpqSeVmuJCvEe
X-Received: by 2002:a05:600c:1911:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-4587bdf5b22mr90789625e9.11.1753796720935;
        Tue, 29 Jul 2025 06:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5wUcahpAHtevk+2TYP7Lul+w0qfC1wUVnwzKy3IbVbmkxmaqURJFORcVMZCT/hAO72QUIJA==
X-Received: by 2002:a05:600c:1911:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-4587bdf5b22mr90789345e9.11.1753796720489;
        Tue, 29 Jul 2025 06:45:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f338sm192950705e9.13.2025.07.29.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:45:19 -0700 (PDT)
Message-ID: <65f5081b-f493-465f-9198-8a16c9b69ff1@redhat.com>
Date: Tue, 29 Jul 2025 15:45:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
 <e74dd8de-7e60-47ab-8a45-2c851f3c5d26@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <e74dd8de-7e60-47ab-8a45-2c851f3c5d26@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.25 14:54, Lorenzo Stoakes wrote:
> Hi Andrew,
> 
> Please apply the below to this series.
> 
> Again to re-emphasise, there's no _actual_ issue here (using a typedef for
> unsigned long vs unsigned long), it's just fixing up things in preparation
> for later changes where this will matter.
> 
> Thanks,
> Lorenzo
> 
> ----8<----
>  From 94ccb0c9e49bf3f9a5a31e2f1da4a722b0a2de50 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Tue, 29 Jul 2025 13:48:50 +0100
> Subject: [PATCH] mm: fixup very disguised vmalloc flags parameter
> 
> The declare_vma() function in arm64 arch code liberally mixes the concepts
> of VMAs and near-identically named vmalloc data structures, so I
> accidentally changed the 'vm_flags' field' that is assigned to a 'vma'
> thinking it was... the vm_flags field of a vma, which it turns out, it
> isn't.
> 
> Revert the type from vm_flags_t to unsigned long.
> 
> Given vm_flags_t == unsigned long, there is no change in any behaviour
> before or after this patch, but in future this will matter.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   arch/arm64/mm/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 20a89ab97dc5..34e5d78af076 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -721,7 +721,7 @@ void mark_rodata_ro(void)
> 
>   static void __init declare_vma(struct vm_struct *vma,
>   			       void *va_start, void *va_end,
> -			       vm_flags_t vm_flags)
> +			       unsigned long vm_flags)
>   {
>   	phys_addr_t pa_start = __pa_symbol(va_start);
>   	unsigned long size = va_end - va_start;
> --
> 2.50.1
> 

For both (however they may or may not get sqashed)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


