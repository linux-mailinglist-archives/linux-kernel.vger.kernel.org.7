Return-Path: <linux-kernel+bounces-872232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EEC0FA36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E2614E8559
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668A31690D;
	Mon, 27 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCrUOTis"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156731619A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586168; cv=none; b=VJyXpvzj9Ue6F8piqzfRTIyJpme+so6oyrrkVjK3HRoida4D/RbN7o5qNM2+mNRkIL0p2z8sCtyohox9x4pqYkGhP1EU2KzayCnjELK2vD4rL2swR1ueSHJb3fFSmGv4kYcXUKBtbp9aC+szG8RPE01xnO09bQ6cMH0Ah29hqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586168; c=relaxed/simple;
	bh=t8Di+fcs9Ip6O8f1bPMb7LPCPEQDcc2NLemRSEhkSzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2p9KNi3E8aaBTVGSZqUzK4ZKxRlyWNcl8s2w/gkejrMh8aSgubW4rJ2PX3Ui4sb5xgPYhRZiaewU/kCAcGnIcI1Rhvfb+6PT7saKv/caYE40PcGavzEFP8a+qpjueTE2IU2GKiIjUJnFhAoHEaOoW8nfQ7wKMVUcvVKquUkrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCrUOTis; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 27 Oct 2025 10:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761586154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hkk/4jH6EBlfw+AjqDX/N89lF3rHfzq/zegSXixlTQg=;
	b=iCrUOTisVmn0Gyrl01InGTa2hzUTpre3WhDeV4nG+iN68gBLiKGojyC5U0wmDX0tmxfP8z
	yQJdQfCm8TAAg8+SpB/IJ2zMuTZ+0wMy+kGHMIsY7qgpVRe8LNBWf9cwZImH4btrtwfuDw
	NENplaCH8pXB94SRHmPauHF+yap+3C8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: jinji zhong <jinji.z.zhong@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	zhongjinji@honor.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <k6jwua5rlkds7dxomwvxotwtjq4hauyevvyoxd5hjz733k7kk5@mmezlradxhpu>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Jinji,

On Sun, Oct 26, 2025 at 01:05:07AM +0000, jinji zhong wrote:
> Hello everyone,
> 
> On Android, different applications have varying tolerance for
> decompression latency. Applications with higher tolerance for
> decompression latency are better suited for algorithms like ZSTD,
> which provides high compression ratio but slower decompression
> speed. Conversely, applications with lower tolerance for
> decompression latency can use algorithms like LZ4 or LZO that
> offer faster decompression but lower compression ratios. For example,
> lightweight applications (with few anonymous pages) or applications
> without foreground UI typically have higher tolerance for decompression
> latency.
> 
> Similarly, in memory allocation slow paths or under high CPU
> pressure, using algorithms with faster compression speeds might
> be more appropriate.
> 
> This patch introduces a per-cgroup compression priority mechanism,
> where different compression priorities map to different algorithms.
> This allows administrators to select appropriate compression
> algorithms on a per-cgroup basis.
> 
> Currently, this patch is experimental and we would greatly
> appreciate community feedback. I'm uncertain whether obtaining
> compression priority via get_cgroup_comp_priority in zram is the
> best approach. While this implementation is convenient, it seems
> somewhat unusual. Perhaps the next step should be to pass
> compression priority through page->private.
> 

Setting aside the issues in the implementation (like changing
compression algorithm of a cgroup while it already has some memory
compressed using older algo), I don't think memcg interface is the right
way to go about it. We usually add interfaces to memcg that have
hierarchical semantics.

Anyways if you want to have this feature, I think BPF might be the way
to get this flexibility without introducing any stable API and then you
can experiment and evaluate if this really helps.

