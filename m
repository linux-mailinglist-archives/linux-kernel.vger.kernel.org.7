Return-Path: <linux-kernel+bounces-775385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B524B2BE94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29973BA3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096B321F55;
	Tue, 19 Aug 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grf2Tql4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53131321F2C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598138; cv=none; b=LMAQedx2TBMKfJYDawz+9yl06SXc9uN7Qf2LwLw3Dp6Dy8kHF1J7VHc4u/q26SJY+EEE44VbqGK55FkZT6Hd8Vf6EBKz/5wVmdajuKIBFwVxtqClxZ+JlXhC3wUAqSd1rACoDer00rpku/piRZPL38j40x0SlHdPD1YM5jnbv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598138; c=relaxed/simple;
	bh=NHPHtH9ALf8fXP+m7/BR0oKEAA9a42xol7Ri8hb20nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk84wulHdljjSEPFQrS3sm61cpkG2us0Sc2NoBbgwGMysME4P4d0+Jem3iijmhuX3aupbgRqJQMMGipaaXyx/AE5r8jsBb0DvoQz4CqAYPCOzdu92VrDIyS9SaGtaa4zUM1Ceoy5sh7c9B8ft0p4bVymw5pOsUc/VY1IXQkyulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grf2Tql4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755598135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1yexDew6C3Lad0/qhTHuJrwx4Fxi6ziyJpmXWOKMBI=;
	b=grf2Tql4rtBPaEOeCJG3aU+3K4ZqDRajZLmJ9xLJR3wfcF/Uce2uL613dyWzIwm8V3OJ+Q
	LCELe603h+R7+5f6yAInAgE/3iQb7e3VGe9EbThWZX6eeEBF/1DABlyVwiOd9TLx3BbDxI
	ZgwsVDWxlLOChQIawgdxiD6wySEJj6M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315--EpM2c6JOwelVkmouP1RVg-1; Tue, 19 Aug 2025 06:08:53 -0400
X-MC-Unique: -EpM2c6JOwelVkmouP1RVg-1
X-Mimecast-MFC-AGG-ID: -EpM2c6JOwelVkmouP1RVg_1755598133
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c4c2cfso230440461cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598133; x=1756202933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1yexDew6C3Lad0/qhTHuJrwx4Fxi6ziyJpmXWOKMBI=;
        b=HaoOeyuYijOjgZhicn2dg1S4s4cHTaIEJBbaqCHrr2nRAs2oFMpjfksQicIoLx0rgg
         LSWjFzCIvrk+QIPnckWpTHnLTDtFYhnYmY9PJGDc2+dqTv3OvJUb8mQcHRvhyQ85rDRi
         8gbO8G8QJAwp2bVfcIxcbXRR+asqWgPsEe41aFZJaT08Yx3fprGBR3E1B9lMsORc0j9g
         f9At6KyBp6sXxgHaXr8SFa+GdsHUGKKS1zuiibEsFNbt3q0XXkYTg8BTSHKTnELHTbrD
         wwVXUC7D4D8jD/GiOvPITiavQL/8a7kvbq6P59ACyDuPB0Ddjz/uFB8OpHmJKbGv/TVj
         66XQ==
X-Gm-Message-State: AOJu0YxaHAP66h2hnBPIjtR7gqIbXeeBwr+bT7OHlJC9EKrs0WB8xkil
	prr+foinXPRBoxOjoVqt5lL+WgFQ3n53AmGB/Ec5q9R4GDh8OQ+xfOuYXqf8iTD239ux38e3C5U
	4i7uVlKdaA6QwduWoUFLk2SyEFae3TZEMw/0dBz6vP2cAzgyGPwu+VCF/bx9iOasDog==
X-Gm-Gg: ASbGnct9NQPgzjTu1nONYCKNUMy6+lmZuUXde8thQz1xcEq9bX6NhyXDJVbECszPBk4
	n9MjPIfSMAhHzNcHGCHa8wCLdQnGlABMjB0Vf7DRpoBhKQLuuM3MEWEIQFzzonV+42126r3SqbL
	o7vLE6ton91q32JP1aasMscrQTqxnz2pccWA9RtUvntzFd7hvE7IplvTHwYLYgnruKwAw5u1VhA
	jXm82H/E2g5wraSLrM02Ngz3+s/TNnn43NKxSnTW/bP8babIsvPyNcJAj3WAsSkPnz8XXltbBEm
	zndQa4YoZsOKnZY7HgFQvekQ8fu9jem6p+PLtjjbYxeutdFK6pIZRXJkMmJcJdbO0fvo
X-Received: by 2002:a05:622a:13:b0:4b0:82d9:7cc0 with SMTP id d75a77b69052e-4b286c9801cmr24440471cf.13.1755598133308;
        Tue, 19 Aug 2025 03:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeSozDuJgPdcyPhgCPexi8n/y3Ep+51aw5qhD6j4WyoggQ1R/8vBy7fG3x+/dTjFoBKHArIw==
X-Received: by 2002:a05:622a:13:b0:4b0:82d9:7cc0 with SMTP id d75a77b69052e-4b286c9801cmr24440221cf.13.1755598132861;
        Tue, 19 Aug 2025 03:08:52 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b27e7810f0sm19150841cf.47.2025.08.19.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:08:52 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:08:48 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
 <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>

On 19/08/25 11:48, Gabriele Monaco wrote:
> 
> 
> On Tue, 2025-08-19 at 11:18 +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 14/08/25 17:08, Gabriele Monaco wrote:
> > 
> > ...
> > 
> > > +/*
> > > + * ha_monitor_init_env - setup timer and reset all environment
> > > + *
> > > + * Called from a hook in the DA start functions, it supplies the
> > > da_mon
> > > + * corresponding to the current ha_mon.
> > > + * Not all hybrid automata require the timer, still set it for
> > > simplicity.
> > > + */
> > > +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> > > +{
> > > +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> > > +
> > > +	ha_monitor_reset_all_stored(ha_mon);
> > > +	if (unlikely(!ha_mon->timer.base))
> > > +		hrtimer_setup(&ha_mon->timer,
> > > ha_monitor_timer_callback,
> > > +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +}
> > 
> > ...
> > 
> > > +/*
> > > + * Helper functions to handle the monitor timer.
> > > + * Not all monitors require a timer, in such case the timer will
> > > be set up but
> > > + * never armed.
> > > + * Timers start since the last reset of the supplied env or from
> > > now if env is
> > > + * not an environment variable. If env was not initialised no
> > > timer starts.
> > > + * Timers can expire on any CPU unless the monitor is per-cpu,
> > > + * where we assume every event occurs on the local CPU.
> > > + */
> > > +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon,
> > > enum envs env,
> > > +				     u64 expire)
> > > +{
> > > +	int mode = HRTIMER_MODE_REL;
> > > +	u64 passed = 0;
> > > +
> > > +	if (env >= 0 && env < ENV_MAX_STORED) {
> > > +		if (ha_monitor_env_invalid(ha_mon, env))
> > > +			return;
> > > +		passed = ha_get_env(ha_mon, env);
> > > +	}
> > > +	if (RV_MON_TYPE == RV_MON_PER_CPU)
> > > +		mode |= HRTIMER_MODE_PINNED;
> > > +	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire -
> > > passed), mode);
> > > +}
> > 
> > Also, my only concern with the usage of per-task timers is that
> > reprogramming add overhead, so I wonder if this gets noticeable when
> > running some kind of performance sensitive workload in production (as
> > it was reported for dl-server). Did you test such a case?
> 
> That's a good point, I need to check the actual overhead..
> 
> One thing to note is that this timer is used only on state constraints,
> one could write roughly the same monitor like this:
> 
>   +------------------------------------------+
>   |                 enqueued                 |
>   +------------------------------------------+
>     |
>     | sched_switch_in;clk < threshold_jiffies
>     v
> 
> or like this:
> 
>   +------------------------------------------+
>   |                 enqueued                 |
>   |         clk < threshold_jiffies          |
>   +------------------------------------------+
>     |
>     | sched_switch_in
>     v
> 
> the first won't fail as soon as the threshold passes, but will
> eventually fail when the sched_switch_in event occurs. This won't use a
> timer at all (well, mostly, some calls are still made to keep the code
> general, I could improve that if it matters).
> 
> Depending on the monitor, the first option could be a lower overhead
> yet valid alternative to the second, if it's guaranteed sched_switch_in
> will eventually come and reaction latency isn't an issue.

Right, as in the first example you have in the docs. I was thinking it
would be cool to possibly replace the hung task monitor with this one,
but again we would need to check for overhead, as the definition that
does expect a switch_in to eventually happen wouldn't work in this case.

> > Does this also need to be _HARD on RT for the monitor to work?
> 
> That might be something we want configurable actually.. I assume the
> more aggressive the timer is, the more overhead it will have on the
> system.
> Some monitors might be fine with a bit of latency.

It might not only be about latency, as if the callback timer is not
serviced in case of starvation (if it's not hard) then the monitor won't
probably react and we won't be able to rely on it.

> For example in the deadline case, I believe, the monitor is not
> supposed to fix anything, but merely report violations. So we don't
> really care to react on time, but to react at all.
> 
> I'm going to assess the overhead and see how to offer some more
> configurability.

Thanks!


