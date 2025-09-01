Return-Path: <linux-kernel+bounces-794649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D59B3E4B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7811F481B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1D2773FB;
	Mon,  1 Sep 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj/PNebn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6E1DF25C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733010; cv=none; b=Dnuz8xhV64qvjH9LCoo5aUy+MnR2w8wdQT3lXpnK9uD9/ducpA6/3Hx45L9Koyid9tuOj7UTRvI9rpWbqTIicTd6qOq4YB/pwEM3GIDF1w57SRJLQln63ig2qiB8dqsW6nfEY6ehq6TGaaF0xX7tO0teYkAXfeTnfssiPHX2hUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733010; c=relaxed/simple;
	bh=Z363fU8PYWxEEDpwzCt5IGCz/RGVwygfFg+xbWwZ2Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2s/iwZPAOAQT9Vf7EqpLQjBYV+UN9WP4xvCeMmJjFSO+phFpoI7HS269NFVsfi1ZZxQ7iUtwzJ+Tbbbqk68m60G1yxLyllRQGtPDUpGWDQQhTvy03MngjAL+cuQnLYSPBqiBpCbLp5TmrTiyJMtrqW1oLvgeL/4+YbRqefwj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lj/PNebn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756733007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5EHyQASudRpMIxAo74+7riZFD6rvogYVCRTIssUbz+k=;
	b=Lj/PNebnC0dVSl76/u0uTIZFwS2KCkP/375A/am2vgnqZ7/n2aFyWhWjwJ2L+3REQj8Dtp
	PiZVM4YrqCnURZo53cC0Llt5guFtX7RFqRGVIQ8kfrTFtNVF2gPpqNtM81+S/CS7vDVvNF
	SMavp4BwUY1W33M85tmS9RDLxEXBHX8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-hD233fJjOoy_KdepGLDuyw-1; Mon, 01 Sep 2025 09:23:26 -0400
X-MC-Unique: hD233fJjOoy_KdepGLDuyw-1
X-Mimecast-MFC-AGG-ID: hD233fJjOoy_KdepGLDuyw_1756733005
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cdd69ee330so1846816f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733004; x=1757337804;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EHyQASudRpMIxAo74+7riZFD6rvogYVCRTIssUbz+k=;
        b=JMHMZlXb3IhstTGGiDhvL3UrnRo+c3wBy1WcnTAJZ/3pT4bCx8ySbsnyiCSrJrg1oI
         T6HU5FywKhUJQyV2sAU6RJWc6uzG8kKQroapvXmLM0FqQbDQWm1LcSBrUWjJEEvmyRj3
         UPcFuqesAgd5kZ6ADoP8DARXItOmgAL77SnIQY7E38IwQO2aN+L+5v5ipKjMjezzwe+8
         yC178R4dDJ83p8wm75N9tmmhXa3Kd+io9Tyc4XdXhU4c+hrS2Ei6GFysHYWwCHJMn+f1
         69N+misQs3WcP4hXdxqhQ0QBw6ZWrMWrvX1SXqnA8w7XNJanm8Dyjw77lNvnL6M+9rhR
         0Jjg==
X-Gm-Message-State: AOJu0YzCgzW0OH6dSZN2STBtPtdT8P94+3pAFINX+GymOYbGhA3h8fRA
	VCB66Sp4fKrHRC4Y7soLyISFWcESesMcn/v5wzSgLnphkZDhc2rS8r+v751PMyLJUx12ihnddCZ
	q0gvgDK8hcZJZHKEAxB0+zaWG60z578UcnON94JHS5jN9oChZxPULplQxmMmV16tLMA==
X-Gm-Gg: ASbGncvU3gJVL8YAP1dXn57f7klWn8sHHcJyKw2o0eHhjd+wjxrxHxgL4EhKMmQgVNr
	BeEDTi7hBMHOgZwXIobEocyAiGdzvBT9+M6KUdX1iS9opMc77axOMNX5rGKDW64LPwnqXpHKhyG
	IAKC0a57mDPxXPxRlmCbDbHJ2Qrpkhypw+Ui3QqCMu+MxKda9YeWZ0IgjyvBCukVP6wKDEZguBl
	gzyNfD8orfXRZ+6H7qF3X9kCO2rJBRMhSM2XvLkM7IWEnPweqh2im3hdkD57QKvVyLAre4SVOsf
	h+gJOJd3IoT0IjimajpkFTQH6nX+14xt813MJ+2yg0GBP1MzmusXx8ADkVNVXQeCi4kwaXcbn+g
	Nj4ncMaAwDCr5wOLZpTuyLLJmg5thNcJ8Z6QTsKtC+LDqM8emIYniMWVHO5DDLgIjtPw=
X-Received: by 2002:a05:6000:250f:b0:3b7:8b2e:cc5a with SMTP id ffacd0b85a97d-3d1ded76f89mr7325976f8f.40.1756733004609;
        Mon, 01 Sep 2025 06:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpCndD0LFPlutircWKghY8QG8SUd+xV9esmudoxAzufTgNwxKCMPPfcvQOOFMy8QRFAF3U3w==
X-Received: by 2002:a05:6000:250f:b0:3b7:8b2e:cc5a with SMTP id ffacd0b85a97d-3d1ded76f89mr7325955f8f.40.1756733004178;
        Mon, 01 Sep 2025 06:23:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm15422593f8f.15.2025.09.01.06.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:23:23 -0700 (PDT)
Message-ID: <177f4c8a-1ac7-4fee-bb34-ebecc4ba9384@redhat.com>
Date: Mon, 1 Sep 2025 15:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memfd: remove redundant casts
To: Andrew Morton <akpm@linux-foundation.org>,
 Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>
References: <efbbe6093b64a5b19f974871d5262d6e75dff2c0.1756639225.git.joeypabalinas@gmail.com>
 <20250831123426.3ce56a2448b520aba75f8edc@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250831123426.3ce56a2448b520aba75f8edc@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 21:34, Andrew Morton wrote:
> On Sun, 31 Aug 2025 01:47:48 -1000 Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> 
>> MFD_ALL_FLAGS is already an unsigned int. Remove redundant casts to
>> unsigned int.
> 
> lgtm.
> 
> It's rather annoying that the MFD_ALL_FLAGS definition is so far away
> from the other MFD_* definitions.  What do peope think of this little
> cleanup?
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: memfd: move MFD_ALL_FLAGS definition to memfd.h
> Date: Sun Aug 31 12:29:57 PM PDT 2025
> 
> It's not part of the UAPI, but putting it here is better from a
> maintainability POV.
> 
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   include/uapi/linux/memfd.h |    2 ++
>   mm/memfd.c                 |    2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/mm/memfd.c~memfd-move-mfd_all_flags-definition-to-memfdh
> +++ a/mm/memfd.c
> @@ -313,8 +313,6 @@ long memfd_fcntl(struct file *file, unsi
>   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>   
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
> -
>   static int check_sysctl_memfd_noexec(unsigned int *flags)
>   {
>   #ifdef CONFIG_SYSCTL
> --- a/include/uapi/linux/memfd.h~memfd-move-mfd_all_flags-definition-to-memfdh
> +++ a/include/uapi/linux/memfd.h
> @@ -12,6 +12,8 @@
>   #define MFD_NOEXEC_SEAL		0x0008U
>   /* executable */
>   #define MFD_EXEC		0x0010U
> +#define MFD_ALL_FLAGS		(MFD_CLOEXEC | MFD_ALLOW_SEALING | \
> +				 MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)

No strong opinion.

When we are exposing this through uapi, wondering if we should rename it 
to something else that includes "MASK".

Quickly search for similar instances. For mmap we have the internal 
"LEGACY_MAP_MASK", but that's also a bit different.

There is this oddity that we store the hugetlb size in the upper bits of 
flags, masked by (MFD_HUGE_MASK << MFD_HUGE_SHIFT).

MFD_FLAGS_MASK maybe? not sure.

-- 
Cheers

David / dhildenb


