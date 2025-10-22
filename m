Return-Path: <linux-kernel+bounces-865698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A312BFDC70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD91A059BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEB2E1C63;
	Wed, 22 Oct 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ewT9VmjD"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD02EA732
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156642; cv=none; b=ml695Kqu/7NQGxqjpUrKAAXWVeivr9gadxMDMKRLgfXHDGnNi59dZI4fVoh8hJIz5ioDdWY/hDxlBkzfp0tkLeLqNywSdMRCqDYVp96NBT1X7eeArDQD4b2HX5sCfzFZ1Xtzkojdv4F7zZHgzSKHFZ/3R/0o7icNP6xIKHr+ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156642; c=relaxed/simple;
	bh=EY76L4CGdRUn2iTq3A8LXWqtQ45P62GbtJbmIsCh5cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQ6JoN8Qi7vgZh3RMtkYAMPZrbWIe6+g4PoL4aeTxZhc2OXWbRDAyBiqMKTVVRvuJr5/gkoDt6eulOZl0lKP60T4wMbaGL5cLWsaPGCOEObSk8PNkih4bQdnuwPTvWnZi7zVhThOTMAqU8GORAvpQ1FddiTGs32TE/YG9gUqnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ewT9VmjD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761156628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oguebMI32HO2qu+qTFZ3a4OfXPITAp8SRQtXmR8DU0=;
	b=ewT9VmjD7fTQPe1Npsb/bC39b2Tzxw6BCjJHe1M8WUB/Q2xBU9/d7L11V6Vb5wHFwQkqr8
	oSNvVeGhpWgBJ7R7fiHC0RpiHou+2eQte79hbL/RqkaC5+9NPXswBassBgdxbSf1mH/NRJ
	b772Rg8EO0Wab8lYZl/nE8lHfRnMQoI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
In-Reply-To: <3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
	(Shakeel Butt's message of "Tue, 21 Oct 2025 18:28:02 -0700")
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
	<20251022005801.120250-1-sj@kernel.org>
	<3h26sozqgksxn4fvh7i6qjhtbnrtzit6eluyieyhsvycs3fbs5@ddblsq2crkit>
Date: Wed, 22 Oct 2025 11:10:22 -0700
Message-ID: <87v7k67qpd.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Tue, Oct 21, 2025 at 05:58:00PM -0700, SeongJae Park wrote:
>> On Tue, 21 Oct 2025 16:44:25 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> 
>> > The function __memcg_memory_event has been unnecessarily marked inline
>> > even when it is not really performance critical. It is usually called
>> > to track extreme conditions. Over the time, it has evolved to include
>> > more functionality and inlining it is causing more harm.
>> > 
>> > Before the patch:
>> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>> >    text    data     bss     dec     hex filename
>> >   35645   10574    4192   50411    c4eb mm/memcontrol.o
>> >   54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
>> >   34644    1065       0   35709    8b7d net/ipv4/tcp_output.o
>> > 
>> > After the patch:
>> > $ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
>> >    text    data     bss     dec     hex filename
>> >   35137   10446    4192   49775    c26f mm/memcontrol.o
>> >   54322    1562       0   55884    da4c net/ipv4/tcp_input.o
>> >   34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o
>> > 
>> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

