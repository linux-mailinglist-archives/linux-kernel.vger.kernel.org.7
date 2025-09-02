Return-Path: <linux-kernel+bounces-797075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EEB40B86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EE4E7686
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510A30F542;
	Tue,  2 Sep 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZtUX3G/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AA2E2846
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832650; cv=none; b=AC/jJE3Zs7Q76BU+qtsK/i3iC02SbSVcj3kluyy6VjvUixrFdxpg1mea6CF8LdRuit5bBgiX63dckO615nzit5WNZNTKhF33+G5kwMlcglZJiXdOdFtcR+viKd9jOTbgEvr8ziiNpUvVCVco7Qhf0ZaV+YdftaYo5gzx7pnmitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832650; c=relaxed/simple;
	bh=oHgHxxly8fLr95F3sY/hL1w7Ojsj5GzmNbdH2vURWZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVUHV70Jywa4r1f3DouJK4zYxlQBmhcbu1eVrZAfAL5HL2FH3u5PU5XTXLy6juVvDtwrZIKxEpwJXj5vbe8PViyPtko5B6QmyQ0b4MZ+0ruDZQlcWuNRs3LwNQF0JgU68CIb0BOHkXPxe18lPYHa7/RtQlNbvMlrD283CJDbrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HZtUX3G/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24a9cc916b3so26578325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756832648; x=1757437448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7Rb+Gc4bzsX0WrGoFt7okZVsdi4ux/eNHzNp2DsalU=;
        b=HZtUX3G/VC3G5hAWJWxyunMBg06R7O0CRtb7UTuugbuLL7OoRbQgVLEAk+p+rGG7bG
         BVyFePTIeN6x4KQT4nc7nhzwYZxIX3shO4uVrPDniEQTxIXihgJb62DRyjGk90u312p9
         77HK9UVYBOL5CQCO5VcTSGNbexZOUQipkW68E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832648; x=1757437448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Rb+Gc4bzsX0WrGoFt7okZVsdi4ux/eNHzNp2DsalU=;
        b=hvaeJ9OM+8MIeCwEUwujN4Ou2MVDXrixo7u1PKQEyVNsCkPuo1EOjCsJ2pVfdF8X+A
         QCR5yb26OCMNsBiydHWTpBzLHkKyqtgIr8JTyNmMJ/WbJHQzEwUWRAmQmH74h/qTchY6
         9PMemY2qJemuOoGbvU9vZeyggXCtepr5hozOxPjfTMSjlhDhBp59cb2z2cZv5Es3RGPI
         JuXqvt/XeR3vgXXVVnEBrIboiKlxWcByytfWVOT1cgGX4wVbzYjVYPW3yUO9lCgifjPg
         J6VKiTPtUdcasvbVFF1B4LLH6WNxE9tKZ2fKR6mIS/dahpwo1TNwC8ELBIyy4y0CQWoN
         1tOA==
X-Forwarded-Encrypted: i=1; AJvYcCULzYPncpbZuEvG1wti55YhoiaUwLeK+cHyD5FWbY/qrB0Do1+YVQHSiLvCUz8HgyW1TB5/iQ+MYLdnnZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ordn2z02UvuXOtPoPR6F98KtjKJ13pQShh9nCYDysAqS+E2B
	mYDEbu6ex5vaS0+o9ZOL6rPIbndH2Rmzj2tYCOSnIArsJXGp9l/5sQ9XujoXSw/HnSQHxll7Tmy
	php0=
X-Gm-Gg: ASbGncu6xECGC5HlKi+yhrGvPWEXDoVg2to4mAbTWA4y/T5XDpPCrSDxCHqixJvC43N
	xnyLaAtIKoT5J9kN3g5HMVOAfQbA9DlyKpSLo5uYHid2WH8PYoI6i6N/VPJJ9LExVuMlmDOcLhI
	uoZBTsKLi67W2TZK5S10OaFUev41oYX3TWpjRZMgC0DGt0dhigI3kgjudqKV5rXPl70Ns7OwGq6
	0XzfXvqvrfVKS1BuPITX9EayaYZUzjAaH9xjO17jNYgTJiI5cYczdsnhAMbRCPf95RxV5e9BhZq
	B1PDVaYKn8gz2nzJU8/u71sRT3KJr5xbEDPt7Z29v/eZTfaZ9w1jBTVLCF9zMNAZuLBRItIrGZ4
	FRLWFcMEWJbg5AvuYjlD/wi/ZdhDDuWGQtq3aQk/ltt+W7oupC2cil4brjrO5bxvAYA==
X-Google-Smtp-Source: AGHT+IH/dXFQSMEx2IMR9F0UCfQCe3hLpF9LL1UmiISbq52vfkoP5vOm9k5UZqsAksktRhCR0AaHbA==
X-Received: by 2002:a17:902:e842:b0:242:9be2:102b with SMTP id d9443c01a7336-249446d2e9dmr150719255ad.0.1756832647958;
        Tue, 02 Sep 2025 10:04:07 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906395cfdsm138203045ad.101.2025.09.02.10.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:04:07 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7724cacc32bso2127101b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgZTXpLS44R9euFuHZi/m92M6bNUVo9qYiPVs2uAD6J7+/mQsXvLWH/Y5AvJQln6GwzSHJprq2EoAL+2w=@vger.kernel.org
X-Received: by 2002:a17:903:384b:b0:240:84b:a11a with SMTP id
 d9443c01a7336-249448f24abmr161721465ad.17.1756832646700; Tue, 02 Sep 2025
 10:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 2 Sep 2025 10:03:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
X-Gm-Features: Ac12FXykSrYm05H2zP7oRG7JrK-8ugSYBV29nSAU-8Tvd7BMAeSBbf3oz6aTBn8
Message-ID: <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
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

On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
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
>
> Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> you explain the specific reasons? Is the community's future plan to
> favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?

I don't think there are any concrete plans, but there was some discussion h=
ere:

https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W=
7q6jRCkg@mail.gmail.com/

-Doug

