Return-Path: <linux-kernel+bounces-803501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AAEB46106
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9549D17900C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F0353366;
	Fri,  5 Sep 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RijEcKMp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4623E342
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094664; cv=none; b=IHWWxx0J2MFjEX4v9p/FRPmBpCmEh3uW4zBc1jXVFscLUZdVa+lTH9D92G7m1LFogxZk7MhF4+aFUAoGxuhtd6fC+n2Xd2Z5vRksIlCleBgiJjgpprUlkFLoaNlLjxIAHBDfLrtpLYDhgARmiPiawvW/eioLv1jYASMFco6W5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094664; c=relaxed/simple;
	bh=xnZs4CJraYZQ5wDbYLO6uLnEPPN/QIdzXCOFwkslhQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9Bm8FOI0X9Wc2LSXgAW5Vb7pfXJJn5FbOQje3Qqtep3Bj4qDX2IkSZaDORqvebOsogel8CdkeXNWzHA6T8skIKR4aDbectHfnm0PgG5JmvftoBSRlRZpWXS5zaJ/YSqei7B5+rD+G9vvW5vts5r0q1g2kTbCIK3wdJ5ieDAMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RijEcKMp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f720ffe34so3150185e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757094661; x=1757699461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaXyfPMqwoi89bLGQQm9R1wibinvU7q12XwB+QMftqw=;
        b=RijEcKMpKZ0l18MgdTMdElLGaCAM6JF8JL80UrDqQYFy2Q34XWx+/TDQ5AeSp/bHi+
         HXJyF+A28Od0ayhZlX0m9NAKRF6oLYZq9lKfbKLMuGWTOrK7YYeHYu2ctQtOrLJAt/zj
         iiVE+yBeqGDYwiQ/sMSvOulGvRcpYOJgfene43VHGzCUNvH6vB4nFtwYGt+YlhfFnCFO
         Db+qGVbMt+93hZX9Oujee9Ms0b6MHs1M72F9eZ7A2Ic+erikPqn9r/BplLoBVpkedMfD
         WahPm64uRdohDNKORitbUXmoIB+9li7aKlSvnU/JOgXA6zVUKYXX4LPpYXK4F/81IZg4
         EW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094661; x=1757699461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaXyfPMqwoi89bLGQQm9R1wibinvU7q12XwB+QMftqw=;
        b=BGK3XgI5CaeyffcPNIIx04UkpOLSaeVyviNO6kwlsYWPw5eUeK9QCqKPQKEWgFHZow
         IO2pbC4myWXSL2OupoH+m7bv+P6qcKdnjW8HlOxwH4mSuhrAa1NP/j5B3MMFiBsYnhN0
         BSWSxLRoDS/2bF6yo/9oFyeBkWVlGB2PW05g7Bx5hVSAOtlhQvDHPtvsa0N3IhgtqIBT
         DRB4D+9+quNkUDAJJJ4Z8QUyCXrnSabzvN6ln0d1hvusCj/adQbR3iaO5Az+5U7fR6mN
         /WDmho7qj6pcPNEs3uqEaA2tcw3jn26GvPQo8GLpFED+lCrc/qnnsPttY+bNg7bvyXO8
         USdw==
X-Gm-Message-State: AOJu0Yyozje4WEbeXzSoFqEo36cyLxk3BtO8Ze9TiPknzwpiIfqsh7B7
	6niCJmzF6Tlks4/4IA6EE8MunDTe4nC8F8cE02k2GCBe+rP9sPI1iRCGmOwTei6MTbTOn7ICTtE
	K+KB0gRbxBdFbwAOfCoslpSjOrpqarw1mAzxANWA=
X-Gm-Gg: ASbGncvp7A8wioNkaeCNlsXJxcXy9LSzVRslE5Md5EGUzUalTwqcnltyOwCTQT/QN8d
	6euS37l8LncxCQg8bxJuD93tbco5b8M7kpdnBAXG1g37O9hdJdV3Hw+9P3cegrIydmT9eH/IDaw
	TO6dv57RuFdY1aR2UN/0iSxYklcFn58SLAv3N8DwQuOJ9BRWrInVOGm551IkKg3ujrz8xz45H24
	RBGfzmcyLQTuRnZuS1QbbpPCtPaxWYqt2Zvk5eQzG8=
X-Google-Smtp-Source: AGHT+IHovfJi9UxsADA1y41PVTn87JQTAj3Hx1c4SPMGqx4uQRvjNmPj9yRmM3NVbenXyWcNvhGxjH9edA0XcuveD74=
X-Received: by 2002:a05:6512:b8f:b0:55f:4ac2:a59a with SMTP id
 2adb3069b0e04-560995d4d53mr1317878e87.22.1757094660686; Fri, 05 Sep 2025
 10:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
In-Reply-To: <CA+G9fYv0mbEBVs0oTiM+H4X-y7ZCwYpfa0hGCQCeVkW2ufGD_w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 5 Sep 2025 10:50:48 -0700
X-Gm-Features: Ac12FXzVJdbZI6etdAi_p7uTw8KZ7iah-8DwGxTzPcTMM_M3HAoZ1BASAyToy4g
Message-ID: <CANDhNCpWWNpBQfeGq_Bj1pEWTYULJGaubTuPJ2Yxjg4_ESzgBw@mail.gmail.com>
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

On Fri, Sep 5, 2025 at 6:21=E2=80=AFAM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> Kernel warnings and a panic were observed on Juno-r2 while running
> LTP controllers (cgroup_fj_stress.sh) on the Linux next-20250904 with
> SCHED_PROXY_EXEC=3Dy enabled build.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> First seen on next-20250904
> Bad: next-20250904
> Good: next-20250822
>
> Test regression: next-20250904 juno-r2 cgroup_fj_stress.sh kernel panic
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you for the testing and the report here!

> Juno-r2:
>  * LTP controllers
>    * cgroup_fj_stress.sh
>
> Test crash:
> cgroup_fj_stress_net_cls_1_200_one:
> [  365.917504] /usr/local/bin/kirk[402]: cgroup_fj_stress_net_cls_1_200_o=
ne:
> start (command: cgroup_fj_stress.sh net_cls 1 200 one)
> [  374.230110] ------------[ cut here ]------------
> [  374.230132] WARNING: lib/timerqueue.c:55 at
> timerqueue_del+0x68/0x70, CPU#5: swapper/5/0

This looks like we are removing a timer that was already removed from the q=
ueue.

I don't see anything obvious right away in the delta that would clue
me into what's going on, but I'll try to reproduce this.

thanks
-john

