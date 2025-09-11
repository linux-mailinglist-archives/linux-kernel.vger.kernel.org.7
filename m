Return-Path: <linux-kernel+bounces-812662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB7B53B27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675337B0A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C8368086;
	Thu, 11 Sep 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ8SAwMg"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8121917F1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614452; cv=none; b=J2yxDpX3ABzg5+JYRMTF0O0x4OopkYFfVoDbJ8e1mAqj453NH7rAvMliWANX1nDbDoN8GlhjlTozI/BDVOT6xzELZ/j6DWPvwdqpgPTcR7xRW8QeWQ4yW2oc7gpRvopWmwzKU4FT6cZEWVNNoJx2hsgEUQzm1NVU67z5xlomvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614452; c=relaxed/simple;
	bh=yCfZvpCsJvpjRfyl2nRLVFX9gYfPt89MI8ComUG2/GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCq4efxIYaifcQdXYn0OjEV2dQDja0YITV52Wqkl0bEgOeW4FZwGH6CtSWrt080z8HGPZW1oC3GjOIu87/r0TffT3uZ7NcvXtPqzW1vOB3u8NucaOeIwPK6iqTvJdxZWuq6K3i1SuxC+da8P3EtkZGf9lIAdfMfHcQNgj8XDUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ8SAwMg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b48fc1d998so33901cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757614450; x=1758219250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYuyVJpGyCom5XGCNmTvUskGhre4nTEkWgBI+lNGdkI=;
        b=LZ8SAwMgzt2er4cyPnhzAT1kpygD7flqnjowl+1upC9vsX65A/SY2Pgql/O71ltnj3
         q5sC5lmkydEptyr6fvHtvDzathtRy/VMKHkW5G4rJ07DnFA4l57ZEcOhVi4GtoqploOK
         2RD99SaKFreq7zyKp6E2tZu9vDmyf0fqJwyHl/6W4sNjC+bZA/SfUBKrbrXCWIALeTtn
         4Xep4KOYZmGApUYATo28A2A1Gpjqh6d4pG4OgBpRciAU7wbzRy5EBlQuHEKHqKEAVfrz
         Er3pwtLKTprYctZgwvjf3w45wCMoSszSrjcQGKGHmPeeeO4Kp0dHtgjisjRJlbMZQqtP
         13yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757614450; x=1758219250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYuyVJpGyCom5XGCNmTvUskGhre4nTEkWgBI+lNGdkI=;
        b=V2ROyg5xLKOylzB/F68pyNw0PGwVwCF6L+FFp4GWfyKL5Asusi8U4v05KFWLSuhdMQ
         lV6BP/B/Z1PLsIsizsEuxNcJ5OzGQsaF+kmQs0Hus4sBRUEyEGscAIxwWvivloFLpl+Y
         E5HVDuUEW8Yldw7vSXTbmep3wC+FlRVR35w29MErVOKnnQRKdssUl1VO8mqSar0JuNbF
         3gkZ8kzf2v4Nv//JbFLwh2vjSqRgrnCnA4U/MIHXOZ+XYqNokRYVvED196PiJU8B7XfC
         JsNd+gPSGmBUV40a7fgdPeFZzAfHwHgVXh6hXziGcdv8tXZ5/yYaLYEufNL8AMwBovKs
         /mwg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9NQ07d+gHmFgN1iMIQUV5PrZmUZlhNwXaoTfaNlWgtTiBoLU1pqGO0nTei86ONIB7I26k3ZP3V6Rghk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7fMbiKEMpzzccbWthL/Qjz999b1Vks5mbi6Bq2ikYg7adznn
	CKcY52P6zO1/KTVi9obkyIFTbzwZq6dlAQCyF8iTh7ls2gj4QT0PFqxcZbi4EhxzDDGNistDDPc
	0hTt9KB7FSy4tWRC8hnB1m9ROGNRdub5nMlhtvWW5
X-Gm-Gg: ASbGnctkIuuXp3oLYn9FMTgt+eXfAPdWQTozBZtfhIVfNXu3baZgNoo08Hi03ch7B+/
	P6TR1KtQgFHo75PPVX/RXfDJBuEYsgxmEZohVpQa2CPwi013p+d6jRJKj4mPhno4e7PmcECm2er
	wigR9YArL/RvWTj3Th1ZvnMOP5wQSp44hx4mYUmvmWcpT3Is0OwMqmzR37c8zKWVoqRYkeEGn7y
	jvK+pXHgBH5lkSgy1mC0oz0wDSrl+YkiF7LIOtbsQsI+iytmbRPpsw=
X-Google-Smtp-Source: AGHT+IEfmP8Mzcp+tLHgB0yN8VNfCmikWRVFOPkK+vcAUGS90y7vDqAImVckmIyQNbuuZf1qwMNh/sDAnqwPonFPq4A=
X-Received: by 2002:a05:622a:14c:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b6252075bbmr14516441cf.8.1757614449314; Thu, 11 Sep 2025
 11:14:09 -0700 (PDT)
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
In-Reply-To: <613698f0.a994.19939d88e1c.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 11:13:58 -0700
X-Gm-Features: AS18NWDzjAQUnGQpp0t_fVd91PRT6EI5nxydqFU4J6hwgGgdW_Y4eforaE3zbl0
Message-ID: <CAJuCfpE=0jpana5qryqwPsuoj_8tCEMWFMcEBTB5-9Lyu_j-Tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: David Wang <00107082@163.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:35=E2=80=AFAM David Wang <00107082@163.com> wrot=
e:
>
>
> At 2025-09-12 01:25:05, "Yueyang Pan" <pyyjason@gmail.com> wrote:
> >On Thu, Sep 11, 2025 at 09:18:29AM -0700, Suren Baghdasaryan wrote:
> >> On Thu, Sep 11, 2025 at 9:00=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >> >
> >> >
> >> >
> >> > On 11/09/2025 16:47, Yueyang Pan wrote:
> >> > > On Thu, Sep 11, 2025 at 11:03:50PM +0800, David Wang wrote:
> >> > >>
> >> > >> At 2025-09-10 07:49:42, "Suren Baghdasaryan" <surenb@google.com> =
wrote:
> >> > >>> While rare, memory allocation profiling can contain inaccurate c=
ounters
> >> > >>> if slab object extension vector allocation fails. That allocatio=
n might
> >> > >>> succeed later but prior to that, slab allocations that would hav=
e used
> >> > >>> that object extension vector will not be accounted for. To indic=
ate
> >> > >>> incorrect counters, mark them with an asterisk in the /proc/allo=
cinfo
> >> > >>> output.
> >> > >>> Bump up /proc/allocinfo version to reflect change in the file fo=
rmat.
> >> > >>>
> >> > >>> Example output with invalid counters:
> >> > >>> allocinfo - version: 2.0
> >> > >>>           0        0 arch/x86/kernel/kdebugfs.c:105 func:create_=
setup_data_nodes
> >> > >>>           0        0 arch/x86/kernel/alternative.c:2090 func:alt=
ernatives_smp_module_add
> >> > >>>          0*       0* arch/x86/kernel/alternative.c:127 func:__it=
s_alloc
> >> > >>>           0        0 arch/x86/kernel/fpu/regset.c:160 func:xstat=
eregs_set
> >> > >>>           0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpst=
ate_realloc
> >> > >>>           0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:a=
rch_enable_hybrid_capacity_scale
> >> > >>>           0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258=
 func:init_amd_l3_attrs
> >> > >>>      49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mc=
e_device_create
> >> > >>>       32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:=
mce_gen_pool_create
> >> > >>>           0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce=
_threshold_create_device
> >> > >>>
> >> > >>
> >> > >> Hi,
> >> > >> The changes may  break some client tools, mine included....
> >> > >> I don't mind adjusting my tools, but still
> >> > >> Is it acceptable  to change
> >> > >>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mc=
e_device_create
> >> > >> to
> >> > >>       +49152      +48 arch/x86/kernel/cpu/mce/core.c:2709 func:mc=
e_device_create*
> >> > >>
> >> > >> The '+' sign make it still standout when view from a terminal, an=
d client tools, not all of them though, might not need any changes.
> >> > >> And when client want to filter out inaccurate data items, it coul=
d be done by checking the tailing '*" of func name.
> >> > >
> >> > > I agree with David on this point. We already have monitoring tool =
built on top
> >> > > of this output across meta fleet. Ideally we would like to keep th=
e format of
> >> > > of size and calls the same, even for future version, because addin=
g a * will
> >> > > change the format from int to str, which leads to change over the =
regex parser
> >> > > many places.
> >> > >
> >> > > I think simply adding * to the end of function name or filename is=
 sufficient
> >> > > as they are already str.
> >> > >
> >> >
> >> > Instead of:
> >> >
> >> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_=
create
> >> >
> >> > Could we do something like:
> >> >
> >> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_cr=
eate(inaccurate)
> >>
> >> If there is a postprocessing then this would break sometimes later
> >> when the function name is parsed, right? So IMO that just postpones
> >> the breakage.
> >>
> >> >
> >> > This should hopefully not require any changes to the tools that are =
consuming this file.
> >> > I think it might be better to use "(inaccurate)" (without any space =
after function name) or
> >> > some other text instead of "+" or "*" to prevent breaking such tools=
. I dont think we need
> >> > to even increment allocinfo version number as well then?
> >>
> >> I'm wondering if we add a new column at the end like this:
> >>
> >> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> >> func:mce_device_create [inaccurate]
> >>
> >> would that break the parsing tools?
> >> Well-designed parsers usually throw away additional fields which they
> >> don't know how to parse. WDYT?
> >>
> >
> >It would break the parse now as we count the number of string to decide =
if
> >there is an optional module name or not. I don't think it is a big
> >deal to fix though.

Uh, right. We do have module name as an optional field...

>
> The inconsistent of module name is really inconvenient for parsing.....
> Could we make changes to make it consistent, something like:
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index 545911cebd25..b8a4595adc95 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -124,7 +124,7 @@ void codetag_to_text(struct seq_buf *out, struct code=
tag *ct)
>                                ct->filename, ct->lineno,
>                                ct->modname, ct->function);
>         else
> -               seq_buf_printf(out, "%s:%u func:%s",
> +               seq_buf_printf(out, "%s:%u [kernel] func:%s",

Yeah, until someone creates a module called "kernel" :)
We could keep the name empty like this:

+               seq_buf_printf(out, "%s:%u [] func:%s",

but I'm not sure that's the best solution.

If we are really concerned about parsers, I could add an ioctl
interface to query the counters which are inaccurate. Would that be
better?

BTW, I have other ideas for ioctls, like filtering-out 0-sized
allocations and such.

>                                ct->filename, ct->lineno, ct->function);
>  }
>
>
>
>
> >
> >I think one more important thing is probably to reach a consensus on
> >what format can be changed in the future, for example say, we can
> >keep adding columns but not change the format the type of one column.
> >With such consensus in mind, it will be easier to design the parser.
> >And I guess many companies will build parser upon this info for fleet-
> >wise collection.
> >
> >> >
> >> > >>
> >> > >> (There would be some corner cases, for example, the '+' sign may =
not needed when the value reach a negative value if some underflow bug happ=
ened)
> >> > >>
> >> > >>
> >> > >> Thanks
> >> > >> David.
> >> > >>
> >> > >>
> >> > >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > >>> ---
> >> > >>
> >> > >
> >> > > Thanks
> >> > > Pan
> >> >
> >
> >Thanks
> >Pan

