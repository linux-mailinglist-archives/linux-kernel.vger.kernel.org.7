Return-Path: <linux-kernel+bounces-792790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A695CB3C8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E7E3BCD82
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C628312B;
	Sat, 30 Aug 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07nse3Gv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KAWMnW1a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WL63TICa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R907s8od"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF521E5710
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540747; cv=none; b=abRyO6u9iLRbdHmmgSjNZmTzzlA0Ib2OBUvm6QXJPPp8lsB0B/AT+jYdPHVZllfWEHIbBKW3VbeM00a355C95+raB0+Y2C7jNAJOR8nAfqccpp+mIZ/VMlCk7nvqlmfDjK84ciQjCMIiulE10FuQ0dRBu/aeWdb2naJZ2obg/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540747; c=relaxed/simple;
	bh=ishx51BiX93aug6i0EqQOlnvz3B8jmul59DXbazDR5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEJBwn3z+El/hp6mtlw+YKLNb7jOMybsXG2fyOFbAyCMv77M2iD+jOHruiswx/hrtKjT9/HnowRsqAA6ZTRCF6gt0I3WP2gVL5+bQD6Tlvw5jap5+blZDz0JRTZ9HCjdcNJXtO/uAe0okmCVb6W74S44VidbVNcAd86uvNaaDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07nse3Gv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KAWMnW1a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WL63TICa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R907s8od; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9D21F44F;
	Sat, 30 Aug 2025 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756540744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8G5u7p+krPqozve1gIrj1loYM9L0j9YkyF6aK4YOtQ=;
	b=07nse3GvCFE6CoI/WHIWKQ4N7n3LynZbFoQwSLiEiIMu0MZEslcALuaK4P/3BRZRagNmnH
	yHrHjej065py4MRUB2LTYg49CzTBd4Uc7dtqPnHeaLhuLJF3Wn3vqLCC7I2A0tAJaMp4WP
	4Chc+eOIrbSDl3T/DK8VO20umwN7dUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756540744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8G5u7p+krPqozve1gIrj1loYM9L0j9YkyF6aK4YOtQ=;
	b=KAWMnW1agj0GhUHmhtie8hBnXThp7IaJHnMICNTHPGOAbUGZ7BvNzO28yMboD80NNvkQnu
	8KoauSTYWFBegLCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WL63TICa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R907s8od
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756540743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8G5u7p+krPqozve1gIrj1loYM9L0j9YkyF6aK4YOtQ=;
	b=WL63TICa8pQYgOJkaqazgjW9EGrttQoeEIzI2z/Q7dXw1dO16JCegsqUbYZ+0Y6pk0z8zz
	/h3+28NPvPquIjNFQJH+dpB4yRsnv3QR5QTEqLcaFYKHlxqHod5ucpRl+KI+z4OI+1PR/N
	qhoskY0Khg43MyjGw2wcpeyWnvvKJbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756540743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8G5u7p+krPqozve1gIrj1loYM9L0j9YkyF6aK4YOtQ=;
	b=R907s8odvCsU9KujHAwcEqihVuKM8xaPcWRapFVPHQUcVjWHFuhhTZXCLDONOtnim32hfm
	VP5VpC0ucG//wTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B47B0139B1;
	Sat, 30 Aug 2025 07:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QpTjKUavsmh/IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 30 Aug 2025 07:59:02 +0000
Message-ID: <f4f92543-98c7-45f6-9f53-ab340d980a49@suse.cz>
Date: Sat, 30 Aug 2025 09:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE counting
To: Ruan Shiyang <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lkp@intel.com,
 ying.huang@linux.alibaba.com, y-goto@fujitsu.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 vschneid@redhat.com, Ben Segall <bsegall@google.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EA9D21F44F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 7/29/25 05:51, Ruan Shiyang wrote:
> Goto-san reported confusing pgpromote statistics where the
> pgpromote_success count significantly exceeded pgpromote_candidate.
> 
> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>  # Enable demotion only
>  echo 1 > /sys/kernel/mm/numa/demotion_enabled
>  numactl -m 0-1 memhog -r200 3500M >/dev/null &
>  pid=$!
>  sleep 2
>  numactl memhog -r100 2500M >/dev/null &
>  sleep 10
>  kill -9 $pid # terminate the 1st memhog
>  # Enable promotion
>  echo 2 > /proc/sys/kernel/numa_balancing
> 
> After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
> $ grep -e pgpromote /proc/vmstat
> pgpromote_success 2579
> pgpromote_candidate 0
> 
> In this scenario, after terminating the first memhog, the conditions for
> pgdat_free_space_enough() are quickly met, and triggers promotion.
> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
> not in PGPROMOTE_CANDIDATE.
> 
> To solve this confusing statistics, introduce this PGPROMOTE_CANDIDATE_NRL
> to count the missed promotion pages.  And also, not counting these pages
> into PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
> performance of the promotion rate limit.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>

Besides my nit, LGTM.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> Changes since RFC v3:
>   1. change the naming of new added stat to PGPROMOTE_CANDIDATE_NRL.
>   2. improve the description of the two stats.
> ---
>  include/linux/mmzone.h | 16 +++++++++++++++-
>  kernel/sched/fair.c    |  5 +++--
>  mm/vmstat.c            |  1 +
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 283913d42d7b..4345996a7d5a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -230,7 +230,21 @@ enum node_stat_item {
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>  	PGPROMOTE_SUCCESS,	/* promote successfully */
> -	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
> +	/**
> +	 * Candidate pages for promotion based on hint fault latency.  This
> +	 * counter is used to control the promotion rate and adjust the hot
> +	 * threshold.
> +	 */
> +	PGPROMOTE_CANDIDATE,
> +	/**
> +	 * Not rate-limited (NRL) candidate pages for those can be promoted
> +	 * without considering hot threshold because of enough free pages in
> +	 * fast-tier node.  These promotions bypass the regular hotness checks
> +	 * and do NOT influence the promotion rate-limiter or
> +	 * threshold-adjustment logic.
> +	 * This is for statistics/monitoring purposes.
> +	 */
> +	PGPROMOTE_CANDIDATE_NRL,
>  #endif
>  	/* PGDEMOTE_*: pages demoted */
>  	PGDEMOTE_KSWAPD,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a14da5396fb..4022c9c1f346 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1940,11 +1940,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  		struct pglist_data *pgdat;
>  		unsigned long rate_limit;
>  		unsigned int latency, th, def_th;
> +		long nr = folio_nr_pages(folio);
>  
>  		pgdat = NODE_DATA(dst_nid);
>  		if (pgdat_free_space_enough(pgdat)) {
>  			/* workload changed, reset hot threshold */
>  			pgdat->nbp_threshold = 0;
> +			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NRL, nr);
>  			return true;
>  		}
>  
> @@ -1958,8 +1960,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  		if (latency >= th)
>  			return false;
>  
> -		return !numa_promotion_rate_limit(pgdat, rate_limit,
> -						  folio_nr_pages(folio));
> +		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
>  	}
>  
>  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index a78d70ddeacd..bb0d2b330dd5 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_NUMA_BALANCING
>  	"pgpromote_success",
>  	"pgpromote_candidate",
> +	"pgpromote_candidate_nrl",
>  #endif
>  	"pgdemote_kswapd",
>  	"pgdemote_direct",


