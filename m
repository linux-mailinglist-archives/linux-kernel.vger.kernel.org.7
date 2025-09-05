Return-Path: <linux-kernel+bounces-803797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C0B4656C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4D1CC52AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948BF2E8B86;
	Fri,  5 Sep 2025 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2VFb4R4"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB761F30AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107225; cv=none; b=Kz+YMpGKdaNqtGuI63Uj7NfAImqBrhc36ISvy8sIZa20Lc7fAEsE56G+kLiQEjTt7LECt+uiMwiyeAB/FPqW09tFUGZTY7ZZtT3A6yairccbpN9ysvKMG9Q6t2a8Igp4/yb7MjshN6UUM6cdfGUXzR0lSBf95E7NxFVQF9CFAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107225; c=relaxed/simple;
	bh=1CyIY4Gge20GP7y0cDU45m2jcj75ZJgT0UYbOpjMvYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2x+M23dtV5fKBZMZo65SfI/s8bw5775TpdSJX/kzcLhL+u6oABiqIICmZFxIytVd41gFlpGtPZjy65OPpCJgrUgUG35ekTemwqm3kK3agEItlAbf9VNpuplR8+/Bc9SRjrTI1uEYV85KzeljWACMgCVXw0F8t+q0DPJ+BDl+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2VFb4R4; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so2752870e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757107221; x=1757712021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihoNevlLzJDBSuy8DxcqIRmMmQ3q65NAy+tYYX30mhs=;
        b=E2VFb4R4IMPFSM3pee/VTvL2rGIgdQdJNG1SQftlQz3H53jnlmc1+1xJjk/6xW8ay3
         RX9B/bKQJHv4cj2gyUD8L1uKB3q9m3YJzEOa8P11QZ+l3A/V79Z1FIAQSDrfKmgwjcE/
         +1uMfi8Zfb5osQH0ksJkntQjGFCRaCBdSlcFXAJIO2/Fl9f5Sm0tVFv+HVIYpVC95JtY
         ZKR53moxlo1nR9VO3m7qQCfvqmtwV0cur2Co9wtnEXlRDzJVIJUr64L17FlboemEJwJW
         wlrStdt8SrH46G1l03RipN3qebLJt+rax24hd1LLYY7zvGviGMY6WxCRhAG6DMjK0Wot
         wirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107221; x=1757712021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihoNevlLzJDBSuy8DxcqIRmMmQ3q65NAy+tYYX30mhs=;
        b=DQxQQLisEDZ5x4aW00GXUcVULAGU0FYQRKb9e4ksZ9mmwR2Y9TEe1v5rCe4e4K626C
         F3NZVKKfGLYuvl5m+DLS32B6CfwbylOInVaVxKTMhJhr+2Icx6Y3DysPd/4Nz3JCl/1+
         Cdtk8R8dE3C2H+m2pMhzl1f2qrZ5uskt+v/E7AS8iumZEXXw/UyBvqhgwpWUOzdXZJC7
         0ljDmzODPmrL1CaxxfD/hpMcelSKAWM29ta3kCcBeh8fUWe7ls7Vy+11/B+z86IvKh5O
         WQKGwj7xHokQhTJLVTG5JpI/58FyTthDJMVRh4gO7q3gMiJPjMBZzTGynmLB/0a7Er4e
         Q6iA==
X-Gm-Message-State: AOJu0YxqMv0NJcL0XhviPOgqvlasDE8mh08i5IMbhvJWSWvJzGYkizXc
	4qHKdNQJpu1Vjm9Ryl+tHm/GdLjoqTwt7DOjCm+FQMviGpe+QhlrCCK4MuXYoar9UIRIHTnx+cL
	GgQCs7XcVYzfLubt6JsycaEfBVDaYawB04cmQwwM=
X-Gm-Gg: ASbGnctL7R8qgOVrQfrkFELVotMsdkVz2rqA7tR+jVQh6ZOM2U88i/QBj+ZTb6WboeY
	hrdwEAXKJk2mfBfJBwaIAjbYDiWGUjZLbYeafM0FO2VVvISREi1wimT6SibYWe+sCMssUskhwCL
	3aYDAhmwA6L1WDGQ/wMs8FWOPCK3rdnhdPR0E4FVjjjv6vUcHW8aTIxxFkyKIFSYJz3j42v4Sgs
	sSEX/NIDw6mZjD7D3SzhDeuVep8s3OGYbwFhI/CYGEpTKCy68HtSw==
X-Google-Smtp-Source: AGHT+IGklKSxmgtyLJoi1vvHN7sLHpD+0Iy8PrXyLbJxGTq/1I6kUc4ziYI23n3kTAxDik0wCpIxXBb5i2BdIOMmD6k=
X-Received: by 2002:a05:6512:3b12:b0:55f:6831:6ee7 with SMTP id
 2adb3069b0e04-562601b5384mr78383e87.21.1757107221283; Fri, 05 Sep 2025
 14:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
 <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
In-Reply-To: <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 5 Sep 2025 14:20:09 -0700
X-Gm-Features: Ac12FXyJR8KmvN8T2fwKhwhjrwRXLtrixZllcL7-1u48pK2bWIjS9VPSJc01V20
Message-ID: <CANDhNCrJYMcK+dak8ASX6uoVFkNSHMf3Bn1kOXDtqNqFb7LkJQ@mail.gmail.com>
Subject: Re: arm64/juno-r2: Kernel panic in cgroup_fj_stress.sh on next-20250904
To: Naresh Kamboju <naresh.kamboju@linaro.org>
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

On Fri, Sep 5, 2025 at 10:50=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@lin=
aro.org> wrote:
> >
> > Kernel warnings and a panic were observed on Juno-r2 while running
> > LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> > SCHED_PROXY_EXEC=3Dy enabled build.
> >
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > First seen on next-20250904
> > Bad: next-20250904
> > Good: next-20250822
> >
> > Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel panic
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you for the testing and the report here!
>
> > Juno-r2:
> >  * LTP controllers
> >    * cgroup_fj_stress.sh
> >
> > Test crash:
> > cgroup_fj_stress_net_cls_1_200_one:
> > [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_200=
_one:
> > start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> > [  374.230110] ------------[ cut here ]------------
> > [  374.230132] WARNING: lib/timerqueue.c:55 at
> > timerqueue_del+0x68/0x70, CPU#5: swapper/5/0
>
> This looks like we are removing a timer that was already removed from the=
 queue.
>
> I don't see anything obvious right away in the delta that would clue
> me into what's going on, but I'll try to reproduce this.

So far I've not been able to reproduce this in my environment.  If you
are able to reproduce this easily, could you try enabling
CONFIG_DEBUG_OBJECTS_TIMERS to see if it shows anything?

thanks
-john

