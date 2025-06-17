Return-Path: <linux-kernel+bounces-689664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93263ADC4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD7C16527E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF5288CBE;
	Tue, 17 Jun 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUFclMGf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0422BF016
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149067; cv=none; b=tlb0F+HwgCBuR4IKdD4eY+uHBvuR7L1K/OoY17l2GjjGd97IGQBEl5TkygAZIe+gzbOuJtkhhuPfmHnFIz9QgDIb/ZCpwKivYhZ9IjYw1RVzDOVSaIXR8dlP9Mwri5LQwZfNarjp3CJbnekB+XW8H+1CXyZm8HSwNPDMrjZIuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149067; c=relaxed/simple;
	bh=h0cIatrA8QlhAxODbULEtlvQfUO67Wc1K5ivENaMF2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChH+qD3n11j1m4Ay/rX6f3lC/ZK1mywt3CcdBtqLo+XaQ3NWxbc5tT+TZjZFL6Fe+sT3o1SfEvdrhV/UoBJ5v8OG5pTWYa5GpG1LX5ss152hhZJGNPN8KddcuqOb1hIpQNsIcWWgCzNmV9lBq7Nujd7z65J48DAKo8/UiAGMOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aUFclMGf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=teGU0f+r+dx/oNJ7C6ACflbmc2p2xmyRlx0sA8jT8Dw=; b=aUFclMGft5euXrqVmqAP1nvhVU
	zd9nYlV15nHu6bE7N+4wsOeGm27wN55bcIjf8one1RzDrttML8RF4+ns+D2rEUsTMyRvfMvf7JHcd
	3SeAJ2WpG3nLuQbm1du+XRl6LiciTkQVLq4I4WaRb2haKprUSFiR5i+R1ugnwM7qYEhStGpQPviqQ
	uOCEz6YRIV8fYqzco6K4mVHl91tDc4wZ75TRBRo3Gl1MCTy2pMkJDMNOHQ99/u/kz0cay0nf9hYcr
	AvZ999I/WzRbarJnmFWMhXPqgFDOIWTmBb7B4SzUd+x96RIVHBODjgQ2Eer2GyJD9VnO6Iu6ppBgb
	1lWE8osw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRRif-00000003kKk-0Vwp;
	Tue, 17 Jun 2025 08:31:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28255308523; Tue, 17 Jun 2025 10:30:59 +0200 (CEST)
Date: Tue, 17 Jun 2025 10:30:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2 sched_ext/for-6.16-fixes] sched_ext, sched/core:
 Don't call scx_group_set_weight() prematurely from sched_create_group()
Message-ID: <20250617083059.GL1613376@noisy.programming.kicks-ass.net>
References: <aEyy27BecPPHDWHc@slm.duckdns.org>
 <aEyzhBAl5zkP6Ku-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEyzhBAl5zkP6Ku-@slm.duckdns.org>

On Fri, Jun 13, 2025 at 01:25:56PM -1000, Tejun Heo wrote:
> During task_group creation, sched_create_group() calls
> scx_group_set_weight() with CGROUP_WEIGHT_DFL to initialize the sched_ext
> portion. This is premature and ends up calling ops.cgroup_set_weight() with
> an incorrect @cgrp before ops.cgroup_init() is called.
> 
> sched_create_group() should just initialize SCX related fields in the new
> task_group. Fix it by factoring out scx_tg_init() from sched_init() and
> making sched_create_group() call that function instead of
> scx_group_set_weight().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 819513666966 ("sched_ext: Add cgroup support")
> Cc: stable@vger.kernel.org # v6.12+
> ---
> Ingo, Peter, while this touches kernel/sched/core.c, the changes are trivial
> and only affect sched_ext. I'm planning to route it through
> sched_ext/for-6.14-fixes. Please holler if you want it routed through tip.

Seems fine, go ahead and take it.

