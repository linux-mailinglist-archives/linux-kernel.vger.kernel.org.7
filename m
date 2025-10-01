Return-Path: <linux-kernel+bounces-838780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB166BB01F8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C787177596
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68932C3250;
	Wed,  1 Oct 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27x6QSsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gIzBnHXK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27x6QSsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gIzBnHXK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D72C3265
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317668; cv=none; b=oH2nIJPLW9bKEl5lDL2x5weaz951Lpk4A6eNmqKqaFOpqToMBqO1ZJXmwtxhV4gytDAx9nXW8gcRcNLS34fczVcx0v7T45L3SYN/Q+2WkjWGflhyOeoOWTMMGest4xuREYZM0huM6K2Si4YAcjo1gmgFmv+SNM9LQm2jhQIcXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317668; c=relaxed/simple;
	bh=hmF/lI8pMoVG47HFC2l+uHYvXKY+xODQGwkcduME3/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDCOnL5tXpuDDP0Wx22jNGhhlHUVn27BovJMnggHNzkkpj3OQV4IC2SpDKw5ZotlR/rMLDcnm535O+PvdPt42u2VDHBSA+xyBnVPOwgnWTxOJ7kT4l6DsW9ezSdr1xSHMzlPpC4LWiNvjyhkwX6P+XUR7SaSVxdfzCGoiKHEuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27x6QSsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gIzBnHXK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27x6QSsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gIzBnHXK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30F041FB6C;
	Wed,  1 Oct 2025 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759317663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PF0wBi19hCMZbudds09SMu1E6+Thus+lwXfrPMqv/OQ=;
	b=27x6QSsLnXfDgXY7pdEYSiZXKKor/atJajs4IHb9CiYvXbS8LZJh6jeOaQbyhHf70Z9x/U
	zjgMZjaizsIsEe9ybGSqit0kpkCYa+AR0LWJVR3rD51nn+pRT9YXH7CFV6QuoYDicAYhl8
	fvUeahFf8QDGGEgBVG3JSRYAvzxrg58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759317663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PF0wBi19hCMZbudds09SMu1E6+Thus+lwXfrPMqv/OQ=;
	b=gIzBnHXKDLn2i76VXzzgf1C9Z5lCSTfOVvUxwyauayG+U5gMiznPQijHtafE1CiYcSX5tG
	WsnNmvjEr6y6TpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759317663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PF0wBi19hCMZbudds09SMu1E6+Thus+lwXfrPMqv/OQ=;
	b=27x6QSsLnXfDgXY7pdEYSiZXKKor/atJajs4IHb9CiYvXbS8LZJh6jeOaQbyhHf70Z9x/U
	zjgMZjaizsIsEe9ybGSqit0kpkCYa+AR0LWJVR3rD51nn+pRT9YXH7CFV6QuoYDicAYhl8
	fvUeahFf8QDGGEgBVG3JSRYAvzxrg58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759317663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PF0wBi19hCMZbudds09SMu1E6+Thus+lwXfrPMqv/OQ=;
	b=gIzBnHXKDLn2i76VXzzgf1C9Z5lCSTfOVvUxwyauayG+U5gMiznPQijHtafE1CiYcSX5tG
	WsnNmvjEr6y6TpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 218DF13A3F;
	Wed,  1 Oct 2025 11:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CarzB58O3WjSZwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 11:21:03 +0000
Message-ID: <138f3057-8aab-4bfb-a541-dbf1a51a32bb@suse.cz>
Date: Wed, 1 Oct 2025 13:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in
 drain_pages_zone
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>,
 Kiryl Shutsemau <kirill@shutemov.name>, Brendan Jackman
 <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 Mel Gorman <mgorman@techsingularity.net>
References: <20250925184446.200563-1-joshua.hahnjy@gmail.com>
 <567be36f-d4ef-e5bc-e11c-3718272d3dfe@gentwo.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <567be36f-d4ef-e5bc-e11c-3718272d3dfe@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gentwo.org,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 9/26/25 6:21 PM, Christoph Lameter (Ampere) wrote:
> On Thu, 25 Sep 2025, Joshua Hahn wrote:
> 
>>> So we need an explanation as to why there is such high contention on the
>>> lock first before changing the logic here.
>>>
>>> The current logic seems to be designed to prevent the lock contention you
>>> are seeing.
>>
>> This is true, but my concern was mostly with the value that is being used
>> for the batching (2048 seems too high). But as I explain below, it seems
>> like the min(2048, count) operation is a no-op anyways, since it is never
>> called with count > 1000 (at least from the benchmarks that I was running,
>> on my machine).
> 
> 
> The problem is that you likely increase zone lock contention with a
> reduced batch size.
> 
> Actually that there is a lock in the pcp structure is weird and causes
> cacheline bouncing on such hot paths. Access should be only from the cpu

The hot paths only access the lock local to them so should not cause
bouncing.

> that owns this structure. Remote cleaning (if needed) can be triggered via
> IPIs.

It used to be that way but Mel changed it to the current implementation
few years ago. IIRC one motivation was to avoid disabling irqs (that
provide exclusion with IPI handlers), hence the spin_trylock() approach
locally and spin_lock() for remote flushing.

Today we could use local_trylock() instead of spin_trylock()
theoretically. The benefit is being inline, unlike spin_trylock() (on
x86). But an IPI handler (that must succeed and can't give up if the
lock is already taken by the operation it interrupted) wouldn't work
with that - it can't give up nor "spin". So the remote flushes would
need to use queue/flush work instead and then the preempt disable +
local_trylock() would be enough (work handler can't interrupt a preempt
disabled section). I don't know if that would make the remote flushes
too expensive though or whether they only happen in such slowpaths to be
acceptable.

> This is the way it used to be and the way it was tested for high core
> counts years ago.
> 
> You seem to run 176 cores here so its similar to what we tested way back
> when. If all cores are accessing the pcp structure then you have
> significant cacheline bouncing. Removing the lock and going back to the
> IPI solution would likely remove the problem.

I doubt the problem here is about cacheline bouncing of pcp. AFAIK it's
free_frozen_page_commit() will be called under preempt_disable()
(pcpu_spin_trylock does that) and do a potentially long
free_pcppages_bulk() operation under spin_lock_irqsave(&zone->lock). So
multiple cpus with similarly long free_pcppages_bulk() will spin on the
zone lock with irqs disabled.
Breaking down the time zone lock is held to smaller batches will help
that and reduce the irqs disabled time. But there might be still long
preemption disabled times for the pcp, and that's IIRC enough to cause
rcu_sched stalls? So patch 4/4 also relinquishes the pcp lock itself
(i.e. enables preemption), which we already saw from the lkp report
isn't trivial to do. But none of this is about pcp cacheline bouncing,
AFAICS.

> The cachelines of the allocator per cpu structures are usually very hot
> and should only be touched in rare circumstances from other cpus.

It should be rare enough to not be an issue.

> Having a loop over all processors accessing all the hot percpus structurs
> is likely causing significant performance issues and therefore the issues
> that you are seeing here.
> 
> 
> 


