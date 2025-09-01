Return-Path: <linux-kernel+bounces-793846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06979B3D91D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EEE18998B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F20242938;
	Mon,  1 Sep 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YyYfO+UE"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795661C84A2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706254; cv=none; b=FtNopOkTsCcrmEFc679NXDeQGThcMVNHY02HiDtmZCwthM6ynP4mGucjRie1BKgbmtyfd8T2H0CkDdQFgCLbAbh7mCmb474705NHbICw/4gb1hxdTi3S9z7PwHZ6kjzflkvWpb46nPyfYyHegJpZlqWQCtSW3c6gnjfbG8WLvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706254; c=relaxed/simple;
	bh=FyAsHeoe/zeL0dZKiAKYHqGwqBTz8WBo6jni7UhNvo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4z22OFW1EQGdAfpBfXn0+S0H9IoQxo8LGrZEtT6FVv9UHp1gM0SO0fXkgZBJ3lIL2tagUgf4/e7lq/xzSaiIvJ3rH8JwafCn0wXhQo9TPGKnp9ZTwrFZi6lvVVe2GOhqLg8D5Cda+hWeUkKqND//sjqu1BBW9xv8clW3uGLeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YyYfO+UE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce5cb708so3053395fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756706251; x=1757311051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeQYWbY1S4fZ+YczB8KbzZBm49i+mRKtPu5B3WoNWrY=;
        b=YyYfO+UELD5VAVOmS2U2dcNZPe/V8rFIdi7bo0gMa6NhRJTi9LqzlnVVkvJpX/lHIv
         Bk3kyz44pkHSvnB1N48TpgAmcM9MnxclEN0kpzuyznV2SfI6xSlA6bU2gOEk+c1xL1+9
         W36uHBTYhkZr/C+tHigzXbiOB/AQPk7phZDRbw9a3Z5fQUar/8yGWfyhkfc1Hcei3nuH
         Ll81OUN7TgFtHPY9qhbbKUAFO5h0Wl5vFM/FQY7i0rmlWD325yuE4zjNuGKjfeCBQRT0
         TIPV/jNDSVjN3bpY92nEDhStDDkrw6QS9Jx3il4VEB4cUvqn7qLgd9YiI6KaTTtZRUSW
         Mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706251; x=1757311051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeQYWbY1S4fZ+YczB8KbzZBm49i+mRKtPu5B3WoNWrY=;
        b=rKoYe3Y3KQxEZPbbfi1Qbu2v7zzTyGi7iBksbTZK7QOUPGIrRw6j+EEAJA/FVlcWrB
         xfqRXPMbyWX1xPl+fw+Bmw8NZuOBSkFhzulmw7IlcXcECkpB+vRtz5fMkeGcektEG/w5
         h8iVzYkl4paIpgsvX/UpcTVwNCcuu4zj3gfTLkDOp5wFVRiGP6Tyu+V9H5i9jrLszYoN
         JKwz/tlDcRIqcXQDzu5W3A0PYqyhcduISSbDOzOzv+vu4QiIlkoOqRLTKZ6Upr8hWdif
         ZOlM7ABeyzIO+7QBBVf2pyFTCe8rwB1f2AmRvMBgx7RhSSGLLi8zLpjBoV/TEu81G0qs
         PGfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyEPaJ9nfnLJuXnAzEZLt+F7SqEGyElKdovL6PEcU9hKdKrk82qcT8hQhBZfiDYnKjZLv/xQp93ylBlOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOd3Ve41PlVzPlwxAhcvmUJTmh+RHu14OYQEcFYgMZKQBUWpB2
	mwABgzQB1km62c5TEVEHh8IrXWXAEyHIIgnvpWePL0t+RZw0llO0+a/5Y2pl1KNqeNPHw2p1Pe4
	30ZUqwClt72oq75/7n98LSfiFGDMx8vAA0F48CmWqCA==
X-Gm-Gg: ASbGncvpyEViMYs8RdPWAabPI/xTgCFNMLE3gETMZPhfmRtcPzNZserWzdkwRz647uE
	ELCLJNSB+8UAO3nOfFMHTVgti0THwJ6wMo8s5fGGElTICo1f9Z9AUyw9HVGD3AY8GR9QhAU2MGR
	ek2hO/zmk6OTd+9OUpF5jl9oR6621jdjag9jnYp4cHupQfO7SBpDSd0XnCwHZpzad1v80WIWC7q
	c8bzF+M1Gaha9mFttemFhEy4JIeDw==
X-Google-Smtp-Source: AGHT+IEtvyL0v+dIqPd4cVuA9FY2MWzZGsXTxWqPBDg5RCf2ntrVdCNu37vpIo27yokw6idnCUTUmPkUJc2WW9ZSX9I=
X-Received: by 2002:a05:6808:14c2:b0:437:75a1:34ff with SMTP id
 5614622812f47-437f7dc9eadmr3255975b6e.43.1756706251452; Sun, 31 Aug 2025
 22:57:31 -0700 (PDT)
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
Date: Mon, 1 Sep 2025 13:57:20 +0800
X-Gm-Features: Ac12FXztNIRPMxCTXiinwhNyATXzi2utzF9owhxKyx-0keFQXx7jGWYBvVSkODg
Message-ID: <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
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

Why is there a plan to remove CONFIG_HARDLOCKUP_DETECTOR_PERF? Could
you explain the specific reasons? Is the community's future plan to
favor CONFIG_HARDLOCKUP_DETECTOR_BUDDY?

>
> That being said, I did a quick look at your patch. I'm pretty sure you
> can't just move the arm64 "watchdog_hld.c" to be generic. Won't
> hw_nmi_get_sample_period() conflict with everyone else's (x86 and
> powerpc)?
>
> -Doug
>

Thanks,
Yunhui

