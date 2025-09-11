Return-Path: <linux-kernel+bounces-812497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F26B538E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7EBA0659C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019235208C;
	Thu, 11 Sep 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlnFVaXq"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4D2D46C9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607524; cv=none; b=lqW9IaEPNCKxsG7lecz60QXcxs9q/cBssN0mgv1kRO6O7UdBirlrC/gNBBLKtK7Ikb242hqrqLVHyLiXJoDDUrgxEHgdGsk+bbpB75PJZrfkCphA7JP7TFAysijnQQ69emsFSGoxiK1iIvNLYRXOa7pQ4ak5Vp5YQOzZduOcsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607524; c=relaxed/simple;
	bh=Y4q5zPydefEq2N+1GXbrXqt+waOzusbSVZD0bdVsMlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQQ+AH83p8ywZz1BDHLYNid04WVBY9lpLIkTB348qvj+Z8Arb4QBffv2jk/mA+5gCAwdeNKuPesCyNuUg+XUkykEV2B+TSsgdJ9KxQH40jP8f1/xbOLhk8G7aU7F7Qedqw9T20bU669OoWmXQwBd/402LJMkV8cUnNSu4S+GXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlnFVaXq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b4bcb9638aso672531cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757607522; x=1758212322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HW7/AsImkzQuXxyaG6On6aHykiQ1FfjR2dV0EigRA=;
        b=UlnFVaXqLqHbumVcZOK9dx/xQvA0ZyQdOSximpSNh8VUebeATyjMfVsQ5svcFNwSWI
         MFPGTpUHT3vwc1zLQQPtccLM7Tr/I0BrGPFhpG0HJUECzpVpn+XWAKuSEp5kDOdpkGnt
         szo3Z3pyhyZBeiCdlY25Umfu//x2MV3f3GEnWF+Z5jiRz/XRzOw1Fo+59P8NAAYpPjMr
         qD76L4NmUOpUnOXAEHz5z9xIKe60thK7BvpydNYYCrmZlTAh1JOdkk8EgD8bNoxq/eEH
         1eKWVyfJa+Q26UAr0MwkmLVh3hd2X5GyecKONsTzTVjHTinltaMaQQQD3cNirFEaw6Kf
         9djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607522; x=1758212322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24HW7/AsImkzQuXxyaG6On6aHykiQ1FfjR2dV0EigRA=;
        b=iU6a4Bt1dfn51T3uSzs3oj3w77Iu0YxfIe9EoHRMmWlpta2df9zSx9MLGrRD5lUQ7L
         k49kpw9gvJynmj2LzboakX505PdQqR2FiuFTR5rC/5YeSrugGXH+DAsHA89gF9zYYRRy
         HEbZQiYqBzbjT6TdgpbEJ0kiglkjfhVVYvTjFE0qmz8ECoVApRvsxJ7ZTV9xmikj9ZN1
         N61EWsTZB/vmRP9MK7Iof+9nShgYdsxd6ZGTtfjD7/anl504zTgrTdvzYOxxfmGxPPCx
         LxS07jXcBx/GgxHavm01bUKStC8bSMBJo3e1yPdgA7MM1XRkI9hO3wk0E+seN5EhQGIL
         qU9A==
X-Forwarded-Encrypted: i=1; AJvYcCUdBoPZxgUhg9j6lGyaX4gqg0YDIPqwtqnvIxIka1bdfdr/NFVtrw7dZ0IT2f8W5mj8AomhZLniAeED9Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKLSU4o35qPJKgJleqMwxvfsEBGmcOr5vpn1954JKn36itUVp
	9k5c2Sd7TYPIfmKd+CDpxPyEyApJYhCaULSPZb4ppMUul/lt7WPhH/YNKb17mcYRsvUQ51m4VOW
	LqqFxQW8IQ7LEzVFuOhLdzMoWj6jl+sx8rvigchxo
X-Gm-Gg: ASbGncuGt9aHNdyBZEWxTslypAHPbf9j5osICcSqrVwRDRGQMGaTfQzyNZBsVr7QFSv
	+723USZamr2NsIIW3SAyBdeueqcdYGgEItJzMKnBQHgdEdGYwmho/TWzX428IyZH2VNyMPDsJ9Q
	KXFu5XyAaeOh6xqY0MrXVsydSQ4e9bPDAD+amb5+fkDit7CqIVBsLB2e8tLH5Go+Wp4tVRqfb/6
	cSWcvriec2uXRxjng8jlskuHU6454PoYRytFN0vF4z85pDWTodDxmI=
X-Google-Smtp-Source: AGHT+IFepjQyaeSo7RONPmZKnbu3ouTnjNwcjqHMB6uwq7dFF7AS+N9S9oBOBUO0kd+RV9Ps1ce594/bcKUPIM1z+ZA=
X-Received: by 2002:a05:622a:311:b0:4b0:85b7:ea77 with SMTP id
 d75a77b69052e-4b626dac8a6mr12181721cf.3.1757607521282; Thu, 11 Sep 2025
 09:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com> <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
In-Reply-To: <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 09:18:29 -0700
X-Gm-Features: AS18NWBuPzWz3lwq_X1O1VoJwliWLiyJCfV3kEGiBFilILnw1cC21z-lWQT3adQ
Message-ID: <CAJuCfpGezf06eR7WnzizpwTaxZ5Rm8jbeW4y87zcr6LZuJ9MZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, David Wang <00107082@163.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:00=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/09/2025 16:47, Yueyang Pan wrote:
> > On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> >>
> >> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> wrote=
:
> >>> While rare, memory allocation profiling can contain inaccurate counte=
rs
> >>> if slab object extension vector allocation fails. That allocation mig=
ht
> >>> succeed later but prior to that, slab allocations that would have use=
d
> >>> that object extension vector will not be accounted for. To indicate
> >>> incorrect counters, mark them with an asterisk in the /proc/allocinfo
> >>> output.
> >>> Bump up /proc/allocinfo version to reflect change in the file format.
> >>>
> >>> Example output with invalid counters:
> >>> allocinfo - version: 2.0
> >>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup=
_data_nodes
> >>>           0        0 arch/x86/kernel/alternative.c:2090 func:alternat=
ives_smp_module_add
> >>>          0*       0* arch/x86/kernel/alternative.c:127 func:__its_all=
oc
> >>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs=
_set
> >>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_r=
ealloc
> >>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_e=
nable_hybrid_capacity_scale
> >>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func=
:init_amd_l3_attrs
> >>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_dev=
ice_create
> >>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_g=
en_pool_create
> >>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thre=
shold_create_device
> >>>
> >>
> >> Hi,
> >> The changes may  break some client tools, mine included....
> >> I don't mind adjusting my tools, but still
> >> Is it acceptable  to change
> >>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_dev=
ice_create
> >> to
> >>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_dev=
ice_create*
> >>
> >> The '+' sign make it still standout when view from a terminal, and cli=
ent tools, not all of them though, might not need any changes.
> >> And when client want to filter out inaccurate data items, it could be =
done by checking the tailing '*" of func name.
> >
> > I agree with David on this point. We already have monitoring tool built=
 on top
> > of this output across meta fleet. Ideally we would like to keep the for=
mat of
> > of size and calls the same, even for future version, because adding a *=
 will
> > change the format from int to str, which leads to change over the regex=
 parser
> > many places.
> >
> > I think simply adding * to the end of function name or filename is suff=
icient
> > as they are already str.
> >
>
> Instead of:
>
> 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_creat=
e
>
> Could we do something like:
>
> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(=
inaccurate)

If there is a postprocessing then this would break sometimes later
when the function name is parsed, right? So IMO that just postpones
the breakage.

>
> This should hopefully not require any changes to the tools that are consu=
ming this file.
> I think it might be better to use "(inaccurate)" (without any space after=
 function name) or
> some other text instead of "+" or "*" to prevent breaking such tools. I d=
ont think we need
> to even increment allocinfo version number as well then?

I'm wondering if we add a new column at the end like this:

49152      48 arch/x86/kernel/cpu/mce/core.c:2709
func:mce_device_create [inaccurate]

would that break the parsing tools?
Well-designed parsers usually throw away additional fields which they
don't know how to parse. WDYT?

>
> >>
> >> (There would be some corner cases, for example, the '+' sign may not n=
eeded when the value reach a negative value if some underflow bug happened)
> >>
> >>
> >> Thanks
> >> David.
> >>
> >>
> >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>
> >
> > Thanks
> > Pan
>

