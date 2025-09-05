Return-Path: <linux-kernel+bounces-803923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC4B46757
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC04E1440
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A829E0E5;
	Fri,  5 Sep 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="du229DAA"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2A54654
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116678; cv=none; b=mEJxS5r91jP0aMYlK2mN8+iYR+lQd3oVJsFc9FVZqF2/8NxjXQWneO1rSsHtzdx56Z/jb6Scc/yuSwmojqTinmuQl+yq2yy9rCz7Ui2K0/+O6/7V358Xu+zi0li86qD+FgA6f8Q0zMBECN7XGp+kWx4UQm4n3UQdQ0bi3Kk5Jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116678; c=relaxed/simple;
	bh=X6FjyOREsMiWyTGUz8ui40PctBG9QEdoLDLoZRzJHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByvaFQrkEj/GIM3raB/pT57g67DlQ6b1ST8k5nD/tmqzoC25wfK+6CWMhHLhQ4jM13YmDv7LHLIKCjrwdAs4OfS+CrhG/46K5eC/iA+uuXc5Cqdx2lQJot8FLxPoCjDzhbCnrZaBjRxRDOl6HJmxIcFmPlkyvT4/7yG1zKZqq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=du229DAA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32bab30eefbso1869222a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757116672; x=1757721472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pLX9mNLE1Old2BsaUGh3Hjem0q5L//LE3ZX0hufywI=;
        b=du229DAAvQOu3vOcwWBT8hUJItdDuhzsN4tnoOuzKcCkpFwYXEG47624E7fqEYo93V
         QwCz/uZbAi99H2PbQO0aONIEvPblougu53N8DNoMuBhJUxacINbXmDqr5H3SYaE/VA9a
         XrmdpAqNz1B9K0DNqfELWWCbBBdIOMvi8mf5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757116672; x=1757721472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pLX9mNLE1Old2BsaUGh3Hjem0q5L//LE3ZX0hufywI=;
        b=Jdtb6Xt1FGfQr1mTGnC/I5V/o8Jo/ujkUTGlPnuvMGI0BxDvpVqPkc3xQ7VWUC1gG1
         5d1Qh0Ir+m4rfGpsfXPxJ+q1Y/OmJFklHrhx8JOJ5jTgHth25xF7cl3qVqyVXFrG3uRT
         gKGpq72f22tGRsMurfyh1x1jBDARpx5g9wvMuT0SWMqzvPrEnzG2LIE1Mg+nwOzjxEUT
         nF/ZDtePfkLGZ3kyyA3z4fC7pfbl9EoKYRV96DL7F6nUqJH2ljnO1ndBDHN/pqM7YRNb
         QdGgIqQvY2leT3/1cL3CJr8lJVAgl2zI8IP/uz+NV6yCQOzvm3me06kKkuH25fmP+1+C
         mqow==
X-Forwarded-Encrypted: i=1; AJvYcCV0vdmGpbiLfMuvGCpb3QFJJjOTg9X2qMEi9dJKucHwgCFSJkD4/zKiD7jNlJtu+k1ZHKMmQ+UJRepI0P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq77cQmO4Fpql+UFoSllEVyF1ohCYPTBi9VgiojgHhKalJrqVv
	OWAPvyC1H351cBdI7t1RLcTBi2VdRNg0RwSrAPNV4du9/cdexzrjh05Z6yR+fpweQYJA95MDreU
	4dkY=
X-Gm-Gg: ASbGncvFMkvmclwQTYcEOKjv366p1d1cQtD1179XWwUxiG4bBAd310LRSKqme+H+fJk
	suuQvaq94UVZGrzPn9SK3xqCpBEYxi7bARVTdBM64FbmIP8lDpYJdSRadTgjEA0+lCnOgIEZSkz
	RUMDDj0pdoHM1appoK9FCa5vMVSVNc6u2mwtIKEhjECj6ge9iEairv2OrUjUNYM6MDNU7Yt0TTc
	qMD2ER7HH2E6dU/rQYsfVY1nm7YpBxyO5quyWXKmZIDMkB/INjyYgG8SrjIKzPW1crKHJFw7yVE
	pMfa36bSX5g810yoAqS8GOuYsJDruUkgP0D/vXHpam/mLdYWMD0fbb8MlZLMAJJNPuWHm5UWGyH
	xZ5NxFAI+/bX1UAlN+/Ig7TAtcvPMcRBt62zim2ckhBehmxkJIRJbxcBK6KN/IACL/g==
X-Google-Smtp-Source: AGHT+IESo/Ap99F3dl2l+3gXoSdN/nvhYHnFjx0KVXaikXb0iowCCU5U1xn95qQVtich75bdgJ19Og==
X-Received: by 2002:a17:90b:1c08:b0:32b:6959:9a84 with SMTP id 98e67ed59e1d1-32bbe1040a1mr6421636a91.11.1757116671999;
        Fri, 05 Sep 2025 16:57:51 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e7186sm24360081a91.16.2025.09.05.16.57.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 16:57:50 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47052620a6so2679574a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:57:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWciDLis/cXdA2PKTSx6IP6HHDIo/Rn9Xjv4bsYtk2b6isyrw1RgiTeCJTIZ7/Z7zIdcEJ5SZZ04nkSQFQ=@vger.kernel.org
X-Received: by 2002:a17:90b:4fd0:b0:325:15bf:4dc2 with SMTP id
 98e67ed59e1d1-32d44f86e71mr623965a91.0.1757116669514; Fri, 05 Sep 2025
 16:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
 <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com> <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
In-Reply-To: <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Sep 2025 16:57:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
X-Gm-Features: Ac12FXzUu2N-pcZbzJSHRvrPWYA7cVEhjyHs0eCe7xSTQbillcbYzLxLmPy77G0
Message-ID: <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 4:56=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Hi Doug=EF=BC=8C
>
> On Wed, Sep 3, 2025 at 1:04=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Sun, Aug 31, 2025 at 10:57=E2=80=AFPM yunhui cui <cuiyunhui@bytedanc=
e.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > > > > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  arch/arm64/kernel/Makefile                   | 1 -
> > > > >  drivers/perf/arm_pmu.c                       | 2 +-
> > > > >  include/linux/nmi.h                          | 1 +
> > > > >  include/linux/perf/arm_pmu.h                 | 2 --
> > > > >  kernel/Makefile                              | 2 +-
> > > > >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> > > > >  6 files changed, 9 insertions(+), 7 deletions(-)
> > > > >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
> > > >
> > > > I'm not a huge fan of the perf hardlockup detector and IMO we shoul=
d
> > > > maybe just delete it. Thus spreading it to support a new architectu=
re
> > > > isn't my favorite thing to do. Can't you use the buddy hardlockup
> > > > detector?
> > >
> > > Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
> > > you explain the specific reasons? Is the community's future plan to
> > > favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?
> >
> > I don't think there are any concrete plans, but there was some discussi=
on here:
> >
> > https://lore.kernel.org/all/CAD=3DFV=3DWWUiCi6bZCs_gseFpDDWNkuJMoL6XCft=
Eo6W7q6jRCkg@mail.gmail.com/
> >
> > -Doug
> >
>
> I=E2=80=99ve read your linked content, which details the pros and cons of=
 perf
> watchdog and buddy watchdog.
> I think everyone will agree on choosing one as the default.
> It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=80=94=
what=E2=80=99s next
> for these two approaches?

I guess to start, someone (you?) should send some patches to the list.
Maybe one patch to make buddy the default and one to change the
description of the "perf" lockup detector say that its usage is
discouraged, that it might be removed, that people should use the
"buddy" detector instead, and that if there's a reason someone needs
the "perf" detector instead of the buddy one then they should make
some loud noises.

You'd want to CC folks who were involved in recent watchdog changes
and make sure to CC Andrew (akpm). If folks react positive and Andrew
agrees then he'll likely land the the patches and we'll have made
forward progress. :-)

-Doug

