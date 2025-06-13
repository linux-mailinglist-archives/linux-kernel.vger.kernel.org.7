Return-Path: <linux-kernel+bounces-685060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC9AD839E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 09:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833767A7530
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5C258CEC;
	Fri, 13 Jun 2025 07:04:07 +0000 (UTC)
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F61EE7C6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798247; cv=none; b=O+aEgRwbf0y3tN1VMZj2RZRjHkZRuZ2PdWNauY8j5yicYU1OnEjgXk2cXccilTyq/xyx0a75yhmFcaIsicjyQR++voybb40LeaExQEhTiD7QTPFCgMbEZr5OZITvq6M/GeQfAceaeHwPrNVld9fhV7dttGhBPH7GnBvk9+BKD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798247; c=relaxed/simple;
	bh=yO46MfnxXffGjPN79txnSZU/FM/I8HaAB1XDIRPVMAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShYQmdyXd+IVhbXeF+CBiacVXxlxGX6qryDNnQVRk0l8nP0d86+uezJ0XL0cSgrCyOR6F8fHqorREJqtyXAhMoDMPqYuwSTghTxbqpUproY4/W1rG4JZklVCk/3EFexNWLRDBUECO/K7E8CEmwGLgf2/8ZV7aM20Ep4WPYBAlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Jun 2025 15:49:02 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 13 Jun 2025 15:49:02 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
Message-ID: <aEvJ3qWQfJwBh3oj@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com>
 <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>

On Thu, Jun 12, 2025 at 07:14:20PM +0800, Kairui Song wrote:
> On Thu, Jun 12, 2025 at 6:43 PM <youngjun.park@lge.com> wrote:
> >
> > From: "youngjun.park" <youngjun.park@lge.com>
> >
> 
> Hi, Youngjun,
> 
> Thanks for sharing this series.
> 
> > This patch implements swap device selection and swap on/off propagation
> > when a cgroup-specific swap priority is set.
> >
> > There is one workaround to this implementation as follows.
> > Current per-cpu swap cluster enforces swap device selection based solely
> > on CPU locality, overriding the swap cgroup's configured priorities.
> 
> I've been thinking about this, we can switch to a per-cgroup-per-cpu
> next cluster selector, the problem with current code is that swap
> allocator is not designed with folio / cgroup in mind at all, so it's
> really ugly to implement, which is why I have following two patches in
> the swap table series:
 
This seems to be the suitable alternative for upstream at the moment.
I think there are still a few things that need to be considered, though.         
(Nhat pointed it out well. I've share my thoughts on that context. )  

> https://lore.kernel.org/linux-mm/20250514201729.48420-18-ryncsn@gmail.com/
> https://lore.kernel.org/linux-mm/20250514201729.48420-22-ryncsn@gmail.com/
> 
> The first one makes all swap allocation starts with a folio, the
> second one makes the allocator always folio aware. So you can know
> which cgroup is doing the allocation at anytime inside the allocator
> (and it reduced the number of argument, also improving performance :)
> )
> So the allocator can just use cgroup's swap info if available, plist,
> percpu cluster, and fallback to global locality in a very natural way.
> 

Wow! This is exactly the situation I needed. 
I thought it was uncomfortable to pass memcg parameter.
If memcg can be naturally identified within the allocation, as you mentioned,    
It would be good both performance-wise and design-wise. 

> > Therefore, when a swap cgroup priority is assigned, we fall back to
> > using per-CPU clusters per swap device, similar to the previous behavior.
> >
> > A proper fix for this workaround will be evaluated in the next patch.
> 
> Hmm, but this is already the last patch in the series?

Ah! The next patch series refers to the one.
I'm still evaluating this part and wasn't confident enough to include it
in the current version.
At first, I wanted to get feedback on the core part, I'm currently pursuing.

