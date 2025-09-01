Return-Path: <linux-kernel+bounces-794717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D2B3E639
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7904204BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFB33A000;
	Mon,  1 Sep 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0rBeIS3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1D337689
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734909; cv=none; b=JHQFNagE4fHMM+FQpPixQY6M2WGW0smS3NDDOTVGwN05BL4fTA3F9QDnR0TOw1IoMmLZnER+4UP+7pP8B4Pbc4OjTtH8O4d/TVGgi1ICVFcNqdvMnx3ast7Tb9JrWseIz/NSLPaFvQj/L36rVgIBs+USIN6CGgbWVFTkwxUxy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734909; c=relaxed/simple;
	bh=TRzVpQ25hrXY2A1SfUneI5clxPubexwphI4QhSKQSKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QoTUmky0DyE/YOGjDNC8JBLJunsYQ7ZIq5TbSUmTT/j76mKBxbT8twp74F91ip8XZcA0UtFs5KBOCkX9/jWwudKT3vMqTXJCv0ZaOTCUYBAxgbqyl0bPmFxA0l/PKvnUMqrQUo0Tb50h2K/oVmaN+kxRTrTVwE62Fqr2cqTPk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0rBeIS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NriXVnZPHaqiO5Dj5qEVt/Cua6PNSalsoubuoEiq6aw=;
	b=F0rBeIS3CV5JonUuTjH5pkNUId1KXGiD3MUqpzIonMivgdBJWWqT7izl/mOjkqrMBbWU1c
	tuhotwFpMNsW1K1JsajOD1gZc8ZAkiW2MvWmOuMX65ZG2pm6IQI6GsH0NMp/iuJsnXtT/f
	C57rnjv5kjnIiECikq9NxK2E+kmH+54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-YZXnT3qJM_GXNyLFUL4Ufg-1; Mon, 01 Sep 2025 09:55:06 -0400
X-MC-Unique: YZXnT3qJM_GXNyLFUL4Ufg-1
X-Mimecast-MFC-AGG-ID: YZXnT3qJM_GXNyLFUL4Ufg_1756734905
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b7c01a6d3so24311935e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734905; x=1757339705;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NriXVnZPHaqiO5Dj5qEVt/Cua6PNSalsoubuoEiq6aw=;
        b=dbpdmLJOPfCXbSLrKiU9XguTBWvsN70Oo+FYaemIXNAv9YxBNQt4kqq9lzFBmDODkV
         /BnC7ZyhGdJQtO9PBWGckXOi+fAPglnn/kwUx7XrzRmv6bueivJRCh94ExL3mhsagOrn
         AHOIy6wmB6euSETGStCw4w0FDDyk5CFVsq3Ssim53Ia0/s/iHM7UICtZ0xhipGeeAKNq
         uOKqX4wyAn3U4BVifNm0b4eIWfMEOYdeseQJtPkQGUV7BeEeAkpwfxlZtxinsaUIP8SY
         LXGfYLzPHCwTS2MIqdVBBDpu9Nm+eXrT2PWKCY0KZL+QE9hreZqJxtjm2P5qjEOddBiL
         woiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZnRNxkTd7a1sXqy3NByE4DGEQE+R8fj0SjRHONkMav+RiB8MG4KphcxgFjc78wQqh5BK8kD1VCn9xozw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTkYcBb+nvVJMwMqbzwcfuCdAN6/9KHBGGgzD50yxxHWxFpmO
	Jox89QD+DiD/jTSygaCTD0hv6P5dwnaSm/NJ+8Z5ooCjloAYxWs80wT3waHEg8sjVP7FqNsiSxB
	3mnKPGLY7TBTOlQjAOuPf4vPkDfmKWqb+DXKygb0JfRg3mX3JI4VIja4FLaNl9TuHaOmO7ux3QA
	==
X-Gm-Gg: ASbGnctUd7STmK2x1SpwaE+wy1rPKTvK2rouSgu2cyMbsg4VKK9tRuX/qXLet6C50D0
	920Jo0Yo4++TMni6LkEvozQwtdD5wY3DcfbHynL5sE4pXYidiXtW0gcTaQzkJavTf4ffVqdwkfw
	KkH4NOvfJapiQlIZQ+fEBN4k6inHpTtE/QjnJJCtMyjWXKnDAIYY7Eg4Qi3Lj5fkM+OcHwOFuno
	9FfgYvtcMDSoYOuFg50uh9RudsmIvqNNEi2iJa6U5amVM5ZkEuND2ASXNln5+XLEmGOcwJFoTlQ
	HUgAKbIgXLX1HHw+3aXNOvperNyrIYhjmQ37Xt/gZLqY2PY0tUafV9SjXWmR+xN6hHHl26iKcx5
	we8h4G7aGsRtqxajo0wrCOqunVBBXfpEMk7IuSMMx+zpTC7Kgjl9tmNOjQmcBnxFHI2Y=
X-Received: by 2002:a05:600c:a41:b0:45b:627a:60cf with SMTP id 5b1f17b1804b1-45b8559b8edmr80725405e9.24.1756734904600;
        Mon, 01 Sep 2025 06:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw9ob70sxuIZ5gwuScW1PzmZuqCETLGf0c2CRTvVo9pjc0fxaGT3edOb/FMXm7G3pI6UFHbw==
X-Received: by 2002:a05:600c:a41:b0:45b:627a:60cf with SMTP id 5b1f17b1804b1-45b8559b8edmr80725195e9.24.1756734904134;
        Mon, 01 Sep 2025 06:55:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e9c41cfsm157982965e9.21.2025.09.01.06.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:55:03 -0700 (PDT)
Message-ID: <e695b279-0540-494c-99a8-987179979d58@redhat.com>
Date: Mon, 1 Sep 2025 15:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] parisc: constify mmap_upper_limit() parameter
 for improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-8-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-8-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> This piece is necessary to make the `rlim_stack` parameter to
> mmap_base() const.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   arch/parisc/include/asm/processor.h | 2 +-
>   arch/parisc/kernel/sys_parisc.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
> index 4c14bde39aac..dd0b5e199559 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -48,7 +48,7 @@
>   #ifndef __ASSEMBLER__
>   
>   struct rlimit;
> -unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
> +unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
>   unsigned long calc_max_stack_size(unsigned long stack_max);

*const like in the other case?

-- 
Cheers

David / dhildenb


