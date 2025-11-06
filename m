Return-Path: <linux-kernel+bounces-889398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22060C3D743
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5630F4E2B89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC64304BC1;
	Thu,  6 Nov 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxrWx6UZ"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB864304BA8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463299; cv=none; b=JeVsHWnG8+GYTE0J9w5rHiTjwtm33SEfEYhLVKK3m02qf+A5T2uaqxGPQscd0tqoiFBev3muXX1zqx/RD7HpL3rogUIfNzzYB7SM6h+tN5wNKXlb1kKg/vwqJEHpzD4OGnTiqLTqaXgNX2H6qpL7saC3dpSk4U43c1FCKrSOxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463299; c=relaxed/simple;
	bh=xkGEVA7tDKhEqGoNowkcJNlMxtjGqjAFlqV1MMTXzoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f615F0UN19epxvWf261izoKnuziF3ZHVwIBb+F/XWY/V55av6URUJc2qVYn7bNGYObVKxlYBwfOZz+e5UR6HHNq+vSc+QILKLSa9ImHcrQSU1ECLEseL8zCkKsZJl4Ro3dNoHgTjqFFcKT5/m2GbeG1AbQy7i9Vf5fpPFnVzlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxrWx6UZ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4710683a644so484935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762463296; x=1763068096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5xVpAr9ZbKaVO0bAtNOEOCLIRQmDJLc8ZfpgxCZQug=;
        b=UxrWx6UZxycBAkbF9zhBdzFwdhR6ipMT3b2PpXXuHtaKe1J8+b1u8BROuuvr+If+hP
         GDjzrlI/LFk7+37kwVAvoiERH1/9augH/+fmTvCgRKXhpkLHqsvo2Z3R6AqkEm5lQSYr
         2DA8LhSn56i6UTG7Rk9YWoYPFEG4rYhzmCXwJSk7VvqcsygVszp4IAIpE2+q6g9+tYyn
         v/jJxKFX76HenfycvCUZyLgafRQFBgiXgWqDzGE9y8MaBaU5SInOS3544flvVoDp/XhQ
         zOAjcmjQIS9pbRzs2i7Kl6MjFTo2PCYsPl/lQg3z2cJN27kE+DI4icGKSSy7J1pMZsPi
         rTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762463296; x=1763068096;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5xVpAr9ZbKaVO0bAtNOEOCLIRQmDJLc8ZfpgxCZQug=;
        b=Kvs9qFHJyLNGZM9vwrPQjHzP6lB97xOCxER7xOjR5GtPwtYLDUM6e608e8XBQObJam
         h979q8aBk22upXzFpfPKltdtcTY1Oy1lA5YRTKCQHc9cBNGXf48JqSfjxYGn4kZ6TEZu
         GC7sh/hmUt5qBFzB1k45tHoz2Eual6EIgcqVrKvXh3Fe0xkzJo+ImAjeLf5JpE6ZdYAf
         up4HVHUVGM8d8vvK/4hBJl1cIzH34sftbzw44DIPlrgiiQgVzaS/Q8kITWe0d4tzO1wO
         qJyy3/rm3rJ8yiwIc/NjBvcadYedUmwVmjKXIQ8FuuiVUM2YX1kwZE3c8IDchXJslHCa
         Ce/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWb9iHcUeXXwHpiguEjeoQEn8tt5stHcOkopAuEhx/7sXRTuhXNpzn4TcB0+c8EAhQGY5ky4FBSrqyvVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHOAUaULMNfqQYGRg4/lBZKEEwaC+9CKu63DKdQd07cj6jguG
	G6Ydn10K44Nxb1qp47NnhgH5vERfenULQgfjHT5o8R72W4k4i7+q75e3
X-Gm-Gg: ASbGncvO0/mx5ktOqsMHnQnyYITzmDc7pgm4e65UvVNZuRu5d3IiNhE4jvM0B66Z/nK
	KZFSlSw79DEfZUijvi4tYLEfOITQNXXKuLXb5xgXBtOVDkr8MZarv16SeoWGOouCxQYW00ATVDd
	bT3h3PuMCrdBVGuM73Dfpzat9lFvV8ggTsH7KBiUJZn2Rbgi+d0YOoGmzNarGRx7RiKsW56vd1n
	gKLG1JJkoRZHq9OchEgJIOgTlZ0rNziO0RrHJEKJ81jXPmZafKUzMamBXQhBkEuKE3puR13n8FC
	aQlfa+vQIISYgGigEmP4cHY7bSio/GDhHpkRL34x/YrxH45OKBUIME1rp5zYcn7SQkap2wR1Uqt
	i5Tav3e3glnFgD/r5h7DpMvsWwxMofJ71NWEvF6O46Ecvbp8uLO/XcHqiar9Tcz07VtMxEvA7M8
	YkA9lEMRvEp/VE00MVj6Kzmw5bs9EUKBwkjT7bgjY=
X-Google-Smtp-Source: AGHT+IHlju2rSLGApcUhNyvklc08dTRWO1IjCiDhqZ7qoZQsGLq1uvql05prWWXeOTbmMu/aHY+nIw==
X-Received: by 2002:a05:600c:4ec6:b0:471:665:e688 with SMTP id 5b1f17b1804b1-4776baa5b9emr9690255e9.17.1762463295905;
        Thu, 06 Nov 2025 13:08:15 -0800 (PST)
Received: from [192.168.3.141] (p4ff1feb5.dip0.t-ipconnect.de. [79.241.254.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm1300220f8f.41.2025.11.06.13.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:08:15 -0800 (PST)
Message-ID: <de2f65f0-8b5d-4d64-a918-4f0c91ee3e59@gmail.com>
Date: Thu, 6 Nov 2025 22:08:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Don't sleep in
 split_kernel_leaf_mapping() when in atomic context
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, yang@os.amperecomputing.com, ardb@kernel.org,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
 <20251106160945.3182799-2-ryan.roberts@arm.com>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20251106160945.3182799-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 17:09, Ryan Roberts wrote:
> It has been reported that split_kernel_leaf_mapping() is trying to sleep
> in non-sleepable context. It does this when acquiring the
> pgtable_split_lock mutex, when either CONFIG_DEBUG_PAGEALLOC or
> CONFIG_KFENCE are enabled, which change linear map permissions within
> softirq context during memory allocation and/or freeing. All other paths
> into this function are called from sleepable context and so are safe.
> 
> But it turns out that the memory for which these 2 features may attempt
> to modify the permissions is always mapped by pte, so there is no need
> to attempt to split the mapping. So let's exit early in these cases and
> avoid attempting to take the mutex.
> 
> There is one wrinkle to this approach; late-initialized kfence allocates
> it's pool from the buddy which may be block mapped. So we must hook that
> allocation and convert it to pte-mappings up front. Previously this was
> done as a side-effect of kfence protecting all the individual pages in
> its pool at init-time, but this no longer works due to the added early
> exit path in split_kernel_leaf_mapping().
> 
> So instead, do this via the existing arch_kfence_init_pool() arch hook,
> and reuse the existing linear_map_split_to_ptes() infrastructure.
> 
> Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Tested-by: Guenter Roeck <groeck@google.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>

