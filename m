Return-Path: <linux-kernel+bounces-812787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C8B53CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E635A2D50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62723F439;
	Thu, 11 Sep 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3pXsTaE"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F31DBB13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620809; cv=none; b=HxsPf/L19QyUIgA4VeM3EBMBpfcMdn2t9iCc2E8ZbnELXdauXoR4KvFyy1im9vFAr7Aqzqyn776FPbbhH+tzjaQylwqLjPsXr9fgdeoKpndf8ATIP2NpVpHC5xaOeziq3u5ApFXUT+EcyPUwqpqMX5BctjNusN0PpfwYFO8p/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620809; c=relaxed/simple;
	bh=Eftok3OIiWGLGXcFKmgCUvZ+qsppnKo2nntmBzH1ft4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVb4h0FuTSq139BTwIj0LduXaAp9jawC+WzvzVK5ZpB1qEzIIBDMj3cEzZwLWIVbpsZX88dws6GwgGSeLNdxJSpAzkLBsi/mWeC4SPz+N2nOzaAAiZNDjjLgZelwNGW7Wg4asRHiwe2gAMxbqXQtEEplAkbL4Ph01GbdhodQkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3pXsTaE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5d6ce4ed7so114521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757620806; x=1758225606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkD+pqXJNdt1OuxKV0bNOvEmBbohC30JPJ9RYIj7i1A=;
        b=Y3pXsTaE3WJ2OL9udiwYWzhOviW+LAuCEwZ5cNTBXZujwWRgzYN05KCpoGfcdb+xLl
         e+eUAhnLsAksNRITkZgQ0V1s3+sSl5KK4+YdKSoBumZvkeZah00adGlrA0ZEly1yUWdj
         W+RLyuyCng6dlnH5b8gOyowPQSzdOtzaIJU/zvz2NcRhYzvnMzgDYnlG0TWpiFywZrdo
         gKtcerseNKljVuIZCULFKlm/6swvozuR6rqqoRp3/hoQZb+qpNKwbmgXxVYDObk9FJcQ
         ZK58ZUS7U8UWoNIbYoCLvN09cSj0nET8YFTFjt5PLxUmivo5FniiqfIvT14eKpPmORdU
         HkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757620806; x=1758225606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkD+pqXJNdt1OuxKV0bNOvEmBbohC30JPJ9RYIj7i1A=;
        b=fdfY+xj9t9QtUz6T+HJ/q/tABsOImRdcQ8xif3b5I985oZGEVpvUizbKYwJMg80ttp
         gvgEIFfmYSQB6C4jvjjVVuLOskF8fHPfORrTgAqxXnGcMjht0+V84FJt+xZh2lVhY8ej
         Jt8e4bpQRmhdFfcmsTpHV/w1Q1TSbey1TzjRr2AtFgvHuYgYx16ZCIurZ90aH0MNkOY+
         7Cz6aK1vNE0El4SI2s/KzZdiJ9sM02K80sX1NQhRhfs3krk+4G82zkIVr6R5Ldlw/E7b
         bB8V9q7a0QQWf1STr1XhdGpwjHARtgncBfXMqpgz3ioq4pndS9QrBVl9B8ZHy3LxeiCF
         +cXA==
X-Forwarded-Encrypted: i=1; AJvYcCXbQ0xJ6XtvOQ/rqWl/uXeOkSB7mo7QzO7RkQubNkFIHwYEVQSrhVpljUIz2LK8MSvgqu+MbjQSiWxADk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+Kjz3wa8vVhWow8knOBx6wylWC0gIc8sF4nmCoXhuD7P7Gnc
	e2LxFFoLFok6RVsh0H9XtclGNFPBiIuTg/usophM3cGlKrNd/RYlgmta/mnCiUfF0H4kXV04hYE
	b0SI3yR1QFhH0Fe4zlHY6GbZDTFx1d5u/2mLXL5oC
X-Gm-Gg: ASbGnctlOoPiU2wUBu33/0x92PbiBxIJY4LiqXD6c4bQwoCmdAJ8XRh6a5O/wG3l90a
	IydvkkdN/E02i+iJY9ffpGJ6Zj3JK5JJ3xPwerXjEldXjU89Qcwoq34hjZ/DylB30EtIRcDAKhM
	4Z/2Yek6BPWh43m1ThZaa4cfj9fRGqV07+gUPOjsf31Ix6JSqBYVKNqFQyVQtC57Rj0DEG6SVsd
	s7VvUJ3fGKmQYpqWB6GgRh5ZRUcHMDn2DiUfw7wAuer
X-Google-Smtp-Source: AGHT+IHeZdkJlTd9IT+e9NkcdPZieCLN2ZSRzHHSXRONjxP05vm+rLHhuto45i9N4ikCBCZuHo8DRlbYui5sC/nKXZg=
X-Received: by 2002:ac8:7e91:0:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b626f02352mr13514471cf.15.1757620805688; Thu, 11 Sep 2025
 13:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com> <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <CAJuCfpGezf06eR7WnzizpwTaxZ5Rm8jbeW4y87zcr6LZuJ9MZA@mail.gmail.com>
 <aMMF8elYvlPoOF+J@devbig569.cln6.facebook.com> <613698f0.a994.19939d88e1c.Coremail.00107082@163.com>
 <CAJuCfpE=0jpana5qryqwPsuoj_8tCEMWFMcEBTB5-9Lyu_j-Tw@mail.gmail.com> <aMMaP6XgGfX3nVVE@devbig569.cln6.facebook.com>
In-Reply-To: <aMMaP6XgGfX3nVVE@devbig569.cln6.facebook.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 12:59:53 -0700
X-Gm-Features: AS18NWDz0STp3NcTsDYvOn1BA7IJ898f8PoI3t-xf78EI7SQvF9-df4h9s1yOGA
Message-ID: <CAJuCfpEFsqO0U9Lp2ssqD53FgmtVZKsMRSQhZzhLRq_a2jD=SA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Yueyang Pan <pyyjason@gmail.com>
Cc: David Wang <00107082@163.com>, Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	shakeel.butt@linux.dev, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:51=E2=80=AFAM Yueyang Pan <pyyjason@gmail.com> w=
rote:
>
> On Thu, Sep 11, 2025 at 11:13:58AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 11, 2025 at 10:35=E2=80=AFAM David Wang <00107082@163.com> =
wrote:
> > >
> > >
> > > At 2025-09-12 01:25:05, "Yueyang Pan" <pyyjason@gmail.com> wrote:
> > > >On Thu, Sep 11, 2025 at 09:18:29AM -0700, Suren Baghdasaryan wrote:
> > > >> On Thu, Sep 11, 2025 at 9:00=E2=80=AFAM Usama Arif <usamaarif642@g=
mail.com> wrote:
> > > >> >
> > > >> >
> > > >> >
> > > >> > On 11/09/2025 16:47, Yueyang Pan wrote:
> > > >> > > On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> > > >> > >>
> > > >> > >> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.c=
om> wrote:
> > > >> > >>> While rare, memory allocation profiling can contain inaccura=
te counters
> > > >> > >>> if slab object extension vector allocation fails. That alloc=
ation might
> > > >> > >>> succeed later but prior to that, slab allocations that would=
 have used
> > > >> > >>> that object extension vector will not be accounted for. To i=
ndicate
> > > >> > >>> incorrect counters, mark them with an asterisk in the /proc/=
allocinfo
> > > >> > >>> output.
> > > >> > >>> Bump up /proc/allocinfo version to reflect change in the fil=
e format.
> > > >> > >>>
> > > >> > >>> Example output with invalid counters:
> > > >> > >>> allocinfo - version: 2.0
> > > >> > >>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:cre=
ate_setup_data_nodes
> > > >> > >>>           0        0 arch/x86/kernel/alternative.c:2090 func=
:alternatives_smp_module_add
> > > >> > >>>          0*       0* arch/x86/kernel/alternative.c:127 func:=
__its_alloc
> > > >> > >>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:x=
stateregs_set
> > > >> > >>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:=
fpstate_realloc
> > > >> > >>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 fu=
nc:arch_enable_hybrid_capacity_scale
> > > >> > >>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c=
:258 func:init_amd_l3_attrs
> > > >> > >>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 fun=
c:mce_device_create
> > > >> > >>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 f=
unc:mce_gen_pool_create
> > > >> > >>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func=
:mce_threshold_create_device
> > > >> > >>>
> > > >> > >>
> > > >> > >> Hi,
> > > >> > >> The changes may  break some client tools, mine included....
> > > >> > >> I don't mind adjusting my tools, but still
> > > >> > >> Is it acceptable  to change
> > > >> > >>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 fun=
c:mce_device_create
> > > >> > >> to
> > > >> > >>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 fun=
c:mce_device_create*
> > > >> > >>
> > > >> > >> The '+' sign make it still standout when view from a terminal=
, and client tools, not all of them though, might not need any changes.
> > > >> > >> And when client want to filter out inaccurate data items, it =
could be done by checking the tailing '*" of func name.
> > > >> > >
> > > >> > > I agree with David on this point. We already have monitoring t=
ool built on top
> > > >> > > of this output across meta fleet. Ideally we would like to kee=
p the format of
> > > >> > > of size and calls the same, even for future version, because a=
dding a * will
> > > >> > > change the format from int to str, which leads to change over =
the regex parser
> > > >> > > many places.
> > > >> > >
> > > >> > > I think simply adding * to the end of function name or filenam=
e is sufficient
> > > >> > > as they are already str.
> > > >> > >
> > > >> >
> > > >> > Instead of:
> > > >> >
> > > >> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_dev=
ice_create
> > > >> >
> > > >> > Could we do something like:
> > > >> >
> > > >> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_devic=
e_create(inaccurate)
> > > >>
> > > >> If there is a postprocessing then this would break sometimes later
> > > >> when the function name is parsed, right? So IMO that just postpone=
s
> > > >> the breakage.
> > > >>
> > > >> >
> > > >> > This should hopefully not require any changes to the tools that =
are consuming this file.
> > > >> > I think it might be better to use "(inaccurate)" (without any sp=
ace after function name) or
> > > >> > some other text instead of "+" or "*" to prevent breaking such t=
ools. I dont think we need
> > > >> > to even increment allocinfo version number as well then?
> > > >>
> > > >> I'm wondering if we add a new column at the end like this:
> > > >>
> > > >> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> > > >> func:mce_device_create [inaccurate]
> > > >>
> > > >> would that break the parsing tools?
> > > >> Well-designed parsers usually throw away additional fields which t=
hey
> > > >> don't know how to parse. WDYT?
> > > >>
> > > >
> > > >It would break the parse now as we count the number of string to dec=
ide if
> > > >there is an optional module name or not. I don't think it is a big
> > > >deal to fix though.
> >
> > Uh, right. We do have module name as an optional field...
> >
> > >
> > > The inconsistent of module name is really inconvenient for parsing...=
..
> > > Could we make changes to make it consistent, something like:
> > >
> > > diff --git a/lib/codetag.c b/lib/codetag.c
> > > index 545911cebd25..b8a4595adc95 100644
> > > --- a/lib/codetag.c
> > > +++ b/lib/codetag.c
> > > @@ -124,7 +124,7 @@ void codetag_to_text(struct seq_buf *out, struct =
codetag *ct)
> > >                                ct->filename, ct->lineno,
> > >                                ct->modname, ct->function);
> > >         else
> > > -               seq_buf_printf(out, "%s:%u func:%s",
> > > +               seq_buf_printf(out, "%s:%u [kernel] func:%s",
> >
> > Yeah, until someone creates a module called "kernel" :)
> > We could keep the name empty like this:
> >
> > +               seq_buf_printf(out, "%s:%u [] func:%s",
> >
> > but I'm not sure that's the best solution.
> >
>
> I guess the best option would be to decide how the format can evolve
> in the future with some rules in comment or doc. But I am sure who
> will decide the rules...
>
> > If we are really concerned about parsers, I could add an ioctl
> > interface to query the counters which are inaccurate. Would that be
> > better?
>
> I think this would be nice as we just need to add functionality on
> top of the parser when we do need it. I guess most of the time we don't
> care about that temporary imprecision.

We don't care about it until it happens :) I think it would be nice to
have a very visible indication that some values are inaccurate. ioclt
would not do that unfortunately...
Another option is to use the "[]" where we currently encode only
module name to express extra info:

No module, accurate counters:
0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes

Module, accurate counters:
0        0 arch/x86/kernel/kdebugfs.c:105 [my_module]
func:create_setup_data_nodes

No module, inaccurate counters:
0        0 arch/x86/kernel/kdebugfs.c:105 [,inaccurate]
func:create_setup_data_nodes

Module, inaccurate counters:
0        0 arch/x86/kernel/kdebugfs.c:105 [my_module,inaccurate]
func:create_setup_data_nodes

Then the rule for parsers would be that whatever is in [] can be
extended with additional values. If they do not recognize the value,
just ignore it.

>
> >
> > BTW, I have other ideas for ioctls, like filtering-out 0-sized
> > allocations and such.
>
> You mean using ioctl to control if we only print out the non zero
> ones?

Correct.

>
> >
> > >                                ct->filename, ct->lineno, ct->function=
);
> > >  }
> > >
> > >
> > >
> > >
> > > >
> > > >I think one more important thing is probably to reach a consensus on
> > > >what format can be changed in the future, for example say, we can
> > > >keep adding columns but not change the format the type of one column=
.
> > > >With such consensus in mind, it will be easier to design the parser.
> > > >And I guess many companies will build parser upon this info for flee=
t-
> > > >wise collection.
> > > >
> > > >> >
> > > >> > >>
> > > >> > >> (There would be some corner cases, for example, the '+' sign =
may not needed when the value reach a negative value if some underflow bug =
happened)
> > > >> > >>
> > > >> > >>
> > > >> > >> Thanks
> > > >> > >> David.
> > > >> > >>
> > > >> > >>
> > > >> > >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > >> > >>> ---
> > > >> > >>
> > > >> > >
> > > >> > > Thanks
> > > >> > > Pan
> > > >> >
> > > >
> > > >Thanks
> > > >Pan
>
> Thanks
> Pan

