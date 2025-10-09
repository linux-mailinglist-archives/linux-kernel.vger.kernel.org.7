Return-Path: <linux-kernel+bounces-846353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170AABC7A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BE719E6CED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7B2C11F6;
	Thu,  9 Oct 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+rSQLlp"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED027E1D7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994280; cv=none; b=fjk1KGT2gCWZm+fDicWtV7gruEzhRSzmf1f824cIsV5h9lwlzzZY9AaVFIIbDTuxvHM4EAXIYFjRUW58GsAujfm1Jmsw6QhPvOUDOQQ+elsya94hCWBEVHosA28yzSWzvqaYI5fBx6dAwqnZqsS8YsHcyMEstoltMq8cbUm8L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994280; c=relaxed/simple;
	bh=MzaggMkgox+f14ZSjk/4xD4ogb/SfsQXZLmM6Zz0BCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfHAHqd/ytOcvK8GyW8Y/FXNAI9ztuuCwLrCHKv4uwoMxFEYwAXI4nNO0bfcgnHbme6R2pCDJnnRXXk2N9w5vvth0emm9U4eGFm8cwC2nkpy9+mljaVdnNDBcumuHzn6RR/2l2pGcPLL6UTaBZhb8cAGmhub5OAKXZw+0oJ1Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+rSQLlp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b554bb615dcso388057a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759994278; x=1760599078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=Q+rSQLlphyJbr0AXy78m/ar9FaN3KjHqa8IIQeKIp+1gjsv9p7Jglqdmxr2xfB4NlN
         HStaCkPMwNvtEjMXMbi9FfKmIlYHGAR1fTeV38GyN6tP9SK6IZuKBcy6Ao0jraWk+uWC
         yMP+0fmz7CFr/DNAkyG9SvYZ/j5IATZ/alk01f6uJkSQUtzVPGzLgDCSBA6By544JZoR
         4wJjkV2dYBuJeyr2ATD6xI4Q/OPD42z0epys9IyWu4Qi7ewpRII3YyKqElSAYI4tF0FG
         bheH/kXsWeO9Z4P+IbD5GLEYXKRQZzmRTt9m6C72Wgz5ShPT4FXuEyjTqExrGkvPNnIW
         eX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994278; x=1760599078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=NBsi7F/OU+8h47O8jGPwra6iSAArBoro++exSMet8QvyUjEkvqP/J4g2ljbtiFwde/
         yxaUy1xwLxxTwC2hg/OkV/78hRZwOD6Z0vnDnEOufxlK4bj9RqSigWpz0mtyDrOsjckt
         zqotgStfZZ9F4jGk6OnZo+evFQOb0IcF0XovKUwecCeBOyhv7nIiTf36IWp+8KQrwKMs
         ofq5QzA+RyOHHTIybddv66uFEAmwFIf49pqVYy6BCTiEeK6wWC5jdydRaFavM+CYf3M4
         EgdXx9yDzZiSHJL66S8fQgr8azA0AvbGwj4bdobFHiITr0VGkqcG/OG7pte+KGwQkjaN
         6DuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsMaIzV54BWRdAV59+p/0ld56pxk46FDDyPjB+IqDPsTNC2rfnIYwxL8/evldOp5R7Mzo4sBuliWAlVeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjp+QwZVTEiT44lwSkNekkO6QpZaCZmwu3aHbs1ITvMRuc84U4
	gY5+pNYRpEVjYhXSWb6Qg6x8VocIMEC767PDIbk/1aiFb85tN52xo3uJriSwjVqt37xleadzICR
	1MGv8rZArj/DQxrC+roc1ITmtaX9xSN3fJothpNpXvw==
X-Gm-Gg: ASbGncssjf63S0xOzmAU2t8d/3DHbVYqi5wfdq/uefqEhaxX6zAQ4QV2NOWQPQx615h
	GyEmndDXcma4zQk82E4uVNmaWbJY7aqmQAP4CnAAiNIlcSbPms8MI+05swxZrsbhsXlRjRTJ2aC
	H9lKrvFKW1AWInemdZOGyr7mnzf7NbfqTpK9y1tSEa+fQuvudY7NS7jMwXBTosdwhSQTmdP2mtv
	bhPIxQZ2+kiw8KurIaxjApatnRa8DkHbaNNoboVjJPVNvVDqCKWI+dmOxIH92f9
X-Google-Smtp-Source: AGHT+IFn9r8crdkPQsk70/0LPQo6O8jmgoxx0cOasKw14vHSrY8R2tzadEUxcInhoqfSRDPYYjYKGZ+AUFL0QoR/aCs=
X-Received: by 2002:a17:902:ce81:b0:250:b622:c750 with SMTP id
 d9443c01a7336-290272d7330mr91020805ad.27.1759994278066; Thu, 09 Oct 2025
 00:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com> <aObK2MfxPyFcovwr@slm.duckdns.org>
In-Reply-To: <aObK2MfxPyFcovwr@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 9 Oct 2025 09:17:44 +0200
X-Gm-Features: AS18NWCFFG2jZlx24PTDm78yxWfINpT0vMvRGNXbx1D6IurrdBPCv36qDUVfa-g
Message-ID: <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:34, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 08, 2025 at 05:22:42PM +0200, Vincent Guittot wrote:
> > On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
> > >
> > > > > +static struct task_struct *
> > > > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > > >  {
> > > > > -       return pick_next_task_fair(rq, prev, NULL);
> > > >
> > > > The special case of a NULL rf pointer is used to skip
> > > > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > > > pick_next_task() slo path when prev_balance has already it. This means
> > > > that it will be called twice if prev is not a fair task.
> > >
> > > Oh right. I suppose we can simply remove balance_fair.
> >
> > That was the option that I also had in mind but this will change from
> > current behavior and I'm afraid that sched_ext people will complain.
> > Currently, if prev is sched_ext, we don't call higher class.balance()
> > which includes the fair class balance_fair->sched_balance_newidle.  If
> > we now always call sched_balance_newidle() at the end
> > pick_next_task_fair(), we will try to pull a fair task at each
> > schedule between sched_ext tasks
>
> If we pass in @prev into pick(), can't pick() decide whether to newidle
> balance or not based on that?

The problem is that with dl_server, you can has a prev of a lower prio
but still want to run a newidle balance :
-cfs task preempted by dl server
-cfs task migrates to another cpu
-we want to run newidle balance when cpu become idle

>
> Thanks.
>
> --
> tejun

