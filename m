Return-Path: <linux-kernel+bounces-809515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A2B50E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A053AE6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA412D7DD6;
	Wed, 10 Sep 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdFZ2Vli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAE304980
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487333; cv=none; b=oO6tyUQMAaVmSdcWFLjSnigZC3+/ngl2RHMwWfbYiAa88rIipa2xSIgyIK9pHpd8wPbUq2zr5PDpx7hJZt8xgNP8NSOkIPN41IXdvXEkCNDpW+9fGGjg/0gD3IrVFq8MwtXoGaRFRxSVoJ4XN1DFgIyev97xboBDVwRhZgjOpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487333; c=relaxed/simple;
	bh=d2fBUdHLE7EpK3sE/IipwtUnbiMjdcQOLwP7kSpaPTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLQmlpYaIUWtbOQrYu3Ht120ss8t/Re972loHzLGSNQzXvr8P5gBuYUk7arOAtdw0X5dJ7jFK1jpoG97wdnV/lAzXM++mWgvr9nXDCe+QGPsyHjJibWJuAQwqWCq77nSNoWHg1/hIPXC8w7CgM7/AdxOVo3IRkKoj9NKTE3gOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdFZ2Vli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C38C4CEF0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757487333;
	bh=d2fBUdHLE7EpK3sE/IipwtUnbiMjdcQOLwP7kSpaPTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QdFZ2VliPTzR8f7aeJJa7Ys6qpl+ICC7P3babIBgSokGSXUw1z0rUJhvVtHDRxBa/
	 XUUg+c6P8N4TcVvELXzIqDtfTiV43l1EkyWrvJisPn9jv3qoUYnmY9HP/mClNI1q3b
	 pdmI5TimlMFbuYoGrJrSrzqSHMN2UObQwRIV7oQUbyS4HqxF4k0LWH9aMOFcmS0X+K
	 xSWku17H1X6FBfGPemyrjeCErGe2pSROUNytLm/bKXRhcLOtl+hoU6T8ET2aTw6gKy
	 S9bUNAWQT7qNyNh1Yz4a0hAxirMTccax81Q5ADkZfvTudD4HpUNKl1fXN4XT6FdJiK
	 yITzER6XKjM/A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so4707398a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:55:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeuGW95ddwPXnQQn4cNDFmv4Fmahbr3Zsvfp42zArGGdzVfTim85qDuADStkEKIUHn4hgxpkDblbOhos8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qmoqZlwdUIcIa05j4Wx1Lmq0Z53lySLlgsUX79lVuxcHKZri
	STFgC6MMf7Lm5Rc5WHoXSOwB2ALNup7mLSP71+7P4HY8gyeyr5H+9Ions829WPnXOedWNBUa7SA
	N1qSdWz4SL+68Cy12DfVEQ+m1z56c79E=
X-Google-Smtp-Source: AGHT+IETxLIN8OmW7AOoSFL9DGIajG37sBe44LIZH4sqbnnRXxSq/3ywiNlQPbGtvXDD53eudUc9m5nTUe/xX1Twno8=
X-Received: by 2002:a05:6402:5c8:b0:623:d0f1:b029 with SMTP id
 4fb4d7f45d1cf-623d0f1bdc8mr12511145a12.21.1757487331557; Tue, 09 Sep 2025
 23:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
 <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn> <CAAhV-H47VKERJCKRi7uAS7OmCWaE4yxZ07Hwz_si2DMVRDrsag@mail.gmail.com>
 <ybv2ndrzbqztkctzwhfphpdqrqbxlougs75glm22rcuzdmnrfp@lqwcms3j2d55>
 <4thrzifl6ntk7kdf65egt4srzkbrxqoqf7yzmasblwvaq3qwmt@vigfgpbxzjkq>
 <CAAhV-H53DkR6oK1chXQtoczqxYBCU-FMKrD99bjEvfXapND1Vw@mail.gmail.com>
 <itoqfhz4pxaf7aclzajkxcdsxe5akxhgahzj4dp24leh7w334k@epnvcxdga75p>
 <49ceb19c-6107-d026-3ae6-ae897d1fcae4@loongson.cn> <CAAhV-H7U+-WM_cmehAEyKZrGteosZZ3GUsO3yy7wjUNK-v=qjw@mail.gmail.com>
 <domy5iwmaasksrm7srdmus5vifcxrzvozwpnc3ht43qtxvkjhd@gkyxt3qaeyqu>
In-Reply-To: <domy5iwmaasksrm7srdmus5vifcxrzvozwpnc3ht43qtxvkjhd@gkyxt3qaeyqu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Sep 2025 14:55:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47Tfzb-JbM1-mN1c0WaodPM0G0ip6NCDwZb8Yj=E8+Fw@mail.gmail.com>
X-Gm-Features: Ac12FXw_vNPkO5NdCd0ygz9HU0E7ujj68OT-djgljfs4hYxzRqViwYjspQUXbA8
Message-ID: <CAAhV-H47Tfzb-JbM1-mN1c0WaodPM0G0ip6NCDwZb8Yj=E8+Fw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Josh,

On Wed, Sep 10, 2025 at 12:05=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Sep 09, 2025 at 12:10:29PM +0800, Huacai Chen wrote:
> > On Tue, Sep 9, 2025 at 12:00=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > >
> > > On 2025/9/6 =E4=B8=8A=E5=8D=8812:04, Josh Poimboeuf wrote:
> > > > On Fri, Sep 05, 2025 at 12:36:16PM +0800, Huacai Chen wrote:
> > > >> Hi, Josh,
> > > >>
> > > >> On Fri, Sep 5, 2025 at 5:46=E2=80=AFAM Josh Poimboeuf <jpoimboe@ke=
rnel.org> wrote:
> > > >>>
> > > >>> On Thu, Sep 04, 2025 at 10:39:30AM -0700, Josh Poimboeuf wrote:
> > > >>>> On Thu, Sep 04, 2025 at 11:59:30AM +0800, Huacai Chen wrote:
> > > >>>>> This is from RISC-V code.
> > > >>>>>
> > > >>>>> __HEAD
> > > >>>>> SYM_CODE_START(_start)
> > > >>>>>          /*
> > > >>>>>           * Image header expected by Linux boot-loaders. The im=
age header data
> > > >>>>>           * structure is described in asm/image.h.
> > > >>>>>           * Do not modify it without modifying the structure an=
d all bootloaders
> > > >>>>>           * that expects this header format!!
> > > >>>>>           */
> > > >>>>> #ifdef CONFIG_EFI
> > > >>>>>          /*
> > > >>>>>           * This instruction decodes to "MZ" ASCII required by =
UEFI.
> > > >>>>>           */
> > > >>>>>          c.li s4,-13
> > > >>>>>          j _start_kernel
> > > >>>>> #else
> > > >>>>>          /* jump to start kernel */
> > > >>>>>          j _start_kernel
> > > >>>>>          /* reserved */
> > > >>>>>          .word 0
> > > >>>>> #endif
> > > >>>>>
> > > >>>>> The HEAD section has instructions, if you change it into a data
> > > >>>>> section then it loses the "x" attribute.
> > > >>>
> > > >>> Actually, the "x" attribute isn't needed for vmlinux.  The vmlinu=
x
> > > >>> linker script places it in the text region regardless.
> > > >>>
> > > >>> Moving the data to a data section should be really simple, someth=
ing
> > > >>> like the below.
> > > >>>
> > > >>> And yes, even the above RISC-V code can be in a data section.  Th=
ose
> > > >>> instructions are part of the 'struct riscv_image_header' data str=
ucture.
> > > >> This may work but also look strange (code in data section), it is =
more
> > > >> like a "workaround". :)
> > > >
> > > > The "strange" part of the code is the intermixing of code and data.=
  If
> > > > they can't be separated, then they are part of a data structure and
> > > > belong in a data section.
> > >
> > > I tried the following minimal changes, put the image header into
> > > the section .head.data, do not link efistub lib.a into vmlinux.o,
> > > just link efistub lib.a into vmlinux, no other changes, they have
> > > same effect with patch #1 and #2, what do you think?
> > I still don't think we have to put the HEAD into a data section. Yes,
> > it is a mix of code and data, but the data is read-only so it doesn't
> > need the "w" attribute (and code needs "x", at least in theory).
>
> Then it can be __HEAD_RODATA, with the "w" removed:
>
> #define __HEAD_RODATA   .section        ".head.rodata","a"
>
> > From my point of view, the text section is still the best for HEAD.
>
> It belongs in a data section for two reasons:
>
>   1) It's an image header data structure.
>
>   2) We don't want objtool (or any other tooling) to try to validate it
>      or otherwise treat it as text during the build.
I'm sorry but I insist on my opinion. :)

Yes, there are reasons to put it into a data section, but there are
also reasons to put it into a code section.

1) ARM64, RISC-V and LoongArch have the same style (mix code and data
in __HEAD), I don't want to do something special.

2) __HEAD is used for nearly all archs, except ARM64, RISC-V and
LoongArch, other archs are almost pure code (so they must use a code
section). However, the code in __HEAD is usually not like a regular
function. In other word, if other archs add objtool support, __HEAD
will also probably cause problems.

3) Many archs put __HEAD between __init_begin and __init_end, which
means it is discarded at runtime, stack unwinder is useless for it.

So, ignoring .head.text is not just a workaround for LoongArch, it is
a proper solution for other archs.


Huacai

>
> --
> Josh
>

