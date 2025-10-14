Return-Path: <linux-kernel+bounces-852684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EEBBD9A97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0175B3AB1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D902314A74;
	Tue, 14 Oct 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGu37ktP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B830F949
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447381; cv=none; b=UnomO/Q8qWWFYjAQ0dr6/lqt6CM8vP5q3vUBD8wu3/tWSQIZSQn6m+/jseZokdYY751LvQibAZOel1ByXfNvGalS+knwNaKk6Si5Jzis2TfaEyrSQxXE/pwJyQsCuknUC1h5vGfVfkJD2sBHemTn5U4Zd35JzMRmD/ZFrRbOsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447381; c=relaxed/simple;
	bh=TrP32CCyZVGRO8t22mwdn7DMyjarK0p1mbw9fs+oVBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJe6mGxdyRkGFlkvpisWJ46nEUwIqbKfd6uucUmXmQNVChx33ahEvgGuuOn8YXPuSQyehwm6+r1UgTqib6VPJGDrSL+SycOgNGpuAtUcI+iSa2Dj/A7Jp3bVI22SGEriHYLtyVkOO/VhKFbD6pM2FqgUxtwQVNeAjXxRqCi9tNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGu37ktP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760447378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/j4fnNPw8xpYuDJO1o02FCXiuLtXdqBOYuHxFNejeY=;
	b=TGu37ktPMQTPN7arxeCmKs9E6lztM/7+4NF40YFa4uY9r/+04i0sSO527XFzwlQbo0izgn
	82JjQuIuwZhfL7NJwILJo3rMcUtNVK68mR/kQaS6glWJfAhgjcwkaxEiKnSqpWx5eigIWZ
	8XS7Hw3TeSdu0tV3xgkZrP2E7Lljlv4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-r-bLG98HPl2gYRmBPMctUw-1; Tue, 14 Oct 2025 09:09:37 -0400
X-MC-Unique: r-bLG98HPl2gYRmBPMctUw-1
X-Mimecast-MFC-AGG-ID: r-bLG98HPl2gYRmBPMctUw_1760447376
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269af520712so99688785ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447376; x=1761052176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/j4fnNPw8xpYuDJO1o02FCXiuLtXdqBOYuHxFNejeY=;
        b=MDvEmdYX2gkhPqPFtFj2fxVJ0yEai9fWEY6NCsBkUcQ8gNdOOTHBX8Y4gE6UuPkGSa
         BN4EAQwRTiLn62MRkhqnqfm8dPxy/q6M5KNl8VSGExA0wBuDpIDNJhAuqwc4PDgxZfqV
         ZNqxAk2sSnPz+p7VsHu7GWDj8JEEl+7kreCX35t15oHibkwIPaBErbDo1Nfuv0KojEwE
         yC81+F9dxPXHNMEHCU4uL1RHXithBXgFbM6kSHGCF2Fb606e3oRZHlC0XXZYm15KI97P
         mdsxIgRgf2CdsJ02MjvGg/X9XiSKr12hG6twie0AdkaYCoioc60FyuLWeooEP7KzZ7Q5
         e3mw==
X-Forwarded-Encrypted: i=1; AJvYcCW4zjIWX+CN4wewCb5VhflJ8tjhJtEHC8c0md47yxEUgsyCnS6NoBcAZCWM815Nb1uKGURJSwnf/BckGf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrCJMIbyH/KHtV66gXBAimLgy06G+gbYuumwmSuLEFiRvE8Et
	r+Y/2+5kPymwBMQmdCH3TWrOTn9hQrsJo9E8XsXJZ6ckaj3Ls1D/df4jeV0v1ZWSFYeQH7tyDrm
	GDOVM2yJN30K68QcucRPnzD9O2eiXqKGD30JcqvKw5wDz01knaGNHgQlzLaL93BzGXKEWpNHKCV
	9z8VJFIpCzT/e6791J6dUj2cxaeZ3neUhO+jX2Eb0g
X-Gm-Gg: ASbGnctAkrwATWKPGucNFG6gyu8rPq9inEVYhQ3LxxP1EEZQkUNOudJb0CrLYPo35Tw
	UTDtMyt8hWXsHClwQMXJx4ZM+tWQRSiBrcvGDxaiccRdGmKUWRoQvUVza0REgTvtHUvxcQuK4mv
	qBsJl/ATBLbxEu1v/B7D5r5w==
X-Received: by 2002:a17:903:1b0d:b0:27e:ee83:fc80 with SMTP id d9443c01a7336-2902741f56fmr278502275ad.57.1760447375895;
        Tue, 14 Oct 2025 06:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs1i6dA1qn9RJPATHJa+lt5gIe1N1iZuuKEYCbVtVtylSs68XJ3a1ryegM0jvVhwbcA0kWJmPRTlPVv3z8nK0=
X-Received: by 2002:a17:903:1b0d:b0:27e:ee83:fc80 with SMTP id
 d9443c01a7336-2902741f56fmr278502005ad.57.1760447375293; Tue, 14 Oct 2025
 06:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb> <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com> <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
In-Reply-To: <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 14 Oct 2025 21:09:24 +0800
X-Gm-Features: AS18NWCYsx1WZef9Zr-wMGig_EYxnzdRSg8VmEkF_yrCq8DAS1t4VGVG6m71ppg
Message-ID: <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

Thanks for sharing your perspective.

On Sat, Oct 11, 2025 at 12:26=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
>
> On 10/6/25 14:12, Juri Lelli wrote:
> > On 06/10/25 12:13, Pierre Gondois wrote:
> >> On 9/30/25 11:04, Peter Zijlstra wrote:
> >>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
> >>>
> >>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
> >>>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
> >>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack=
),
> >>>> it is not "transparent" from a bandwidth tracking point of view.
> >>>>
> >>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufre=
q_schedutil.c#L661
> >>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cpp=
c_cpufreq.c#L198
> >>> Right, I remember that hack. Bit sad its spreading, but this CPPC thi=
ng
> >>> is very much like the schedutil one, so might as well do that I suppo=
se.
> >> IIUC, the sugov thread was switched to deadline to allow frequency upd=
ates
> >> when deadline tasks start to run. I.e. there should be no point updati=
ng the
> >> freq. after the deadline task finished running, cf [1] and [2]
> >>
> >> The CPPC FIE worker should not require to run that quickly as it seems=
 to be
> >> more like a freq. maintenance work (the call comes from the sched tick=
)
> >>
> >> sched_tick()
> >> \-arch_scale_freq_tick() / topology_scale_freq_tick()
> >>    \-set_freq_scale() / cppc_scale_freq_tick()
> >>      \-irq_work_queue()
> > OK, but how much bandwidth is enough for it (on different platforms)?
> > Also, I am not sure the worker follows cpusets/root domain changes.
> >
> >
> To share some additional information, I could to reproduce the issue by
> creating as many deadline tasks with a huge bandwidth that the platform
> allows it:
> chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
>
> Then kexec to another kernel. The available bandwidth of the root domain
> gradually decreases with the number of CPUs unplugged.
> At some point, there is not enough bandwidth and an overflow is detected.
> (Same call stack as in the original message).
>
> So I'm not sure this is really related to the cppc_fie thread.
> I think it's more related to checking the available bandwidth in a contex=
t
> which is not appropriate. The deadline bandwidth might lack when the
> platform
> is reset, but this should not be that important.
>

I think there are two independent issues.

In your experiment, as CPUs are hot-removed one by one, at some point
the hot-removal will fail due to insufficient DL bandwidth. There
should be a warning message to inform users about what's happening,
and users can then remove some DL tasks to continue the CPU
hot-removal.

Meanwhile, in the kexec case, this checking can be skipped since the
system cannot roll back to a working state anyway


Thanks,

Pingfan
> ---
>
> Question:
> Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
> is this comment actually correct ?
> /*
>   * Fake (unused) bandwidth; workaround to "fix"
>   * priority inheritance.
>   */
>
> ---
>
> On a non-deadline related topic, the CPPC drivers creates a cppc_fie
> worker in
> case the CPPC counters to estimate the current frequency are in PCC
> channels.
> Accessing these channels requires to go through sleeping sections,
> that's why a worker is used.
>
> However, CPPC counters might be accessed through FFH, which doesn't go
> through
> sleeping sections. In such case, the cppc_fie worker is never used and ne=
ver
> removed, so it would be nice to remote it.
>


