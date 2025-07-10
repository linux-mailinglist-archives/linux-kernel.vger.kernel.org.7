Return-Path: <linux-kernel+bounces-725464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD4AFFF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0417AA2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1A2D9480;
	Thu, 10 Jul 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdcaIjK+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E2246788
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144028; cv=none; b=uOxuXZRggtiwjUKwIwt2GzfrZyWlVY/7iqI4FlQt4FFyXY/ELDAXzQCfwHKDWY8jj/74zen9PPA/WQrP8gyrvSoHHyYuMV8CK9+7/5Axos889tioZYkP4lGaK67X3+Tk9s0DsbsFUgNCIakIuXUUWZr8EC0+X+Dc5be2dlPRBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144028; c=relaxed/simple;
	bh=tZYkt1wHfFgclzc9+++8gCCPjvT9rGdbcRQ4jkMYiag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouVc2mNLxmilNU29tYdmbZCRB3yYoRpfU/Jz7eH9ucrgY91vV7mtCpH++Z2Hsdd8ZSpKwZYMPQ0/hcw0C8x/qul6Rm1Rz+lFN9PodQz158sBwbRWtRqli/YcxOxeX+HvBje2d/rwYqtp7xz8ASxhnu89MMyhKEtCRQNt0Jil4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdcaIjK+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so142425566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752144025; x=1752748825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3lBgrRkY9T03KrkfK/qnx0n/r8D943tnCxWnGQKULI=;
        b=qdcaIjK+tkBxeMvL0Psx4+nhpvdxZ+1nSEjS2bLiTBFHipI2Af7Wy9zZQVaavPq1Bj
         JpG35xG1DWkDX4/PsU2zLX00uitv3xZntgiN2oH73VqLfrMFekfqrXflz3CI/v//GVW5
         njmN7P/3cvRGu6ll3sI/1pYP+WDNuFviWSrtkyPuXiA74T4NUbu5+kjRTw5Lnq4LT3Yd
         DOlzVNdvLc8YHerV9+2p3An01ZMngCQVrcBKcpV8cY6p2qcP4FNv+v8gIgLgP7WT4+GT
         1AYaDUC8rHnY6z5MHgiwZfuZI+SeUKKKCdX7GTDRWrgssFlw/6HOTDWOfQfHkf2x4ZIt
         uSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144025; x=1752748825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3lBgrRkY9T03KrkfK/qnx0n/r8D943tnCxWnGQKULI=;
        b=rH4C2zAkEDruUWZuTdEYY9w3JwTIzsxYD1oeSzP3ADNLnYtCrH4vOvX6XoXq/FyKxQ
         zggWjTHkDHGfc1RN5nbDtvpQabtIRsgcepDKXsTfzDOOS83WmcZPtX+LEoUGtdw5BaQe
         TB0Cfj7fVpAhW16Oo09bvE/SvrxVwCw1bqkqVwHvFKQxcnrViF3Z5kqmr67JEH4oUB/4
         4+8Z8no6mVxf1sA8iA27TaNtXLq3sNA6vcIhV4NGE1K15pIXWvbwmwr96NGwm8sWrZLL
         iCAkx3y5qcRYgSLk4wg/IzZKPDNXvM8VHEdX0atVYfPd7fr4hz5cmHm6fQIS1el1Vyi0
         +BXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5UflR9wBoFrg6WRHGQMVwlkRz6VGuGzVGXJI/DBQL4RM/eteVw6pzo2NDiuRTtz2Dcv1RAolSRnbEAe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcexv6a2SEEfSHMeKlPd1TD+7zuPVek9Fa9EgkBrLWIBys7jz
	eweqMiQh0aeuCtaS4ETpBwDVIpkMSiUoP7x0QOSd6o3GdhqpEl+AicP++k5Ds+2Et+8KBpa7oeV
	EvXGJ9rsIjOxRixlx4QjtDAqJ+rU+idhijp12FUogxg==
X-Gm-Gg: ASbGncuSFJGCsRrqkTurWh/B6n2jGuaqd+5yZ81i+9hPerIJbE6usKKgJYD6I/80F/U
	xSZfDoVM7btsYbKsscf71fBlzUenP+4im9nP8DgNkgLKbMK4xoding6hnGvECwm3YiKuBqidsBS
	18XQY3Ooh9FSmg1VqFKeM19Xo9bzSP4ph8yogaQdE3CyHhhMLyNqxrkC+uNO20WPEjYjBxGbVHD
	TNqlwHyrKo=
X-Google-Smtp-Source: AGHT+IF5yFQ7tZzTHHUw7DEo/RY1HZuGPuE/k1wjMuJBT7UU1MzDMBXUuF0aWPGH1ZxLUY9pZ8pLdLEPrZ524zI2L40=
X-Received: by 2002:a17:907:ec06:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae6e10d0ba0mr289116166b.22.1752144025149; Thu, 10 Jul 2025
 03:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org> <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
In-Reply-To: <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jul 2025 12:40:12 +0200
X-Gm-Features: Ac12FXxGGrOMNostL61EIJA8xnD-s44uZwKJ4F-Sxa8oDPm3plOWyRyAseX120o
Message-ID: <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, dhaval@gianis.ca, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025 at 09:00, Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Vincent,
>
> On 08/07/25 22:26, Vincent Guittot wrote:
> > Run to parity ensures that current will get a chance to run its full
> > slice in one go but this can create large latency and/or lag for
> > entities with shorter slice that have exhausted their previous slice
> > and wait to run their next slice.
> >
> > Clamp the run to parity to the shortest slice of all enqueued entities.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7e82b357763a..85238f2e026a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -884,16 +884,20 @@ struct sched_entity *__pick_first_entity(struct c=
fs_rq *cfs_rq)
> >  /*
> >   * Set the vruntime up to which an entity can run before looking
> >   * for another entity to pick.
> > - * In case of run to parity, we protect the entity up to its deadline.
> > + * In case of run to parity, we use the shortest slice of the enqueued
> > + * entities to set the protected period.
> >   * When run to parity is disabled, we give a minimum quantum to the ru=
nning
> >   * entity to ensure progress.
> >   */
>
> If I set my task=E2=80=99s custom slice to a larger value but another tas=
k has a smaller slice,
> this change will cap my protected window to the smaller slice. Does that =
mean my custom
> slice is no longer honored?

What do you mean by honored ? EEVDF never mandates that a request of
size slice will be done in one go. Slice mainly defines the deadline
and orders the entities but not that it will always run your slice in
one go. Run to parity tries to minimize the number of context switches
between runnable tasks but must not break fairness and lag theorem.So
If your task A has a slice of 10ms and task B wakes up with a slice of
1ms. B will preempt A because its deadline is earlier. If task B still
wants to run after its slice is exhausted, it will not be eligible and
task A will run until task B becomes eligible, which is as long as
task B's slice.




>
> Thanks,
> Madadi Vineeth Reddy
>
> >  static inline void set_protect_slice(struct sched_entity *se)
> >  {
> > -     u64 quantum =3D se->slice;
> > +     u64 quantum;
> >
> > -     if (!sched_feat(RUN_TO_PARITY))
> > -             quantum =3D min(quantum, normalized_sysctl_sched_base_sli=
ce);
> > +     if (sched_feat(RUN_TO_PARITY))
> > +             quantum =3D cfs_rq_min_slice(cfs_rq_of(se));
> > +     else
> > +             quantum =3D normalized_sysctl_sched_base_slice;
> > +     quantum =3D min(quantum, se->slice);
> >
> >       if (quantum !=3D se->slice)
> >               se->vprot =3D min_vruntime(se->deadline, se->vruntime + c=
alc_delta_fair(quantum, se));
>

