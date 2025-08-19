Return-Path: <linux-kernel+bounces-774740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACDB2B6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCBC3B18DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D22853ED;
	Tue, 19 Aug 2025 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjjxK1M9"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF623185F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568986; cv=none; b=P/u/CMmFXyRLjY6G+8imraEd0M8dlHps20HEp8TTLaMJqje3iaKSqJZvpskT3OZIUiavPVfDYHgd56P4HLZYn+YzHtHmE0lUW4m0f41FikDVLnr9fTGHINWzXzrVP9UN8qBkd3jIrXZxi5Yy3Pse9ltl/xgRxfbaRSfGMkXxITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568986; c=relaxed/simple;
	bh=PMwSt0D8lJt43b4nuQr1l+eODZlQRZb/SwoCfja/ulg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fISyJiLzKl8GX+xwSaUCJCsmyjUTQLzv/D8hgVxVlcFEpqMmzqR+ZyYUTPCMDCV6nV64BuoVWJn53u7zME6SyxJO6OhdfyubzElZucAy4FMoxiupKLZjvKA5n2xxMU3vGIWws67tySaG5Anh2EUB7ZUvSWL/JvLBTt0alo5ZoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjjxK1M9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b1099192b0so78553721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568984; x=1756173784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnQVDQorgVcTCFpd+4ZsjAZWufGtS3gGnispmnp75Kw=;
        b=DjjxK1M9syQu1vrNi91d1BhPtoivv+2R1uerDUQMegy9uWn5sthftjJ5AZiqF02GnW
         edzYc8En1VagkSLPnsPwSGH3Lbjhargcm5xwahRWPk362Ka/4hBheq8vMFH3a5RyjU/W
         BiKsvHOZHoXszOz0mfWa1wGGjldsq8wlH0LM6gIBi7MM8DsFKKIoMWudBVulaoZYA4+4
         utDM9aassM2IyOwxFDPf5+qYWS8MY4xv822Y8ufYCWJbMp5JbDP3j1WdeBv9OtjSWkgc
         bGvQfo8JAKi1hHF8E7GdIY22UmGK3n00PfuVorAXagCz423quTmfL3cXMXOUMC78g4fm
         SoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568984; x=1756173784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnQVDQorgVcTCFpd+4ZsjAZWufGtS3gGnispmnp75Kw=;
        b=QvdyUO/allqWrkXZQibKXgqMnw9AsLiz3yJsnUE/pnX22Vo3ZUMGeiuxTlbKPW5oe5
         F4DaEUfWJx2YDbW+5CCYymO6eEc50hlGde+FHSqF1O6IObbJa7xYR8N+dNdBfimI8yVM
         61ZzynI9shIAgNPqCDXlFjpmzEMauMiPveZLUI+P3vKQ7SRkTbyJ16ssdBCuyB/5YGu7
         iMICV7purU2Cg0LQPDVOI96NT55Ns8h6m1u/Pl5sgbBGgBPuH7udmTzToyxMlRtItXRp
         cfM7jLRJ1fSdLFVMQmhFPCPte0PlKOA6E2ghkWLKe8RC2THDsxFMk4sxLze4QyV765bT
         bJkw==
X-Forwarded-Encrypted: i=1; AJvYcCWHF0oFTauou9bbDmkFvCJ4hoWa3oyncVGZqXtPMo/+/dB2AbDarIApWKXqlUvnUVTqjNRR/6wni7SqPYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDJ77l/gvl82Hi2BVyFNo1zUCNgkG9Ct2XaADnpaC57gyCJLt
	k5sgEzuaDFfgs7ovGDGhqkKJd7UxJqRWgG8DL4gelLCx/+HDWvNZQOYA3DqkRi6zr8XUanPmbvP
	t1azgTxB+hTF/fCX/vCcfMUv5L4W0mVE=
X-Gm-Gg: ASbGncvtuc6MRuv5X66VMdQzTfIXk7KvyMSsU/PaEa68ua/KjZpXuVoOb1v0RqOdb2g
	c0wlcSoGkbocxqiP3tgDBFy55foGlPq4s+BGAep0QeeCWOr4R5hhpLsd/uThgvVRG+NZjQmdaF8
	bCo9aHrUCkSy3u171yzfBM4Fl0scSE9kEAp0LfIYSY4/vDTOkvgBbX6lqPzcyi176hIiu482RIt
	eEHg8xKwX7UmPUNNQc=
X-Google-Smtp-Source: AGHT+IH4Xx+1jXT+aH1dps+VG+kTgOfkxC7UlJT4DreiVn1HHuE9ysS0ugV9c1TvjJe70uf7XRXRP1WHe4BV/r1VRaQ=
X-Received: by 2002:a05:622a:150:b0:4ab:c0ec:6236 with SMTP id
 d75a77b69052e-4b286c974d5mr11155631cf.12.1755568983469; Mon, 18 Aug 2025
 19:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812093339.8895-1-xuewen.yan@unisoc.com> <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
 <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com> <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
 <e3861092-71d3-4f36-8013-d721f60c1392@arm.com>
In-Reply-To: <e3861092-71d3-4f36-8013-d721f60c1392@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 19 Aug 2025 10:02:52 +0800
X-Gm-Features: Ac12FXxOUlbXac0JRSfJKn4QuCnWOjILjFE2DS5uk7wl-mYUowz1M4E-As_Pehc
Message-ID: <CAB8ipk8W8Oj2vu14sGX0wncPpJRD=xL35U8QW1wou-CX+3H0KA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:24=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 18.08.25 12:05, Xuewen Yan wrote:
> > On Fri, Aug 15, 2025 at 9:01=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 14.08.25 10:52, Xuewen Yan wrote:
> >>> Hi Dietmar,
> >>>
> >>> On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 12.08.25 10:33, Xuewen Yan wrote:
> >>
> >> [...]
> >>
> >>>> Can you not mask cpus already early in the pd loop (1) and then prof=
it
> >>>> from (2) in these rare cases?
> >>>
> >>> I do not think the cpus_ptr chould place before the pd_cap calc,
> >>> because the following scenario should be considered:
> >>> the task's cpus_ptr cpus=EF=BC=9A 0,1,2,3
> >>> pd's cpus: 0,1,2,3,4,5,6
> >>> the pd's cap =3D cpu_cap * 6;
> >>> if we cpumask_and(pd'scpus, p->cpus_ptr),
> >>> the cpumask_weight =3D 4,
> >>> the pd's cap =3D cpu_cap *4.
> >>
> >> Yes, you're right! Missed this one.
> >>
> >>>> IIRC, the sd only plays a role here in
> >>>> exclusive cpusets scenarios which I don't thing anybody deploys with=
 EAS?
> >>>
> >>> I am also wondering if the check for SD's CPUs could be removed...
> >>
> >> Still not 100% sure here. I would have to play with cpusets and EAS a
> >> little bit more. Are you thinking that in those cases p->cpus_ptr
> >> already covers the cpuset restriction so that the sd mask isn't necess=
ary?
> >
> > I am not familiar with cpuset, so I can't guarantee this. Similarly, I
> > also need to learn more about cpuset and cpu topology before I can
> > answer this question.
>
> Looks like we do need also the sd cpumask here.
>
> Consider this tri-gear system:
>
> #  cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 160
> 160
> 160
> 160
> 498
> 498
> 1024
> 1024
>
> and 2 exclusive cpusets cs1=3D{0-1,4,6} and cs2=3D{2-3,5,7}, so EAS is
> possible in all 3 root_domains (/, /cs1, /cs2):

Isn't your CPU an ARM Dynamiq architecture?
In my understanding, for Dynamiq arch, there is only one MC domain...
Did I miss something?

Thanks!
>
> ...
> [   74.691104] CPU1 attaching sched-domain(s):
> [   74.691180]  domain-0: span=3D0-1 level=3DMC
> [   74.691244]   groups: 1:{ span=3D1 cap=3D159 }, 0:{ span=3D0 cap=3D155=
 }
> [   74.693453]   domain-1: span=3D0-1,4,6 level=3DPKG
> [   74.693534]    groups: 0:{ span=3D0-1 cap=3D314 }, 4:{ span=3D4 cap=3D=
496 },
> 6:{ span=3D6 cap=3D986 }
> ...
> [   74.697890] root domain span: 0-1,4,6
> [   74.697994] root_domain 2-3,5,7: pd6:{ cpus=3D6-7 nr_pstate=3D4 } pd4:=
{
> cpus=3D4-5 nr_pstate=3D4 } pd0:{ cpus=3D0-3 nr_pstate=3D4 }
> [   74.698922] root_domain 0-1,4,6: pd6:{ cpus=3D6-7 nr_pstate=3D4 } pd4:=
{
> cpus=3D4-5 nr_pstate=3D4 } pd0:{ cpus=3D0-3 nr_pstate=3D4 }
>
>
>   sd =3D rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));
>
>
> Tasks running in '/' only have the sd to reduce the CPU affinity correctl=
y.
>
> ...
> [001] 5290.935663: select_task_rq_fair: kworker/u33:3 382 prev_cpu=3D0
> [001] 5290.935696: select_task_rq_fair: kworker/u33:3 382 prev_cpu=3D0
> pd=3D6-7 online=3D0-7 sd=3D0-1,4,6 cpus_ptr=3D0-7
> [001] 5290.935753: select_task_rq_fair: kworker/u33:3 382 prev_cpu=3D0
> pd=3D4-5 online=3D0-7 sd=3D0-1,4,6 cpus_ptr=3D0-7
> [001] 5290.935779: select_task_rq_fair: kworker/u33:3 382 prev_cpu=3D0
> pd=3D0-3 online=3D0-7 sd=3D0-1,4,6 cpus_ptr=3D0-7
> ...

