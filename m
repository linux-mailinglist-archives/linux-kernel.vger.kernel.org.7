Return-Path: <linux-kernel+bounces-798431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B31B41DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337E8685703
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623A2FC87A;
	Wed,  3 Sep 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BHMuVxse"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DA1DB375
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900602; cv=none; b=FTIAjAbjDP5fvUqolxiPZkIPimPoYlTbXQUGFzOsyXSblH5KeLnug8dynCGuHe9DF/RvsNv3nyvLUu2pMjIIop3z3sLCf68oBhoJ3bNoEthaQIPkwgqFXc3A/nfE3i34qa9nZM89HynJrAHoeQLWKGAPKArNbzrYz83UlEVTpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900602; c=relaxed/simple;
	bh=QhtuA5fceXCkweMbThx5ayqE1iE7t/8jfmLDQDkaoMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyjOOyvFp5w4P9JMbRV1SJpFScmM8UqqemY35XKGCwK0omw9C8DnAkyUkoe6DoznojzfQ9lGVlmqVsJMXQxQXXv07+fb/hjjbN5l9dvMvYYySNRoEZI0MRBDWu+m44aC+3oeL7Fbll+Xm8oww6B9zUpE0I+4fbYzpPk7qr6kewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BHMuVxse; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-31d7119322dso56161fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756900600; x=1757505400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APKSuSS/fVxVxNIRz7xmQz/WCEFPilAmQiDv33UmZds=;
        b=BHMuVxseSQ1RlceO1M/8Pl/Sjh85pCTxqfGII7rCkcoPYGbNLeeKZe7yHEgA5u8dQQ
         iE0+YtM3iin2bZocN6UxoqArShW0lxf5R1E1fkcEb+l0qKg/2HmzxK6hLKIppCnrBrLe
         DUnsE3nqnXmgekXPqIJqCA2JTpEhU9bmN8gM9BBz0UFwETiOynawJPt0zF6gl6ug8kxZ
         MbgX8AMZOOYDNN7vKsZEcYw67mh37qd2jlt4K8aj3ZpYsX2pLO310qI3hHU8OoYyD9J9
         y2wkMsQ+5PXDHktbnIfzxEjgd892HfE4Yyn1pG8l1WKSjKd/5BtQ4cQ9kwRjPrfRPDWR
         aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900600; x=1757505400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APKSuSS/fVxVxNIRz7xmQz/WCEFPilAmQiDv33UmZds=;
        b=DrLUrwcY3b1utmcEL/RedjAMBXkrAlguvVo/9DT1r11NQ+cfmLmWAXGkiQIUrphCqv
         88aXlPHZREVb+UMll0TPY/B5paPX/2RdrfDVtGP7khzUFKIiGw67ZPXF4DDz2nanJg35
         p8dHU71BP9izuX1A2p8O+pf8Uroy0OygYVDvGk5vLjCdva5Wss/ySJ40p48xRNHsAe2+
         ms3ButWRSQ3kFToTHohbwTlmd275UYFYtz0BhZTzUwPhPqBdZiefodgk1T0xaIMpWuqS
         0L52cPLHYgSBAjmwvQH3yFBvqAbyJsazdZXmpekkBon7WbFo5kORRjBcwjBQpuF/TT+A
         DWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXj3DHjv9kdGtL236T67u73OsT34ARsN1otaCd1rkxnZ3Bfl2cfpPnlvfqqN0naQXFgOeyLxTrS2aD/Eeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLjYuWutXlijiXs0Cx3R5DdOneSzW7+R7zPcCkShxaGwX3HiV
	y3q8ZtETy/GMsgeBOIxbt/n9dwU/rUN6FIModZCUcsOOV2MS+JY30rLdj4ADstF8x8UjtP5ki8o
	jM00GHmbR7RdckpnWD0tCsgnufKGg9uHq4rJMFJRwLA==
X-Gm-Gg: ASbGncv7PofZuD3RVWJ5s5IknUmB+KaTHoGUennFkwEbQnct0xVlOq40ikyxY4ks7Si
	mLsbxGRN1YrIrDOE7Uuiui4mdevKppfbZM+pNv4klAviSShMu7h9ssGqHNGrp5bYwaGmmhgY2IW
	Oi9N/vUir70oFkT4P4GMo6fV57pV/eb9Beypdv1Br883VHzoQ2LiKdCKYpBG0KoLJ9lQfbMWatN
	OZTPUVNZKkGRQBE5OcKYZGtKvbROsI=
X-Google-Smtp-Source: AGHT+IHzNG/bae/flkHEvpbYr0cWRiFGYBcRlfIUCA0hkHWscwORrD9erXClVYnAWO9a+v6BZHjoa+d3ZcNUM1a30FA=
X-Received: by 2002:a05:6871:3686:b0:314:b6a6:68a8 with SMTP id
 586e51a60fabf-31963480bf7mr6232182fac.48.1756900599934; Wed, 03 Sep 2025
 04:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com> <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 3 Sep 2025 19:56:28 +0800
X-Gm-Features: Ac12FXxqD3B_4az_DfqpBxwMDURjxHr7LFapX1M6NDjnkBWeIMm-90QquXtdgEE
Message-ID: <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Doug Anderson <dianders@chromium.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, 
	mark.rutland@arm.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com, 
	masahiroy@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, mingo@kernel.org, 
	lihuafei1@huawei.com, akpm@linux-foundation.org, jpoimboe@kernel.org, 
	rppt@kernel.org, kees@kernel.org, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug=EF=BC=8C

On Wed, Sep 3, 2025 at 1:04=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > Hi Doug,
> >
> > On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  arch/arm64/kernel/Makefile                   | 1 -
> > > >  drivers/perf/arm_pmu.c                       | 2 +-
> > > >  include/linux/nmi.h                          | 1 +
> > > >  include/linux/perf/arm_pmu.h                 | 2 --
> > > >  kernel/Makefile                              | 2 +-
> > > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> > >
> > > I'm not a huge fan of the perf hardlockup detector and IMO we should
> > > maybe just delete it. Thus spreading it to support a new architecture
> > > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > > detector?
> >
> > Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> > you explain the specific reasons? Is the community's future plan to
> > favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?
>
> I don't think there are any concrete plans, but there was some discussion=
 here:
>
> https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo=
6W7q6jRCkg@mail.gmail.com/
>
> -Doug
>

I=E2=80=99ve read your linked content, which details the pros and cons of p=
erf
watchdog and buddy watchdog.
I think everyone will agree on choosing one as the default.
It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=94wh=
at=E2=80=99s next
for these two approaches?

Thanks,
Yunhui

