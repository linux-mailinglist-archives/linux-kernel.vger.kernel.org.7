Return-Path: <linux-kernel+bounces-823848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26AB8790B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4B3AA417
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C31C860F;
	Fri, 19 Sep 2025 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2S00ee4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00821369B4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243798; cv=none; b=RU9+zmDdh2stBPIE3SmN4uW5aqiDy+9axGWwM8e+pRSYMQ1EefsnTS6m/QMMLWcnd4tnjWUqu38y24L37NE1qJFFhGOJC9pR+gBXodp3Hr4jm6ur+rEjGxjBOlbWHwAB2yWBCC/eOu+SyMxVq1+PEXyIVdGLMYevDdItM542rLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243798; c=relaxed/simple;
	bh=NQH0ksGEHbnPyoln1caWKpJK2uzZhjugvlBcdguhXDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeLTs2wVs7XhjMZNAqgBRBjjhaptpiVkTkR6c25CP8mhjhfpKRt6yBKw1+YvPx3Sct1ZmpVqJDpl8frZQH4F2zWTp319Io8g5cULBPqGJ/DNwjAc3ZxxV3A6bNWLtdkYnwCsE6IHT+5ZTyswwI7mivbbsiZD7AQ12ZbvuznqffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2S00ee4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF79C4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758243798;
	bh=NQH0ksGEHbnPyoln1caWKpJK2uzZhjugvlBcdguhXDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L2S00ee4j20bXPdIavzxonD3OVNkTYst54XlpEUisTa+sE2U4LfNHsGIKcHDqnIqL
	 03teC1bd3d/emhnG+Ek38xqNMqTBa4XN7d5M0k+bsneCjSDUCCgZZltl9n+KtIYsvu
	 voNvvI1O48/moQHV2DZsnxN8al/rxKb5tgsTdbItchrqkNnSYPTsMMYCrgKvhm4UUv
	 kFXmCMUdAFsGk/QyKh4RbUb5hc0LziYsBkVpiPwfYXNYu0Fnq4OORBN4CRjo77LnW9
	 bImPlL9QkYi3gTkDfc+BcSUM/mmlFmiLCj4u0KROcXDUDjcBWJbtm30ypRLoUl7NXd
	 IsT3GJ1Ur+42g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso2295605a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:03:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcFc4pkz3yNnPuc+F4UARhMR9iOzneYexY9doIn4tadriax6wFNR5xJapkytAWsPxx19hA/OE2HaxryTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfk8cKCaP3cLFN+9fezFflEuBxHaWbtIIZT/wrUlfD0zCQMaCe
	a7klzfVx+pYLyzyoWyJqy87M3W7+PDw1NPmg/Hs/Nw5bhzWXoXlJb8WvD4cSt1heLUmjuGwumGL
	I3ivFlgwajBeTaNAR5PdfxfNXTfVcEFM=
X-Google-Smtp-Source: AGHT+IEWDmIshmLj2G4ukbKcQsu43zLFa0GbZO4GUGnB6KBPcUZ/DzAZy7pv/NlVkIk+CQuw453e7DKWrQHVZlcXTjo=
X-Received: by 2002:a17:907:1c89:b0:aff:c306:de51 with SMTP id
 a640c23a62f3a-b24eca00e53mr131947766b.4.1758243797028; Thu, 18 Sep 2025
 18:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917112716.24415-1-yangtiezhu@loongson.cn>
 <20250917112716.24415-2-yangtiezhu@loongson.cn> <ym3yf3rkxfq3sukfqbemmbpamjfsx4jjushqh3f54ah5ugamse@qqwabon64umq>
 <64530e20-9bc7-0c0b-d6ea-a4c7df3e85d9@loongson.cn> <pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy>
In-Reply-To: <pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 19 Sep 2025 09:03:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSuV0EmeeUb9d5FNw@mail.gmail.com>
X-Gm-Features: AS18NWBVTb0PQqhU62n6eO284WwNeuQiKwu7o5gUI2msYqvF_VGFdAVdSA6O--M
Message-ID: <CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSuV0EmeeUb9d5FNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] objtool/LoongArch: Fix fall through warning about efistub
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:20=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Thu, Sep 18, 2025 at 09:44:24AM +0800, Tiezhu Yang wrote:
> > (1) libstub doesn't link to vmlinux.o, only link libstub with vmlinux.o
> > during the final vmlinux link.
> >
> > ----->8-----
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index a3a9759414f4..919c1970ce14 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -164,7 +164,6 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS)
> > $(KBUILD_CFLAGS) -dM -E -x c /dev
> >  endif
> >
> >  libs-y +=3D arch/loongarch/lib/
> > -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> >
> >  drivers-y              +=3D arch/loongarch/crypto/
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 51367c2bfc21..c664bfb9b15f 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -69,6 +69,12 @@ vmlinux_link()
> >                 libs=3D"${KBUILD_VMLINUX_LIBS}"
> >         fi
> >
> > +       if [ "${SRCARCH}" =3D "loongarch" ]; then
> > +               if is_enabled CONFIG_EFI_STUB; then
> > +                       libs=3D"${libs} drivers/firmware/efi/libstub/li=
b.a"
> > +               fi
> > +       fi
>
> Right, though I think it would need to be something more generic so that
> other arches can have "post-objtool libs" as well.
I don't like this solution, but if ARM64, RISC-V and LoongArch are
changed together, I can accept.
And please remember to ensure ZBOOT on EFISTUB still works.

Huacai

>
> For example, arch/loongarch/Makefile could have
>
>   KBUILD_VMLINUX_LIBS_PRELINK +=3D $(objtree)/drivers/firmware/efi/libstu=
b/lib.a
>
> which can be exported by the top-level Makefile:
>
>   export KBUILD_VMLINUX_LIBS_PRELINK
>
> and then used by scripts/link-vmlinux.sh (untested):
>
>   ${ld} ${ldflags} -o ${output} \
>         ${wl}--whole-archive ${objs} ${wl}--no-whole-archive \
>         ${wl}--start-group ${libs} ${KBUILD_VMLINUX_LIBS_PRELINK} ${wl}--=
end-group \
>         ${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
>
> --
> Josh

