Return-Path: <linux-kernel+bounces-807004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39CB49EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17397B2EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601D52248B8;
	Tue,  9 Sep 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fTItJmwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632972634
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381810; cv=none; b=ncWYxWQo7XqQKyr724/U7SyTRYKTZDi35+PIUxpJ7YAjTPyeEDJvLGetYuHQC8kJE0BjuU40svyAGrxkcDdi8aPkWZ8b3APcKLedPzTS27BQmi4LYSSgMw17z8At5ixjrNd5APgLr79OCE5EoU1ZQJ4IC9csf8y0rX6/H7XSz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381810; c=relaxed/simple;
	bh=Z1rOYyBYisrEgpjxg5axvCiSam4Xo1at+Aqmwaue7MU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rXyBBXCmwesMpFuIl3lnBJzZV9eGdrcaP54ieVu7jcxdzJX01osw2FBJw7TgWOSfIoGLT2YviMmXYhxLP2cYTyu1qWELLJRFo7lpucuXjWXNnmwJlXDaRCofs0NGmYo3RAh08rLnvarRrTRDbS+BuJKosyTqnmeYjD6c8sGZ1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fTItJmwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE12C4CEF1;
	Tue,  9 Sep 2025 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757381810;
	bh=Z1rOYyBYisrEgpjxg5axvCiSam4Xo1at+Aqmwaue7MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fTItJmwphkdiwuwpmzrhAuNOpxlnTraGAELtElgAj72BfU7Ufj/C03C3qzZrcU7rO
	 zO9UrfXTgGE9oucR2CVHiLGDU9bnuU9wrUFhC0oXDyaaiHcTl4fKQKP2pXQcgvMvee
	 pwuj8ycqWx855HfKpZKql8pT5Zdn38r0Rpz6alnc=
Date: Mon, 8 Sep 2025 18:36:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: cuishiwei <cuishw@inspur.com>
Cc: <axelrasmussen@google.com>, <yuanchu@google.com>, <hannes@cmpxchg.org>,
 <weixugc@google.com>, <david@redhat.com>, <zhengqi.arch@bytedance.com>,
 <shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] disable demotion during memory reclamation
Message-Id: <20250908183649.da6b77d15c1076e5b69064af@linux-foundation.org>
In-Reply-To: <20250909012141.1467-1-cuishw@inspur.com>
References: <20250909012141.1467-1-cuishw@inspur.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 09:21:41 +0800 cuishiwei <cuishw@inspur.com> wrote:

> When a memory cgroup exceeds its memory limit, the system reclaims
> its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
> set to 1, memory on fast memory nodes will also be demoted to slow 
> memory nodes.
> 
> This demotion contradicts the goal of reclaiming cold memory within
> the memcg.At this point, demoting cold memory from fast to slow nodes
> is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
> we should set no_demotion when reclaiming memory in a memcg.

Is this from code inspection?  Or is there some workload which benefits
from this change?  If the latter, please tell us all about it.

>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6706,6 +6706,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.may_unmap = 1,
>  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +		.no_demotion = 1,
>  	};
>  	/*
>  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> -- 
> 2.43.0

