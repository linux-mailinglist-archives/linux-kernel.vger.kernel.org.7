Return-Path: <linux-kernel+bounces-812970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA508B53F09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A62C3A7769
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532232F39B8;
	Thu, 11 Sep 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6CnKiGM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63E156F45
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632901; cv=none; b=J3EkQstyp+rZ4WDUQQyT5XULCySkFVT1mEyJPJvKoVHEhEG1ml5JJEJRtgnrX6PQSSGv/pqrgZ/4SubUM9HYUKr3uI5hETsXcNLu7fuZZorSCn2kx7IG9zYusqk8uLBG7Y+PiVvR7sz1yKJrv3KCbI7JJaCVMIHyN/sYvXj7XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632901; c=relaxed/simple;
	bh=C+P/Kd9SkQ9GCrQQto5yx0j2xpLCsnbcGxjpkffkaV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgByAsgAj7zIKXLd9s+Af3ZARtzQabSNDTPALzQbGw05pC1QtXD5aHaBExbcf322HJO50/YYZ3+MPMVZ+90I3DlZfujIRXRVd9wuOST00H2yZ/XsrUvgWFmoGRVRgU/g6Odv/KedBMZJYC31LAS3vSpgZawQgrppE7EiwjsOyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6CnKiGM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-56088927dcbso1596020e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757632898; x=1758237698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2tF9sFw+n8j84uzFeDjQP8HrQEawxM0S1IkjwFEuAg=;
        b=M6CnKiGMHDf7HQoCc5vEokNhxJMhyRASfzfHGwt0VCpZ4/Q+0ExCyrfXHAp7zFR3PH
         bwpbs8F3K6emLvUx9Wshhj0MmUCvOajOAaPWG4oteOCUyG+J2cm+So12px+HL4ykn+sp
         b4XIKn7N+/LHuCafnRWtIVB2amDSr4y75Ks0iRCOW6C8dkhZIztHzJuir2ldaxTyOyCD
         ZkgC60jgdnIzIUKsdVGdbGq9245yHYcdeknwn/FQT1iVnGOqvxMBDMJ9+2KQAgirz811
         uUglkqdtJTpyQcuE0H4EIZnPzYzwDiaY9rCe6VHNUNNu7Cplr0Zyt/VkDPjU090tXdnt
         zrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757632898; x=1758237698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2tF9sFw+n8j84uzFeDjQP8HrQEawxM0S1IkjwFEuAg=;
        b=oIlbqJG6GrTe7h/PBI+ENyFLQJX3RxYLR8jtLAClpj+CM2SR6H+Rzn7m2HBFDgY0hJ
         anSLcG36fKwYPckoqupGn0ZkFXNO1aHrsEJZykxE2aerTam+adqOKLA+7Q7OgVZCi0Mw
         c/TDPKIfXo6i1dJufex1CaN16c1MZgDOowSAmQWsEmeyKUAUm2tr1zajiMObgoURWG/Z
         yY6iDt5+wtcmX+nsRWhhVkQ2edd89zZ0/bbpPoIu6tEwZBQuaU3opsb9sx6JGMOI8vk9
         cwj1UrzX72CwJhUkfC07LcbRLfM4gg5k3u14d5N4LXn8ZJ8I2n3LhKlMPfHK3NVJbCYJ
         GOkA==
X-Gm-Message-State: AOJu0YwvuJEJxBBZF/8QGiytITRrV0ZgMPo8TTeDrADf+c/iaOB7L/H9
	+yYg7r0PMpXhihaZ21tmGvUMu4B3PJnQfv9icFikc9IOLH2BeUhmR7KdjD9YleApBuO98N+ae/m
	l4Zn+1TIGyyy/Mgeznys8gpAHJZJFRz4K7McNPLw=
X-Gm-Gg: ASbGnctrB4lh1oUR+pCGQytlKe9VnEElpgmAN/YGKG4ouAF6whMGA1mF9vIvSnZUlq8
	d6SkFsscOnXIFQvrGCvKl+qTK4u+Mgjdu5NcASSmbXKRhU+VV6uNcmf+QYQP+AMnLw0bLZeq0YV
	9KLFVkmGZa5aKetyBMKl/zEdZaMNwNH7P9RODy3GXyYp1V5PpI3RbGrek4hbiXH4l43qURIJjfS
	AtSzwDZG53EzpAx5Uk9opAZNQjkcVV1nw/JOuevtPPmgnc0YIa6IQ==
X-Google-Smtp-Source: AGHT+IEFJXJW1X6tBOAwyCHP2/pNuIz9Kqe7OoiT6Xj6j1WMXvzS7spSsNULxDlU9+neHfDYq92JqC+heydPANJTiis=
X-Received: by 2002:a05:6512:258a:b0:55f:6391:a34b with SMTP id
 2adb3069b0e04-5704fd7711emr290318e87.36.1757632897728; Thu, 11 Sep 2025
 16:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <aMLVuZbkMEQzXPqR@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aMLVuZbkMEQzXPqR@jlelli-thinkpadt14gen4.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Thu, 11 Sep 2025 16:21:26 -0700
X-Gm-Features: Ac12FXxvCah98bmAqbPWhrueAE4WNI205G2-y4d7gfPEKfzZUlksxE7uCGtCVQk
Message-ID: <CANDhNCqx1cGRH=H5ze5LWdjTzA40Ajf5pmjrxj==oh_FcTd2oA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
To: Juri Lelli <juri.lelli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com, Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, yurand2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:59=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
> On 04/09/25 00:21, John Stultz wrote:
> > I=E2=80=99d really appreciate any feedback or review thoughts on the
> > full series as well.
>
> I current have the following on top of your complete series
>
> https://github.com/jlelli/linux/commits/experimental/eval-mbwi/
> https://github.com/jlelli/linux experimental/eval-mbwi
>
> of which
>
> https://github.com/jlelli/linux/commit/9d4bbb1aca624e76e5b34938d848dc9a41=
8c6146
>
> introduces the testing (M-BWI is Multiprocessor Bandwidth Inheritance)
> infra and the rest some additional tracepoints (based on Gabriele's
> patch) to get more DEADLINE info out of tests (in conjuction with
> sched_tp [1]).
>
> Nothing bit to report just yet, mainly spent time getting this working.

Very cool to see! I'll have to pull those and take a look at it!

And I'm of course very interested to hear if you find anything with
the proxy set that I need to revise.

> One thing I noticed thouh (and probably forgot from previous
> discussions) is that spin_on_owner might be 'confusing' from an
> RT/DEADLINE perspective as it deviates from what one expects from the
> ideal theoretical world (as tasks don't immediately block and
> potentially donate). Not sure what to do about it. Maybe special case it
> for RT/DEADLINE, but just started playing with it.

Can you refresh me a bit on why blocking to donate is preferred? If
the lock owner is running, there's not much that blocking to donate
would help with. Does this concern not apply to the current mutex
logic without proxy?  With proxy-exec, I'm trying to preserve the
existing mutex behavior of spin_on_owner, with the main tweak is just
the lock handoff to the current donor when we are proxying, otherwise
the intent is it should be the same.

Now, I do recognize that rt_mutexes and mutexes do have different lock
handoff requirements for RT tasks (needs to strictly go to the highest
priority waiter, and we can't let a lower priority task steal it),
which is why I've not yet enabled proxy-exec on rt_mutexes.

> Anyway, I will keep playing with all this. Just wanted to give
> you/others a quick update. Also adding Luca, Tommaso and Yuri to the
> thread so that they are aware of the testing framework. :)

Thanks so much for sharing!
-john

