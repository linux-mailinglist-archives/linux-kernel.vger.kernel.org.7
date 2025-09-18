Return-Path: <linux-kernel+bounces-778543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16EB2E727
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5671894BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABC2D8764;
	Wed, 20 Aug 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nv9ys9uW"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AE36CE0E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723981; cv=none; b=o4N4moNnqqXVOHbNKj3ld5XxYQqREFVAXr/X7VN2ma/z6jRultbh4x8Ru6omosSRqkT83Lj3UmAL9NVLL4aBKuHE0FDlSQV3pPbY9UovwH3GBSgZK9kfftxzK1YA6k9qMx2N4tK1kGpb0159P+QqyZI2dQMjtk9gaoTOk5PJmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723981; c=relaxed/simple;
	bh=t2+IyDUqxUTNWPEKnD5gcR4XWY6akacYiTQ4GvoabX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNvxEXE8wP0ZonoF0EFVh22eoX3QFSVIpoNDrWDb8IXT99pp4bMP6OyBzFb+qgq2IdKB8RKVtfINsxhNVO46PHuFB2B3XduSaq/1CcTubJ2+5lksrlYmqOkjfZn18K6/jc1pspL72IdURBDrrebA86fjyLuDo56Bua0GWdw3yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nv9ys9uW; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 14:06:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755723968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5nnquroIbMQvlMv47A2Web6GvDOkaVsT4QY8ArCPIE=;
	b=nv9ys9uWgQm2a+GMpXf6T75wGLjEAhLKwr7XgWO7MIB9CWfN2fodejGugNNSgz1I3dXDqN
	9TrqWVh/wJbZXqa1yhxEY4vptm/oADUqgvnIhd+rwaEd0Vt/ADPr3axKZYb/M8MmIwK9OK
	tQ9kU52NGGSTGuis2NiC7H4W5p4151M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: BPF OOM
Message-ID: <h2bmsuk7iq7i6hphp7vbaxndawwgjz42mhfntlcc2yt4u6but6@7xlre5c56xlq>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 18, 2025 at 10:01:22AM -0700, Roman Gushchin wrote:
> This patchset adds an ability to customize the out of memory
> handling using bpf.
> 
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
> 
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
> 
> It provides a generic interface which is called before the existing OOM
> killer code and allows implementing any policy, e.g. picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).

The releasing memory part is really interesting and useful. I can see
much more reliable and targetted oom reaping with this approach.

> 
> The past attempt to implement memory-cgroup aware policy [2] showed
> that there are multiple opinions on what the best policy is.  As it's
> highly workload-dependent and specific to a concrete way of organizing
> workloads, the structure of the cgroup tree etc,

and user space policies like Google has very clear priorities among
concurrently running workloads while many other users do not.

> a customizable
> bpf-based implementation is preferable over a in-kernel implementation
> with a dozen on sysctls.

+1

> 
> The second part is related to the fundamental question on when to
> declare the OOM event. It's a trade-off between the risk of
> unnecessary OOM kills and associated work losses and the risk of
> infinite trashing and effective soft lockups.  In the last few years
> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> systemd-OOMd [4]

and Android's LMKD (https://source.android.com/docs/core/perf/lmkd) uses
PSI too.

> ). The common idea was to use userspace daemons to
> implement custom OOM logic as well as rely on PSI monitoring to avoid
> stalls. In this scenario the userspace daemon was supposed to handle
> the majority of OOMs, while the in-kernel OOM killer worked as the
> last resort measure to guarantee that the system would never deadlock
> on the memory. But this approach creates additional infrastructure
> churn: userspace OOM daemon is a separate entity which needs to be
> deployed, updated, monitored. A completely different pipeline needs to
> be built to monitor both types of OOM events and collect associated
> logs. A userspace daemon is more restricted in terms on what data is
> available to it. Implementing a daemon which can work reliably under a
> heavy memory pressure in the system is also tricky.

Thanks for raising this and it is really challenging on very aggressive
overcommitted system. The userspace oom-killer needs cpu (or scheduling)
and memory guarantees as it needs to run and collect stats to decide who
to kill. Even with that, it can still get stuck in some global kernel
locks (I remember at Google I have seen their userspace oom-killer which
was a thread in borglet stuck on cgroup mutex or kernfs lock or
something). Anyways I see a lot of potential of this BPF based
oom-killer.

Orthogonally I am wondering if we can enable actions other than killing.
For example some workloads might prefer to get frozen or migrated away
instead of being killed.

