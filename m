Return-Path: <linux-kernel+bounces-870671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C54C0B6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61E718A0755
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA83002A5;
	Sun, 26 Oct 2025 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b="hsRGQOKt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5352FFFA8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519960; cv=none; b=gAcz8+ksGaThMJunTyjTuGKUq+IF6nDuQ/HHwnYm97KMNwJF5B2nJSiK0CrKCKzJ9ymWlcRrp6Wf4DRDAPziE6MaqgBPg3pHRY/PJkEw4fqfVrzSovWgF/0FzWetoHA3HjIqIBWYQ6nZI6qR4C0mx0quK25bM8HIa4pY44qt2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519960; c=relaxed/simple;
	bh=PPxjfgh0ouB1LEh9FfKbHQ8cr7KijaRuWZO7sOvIlmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVRkaJxN9xe7TyqQ4QFVkijZ1vU0ou3XRZVD/6WSsh17DOfdn+if818FcYVnnd4OkJkFnPZr3A/R/YKpLHrdMwVljzhiT0XQ4OZtqeeRuvUqB/UJiOdSPN08paBkSw2HZ3mGrbxPVLFORB43MHH/b2gp34xY+59jDRohC7w8t+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk; spf=pass smtp.mailfrom=surgut.co.uk; dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b=hsRGQOKt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surgut.co.uk
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b64cdbb949cso903544166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google; t=1761519953; x=1762124753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=is27natm4q82ZfjRueAlfHtVSyQtOlMyTtv22WIryvc=;
        b=hsRGQOKtsSEjTRu6s5t/zHvqNcX0sCsq8Kf6xuP6PWBeV6RPobjEeCz9bADYTOTxAP
         5BNfJSOYYxalwx1oyMUxc66d2ru+sIM32G566vggWn1MbG+SAc5ioifeGBsSrwUQ4PF5
         MdF3ZTZloo4VJYIh/Sr8EuCqX84rpJqjQ3iOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519953; x=1762124753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=is27natm4q82ZfjRueAlfHtVSyQtOlMyTtv22WIryvc=;
        b=G55XR8t82xOBpHWWTkJFbBnOvUlS82kWngtYW2thbAz0BYnU1wqr5++TPkqsNxTOqM
         U68UacNiJKJhfTBgi+W1W49Y61gf9SrOfy4q8QUxnQhvIRnlLkJlLMTQWbHt6qGTE+UH
         bQ9fQAKfbCqRDwxZmwrxUGO0hdjIAz5vOE24grAnAhbRYGWPJuZdI6cl+IKnFBIbwNxY
         NTgB6WrZDcIhSu2xvJCZKKlPul4C3Ej98Ql5ErqoxZlNlSvmYry3KeSxVjMp7eHXMDKr
         V1w6/1L0b9yc91yOEFkNKaxgzJtR87qIvwszSKN2tAIBELifQ2sGRUFE3tpU+NOiBCNa
         oE3Q==
X-Gm-Message-State: AOJu0Ywqj5U6ApR338/WBepYbWfhO91HrO51O+f6ALbBMCQAKMCWYAkt
	MCs8XRfp4GdMmHvluaLHF5eqhoyHodrDegQtcdx0YthW4voIGlYgnZ3t/nFTva/mKKm3ziFAY2O
	GV4jfXyZx43828mwlheR721XMy0o0YnS4KOq/YARz4A==
X-Gm-Gg: ASbGncvdLW3sVbrBgp+FehmvqrzBbiX+eHV6KEE9olDI5gclB9JAs8IiWqW3sQzc3xx
	oN6Onf16PF0Y33sIph8cU93gcCFoltbxboZgO9P50C5s08WDIUjDOO+jYzr+U2NJp6c8U+jSHZz
	sMqJAwRwpMEQkyV54us94jdZW2R2tnJJNl+H1VOR4qK3czGZOX3xwtX58WrVFtBWeLa5JOqpElz
	R0DWGv4oHHgZjpMXRFc/gDdJxgAiLcT1pm22sOraJGIz91C4tbuPfO7w4MlcCALaF+lWcesk6RO
	q1f8ehgvcLTyswKygqg=
X-Google-Smtp-Source: AGHT+IE2qeiv6wtEHcxfHTxcz3+g4CqNYkc3SG8aYvr97lhf/t3X5J9M5LV1kA1IPHQlfzD1kGLF4Bc3T0T6p5XwUH0=
X-Received: by 2002:a17:907:1b18:b0:b6d:4080:fdf0 with SMTP id
 a640c23a62f3a-b6d6ff6e411mr962713966b.50.1761519952882; Sun, 26 Oct 2025
 16:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk> <20251026215635.GA2368369@ax162>
In-Reply-To: <20251026215635.GA2368369@ax162>
From: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Date: Sun, 26 Oct 2025 23:05:41 +0000
X-Gm-Features: AWmQ_bk-C6yqRcXuQFysCvIdDTFpFqbzjo0WJC8EN1TlWFS6dNkNgds3DoFI9WM
Message-ID: <CANBHLUikrwQS2UcMa1Ryde3r8mPSTCL1WrObF1qKa+o-=MjN=A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: align modinfo section for Secureboot Authenticode
 EDK2 compat
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	masahiroy@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, 
	legion@kernel.org, nsc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 21:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Dimitri,
>
> On Sun, Oct 26, 2025 at 08:21:00PM +0000, Dimitri John Ledkov wrote:
> > Previously linker scripts would always generate vmlinuz that has sections
> > aligned. And thus padded (correct Authenticode calculation) and unpadded
>
> Was this something that was guaranteed to happen or did it just always
> happen by coincidence? Is there a way to enforce this?

I don't believe this was ever guaranteed, but out of convenience /
performance / compatibility various sections are aligned and padded
already. Thus it is possible that it was an unwritten contract that
all kernels' sections so far have been padded/aligned on many if not
all UEFI platforms.

From time to time, roughly every 3-5 years since 2012, I experience
this class of bugs in various EFI tooling and/or projects. In all
cases projects agree to produce aligned&padded binaries.
Because it is almost no cost to do so, and it prevents head-scratching
debugging.

I don't know of a good way to enforce this, the pesign tool is a good
way to check this -> as it implements the known padded/nopadding
options to calculate the hashes. Maybe some pefile walk script can be
written to validate/test sections at the end of the kernel build. If
such a tool exists, it would be useful for gnu-efi, grub,
systemd-boot, fwupd, and all kernels.

>
> > calculation would be same. As in https://github.com/rhboot/pesign userspace
> > tool would produce the same authenticode digest for both of the following
> > commands:
> >
> >     pesign --padding --hash --in ./arch/x86_64/boot/bzImage
> >     pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage
> >
> > The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
> > vmlinux.unstripped") added .modinfo section of variable length. Depending
> > on kernel configuration it may or may not be aligned.
> >
> > All userspace signing tooling correctly pads such section to calculation
> > spec compliant authenticode digest.
>
> I might be missing something here but .modinfo should not be in the
> final vmlinux since it gets stripped out via the strip_relocs rule in
> scripts/Makefile.vmlinux. Does this matter because an unaligned .modinfo
> section could potentially leave sections after it in the linker scripts
> unaligned as well?

I am out of my depth here as well, but yes I too am surprised how the
change in question affected the binary.
Note that .modinfo doesn't declare 0 VMA address, and if one sets it
as .modinfo 0 => linking fails due to overlap.
Thus yes, my naive understanding is that presence of this unaligned
section pushed something else to start on an unaligned address, and
that itself was not padded.
Or maybe strip doesn't recalculate things..... but then is it really
strip at this point if we want it to move sections about and
align/padd them, sounds more like linker script at this point.

When I look with objdump at two vmlinux the working and non-working
one, they look almost identical with nothing standing out. But of
course I only see the top level pefile

Possibly a better way to do this is to indeed have dedicated linker
scripts for uncompressed image with extra metadata and debug info;
uncompressed image without extra metadata/debug; compressed image with
debug info; compressed image without debug info => as direct link
targets, rather than link - then - strip.

>
> > However, if bzImage is not further processed and is attempted to be loaded
> > directly by EDK2 firmware, it calculates unpadded Authenticode digest and
>
> Could this affect other bootloaders as well?

Yes. It can affect lots of tooling that works with EFI binaries such
as signing tools, efivars creation tooling, parsing/wrapper tools,
bootloaders, and boot firmware. Given how niche all of this is, and
because the majority of EFI binaries are padded & aligned, it is
highly unusual when an unagling and/or unpadded one is encountered.

> I noticed this report about
> rEFInd and pointed them here in case it was related:
>
> https://lore.kernel.org/CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com/
>
> > fails to correct accept/reject such kernel builds even when propoer
> > Authenticode values are enrolled in db/dbx. One can say EDK2 requires
> > aligned/padded kernels in Secureboot.
> >
> > Thus add ALIGN(8) to the .modinfo section, to esure kernels irrespective of
> > modinfo contents can be loaded by all existing EDK2 firmware builds.
> >
> > Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
>
> I took this change via the Kbuild tree for 6.18-rc1 so I can pick this
> up for kbuild-fixes or Arnd can take this if he has anything pending for
> fixes in the asm-generic tree.
>

This would be very appreciated. Thank you.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 8a9a2e732a65b..e04d56a5332e6 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -832,7 +832,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> >
> >  /* Required sections not related to debugging. */
> >  #define ELF_DETAILS                                                  \
> > -             .modinfo : { *(.modinfo) }                              \
> > +             .modinfo : { *(.modinfo) . = ALIGN(8); }                \
> >               .comment 0 : { *(.comment) }                            \
> >               .symtab 0 : { *(.symtab) }                              \
> >               .strtab 0 : { *(.strtab) }                              \
> > --
> > 2.51.0
> >

-- 
Regards,

Dimitri.

