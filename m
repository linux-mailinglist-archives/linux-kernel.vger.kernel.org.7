Return-Path: <linux-kernel+bounces-730904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92676B04C25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06C01A66B58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134023956A;
	Mon, 14 Jul 2025 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu46AHoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E691662E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535342; cv=none; b=K3cNdgmVbumIgm6R0ZwtnF42s8gzlQRXVICR59fwPV9lR2hCoxEOaTo1WumpplEOwqUd0eMZreOcF8dfIdvD4gvTBj2OWFLmkW7gR2ZCr13v21bdF/cuFtZ4o5+UIP0+W5YmalzVqHHykXJX6JoQW318c8o/MW3tEr5gGCWqLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535342; c=relaxed/simple;
	bh=mEw3GM8lHz2Em3DYj6xxTGIj0HXcd2ADn7uo7fN8MmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVhafL+LIA081QlNAf4/3s6ib49jXO9CtkRksA3MzGDAHOc1kVSkHXEHFWpQUu0+kSnMbJylydAZcu/BivhK0JIC19AdJD6S+65N9V9/Pd4ze2Lopep6yaUjj8MyYyaj6UBos10r7WFnXTrNDDV0QmpZ5FagD+eUh6mjZ2vbDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu46AHoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517D3C4CEF6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752535342;
	bh=mEw3GM8lHz2Em3DYj6xxTGIj0HXcd2ADn7uo7fN8MmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pu46AHoJLKDPpNZK0nIZXcx1czbZEb9Pp2MQXvgUexnEqMRSMhRDh0X3xFrD4WLtw
	 +c4FWZnD4RtUOIE9RL9wyuBFLSw+npp70q1Ce9UdGSKi5sLJTAIf7Nsg0/6Rorq8yL
	 DkX55nNAHOXlLI4hngu1Ow6d8w4JdxdbfOfW+unOfuL7bSKrkaFtew+4dugn0VOmUo
	 PCtyPKzD76BSZSffOyuGPQF/IcwtwZri38VdkyugZE2lq3+GpN5t5w9f6zZVuEs2vP
	 SStKn3wWPLv80DjSgBPPQOsLeIjwwhdykrHbBFzHlb14GCVEtqqck0CY46/rvuvc6q
	 Tefy1E7HnDc9Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32e14ce168eso43729651fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:22:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9dvpVJ2ZCsm32K+QugzugNfQA/Nm0UlIWx0leS3LtbALspAJeAniPKNzlrgiWJxb+Nwvs2/IGlq+jITs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB40AAJ8RJf3BwJ3WDzr4RI63NBj6V1ZgpCIwrKVhNc6w+9m9z
	/wCdqrrefeZLq11uPLGqm75gtH5+R/nnpPbLFpcdgobe9rHmsVsUytYeHXh1tMG8sXgy6md2AVY
	ckTHMQP03Eze7Yxqof6HivE6nKB9BYUw=
X-Google-Smtp-Source: AGHT+IGkIXLkChFWnn9tShZXlbFyK7ip+TzarIXhJK63dD2BYzNlFgNyqGgA3oVuYAFzIdxh53YxZ87eACnkNvDke34=
X-Received: by 2002:a2e:a588:0:b0:32c:bc69:e926 with SMTP id
 38308e7fff4ca-33053292f8bmr39835811fa.7.1752535340645; Mon, 14 Jul 2025
 16:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714073402.4107091-2-ardb+git@google.com> <20250714102729.GDaHTbkRSLA61z7vPz@fat_crate.local>
In-Reply-To: <20250714102729.GDaHTbkRSLA61z7vPz@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 09:22:08 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEBCYaPtupH67Gf3tHwoFiL7xKXbPpWbVV9zD0=bQg0Hg@mail.gmail.com>
X-Gm-Features: Ac12FXz1VF-L443_XRzu3rn-DUT4G6Px2xgGhcaXqRnOcoUuCa8GprYLolRqZYI
Message-ID: <CAMj1kXEBCYaPtupH67Gf3tHwoFiL7xKXbPpWbVV9zD0=bQg0Hg@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Work around broken noinstr on GCC
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 20:27, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jul 14, 2025 at 09:34:03AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Forcibly disable KCSAN for the sev-nmi.c source file, which only
> > contains functions annotated as 'noinstr' but is emitted with calls to
> > KCSAN instrumentation nonetheless. E.g.,
> >
> >   vmlinux.o: error: objtool: __sev_es_nmi_complete+0x58: call to __kcsan_check_access() leaves .noinstr.text section
> >   make[2]: *** [/usr/local/google/home/ardb/linux/scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/coco/sev/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
> > index db3255b979bd..342d79f0ab6a 100644
> > --- a/arch/x86/coco/sev/Makefile
> > +++ b/arch/x86/coco/sev/Makefile
> > @@ -5,5 +5,6 @@ obj-y += core.o sev-nmi.o vc-handle.o
> >  # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
> >  UBSAN_SANITIZE_sev-nmi.o     := n
> >
> > -# GCC may fail to respect __no_sanitize_address when inlining
> > +# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
> >  KASAN_SANITIZE_sev-nmi.o     := n
> > +KCSAN_SANITIZE_sev-nmi.o     := n
> > --
>
> Hmm, so this points to the carve out:
>
> b66fcee1574e ("x86/sev: Move noinstr NMI handling code into separate source file")
>
> but then we didn't do any KCSAN exclusion to SEV code before either.
>

This is actually an oversight on my part,

Fixes: a3cbbb4717e1 ("x86/boot: Move SEV startup code into startup/")

> I guess send this to Linus now so that it is in 6.16?
>

Yes.

