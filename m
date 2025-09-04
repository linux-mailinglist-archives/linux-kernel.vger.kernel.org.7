Return-Path: <linux-kernel+bounces-799739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A2B42FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3D61C2403F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD15213E6A;
	Thu,  4 Sep 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdOlyLxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25021922F6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952245; cv=none; b=U3+EZyhweKaYGcvr5FNmNikm93Y6CK5GK4hbCqJZDtD2fF9FfofxUEi/TI0ZlistquFLAksOA5mCM50axy3PIP+FVkn4UCyi9Cv8A3CgzMukTyPFi3dq9zFqGzqYjTE8fhDEVNLpwrEBAv/YhBo8FCML3BOSWNwq2bh9yVVymmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952245; c=relaxed/simple;
	bh=N0VOnXWIKE6NNmMKKAb50z+AlzIs/etShwjEolgn76I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCj/d3nmilKMIfzIQMOoimFhAW0yneCxvCOvNFKZBrhAvJUyxQXZGikZs9KgA7NOsM6pBJFNSnjXatW56dSiW/+9QDqjhU2hTLZ5+BjT7ZNqxqDoih6c6laalgrM8L6lDfbY6gcZyNKN/zjufRIkAs/tjgODuvM2G+C+IBpVL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdOlyLxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F674C4CEF1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756952245;
	bh=N0VOnXWIKE6NNmMKKAb50z+AlzIs/etShwjEolgn76I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QdOlyLxS0YWEN2ihxgc8Mrd1WHgzT7i9sfD3BsbtZrNOETswbozCDE1mtELEVgJpY
	 ljpagUCYEVkvSbnHDvL4JKI56c3/fZn5bZ6xqwbme1/jupgiRgy1sOeQ4sN0OdP4lV
	 NIjHK5bSgOmLwQQWxn3H4jKjrbryXCKwWY/aHwJYyjMEvm1/p84wkCqdQM4RK8mcGE
	 w8sXW98ovUEviMKSO0WVWJp5lf/845kS373+znglqA4L133MsET5RcmVOjde7QmYCn
	 XooTo978o5qDjwovZX/MRuaPwrnW5yQvyVToIUhgLRgAfcUzx2ivqir4yUMv0cAzxa
	 6Y6om+O6q0ctQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b047f28a83dso43440966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:17:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkFPqKruNWLXX37TMF8yY6gtJoFLM1zI2Id8T6+GS3h/1MQOv3HLNXffPrdi1pD+L7WYQ0AZhEGKKbaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPd4bs/FUpK94O8MzfgwlTjeYxVAMS9Fn2j53//gBUlGBpNjTm
	egOxihEnkUwjUeTldOGOF0Go8lpyGGYgAg+SriQ6NdcT3FX5MnQspd1dkFtd53cOhtJtDJ3dgeL
	5r6gROjQlve/drPz+u7PuQcpqTjpev3U=
X-Google-Smtp-Source: AGHT+IHOWztl46/slEO/7EuS/Va0SzrtEygTka9F+2UmYvOqeFu+c+fnGh3Ug14pYpAytVLf3LRZWiRm9oW1+xZxcO8=
X-Received: by 2002:a17:906:c111:b0:afe:ae1b:bf17 with SMTP id
 a640c23a62f3a-b01d8a2fde7mr1711577766b.3.1756952243768; Wed, 03 Sep 2025
 19:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn> <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
 <a59b3eaa-133d-88bf-f1f3-41328d023c4a@loongson.cn> <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
In-Reply-To: <qvatvh7rixtdtaflqtgphlva7kkr47drijklkvmae3xh54vn6y@y5v75lwgjdyu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 10:17:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com>
X-Gm-Features: Ac12FXwzAM9OobAJiipSpOeHgylrRIqkQNbpf8g-KKwRSdrOhy9Ucuc-6XI8mCY
Message-ID: <CAAhV-H5u4xHcuLhyPe+a_YqPoCX2uVoqcW94i=HvU1NooL_efg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Josh,

On Thu, Sep 4, 2025 at 3:17=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Mon, Sep 01, 2025 at 04:31:36PM +0800, Tiezhu Yang wrote:
> > On 2025/9/1 =E4=B8=8B=E5=8D=884:16, Peter Zijlstra wrote:
> > > On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
> > > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > > the following objtool warning:
> > > >
> > > >    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > > >    falls through to next function __efistub_exit_boot_func()
> > > >
> > > > This is because efi_boot_kernel() doesn't end with a return instruc=
tion
> > > > or an unconditional jump, then objtool has determined that the func=
tion
> > > > can fall through into the next function.
> > > >
> > > > At the beginning, try to do something to make efi_boot_kernel() end=
s with
> > > > an unconditional jump instruction, but it is not a proper way.
> > > >
> > > > After more analysis, one simple way is to ignore these EFISTUB func=
tions
> > > > in validate_branch() of objtool since they are useless for stack un=
winder.
> > > >
> > >
> > > This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(),
> > > right?
> > >
> > > Why not simply do something like:
> > >
> > > diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmw=
are/efi/libstub/loongarch.c
> > > index 3782d0a187d1..082611a5f1f0 100644
> > > --- a/drivers/firmware/efi/libstub/loongarch.c
> > > +++ b/drivers/firmware/efi/libstub/loongarch.c
> > > @@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_load=
ed_image_t *image,
> > >     real_kernel_entry(true, (unsigned long)cmdline_ptr,
> > >                       (unsigned long)efi_system_table);
> > > +   BUG();
> > >   }
> >
> > At the beginning, I did the above change, but no effect.
> >
> > The first thing is to remove the attribute __noreturn for
> > real_kernel_entry(), otherwise the compiler can not generate
> > instructions after that.
> >
> > But there is an argument in the previous RFC [1]:
> >
> > "From my point of view this is incorrect, this function is indeed a
> > noreturn function, and this modification makes LoongArch different to
> > other architectures."
> >
> > Josh suggested to do something so that the EFI stub code isn't linked i=
nto
> > vmlinux.o [2], it needs to modify the link process and seems too
> > complicated and expensive for this warning to some extent.
> >
> > So I did this change for objtool.
>
> I don't like adding these workarounds to objtool.  Is it really that
> complicated to link efistub separately?  That seems like the proper
> design.  vmlinux.o should only have real kernel code.
I don't think this is just a "workaround", ARM64, RISC-V and LoongArch
share the same logic in efistub which may be different from X86. When
ARM64 and RISC-V add objtool support, they will also need to ignore
the __efistub_ functions.

The other patch is similar.


Huacai

>
> --
> Josh

