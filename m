Return-Path: <linux-kernel+bounces-701834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E8AE79FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1F1BC6BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F1265CA7;
	Wed, 25 Jun 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4vh1fe7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5A25BEF6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839902; cv=none; b=kgIQCeKt42/ylvzWnM6uFiMPBOexYtSrAkP/fe8V7oS5nV5rpduyDk+mhifZBvE+Pr2aN+1rwBFxM31OgR7iX4/qH1YWiqUeS6kNsYrLmjA+wiJWg7w2aI2GRAAs4noNhgMFbUKmSHKXGyQor9vrxFHoG3gMENp1sIuR//lv7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839902; c=relaxed/simple;
	bh=OvIvnuUcRx78qwb8fWNVEGQ9qzTGzeAjjsuxdSFDoVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRBazVWO7DGj+Gghkx2+qJ54VusRUmOd6HvyGshus7Fvc9tFZ+dTixAWNzv1U0ayyLQH2lyC2lmmwV3UF5MAqrLD1ItkqAXusKamUFA6TQwGH77/S+M5ZqfaOnt6Zld8qqdDMzw1044LmbREXWYIrQSCqINhu9T06/2Y/O3pFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4vh1fe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750839899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yjxBqLSglh9w0Bfe6TB64MnO1skEP54m/baUAxHHlrQ=;
	b=S4vh1fe7s3Kp1FTCI+W0olJwu3hDjcExvxq41vU3VwfY52oBMCkPtCVgXm9G9KqlbF/VfK
	mLEjLRt2Im5vLPKuaP7iAGYnmLE+lyl/DGMUF/2Oo4V6asBM0PjFr0kYYtlkfxhJRjNm+4
	QwS8NuQDIeCSx8mRlCmE1eZONj2OWCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-KBV6HWcqMqGuz5ai6fz9xQ-1; Wed, 25 Jun 2025 04:24:57 -0400
X-MC-Unique: KBV6HWcqMqGuz5ai6fz9xQ-1
X-Mimecast-MFC-AGG-ID: KBV6HWcqMqGuz5ai6fz9xQ_1750839896
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so664899f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 01:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750839896; x=1751444696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yjxBqLSglh9w0Bfe6TB64MnO1skEP54m/baUAxHHlrQ=;
        b=e3sdOB1vMHf8sFrky1Kp+MIiaaVXm+FShpcebjcKod1Ik7/w9jBhs6k5zaYCVOyYJZ
         G1f68erQF6+DkQH55Yq8ohZcqm44UvgId2PckFWs4h5nt9K66w1+g7dG22MLlxrt/Pws
         RVhae9jwFJfNn81RDUm+xRuBA6wniPxfiaq9Ggiqmhx8SbHsx/63l2qTxSLnNLJgdq7h
         ztNOOesk5VknsJu/oo6buAG41GXOe6ik80rcZhrxxti0f+yGkYgGWTdhLqA7A7OVc/yt
         5GxfxxAM85+cMYo4o7+KVVGXsi5w0zNy5weVMosDtvnV6dJse5eL5hZXs9h3d4WiibL8
         goBw==
X-Forwarded-Encrypted: i=1; AJvYcCVPgM7QGoqWV5RV312pP0VmqG36at2eQmQsC6+ndELUjo3/BxK79Byc2nEcI1t0/8v8VUckSxiTdjwic08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+OuT2GiujywRY4+SRHikst8pp3W+Wnd2F3C1KlEuIvd48LZJ
	wsz5G02WgI0diXMkhkOJVUiI2M0pSBbmnljFVQvJjfA5nPVsi/Qk+ANErT/5dDLhcdEEyvHIlDv
	I04PX7IQns8scVLPmLamrI7PcYGqx5188jF9mHnpxvvZ8Mcr9fXlm8roHwRtUAP8iSw==
X-Gm-Gg: ASbGncv8bfFS2IF4x8b6oKxgqkBI3X1Uc+4nhAeeYovVfN01zTp7tVPvAZ3QcoLjl5G
	qavrnKR/FdxzmjmIlyQS7/tCBttGQv122NytI4NS+L2q6nddnnN707Jng9fncQT+9/TiGtyZXAw
	yAgjJ7UTcfpalpZJBc3VTGotkhhwar3jvaWkCQLIBbUBp0PI/aRH5YRqkjuDKAhINP8G/iXvs7s
	vaZFjL2TVPCDSul9wys2Y9KreBoOR+gQQba+kfgqadgLG+b/DrTw1r4hFcrWstNo1DIg4K0PeKx
	nyWZRsRMfYtsrI9RLvI/Jxcq3uXBzSS/Tt6iN/VuyGLpdueEIXrLkZbq2AjA3TvNxUJ56CxePvW
	UTm9n6UUtGpRpFqMMC2cFzLIToU0sw08zjN1V53Ls0xL6
X-Received: by 2002:a05:6000:4b17:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3a6ed65e833mr1351154f8f.31.1750839896149;
        Wed, 25 Jun 2025 01:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJdi4Mem91gTU6FBagrsf3QJAVRSz9TsoKzr+Rk/R17NjfIBqv05o4O3UswDeP7ARQxo3SWQ==
X-Received: by 2002:a05:6000:4b17:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3a6ed65e833mr1351120f8f.31.1750839895799;
        Wed, 25 Jun 2025 01:24:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f264esm3888251f8f.47.2025.06.25.01.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:24:54 -0700 (PDT)
Message-ID: <23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat.com>
Date: Wed, 25 Jun 2025 10:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] fix MADV_COLLAPSE issue if THP settings are
 disabled
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 zokeefe@google.com, shy828301@gmail.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1750815384.git.baolin.wang@linux.alibaba.com>
 <75c02dbf-4189-958d-515e-fa80bb2187fc@google.com>
 <f1782ae5-c1d6-4f46-a676-666505990f4d@lucifer.local>
 <008ec97f-3b33-4b47-a112-9cef8c1d7f58@redhat.com>
 <01d679f2-fd64-472c-b9dc-ebe87268ce82@lucifer.local>
 <a16071e5-ae97-4e1a-9df8-f353f6b319c7@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a16071e5-ae97-4e1a-9df8-f353f6b319c7@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:12, Lorenzo Stoakes wrote:
> On Wed, Jun 25, 2025 at 08:55:28AM +0100, Lorenzo Stoakes wrote:
>> I suppose the least awful way of addressing Baolin's concerns re: mTHP
>> while simultaneosly keeping existing semantics is:
>>
>> 1. Introduce deny to mean what never should have meant.
> 
> To fix Baolin's issue btw we'd have to add 'deny' to both 'global' settings
> _and_ each page size setting.
> 
> Because otherwise we'd end up in a weird case where say:
> 
> global 'deny'
> 
>   2 MiB 'never'
> 64 KiB 'inherit'
> 
> And err... get 2 MiB THP pages from MADV_COLLAPSE :)
> 
> Or:
> 
> global 'deny'
> 
>   2 MiB 'never'
> 64 KiB 'always'
> 
> Or:
> 
> global 'never'
> 
>   2 MiB 'never'
> 64 KiB 'always'
> 
> Or:
> 
> global 'never'
> 
>   2 MiB 'madvise'
> 64 KiB 'always'
> 
> All doing the same. Not very clear is it?
> 
> We have sowed the seeds of something terrible here, truly.

Fully agreed. "Deny" is nasty. Maybe if we really need a way to disable 
"madv_collapse", it should be done differently, not using this toggle here.

Regarding MADV_COLLAPSE, I strongly assume that we should not change it 
to collapse smaller mTHPs as part of the khugepaged mTHP work. For now, 
it will simply always collapse to PMD THPs.

Once we want to support other sizes, likely MADV_COLLAPSE users want to 
have better control over which size to use, at which point it all gets 
nasty.

-- 
Cheers,

David / dhildenb


