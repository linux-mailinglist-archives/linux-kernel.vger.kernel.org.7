Return-Path: <linux-kernel+bounces-787578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101AB37839
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD11175684
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0B2D0274;
	Wed, 27 Aug 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O15W6Ajv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FF2773F7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262483; cv=none; b=Lu6Lac56N2w2caaYR06dQz3lRZYYbKb7t/0XTtJCuoFhMkxXx+zwar9SCyoLtjygOxUuaBc4repFW/Yq1uXZDXHQVCwtRn2amDERhnMKiAbIiPibirrhfXfWX8mV4thjxYnfGCuqjdDVLtSx07o4AtoPRaCeYk/zrHSxQwseguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262483; c=relaxed/simple;
	bh=tGB21+KeiOGIRb/mkNVHXqw7dsiXeK8y5OMn7Rxp4yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikDPKxHqUUC+bZFknygcsgm+DjyrQ3x9kVpvtT5ggiZK4se2uURrdcSRNCpWKTyRVBSOrrtxk03X85oqLN5gtzCL9Vr/24631mq5slAgwRxCSx6M9Mtn+cv8yGdinr15+C1Ai64gIoROvsD+Fypw9K1itaBkZCp84G9JLiZUlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O15W6Ajv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24639fbdd87so4346415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756262480; x=1756867280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjxEgqnJro7lL9LezaBDUakZcT0q5OR/PsDrwklypb4=;
        b=O15W6Ajv28IMhMGIl2qCL10KU8h/lRbkcpGYvgP57VsaAC5jojOjIew6T6A20MghKw
         /O+XVOamRhGbQDkQq041r3PIVuRSO3Baj2gHSC43FwWQlG2mp2WetCNlpyUsf8oFUyK6
         lTLV1vCFgoVEouLhuSzfoD6+HyLlr4JWGxMch9nloziS5aF4jw6+PnjmQhRjF2Au21jf
         +Wju8Bb2+HmUbLv5X3kCsQuZfn2X6X7IcAjQ95psuSi13GFvS+kETsh2w3PV17xSIcvH
         985lgDTxwBZ/5kI22VkDZeVQMxaq8X9cbxqMjJJSABIM3c611o4DvNu5et6MU6nZPJc8
         BZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756262480; x=1756867280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjxEgqnJro7lL9LezaBDUakZcT0q5OR/PsDrwklypb4=;
        b=ReGUAw/2AMbfB7eRRH1lhkbMfEfCCLZWTOWQVsAYnzoAWZSywgDz+Rx+L4dymwERIS
         mccpMPeEXDSPi7YrI3Hpi1eZcu4KYO2TCRwTrlaEUQG8/FjkzMDC+U2LNGP9Jaa/KIyL
         Gp9RZLao+Ch4xHuvVrsQQ+SuMFpUQQ0bfm2jWNH5nvAF6MD9DSNjVrcfaIuJmBlQn8lc
         WcpJs8CNsd/D1PcuPx0v2pV7yONsulf2RnqSZABxKmXF4kqQnlylMVC8jAmcaL2SzMF/
         le0sqXfzBF4M5Z+dmdrd+1Ey0UyJ50LiI7Z+ejPuv9dWDM/XmPlcLl2ZaDrpmcezlO1N
         QSJw==
X-Forwarded-Encrypted: i=1; AJvYcCVHUYrTmORSEMaVHmzTe6pA/o8ogtWrc1ag0+srZ7ACiORU4siKAA4XJcwCoNel4NtBSb6Oq+YE2gy3Mxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0LkMkyps6ah9g0LREy1xfwkMwpZABlQ6SD4utDuntQFQVGpP
	+We2iatAVo9ejCC8sSUW5/XX7ePa46/WljY4fUudviCs2nJkdXsHWLBtamOunuJ1UgAvc15TaCR
	31nZ3m7eA0PcVTiZn6KQDcUmJScgFXuEzPLOoyT1yXQ==
X-Gm-Gg: ASbGncuYLAIjpzfTUP3GUez/JW17XtMf74Wne/YdBvxLp35FH2LqnBBnAzQ7HjMR5+i
	0GImjKQN55IY0+DI/OvIr1mnVl5mgxKjS6o85cJak1ZGfKFgJkh99Gji6HUdcyCE9UhyXyygjMh
	C/2s6vjbHdBzpWxZ2hs4g3QxWJl81bv+hZI76m8sRt+zuKENiuTRCNwnbkq1gE/L4Sfi/oV59mP
	F1WRXnihaubNfUdTbxWWhSr9gX0mlEz56TX2vC/vY3r4qGXHFq2rAQG9S8=
X-Google-Smtp-Source: AGHT+IFPzhubzZRBaSf6ZK7EERQAGuZTZeLwtvw9GV2o/YId4xoUhbtPFhevcDJ7OY1DRqDVEbOGIVoPvPf8Q3kVeug=
X-Received: by 2002:a17:902:e548:b0:234:9fe1:8fc6 with SMTP id
 d9443c01a7336-248753a2436mr47264125ad.18.1756262479947; Tue, 26 Aug 2025
 19:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
 <20250826-dullness-seventy-c93e7c8479d0@spud> <CAPYmKFuZ5y=q-tpmgMzGFEy6y=UPDf5vLg4gS8VAEkAKBr6BmQ@mail.gmail.com>
In-Reply-To: <CAPYmKFuZ5y=q-tpmgMzGFEy6y=UPDf5vLg4gS8VAEkAKBr6BmQ@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 27 Aug 2025 10:41:08 +0800
X-Gm-Features: Ac12FXywUMzcZzcq7obnXHI4n0aD8CBNXv6CPZzr0eD00j5rqXvalTtJvc8l_Wo
Message-ID: <CAPYmKFu52h_n_NkD=LhVscjp-RWvai8eAO29D=ZXTtXgB_Msbw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/4] riscv: Add Zalasr ISA exntesion support
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:26=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
>
> Hi Conor,
>
> On Wed, Aug 27, 2025 at 1:46=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Aug 26, 2025 at 10:57:36PM +0800, Xu Lu wrote:
> > > This patch adds support for the Zalasr ISA extension, which supplies =
the
> > > real load acquire/store release instructions.
> > >
> > > The specification can be found here:
> > > https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> >
> > Why is this an RFC?
>
> There is still some code using fence to simulate real
> load-acquire/store-release insns. For example, RISCV_ACQUIRE_BARRIER
> and RISCV_RELEASE_BARRIER, etc. I will resend a formal patch series
> after I modify them.

Or maybe I will skip such code as they have different semantics with
load-acquire/store-release as there is no need to load or store any
data.

>
> > Is the RFC tag related to how you have not CCed all relevant mailing
> > lists and maintainers?
>
> Sorry about this. I will recheck the maintainer list next time.
>
> Best regards,
> Xu Lu
>
> >
> > Cheers,
> > Conor.
> >
> > >
> > > Xu Lu (4):
> > >   riscv: add ISA extension parsing for Zalasr
> > >   dt-bindings: riscv: Add Zalasr ISA extension description
> > >   riscv: Instroduce Zalasr instructions
> > >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
> > >
> > >  .../devicetree/bindings/riscv/extensions.yaml |  5 ++
> > >  arch/riscv/include/asm/barrier.h              | 79 ++++++++++++++++-=
--
> > >  arch/riscv/include/asm/hwcap.h                |  1 +
> > >  arch/riscv/include/asm/insn-def.h             | 79 +++++++++++++++++=
++
> > >  arch/riscv/kernel/cpufeature.c                |  1 +
> > >  5 files changed, 154 insertions(+), 11 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >

