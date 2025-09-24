Return-Path: <linux-kernel+bounces-829867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6570B98164
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC25E1B207FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4202222A1;
	Wed, 24 Sep 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j2V5aZ8y"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F621E087
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681686; cv=none; b=cRZjrQFkIRLkbA0NzhTMk1eqMCvMZm6hPKrBue/ycSciRCS4W3eHgxH+/EAZIruwID5vwXhHEtky3Rw7QLUO+9KVgr+zuyGc5uFODCVnYAo5hzVwRbY2fiHfVgkea39lveIOpCOuGW1BDTSWGesMCjeUoRl6EQMGs9+Vf5l3QKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681686; c=relaxed/simple;
	bh=33wXjsIvKpnr07ANf4dsbUFwqzQfE0tjd9GeFkQo5dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsKNmIQ3vRCHLMDfDSeCN8umsqHzKacJPFryljO23w50Td8rU/shqjXb63prGWadsuHB6g1hxs4jBV29z5OtEF368yVrEytHaCRZCS0FbV/h6bb2qyhQMIshDqzN8Q6qEGvkfd4A2pRuNENFkwP4pA9otgMNU2xiQzl5fcLxhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j2V5aZ8y; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-344618b80d0so2176063fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758681683; x=1759286483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ7ZD4HOO6vcvN2jhvcYNuUy+e/nu1npqP5xs4E4kvw=;
        b=j2V5aZ8yMBhCfMo5ISfykD7gGN6yx8WMCaSuYJPBFLEWlio1CTj58WGzq9sAUph3QI
         D3FTsfvMz9XkJcAEeS4z6zesVq2Bkc1BFvYB8sLR0qqNvq9E/qyeazaQ5dvKgWsS5gM4
         9ARqO/5X4AdegKsHVjv9f7UlrLKGn4HtQFr30usWaJP8u0dXvZQMnOjXHb2+/opaOpKR
         HNYTNw9TYEOJl5KA0zxJjj1IFxb8vubrKWRvZ0DKKWONX/34NY2kYXmSnORFsOwuVdAN
         Z8a9MPvpNqKo9qxMHblozps2mjWViFcCbda5AqQaJp4hSFWwH/6pXGyg2CUlPArl/g/8
         /SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758681683; x=1759286483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ7ZD4HOO6vcvN2jhvcYNuUy+e/nu1npqP5xs4E4kvw=;
        b=dIYuU+qkh/xAuotV0l6OAb2Vj7oEaeAJoXYg5E5Wr3byjRuTglJ8H7DfyRBETe23er
         n5l4hqLBE6hHz7qsMPWkvwxLuFgWDjBSE/jlidj1sXLdrccuyQosVYv2CwLHpt4HEC+I
         OQ0Y57L2z7zDVvTaLHTIOrZ52hRuGN/UNtXQgg1h9wEoCm+H3Zu5COe77tW+FxWG0pms
         RLGDMHj8DXbZbqchNvupwKBqe0EhFnwt6eM1bFLyPLzFV74UFHZ5Iii3o9SC3WwsFqOf
         jN8/v7KD7d855LCqPB5MNqgG0xtmCXwX3l7bQgf8RFrwc3k1XwMYsnbDfbmZvDgGHus+
         8Csw==
X-Forwarded-Encrypted: i=1; AJvYcCVT1BgQDwiPrPoc9K20wx0I2VOPLELNeuJHQ4qo1OD9P0VDaJlLX1Iy78DLzq1GweefOjP2eM/M6tToui4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatzwOaP1lJ2QoOgOXNLIJa7csNZ7jaMRRRSNwXCegy/JKsMJQ
	NI6prFHCz+Sa8ZpZofoJBwoEBSlmD6lj7rCD+Dii2iUN3bUeJbn4PVfSEgSNKO/yoImHkn9OUIy
	qqd2Zj1IEs4QFZYb/OL2L+BssPX7XPUQ7XzhS/zEOuw==
X-Gm-Gg: ASbGncuIalHGUTVFSPRvxpGIwjyGmSmbSMIP8A+IxpLa0A/xsMT+lPxIE6MSVVJA75i
	dX/aabSv6qcZ9Aq5f6+ewAjLwQgA1brsbbKpZkWCEYJA4KvLIJRZUlxkXaBzb3PgptvTs4PEGtw
	eCvnNhms6380sZhIJrnV5/jEtl8Ejh27jSTkMmXP1yv4/uYbAcIf4tDjR65yGRNxDzduiZKiDgV
	whxqQ8uKP2T5lsAWLs1TKvnJrEkUHE=
X-Google-Smtp-Source: AGHT+IGEpNk9DDtckp5YNfBhGfRHVJ45anN0NmcR9uT9RDyjMg5L8WQA0A/0mav6VX8Fgt6VaztuETs4XxHkt904xHk=
X-Received: by 2002:a05:6808:4fcf:b0:439:b9b3:af48 with SMTP id
 5614622812f47-43f2d4fa2f9mr2800409b6e.51.1758681683348; Tue, 23 Sep 2025
 19:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
In-Reply-To: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 24 Sep 2025 10:41:12 +0800
X-Gm-Features: AS18NWB66CdU_tLMngkAZDvsu7vdd4uKDW0eFr5qi5AGo0Yw70dG5SNPb2ixTPc
Message-ID: <CAEEQ3wnHzL6KVaW=RAkoMNSoM+HW11n=5miFwkw7=LQw+375Gw@mail.gmail.com>
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

Hi Doug,

On Sat, Aug 30, 2025 at 5:34=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> > to arch_pmu_irq_is_nmi() for cross-arch reusability.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/arm64/kernel/Makefile                   | 1 -
> >  drivers/perf/arm_pmu.c                       | 2 +-
> >  include/linux/nmi.h                          | 1 +
> >  include/linux/perf/arm_pmu.h                 | 2 --
> >  kernel/Makefile                              | 2 +-
> >  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
> >  6 files changed, 9 insertions(+), 7 deletions(-)
> >  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)
>
> I'm not a huge fan of the perf hardlockup detector and IMO we should
> maybe just delete it. Thus spreading it to support a new architecture
> isn't my favorite thing to do. Can't you use the buddy hardlockup
> detector?
>
> That being said, I did a quick look at your patch. I'm pretty sure you
> can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> powerpc)?

After discussing whether to remove watchdog perf, it still seems
necessary to keep advancing with it. For the code, we just need to
decorate hw_nmi_get_sample_period() with __weak, right?


>
> -Doug
>

Thanks,
Yunhui

