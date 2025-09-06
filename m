Return-Path: <linux-kernel+bounces-804122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7608B46A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E28D5C16D4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1CE2C11F8;
	Sat,  6 Sep 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHOMNemF"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975827F74B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148255; cv=none; b=O9rZgvFS3RaIiI7ZFoSE56w28Dl8fBgeqALlQtsYGDPFtAynWrDqOlmAg9BNvXSsrg4sxiRisBEQ3mS1zBIggm/T0uCpr20bpXTQQ4WkzRwTjLEcFf7OYKDwd0RH2X13p0W70mKyX5hpiZKEI6YN4sFYGcFPDDiEN1UaJObm6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148255; c=relaxed/simple;
	bh=ioBMi4/eFSTZR/gwR4miHwSmbvpNL7DYm9ThLt7uKdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL+ivifqtSwwGHf+cZjm/ux1it6enMvKfpk7NgxZrOPd2Bm0cq3sUHyMsaVzyQ4EI5K8wxsEsi/TRhvy82NOicaEe0g4O5rJ0W5M5pba2rJT9A5oMcuwfjQsbO/QEN6sKyITG/Qw7ZcazRSC8ac7ziDOjbL94LyEWJYo2ULDgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHOMNemF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so2874510a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757148252; x=1757753052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew5mxc5caN5gcDtxTwu7IwmhCpTzTpkvaeyIZ+j1bkQ=;
        b=XHOMNemF/8sYH/D18TbUO8uFwC0m7wBJwVycT0ANqt3VXAWbx12GO0acw+aikZFrn+
         jcEHPIZHiLOFc99bb1qEl6ASCBNWJzCtRPgKQzVtPBYRpq6F4kOh6QW0i9HFjy+ALp/D
         TrEY3/4aRDiNDuG5TsWvynSP5Aax6DNYNSI2BWl1wTZ89Va2ZsUhdAxqjcER5JjrYTmX
         Dco+RK5qBbqnvMRcUCkBG23jOUuvqR0RMV9Pb/TY4B8wZ6dt/lDYrDNuShxArGMbIjXQ
         VItfgYhG1PzejJNYty+qawXp3AWOEWIIbV7NZqfPkPlyEp560AvKME9Y0zAS3LARYJdW
         9wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757148252; x=1757753052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew5mxc5caN5gcDtxTwu7IwmhCpTzTpkvaeyIZ+j1bkQ=;
        b=nAAQBKiiRsTdQ4SHJ0PDUS9Z4IVdkom/mnBp8mzIKsIaV8VIS76r45Ma1MdiPrYPWj
         IxaAg7f2z7MLoEPvgFfibUEMoR4ITQRtR4QsUF0msIHOXthh+wJZZk7W+JokNUt826aq
         4lqfD2CanmDyJwFL9Gq6Lqlims+5lrMeZB/2b5Soa9udpT0/H6t1ABaYhwzwLHIVqf03
         2GPCYLADZfkALvJcLBTyjwzOhaWazQrUBsWgpw53YGUnWcc9NnAnLiaXHZg0cP3z1D5w
         Kifh6admbLTrc+6Pzl9s3QZcKRT+Q2w+ZDzY/nbSAdsBoMoy03iPtr668CH4XubWuJZM
         J6jg==
X-Gm-Message-State: AOJu0Yx0n7coTZYwR6vpdqLKr31pa0BA/yAfhxa8i91iP6V4akwXtZWG
	uWq2cyrR4hy/S9tz1Ahaxs1z2eWu7y/G2DvV97RhGE8iAQjtUgtrlVNdOX2uH57cWvUeg/qTnEJ
	sVA2FSzRjcgionjvpkEXVdjMtIyZ/Y/5jAXtE18T5bA==
X-Gm-Gg: ASbGnctVoIyIckl2TwtKO7r9bPweqKCULE++jmSkyRLTqaJrdt4yTsEPdkWAwQ1RiVe
	+YBYMloJKR4pSjyJW60txvWQYTtPFzSaokYiUEejDyRMAfzy7LpcZbg/dIy81cxTvPWKl+sxN4p
	HkYCYw2XwTkve72qcZyBPG+z71MKqQcz/9iWzycdUoGFuiPesU9/cncwzjNv8TsIwAAS9JW0Axe
	UtvxEg54ktt+sP46d4eDNWDOzISbtDDa0eUkTzhmp6C6q1+lQ==
X-Google-Smtp-Source: AGHT+IFWY6ZjZ54pmmCwZjzjcEHYHuEaPv0XvwL3Eflpm/wFl4W2+BYv03gcg0aI3CC8OEM/T3fJ+UI2CYpLLpEbOeM=
X-Received: by 2002:a17:90b:3852:b0:329:e729:b2a1 with SMTP id
 98e67ed59e1d1-32d440d9ff0mr2516690a91.35.1757148252335; Sat, 06 Sep 2025
 01:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
 <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com> <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
In-Reply-To: <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 6 Sep 2025 14:14:00 +0530
X-Gm-Features: Ac12FXyDB-xmFe72rMp4oqEaC6ssFIEBHl2K-2wenWmXDkTJZrm_JyQxx_K7VTs
Message-ID: <CA+G9fYuhDU=5b0my6yMy+ni=K_SFCRxncWJFvj0DVuLftTWYUA@mail.gmail.com>
Subject: Re: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: John Stultz <jstultz@google.com>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Cgroups <cgroups@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Sept 2025 at 02:50, John Stultz <jstultz@google.com> wrote:
>
> On Fri, Sep 5, 2025 at 10:50=E2=80=AFAM John Stultz <jstultz@google.com> =
wrote:
> >
> > On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@l=
inaro.org> wrote:
> > >
> > > Kernel warnings and a panic were observed on Juno-r2 while running
> > > LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> > > SCHED_PROXY_EXEC=3Dy enabled build.
> > >
> > > Regression Analysis:
> > > - New regression? yes
> > > - Reproducibility? yes
> > >
> > > First seen on next-20250904
> > > Bad: next-20250904
> > > Good: next-20250822
> > >
> > > Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel pan=
ic
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Thank you for the testing and the report here!
> >
> > > Juno-r2:
> > >  * LTP controllers
> > >    * cgroup_fj_stress.sh
> > >
> > > Test crash:
> > > cgroup_fj_stress_net_cls_1_200_one:
> > > [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_2=
00_one:
> > > start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> > > [  374.230110] ------------[ cut here ]------------
> > > [  374.230132] WARNING: lib/timerqueue.c:55 at
> > > timerqueue_del+0x68/0x70, CPU#5: swapper/5/0
> >
> > This looks like we are removing a timer that was already removed from t=
he queue.
> >
> > I don't see anything obvious right away in the delta that would clue
> > me into what's going on, but I'll try to reproduce this.
>
> So far I've not been able to reproduce this in my environment.  If you
> are able to reproduce this easily, could you try enabling
> CONFIG_DEBUG_OBJECTS_TIMERS to see if it shows anything?

I have been running in CI loop for these tests to reproduce and did not
find this again.

I will add this extra Kconfig CONFIG_DEBUG_OBJECTS_TIMERS
and re-run to reproduce this reported regression.

- Naresh

>
> thanks
> -john

