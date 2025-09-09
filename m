Return-Path: <linux-kernel+bounces-807132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBDB4A07F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DDF4E49C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C132D77EF;
	Tue,  9 Sep 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSvuDIwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6A23C512
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391043; cv=none; b=eWZlvdm+689OHlzUvOvg4bJg/tH/ym7PfU6k6+YG4Ow16OGHa8ot7e0fGf1BFpadO3ZaSHnAIwJENS26mbFuMjoWKseiQZ5BWaSBx8OkHhR6QYq6xT4n9L2w3uvOHrSbcb/BWh4pkbMBIgCMl8a0QekvvFXfwidKsQwjI2H92eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391043; c=relaxed/simple;
	bh=3akNCatce6KOE95D4GEI/qD9m//H8mmo2tfFU7blmdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oeyz4IIfntyzjcbuX6jaAygdRAK7BT6LYkEZi367QHQXNInODWnDNhsdUIVCIERGDoUBKWCgs10dp5Pg04FR68vV1akaSuVf4eYbSQxm9nbGGW6km9HePCrqOyyjPEBjqa+XLmAtAtikcagkLHJnG8tLzjxNgAnmvPd3ea0R63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSvuDIwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699DCC4CEF5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757391043;
	bh=3akNCatce6KOE95D4GEI/qD9m//H8mmo2tfFU7blmdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BSvuDIwjAuVo7DHZZLcvMx9af8HmnElTZWxE1vpqxoN33/30LQZ1wkJ7a3ilOjTf3
	 JWYaH7iW8/xP7VOmeYr4qtioqP0sD6BZ14tdtSpabT5lQ5tHUnAjum+9bZIfSWzgIa
	 9syACfQLKU4Anw1TE+ctkLaau5uw128ti3yzl4uMcijzAsTOT2eT+mYPmo47d6ySoi
	 eQ6dATjBmw3P/HAIM2mBeAnukdPtwpUiM30ASSGYzTvBhcWxhCLcC5XZc3DcMSzMTX
	 9uo2sOM1n/R49bHI1FKt1suzntUTXskDg3ImSPrpWjD4Dbirjl7+Tpb4HhLidOQ0dH
	 v05GBzqrP5Jnw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so8590565a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQE78ONJsBy2iXMj133Vhr1X7nFdOT2btAT7Zc870kjOrWyAKH0QkrCAvnUQoR3+vFoR3FyfUJ1SYN554=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10/orLBU2mdPt6mx4pD1TwwQmO9pZ4uZTmZiUP+p6ZsLkhyCt
	HOnu1s/eFmTUViU7+fFhsZ/Cn5w8/k4K6Qzf2MbFf7KhtlQftKw8voeAAOxb2DLpH3cdbOiDWUV
	A4hcSNG11ZxbqrPU6UsJ4qebP26uGvHg=
X-Google-Smtp-Source: AGHT+IFbPOswZZOp3pr/Mv6PfhzF9+grvdHgGCFvh6Uv38pwroMVVCzD+KT2cf2gQCvOLV+T363PMulv1FlwR8vVYms=
X-Received: by 2002:a05:6402:27d3:b0:62b:ae0f:11cf with SMTP id
 4fb4d7f45d1cf-62bae0f287amr1452760a12.19.1757391041965; Mon, 08 Sep 2025
 21:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn> <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn> <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn> <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p> <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn>
In-Reply-To: <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Sep 2025 12:10:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
X-Gm-Features: Ac12FXxLHrJ7b7AIuzKZTtFqGXbWuSCptZrNXaIw1zTZ4WV2EmDgcU8pN6mB4CY
Message-ID: <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:00=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/9/6 =E4=B8=8A=E5=8D=8812:04, Josh Poimboeuf wrote:
> > On Fri, Sep 05, 2025 at 12:36:16PM +0800, Huacai Chen wrote:
> >> Hi, Josh,
> >>
> >> On Fri, Sep 5, 2025 at 5:46=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> >>>
> >>> On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
> >>>> On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> >>>>> This is from RISC-V code.
> >>>>>
> >>>>> __HEAD
> >>>>> SYM_CODE_START(_start)
> >>>>>          /*
> >>>>>           * Image header expected by Linux boot-loaders. The image =
header data
> >>>>>           * structure is described in asm/image.h.
> >>>>>           * Do not modify it without modifying the structure and al=
l bootloaders
> >>>>>           * that expects this header format!!
> >>>>>           */
> >>>>> #ifdef CONFIG_EFI
> >>>>>          /*
> >>>>>           * This instruction decodes to "MZ" ASCII required by UEFI=
.
> >>>>>           */
> >>>>>          c.li s4,-13
> >>>>>          j _start_kernel
> >>>>> #else
> >>>>>          /* jump to start kernel */
> >>>>>          j _start_kernel
> >>>>>          /* reserved */
> >>>>>          .word 0
> >>>>> #endif
> >>>>>
> >>>>> The HEAD section has instructions, if you change it into a data
> >>>>> section then it loses the "x" attribute.
> >>>
> >>> Actually, the "x" attribute isn't needed for vmlinux.  The vmlinux
> >>> linker script places it in the text region regardless.
> >>>
> >>> Moving the data to a data section should be really simple, something
> >>> like the below.
> >>>
> >>> And yes, even the above RISC-V code can be in a data section.  Those
> >>> instructions are part of the 'struct riscv_image_header' data structu=
re.
> >> This may work but also look strange (code in data section), it is more
> >> like a "workaround". :)
> >
> > The "strange" part of the code is the intermixing of code and data.  If
> > they can't be separated, then they are part of a data structure and
> > belong in a data section.
>
> I tried the following minimal changes, put the image header into
> the section .head.data, do not link efistub lib.a into vmlinux.o,
> just link efistub lib.a into vmlinux, no other changes, they have
> same effect with patch #1 and #2, what do you think?
I still don't think we have to put the HEAD into a data section. Yes,
it is a mix of code and data, but the data is read-only so it doesn't
need the "w" attribute (and code needs "x", at least in theory).

From my point of view, the text section is still the best for HEAD.

Huacai

>
> ----->8-----
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a3a9759414f4..919c1970ce14 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -164,7 +164,6 @@ CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS)
> $(KBUILD_CFLAGS) -dM -E -x c /dev
>   endif
>
>   libs-y +=3D arch/loongarch/lib/
> -libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
>
>   drivers-y              +=3D arch/loongarch/crypto/
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e3865e92a917..c42500d9fad8 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -17,7 +17,7 @@
>
>   #include "efi-header.S"
>
> -       __HEAD
> +       __HEADDATA
>
>   _head:
>          .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S
> b/arch/loongarch/kernel/vmlinux.lds.S
> index 08ea921cdec1..fc35ef349aba 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -38,6 +38,7 @@ SECTIONS
>          . =3D VMLINUX_LOAD_ADDRESS;
>
>          _text =3D .;
> +       HEAD_DATA_SECTION
>          HEAD_TEXT_SECTION
>
>          . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> diff --git a/include/asm-generic/vmlinux.lds.h
> b/include/asm-generic/vmlinux.lds.h
> index ae2d2359b79e..0f95fb1649f3 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -645,6 +645,14 @@ defined(CONFIG_AUTOFDO_CLANG) ||
> defined(CONFIG_PROPELLER_CLANG)
>                  *(.static_call.text)                                    =
\
>                  __static_call_text_end =3D .;
>
> +/* Section used for early init (in .S files) */
> +#define HEAD_DATA  KEEP(*(.head.data))
> +
> +#define HEAD_DATA_SECTION                                              \
> +       .head.data : AT(ADDR(.head.data) - LOAD_OFFSET) {               \
> +               HEAD_DATA                                               \
> +       }
> +
>   /* Section used for early init (in .S files) */
>   #define HEAD_TEXT  KEEP(*(.head.text))
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index a60d32d227ee..4e5be09c42cd 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -98,6 +98,7 @@
>
>   /* For assembly routines */
>   #define __HEAD         .section        ".head.text","ax"
> +#define __HEADDATA     .section        ".head.data","aw"
>   #define __INIT         .section        ".init.text","ax"
>   #define __FINIT                .previous
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 51367c2bfc21..c664bfb9b15f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -69,6 +69,12 @@ vmlinux_link()
>                  libs=3D"${KBUILD_VMLINUX_LIBS}"
>          fi
>
> +       if [ "${SRCARCH}" =3D "loongarch" ]; then
> +               if is_enabled CONFIG_EFI_STUB; then
> +                       libs=3D"${libs} drivers/firmware/efi/libstub/lib.=
a"
> +               fi
> +       fi
> +
>          if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
>                  objs=3D"${objs} .builtin-dtbs.o"
>          fi
>
> Thanks,
> Tiezhu
>

