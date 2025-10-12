Return-Path: <linux-kernel+bounces-849778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803EBD0DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D0F4E3FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A782EB5C6;
	Sun, 12 Oct 2025 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw3Mm/SA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53182848AA
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313072; cv=none; b=dMGvdjMFODkZ1R90YjVMCwvWImPK+q9QsTEp7ImEvi99nhwuldmSAnJDQmulFai9WSZGj00oVP9zKmuKlNLDrwDw/hpIPLNbxjQIoD9luZdmuHJf0FEHmC9qF1Yk5cIL73bUaS4kKUn3uTz800P6t60egwC9LIZbRxt4s7oPepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313072; c=relaxed/simple;
	bh=1hhfwvgv5qJC+AoyphWDuLXE10eJqEn11Hz3jk9+lyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dutKn+Bza1rBnODzN5pWk3xmH9JB8B/sfUktAqc+799DHfo6VNkv9VLfkzyzx3Pz5dwpBwVqABztlW5r6cKK7MGCDEg4kqFpHhjoqoP2v3dxlx4w57dFWX1D6VQEO8Wil7GAfTuIrFbaHb8f+wcfEU7y6lobdmUA053o+M85wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw3Mm/SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F461C16AAE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760313072;
	bh=1hhfwvgv5qJC+AoyphWDuLXE10eJqEn11Hz3jk9+lyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kw3Mm/SA/tcRTDDQ0+CmcuVqmFGAuU0e/hwAnKAkWFj22IGpBtaPzugH872mSVTQb
	 riasJyANRBjXFE8o+aXAwjpPj3x6Tbx6YvdSGbmpXAYNuvUN8+xPuS0V+v/wN88BYu
	 ip0LhTlEgS4fC+2S5nYhcGdaV7itc1jDE83y4qLbhhqG+UmtH3z3gIziL4rSUzO+Ek
	 3Smcj1v8vBPx/PsEZwwjKtqlYi2rRrInX31DlH3k57PrclKlPOHBcytiNRbeGsQdai
	 mZ71XQcwerid2o+5XcFcP3tBXL06oDHyqP2+WDlyr196XolE/a4c32t0yhWGu3IxTt
	 2anadroMn7fGw==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1929371f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULmuUUiirG/syNlsK+jLkz7VnLyVIsGNSgjbUgnNuxhgOUT6eQJjQfOIVBfaJBg6JGe5lXhepPtOerTBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwDMAOaokEeWYfSa5sWDit7V6v6GcHRUJxxZRIi+hAusb8Xlg
	J0rOEvMBaJOKm+Db8Tgag3yMBqpnZ0NuiK05WAtrh3F4qEtV8T/VEBGnryjNmU8vhKWAATAvf0g
	OkBIGxt/3EYRvGyW3S5TlXXgEJlNJnFw=
X-Google-Smtp-Source: AGHT+IEYzBXknTykBQ1N4HifJ4EJ5ABEr2IxiSGzoS1xGp1F6TYtaXxoMPgsPrk1p0g+88PANj1vgBGlykuqRZRGutI=
X-Received: by 2002:a5d:64c8:0:b0:3e7:63b0:bf3c with SMTP id
 ffacd0b85a97d-4266e7c6209mr14072627f8f.27.1760313070758; Sun, 12 Oct 2025
 16:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155746.1558731-1-guoren@kernel.org> <CAK9=C2UrYg+sHsDqkmz7f7KnaREU7hXF4rbON002cnAti_pDXg@mail.gmail.com>
In-Reply-To: <CAK9=C2UrYg+sHsDqkmz7f7KnaREU7hXF4rbON002cnAti_pDXg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 13 Oct 2025 07:50:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR9VbOcBQOfF6Tqsp00289mypYExi2iGeKhwTu-iDS+aA@mail.gmail.com>
X-Gm-Features: AS18NWANYCTOkqbOuxt6SoWPohB4_pnla1E2x3tWojPPEfaEypOaOFajbNCOlnA
Message-ID: <CAJF2gTR9VbOcBQOfF6Tqsp00289mypYExi2iGeKhwTu-iDS+aA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add pgprot_dmacoherent definition
To: Anup Patel <apatel@ventanamicro.com>
Cc: samuel.holland@sifive.com, david@redhat.com, yongxuan.wang@sifive.com, 
	cuiyunhui@bytedance.com, luxu.kernel@bytedance.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, palmer@dabbelt.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:51=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> On Sat, Oct 11, 2025 at 9:28=E2=80=AFPM <guoren@kernel.org> wrote:
> >
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > RISC-V Svpbmt Standard Extension for Page-Based Memory Types
> > defines three modes:
> >
> >  Mode | Value | Requested Memory Attributes
> >  PMA  |   0   | None
> >  NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
> >       |       | main memory
> >  IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
> >       |       | (I/O ordering), I/O
> >
> > The pgprot_dmacoherent default uses the IO memory attribute if there
> > is no asm definition, but IO is not for main memory according to
> > Svpbmt rules.
> >
> > This commit corrects pgprot_dmacoherent with the NC memory attribute,
> > which satisfies performance improvement and prevents using the IO
> > attribute to access main memory.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> I had sent the same patch on Aug 20 and you had provided
> Tested-by to that patch.
>
> If you had concerns with my patch then you could have provided
> comments but you choose to hijack it and change authorship.
I didn't find your patch at first, so I sent it out. When I discovered
your patch, I gave the Tested-by to yours.
I've added the abandoned reply to this thread. Have you seen that [1]?

[1] https://lore.kernel.org/all/CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEGWrw=
9ERRLYYA@mail.gmail.com/

>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 29e994a9afb6..2a84479de81b 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -654,6 +654,15 @@ static inline pgprot_t pgprot_writecombine(pgprot_=
t _prot)
> >         return __pgprot(prot);
> >  }
> >
> > +/*
> > + * DMA allocations for non-coherent devices use what the RISC-V archit=
ecture
> > + * call "Non-Cacheable" memory attribute, which permits idempotent, we=
akly-ordered
> > + * (RVWMO), main memory. This is different from "I/O" memory attribute=
 which is
> > + * intended for MMIO access with Non-cacheable, non-idempotent, strong=
ly-ordered
> > + * (I/O ordering), I/O attributes.
> > + */
> > +#define pgprot_dmacoherent pgprot_writecombine
> > +
> >  /*
> >   * Both Svade and Svadu control the hardware behavior when the PTE A/D=
 bits need to be set. By
> >   * default the M-mode firmware enables the hardware updating scheme wh=
en only Svadu is present in
> > --
> > 2.40.1
> >
> >



--=20
Best Regards
 Guo Ren

