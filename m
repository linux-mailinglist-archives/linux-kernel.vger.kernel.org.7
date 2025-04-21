Return-Path: <linux-kernel+bounces-613090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D56A9580A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 23:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA83166591
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A7217F5C;
	Mon, 21 Apr 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H1M8vOPg"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541F2E401
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271296; cv=none; b=jKkV4h099DuFhtwZ+Mq6sIwZUFuIRAVPmaFUx+wLEGB1v22y9SCZP2pCV/0M0JHu8qYAW19q/VKgcphf8T7bJoIfZ8WToMlENd7zwrgGgXCe8dKXNj7C4HWoRur3vggWHsf8m3rlL1NiBrIQAhgzWzjgCx9miPsLUSNNi+d9e6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271296; c=relaxed/simple;
	bh=8qJzO1ZLC8/KZccvex8eKof6pGy6JwT3E8gASVra+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUnR/DB9I96s0F7fIXPiyvK3d5XDLLqCxtd9+tGwTmR9q7EBcMOna/dYfPrVqrLUY/g7V84nI6YSPCWBNsHkBXLcVtjyo71tFV3oCwAjnNGJq88pl6Zejbe5VcKxEZ/60bC0J2cGZS73oV+PZ/b5YYiVBXvkL8PlrSyVicobILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H1M8vOPg; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 21:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745271290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/P6KO5tmhrmW7ovw7XWmmzoB4BERa9BgtVy7OgEIno=;
	b=H1M8vOPg30LswLGaE8LCWjWxA2FMnO6Ya3I3SjGeZyEdGb5wh71XL+MpMLezULbnwcojD+
	MrJ4HfPEtbJ73NLjwmyCdhPdyORWn6TYDM2v0lghbYCBO/fUbbtEXH8RiBMhguZ14PJ0M3
	GjUQp+jm7jol1Y0FgvGCzIkxogYd3Uw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <aAa58xJFJ3du6OlY@google.com>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419183545.1982187-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 11:35:45AM -0700, Shakeel Butt wrote:
> Setting the max and high limits can trigger synchronous reclaim and/or
> oom-kill if the usage is higher than the given limit. This behavior is
> fine for newly created cgroups but it can cause issues for the node
> controller while setting limits for existing cgroups.
> 
> In our production multi-tenant and overcommitted environment, we are
> seeing priority inversion when the node controller dynamically adjusts
> the limits of running jobs of different priorities. Based on the system
> situation, the node controller may reduce the limits of lower priority
> jobs and increase the limits of higher priority jobs. However we are
> seeing node controller getting stuck for long period of time while
> reclaiming from lower priority jobs while setting their limits and also
> spends a lot of its own CPU.
> 
> One of the workaround we are trying is to fork a new process which sets
> the limit of the lower priority job along with setting an alarm to get
> itself killed if it get stuck in the reclaim for lower priority job.
> However we are finding it very unreliable and costly. Either we need a
> good enough time buffer for the alarm to be delivered after setting
> limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> in setting the limit for much shorter but cheaper (less reclaim) alarms.
> 
> Let's introduce new limit setting option which does not trigger
> reclaim and/or oom-kill and let the processes in the target cgroup to
> trigger reclaim and/or throttling and/or oom-kill in their next charge
> request. This will make the node controller on multi-tenant
> overcommitted environment much more reliable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> Changes since v1:
> - Instead of new interfaces use O_NONBLOCK flag (Greg, Roman & Tejun)
> 
>  Documentation/admin-guide/cgroup-v2.rst | 14 ++++++++++++++
>  mm/memcontrol.c                         | 10 ++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Re stable backports: can you, please, share some details about the problem
users are facing? Which kernel are they using?

Thanks!

