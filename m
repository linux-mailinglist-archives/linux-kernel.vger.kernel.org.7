Return-Path: <linux-kernel+bounces-852174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DFBD85A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B863BC25C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2072E6112;
	Tue, 14 Oct 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZjVYgB4+"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD891E3DED
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433090; cv=none; b=S65SCDBiLn0ijHgZEA3hMBvLvvbW3KZjW7+NvuC8q1dvMPabxCSCuVuy3wu/66WRDj6DFYthQ9SQc7pQBT2R97aFwHc0XX0qLcPlyYf7ux6iIQEtpAFaWjjUOn8usTcGpkfnGFRr+mEt7S1yyJlYkc6If38TKAvqWXixUGAO1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433090; c=relaxed/simple;
	bh=buIdTYuoZdf9iDkoLFoEG35di4muq7tsJziodli4FOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PofsZuVt4M0qPhmM2uWUgYYXVygTdNx4+sTi1vRgLGz0kxY02W3ylN1GhM6oenhhU6+sHrlc+XFn4SxLTe4d04iZAccM54UCmRJt3Mh+zz90X0nJ/ivi9IDvHBSerk9/Dag8CIZBw9SRcTrawg+/QYWlKNlFf6RaDV7wmH8olkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZjVYgB4+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32ec291a325so3698507a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760433088; x=1761037888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDJyXgKuthhtyotHWhKtZqfy42blKD0kmhmT5xhTHFY=;
        b=ZjVYgB4+Ipo51ZBg3GzC//p8R2MDr7m8iBTIoP5/pBC7mljNF9bCdV0nZsM2v4kmkF
         cEnRJhWpsy1wn+naYv+ZDbUWRIoaUxzixvJh7/f8MqJ0vbeY3vnsYqucwdynTY6NHufk
         +uKm0eU9CsTCXO2f4UP3Uovb72mScNLfFwKJ4kDCYCDV32rhm8VOxC8BZiaIz7VZsAWv
         9XSVecgNpezVySQ4gy9WkP5uZkqMB7S1zOwSsDIVDN1A7eoq3z1cmH1qCtb+x/jOaU8U
         e3fmKO3pouXKBDG+S9MvaJMYHQytFVklV0GzGz6BfgB673p1BWwom8hiaaOPDEX7DUzS
         TfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433088; x=1761037888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDJyXgKuthhtyotHWhKtZqfy42blKD0kmhmT5xhTHFY=;
        b=Y4V9nuvpZK75A2TPSlx5E3/Unk7O2H+zHY+FgdtFZ20TxdSjWL/kWbzskYAMDhaZ7c
         jcNxO2cdgL8DRAyP9aaAi0UftBu+zekvu1/vFvFdz6VwLpm7EGOvLvgIGoZcKwT3QSG6
         ZeuVa7C7sUaCHwG1oBZ/OBpEOe1NeL8xC/nyV4hjyq3+f/AQ3sR1zmsamkwOvxBJNWnS
         Sn9UQwQkG2bAaqSfKlcMoEgpPDZmmSo0LqIDGeZgmSFNBsUHNDZ0FC29og2mNP+2S+KM
         JtCiBwYbu0pev0/b/SlazLHVxKRSL+nd3rN+xDNCg1Ev63Bl/BueTpPZhSFDs2uElMny
         aKKg==
X-Forwarded-Encrypted: i=1; AJvYcCVSY2c1IJNzynjUJ9cMcwQGVnO0Rfh+9Ar/o3K8uf//pDDByHO1S2exLRRnIqj0ihYh/8rgOo3WusJyAoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm71NV2yIhmNhv9qWQJheWFoycRKpk5rZd45zuKcTwz2g/mDNC
	OpeZk5WujEWdSTplfk2QuNpbd4aGqoCR7SAivlhL5VzZkzQDeF50r4z84rBq3sq3DQ==
X-Gm-Gg: ASbGncsqic+rWv+U7GOQfeU2lQWJFPPAl40Ysj6G0ygG6up1JgMFodFRC6l5BtdGcPh
	jd8b2w0ALHsk3TfG0VPg0NF+apky9+nbUMNz8R3ACDy4bN6ZPOZSxsybO986z7zMcNuSe09Gwj7
	V8uumPv5ChkXzrKHJXlCu5pY9A83Nx9QX8OVupNZQFfaL5D60IwvB0GW2b5bHknGbsnxWL4mqGH
	zD6vAB0cmisM/thLKYAv/fLBOgsfXZ6L5FeAnPof4Vs/Shza98rbRPgIdKfIXnTGFJk/90RVxwo
	d50YONggC+728WNQTuiusQbFKiiLJjg1W0qgT2/DuQhnTLin/dN/wdiUQdADcjDC4AvqZmqTTDM
	2XoPV9toGRlsQxxL+tCg0OaX3R2yPZeUKt4qBogizioV+DeFvIMMnE1EsgWClQ5SSvKOQ
X-Google-Smtp-Source: AGHT+IGEma8tBx5Y9sAgKhxuu8ZYQP9yia/4IqqnzmeOyG/1G8jlUGcQW1ZdBYeq4hs6Beu5NZXN0w==
X-Received: by 2002:a17:90b:38d2:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33b5138401amr32893100a91.28.1760433087669;
        Tue, 14 Oct 2025 02:11:27 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbfb07sm11249785a12.3.2025.10.14.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:11:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:11:13 +0800
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
Message-ID: <20251014090728.GA41@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>

Hi Hao,

On Tue, Oct 14, 2025 at 03:43:10PM +0800, Hao Jia wrote:
> 
> Hello Aaron,
> 
> On 2025/9/29 15:46, Aaron Lu wrote:
> > When a cfs_rq is to be throttled, its limbo list should be empty and
> > that's why there is a warn in tg_throttle_down() for non empty
> > cfs_rq->throttled_limbo_list.
> > 
> > When running a test with the following hierarchy:
> > 
> >            root
> >          /      \
> >          A*     ...
> >       /  |  \   ...
> >          B
> >         /  \
> >        C*
> > 
> > where both A and C have quota settings, that warn on non empty limbo list
> > is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> > part of the cfs_rq for the sake of simpler representation).
> > 
> 
> I encountered a similar warning a while ago and fixed it. I have a question
> I'd like to ask. tg_unthrottle_up(cfs_rq_C) calls enqueue_task_fair(p) to
> enqueue a task, which requires that the runtime_remaining of task p's entire
> task_group hierarchy be greater than 0.
> 
> In addition to the case you fixed above,
> When bandwidth is running normally, Is it possible that there's a corner
> case where cfs_A->runtime_remaining > 0, but cfs_B->runtime_remaining < 0
> could trigger a similar warning?

Do you mean B also has quota set and cfs_B's runtime_remaining < 0?
In this case, B should be throttled and C is a descendent of B so should
also be throttled, i.e. C can't be unthrottled when B is in throttled
state. Do I understand you correctly?

> 
> So, I previously tried to fix this issue using the following code, adding
> the ENQUEUE_THROTTLE flag to ensure that tasks enqueued in
> tg_unthrottle_up() aren't throttled.
> 

Yeah I think this can also fix the warning.
I'm not sure if it is a good idea though, because on unthrottle, the
expectation is, this cfs_rq should have runtime_remaining > 0 and if
it's not the case, I think it is better to know why.

Thanks.

