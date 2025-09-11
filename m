Return-Path: <linux-kernel+bounces-812611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E2B53A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90203A6BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725135FC25;
	Thu, 11 Sep 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAc95k3O"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B6326D54
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611512; cv=none; b=KoTJOSNjdvzfhiy89SoezoE7fDEfwvyg6pNrcXVKsvgSTsMkJRz+xxEIVpZ1g/nLGOgN79tIk2ahLAYfBRoniQTTED9b8BjKAsQ+ZipqlEKgJ/DVMKWEBMJU/Uz8jFkzlj65j97LEPO91czzlfvqnB0269/JDQWd9ghlgMHmtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611512; c=relaxed/simple;
	bh=wg7hslR1FR2QUgzA+5Q/NuwdCqUhPpK5744j2u/08mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjR8v/M1+/F7CfXf4cptRMfTduXygRG38tMSogk6aEGHn5m97KvTY8k39C6YLz641hWN3jIEz0cEhspkAqgm+8ix5UgQmDxa9bc0yiXI/4XR3VZH+lNLF1CzjUCFgrk+n4/mS5N5Kr+n1i3jEzHH96zgsL/btuyk/a0tny9wEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAc95k3O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so7366445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757611509; x=1758216309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66hww0i42bGnBY1WyrFAxgF0MA47MP7lxex8W0+v584=;
        b=hAc95k3Obwg1hMjDC2b1dtRgunbRcuQvBBj6hJr0GBsTXD8wlsIaqjspPhB5Sa2v5s
         mUNoCraS2TIAEBvrCzs+3GP2Cy3fajJNobWcUQotxtwhGVlXJVxDgtp+tuSkGodm36fS
         0hSVCww2VC/scQ+QpRWAxQIWjIfShCEDOoHnPBW5xIWefZjJwDdIJrdW6dSJdLsBMjww
         IEiHexM7LzZZcxefp96VvkrOIHOLqVZy7Jm2XJks6/uasuHldKS/+zuN8ypMaiP9AP8i
         ScmczsWsqhVTpJJkEHGezqqaY7GyG/CaeEBWwoz+pWjLGw0BeHOhsFMgV7TQtqxICTbt
         CLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611509; x=1758216309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66hww0i42bGnBY1WyrFAxgF0MA47MP7lxex8W0+v584=;
        b=kyU2PgryBAJyqbOAUyjqdiivy5iQjvNhhgJ3hog6FL1quD7TK1Y/4NmMso+wPjVbzu
         jg6RLRtZxDdgU+wOGEFtlNOEH/kB4YMjminPLh1jq7MHtcSs55b2dBdgKbC4sQEldKuP
         ptQJBSoa6a8tP2CK+m1JqeQDz3jfyBSXjT3XH5AORs7HydfZQDf5H0RbWjiqorrGysTY
         xftvQ232dU9iCCXy/P398g4ISwWTMmU8Jd77tT/JimuCEXkDaEKOWjqsBXmWQgXtIa/9
         P6eOlpY13f9EhVLaF/fz3awzoW/x6f0k0zPxJni8rqPYYY2/Xh+Umqgkr05d8AIWGb6Y
         Hapg==
X-Forwarded-Encrypted: i=1; AJvYcCVCqwesaK5zuzfRjXjTtwR5ygrUOuza53C95/IsqA8Cxi6ChVUpjT9gmzUc+7kzf2FOYt+ATDqSNlWmrY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFeGlrmgEP6xuVU6ps81s6pDDOa70qe4+DZ5+AKDR9ushoux0
	iNDxbhXGsfXD2YegeRUhjkL89ps3vNPgpFSmQJLVz65FCGthGEmbynVB
X-Gm-Gg: ASbGncuUhXXggzEpVaUOmJ/XRwfq4n3cPfyVvo/+AE901vow9QSB8l75IGbNi4vg19R
	OWN4TVfPrs7kGWZV+VQIYV8yvSxNkV56Z8dZVt95Ob4wgxNjW+o+S00lEzhAWjbFSMmhzCXyLjD
	lm73mqiu4HxhtKDjEaRMWOs5flhKSgsP3BNjYLMwbR0fZVQqAKLEUcHkReKIq2YhJOWFbuWxn9C
	yVFOGq9d6N2K0DSI4LoCTOLMiwwXu5ruucwAeRgsH/9rxDBK83WaVJViJUCRNcXIoAY0KwI1gbB
	p2LnJ75xNm4sRC/ilP4keI2IroWDJF/JUc6cgYS76pIdcP7DcktQjy0kgM2rBlX7ev3LD0oAhbM
	0hpBCszUxYUg4fUzhqMHjh4s1VAA04HqmCpywSV7jvGvGfomcXQ==
X-Google-Smtp-Source: AGHT+IEaEQOTywFYBJnwC3JrY90Mp6xQbmA2EeG+g3Ac9ehgcskjHnu2dwm7OKqmhaMFqIZZy0my7g==
X-Received: by 2002:a05:600c:19d1:b0:45d:98be:ee8f with SMTP id 5b1f17b1804b1-45f212609f5mr1816215e9.26.1757611508226;
        Thu, 11 Sep 2025 10:25:08 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0187f0a7sm18431515e9.3.2025.09.11.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:25:07 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:25:05 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, David Wang <00107082@163.com>,
	akpm@linux-foundation.org, kent.overstreet@linux.dev,
	vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <aMMF8elYvlPoOF+J@devbig569.cln6.facebook.com>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
 <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <CAJuCfpGezf06eR7WnzizpwTaxZ5Rm8jbeW4y87zcr6LZuJ9MZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGezf06eR7WnzizpwTaxZ5Rm8jbeW4y87zcr6LZuJ9MZA@mail.gmail.com>

On Thu, Sep 11, 2025 at 09:18:29AM -0700, Suren Baghdasaryan wrote:
> On Thu, Sep 11, 2025 at 9:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 11/09/2025 16:47, Yueyang Pan wrote:
> > > On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> > >>
> > >> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> wrote:
> > >>> While rare, memory allocation profiling can contain inaccurate counters
> > >>> if slab object extension vector allocation fails. That allocation might
> > >>> succeed later but prior to that, slab allocations that would have used
> > >>> that object extension vector will not be accounted for. To indicate
> > >>> incorrect counters, mark them with an asterisk in the /proc/allocinfo
> > >>> output.
> > >>> Bump up /proc/allocinfo version to reflect change in the file format.
> > >>>
> > >>> Example output with invalid counters:
> > >>> allocinfo - version: 2.0
> > >>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
> > >>>           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
> > >>>          0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
> > >>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
> > >>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
> > >>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
> > >>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
> > >>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
> > >>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> > >>>
> > >>
> > >> Hi,
> > >> The changes may  break some client tools, mine included....
> > >> I don't mind adjusting my tools, but still
> > >> Is it acceptable  to change
> > >>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >> to
> > >>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create*
> > >>
> > >> The '+' sign make it still standout when view from a terminal, and client tools, not all of them though, might not need any changes.
> > >> And when client want to filter out inaccurate data items, it could be done by checking the tailing '*" of func name.
> > >
> > > I agree with David on this point. We already have monitoring tool built on top
> > > of this output across meta fleet. Ideally we would like to keep the format of
> > > of size and calls the same, even for future version, because adding a * will
> > > change the format from int to str, which leads to change over the regex parser
> > > many places.
> > >
> > > I think simply adding * to the end of function name or filename is sufficient
> > > as they are already str.
> > >
> >
> > Instead of:
> >
> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> >
> > Could we do something like:
> >
> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)
> 
> If there is a postprocessing then this would break sometimes later
> when the function name is parsed, right? So IMO that just postpones
> the breakage.
> 
> >
> > This should hopefully not require any changes to the tools that are consuming this file.
> > I think it might be better to use "(inaccurate)" (without any space after function name) or
> > some other text instead of "+" or "*" to prevent breaking such tools. I dont think we need
> > to even increment allocinfo version number as well then?
> 
> I'm wondering if we add a new column at the end like this:
> 
> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> func:mce_device_create [inaccurate]
> 
> would that break the parsing tools?
> Well-designed parsers usually throw away additional fields which they
> don't know how to parse. WDYT?
> 

It would break the parse now as we count the number of string to decide if 
there is an optional module name or not. I don't think it is a big 
deal to fix though.

I think one more important thing is probably to reach a consensus on 
what format can be changed in the future, for example say, we can 
keep adding columns but not change the format the type of one column.
With such consensus in mind, it will be easier to design the parser. 
And I guess many companies will build parser upon this info for fleet-
wise collection.

> >
> > >>
> > >> (There would be some corner cases, for example, the '+' sign may not needed when the value reach a negative value if some underflow bug happened)
> > >>
> > >>
> > >> Thanks
> > >> David.
> > >>
> > >>
> > >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>> ---
> > >>
> > >
> > > Thanks
> > > Pan
> >

Thanks
Pan

