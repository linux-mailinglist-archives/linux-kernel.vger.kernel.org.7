Return-Path: <linux-kernel+bounces-853054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21213BDA8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED19F50036E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9E1F78E6;
	Tue, 14 Oct 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkWpMkYr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62328C5D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457684; cv=none; b=jpScZ3ylpStY9Q6HiZrlN+ossEYP/yulp6uELVLsIRN9qfubvXlKhpNkUgTeVTVSZV+SuWBM5gP8JDopCRibOsQzQNGuDY9toAUqE5PklwEjEujt6FHm+AvhyNBFWCrR0b8BSG5yvdfAGfVjn3NYpSivonCsQbbdT/uLHggdSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457684; c=relaxed/simple;
	bh=+KEX9AujBtr9lpn8x5RhcaR8WJ/jLlzSf+/S97Bdbzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyE4n+x7abiGoo99F4peMx4GkwJkpNAOGX/+SpQVKGUOLZYBT5CoOflqUjdLhuaAQmre5NDAJsfuzeithetOCAP+yfugF6KfBeNF3jty+MV+YD5i0CP+XaUQ9WH0mQMjgYZ6lYMba2anYoT5bH75g4GWQ4v3c6jka9xyKrpzydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkWpMkYr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760457679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=si61t1vZh5VlgSG2wCpXGWtywTNXsuoswljr9Nu5B1Y=;
	b=ZkWpMkYr8Ep2wJpvsuiTXHVhmeZTWzjiZQq7Rdtvn6VxoF2wtPiA55tS5MLR5GCoAR2WyF
	W6gTRr2Hotpeyhb7P8EUkeWHqJM5LKryZIwscIae2TLARVVCOLe7a9oqZ42Ka3sICkvmL4
	2mYANdKj33YVO7S6UeZN/nXFk3WEimk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-J7TjatRmOgS7SmhuNaRnwQ-1; Tue, 14 Oct 2025 12:01:18 -0400
X-MC-Unique: J7TjatRmOgS7SmhuNaRnwQ-1
X-Mimecast-MFC-AGG-ID: J7TjatRmOgS7SmhuNaRnwQ_1760457677
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so30472145e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457676; x=1761062476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si61t1vZh5VlgSG2wCpXGWtywTNXsuoswljr9Nu5B1Y=;
        b=aHSp3Zyso9ePUIgPofPCVb8Ch1l/Md2OMP9CNqjSTsfJsBSQ0fONxetHBtHev6+Duy
         yWSQs7WRm3B5lGt9+SG7Ffj/fq6cU571+9hMSTDFFYX78WhUJ/b/FHc/JkU26gfHV4Lb
         zP0AIvm0pklq7xWzW99wLh55MfmfZaeso9g6c4CP4J41kxEOH5bM94NICWeTTvAXCTLQ
         KeYqgY9hceoVVlBe0/eV+UNnRB5gTbkxo3us6u3EcUITTyj7YTN6C3mw+PCweZ8QZxo0
         J3ZVlyiKgVmzKJqbdVgvyLea0eTL92KTpdNUsymMejRFs9YS6GoxIM1PpN3dTc1rRbND
         OuEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+7BrpLbxe/Dwd4P7/xcNRTHaoEm/m9yLu09IwmoVo2PeBM/o/HnJAeQbaL4wW0OThh/RnCdWawT1vRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Dt888x1BbvE3g/o5P87EHAzGDvZ2xnZis3VVHCrMOJrDRspA
	U0bcTeMrlu9appKr6OrLqoZeyrsVa+meyQ2vmJo7ncRzy4uX/7svH/aqOkvnbSrIiwlfv6dELrb
	Etdb5PvwLp+GSh/8AHEhV5Q2W0j9zz82ttf1NOcXIGf+mttg5A8ZZNHXtAnR6eQO3AA==
X-Gm-Gg: ASbGnctrOir0LiMg1o72mKJK+kgDkTONbsspXY66tfrELz0MWLaiygd0ZT7aqnraeq9
	vLUjhnA/QpPU5CI1Fr/GpIygIIlMITM4c6sTmB4O24OEC80l55xVImDsZGBU3FYpUf15Doq1B5J
	cXjgRZNYZiVnfgLRZdugwe36pjNkR8yNSNaUDKGKbL7qiakl7uzfevH+QghgMi5Syd9td6TXdkv
	28LKiisctJVcLhqgXTyB/7qyuWujY0g1rmfDlnrjuw8UiGknemhR5XimJzJlJhJ37agMIf7VlkS
	5FDzGpx8Luub1uVA7YeeYfhLaQHGT7opKkM/6hznNlFs300X4+0DeZ/iXbo5sPAKgKPnVz6G
X-Received: by 2002:a05:600c:524c:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-46fa9b08f16mr193744845e9.31.1760457675851;
        Tue, 14 Oct 2025 09:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGEc03ugdLDXxblLvCVdal1R7r5TI2O4yWVpv1koTQqss82OqtTOYQ9wxYSfT9lLTWmMGIuw==
X-Received: by 2002:a05:600c:524c:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-46fa9b08f16mr193743895e9.31.1760457674209;
        Tue, 14 Oct 2025 09:01:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm9701174f8f.38.2025.10.14.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:01:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:01:10 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>

On 14/10/25 17:32, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 12:25 +0200, Peter Zijlstra wrote:
> > 
> > Lets be confused together :-)
> > 
> > So dl_server is active, but machine is otherwise idle, this means
> > dl_server_timer is pending, right?
> 
> It may not be, as far as I see from the trace, the timer expires at the last
> replenish before this "error" and is only restarted a while after, when the
> boosted task is throttled by a tick.
> 
> > 
> > This timer is in one of two states:
> > 
> >  - waiting for replenish; which will trigger and switch to 0-laxity.
> >  - waiting for 0-laxity
> > 
> > So that 0-laxity case is the interesting one; when the machine really is
> > idle, no fair tasks will run and its runtime budget will not get
> > depleted. Therefore, once we hit 0-laxity, it will do
> > enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH).

Shouldn't idle time be accounted (subtracted from runtime) as well, though?

> > This enqueue should ensure dl_se->deadline is in the future, right?
> 
> Yes, this enqueue replenishes (as I can see in the trace), but that doesn't re-
> start the timer. The server gets to replenish_dl_entity with dl_defer_armed,
> toggles that and doesn't start a timer (should it?).
> 
> > Anyway, we run this deadline entity (there ain't nothing else to do
> > anyway), and it finds there aren't any fair tasks, it does
> > dl_server_stop().
> 
> As far as I see, we do reschedule when enqueueing this server entity, but we
> don't stop the server (should we though?).
> I'm going to gather some more traces to understand what's happening in there.
> 
> Here is a trace where you see the schedule just after that replenish before the
> error, but no server stop in there (we have tracepoints so you'd see it):
> 
>       <idle>-0    d.h3.  13.347981: (+3)     sched_dl_replenish:   comm=server pid=-13 runtime=50000000 deadline=14270340997 yielded=0
>       <idle>-0    .N.2.  13.348043: (+62)    sched_entry:          without preemption
>       <idle>-0    ...2.  13.348048: (+5)     sched_exit:           without switch
>       <idle>-0    .N.2.  14.942485: (+1594437) sched_entry:          without preemption
>       <idle>-0    dN.2.  14.942498: (+13)    bprint:               pick_task_dl: Server picked ksoftirqd/13-126 (runtime 0)
>       <idle>-0    d..3.  14.942519: (+21)    event_nomiss:         -13: ready x sched_switch_in -> running
>       <idle>-0    d..2.  14.942521: (+2)     sched_switch:         swapper/13:0 [120] R ==> ksoftirqd/13:126 [120]
> ksoftirqd/13-126  ...2.  14.942528: (+7)     sched_exit:           with switch
> ksoftirqd/13-126  ...2.  14.942566: (+38)    sched_entry:          without preemption
> ksoftirqd/13-126  d..3.  14.942588: (+22)    error_env_nomiss:     -13: event dl_throttle not expected in the state running with env clk=593612020
> ksoftirqd/13-126  d..3.  14.942592: (+4)     sched_dl_throttle:    comm=server pid=-13 runtime=-92390 deadline=14270340997 yielded=0
> ksoftirqd/13-126  d..3.  14.942601: (+9)     sched_dl_replenish:   comm=server pid=-13 runtime=50000000 deadline=15864951976 yielded=0
> ksoftirqd/13-126  d..2.  14.942623: (+22)    sched_switch:         ksoftirqd/13:126 [120] S ==> rcuc/13:124 [98]
>      rcuc/13-124  ...2.  14.942628: (+5)     sched_exit:           with switch
> 
> > Then, if a fair takes wakes (nr_running: 0->1) and dl_server isn't
> > active, we do dl_server_start(), which in turn does enqueue_dl_entity().
> > Now this enqueue is supposed to check if the dl_entity can still run;
> > does it still have time left in its current period, if not, its
> > replenish timer time.
> > 
> > 
> > So where exactly does the fair task start, and result in dl_se being
> > on_rq such that dl_deadline is in the past? That sounds like an enqueue
> > problem to me.
> > 
> > 
> 


