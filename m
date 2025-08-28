Return-Path: <linux-kernel+bounces-789302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F40B3939E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317661897567
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B28222566;
	Thu, 28 Aug 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OSUrm0re"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E33985
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361195; cv=none; b=XizLKoJb80o6SKSCDY4QHo3owTf1zBSyvIdaYkFPwfP6awSnCfCXgEbxVFvymFZB1v+aWU84FvmJVtQ4PlSIik8Y6EXrw8IrEUs57kMjKXiAp9vFIDduuBYurO6cv1djJNe1Ja7cColA5NpJHilgmVS1qZ0Adni/RVinTI4iKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361195; c=relaxed/simple;
	bh=PbKQpGGBilcO6Dj4RoBPEYLZz/I+TRE8oGKTmh0hKP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPSfJ03laxxlNE8iQOd5Xkwc7+WonW58xLDp7tft+txi/aH1hcxaS3bQDXkpnhBIYXwzUN2+Zh8teqnCPUdn1raGYyyj4UvoQ/E2aMp9jUOpypCg8Fuc7Nv09gbWyxuSbdaoF8iucg482HraxJiikeHYiPtTjwWu6suaMauwTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OSUrm0re; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-246ef40cf93so6192315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756361192; x=1756965992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GliZ6abO/W4kEVa9n/07p5t7LxKcC9kcpGmbHvXU58o=;
        b=OSUrm0ree8ASZL8tbO/MqEhcwso1d5lpODCc6uTM9wcegI5LJU8kTYMNwXmee0adAD
         DwlrEVIVtddzMXqtCDzTbXmUIGPfsprwLElZzU1w4bRA/+Zf7k2djB9XlDOxPRoXz7jD
         1brZHERpbnJLX9KaA4vZjQ99DAeieOxHV3aNUqdP2KwGl3opHz0/pY13OMmXbxsE+gRH
         5kfr35iUvT6jGaU/S5VYA1aMPlS+QB2v1egypHE6CrZcLT/rmT+laNcN8xGparffDUG4
         m4N8Bzu/dbgrLpsRxKtT4uxYE+3ptS6KG1oNM3QP/fovfBLaomk1DTaJsal/Y65l8Xb6
         ahTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756361192; x=1756965992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GliZ6abO/W4kEVa9n/07p5t7LxKcC9kcpGmbHvXU58o=;
        b=e1dG6gfI2A2CRkgZD0W3LP9HDethI82vSZ3hF9vnZ48XXFRPAYy7VbiwAw4TaZNgnM
         KEZoOErEKG+JYr1z/BI326Rj/T31OSJZOKf8vBeBU4JSROgsNlEzj2Y86uOGaJx8AjRv
         nzQQF5dz8NUGLZECTaeYEwS6Lf7+z3PMSvfyXZD10/lrxdasMWzEJ1t2iJNLpf0Z1EFT
         gwsIYvfWQDpxZ216rduPPf0S9nw0aL46XEDp3u9KukFE05csQocnKfrKJUntByVY/CxU
         mQgakDMNdy21rsgjGtfvkFkIJ3xMYda4WPvwWQrRvH+g0vwASjSA9Kskgh25/ivicWKT
         MZFg==
X-Forwarded-Encrypted: i=1; AJvYcCWuWDlD+d9PyrpQ9KfsVR43Yynt0PT0BluqVlZWQv0zZh/y35CJwcapBD6X1uM1zb/mQHv2bbBBqIu/ZEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9aPBFH15JQkHVwK3TRZAtD9qNqp9mUU1ExQjfVlyU+RuddpC
	ixtia684G+ih9/4uESh+2cTEUARhTZUV+pETjbkU42jR802arc4MEE5Qi+1ycDXbbg==
X-Gm-Gg: ASbGncuHRZqzsbkfIJRVS+peg49TnofjWOvXlv3MZMZK0O+O/BgHl1b+sS6xBqZajBC
	K/G+Tt9GfKqbYTXVBzEleIL8bhgWrUVMpb/7N81Hplgu9DSPg5r6DFlqFhNsfTzagbWksfTJNPO
	xIWwPLZX270kuHgk7W97LCC5fhE2ym9JhxoSw07F2I/FUdjtLtVh9oUQxgSkBWMtSFB6tY+Hlvq
	d5gWQvNtBi7Dh6HzR3xxYCGn4uXvi949HA+XzOt+e+hcOSz8ibI8RrCCyUJ7ebLUFx6TfNjNRNh
	SUxLF+CDrvQgSZp+2ai3+qNqmYwLLhecpKmtojqN7D0wAIKFikLweQLb51jdboyDxNX+dS5hgpf
	h9lnbZk+5mH0W5Q9saX0zD0dXR+ZAXd635ydvKGvYEFQcW3uQrg==
X-Google-Smtp-Source: AGHT+IFgh8QV7V/MYka+VqP2PxzfBWBvYZ8Tew53OIrwH5J6OvnBCHIq8VpUf0BipF08xQ8SP+TRpA==
X-Received: by 2002:a17:903:298d:b0:248:9429:3638 with SMTP id d9443c01a7336-248942939bamr72669795ad.7.1756361191567;
        Wed, 27 Aug 2025 23:06:31 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248d8e20e88sm9936195ad.11.2025.08.27.23.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 23:06:30 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:06:20 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
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
	Songtang Liu <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
Message-ID: <20250828060620.GB35@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250819093427.GC38@bytedance>
 <u2ri72fqvzlyvwxmaez3l6mbgtkvzmg36ylzc4k2qhvjcdiup5@7ogshyljqoot>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u2ri72fqvzlyvwxmaez3l6mbgtkvzmg36ylzc4k2qhvjcdiup5@7ogshyljqoot>

Hi Michal,

Thanks for taking a look.

On Tue, Aug 26, 2025 at 04:10:37PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, Aug 19, 2025 at 05:34:27PM +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> > Got it, does the below added words make this clear?
> > 
> >     With task based throttle model, the previous way to check cfs_rq's
> >     nr_queued to decide if throttled time should be accounted doesn't work
> >     as expected, e.g. when a cfs_rq which has a single task is throttled,
> >     that task could later block in kernel mode instead of being dequeued on
> >     limbo list and account this as throttled time is not accurate.
> > 
> >     Rework throttle time accounting for a cfs_rq as follows:
> >     - start accounting when the first task gets throttled in its hierarchy;
> >     - stop accounting on unthrottle.
> > 
> >     Note that there will be a time gap between when a cfs_rq is throttled
> >     and when a task in its hierarchy is actually throttled. This accounting
> >     mechanism only started accounting in the latter case.
> 
> Do I understand it correctly that this rework doesn't change the
> cumulative amount of throttled_time in cpu.stat.local but the value gets
> updated only later?
> 
> I'd say such little shifts are OK [1]. What should be avoided is
> changing the semantics so that throttled_time time would scale with the
> number of tasks inside the cgroup (assuming a single cfs_rq, i.e. number
> of tasks on the cfs_rq).

As Valetin explained, throttle_time does not scale with the number of
tasks inside the cgroup.

> [1] Maybe not even shifts -- in that case of a cfs_rq with a task, it
> can manage to run in kernel almost for the whole period, so it gets
> dequeued on return to userspace only to be re-enqueued when its cfs_rq
> is unthrottled. It apparently escaped throttling, so the reported
> throttled_time would be rightfully lower.

Right, in this case, the throttle_time would be very small.

