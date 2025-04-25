Return-Path: <linux-kernel+bounces-619304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAFA9BB07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 01:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259757AF53E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BD27BF78;
	Thu, 24 Apr 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8qVdmDT"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF51AA1F4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535653; cv=none; b=s+YgDy/6X67lTHnfdtnyMgu75vmLQ8K+iXlIi/65bIgCdd9Ggz5Of0BFTdGOeG7ioVSoNJajRV3STRv+OOI4ChHj9tQm3g0H0+hRcM+TDgMj740nTkrv6hCg/5aI2pVdFYOwUk/tZ2xwiu0PfqbpMu0iGd+FLpHWmWsJNkhP9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535653; c=relaxed/simple;
	bh=hRUUYUg4bUCUj7FTfA50KwIVcNDhWjCmulZ/4J1T2lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0jrWEYPBWxc+ueMp1f7cNx1xvQZfe2Qsl7e3tTlVijdeqRspZndxKj/Ayuruf/jbwXRaZYsh1DhpCixGtPxJ7MDGOaVxxPp0AH0cgLSDZ8cGmOpkQu4fF5KVbNJrPFVIfCCsJiKuYOzr1GInqZKHvVl3oVMRfReHLzCm6GCFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8qVdmDT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 16:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745535638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJVvQHLAm1I3auOzUVRa8UOMSKBiN+sklpD1+b2kdV4=;
	b=U8qVdmDTnXgyPjaOJj2SSPNteNgcAnqAj8hRfxofzZKxdBuOckUnzbmlqjFQihRGxq4/cp
	Z1JKuS2dF/qW6IhLHo6SsRT5jdTGSuwGSTHrcDvnvh+u+wHBx8mSIB2vQyn0uG7R/UqMI6
	liq8C4bc/gCXL9ESX4+eiIFqNtHnGGo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Francesco Valla <francesco@valla.it>, 
	Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
Message-ID: <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 09:00:01AM -0700, Shakeel Butt wrote:
> On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
> > When cgroup_init() creates root_mem_cgroup through css_online callback,
> > some critical resources might not be fully initialized, forcing later
> > operations to perform conditional checks for resource availability.
> > 
> > This patch introduces mem_cgroup_early_init() to address the init order,
> > it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
> > by initcall, mem_cgroup_early_init can use to prepare some key resources
> > before root_mem_cgroup alloc.
> > 
> > Signed-off-by: Huan Yang <link@vivo.com>
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Please move this patch as the first patch of the series and also remove
> the "early" from the function name as it has a different meaning in the
> context of cgroup init. Something like either memcg_init() or
> memcg_kmem_caches_init().

BTW I think just putting this kmem cache creation in mem_cgroup_init()
and explicitly calling it before cgroup_init() would be fine. In that
case there would be a single memcg init function.

