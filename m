Return-Path: <linux-kernel+bounces-786341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE51B3589F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10C3174CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A8306D3E;
	Tue, 26 Aug 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="coY8G13j"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C8305E1F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199765; cv=none; b=ID/M6RTCYjcyb+JOUTdgN/OgW0+m3Hk0eQGLk6Tj4mESAY3dq0f6kkErJL+76pjguZVpW0+UqGj9P1MbCDoFrvlVWaOjIJ9qckrTPezmbDZlL7C6EpE0bUPOBEOfDrm59fKPL0YKy9LejBtkLeEZKWPFsFwU5rhjrIkT9OH4Wf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199765; c=relaxed/simple;
	bh=1y6xXtnsBfcq1kO8jrl/JBy033EpU/0duq6peYZvdWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBgPhvJfRs4K580MDkB9ToahwajQTKvzuV2oZ22K2+B9uP4mNEXLfJHl9Tra+Kb/k3paaC2X2NN2YwJvbLy6o/5NyTD+w79E1NG9rYRlKX7Ksith21Yx3MSlPzsGFoBXJrR+X9BXjcnXJdA89ewKzjAbvMKYEOVexZEGZiU0xXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=coY8G13j; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24687a76debso23631025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756199762; x=1756804562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tcYVYvsM6kA2zwY5YJW0abgLUuueK5NNoX+JNJ1avE=;
        b=coY8G13j08J9SYOCdkQHYVfiUyrieYQA5+xgVtkwKCoxpBEX6orYEdvw4qLLbZJesf
         g+zMshK67gGsVo/gKdkqLCP1/Bn0sPb18VlxaJXdr5YMtZxTmRV2wrRa4dZOgwCEqz2L
         Wa+HQHieWdnrfh0LZBPmL+x7xdRFRI8WP4cLI5p3fqsabKkYZEoAooNOl9BDGECTOlbL
         elKRiX8FFQFKb5rj1DJnASlz2PXTDYq64jV3Hdy6tG8G97kRxfDiv+/45fn6eEsubqe4
         U1QW4h0KAw04mjl/P8dWAE167PZaSz5UTZx1CcgM4iKUAEAIReid+l2VXiYjfY4dfF7b
         2anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199762; x=1756804562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tcYVYvsM6kA2zwY5YJW0abgLUuueK5NNoX+JNJ1avE=;
        b=aRya4Oxvs9xln+39Q3pheV2St1QCyyNiQ1dQXWu1A1PLPm420G92zZnnQ7o3StVCmG
         qR49nd37KPqoXedjl/260T0lrOHfpMP0++Vru7y92uC1xQjk/8gqyyZJItSrNl825hJK
         yhpMocv+v18Hz3awxqCRbT0Gz7Ym3/hXYRLdGYNzMzEe4UIcguVHZ+D9rybc5cacIqMb
         YVvb16Odil/t5ssI853J/qM4+rpe137xHj5JnN57LrxV7ejkOOSE+YhqDHGaJGVbNArT
         m83ITlIuOr0yQi9JIYlph3gsoOIx3z9XMtOeQRZsWqyGOys9FwaeKvxUz2laVuS/NFZt
         q0mg==
X-Forwarded-Encrypted: i=1; AJvYcCVXDoElglMphArFkBkgYthyrvsQL60mtlijlaGnSrLAHyYlyMUZ/V3UfS9elrg1+OxPf14E/rPBKu/Lwu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76BBUzLQY8thi5BPCpYdnI8ZLUvf8A5r3LVQJJQVHdNw6Cqsj
	V3nJU6mRcFTwPsRkzHG6GbRQvkmNlvPHMTualIc2HiCGMJprQUpJ3OPLSNOSgb5sXg==
X-Gm-Gg: ASbGncuMZJoxOQHIBG2ifVtajlIEoUVrI0jU/TTKJMo3gIoT+bKHWPj5iiUkN6RUemZ
	8Z8Y1lXfST5KguPfILBHc67eSzqydDs8fjnRbqA3uIiKk3+pyyYQDaJ7PM0EgI0f32c6LOIPdom
	MY8K/BkTVZ6O1nOlL/vHuoAZPU18LdRbDfWROFzUd3YDig7gmlrShPJ1I94U1889Uun2PjuT8Dd
	XC4Oznc9Mj7+p7341ToJKPrtdOoNFc1UmsEnnwpV2MDrTGRR3Qn1sn021P48x+TZBMkQxajI1Xy
	8cShx8MWlP3PFtjcMnbf3Nsqjs+lqcPwWmz7HU385IA7WguGOQXgnYSnuIuT8hxiaGqIJhmvmWR
	SakZoH7qxMxbUoEivHbj4dry9zjwHi61Z7PNwEsvC+m8xBos=
X-Google-Smtp-Source: AGHT+IFKzh36i/RR/bwLCELe7gb/WIrtsSCl8pnqE3wNQlAA5RehW1rSbbJl/QtH9n2qSYJ+QAkpWA==
X-Received: by 2002:a17:903:1b0c:b0:240:6fc0:3421 with SMTP id d9443c01a7336-248753a27acmr10478495ad.3.1756199762210;
        Tue, 26 Aug 2025 02:16:02 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24692f981c9sm74072675ad.116.2025.08.26.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:16:01 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:15:51 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
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
	Songtang Liu <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
Message-ID: <20250826091551.GC87@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Aug 18, 2025 at 04:57:27PM +0200, Valentin Schneider wrote:
> On 15/07/25 15:16, Aaron Lu wrote:
> > @@ -5287,19 +5287,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >               check_enqueue_throttle(cfs_rq);
> >               list_add_leaf_cfs_rq(cfs_rq);
> >  #ifdef CONFIG_CFS_BANDWIDTH
> > -		if (throttled_hierarchy(cfs_rq)) {
> > +		if (cfs_rq->pelt_clock_throttled) {
> >                       struct rq *rq = rq_of(cfs_rq);
> >
> > -			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
> > -				cfs_rq->throttled_clock = rq_clock(rq);
> > -			if (!cfs_rq->throttled_clock_self)
> > -				cfs_rq->throttled_clock_self = rq_clock(rq);
> > -
> > -			if (cfs_rq->pelt_clock_throttled) {
> > -				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> > -					cfs_rq->throttled_clock_pelt;
> > -				cfs_rq->pelt_clock_throttled = 0;
> > -			}
> > +			cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> > +				cfs_rq->throttled_clock_pelt;
> > +			cfs_rq->pelt_clock_throttled = 0;
> 
> This is the only hunk of the patch that affects the PELT stuff; should this
> have been included in patch 3 which does the rest of the PELT accounting changes?
> 

While working on a rebase and staring at this further, this hunk that
deals with pelt stuff is actually introduced in patch 3 and do not have
any real changes here. i.e. after throttled_clock related lines are
removed, pelt stuffs just moved from an inner if to an outer if but it
didn't have any real changes.

I hope I've clarified it clear this time, last time my brain stopped
working...

