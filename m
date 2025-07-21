Return-Path: <linux-kernel+bounces-738960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9BB0BFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A9189ABC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B7287252;
	Mon, 21 Jul 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+eKVGpf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F121798F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088791; cv=none; b=Lsk7o+EM4LMySTYnWlyxdXLo/UnnoLFoGbfm1EIJQ8bBaS6HvH8WnwEKwcodrqESZG+K27VRlKgO6UjTPzHJR7acUX1SVdeQbveD4L21wnx9zfjXMhr9dU8YNX7fRiLhtLAeV82ZuUBDSgMqLySO2NGpd/JPWx2pf910dQd/NAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088791; c=relaxed/simple;
	bh=iv7l4zOF1eh6MLZ5cfXAmIIxBlQIuHluu12YFC10Q+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux/3FXpzZfrLFIDZanXhXJcMvwsXnWXg+MQXQOPiyeuisJAxXq6wYRYn07zOfhfTlZzoTGNFdvz/mlaWkyK7fbKznRgC5JBbge81DrR0AZs/Q3TKbEPaB3+0H3dVytS9wvtilhRFKorA5jUXD9QfcbB2yjVIIQQ48mYpPZD84cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+eKVGpf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso714302466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753088788; x=1753693588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv7l4zOF1eh6MLZ5cfXAmIIxBlQIuHluu12YFC10Q+M=;
        b=k+eKVGpfniz6TDl7wAsZ7NQz2A2zNA1WLOtPUeDRX1J0evZrHdGf7RWSfXmtMhCdXa
         2ib4moygy/1XeAlIj6ambuEdvvpxOd9epvRvVXckaa+DzvMMjAe1K75foKLAITCpKaiQ
         4HeoH/9BcW6NlnGXK/qaEP6w0Y2h8rRIQeyu2mYDY5nabC+rHveNok5B2/MdUAP9daSG
         iq3bnr8ij0ojRC7BDWw0mBJODR2ZsPPKoA+7qgwJFwQy6Okj82XJYcUFIuetA2Fwia8t
         hfjUvXCUE+z1iqiBZVAYxJ/KfXkwqEmJUaJ/xgmZvEDsklD4Ld9SRw2nS49Np5OVON7Y
         gn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088788; x=1753693588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv7l4zOF1eh6MLZ5cfXAmIIxBlQIuHluu12YFC10Q+M=;
        b=S/ZZFjQlzQxX5fd/JEIWavwK4NzJUXr6T0aM8XjchPhkQR516a3QsA6lQO7b6YUYLx
         N6ilIsYaG6txtngPzrtXqkRtL82/KfQUv2FnS48JNUn5iMykYY76Mf7XyBTvx/RFpvw0
         cZe0mPj2l55g3qj/5kOm1j+NMgVwQERcLJnmfTW+fBdfPtoRUde//DYJJjE5Z0R9wu6X
         Yx5XZ/5TdynEc5eLP5yP/R26xtyuWmQmiJnmhm+OHFwnyGaj1hhWdDwhcCnEAYskaAwh
         sSOqv74hWdAGQitJQiDO39DZikdGpPpok5R0ofgOcipFgLRYxZNZmyBBVZBTjy1vU1w4
         SXrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMOtS07nNJPNwf359HEvFYRP56zM1uiTFw79ajJLsQK2v2QC01DvbTEbiphLZQTPSUQRddW2Fz+0jbElo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4qT5f9Hxd0mLGFye3rFvJQAIXpY0rFwnuvDeHZGaawgyzVCK
	RP50ilN+t+S6nkZgfabRltTXR8A0ZdP8ZFdiclnR3i/b0HNG8hAO4BSe4550XAqwJIK/QywOM0J
	h21t/OjNhgOsfWetTkzQXKg4pxJtdTfQUXk4s4iamFA==
X-Gm-Gg: ASbGncumRY07Kbn85rCBSuOjjoqhksgucHiKTN8q59IeS6ChrlXEnrJz+FlMhZbIMAR
	uouFpa8Ar83Rca9tA+PRX9jN3prIACp7SPAx+Brm2KwuwPbCx0/DU6kfoYHdkufD/993Rf0q0dL
	C1COpIvWGzkjuQolN/9e5SRZ+lX/cRkfRAMzYJj43LRY4IfyIYkW61CmLGVHxU2eWAYdbWHRla0
	/VoNuDctGmIMt3d8iLWFbDbfRXyBZ+96bUBs9dh
X-Google-Smtp-Source: AGHT+IGJzobdj67JfI1cqIPG72ZNlHlCPAKBX8lDhWckEqUrT0k6YrEvCN9vXtljRHnNlfXggqmCyutywfOkC8e8MUM=
X-Received: by 2002:a17:907:da4:b0:ae3:a71b:1543 with SMTP id
 a640c23a62f3a-aec4ddb755emr1744816966b.2.1753088787748; Mon, 21 Jul 2025
 02:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org> <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
 <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
 <20250710123435.GM1613376@noisy.programming.kicks-ass.net> <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com>
In-Reply-To: <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 21 Jul 2025 11:06:15 +0200
X-Gm-Features: Ac12FXw7uLowpcuNfsTaa_85XWi-NCPLvl-x0bJoNb3ZJHdr2qT9fvtFhirUU7I
Message-ID: <CAKfTPtBhkBTcWW88QV2tUFEF_kvHZpai7OvHG3q5qU9shpj-3g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, dhaval@gianis.ca, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,

Sorry for the late reply but I have limited network access at the moment.

On Sun, 13 Jul 2025 at 20:17, Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Vincent, Peter
>
> On 10/07/25 18:04, Peter Zijlstra wrote:
> >
> >>> If I set my task=E2=80=99s custom slice to a larger value but another=
 task has a smaller slice,
> >>> this change will cap my protected window to the smaller slice. Does t=
hat mean my custom
> >>> slice is no longer honored?
> >>
> >> What do you mean by honored ? EEVDF never mandates that a request of
> >> size slice will be done in one go. Slice mainly defines the deadline
> >> and orders the entities but not that it will always run your slice in
> >> one go. Run to parity tries to minimize the number of context switches
> >> between runnable tasks but must not break fairness and lag theorem.So
> >> If your task A has a slice of 10ms and task B wakes up with a slice of
> >> 1ms. B will preempt A because its deadline is earlier. If task B still
> >> wants to run after its slice is exhausted, it will not be eligible and
> >> task A will run until task B becomes eligible, which is as long as
> >> task B's slice.
> >
> > Right. Added if you don't want wakeup preemption, we've got SCHED_BATCH
> > for you.
>
> Thanks for the explanation. Understood now that slice is only for deadlin=
e
> calculation and ordering for eligible tasks.
>
> Before your patch, I observed that each task ran for its full custom slic=
e
> before preemption, which led me to assume that slice directly controlled
> uninterrupted runtime.
>
> With the patch series applied and RUN_TO_PARITY=3Dtrue, I now see the exp=
ected behavior:
> - Default slice (~2.8=E2=80=AFms): tasks run ~3=E2=80=AFms each.
> - Increasing one task=E2=80=99s slice doesn=E2=80=99t extend its single=
=E2=80=90run duration=E2=80=94it remains ~3=E2=80=AFms.
> - Decreasing one tasks=E2=80=99 slice shortens everyone=E2=80=99s run to =
that new minimum.
>
> With this patch series, With NO_RUN_TO_PARITY, I see runtimes near 1=E2=
=80=AFms (CONFIG_HZ=3D1000).
>
> However, without your patches, I was still seeing ~3=E2=80=AFms runs even=
 with NO_RUN_TO_PARITY,
> which confused me because I expected runtime to drop to ~1=E2=80=AFms (pr=
eempt at every tick)
> rather than run up to the default slice.
>
> Without your patches and having RUN_TO_PARITY is as expected. Task runnin=
g till it's
> slice when eligible.
>
> I ran these with 16 stress=E2=80=91ng threads pinned to one CPU.
>
> Please let me know if my understanding is incorrect, and why I was still =
seeing ~3=E2=80=AFms
> runtimes with NO_RUN_TO_PARITY before this patch series.

Before my patchset both NO_RUN_TO_PARITY and RUN_TO_PARITY were wrong.
Patch 2 fixes NO_RUN_TO_PARITY and others RUN_TO_PARITY

>
> Thanks,
> Madadi Vineeth Reddy

