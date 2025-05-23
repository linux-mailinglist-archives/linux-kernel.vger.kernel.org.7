Return-Path: <linux-kernel+bounces-661331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6FAC2981
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5782C7BC21F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5129A323;
	Fri, 23 May 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4+4mLQa"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28228EC
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024509; cv=none; b=rLCi6oEXPlJ469DgNY/HdjMT2LyRBjpjb+NUQXUvIy+aQuTAwfRkanYVUT8io297Lfdc/HofqIa7Rw4x2i229BWF/FEgZfLSaNjIJSR8O2m5Hdo7SB+sgipPqdZXOBOLkkZemUG9KEK9khU4zbJHwhDt0supCtpZe8DYTdaXPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024509; c=relaxed/simple;
	bh=nhTbb3nsCWQTVzNVpM7fmLPGeECXCpvJPH1HVgPh5S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3uk9rgZhjSywHQC1z4fLIjU4SNTiw8lKAsHDyojzh8dt4xoQ+oKUGqvYyWFH2yguZ5Tb423e9owTjIpNLsw1SYDzlVihD8/2ZKnJ4imkO+JRpXFvoz26SSwe9uyFt3Szuadm0uLoY6yQUNu2c3Sb/DGNnDydbuLK5WrIaunKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4+4mLQa; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 11:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748024505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9GcVUed+F9NvfABQQn7JwQ6fDdObSd9v2gwZ5/oOI4M=;
	b=u4+4mLQaOqcYqcofYG5LY1w56+zv4vr2CilC+OslZZYWDtT/N3C+7BnPWib9fzr9iOypRl
	b/Q0P+dQeHpTaRRsMa53vqEKUddVoMztdhwy19cukLaz0Rn3yad5SE/jT7+UyiMRFcwS2E
	fR4tFXLDOlHKsf63TufOYWOKphxptuI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Usama Arif <usamaarif642@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] memcg: Always call cond_resched() after fn()
Message-ID: <ucarls72c6j7xzhdjsbb2wj5ovlzthatmh7kzwhepvudszap4h@xetgnupdm5ui>
References: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 10:21:06AM -0700, Breno Leitao wrote:
> I am seeing soft lockup on certain machine types when a cgroup
> OOMs. This is happening because killing the process in certain machine
> might be very slow, which causes the soft lockup and RCU stalls. This
> happens usually when the cgroup has MANY processes and memory.oom.group
> is set.
> 
> Example I am seeing in real production:
> 
>        [462012.244552] Memory cgroup out of memory: Killed process 3370438 (crosvm) ....
>        ....
>        [462037.318059] Memory cgroup out of memory: Killed process 4171372 (adb) ....
>        [462037.348314] watchdog: BUG: soft lockup - CPU#64 stuck for 26s! [stat_manager-ag:1618982]
>        ....
> 

> Quick look at why this is so slow, it seems to be related to serial
> flush for certain machine types. For all the crashes I saw, the target
> CPU was at console_flush_all().
> 
> In the case above, there are thousands of processes in the cgroup, and
> it is soft locking up before it reaches the 1024 limit in the code
> (which would call the cond_resched()). So, cond_resched() in 1024 blocks
> is not sufficient.
> 
> Remove the counter-based conditional rescheduling logic and call
> cond_resched() unconditionally after each task iteration, after fn() is
> called. This avoids the lockup independently of how slow fn() is.
> 
> Cc: Michael van der Westhuizen <rmikey@meta.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 46576834291869457 ("memcg: fix soft lockup in the OOM process")

Can you share the call stack but I think from the above, it seems to be
from oom_kill_memcg_member(). Have you tried making __oom_kill_process
not chatty? Basically instead of dumping to serial directly, use local
buffer and then dump once it is full.

Anyways, that would be a bit more involved and until then this seems
fine to me.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

