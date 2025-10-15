Return-Path: <linux-kernel+bounces-854063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B85BDD761
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F65B354C63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673D306B2D;
	Wed, 15 Oct 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ut7GgrsY"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C33054D4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517657; cv=none; b=U7uYjMEexhUKMwC9V8OR2QHauJ4sHbLU9sEmUozNi7CBBRc9Z67pG3EzB2UeE+/KjnNbNdkAbkBPMnJZo2iyAd/4np3rbKMZ2rncC/DWldhBnviPIm04OcEO+N0zlC9djPWrTIp8PPXUoZgrOIVjca/qrpGGhb2lb2qhdyIMnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517657; c=relaxed/simple;
	bh=Qq3HOmJdRgm5/6ZysVyR3aOcpxN3XPxeBKbeXqItO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVpe1UiWxKjGfPmdtUKEwfEnJzPYaNKHBHtQ1oCcQnDUrnba+rZXbr7JnjIzcIHlyJ5uSIWIKs/CQsbB31F8WgwVRGboGPwfRegGPVt4sv5OpSnPH5g37oCkHhcxvh3zNNoJ1u8ZhZqoufKTZiNZvWnYsGeYXpQRpXV7HX8RK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ut7GgrsY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b62e7221351so5154558a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760517654; x=1761122454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9DJI+T1iSuxvzgFXbQn7g/6PBIXqmK2G5bW2LSEqHg=;
        b=Ut7GgrsYJc6gLkiPl0ODvzRaNXhcxiIfhmaxIZ4A4BtyCazDoQoMAlgMT7icPlk9tK
         yszteKdFzLVfGyu35mh/aQ3MmUhxG04wp7lDnlF+Q8YMSiNnlZcwzII0zSTBd3uHWqp2
         aarRNflvj1Ea/eQ8nJyQjOMTCkIJNQQKs6uEz7V/yvKxeGJyt3LDNNa5cENnPKLKDoK+
         HwNKXi83TIP3zkZGCFJ3BOdvqUH+5Qht8UqI3w8ya1d27Ww/299s5bahkDdT9c/o5caI
         1nbMwTl2C+TK+AWoxKekN0fwWUiU42URz5Qjvd2XhwqtrsR/bPZAOZWUM5ApluVxKllN
         Yd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517654; x=1761122454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9DJI+T1iSuxvzgFXbQn7g/6PBIXqmK2G5bW2LSEqHg=;
        b=YBJz2/dCDe43f8X6tLleU1v5jQeO8IAqRkoANhCSuO+k0uvaJGMjwvefCpDT3SM+VU
         KTmc9LBzs0Vk8F75DQbmgm+pEACiZ5mglt79LItdLNn1NH426iRbTHfi6SUcT40m2vrG
         a4gWn3h7nipE19ZL+dLO1TrukWz3o0s/rOI/L/lAu48rjihQroE5D6BxxdOTQGbJtMpq
         uuf25NR549BlKO8GMIHnWjhwK5IBgwcmzS3fNq71DsuR85XS8gbgPsgRBS76uRqS9TLO
         gjovHW26qYxopK4LQmShJEpiChlpyJ55gJklZKq4oM8EIv0Q3MrirylXpmxQOVvSnIrm
         g2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIjjUTjOoG5vB4Fk7a0FtesTQlihJoNy/W9K1xaAzAuum0O/BWWdyVs+mk3HU/i2s96BD+o3NMZ6pef0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHDDf9ZLl2pA88fBP5TE8Vrk4RQnVzQG0GMrnH2WDG0KcuhOx
	a+1D29+LZisLpJR9QCr/eKFBzJLgDPrj7o7zYiHJuIEla+01xvpIXenZ4E8oZGKokQ==
X-Gm-Gg: ASbGncu+EtU/UaIDcW3fLwEAZlx5rCopbJfIEAWWlbCF/X3Rkw9dpejEhwU/p1ohR2a
	RS/hWApCpuLT8HXBzSoKVFV/ZuF/vkSbD0PA4w5z3RSaY7SMIXnU7pdK9fv6+toGqOLh1Nb7SEL
	6FFu1SXQmLeXTcYePfSQK4JrbxCAS/blyPzXswjlrAhaqViFlki4wRVM7QKK634Dqp+ZHTG5n3/
	lT9p0SovzcIfzGcVqTQiWwFh7DCdO7ftje0pZgEKV9cUhrPF9iXFgr9VwsnY+iBMJwaZsfQNfC+
	l+P+MmSxyHcdcYQO0YAvZCBCbIGcviTF10M4/GiKyLJRTC2VLY5FxzT8TMYgNOGqaEwTw78s5gJ
	rkL1gNhtVQ5NcaZEyoS05ht7MBgb8OIcjnw2x1d87PmZrYmtpaozMSuv5L78ZS4VN7opZ
X-Google-Smtp-Source: AGHT+IEtAhCldQUd9Fc0iXVFQEwbLnMT8V8Grcfj8qfKeaU7kkYLiqgTuUUe7/JY3nNt/phswPguPg==
X-Received: by 2002:a17:903:1b4b:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-29027214ee7mr371076265ad.6.1760517654094;
        Wed, 15 Oct 2025 01:40:54 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08912sm187821405ad.78.2025.10.15.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:40:53 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:40:45 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251015084045.GB35@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>

On Wed, Oct 15, 2025 at 02:31:27PM +0800, Hao Jia wrote:
> On 2025/10/15 10:51, Aaron Lu wrote:
> > On Wed, Oct 15, 2025 at 09:43:20AM +0800, Hao Jia wrote:
> > ... ...
> > > Yes, I've already hit the cfs_rq->runtime_remaining < 0 condition in
> > > tg_unthrottle_up().
> > > 
> > > This morning, after applying your patch, I still get the same issue.
> > > However, As before, because cfs_rq->curr isn't NULL,
> > > check_enqueue_throttle() returns prematurely, preventing the triggering of
> > > throttle_cfs_rq().
> > > 
> > > 
> > > Some information to share with you.
> > 
> > Can you also share your cgroup setup and related quota setting etc. and
> > how to trigger it? Thanks.
> 
> I ran some internal workloads on my test machine with different quota
> settings, and added 10 sched messaging branchmark cgroups, setting their
> cpu.max to 1000 100000.
> 
> perf bench sched messaging -g 10 -t -l 50000 &
> 
> I'm not sure if the issue can be reproduced without these internal
> workloads.

Thanks for the report, I think I understand your concern now.

I managed to trigger a condition in tg_unthrottle_up() for a cfs_rq that
has runtime_enabled but with a negative runtime_remaining, the setup is
as before:

          root
        /      \
        A*     ...
     /  |  \   ...
        B
       /  \
      C*

where both A and C have quota settings.

1 Initially, both cfs_rq_a and cfs_rq_c are in unthrottled state with a
  positive runtime_remaining.
2 At some time, cfs_rq_a is throttled. cfs_rq_c is now in a throttled
  hierarchy, but it's not throttled and has a positive runtime_remaining.
3 Some time later, task @p gets enqueued to cfs_rq_c and starts execution
  in kernel mode, consumed all cfs_rq_c's runtime_remaining.
  account_cfs_rq_runtime() properly accounted, but resched_curr() doesn't
  cause schedule() -> check_cfs_rq_runtime() -> throttle_cfs_rq() to
  happen immediately, because task @p is still executing in kernel mode
  (CONFIG_PREEMPT_VOLUNTARY).
4 Some time later, cfs_rq_a is unthrottled.
  tg_unthrottle_up() noticed cfs_rq_c has a negative runtime_remaining.

In this situation, check_enqueue_throttle() will not do anything though
because cfs_rq_c->curr is set, throttle will not happen immediately so
it won't cause throttle to happen on unthrottle path.

Hao Jia,

Do I understand you correctly that you can only hit the newly added
debug warn in tg_unthrottle_up():
WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
but not throttle triggered on unthrottle path?

BTW, I think your change has the advantage of being straightforward and
easy to reason about. My concern is, it's not efficient to enqueue tasks
to a cfs_rq that has no runtime left, not sure how big a deal that is
though.

Thanks.

