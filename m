Return-Path: <linux-kernel+bounces-812437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7EFB53820
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3941CC1D76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A12345729;
	Thu, 11 Sep 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkT6qUXG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBD28E3F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605652; cv=none; b=GTHUN+7vB8ndJkoVVfsn2OyI4krCBurGu3Vy7osLiZV7BxbFwwx9PJC3eOU4bj/lhjDWhq1RlL0WBRAdyugoJkYpxvYRAmn4fG4TjnWa4zZOMBalT0Akg79oT8AH2aujj11KhOTl0adZyg1ddUNnFOZUmpqyTcsNypmrlfG4tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605652; c=relaxed/simple;
	bh=CugXlghZYBFLvgEK/vYdr8mfPvn0Xn1Vb78W8OcEnkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1AmdC1onw09w6dhyvBPjpdmLztFnuiFtvSlSFRewLniDk5vD2nl70NiC/jNJ8ipRniaEW63E23r+vDDix+srbaZnfNfn8TREqQsa4ZnaeRkp02DjiBpk/xjYnYSU3afYzE3FGayYsEY5rOnM2THUYlslEFvEOXeGg6PmkC/gaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkT6qUXG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ed646b656so3027485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757605648; x=1758210448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFx9oDnda6VBYzco4HQeSyIICMaeMRy33Q5Glx2a6V4=;
        b=gkT6qUXG9KaGRWIiMiWAcRgXsK2Z+EGg5vF9MEntCf0AIKLZclomz0egyL2pw0lp7N
         R2sGFSHwmHXfwXRQpU2YYNgZIKV3hzKimamhzBxpO3Zs+s1ZegYC85Edv2Du1+53Qumn
         AORNlnd/Svf8f6/Ly1SvKP2yIu770UXFb/remfRnBYKMya+r7AQDgYPiGn3xgjUGHcB/
         s5oPFumZfgk/RE8wdEIb6zgtSg1e8qi+YTpv16oq+SMhdZCeleOS6vFU+2yzOfNr494e
         x5+gdhXvNDqFbvtJ5rPGAZ0UpnftNrlN6rwhgDNtJWjaZm3Qkq09s9Bvd3QjyfFm/iut
         j+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605648; x=1758210448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFx9oDnda6VBYzco4HQeSyIICMaeMRy33Q5Glx2a6V4=;
        b=MeikMlNSKas3QgdkJrixc6MfaGzsX19vILEmPFX7Ngh9jyhMW9SBoLJZRxMcgFsTqe
         e7rO7/Bt/+2LX5/ZBMcd2mATS5wlY5xSEVwXZf5uqPzdpqjSKOJah0YAMHZpbv1WoIca
         SXxGIUyBn08crrJ8lYjPqV58swXsribyZs77SAtnHGXJllpRflqKsJRoh3X7Tvtk71CX
         ue08DqjinoVohRoDfSbnMZDTlpAZEL/1HFTHORsyqeEAAld8KDu9Zj3XvV2nRnszwXP/
         r1pitfB4w7gE6VM6JIKX0kiBYzobnMzWcM1zIHZPAfylpVKpY3xnuRivXMB7bEAYXOkc
         L7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCS7S/A7jn0706bnwKDfCJELFnUw2im9QzgRhautX/VR9VGn3NEwwl0Rgt5XUxqO3+wgFmiGSGPMox1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPhfMjk5yIwkM5zchQ/Qt3F/eBK2IRrjKh6nK3DkAnt0YAJj9
	EO/6MvU98gNQuTAvkb5VaKfXphkI0sHx82vqRYrZMuw8U0RZcrno+NsH
X-Gm-Gg: ASbGncuWRjFbqd5Picwfb2jyZncJZVfm8BVqSBLSMoth6UQvhHdEHoEToCLuooNpiIz
	9orfLZFr2ubXqkzxFRekfvT+H990oN8g2WJS9JQU0nh39acTrYvXijP92Tbf1EGwTiYU5HGVMK2
	Ov5gpa/uYRvk2vUQL0NiUFCMIRWRxK7pl7L47JuYUEtriP3J5O96Z4wPzrFe4191s4BjXF5q5yY
	8OTTJQ2fIL0ASm7ZXvP80Wz727B4bvxIxcsyS76dGe1l152AOsaXbWErsmHTc+fv/DV3lUayT6M
	T/D4NI8RuaJ9uT+68xVgWCA+8ACz17Md82HnGfMmye2PoA/mCBWyZk/6R/TKEtOO/NNue6yc/bZ
	TEXjjW0gYMbBZsxMuqLdiWetdecPXHszmCZWhfjGw0V/bPSV3
X-Google-Smtp-Source: AGHT+IFwYbz7NjDqxXwpnaGQMVwcC9yGmE42myK59UTXFjX0Z6krF3VrWIOyB5o/f16GdxD74dmXBw==
X-Received: by 2002:a05:600c:5493:b0:45d:98be:ee9e with SMTP id 5b1f17b1804b1-45ddde6a3f0mr164977525e9.1.1757605647599;
        Thu, 11 Sep 2025 08:47:27 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0152ffc1sm16239635e9.3.2025.09.11.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:47:26 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:47:20 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: David Wang <00107082@163.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
	usamaarif642@gmail.com, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>

On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> 
> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> wrote:
> >While rare, memory allocation profiling can contain inaccurate counters
> >if slab object extension vector allocation fails. That allocation might
> >succeed later but prior to that, slab allocations that would have used
> >that object extension vector will not be accounted for. To indicate
> >incorrect counters, mark them with an asterisk in the /proc/allocinfo
> >output.
> >Bump up /proc/allocinfo version to reflect change in the file format.
> >
> >Example output with invalid counters:
> >allocinfo - version: 2.0
> >           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
> >           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
> >          0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
> >           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
> >           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
> >           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
> >           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
> >      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> >       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
> >           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> >
> 
> Hi, 
> The changes may  break some client tools, mine included.... 
> I don't mind adjusting my tools, but still
> Is it acceptable  to change 
>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> to
>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create*
> 
> The '+' sign make it still standout when view from a terminal, and client tools, not all of them though, might not need any changes. 
> And when client want to filter out inaccurate data items, it could be done by checking the tailing '*" of func name.

I agree with David on this point. We already have monitoring tool built on top 
of this output across meta fleet. Ideally we would like to keep the format of 
of size and calls the same, even for future version, because adding a * will 
change the format from int to str, which leads to change over the regex parser 
many places.

I think simply adding * to the end of function name or filename is sufficient 
as they are already str.

> 
> (There would be some corner cases, for example, the '+' sign may not needed when the value reach a negative value if some underflow bug happened)
> 
> 
> Thanks
> David.
> 
> 
> >Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >---
> 

Thanks
Pan

