Return-Path: <linux-kernel+bounces-790346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B742B3A5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3459917C8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D229C339;
	Thu, 28 Aug 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="KNw7EIFj"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E1268C42
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397299; cv=none; b=CEtSFKXeRAbHL8o40loaN15ZNF/XKYPm4y7xcgTUcbb0YqEkhNThAlCJa/Jv3lo4qYuDL+tOI2zMmp+wEkxjccbmIuelYOcb3r0Yg5vl0UREUjxCTG35h6ckl2ZCF98lRwyI3cTaNCc0fBbK2rTCrttCLiwNxUYZGHGItANNCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397299; c=relaxed/simple;
	bh=jZ1A+4yhhteH9jNqK7EA+IvNC8gu6cJoXsYfxwRpOcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tv+tjxxHOdB/+wGWngHWiXBO6pC67bvh1NJXz1amBs0YA0CEmnZ8oF00X+z44ptLnsUdZE5EfToThZxuILm5b/PjmprVWQ90TNXxnztdABIpfWmptWC64KsTFxA1FFPU5bOiRSu3fV2H6Orq8WkGNrYVAuYPjetgKXoY4MnJjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=KNw7EIFj; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1756395884;
	bh=jZ1A+4yhhteH9jNqK7EA+IvNC8gu6cJoXsYfxwRpOcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KNw7EIFj6frtB4PnlV0XyKY+Xhk5LXjntutef1boUAxqmSyCFpaKqO9toy8Tb2KBy
	 Yn6e2PkHSAJ7kcg1KyIeu2B+T+ZP/wHypgeIsq7SS6Al7BuZ2+T3+ldmCZCgRVmcGT
	 +OZOjXyR4gmqBXp9fZ73G1TSw6HETuxplVoqCxFs=
Received: by gentwo.org (Postfix, from userid 1003)
	id 20E82401E7; Thu, 28 Aug 2025 08:44:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1E6E04010E;
	Thu, 28 Aug 2025 08:44:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:44:44 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Valentin Schneider <vschneid@redhat.com>
cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, frederic@kernel.org, linux-kernel@vger.kernel.org, 
    patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com> <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com> <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Aug 2025, Valentin Schneider wrote:

> > Yes, binding the threads to CPU can work around the performance
> > issue caused by load imbalance. Should we document that 'nohz_full' may cause
> > the scheduler load balancing not working well and CPU affinity is preferred?
> >
>
> Yeah I guess we could highlight that.

We need to make sure that the idle cpus are used when available and
needed. Otherwise the scheduler is buggy.

Such a load balancing action means that there is a cpu that is running
multiple processes. Therefore the timer interrrupt and the scheduler
processing is active on at least one cpu. We can therefore do something
about the situation.

The scheduler needs to move one of the processes onto the idle cpu.

