Return-Path: <linux-kernel+bounces-830803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A94B9A935
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972672E1FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C530F55C;
	Wed, 24 Sep 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IUtPtt4Q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A752307AFA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727356; cv=none; b=JRMepZxe9Nq0wv8UJmtbf4LKYX9PHvyKujJZu+H+3xb35qEA2IR6Om8Vp9Zq1jn8BEf9RqXeleKtDPc8caG5W9JChvN3WtYKQfXFlFH38W1ykqyQMpvai4BHP1zV1sfREPxfzDdrdjT4enGJ4zkHGWYBeLZ9tJ+M30GtcUNUg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727356; c=relaxed/simple;
	bh=JsPnfKtr3MiLoJ8hsPpReBdY4CePyEpwU2RLe/kafMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhUj2dte10LRmUKzd6wls4UmnOsjtt6WbkvYdCAdldtGt3z5p3fZFTvMTmWGAMQ3dfn9uErKRhu7dgcaPy/WLRbazNhLDD6Hu6+zaduXgG30wVeGt6kiipWHcjKdVaUMwnznkzKp4ugcdJkuaZxgeQhLlfxQn4BFGX584cIR17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IUtPtt4Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f581aeso68783415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758727354; x=1759332154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGkkH3On4e9g/uKbOlSYkJKHveGl2HpttCc7mFGVIhA=;
        b=IUtPtt4QMF4dmK6apSmFMwFJuhKA57iGeFW37hTkKPyLSnPXMA4CwRwHc31TOTREin
         Ak5OjSWLuEIQ799KRxh2bYPfDvRzOeO2Rx8DjNWh0QIKfynsnI5ZfDXFUArQM7atArJW
         eR3nGYCgqNGPYREYqHbL6eu9M3d3Tc/FZ1nRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727354; x=1759332154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGkkH3On4e9g/uKbOlSYkJKHveGl2HpttCc7mFGVIhA=;
        b=lMhpCxEjB13CydgT238VdjhSa27q0uhzBL0ufxmcYIwoJMnJu5YGwfsmKaF9oUVR25
         Lt5k1VH5wSR3AbgiyJAoTldunaZ0lAV5/IkfH/4h/GG3veH1mAfov0DmyXys/3Vz8GWu
         LoMQaSdOYNI9SHQ2ERfVqNEqVIc2yJ3B6vGT1l/hN1kHW+DAhAGz3gSSoutzj9QOij6g
         k9+p6+iSZNnfuTXVBz57hudEkiMoXFQFLOb5xrs5eglcH4hBfbpC/xGxvIEa3tEbAtAl
         eul8YIYeVwz+Uvtv/dkJM8tZxqBUvoNPmOBEly8M2YYNuzlTDKYGHciEfbKJIl0y+dAe
         mw+A==
X-Forwarded-Encrypted: i=1; AJvYcCXrUHvfU1zH9QiltKkAADwLXCcwiQNRIyDzu1k/T2Ajfof+cJzTgpOZ20cR58tgKe0eCpv/61IFmGAVs3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99tMguYzhj1QWYS9ulJZiYJmllIj8HH7Bn0BKEMbnNrPSYILG
	xFUYFi19kTolfDE9KT3ztxGSMu5etixyWgOhNs9zwAvb3zv24gknvRZfI0qVHln7hgo3c++iMTq
	azNY=
X-Gm-Gg: ASbGncsMRNaXkz/+Ec9MjqKgWIT38759Erc/RcSigNLEN2afTAasMcylwCMLK9jJfpL
	GWbJuEO37xWcNMXNBX8x2gVS3UrHjtKQBp6D5BpZJ8tBLs0NknYyNvIEYzLeEmC4Jd/DNZ3Y8WV
	lCo7fYpMuwC6mMvjwI/sxUQI7E4ByheFM5XpLEWGi8yKQdUFJLLQHHDfQPbfSY/h/ssfF8jyICO
	izNChZHNcM+zBW9z5fdFwhTWDpIjjapipr0+TCm6vbzKjk30yBuLoE8/4xuA50og8lDuNc89+9c
	OZdZXHbK7w9BDtPQGkpRXa08lSXBJGdf+iVmSfdAjGvkuRoT21Fvx94jDmM/1pg9+53WuvLN45x
	j0jfHPrxkdg7xzqqqDzhH5z3X2j8TruemLnODUbpid/jBWSGTusJL4PTLI0213674wA==
X-Google-Smtp-Source: AGHT+IFtBuJw5MP85/dd3tQ5nJplmFbKn/eWqgTz0d8ei8HzKGKOM5ShOy/XFjp5BlkJZjARj+PPPA==
X-Received: by 2002:a17:903:acf:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-27ed4ac2af1mr977145ad.40.1758727354465;
        Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dd5sm195573185ad.26.2025.09.24.08.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27a6c3f482dso26823515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF/L/IMfPW7Y6uJntXL0D58pw22hso3N1xLIEXRzGNZvaG6XojYPrzmlLJUJBm5tDO8qUqaHznT34AQVY=@vger.kernel.org
X-Received: by 2002:a17:902:c94d:b0:278:daab:7940 with SMTP id
 d9443c01a7336-27ed4a3dfa8mr1337745ad.17.1758727353184; Wed, 24 Sep 2025
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Sep 2025 08:22:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYGmayve1ujv9oqRrJaq-D6g7pRygvQf31WfEMsT3g8Q@mail.gmail.com>
X-Gm-Features: AS18NWDf2q3VkrTezxWiqMq5MaW03lcJwh8tH3BwlSFCZCG9Jd79C5JfcXHF2sY
Message-ID: <CAD=FV=XYGmayve1ujv9oqRrJaq-D6g7pRygvQf31WfEMsT3g8Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: yunhui cui <cuiyunhui@bytedance.com>
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

Hi,

On Tue, Sep 23, 2025 at 7:41=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/arm64/kernel/Makefile                   | 1 -
> > >  drivers/perf/arm_pmu.c                       | 2 +-
> > >  include/linux/nmi.h                          | 1 +
> > >  include/linux/perf/arm_pmu.h                 | 2 --
> > >  kernel/Makefile                              | 2 +-
> > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> >
> > I'm not a huge fan of the perf hardlockup detector and IMO we should
> > maybe just delete it. Thus spreading it to support a new architecture
> > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > detector?
> >
> > That being said, I did a quick look at your patch. I'm pretty sure you
> > can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> > hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> > powerpc)?
>
> After discussing whether to remove watchdog perf, it still seems
> necessary to keep advancing with it. For the code, we just need to
> decorate hw_nmi_get_sample_period() with __weak, right?

That would probably work, but IMO you should make sure you can figure
out how to at least compile the x86/powerpc kernels to confirm.

-Doug

