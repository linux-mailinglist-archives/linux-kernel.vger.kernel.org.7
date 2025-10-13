Return-Path: <linux-kernel+bounces-849823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8EBD0FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA854E05F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45AC1547D2;
	Mon, 13 Oct 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGyqI9Sm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AC4C6E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760315414; cv=none; b=ZQC4DcrV59IHnFxrY3T889uhqYTFob8cSrEqiw4p4jNTxXVCtf5S1ZuBqMx2L59JhKm9zqvQmWadsvATduI1SvFJZSf5oVyuo+SwDXHFm5d7XMknhUZvRgj5u0E3weSa2aaPY+uUk3Tx3rh8FLSBn9B5H665qcEH6MexRjouMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760315414; c=relaxed/simple;
	bh=Ftqnj4KaATzLCXTBXiHFa8DQwKVVMfZ4GfmyMx/ZjEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKC5z9xWqhBpShoeGk3enCPS9FmVp81h08G1LjwFd6VUGZ3DsBpaOQuFTUOjSCh0ktFIpga6m1coYOrQ3Wc/PPkDJDeQJptJnj5SjNT+PLNwRBctWTmZxVRYrX40jpIZLGBQyegDcTgfqUqQd2BiV5VPzt4eW4VVcUEkwaor7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGyqI9Sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF0FC16AAE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760315412;
	bh=Ftqnj4KaATzLCXTBXiHFa8DQwKVVMfZ4GfmyMx/ZjEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGyqI9Sm66vBEFhZpDoexjnIsKxIQaemKUhG+yrFcf989TLgbGfnjR8v/+TBNu3DB
	 MwTNm6jINMRxiHpxKt+RzwI+SghoXdxYKwyot7XC4bh1fXRJNY5SCMDYVnrzMP3d0/
	 EcEJ5glyvPWLKgO7nquwTsKtfDT3jayyfHi6psy/WqbUatafKqdNYwJngQpRnYwoj5
	 XKz+aeLMisqCUTzIfyGi0RJQjBXtGXVasofModjF1WfCnOmMq6XFu8JoR/zAxzJXhJ
	 m+MhKqEDSELVByzu09xhtliLQIts7mhDQLqxZFSSOZpHvnYUPU7hPeSaXaCfYGG05B
	 hm09HfsjLRYhA==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f44000626bso2558506f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:30:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvlcdKJEYfq1sNFeEeoH6zn1QU9lQlQRzgnlhZXZ8FEoSLjxZzdHFu0gWeGmCHzvPpiVbuMwXjOREjDw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnMCD39bAlI3fvauEqlld/AGywjSgP7cuRgPo3bnZsmT0hbbm
	KLeM9RROptuW56xpePotkMVMIhL/8BX8sER4xl009r/Msryn7Kwge8tbh9EZBiJkXEo2pXXk0TL
	t74OwZvm6Q5ZCPY9yDMcLVBPULRl25bY=
X-Google-Smtp-Source: AGHT+IF28hGFEYqy29BMAFT4KFXlhAWSW7TtE/VIwFlQvB8Cdfl8PzF88CzrL2eeItCVIJ5zgOvuDFGeYxdYMM4z/hs=
X-Received: by 2002:a05:6000:2891:b0:3ee:1523:2310 with SMTP id
 ffacd0b85a97d-4266e7c203emr13067865f8f.27.1760315411080; Sun, 12 Oct 2025
 17:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155746.1558731-1-guoren@kernel.org> <CAK9=C2UrYg+sHsDqkmz7f7KnaREU7hXF4rbON002cnAti_pDXg@mail.gmail.com>
 <CAJF2gTR9VbOcBQOfF6Tqsp00289mypYExi2iGeKhwTu-iDS+aA@mail.gmail.com>
In-Reply-To: <CAJF2gTR9VbOcBQOfF6Tqsp00289mypYExi2iGeKhwTu-iDS+aA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 13 Oct 2025 08:29:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRwW+0-nAvagfBf8U9vbUWocvCaNfYNVrCN+d2hYxdBYg@mail.gmail.com>
X-Gm-Features: AS18NWCS67Vw69jJgG0u0GE_175z0kD2HPQ7-bp5JgDUnjIYl49Fw2qPHcn4IW4
Message-ID: <CAJF2gTRwW+0-nAvagfBf8U9vbUWocvCaNfYNVrCN+d2hYxdBYg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add pgprot_dmacoherent definition
To: Anup Patel <apatel@ventanamicro.com>
Cc: samuel.holland@sifive.com, david@redhat.com, yongxuan.wang@sifive.com, 
	cuiyunhui@bytedance.com, luxu.kernel@bytedance.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, palmer@dabbelt.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:50=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Oct 12, 2025 at 11:51=E2=80=AFPM Anup Patel <apatel@ventanamicro.=
com> wrote:
> >
> > On Sat, Oct 11, 2025 at 9:28=E2=80=AFPM <guoren@kernel.org> wrote:
> > >
> > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> > >
> > > RISC-V Svpbmt Standard Extension for Page-Based Memory Types
> > > defines three modes:
> > >
> > >  Mode | Value | Requested Memory Attributes
> > >  PMA  |   0   | None
> > >  NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
> > >       |       | main memory
> > >  IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
> > >       |       | (I/O ordering), I/O
> > >
> > > The pgprot_dmacoherent default uses the IO memory attribute if there
> > > is no asm definition, but IO is not for main memory according to
> > > Svpbmt rules.
> > >
> > > This commit corrects pgprot_dmacoherent with the NC memory attribute,
> > > which satisfies performance improvement and prevents using the IO
> > > attribute to access main memory.
> > >
> > > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> >
> > I had sent the same patch on Aug 20 and you had provided
> > Tested-by to that patch.
> >
> > If you had concerns with my patch then you could have provided
> > comments but you choose to hijack it and change authorship.
> I didn't find your patch at first, so I sent it out. When I discovered
> your patch, I gave the Tested-by to yours.
> I've added the abandoned reply to this thread. Have you seen that [1]?
>
> [1] https://lore.kernel.org/all/CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEGW=
rw9ERRLYYA@mail.gmail.com/

This patch is on Sat, Oct 11, 2025 [1]
Guo's Tested-by is on Sun, 12 Oct 2025 02:07:34 [2]
Abandon reply is on Sun, 12 Oct 2025 14:11:42 [3]
Gao's Tested-by is on Sun, 12 Oct 2025 18:00:36 [4]

[1]: https://lore.kernel.org/all/20251011155746.1558731-1-guoren@kernel.org=
/
[2]: https://lore.kernel.org/linux-riscv/aOtR39pl5xjyYHn1@gmail.com/
[3]: https://lore.kernel.org/all/CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEGWr=
w9ERRLYYA@mail.gmail.com/
[4]: https://lore.kernel.org/linux-riscv/031395FE-C51C-45A7-85A3-CC4A25EB60=
66@gmail.com/

I also asked Gao to notice your patch and give it the Tested-by tag.
That's why you got two Tested-by on Oct 12 after two months. So, your
reply, "but you choose to hijack it and change authorship," makes me
sad.

Anyway, it's a vital fixup patch that resolved the bug that had
existed for many years of svpbmt, and I hope this misunderstanding can
draw the maintainers' attention and gain more Tested-by tags.

>
> >
> > Regards,
> > Anup
> >
> > > ---
> > >  arch/riscv/include/asm/pgtable.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index 29e994a9afb6..2a84479de81b 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -654,6 +654,15 @@ static inline pgprot_t pgprot_writecombine(pgpro=
t_t _prot)
> > >         return __pgprot(prot);
> > >  }
> > >
> > > +/*
> > > + * DMA allocations for non-coherent devices use what the RISC-V arch=
itecture
> > > + * call "Non-Cacheable" memory attribute, which permits idempotent, =
weakly-ordered
> > > + * (RVWMO), main memory. This is different from "I/O" memory attribu=
te which is
> > > + * intended for MMIO access with Non-cacheable, non-idempotent, stro=
ngly-ordered
> > > + * (I/O ordering), I/O attributes.
> > > + */
> > > +#define pgprot_dmacoherent pgprot_writecombine
> > > +
> > >  /*
> > >   * Both Svade and Svadu control the hardware behavior when the PTE A=
/D bits need to be set. By
> > >   * default the M-mode firmware enables the hardware updating scheme =
when only Svadu is present in
> > > --
> > > 2.40.1
> > >
> > >
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren

