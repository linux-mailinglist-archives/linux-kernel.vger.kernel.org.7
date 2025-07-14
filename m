Return-Path: <linux-kernel+bounces-730487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B15B04550
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E74A4A37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80B25F98A;
	Mon, 14 Jul 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTXLSzO2"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672071DE3C8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510110; cv=none; b=I30KeuQG0+RxeoJAEfHaZ41OvOlDXStUqUZgkw6qrlusUFGPyPS+JzkE/fMYwl4rqeUbIRVnT/KRz4hegziHX7W9Q1Mjkci91p509vxNW56MEbNgx+wnJDpAAKO4H5S57qQ/wjKeqZEddM1/DU+miMJ1Z7D/URU9UOmkZq8S5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510110; c=relaxed/simple;
	bh=UYL9FxgAl2ewORVJzJNE/QkTpB7BwuVEi8SngBc9vRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2Ti9ScP2ObYQIj9dseulmWgxAAYB1x9l9RS1DUcq+e4e7DesOFCZhNBWWVll1U00+nTq04A9JL28L0VEIKolgwMQcv1zDEECZLUygnvFj/WBfrSyAO5uUOVLLnEc5lEEJWVcNr8IqYulGuKVW5P+75mLSdwT/au/n5Z3aSpPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTXLSzO2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752510105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcxPOiqo1VWn6JFGmacDTt76C1NFyWdttR909jiVjRY=;
	b=uTXLSzO2c1NdApSVVJ8OQZxksSUT2V6en2xn/FPj6bE2wK3O/qCwEtfTQ8Hm1LUEIXx0+O
	VECfo+bbWXcxADaZDUjRiWGu8t3MMHEApvi768esm/J4IfNHqvyNGV59t2YW+gAJZv26iq
	qXSM9jCAyhZBiJsQl3PFGFueZ18JYoM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  Michal Hocko <mhocko@kernel.org>,  David Hildenbrand <david@redhat.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
In-Reply-To: <20250714152247.GB991@cmpxchg.org> (Johannes Weiner's message of
	"Mon, 14 Jul 2025 11:22:47 -0400")
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
	<20250711172028.GA991@cmpxchg.org> <8734b2vcgr.fsf@linux.dev>
	<20250714152247.GB991@cmpxchg.org>
Date: Mon, 14 Jul 2025 09:21:34 -0700
Message-ID: <87o6tmu4j5.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Fri, Jul 11, 2025 at 10:55:48AM -0700, Roman Gushchin wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> > The caveat with this patch is that, aside from the static noswap
>> > scenario, modes can switch back and forth abruptly or even overlap.
>> >
>> > So if you leave a pressure scenario and go back to cache trimming, you
>> > will no longer age the cost information anymore. The next spike could
>> > be starting out with potentially quite stale information.
>> >
>> > Or say proactive reclaim recently already targeted anon, and there
>> > were rotations and pageouts; that would be useful data for a reactive
>> > reclaimer doing work at around the same time, or shortly thereafter.
>> 
>> Agree, but at the same time it's possible to come up with the scenario
>> when it's not good.
>>   A
>>  / \
>> B  C  memory.max=X
>>   / \
>>  D   E
>> 
>> Let's say we have a cgroup structure like this, we apply a lot
>> of proactive anon pressure on E, then the pressure from on D from
>> C's limit will be biased towards file without a good reason.
>
> No, this is on purpose. D and E are not independent. They're in the
> same memory domain, C. So if you want to reclaim C, and a subset of
> its anon has already been pressured to resistance, then a larger part
> of the reclaim candidates in C will need to come from file.

So, basically you can create a tiny memcg without swap in a large
system, create a ton of memory pressure there and bias the global
memory reclaim? That's strange.

