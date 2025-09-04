Return-Path: <linux-kernel+bounces-799829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA4B430B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E4E188C3F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BE227563;
	Thu,  4 Sep 2025 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmEi8hQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D312264B1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958384; cv=none; b=gqcHjUUO4GqmDhVXf3pi7pWT+R0Ga68hyfPyQjRqEwFXKB2daAmUBhVRrG4QcWRDjzLKVAFS4ymhNJQTn+w1J4dauKPP7J4AAdv0lFnGrXHPteLiBIp6jnQMIi+53JGg5yOhHfCmrv+PgB/C14l8NfCcR4Wgdl+/T0KMOJg3R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958384; c=relaxed/simple;
	bh=Z+BnEz0jvg+yK0dAV5XhybeWEpr6xpDUc3QMzhsDHXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivdhOLJ2BiOUSa1rAkz6Hec/l8Z/8HAmWHf3Z8dPbOUDb2VHjG862szio4VlUzv1ied7sKM9kp0rqscKW1acXVlQAzqpPh/GZQWVrsw8o8tr7N7cvnyoPTfRbgn3m9aemHjT8UxEFZjiaRaVP4g2FWfP4MQmc/CZFSOWI+yaadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmEi8hQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A1C4CEF0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756958384;
	bh=Z+BnEz0jvg+yK0dAV5XhybeWEpr6xpDUc3QMzhsDHXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmEi8hQVxB+vB4qI9JIsiQmWd0Itxe0lorXLK50cLyibClunc7/HTif68v2OeD3OV
	 OC1OtlC2syfmkCu1tDhpsFcrgJ3N4E56j4O0fObeFy+Zs9t9k45IImdC0UhaT2p+bK
	 OF7NE+/XaKdwJK68cF2Y3BLF+hyB3mbAcLVfKsKYtsz9nXK4DJ2BFjo6WP/0/EV3je
	 dC2PktXMVbS1BykhCQw2I2lNQhBJzKzc5fFYP9kQSh3+O+WJ5MEHLil10Xc4CWOAD0
	 Ut6ebi5ZUun+tMlATTFNeQvlYzqvgxOpw/3xm99Cyus4PFrYkyxdzt+/3pw8Z3x7tO
	 LhDyLTo2Tj/WQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso673590a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:59:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUajYq0PUQzCS+IxD0kijdAvB8FRZnLk+/htWNsvxoHOYqvMCOhFBF+Bd66xYSbD7OmKW+uNTwrYIT0eE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgL464sdfCpFLWIsXTJqwdJ0DnlcaYRvh5eM+VHTFqn4Xby54z
	s22PH8ODoZT05xC6+8taqhp/cZbW5rdzRLa7TRrPouBvcMuL1EiHDRWZp8s6WfhwmkLdb7NxVKO
	OmvySgUZkBwF6UgjrkkMlVzfEucGpMvg=
X-Google-Smtp-Source: AGHT+IFtZbt4F2wiEft1YMfhg8FPqNBSOrFLpd05PCI0gAHIRapAuWGlrPMyURoHhEefcvG/q+IUwr4/gCmxQKjvREE=
X-Received: by 2002:a05:6402:1d49:b0:61f:177a:e458 with SMTP id
 4fb4d7f45d1cf-61f177ae946mr559135a12.24.1756958382663; Wed, 03 Sep 2025
 20:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn> <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn> <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn> <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
In-Reply-To: <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 11:59:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
X-Gm-Features: Ac12FXxP3ZoLcidPegFPaxOdZY3bQjf34J0IwTsbnSzDdpOhDTVExs6BrMaldbE
Message-ID: <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:50=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/9/4 =E4=B8=8A=E5=8D=8810:21, Huacai Chen wrote:
> > On Thu, Sep 4, 2025 at 10:18=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> On 2025/9/4 =E4=B8=8A=E5=8D=883:19, Josh Poimboeuf wrote:
> >>> On Mon, Sep 01, 2025 at 04:39:29PM +0800, Tiezhu Yang wrote:
> >>>> On 2025/9/1 =E4=B8=8B=E5=8D=884:19, Peter Zijlstra wrote:
> >>>>> On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
> >>>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist =
the
> >>>>>> following objtool warnings:
> >>
> >> ...
> >>
> >>>> Josh suggested to do something to put these instructions in the data
> >>>> section, but as said in the previous reply, it needs to modify the l=
ink
> >>>> process and seems too complicated and expensive for this warning to =
some
> >>>> extent.
> >>>>
> >>>> So I did this change for objtool.
> >>>
> >>> I don't like this workaround either, how exactly is it complicated an=
d
> >>> expensive to put the data in a data section?
> >>
> >> I can put them in a data section in the next version, this is
> >> reasonable.
> > No, from the ARM64 and RISC-V design, we can put jump instructions in
> > the HEAD section, and this is what Jiaxun wants to do. Changing to a
> > data section is not reasonable.
>
> ARM64, RISC-V and LoongArch share the same logic in efistub:
>
> $ grep -r "libstub/lib.a" arch/*/Makefile
> arch/arm64/Makefile:libs-$(CONFIG_EFI_STUB) +=3D
> $(objtree)/drivers/firmware/efi/libstub/lib.a
> arch/loongarch/Makefile:libs-$(CONFIG_EFI_STUB) +=3D
> $(objtree)/drivers/firmware/efi/libstub/lib.a
> arch/riscv/Makefile:libs-$(CONFIG_EFI_STUB) +=3D
> $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> If we can not put the these data to a data section, then we can not
> link efistub separately, because if remove the following code in
> arch/loongarch/Makefile:
>
> libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib.=
a
>
> there exists the following build error:
>
>     LD      vmlinux.o
>    OBJCOPY modules.builtin.modinfo
>    GEN     modules.builtin
>    GEN     .vmlinux.objs
>    MODPOST Module.symvers
>    UPD     include/generated/utsversion.h
>    CC      init/version-timestamp.o
>    KSYMS   .tmp_vmlinux0.kallsyms.S
>    AS      .tmp_vmlinux0.kallsyms.o
>    LD      .tmp_vmlinux1
> ld: arch/loongarch/kernel/head.o: in function `pe_header':
> (.head.text+0x68): undefined reference to `__efistub_efi_pe_entry'
>
> What should to do in the next step? I am looking forward to your
> final conclusion.

This is from RISC-V code.

__HEAD
SYM_CODE_START(_start)
        /*
         * Image header expected by Linux boot-loaders. The image header da=
ta
         * structure is described in asm/image.h.
         * Do not modify it without modifying the structure and all bootloa=
ders
         * that expects this header format!!
         */
#ifdef CONFIG_EFI
        /*
         * This instruction decodes to "MZ" ASCII required by UEFI.
         */
        c.li s4,-13
        j _start_kernel
#else
        /* jump to start kernel */
        j _start_kernel
        /* reserved */
        .word 0
#endif

The HEAD section has instructions, if you change it into a data
section then it loses the "x" attribute.

So my conclusion is this series is the correct solution for all
non-x86 archs. We don't need to treat it as "workarounds".

Huacai

>
> Thanks,
> Tiezhu
>

