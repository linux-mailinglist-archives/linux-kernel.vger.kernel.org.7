Return-Path: <linux-kernel+bounces-827095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0526B904BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AFE3A6413
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4F27F72C;
	Mon, 22 Sep 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fLMU/Kwj"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52D224D6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539059; cv=none; b=EExWbk9UAbLIQqtbdITZ+Y5wUy9/q+7wdaLpTg5/iXLkl28l4xw6E6FF8Pn7alurEhSyld+jOPQkNMfAry+WgDTUx10NNh2VsLyskv7M6AusY+s5b9S9SmVngBSXllM64Gx/frIFZz7y/5Y790QxIGMJV9h69GklUBgzSbMwl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539059; c=relaxed/simple;
	bh=x6sXZBtc5Xy+0SaVSipjo15fHcNyaUoOREPg8krCBk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUYcLw5QohKBdZepmYIYwX0GJGgytCauhmvz72kEdvGV3te83K2tPdu/FFXfd3TUH7TbY41hJJ4M8paeRETL2RIPG0lmJh9iy3p4c8q0E2BEnNAsUAao+hERtmYXA1AvxQHtFJWIE41MGF5iMMWjkGttABsIV/aVSLR6rF8y1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fLMU/Kwj; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce8c3afaso3904018fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758539057; x=1759143857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XGdu2beYVX5j16G/50OKngoOcnsJZ8baPn43qnH8Vk=;
        b=fLMU/KwjzDSZS3/anYanEROya++jGDXoREE/7lOpJVXnVEeZBDFUBoCDnbIRvKP2pI
         vOM5iKxe90Fike11jrk3WlT/G7Ba02L14b5/J/xuHqHHbSH5OJCQly2M+qlMAbkmV1Pl
         Q32NRNvFujiLi0SMxd4RSBT3PhZCxST3nkO9YNFfFbMEWBHgh5Ycbe59ahtQ1aqnGnhJ
         1kW1il/CjF+uUSsRdbVS6sjmn6u0r6NKbJ0t27SkxrB+7BONVzKkOODwsEJhWN1jliPu
         0x6mDBIXIPMPqQsMZn3uYs1RfviT8QzoY/0n4vBPFVMPtSMI0AoE8tRWq8fCq30ufewb
         Z4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758539057; x=1759143857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XGdu2beYVX5j16G/50OKngoOcnsJZ8baPn43qnH8Vk=;
        b=T8NdkHwLdv7zjEXFTFu7w54FRfoVVpltG7LXNqqKwGCjmPTaDu1uNdaQ/4s5LVoZwN
         rQ/mwmusRduCsjeJWFuyY6xuHk+TaC4ZEjf2Uaix/W1pe8g5RGgCbn7i9zg6YPXF1R+y
         hHN2YR527r2n4N0CWmOx7OmhYWfNsHyhMWVLq6HZtNMuXDnVt81zQyZKGrPbHqZVpXz5
         jadhDBMVkkPVaFIO5KkbSwobhozTgJRASxwxY7a8zT+A/h9hfQLbXqD6CdlFe1DntsUf
         LKxyWSXWBBxmLj+SLRlVmIteShohF2w2QDnBZyNOJcLlbJVEd9fpx8zElXBkXAzbFPSN
         uFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX//cDIZF/Erg+U6jwJJ/0Zrk8f9NO2snx53MBl9icF2c/k5FaZRyTbMOU31OzwgXeaC8sPyQVHZ/rszeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfLpuCfZ72Xa8gznNuhkJA/TT+1cFNb1ckjRsGfBa2HiQfA76
	syO4u2i3PM+UISxtA8Yfect2Q6XRxtkchz+hCL68ykVZIDOrUCnbDUA41G6zY0jUE1qGxIMZE+t
	G3FBblySaK0FwSshz2ASPjcdjhTppjVFlE9AyREFJfQ==
X-Gm-Gg: ASbGncsyphWek0g5IZ4Uxx8Z43W2QEiRlretXrnrTaPdbwEM2jhhxxCiI5z/43TeNi1
	x5uXwQer9+2dt8ySqR+qA+v6niD5kFP77p3vQvadgqMhYmUI3VOYoA2dS0Dqxu3Ob+sDag70gDf
	mbkjKq5RJ1JKHZ1bC2kFG70undVcI2i7Vl0jjFDZvhWyLf2CDtZgw7V391PaKGdXe8KkCPOFKrj
	3eMNYM5ThD8ZA==
X-Google-Smtp-Source: AGHT+IEvS4cemYKzvf8/W3Ni0tXFdK49y2b13V4Ek7MsLn0SEOghPBIISAL2RiOAvFwYHiWJSM5vrjR4tjFOI/lJfqE=
X-Received: by 2002:a05:6808:2106:b0:437:b63f:5b06 with SMTP id
 5614622812f47-43d6c2aeb61mr5322105b6e.34.1758539057077; Mon, 22 Sep 2025
 04:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
 <20250919085918.5442-2-cuiyunhui@bytedance.com> <20250919-colossal-splendid-bettong-e5a0bd@sudeepholla>
 <CAEEQ3wkRoX5Y5xQu22kVCFxEy8fgcUxKHEm=9Bpg7g-Np8b-SA@mail.gmail.com> <20250922-buffalo-of-hypothetical-downpour-d2a47c@sudeepholla>
In-Reply-To: <20250922-buffalo-of-hypothetical-downpour-d2a47c@sudeepholla>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Sep 2025 19:04:05 +0800
X-Gm-Features: AS18NWCjxTnXNffNhsVhAB7VVz0ET_vSy-py67u7Gzutp1wKTHn_hOJyONTf-KI
Message-ID: <CAEEQ3w=4aKS=p=+q4iC42Va+dMVm017R0Surxff+4R+4RjkgAg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/1] arch_topology: move
 parse_acpi_topology() to common code
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, beata.michalska@arm.com, 
	ptsm@linux.microsoft.com, sumitg@nvidia.com, yangyicong@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Mon, Sep 22, 2025 at 5:01=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Mon, Sep 22, 2025 at 10:18:57AM +0800, yunhui cui wrote:
> > Hi Sudeep,
> >
> > On Fri, Sep 19, 2025 at 10:05=E2=80=AFPM Sudeep Holla <sudeep.holla@arm=
.com> wrote:
>
> [...]
>
> > >
> > > Just thinking if it makes sense keep acpi_cpu_is_threaded generic wit=
hout
> > > the need for weak definition.
> > >
> > > Additional note: not sure why you haven't moved this under CONFIG_ARM=
64/RISCV as
> > > done with other code.
> > >
> > > bool __init acpi_cpu_is_threaded(int cpu)
> > > {
> > >         int is_threaded =3D acpi_pptt_cpu_is_thread(cpu);
> > >
> > >         /*
> > >          * if the PPTT doesn't have thread information, check for arc=
hitecture
> > >          * specific fallback if available
> > >          */
> > >         if (is_threaded < 0)
> > >                 is_threaded =3D arch_cpu_is_threaded();
> > >
> > >         return !!is_threaded;
> > > }
> > >
> > > Then you can just have the define in
> > >
> > > #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK=
)
> > >
> > > in arch/arm64/include/asm/topology.h
> > >
> > > and
> > >
> > > +#ifndef arch_cpu_is_threaded
> > > +#define arch_cpu_is_threaded           (0)
> > > +#endif
> > >
> > > in include/linux/arch_topology.h
> > >
> > > Thoughts ?
> >
> > If placed in include/linux/arch_topology.h, there is a possibility
> > that "arch_cpu_is_threaded" will be redefined.
> >
>
> Why is that a problem ? We want arch to override the default definition
> if and when required.

Because include/linux/topology.h first includes linux/arch_topology.h,
and then includes asm/topology.h, a warning will be generated during
compilation:

In file included from ./include/linux/topology.h:37,
                 from ./include/linux/gfp.h:8,
                 from ./include/linux/xarray.h:16,
                 from ./include/linux/list_lru.h:14,
                 from ./include/linux/fs.h:14,
                 from kernel/events/core.c:11:
./arch/arm64/include/asm/topology.h:39: warning:
"arch_cpu_is_threaded" redefined
   39 | #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMA=
SK)
      |
In file included from ./include/linux/topology.h:30:
./include/linux/arch_topology.h:94: note: this is the location of the
previous definition
   94 | #define arch_cpu_is_threaded()  (0)

Unless #undef arch_cpu_is_threaded is used in arch/arm64/include/asm/topolo=
gy.h,

So it's better to place
#ifndef arch_cpu_is_threaded
#define arch_cpu_is_threaded (0)
#endif
in include/asm-generic/topology.h.

>
> --
> Regards,
> Sudeep

Thanks,
Yunhui

