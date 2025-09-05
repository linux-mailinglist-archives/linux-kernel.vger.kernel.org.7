Return-Path: <linux-kernel+bounces-803436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FDB45FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05551889D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE55313261;
	Fri,  5 Sep 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0UvgA62"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D931329A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092350; cv=none; b=UJqmII6ZOfSyRXdsUTDtxt84uAT77NVX6xemt2hxM1QFH+OB0gHcffdvMxB3V7L9IrTcpeTY6VLfZf99+RVp8ZHlleneI8wS/1DVPKdg+LuD2j3eh8GytBn5+BXlznjFoHZ1+So+OXS0286yyL2m1Yg0mkINl+2d+TzFtUgrmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092350; c=relaxed/simple;
	bh=PCDRmRg2thZ/H5URq25t6jZU/7i5ip6Pl2DzmRlmUgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUhrYlp+JZR3gmVUippeLVC6ZyDTW2lFBhKZH97TQDWofnz/6m+Q34J/JLMm/DOsIkmxFzi6aYYsUD6u1MVu6SXG78xCMVu7QgFanQ4XvXRjjdor5S0i60R40nOO7fJM7pdwYAAfIRHYqI0uFYfV+7wn0wT0Iva1vfNaM4Uz0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0UvgA62; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45cb60ac191so1436245e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092347; x=1757697147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRexvvNjPPJfK1uT0OSGvRNA7ydx0We94Cj4HRzyUo8=;
        b=C0UvgA628EwGTViKTrfDzOIWP7a46pPRfiagIWVkA24JmAUeBmevhFCJIImVyTqPaR
         aeO8zki1Ht9V5sojRczfK0ul/x4Ovww1mwonPhWyNKo6ehZxY+HTPD6UQWxBQytTq0r/
         Glm3sLoiBLynImAk8Jd8NJWX0IXUisv6IX3sUaiPs5TMLWLOD9b3Ic7bnPseWCqtoR+y
         ols3GLgI2A42Me9qudIHb6oAeqFuEpk/7znCIoJB7XHb6M6YxLYXxurhlAV0yOnfe0mn
         qlAsWURBNmwR/vMjXLSSa0Q7+PTcfmBlX03+2uEhiGFxPsQ9/ZT2njwqodTWc0rRGYmq
         wPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092347; x=1757697147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRexvvNjPPJfK1uT0OSGvRNA7ydx0We94Cj4HRzyUo8=;
        b=rOBde9zDFp32DhPS1Kp+6TVl7NlKsLu9biTJ4jJod+KPAjxtpgiSvR/F+i1Rp8mZlN
         axI3jU+hz5aO8xfn+76mFFUDkyB6w8wAzTRVa9VtYqDRBOaj0jsUyqEE6P0U1JXyWeXM
         /t03J3H79eCQbA649eOoDA6fZ5MqQ554Vil327wf6L2QHIuUj7L1ipfU31QYbg5L9Uaw
         RfTyNivYoCiDUJktoQ7jnYXuI5IICReAnlpUePxKiDkiWyFVO7Cgxk/as1l+4yan9kTE
         A0p81fRME4bHFriVQTq4qB4mprx2SHx8osc00TqAUMOXFC9qon3z2dDdVG2AdgVgGca+
         m/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHWXIGIoaSng/P7N9zFazXhCNlN/EGXaGQH9ZGZYiTtmj0uXV/oOa3qjG92pXRRCe2T9OGxFeBRRKGpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AZL0AFHSHDq8aAepenJFrky6Xy28U3Tv/tiDGSPZzdI7S+8T
	lsI2gI9qQyXf3Jk6+Sp5pjmSRs5PdoHK3+KWeW2AsookLaYXA6yB7YnF
X-Gm-Gg: ASbGncu4zYvSMUj498SCgszq5LibFoSU0k4vFrzJp2oNKEK3bbJGc5mLwWDggaGxIcx
	gWihzHDX6CU2dk+8WCLSegIk5Aa1ID6cUxQFKWVUKMqxRwW3vlbX87ITF86hDCZ73Y2voioBepP
	pEBC8lHbEoItZcVGsF9K9S2dh77MPLTIAdQVFUyJoFi9zpSDeHM8/YHyiGrpvjq0TJavTXQceQk
	CxzBQsQJnYU07MrvJ2QlBAAYpSIB23SWNTDx9Xxm/vgMPmFl66VwJTPrsKH6dcJAwIWZdo5nv3B
	6UrfLKimIPh8rlkHsACeIk6RgUjIuea/RmPV3wDVzyYdDFBaPsi3eGOd75iX1Ocrxf4AGJiNgIZ
	y/o8zdeXzhZATRFwbo3geGmwP+yrlM3f9uw5tKW2AlZsppVaqZmDy/KZQejB+9xIqH8jFmyZ2RX
	nEbmtteqRneDSn41I=
X-Google-Smtp-Source: AGHT+IGlC1bZMx0rOOObifxr+isGVzwQ1CKTbVGeV1N0+/Jd+6iR4EncAxNpQwTB91Ey6108bNX3uA==
X-Received: by 2002:a05:600c:8b10:b0:45d:d0a9:18b3 with SMTP id 5b1f17b1804b1-45dd0a91aecmr33464465e9.4.1757092346974;
        Fri, 05 Sep 2025 10:12:26 -0700 (PDT)
Received: from [10.213.233.28] (109-92-217-44.dynamic.isp.telekom.rs. [109.92.217.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab14esm369577925e9.21.2025.09.05.10.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:12:26 -0700 (PDT)
Message-ID: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
Date: Fri, 5 Sep 2025 19:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
To: Andrey Konovalov <andreyknvl@gmail.com>, Baoquan He <bhe@redhat.com>,
 snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com,
 linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com,
 christophe.leroy@csgroup.eu
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 4:58 PM, Andrey Konovalov wrote:
> On Thu, Sep 4, 2025 at 10:11 AM Baoquan He <bhe@redhat.com> wrote:
>>
>>> If so, would it help if we make the kasan.vmalloc command-line
>>> parameter work with the non-HW_TAGS modes (and make it do the same
>>> thing as disabling CONFIG_KASAN_VMALLOC)?
>>>
>>> What I don't like about introducing kasan=off for non-HW_TAGS modes is
>>> that this parameter does not actually disable KASAN. It just
>>> suppresses KASAN code for mapping proper shadow memory. But the
>>> compiler-added instrumentation is still executing (and I suspect this
>>> might break the inline instrumentation mode).
>>
>> I may not follow your saying it doesn't disable KASAN. In this patchset,
>> not only do I disable the code for mapping shadow memory, but also I
>> skip any KASAN checking. Please see change of check_region_inline() in
>> mm/kasan/generic.c and kasan_check_range() in mm/kasan/sw_tags.c. It
>> will skip any KASAN checking when accessing memory.
>>
>> Yeah, the compiler added instrumentation will be called, but the if
>> (!kasan_enabled()) checking will decide if going further into KASAN code
>> or just return directly.
> 
> This all is true for the outline instrumentation mode.
> 
> However, with the inline instrumentation, check_region_inline() is not
> called (in many cases, at least) and instead the compiler embeds the
> instructions to calculate the shadow memory address and check its
> value directly (this is why we have CONFIG_KASAN_SHADOW_OFFSET, whose
> value has to be known at compile time).
> 
>> I tried inline mode on x86_64 and arm64, it
>> works well when one reviewer said inline mode could cost much more
>> memory, I don't see any breakage w or w/o kasan=off when this patchset
>> applied..
> 
> This is interesting. I guess what happens is that we still have the
> early shadow memory mapped so the shadow memory accesses inserted by
> the inline instrumentation do not crash.
> 
> But have you tried running kasan=off + CONFIG_KASAN_STACK=y +
> CONFIG_VMAP_STACK=y (+ CONFIG_KASAN_VMALLOC=y)? I would expect this
> should causes crashes, as the early shadow is mapped as read-only and
> the inline stack instrumentation will try writing into it (or do the
> writes into the early shadow somehow get ignored?..).
> 

It's not read-only, otherwise we would crash very early before full shadow
setup and won't be able to boot at all. So writes still happen, and shadow
checked, but reports are disabled.

So the patchset should work, but it's a little bit odd feature. With kasan=off we still
pay x2-x3 performance penalty of compiler instrumentation and get nothing in return.
So the usecase for this is if you don't want to compile and manage additional kernel binary
(with CONFIG_KASAN=n) and don't care about performance at all.

