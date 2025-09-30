Return-Path: <linux-kernel+bounces-837016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADDBAB187
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A462217D56F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82078153BE9;
	Tue, 30 Sep 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQEQ98G3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C91EA7CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200792; cv=none; b=gXreRooLn0j/aytJ+PmyGdYE3sIcIodMji7KNmHXrtkXLUdGZsc+DoTsA1tjwEbsoDgsy0V2svN/IwHNB13AabC5MnspNmXv0NBFCLFUHL24gqgmud2ADXxq8+znoov7msT/OPgGNNO2Pi+Yoy2g3oIbCoV2421XRRa/JZbYfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200792; c=relaxed/simple;
	bh=ym6h+Qei6CJdmJJVbagIpDYKjBeMBZx8FHWAejUB0wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZKugwPZsqCVCx3cuBacl/wfz27a1l3wTjto7JP5/3wvNlc3+OAGy2I/thAH2DeBsKgAz7ih39cHkaTZ0VQ3kRRjMQwKN2ay7415JcJ3Aqvul/PwPPX5k9kAKDBVrSGuKM0VVgSBBzndFGgvZShfGqp4mJVZIt/W+B3XO5Kkpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQEQ98G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847ABC116C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200792;
	bh=ym6h+Qei6CJdmJJVbagIpDYKjBeMBZx8FHWAejUB0wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZQEQ98G3bc+RXLkAjVNzcVi/lvBuHyora3y6Zw3XprKqYOMPaiGuYjUK/G31JHpHr
	 O/OuKZm9HxOCnEpUNddpaLPt8AEcacqAeWwfafojoodFqESXk1zkEJdNPhyMg0aCTq
	 u9t2U/bkf6E2Ki2+tyhc3LF4SVgdenJkZpg5gxVO8OiTLyAuSdwIQIn6hyFegsIt+o
	 czyltKdO8Mhzmuk9ok02kbwhybem3tvpxnlWZKLjd1DoG/jUDb+8I5/pMNXO+ow6wc
	 9R56Mc3eNQU+YHPldkahVJa9yh0GzHiPaLclpp3q1D+rONvmophr3SCnxBPTIcVQ4F
	 ilqJGzWWnxTQA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3d80891c6cso317484066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:53:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWh/7hdh1Ih0SIj5rPE3/85G/qKoJlJ3zYUrz2aSKXQoez+8C378nGegaMV2ef07Y4f9P4fcq7tUaJfpw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMMbZ0jjUz9v0E7ohZq3hnUIYadn8yAYy+1fxgQSybSGIFT27
	tWdxSAfbscHVPL3zeL28jqGm1+LiSbCKhporjHzJW5CnTohIVdX8DmySpuX3kwGoJ1pCNIKBdhA
	SfkJ1UGenILz43bELSq8p9VrEb1D6nuY=
X-Google-Smtp-Source: AGHT+IEfvCuZAVXXWVTEo167aebO6qUsrh2w2UDinUqmaNHItIXCoAnwHta702NRz1ENszkgUaXlenJfqCGyw7SV6Wc=
X-Received: by 2002:a17:907:daa:b0:b2d:4e57:58d8 with SMTP id
 a640c23a62f3a-b413600acc6mr256609966b.10.1759200791107; Mon, 29 Sep 2025
 19:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com> <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 30 Sep 2025 10:52:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6PNcyTNXEhzdovt3an7e9V+B+Z-px=_HPiQ5vv7qaDMg@mail.gmail.com>
X-Gm-Features: AS18NWDktm4BaCz5O-7O3VzGm9rq1tPjPU1iKF2Ar1jh6n3dOQanb3Px7roMXtU
Message-ID: <CAAhV-H6PNcyTNXEhzdovt3an7e9V+B+Z-px=_HPiQ5vv7qaDMg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 10:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Sun, 28 Sept 2025 at 15:52, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Sun, Sep 28, 2025 at 9:42=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> w=
rote:
> > > >
> > > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > > the following objtool warning on LoongArch:
> > > >
> > > >   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > > >   falls through to next function __efistub_exit_boot_func()
> > > >
> > > > This is because efi_boot_kernel() doesn't end with a return instruc=
tion
> > > > or an unconditional jump, then objtool has determined that the func=
tion
> > > > can fall through into the next function.
> > > >
> > > > At the beginning, try to do something to make efi_boot_kernel() end=
s with
> > > > an unconditional jump instruction, but this modification seems not =
proper.
> > > >
> > > > Since the efistub functions are useless for stack unwinder, they ca=
n be
> > > > ignored by objtool. After many discussions, no need to link libstub=
 to
> > > > the vmlinux.o, only link libstub to the final vmlinux.
> > > >
> > >
> > > Please try keeping these changes confined to arch/loongarch. This
> > > problem does not exist on other architectures, and changing the way
> > > vmlinux is constructed might create other issues down the road.
> > ARM, RISC-V and LoongArch do things exactly in the same way. Now
> > LoongArch is the first of the three to enable objtool, so we meet the
> > problem first.
> >
> > But yes, I also don't want to change the way of constructing vmlinux.
> > So I prefer the earliest way to fix this problem.
> > https://lore.kernel.org/loongarch/CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSu=
V0EmeeUb9d5FNw@mail.gmail.com/T/#meef7411abd14f4c28c85e686614aa9211fccdca0
> >
>
> Can we just drop the __noreturn annotation from kernel_entry_t, and
> return EFI_SUCCESS from efi_boot_kernel()?
Not good, because kernel_entry_t is really "noreturn", and at present
no architecture returns EFI_SUCCESS at the end of efi_boot_kernel().


Huacai

