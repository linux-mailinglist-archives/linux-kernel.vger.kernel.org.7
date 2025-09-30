Return-Path: <linux-kernel+bounces-837648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0CCBACD45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DDF188D3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15712FBE00;
	Tue, 30 Sep 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fugJyQzq"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E81C84A6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235260; cv=none; b=HfdyKvYdRRBrdVygn6kZrCQC1Adasz6GmQNxZzREEup99+29Ec2WYP2u06e6iAhicUFQjhNCYv0g9mn9KSBG1k/497P38Y5p05a2U7QuWt9lYIiZzukKhXDwoc95w0Fa1FZnlvIoEVScI5ZmAfAHFt9NsMwc96/+YqeztxHq0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235260; c=relaxed/simple;
	bh=mZrVCu6oFAcWRG1DgiGigyq619XqnM3BxtDHKHdEp1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5FFfh+qBegkkiHNVzYVK6f7kO8Q50Dq2HZQdXOqfu5DIROx4tcRMYvwrbzOmWidW8LP/X8WHTWc+ELa2K83q40Iafi1xK6VKW+563gfd389W9GEQj4COBPw11emyz9xxPjTjy6/YXhAkv6qELitm/zAQbufYCPCpbH6C6jLDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fugJyQzq; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b55562f3130so4111505a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235258; x=1759840058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/Gs1GtQpv3mjTEPXCPEtOH53sN2ZH4db15oLx51itc=;
        b=fugJyQzq520Sc5ROa9TG+35yfqHeHRusMK2SjMehs7vhbeAkVWI+njGpbP0tDqjiFH
         Q04laWoynbc8JDTjpMADXhzYp4ezozw23HqoWH69k8a/a1IcY4cqJUTN5wfqu13gMKR/
         jcudtEw9imukaWrICEArZd1YvTwOugzoZAybtTjAMVURz3KjBBzF8vEIjIa8Fi8yYbIO
         hAsiOmurfghYIYDmL5UNS/p5JwITP8qN2M9DHwKISp+QcndFJo2Y+lbT+HpANtxi/maX
         poRIBWp0qfJu+8JnJDkz8l/c4r1eY+4IEg+zdBQojS/chrqKJJnHsfurUjizwTS6zFDZ
         ChYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235258; x=1759840058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/Gs1GtQpv3mjTEPXCPEtOH53sN2ZH4db15oLx51itc=;
        b=Tr4O23pXCjJNZLyX6O8YEYKWDcBUD3UlP1nbv/BC0hT6jq/DewpWazsobvbaXjPKyd
         TCN00FVwwWSdT2k1tXmudDm+RfAKrY2tLwsqSfQwh43rWg1HCZqfzOqFtoOae4jgt00I
         fnP05zTJ3TXoH3k+ngxRQSSL7g89uRPZTDofFH7LVtWfiJpZ5wYHDz1sYmgRiTGh4TtP
         uu2RNSHo6LEF0vtfkQE+yRo0syQ80iegYWDz345j2V9UXJert/CkLgjq+4ROuTVj9JOm
         RiiPik+Y8ZISbdW1pdkMRx2dmWenY+rN23341doLYv5Ld0g83DQQt2wlCU6MzWf974Vm
         cApg==
X-Gm-Message-State: AOJu0YxuptMbkVo2G4m2Kr6WPq3/VzS4b+TE2+597wcHs06XUkVhisiE
	vitfVvxMUZ9s07GutudyY1N1MS2RR821qV4d1WOODrU3uwA4avVWcw6iy+y3IIz1SCCq6cQY4pa
	7W3wB9BpiHWT0Qx26ecwnwJPSDfTvV8w=
X-Gm-Gg: ASbGncvL1EDZAwVHoJC6FBsnCd2kCTJ1TcWJvrXPtAfxUUZ/HtVeKyYZ5G0taDcrYhc
	Dr/EMrZocyyMUvpGucHmAPU/D8wjPXuZXxhzSWq7E92e8ZKvo8Gd3dnQgGSFtrp6Fob38jQodI0
	lmDFFwfoGJ/tzgRaYNSCdnGS2F44XKeVs2yH+vwaUXZ40WZsBAeImMyolP0f+SSidCJ1qZsFx/P
	AddefVOrQDK6UoKJaNU3/qGdiQTQUKuc9Xi1WTYisQ=
X-Google-Smtp-Source: AGHT+IFYBbMPMSwBmQBAJTaVIPRMVnXV024pCOihSccBzftHQhFBeqYF4guOyUbbqZowTrYBsOB0U1vYIWl8sPoKGTw=
X-Received: by 2002:a17:903:ac4:b0:25c:76f1:b024 with SMTP id
 d9443c01a7336-27ed4a0e498mr256269305ad.25.1759235258362; Tue, 30 Sep 2025
 05:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929061213.1659258-1-jianyungao89@gmail.com> <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com>
In-Reply-To: <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 30 Sep 2025 20:27:32 +0800
X-Gm-Features: AS18NWAUyg7yURBiRfDQE72ZG00vRe-QNREru7BIag6sQVxjJSKpQ3IiqO6_mK4
Message-ID: <CAHP3+4DFhdf7endTX4DVchvQJyZUR0qAhe2SRfhwdQTzS2F5zw@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix some spelling mistakes in the scheduler module
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh, yes. You are right. I will fix that in the next version. Thank you
very much!

On Tue, Sep 30, 2025 at 4:27=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/29/25 07:12, Jianyun Gao wrote:
> > From: "jianyun.gao" <jianyungao89@gmail.com>
> >
> > The following are some spelling mistakes existing in the scheduler
> > module. Just fix it!
> >
> >   slection -> selection
> >   achitectures -> architectures
> >   excempt -> except
> >   incorectly -> incorrectly
> >   litle -> little
> >   faireness -> fairness
> >   condtion -> condition
> >
> > Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> > ---
> > V2:
> > Delete the incorrect modifications for "borken" in V1.
> > The previous version is here:
> >
> > https://lore.kernel.org/lkml/20250926092832.1457477-1-jianyungao89@gmai=
l.com/
> >
> >  kernel/sched/core.c     | 2 +-
> >  kernel/sched/cputime.c  | 2 +-
> >  kernel/sched/fair.c     | 8 ++++----
> >  kernel/sched/wait_bit.c | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7f1e5cb94c53..af5076e40567 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_=
mode)
> >               /*
> >                * We pass task_is_blocked() as the should_block arg
> >                * in order to keep mutex-blocked tasks on the runqueue
> > -              * for slection with proxy-exec (without proxy-exec
> > +              * for selection with proxy-exec (without proxy-exec
> >                * task_is_blocked() will always be false).
> >                */
> >               try_to_block_task(rq, prev, &prev_state,
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 7097de2c8cda..2429be5a5e40 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, stru=
ct prev_cputime *prev,
> >       stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
> >       /*
> >        * Because mul_u64_u64_div_u64() can approximate on some
> > -      * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
> > +      * architectures; enforce the constraint that: a*b/(b+c) <=3D a.
> >        */
> >       if (unlikely(stime > rtime))
> >               stime =3D rtime;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 18a30ae35441..20fe5899b247 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
> >               bool delay =3D sleep;
> >               /*
> >                * DELAY_DEQUEUE relies on spurious wakeups, special task
> > -              * states must not suffer spurious wakeups, excempt them.
> > +              * states must not suffer spurious wakeups, except them.
>
> This should be exempt, no?

