Return-Path: <linux-kernel+bounces-854196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62411BDDCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957AA188C55A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099931A547;
	Wed, 15 Oct 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWZ0mDmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49421314D0C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520957; cv=none; b=po8kJxrcTPlWgRk8xmqbnuc3Ds16Hl72kGqNV09kLJKP2xpAFtXjLxQtFh4Cg6LhLPPOrOK3Nles93BYH+eSq8KQ25nJQRrRCIPcZFxZ5HgSkEy8ma8RSJaow2b8sxQ3SYUqjH6JZ5Q5IcunsPVr9JX1b/x3ez28JAKi2nrRnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520957; c=relaxed/simple;
	bh=SAaTWTuJrcCmTfoeIHIkseoTyj7SdD+WNtx1Vu6HZB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw8wPhloShI5yzN1IUndOkwYV5iEtAdGRYmEc7MZURtRuI7ieuraOCoRKDYND/NRRYP92SRpk4Do5/xmyjHNAIJ+sbGLPvSWqW7YhLxY9gOB3O//XWws0Ltp9HsPsjDF6WOL9reZhFbc/X/quP9XxBWT2WSFqM7ZyZq+pjMOPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWZ0mDmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760520954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnjbAAE44cfcG2WtQ64BW6kWGfa583/EFbUPiE8s7Ao=;
	b=fWZ0mDmWFLnU3CNtfbK61YeXtKx/Yw+ED93Bwbxy/VrLQAuUAbXKntUjsYRi3fSP9L01jW
	7R/0Wm90uYvPSbNrNn3Tzgfrp3VTG8bZF5I4VKHqBZqGirgu9E3slaNA5KMnLBrWwe0VLc
	drxvuEOKPkdifR0umZeWmVnLgMG2pgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-NygKqNEeNwO-eR4980q27g-1; Wed, 15 Oct 2025 05:35:52 -0400
X-MC-Unique: NygKqNEeNwO-eR4980q27g-1
X-Mimecast-MFC-AGG-ID: NygKqNEeNwO-eR4980q27g_1760520951
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so4943475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520951; x=1761125751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnjbAAE44cfcG2WtQ64BW6kWGfa583/EFbUPiE8s7Ao=;
        b=NEpa4Y0L8jg79Xi2fyia4VJRBa/iHLrkjrCQJBF+12KSdTy/odQi+tj10mt9G4A0+h
         hGi2dCd577jjQ7nMEJ5/PanD9IWS9nzVWHQmIVgTr8C7O/oKprS1hlUgVwi2yy699uAp
         G+mBysuU7Q3NZeh1sNmt/3PFeTt8QbQLrtKfy87OtXMBqkafbmEeSgknUgTQNYCQ6Nbl
         nR5lh1ymexMY1uege3qi0Hrex08Yg6nV8ymtAix//iV9arKNGNnlMBeFmcdHvy+IDHNa
         jpr+oYAeys31GE9jHpWbpDiryZUU00nfkwrJB65IBKVh6a3Uo12drXMBhnYq1Ib0grUI
         eaGw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4JPaT28tIRanRjj5s+BpM7Xri2uzB3qSszREjFSJmNQIWFjlWsgXr2n1XT/m5saCgVXjn+Co6dBKtHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6DupRDyiRMSTR/sXPaKR3GObAMMD5cqqMRimkfuzBS7fBaGZ
	KPqLwuLnbeRrcvdpOLwKkDD6ox5iXbGYlM+x2EfQbjjX8akSzkUIemFWQQ5OrRsm4jSu9DeKbD8
	yIgUlmlg+8fRyScfqakz1j1nlXvwk0HpjzXu5VB+szp4EoPBR3M51IgXABCOuCnn+0w==
X-Gm-Gg: ASbGncuUE1VEEo+0M05b342iH6CQm5nIQ0N/FyYxxY+vg68Al0Q75drUcGg7SuG8SE3
	hxMa9L84NIlbKibNgENOn+c5dnLHe20Bq2IiACGSGissvwf3UHditYXBrgtj5INjDFN0CTqzKtR
	rQpjQXzNqbq7qo8sU1+QqRvSkep0H8brsPZfJ31lDvaoj4Vg4/2F6J6++SXqzzoHB2o254dub3b
	UrW0Nv5JqRkRW0C1X6nm/h9ZHgb+K3QlDduICkLYzHMjz0jXIo0BFORnusUZkmuEEz41i9lwK72
	5pQY6xh04dxdIf45a22zt5AmhIptL1ZZZStRc0n4TcN4fEDr8u1q21x6mUgO9WRHqgb/FI9R
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-46fa9ec796bmr209102855e9.16.1760520951384;
        Wed, 15 Oct 2025 02:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo13nIXlK6rrWAan5FpCkuO3+ZaZ3UhcIAxykoRd6It7aH9TFCFv4gquDLwOTrZuC+/GypTg==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-46fa9ec796bmr209102585e9.16.1760520950935;
        Wed, 15 Oct 2025 02:35:50 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c03644sm19989865e9.8.2025.10.15.02.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:35:50 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:35:48 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>
 <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
 <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>

On 14/10/25 21:09, Pingfan Liu wrote:
> Hi Pierre,
> 
> Thanks for sharing your perspective.
> 
> On Sat, Oct 11, 2025 at 12:26 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
> >
> >
> > On 10/6/25 14:12, Juri Lelli wrote:
> > > On 06/10/25 12:13, Pierre Gondois wrote:
> > >> On 9/30/25 11:04, Peter Zijlstra wrote:
> > >>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
> > >>>
> > >>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
> > >>>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
> > >>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
> > >>>> it is not "transparent" from a bandwidth tracking point of view.
> > >>>>
> > >>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
> > >>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
> > >>> Right, I remember that hack. Bit sad its spreading, but this CPPC thing
> > >>> is very much like the schedutil one, so might as well do that I suppose.
> > >> IIUC, the sugov thread was switched to deadline to allow frequency updates
> > >> when deadline tasks start to run. I.e. there should be no point updating the
> > >> freq. after the deadline task finished running, cf [1] and [2]
> > >>
> > >> The CPPC FIE worker should not require to run that quickly as it seems to be
> > >> more like a freq. maintenance work (the call comes from the sched tick)
> > >>
> > >> sched_tick()
> > >> \-arch_scale_freq_tick() / topology_scale_freq_tick()
> > >>    \-set_freq_scale() / cppc_scale_freq_tick()
> > >>      \-irq_work_queue()
> > > OK, but how much bandwidth is enough for it (on different platforms)?
> > > Also, I am not sure the worker follows cpusets/root domain changes.
> > >
> > >
> > To share some additional information, I could to reproduce the issue by
> > creating as many deadline tasks with a huge bandwidth that the platform
> > allows it:
> > chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
> >
> > Then kexec to another kernel. The available bandwidth of the root domain
> > gradually decreases with the number of CPUs unplugged.
> > At some point, there is not enough bandwidth and an overflow is detected.
> > (Same call stack as in the original message).

I seem to agree with Pingfan below, kexec (kernel crash?) is a case
where all guarantees are out of the window anyway, so really no point in
keeping track of bandwidth and failing hotplug. Guess we should be
adding an ad-hoc check/bail for this case.

> > So I'm not sure this is really related to the cppc_fie thread.
> > I think it's more related to checking the available bandwidth in a context
> > which is not appropriate. The deadline bandwidth might lack when the
> > platform
> > is reset, but this should not be that important.
> >
> 
> I think there are two independent issues.
> 
> In your experiment, as CPUs are hot-removed one by one, at some point
> the hot-removal will fail due to insufficient DL bandwidth. There
> should be a warning message to inform users about what's happening,
> and users can then remove some DL tasks to continue the CPU
> hot-removal.
> 
> Meanwhile, in the kexec case, this checking can be skipped since the
> system cannot roll back to a working state anyway
> 
> 
> Thanks,
> 
> Pingfan
> > ---
> >
> > Question:
> > Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
> > is this comment actually correct ?
> > /*
> >   * Fake (unused) bandwidth; workaround to "fix"
> >   * priority inheritance.
> >   */
> >
> > ---
> >
> > On a non-deadline related topic, the CPPC drivers creates a cppc_fie
> > worker in
> > case the CPPC counters to estimate the current frequency are in PCC
> > channels.
> > Accessing these channels requires to go through sleeping sections,
> > that's why a worker is used.
> >
> > However, CPPC counters might be accessed through FFH, which doesn't go
> > through
> > sleeping sections. In such case, the cppc_fie worker is never used and never
> > removed, so it would be nice to remote it.
> >
> 


