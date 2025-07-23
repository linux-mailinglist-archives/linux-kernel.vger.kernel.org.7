Return-Path: <linux-kernel+bounces-742118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F495B0ED81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2704316ADE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2062258CE1;
	Wed, 23 Jul 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q+sheZCQ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C36AD23
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260232; cv=none; b=Jw6LlIm2ORZ2A2MszkeJiqFjoU4zY4JJQB11ZeNYkf7bF1RRHG/AOLxRXMdh0hqImO6/rkYCrRP813azcfb56tYNrD4LkcYSMxjgZUsHqiuhwzX75IyJBDNsnpFoMlWJ4sFQamNoW0vZBk4GL52HiMZqBZucyGT3hjZZhX27Dus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260232; c=relaxed/simple;
	bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQUGDefmAFD/OO4csCQSaxfNG2rJat8G0aM1GVakNp+BUjRsuPuKOBz9VdBBNt9aXO5BsK4LixStM5yDMBW/CS8YrFn3L4Qeo7Hlw+gNEFExXjyCwP1Irc+jwtFzXXSsWL0TLTDFvn86J1RtV05ANzWc7lrxtK3BgIQix3y1uSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q+sheZCQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so58035851fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753260229; x=1753865029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
        b=Q+sheZCQ6hecARGXA5vlJ/+cM/zS8w5QM6SKxxmZVmjqom2JvKJQCdG8LxeL3CkSOy
         jBcOV9GJxxWnwZ2MG87fzzLapF25tGjRwNVzkvseA3nCrFpSU7us1gTwvQyarTDoZLsJ
         DLH0WfzOaqzMlM1myHiznGh/bJWuEeNFttpEyqd6VxZzEh8rvvHMLTces1MaM7YJHOm+
         uRRRYLCTlq99VaFQcZcPYtt0thuV7Kjz20ERDQDDaQJwx+CSkPEsmgpwo03EDI614gI6
         M+HROCRsrxLwXfNYfSxG5xcBdrxUG5NsqYHHt3QT9EHiraaBpNEULnpQlMlXlGVwMIMN
         ERDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260229; x=1753865029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
        b=Rh5l6BBFTEx+ng95ePiO15GYdOWibUXhmm+TU2eCl3iZfV44SQxvoUJI31lSyZphnn
         rUmea4eGUeN+w8HXa2bE12ZCJdnErerKFw4kRH31vjUPULju3z18GF1qdATHvJU8Thgi
         10CT5SJqVeAtVIfygGjtPILI+LqZPiPppYx41ap2sRZeBH0ZIP7MtuDb3/qk0eb4xeNn
         JPFilkEaq5SGLPKQaG8Bw52ybt3RCuNMWkb1yD3Im2Ulhd/Y/ibqF29pQ5TowBXlDX9H
         gbGpgdN73AA3pEL66SIP/jt0YxgTOE0hZdRy5RO0uRSXyc6ap/W/RBLuFoodrLsRu1L2
         hG/g==
X-Forwarded-Encrypted: i=1; AJvYcCXCtBdjIiaKx95S/yArhLF7ggKkfrIYlZktVl0YCqZRjH2x9/LIriQZWvKrxpPqhwkV7OKdAKbi4h/DAcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzP12oUEzrw8FpDsVAKtWjZAaqML7AIaJuVWCrVnBQSGiypEN
	0knT8IYKsp/IPZYMRdUPcSzcdxtml3/a6vL0W4MdxEc114DjgZvWFnwx12su7kqtxIFAEx3KZgA
	+FB7kwLZxmtKbqInB8vvwJ58S6Nv7jpR59Fy0OLim3A==
X-Gm-Gg: ASbGnctTbYNJa+AMubbmYNInCbm1CxsI4Pg6Tg+OOdKbXRkrbYG0/XLVKKEFLwbtaeZ
	+/JDABKZcJAdT47IPQCVBe2KPENjUoGL2HvQ4s/gU9D4J843V+IfJyGfP9YfzAyzyjUfS9HC9/R
	eDx635Hh8guyYZM9sFSLUTgL7bpDQOgWkeAjl8lQ6bfh/zVRBwD6P5qvjtTji4mxK5aICsQuiYZ
	f9pG+bBkQJiWDA1e3wkEhaAoCEUmZ/FGbFqjg==
X-Google-Smtp-Source: AGHT+IHAFBrQohHc/2BHWRgsaNp0FeUIp88x1fnp5TVgXj36+HqgTyzHYQ9aaWJAVlgJBvSW2exqJ6lon2LfY81mcuc=
X-Received: by 2002:a2e:ae18:0:10b0:32b:a9a4:cd01 with SMTP id
 38308e7fff4ca-330dfd1fed3mr4451231fa.29.1753260228769; Wed, 23 Jul 2025
 01:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
 <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com> <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
In-Reply-To: <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Jul 2025 10:43:37 +0200
X-Gm-Features: Ac12FXw1wjrtcFNe5Jsgn2117sH2qWPQ_2KZUL5ZF_HLG4DNwY0V5wirW6Lk63M
Message-ID: <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Jul 15, 2025 at 3:13=E2=80=AFPM Thomas Richard
> <thomas.richard@bootlin.com> wrote:
> >
> > On 6/25/25 10:26 AM, Bartosz Golaszewski wrote:
> > > On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
> > > <thomas.richard@bootlin.com> wrote:
> > >>
> > >> This is the eighth version of this series. I just added a missing he=
ader
> > >> file in gpio-aggregator driver to fix a build warning reported by a =
kernel
> > >> test robot [1].
> > >>
> > >> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@=
intel.com/
> > >>
> > >> Best Regards,
> > >>
> > >> Thomas
> > >>
> > >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> > >> ---
> > >
> > > This series looks pretty good now, any objections to picking it up? A=
s
> > > usual - I can take the GPIO patches and provide an immutable branch
> > > for Linus to pull.
> >
> > Hi Bartosz,
> >
> > When do you plan to pick the patches? Will it be ok for next merge wind=
ow?
> >
>
> Well, nobody responded to my last email. This is a cross-tree series
> so at least Linus must confirm he's ok.
>
> Bart

Linus, I'm willing to queue at least the GPIO part for v6.17, does the
pinctrl part look good to you?

Bart

