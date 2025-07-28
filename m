Return-Path: <linux-kernel+bounces-748022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EAB13B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471C9189D417
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83E267B01;
	Mon, 28 Jul 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi0GbFRi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EA2673B9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709336; cv=none; b=Pvg84cbAs6eEn2aIzbLY/uqlIgioENbg9hhOf0LXye338HXsZlhuDxjuEROmWC8UDyQ/x6CRMQw2kLLfw/ygM1XMbPYKA5qsRydgdWSG4IfTrPXD4QJEXD7pmGJulbe+lrwsGqItC2HvbRrgcUhjfDuxaweFO0rlcZJvWDsREuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709336; c=relaxed/simple;
	bh=TlSoO3vPV8cZBvh33T6m3vWvJPn44ULMpjGzeTRvAiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRncPAAN/iXe+m7dA49ZzxuCfA/XESRspqZAujNA8AT6D0dY0ZW1fw75ySXF47IJV7JN9M/Y9Acf56ahERoJ7IirqYv5kb8duALKMZNWh/+Zui/k9Ep/8NxyD2J7NM/22X69LK2E6JDQwF3QIa0DzzJ95MS/upBeOXdml6i4xGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi0GbFRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753709333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Le65crWkL2r0S+fv/QPgs84i+1vkmflDFPmUD2ynLfM=;
	b=gi0GbFRiqoirvQ2fviygrfc2zG7cBCHcs/+HitrdAtaw7r2ZtCRJHP/xdjLQFLCz6wXlYk
	kHWJ4CngFfj4JJlMuVFjutWXmH/HTauu9hHlRG+BfNsK0Na0jf69KFawEJf3pKh0FCCGaY
	sxElaE6k83s6qxK2dwJK63wdIgfimPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-GhosyDgUM5yPHHiWjlWZtQ-1; Mon, 28 Jul 2025 09:28:45 -0400
X-MC-Unique: GhosyDgUM5yPHHiWjlWZtQ-1
X-Mimecast-MFC-AGG-ID: GhosyDgUM5yPHHiWjlWZtQ_1753709324
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4563f15f226so9010345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753709324; x=1754314124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Le65crWkL2r0S+fv/QPgs84i+1vkmflDFPmUD2ynLfM=;
        b=teUDg7Xzg4EirU1VA4sUyG3YBTPFrUVTLMGaQwY8G8AqUspOdFWf3FXoCgkNhCYyax
         /ipVRm+jpw6/oTvkWMOm9EKcNWMfIoA2+WGpqsfmpak1n10MPQ9dI/qy5EG8BHFfBj1Z
         VCWZj8JvdCsUJ4rJK+AkqX1CmSiDIn7fXxxYxBoMhInXZ0M0aBIp7tiNOMo6TMN7iJNy
         KiJmrkFHSGaHTpGz7ZJUb5wAvcgp2DBI93veHt/+o89LJ2+BoTFn2JNvyCKjnv4VCw22
         4nn/RrWGl7eItEn1kQVwr13uyaKgB/Ov/pz1vrmZP/p86mC7b4VhgX2K8nEbeKbK7ubh
         JhFg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVW8zDCqNYKF74pYkcLCgUXk6MEbM40y9NXp1gGUx/TCb0LGqaJFAj6w2bO+O6KKaSrRRgyGT5qR8vHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLwvTSFO6+YbuZJUxOzZpR6+3oDEVrwYBuXgxt4IlIcXa9QS/
	4lTD77p4lby5b3wgJX4zNOweQTRj/pP3+k18mW4fKk/XPoaeJ01J1uMUZe07lUPiV6RVm+iQ6sD
	h5mr5Y9JiA5b2gyNoEQOYjlJNwdYCCnw0lbdFWgNrZR2sUy0IEIZ2XlUhhQhj4CIoMg==
X-Gm-Gg: ASbGncsNRg+n5aubMctVfdSkIouHEWYGEenyKuGkcsbuPKQ2NFZ1rzyyWuN79XGmjrc
	NiOIf8m76gdvVHDwmo/YGUUYYBvt1aeWbfNq0g68ecO1sODY9vy5kNwLnLqnafrNOtBWTmJEExP
	qdKm5DAwpkrnf0OhG4p2UFcIeytTg5iYNkbljKhEkj/07+KKzsRGuCYVVN4kXv2Ula0s+hY5bOm
	XZV3rCpLhCnGP0rEd4LbenPKR95c5nZTfZKv4UcOJ2Tfa/DAF0DzZxPk6qlqxcxkIe/fI4FSfwx
	jkkVmHisL1/Ztx5u2jqb0l7jHGYfV+YS8qkU9o1KgRyejHzrgN2QUSM4iSjIqR5nTwX+rkWNMU7
	EUfEVRoUbD3edguD52C6kEF0K9Ib5jMXZoVbHD0E3LyrOiQFXhpAa9mZYbVflFzv8S60=
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45876447cfamr87417955e9.21.1753709324268;
        Mon, 28 Jul 2025 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsVPv+MWr7O6tN7PNmT8Q2J8IDZY4LgEZaJPbBaAXxPD+wuoWYfzqkdrvfI0jOOB8Ha1wgzg==
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45876447cfamr87417625e9.21.1753709323785;
        Mon, 28 Jul 2025 06:28:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377f0sm156708195e9.6.2025.07.28.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:28:43 -0700 (PDT)
Message-ID: <e83ac8e3-06fa-4ccb-95e5-4f95ba5aba7b@redhat.com>
Date: Mon, 28 Jul 2025 15:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-3-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250725162258.1043176-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 18:22, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Describing the context through a type is much clearer, and good enough
> for our case.
> 
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
> 
> Really, we want to ignore sysfs only when we are forcing a collapse
> through MADV_COLLAPSE, otherwise we want to enforce.
> 
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>

Nit: if you forward patches untouched, make sure to add your SOB as well.

-- 
Cheers,

David / dhildenb


