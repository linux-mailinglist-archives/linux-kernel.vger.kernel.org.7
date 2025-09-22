Return-Path: <linux-kernel+bounces-827955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8BB9384E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF571890156
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611803128C4;
	Mon, 22 Sep 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zi9IkOSG"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D392ECD15
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581375; cv=none; b=NZ5m0mMCCO5q+RFD0khDw8gc86elBMPt7FnR8bdqrvQTh3TcX4d88tMoa7zAxxThzna9NvMCN65nxXv/XNIBpZCtLMvo1aDoEPMgK01PQOkprxr0eO9lmIb8qpYgDA9SY1pE4nICotKcqsBFqD7qNINUx3MZ7kDPj4NJ2wHhbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581375; c=relaxed/simple;
	bh=vxbBDavBTBnuvF8f1Kx6iKiRWJW4b34HKAfgxk7htsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9Bky4UU23p/bi34N1VDtCgvDgYcUaA4qw+Zd3FjgOvH6/eHlYzqkv+hWx5ix3Zp7CipHEP6ao8C0A0hQ6Sf/WQrJk0YyCDwoyIKDzsEqFnCHcX6Km0eOhFowGqwGGFoxpgkAwiUYuE3hWlZ/mnCsNb4npZJJDPI86HxcictAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zi9IkOSG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07c081660aso893278766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581372; x=1759186172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF7n4MxMlgN+yI/qlPr4vsS5UraBfXpeEUdNSal42Ds=;
        b=Zi9IkOSG9oZjFrd4Tm3OT0lBqYon8i+8Zk7vHG6aaSKyMRuFviiQYgnmsZ1v5nt+EY
         eNLmOz54WBNReHY8eOXDfTpZ6+FYupVpv4dpEbBQLjNJR9SoF8ojhsNeLUU0E2tGNSRE
         N3T336ChUFsOHRAT2Q11sORg5c/Z3e6jZhC3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581372; x=1759186172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hF7n4MxMlgN+yI/qlPr4vsS5UraBfXpeEUdNSal42Ds=;
        b=FpzQVepzc1NTcHuVVWRz5xPJtPaZqD8YaURtkt+tcD5r66plRqn3Rjz2aTBHC2FPxi
         7D/1M768aPeXjI1Qbv0WC5SNhGfFWPo/wOQ9HS5fnV8C/OKR0AcG/1c0FNSmAmmItkNh
         VsOgRLI9ji4SGOxoeQ80AZPKxSKDqGYMH5pim/apIjgvKIuaKb1gFMLwMsHG8kU7kUhg
         SRo6ya2ZtDLUZUxTQHVWez9xopmMmUsSIRPN4AtQlrER8/0XDP6nc28Sr8aIG6a1rJ5a
         CAhcwlqQBI5fIiQbkn0344OhFDkgUCUeVqrfRJMpk1SAur8ZNbmt7kYcZNsTE/rv1JTx
         5ZZg==
X-Forwarded-Encrypted: i=1; AJvYcCW/F82DJLisNn13kVSe8VD0HnUFFOeB/C3nck7UgUFE2T3OMNEIWgNRa3ZIJdBRnbAOfWdtZvFYt2ymGNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFJXMblTlOHcPgUZMAwMmCoOStHt7/tgkVARKNUBRL3b1Jo4+
	ExAeu2Hp22gC+8ymU9EsDGi20OlPsm4NTyThjJJcXh1FQrLkXF2GTnQr2B8G3CUXQ6B0R3K4jYj
	A0uCemZzWizxepNHPQq41NHecD2h0xqQtR49i/gz0
X-Gm-Gg: ASbGncsPb/REPtYeN/LBoVSNZEIuRaBh3cRb9Hkay7+kKPSDx92vMbFSPZ0cgJLs0Qj
	W975qHQUPYIsn8PQWADz+T5N4YoCYXvtbRv3si5TKcLz9ZgFlPwJ/gqppLa+HpU1CqFvxPcmROg
	NaS6FM6+2GaJrj/0Zjt3VbJZguKHS/0yYcUazCIE2PTpgqMXIt5+fygj2ALmmcf0y/WghuDJ1XZ
	Ozunx3p
X-Google-Smtp-Source: AGHT+IHbZn5OHKIeP1nsOAwVTqRzYRAfH9tmRuufJiUJb0Kj876VvOf28w57UjKHjpksGXr6nZqyuuLgkcwi7yyxhJw=
X-Received: by 2002:a17:907:72cb:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b3026c84e0cmr28141466b.20.1758581372388; Mon, 22 Sep 2025
 15:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919224639.1122848-1-sjg@chromium.org> <20250919224639.1122848-2-sjg@chromium.org>
 <aM_T9mtmEdAGNpLi@probook>
In-Reply-To: <aM_T9mtmEdAGNpLi@probook>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 22 Sep 2025 16:49:20 -0600
X-Gm-Features: AS18NWDs90BMyBNurGn6-wf-BQsjRp3Qx4vhBwf3ekxo6QmIQw9nCTDVVqaMP0k
Message-ID: <CAFLszTirQa0tt91aa1m8x3j7_m457F_5HkAD0b22datwZe11rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scripts/make_fit: Speed up operation
To: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>
Cc: linux-arm-kernel@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi J,

On Sun, 21 Sept 2025 at 04:31, J. Neusch=C3=A4fer <j.ne@posteo.net> wrote:
>
> On Fri, Sep 19, 2025 at 04:46:25PM -0600, Simon Glass wrote:
> > The kernel is likely at least 16MB so we may as well use that as a step
> > size when reallocating space for the FIT in memory. Pack the FIT at the
> > end, so there is no wasted space.
> >
> > This reduces the time to pack by an order of magnitude, or so.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> >
> > (no changes since v1)
> >
> >  scripts/make_fit.py | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > index b4caa127d2c3..904f45088978 100755
> > --- a/scripts/make_fit.py
> > +++ b/scripts/make_fit.py
> > @@ -100,7 +100,7 @@ def setup_fit(fsw, name):
> >          fsw (libfdt.FdtSw): Object to use for writing
> >          name (str): Name of kernel image
> >      """
> > -    fsw.INC_SIZE =3D 65536
> > +    fsw.INC_SIZE =3D 16 << 20
> >      fsw.finish_reservemap()
> >      fsw.begin_node('')
> >      fsw.property_string('description', f'{name} with devicetree set')
> > @@ -330,10 +330,12 @@ def build_fit(args):
> >
> >          entries.append([model, compat, files_seq])
> >
>
> > -    finish_fit(fsw, entries)
> > +    finish_fit(fsw, entries, bool(args.ramdisk))
>
> It seems like this line should rather go into the previous patch.

Ah yes, will fix in v3, thanks.

>
> >
> >      # Include the kernel itself in the returned file count
> > -    return fsw.as_fdt().as_bytearray(), seq + 1, size
> > +    fdt =3D fsw.as_fdt()
> > +    fdt.pack()
> > +    return fdt.as_bytearray(), seq + 1, size
>
> The rest looks good to me. Easy optimization, big win :)
>

Regards,
Simon

