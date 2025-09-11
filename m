Return-Path: <linux-kernel+bounces-812726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF89B53BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E676EA05993
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CE29405;
	Thu, 11 Sep 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmXWsAUy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959F2DC777
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616709; cv=none; b=GrFn0TX3/6pR+GXWmgrd6zR0MYScedPYVIpjaug/kyB4U2VQUeqgnMZczD3aTVv135Mb9S+HJOKGq3Vp2yoWSvC1d0qp4Jjq2PQkuhS0GzoBD2B2kHBlNQ3JnhWOh+XS+as+JwiX+6sOGj94kggtLToCneiXaMUdsauXSKLsU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616709; c=relaxed/simple;
	bh=G7xEIoY6QGYL7caVlyY/aYcfd7nGhd8uZ6dJo4GCTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug/dyy+oZQ0Rbx+Twmt9IYrplHsgelIoVdbF8nvXYjbM4Le0qvqaR9IHb0zSA4/MeqzAh+bORW00k0QwcCXwNUSgq5O5X0CVLcwh/x48jrnIIxBLC1uZdqlpKwzsNhygjn27U/8QPUtgR64OrPBSWTANj6rlSfX4szCxoyVZhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmXWsAUy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so7916915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616706; x=1758221506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSXSLjz9xxQBXrBSw3AK6oe7rPYSJGQAvD1J01P1Xw0=;
        b=OmXWsAUyy8pmmTVRLCgnzw44Z1hpUaghVx4WJ5MGt7IXJBEVf9JwcpAxRjnjp4jh5p
         G7oNEBHPVW9yWTCnRv55BpMS9V4msDkC0QJ8ozenkQXGVdS1haXkNc/m8WShEoBClogp
         tIA957G6z3+jsMxGjrrntWbvB7NEuXpGjz1wKlQkcL25JNFKLi5SBN9h0mXohIVwc4Yf
         2IybbNXO0RMFFhQA1Wx6x8GEwAaIBFNB+I/72gFvcez0a01yQQLE8MOdavWF6VbENyG4
         WS5IqWZwlnqfh5Fyg6wD8EUms7mSl1a7Qzw1Oo/rutfT6IzvlDKqsJWjAAtkupyNzjCc
         CSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616706; x=1758221506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSXSLjz9xxQBXrBSw3AK6oe7rPYSJGQAvD1J01P1Xw0=;
        b=KbK4FmId2MZ4DTofXlv/OK9spMDmSUYMhrKYRBX7W8iYXvHxaKiSm4X0jpiZh95Jvm
         CVL1rf0qjjI3Npclsf1meBxiTpywZo58olRs5uVbGoG0UIgyOcRWI5OWjGdn+gA9T9C0
         Ig89kXYWozLTCbWFw8Q669qx1JjzPqpVe6u5lwxd2pNEfgfVGmyC8RWdTnKn3K2K2od0
         JhduWTBfvH7gyOPfUcl6vLuDTK0QXWzGeOgevti6Ns5LuAeZ0f14ICumkF7Tl8tEUaRv
         N9q9jABC//B0Cm31YLmty7w8Y+MSKtyY6GDeLuQWF4TA81tZU96zwUx51ElnM/CYitP+
         wrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8wsG6UdoSlOsT0H7vUe6aXQWqLPU70ptN3SNAdPMO4NSspa9HskfW4s4tgGRjc1sTx93lOTZBIic8lXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBHEGU9bfY8CrsHwvpWSut0Da5UqT4qsWLxQUEl0D5tJXp0UW
	baHFLKhNnwbPYGoaPdp5WrANNzTFNo/0aaj++cjRYPwXmhrl0EqRGzPH
X-Gm-Gg: ASbGncvibHisbjVQgGbg/IO4HPYz7abhJSzMJBlLBzEDKsHAtMCwUl/M4qVdu3a/edH
	PWHsrihZcFLUn9BWyJF/LuPG90HiU+IQeCrxg5zKCyNQ8+HOwrPsw7r9JxZYuMSpzEglzrZkSUJ
	WQ13ucw6RKR+f9Da1bCBW6nzOa/UuboCBSgC/qChwbQYIc0SjYCoK8clQIUYnLtuDrIcsHWm1cw
	jxPj8kYauiO2rKz1p5olswqLvxcYJBbcd6fdAl5QBxFVhM5SmAogzBZ/0VGzeNGxLDkvi8ceC5M
	6dYA6FnS6iZB2manX+HpRpZRrb710hQAARfpBmZ5dwC4atsGCdmSqfj9Jh4/PbvyViEYRehhhOq
	EO2tBTGJKnPzemYVQvnJ7saOIDaYBGrjdLLTOmV4=
X-Google-Smtp-Source: AGHT+IG721ygNIQdIEEEEkJ+eIYPvjiP+uDfNNRip9ilX+h9GXA46usxqABET0AECdsMFBw5Cwgg8g==
X-Received: by 2002:a05:600c:314e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45f2121ab89mr5163355e9.24.1757616705792;
        Thu, 11 Sep 2025 11:51:45 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015bf73csm18359595e9.11.2025.09.11.11.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:51:45 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:51:43 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>, Usama Arif <usamaarif642@gmail.com>,
	akpm@linux-foundation.org, kent.overstreet@linux.dev,
	vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <aMMaP6XgGfX3nVVE@devbig569.cln6.facebook.com>
References: <20250909234942.1104356-1-surenb@google.com>
 <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
 <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <CAJuCfpGezf06eR7WnzizpwTaxZ5Rm8jbeW4y87zcr6LZuJ9MZA@mail.gmail.com>
 <aMMF8elYvlPoOF+J@devbig569.cln6.facebook.com>
 <613698f0.a994.19939d88e1c.Coremail.00107082@163.com>
 <CAJuCfpE=0jpana5qryqwPsuoj_8tCEMWFMcEBTB5-9Lyu_j-Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE=0jpana5qryqwPsuoj_8tCEMWFMcEBTB5-9Lyu_j-Tw@mail.gmail.com>

On Thu, Sep 11, 2025 at 11:13:58AM -0700, Suren Baghdasaryan wrote:
> On Thu, Sep 11, 2025 at 10:35 AM David Wang <00107082@163.com> wrote:
> >
> >
> > At 2025-09-12 01:25:05, "Yueyang Pan" <pyyjason@gmail.com> wrote:
> > >On Thu, Sep 11, 2025 at 09:18:29AM -0700, Suren Baghdasaryan wrote:
> > >> On Thu, Sep 11, 2025 at 9:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
> > >> >
> > >> >
> > >> >
> > >> > On 11/09/2025 16:47, Yueyang Pan wrote:
> > >> > > On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> > >> > >>
> > >> > >> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> wrote:
> > >> > >>> While rare, memory allocation profiling can contain inaccurate counters
> > >> > >>> if slab object extension vector allocation fails. That allocation might
> > >> > >>> succeed later but prior to that, slab allocations that would have used
> > >> > >>> that object extension vector will not be accounted for. To indicate
> > >> > >>> incorrect counters, mark them with an asterisk in the /proc/allocinfo
> > >> > >>> output.
> > >> > >>> Bump up /proc/allocinfo version to reflect change in the file format.
> > >> > >>>
> > >> > >>> Example output with invalid counters:
> > >> > >>> allocinfo - version: 2.0
> > >> > >>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
> > >> > >>>           0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
> > >> > >>>          0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
> > >> > >>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
> > >> > >>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
> > >> > >>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
> > >> > >>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
> > >> > >>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >> > >>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
> > >> > >>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> > >> > >>>
> > >> > >>
> > >> > >> Hi,
> > >> > >> The changes may  break some client tools, mine included....
> > >> > >> I don't mind adjusting my tools, but still
> > >> > >> Is it acceptable  to change
> > >> > >>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >> > >> to
> > >> > >>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create*
> > >> > >>
> > >> > >> The '+' sign make it still standout when view from a terminal, and client tools, not all of them though, might not need any changes.
> > >> > >> And when client want to filter out inaccurate data items, it could be done by checking the tailing '*" of func name.
> > >> > >
> > >> > > I agree with David on this point. We already have monitoring tool built on top
> > >> > > of this output across meta fleet. Ideally we would like to keep the format of
> > >> > > of size and calls the same, even for future version, because adding a * will
> > >> > > change the format from int to str, which leads to change over the regex parser
> > >> > > many places.
> > >> > >
> > >> > > I think simply adding * to the end of function name or filename is sufficient
> > >> > > as they are already str.
> > >> > >
> > >> >
> > >> > Instead of:
> > >> >
> > >> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> > >> >
> > >> > Could we do something like:
> > >> >
> > >> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)
> > >>
> > >> If there is a postprocessing then this would break sometimes later
> > >> when the function name is parsed, right? So IMO that just postpones
> > >> the breakage.
> > >>
> > >> >
> > >> > This should hopefully not require any changes to the tools that are consuming this file.
> > >> > I think it might be better to use "(inaccurate)" (without any space after function name) or
> > >> > some other text instead of "+" or "*" to prevent breaking such tools. I dont think we need
> > >> > to even increment allocinfo version number as well then?
> > >>
> > >> I'm wondering if we add a new column at the end like this:
> > >>
> > >> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> > >> func:mce_device_create [inaccurate]
> > >>
> > >> would that break the parsing tools?
> > >> Well-designed parsers usually throw away additional fields which they
> > >> don't know how to parse. WDYT?
> > >>
> > >
> > >It would break the parse now as we count the number of string to decide if
> > >there is an optional module name or not. I don't think it is a big
> > >deal to fix though.
> 
> Uh, right. We do have module name as an optional field...
> 
> >
> > The inconsistent of module name is really inconvenient for parsing.....
> > Could we make changes to make it consistent, something like:
> >
> > diff --git a/lib/codetag.c b/lib/codetag.c
> > index 545911cebd25..b8a4595adc95 100644
> > --- a/lib/codetag.c
> > +++ b/lib/codetag.c
> > @@ -124,7 +124,7 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct)
> >                                ct->filename, ct->lineno,
> >                                ct->modname, ct->function);
> >         else
> > -               seq_buf_printf(out, "%s:%u func:%s",
> > +               seq_buf_printf(out, "%s:%u [kernel] func:%s",
> 
> Yeah, until someone creates a module called "kernel" :)
> We could keep the name empty like this:
> 
> +               seq_buf_printf(out, "%s:%u [] func:%s",
> 
> but I'm not sure that's the best solution.
> 

I guess the best option would be to decide how the format can evolve 
in the future with some rules in comment or doc. But I am sure who 
will decide the rules...

> If we are really concerned about parsers, I could add an ioctl
> interface to query the counters which are inaccurate. Would that be
> better?

I think this would be nice as we just need to add functionality on 
top of the parser when we do need it. I guess most of the time we don't 
care about that temporary imprecision.

> 
> BTW, I have other ideas for ioctls, like filtering-out 0-sized
> allocations and such.

You mean using ioctl to control if we only print out the non zero 
ones?

> 
> >                                ct->filename, ct->lineno, ct->function);
> >  }
> >
> >
> >
> >
> > >
> > >I think one more important thing is probably to reach a consensus on
> > >what format can be changed in the future, for example say, we can
> > >keep adding columns but not change the format the type of one column.
> > >With such consensus in mind, it will be easier to design the parser.
> > >And I guess many companies will build parser upon this info for fleet-
> > >wise collection.
> > >
> > >> >
> > >> > >>
> > >> > >> (There would be some corner cases, for example, the '+' sign may not needed when the value reach a negative value if some underflow bug happened)
> > >> > >>
> > >> > >>
> > >> > >> Thanks
> > >> > >> David.
> > >> > >>
> > >> > >>
> > >> > >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > >> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >> > >>> ---
> > >> > >>
> > >> > >
> > >> > > Thanks
> > >> > > Pan
> > >> >
> > >
> > >Thanks
> > >Pan

Thanks
Pan

