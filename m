Return-Path: <linux-kernel+bounces-738967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6993B0BFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA67D16A5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E01288C0A;
	Mon, 21 Jul 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QerzCdBH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8391798F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089120; cv=none; b=hjpkWoJuKpfWAh1uw71lFt+KnkDxyX/8K/HPVt90eELzAiXTp5cOVwzwYGqhXGum21SlOgRCxiBQzXBpRyc78P+1YjKQnpvTWyhjxzJPpRqSq7ga3nt5pzsjG6zNYRQT1t8fL/bxfHRZhDUnEwg0F5bdhqu/qkFKVGvsuvoKj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089120; c=relaxed/simple;
	bh=hhA7ypzgVJrNCUExLyxE2vtXk35QIwwG/Xy7pYSXsbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpcUrx7fukX0OV0IDOLYULoBXbrShz22Bd4DV+76aOBfR2uGLZI9MqYSgdG/k03MpMdY5yPS0x8fgo8+Hy8J1F0/oC2jRUOKsduSx2vAexIBEUh+ikQweiBIvxHor1qBSt3+h2zEqEpOiaE9M5GOrpp13q3cfImoH0sLm2nd6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QerzCdBH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0c571f137so756364366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753089116; x=1753693916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhA7ypzgVJrNCUExLyxE2vtXk35QIwwG/Xy7pYSXsbs=;
        b=QerzCdBHoX1MEMGCuu8Q8aws1DVWr02MYJSOWTjoX43eXscKQYlXWbu3PkH1YRQaLb
         t3Lm1ZRkeJqF2VLwMcOtQXx09mLEhSxxs0UE/ED05bGc5ucUt3RFGnfXZAZXXAhnki10
         fksd8Lq+E2sjC2vIs3ocBies8LG+lA8uPt5Di+WmRfWL7rS+laG00CEeSrJdOHMdTx9m
         4Tr8E6Os0HJ8HRpacLgxJ/cyX6m07RSZUp09KnRDxem7nWsJOdHj4bux8ciCEXSVtX0K
         K9mxj1kuvGGfiVseIyCp5sbjpFJh1UoIv/7UBUcg4aEnt/UHo5Bf5QXwq1zv+MGWcunG
         36lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753089116; x=1753693916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhA7ypzgVJrNCUExLyxE2vtXk35QIwwG/Xy7pYSXsbs=;
        b=i5zF+309WI/lLA+d7uFaVcYszy+F5djAd4feJe5XEeT5FUJxB4kHG7v0Obme0nlkfu
         NILo/v2XpGfk+SAwNY5MYtNWRfSI45sJSKIvIl9ssFncn1ZvUvVaaZlCw5dNjgNFiFC2
         LyHT+WRnVwMC4Id6DdEDmkTh9M6zPhhSFL2lBLZ2FFnnK7pdmBceL/9j2Zrq7v4Q/oW4
         FNh0B4Ite+QI2Q2NpaJo48ixtNn2hwgTl7jalKwq9Qq/r2Wy5hBfARNdTHB1q5yF4uVs
         2TVBOl8WBB42H1AkOu+4hdeDfaP6Llcc339FHoc40JmQWWjucQjytRmoIb8t1Pw7Rt1w
         JTxw==
X-Forwarded-Encrypted: i=1; AJvYcCWXy5GLPb9fLvlUwEE2OEqjsWlpwwZPrp9892VhyJu1KVaWTbkHnBttUXHPtGWbBRPZRqU9bvYUnDmbdQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYvNeTbs6QQp1Alg4T4lZjqaNCuEG8l3T0WijFnsufH6nOYRJ
	tgli3yJJ3MkkdNseLNJyJ6/aVLYUe/l4Ec6lPPmSIZOmSb1g1FQlcWFVTiXfplASiDb0vB6+ymP
	NTXD+/hac5GfOtGNjCaKmCHWNd0eBXkvxINe21x4VZw==
X-Gm-Gg: ASbGnctiKKAbRjI2Uxx7C+KFuEV8OegW7WE6ubzl81s/H4owsL2sMvRcgwoGY4uLGRA
	jfV4eUb68LT9ENQHh8n75MzPmnn6nYNHMighAvLkhZ6m99ql6qx9tsf/QJW3oP73pcV21OufI0h
	9pGwLeaPvWd+n0ujXyC1PRen9CtOfcvkA3oZYwULtdMtIDx0rGQavW9Tf1E1CRaFJfVcMa6cKDz
	vKx720y8FC/s94UXEZBQNsiXJ7q1IqdzvbUStBMD27o7d8WQzc=
X-Google-Smtp-Source: AGHT+IGC/e4x0EMjihguyBAqhi5FMc3ech9KyBzf6phbktI0S+TUxfY6zhy8jBmyt+ey74AA3gKZ8o62yyNeS12ML/4=
X-Received: by 2002:a17:907:7e81:b0:aec:4aa6:7800 with SMTP id
 a640c23a62f3a-aec4aa6a010mr1655445466b.20.1753089115834; Mon, 21 Jul 2025
 02:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org> <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
 <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
 <20250710123435.GM1613376@noisy.programming.kicks-ass.net>
 <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com> <cee2b280-a036-43b5-8ff8-6ec2a0b9356b@linux.ibm.com>
In-Reply-To: <cee2b280-a036-43b5-8ff8-6ec2a0b9356b@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 21 Jul 2025 11:11:44 +0200
X-Gm-Features: Ac12FXyZExlsOOdP_D0BIVf9BEFJYulmB6-joNCfkKbFhOtLTl6hBVwgneMGSVc
Message-ID: <CAKfTPtCNkqp87j8mAKbfBS+Pk=YWv9qQf9VE4=AkqPu9YCR=Kw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, dhaval@gianis.ca, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 at 12:57, Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> On 13/07/25 23:47, Madadi Vineeth Reddy wrote:
> > Hi Vincent, Peter
> >
> > On 10/07/25 18:04, Peter Zijlstra wrote:
> >>
> >>>> If I set my task=E2=80=99s custom slice to a larger value but anothe=
r task has a smaller slice,
> >>>> this change will cap my protected window to the smaller slice. Does =
that mean my custom
> >>>> slice is no longer honored?
> >>>
> >>> What do you mean by honored ? EEVDF never mandates that a request of
> >>> size slice will be done in one go. Slice mainly defines the deadline
> >>> and orders the entities but not that it will always run your slice in
> >>> one go. Run to parity tries to minimize the number of context switche=
s
> >>> between runnable tasks but must not break fairness and lag theorem.So
> >>> If your task A has a slice of 10ms and task B wakes up with a slice o=
f
> >>> 1ms. B will preempt A because its deadline is earlier. If task B stil=
l
> >>> wants to run after its slice is exhausted, it will not be eligible an=
d
> >>> task A will run until task B becomes eligible, which is as long as
> >>> task B's slice.
> >>
> >> Right. Added if you don't want wakeup preemption, we've got SCHED_BATC=
H
> >> for you.
> >
> > Thanks for the explanation. Understood now that slice is only for deadl=
ine
> > calculation and ordering for eligible tasks.
> >
> > Before your patch, I observed that each task ran for its full custom sl=
ice
> > before preemption, which led me to assume that slice directly controlle=
d
> > uninterrupted runtime.
> >
> > With the patch series applied and RUN_TO_PARITY=3Dtrue, I now see the e=
xpected behavior:
> > - Default slice (~2.8=E2=80=AFms): tasks run ~3=E2=80=AFms each.
> > - Increasing one task=E2=80=99s slice doesn=E2=80=99t extend its single=
=E2=80=90run duration=E2=80=94it remains ~3=E2=80=AFms.
> > - Decreasing one tasks=E2=80=99 slice shortens everyone=E2=80=99s run t=
o that new minimum.
> >
> > With this patch series, With NO_RUN_TO_PARITY, I see runtimes near 1=E2=
=80=AFms (CONFIG_HZ=3D1000).
> >
> > However, without your patches, I was still seeing ~3=E2=80=AFms runs ev=
en with NO_RUN_TO_PARITY,
> > which confused me because I expected runtime to drop to ~1=E2=80=AFms (=
preempt at every tick)
> > rather than run up to the default slice.
> >
> > Without your patches and having RUN_TO_PARITY is as expected. Task runn=
ing till it's
> > slice when eligible.
> >
> > I ran these with 16 stress=E2=80=91ng threads pinned to one CPU.
> >
> > Please let me know if my understanding is incorrect, and why I was stil=
l seeing ~3=E2=80=AFms
> > runtimes with NO_RUN_TO_PARITY before this patch series.
> >
>
> Hi Vincent,
>
> Just following up on my earlier question: with the patch applied (and=E2=
=80=AFRUN_TO_PARITY=3Dtrue),
> reducing one task=E2=80=99s slice now clamps the runtime of all tasks on =
that runqueue to the new
> minimum.(By =E2=80=9Cruntime=E2=80=9D I mean the continuous time a task r=
uns before preemption.). Could this
> negatively impact throughput oriented workloads where remaining threads n=
eed longer run time
> before preemption?

Probably, it is also expected that tasks which have shorter slices,
don't want to run forever. The shorter runtime will only apply while
the task is runnable and this task should run 1st or almost and go
back to sleep so its impact should be small. I agree that if you have
an always running task which sets its slice to 1ms it will increase
number of context switch for other tasks which don't have a longer
slice but we can't do much against that

>
> I understand that slice is only for ordering of deadlines but just curiou=
s about it's
> effect in scenarios like this.
>
> Thanks,
> Madadi Vineeth Reddy
>
> > Thanks,
> > Madadi Vineeth Reddy
>

