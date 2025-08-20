Return-Path: <linux-kernel+bounces-778219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D572FB2E2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D95E28FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DB3314B1;
	Wed, 20 Aug 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvUwppo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC765218AAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708765; cv=none; b=nHXUOHeKiX53MxPEoVKXw00DgPGzYG8A5OJSTlxGHfv0Ttwblk4EO3rmmBnIWEuAnc8peMtSTc1PIwh12pOpjFJ8wAD6HZZbc+urxluCEFJUcLcxaQwRRfa9ZU0UfYF7tydCgweHgA6e7WeNtn2Qsy8VwvQP17930rW8GxJ+s6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708765; c=relaxed/simple;
	bh=a1rgKl6oWJaDB7bfW8fBe6cuwkiaEm4eGDouUvg8XA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISDQygYTIR2iM1Sfgw+j+J4gi70IVC5xr4r4gBWrHuefH/GC3JYBExJ3dYCTGuL9fztmjGHziISK/ygJLZ0fzMNMqYNbiDboYfHBcSrvHkpXwheM9YVdWrjzeN+1quC9UBd63lyqkgrVS2gOuoDJt4179oiogClh2MqcROCLK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvUwppo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5141DC4CEE7;
	Wed, 20 Aug 2025 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708765;
	bh=a1rgKl6oWJaDB7bfW8fBe6cuwkiaEm4eGDouUvg8XA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvUwppo8/zu71lfF5eSoj9Onptm2Qv/FcBLneR56M4Cr/PsGQK7RdJXvmgkIh3Hx5
	 TJM/FlDjid3rc/cOLkeLMP9dPhsFZHwwJBCXH4AzCLoIqXHKwYMvvO5plMQmXEekHf
	 +YlC6YvV9daF+MoD5LqF+KgkBqU+DI2HgMDZegsLEzD9wI4l2/3MgINelor4SxKETE
	 vGDMHEeCi89wBHiim0bcXI0W3dsDTfTP66RFj7nazXVH6f7bPHtX/sBf2trgT9ONHn
	 SL9yqUzP+eEaWkJZJ8H4qSVNzt86xPRS9CtBPc4I4Qg19cjMz27SAmw1kjivZHBseA
	 72xvHiAdJSfgg==
Date: Wed, 20 Aug 2025 06:52:44 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: liuwenfang <liuwenfang@honor.com>, 'David Vernet' <void@manifault.com>,
	'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <aKX9XPDt0yOzPQWv@slm.duckdns.org>
References: <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
 <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
 <aKUWoePcNPcnJT1D@slm.duckdns.org>
 <20250820091810.GK3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091810.GK3245006@noisy.programming.kicks-ass.net>

Hello,

On Wed, Aug 20, 2025 at 11:18:10AM +0200, Peter Zijlstra wrote:
> >   This guarantee changes if we add @rf to pick_task() and let it unlock and
> >   relock. A higher priority task may get queued while the rq lock is
> >   released and then the lower priority pick_task() may still return a task
> >   of its own.
> 
> No, this would be broken. This guarantee must not change.
> 
> What you can do however is something like:
> 
> again:
>    p = pick_local_task();
>    if (!p) {
>      unlock(rq, rf);
>      // get yourself a local task
>      lock(rq, rf);
>      if (higher-class-task-available(rq)) {
>        // roll back whatever state
>        return RETRY_TASK;
>      }
>      goto again;
>    }
> 
>    return p;

Isn't that kinda nasty as we'd have to do that in every pick_task(). What'd
be equivalent but in a central location would be making sure that
wakeup_preempt() asserts a resched event if it hits a race window like that.
I haven't thought too much about how that should be done exactly but the
races should be pretty rare, so it'd be surprising if the behavior
difference is noticeable.

Thanks.

-- 
tejun

