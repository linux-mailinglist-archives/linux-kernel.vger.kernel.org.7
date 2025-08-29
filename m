Return-Path: <linux-kernel+bounces-791435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31304B3B6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64EB165485
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402F52E5B32;
	Fri, 29 Aug 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pppokbhl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SiyTGGrA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTIBeHeG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDPf2kZW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE23019A2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458491; cv=none; b=DX04EUIqHDrd4Yb3N3etFA3Yj1CgJVCYT8fVH0oAujAIvYP4IEmY7gSX0QfKqq1VA1gdre4mYczXoUPv/14pLOS5Lt4ob07zPdj6FgcVK5eUozajIKNnRjT/1GS42o1lqKpVOD9HBzRBNmlWhNKEJCitWrmdi8hK2pA132UUgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458491; c=relaxed/simple;
	bh=4dlhikmtXHjSDzlaAGBVUiAGzbwtvczO/FMC72xi2ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8oh84XQdSEZnLy8KlKH1h2WFRvnqQpvKiJz8W4+X4ZqfcSZDr+ogX5Y/XtRPjrwy27z/2x+VNF300nyK1cHyxV+CSjW4e1ecd/2R8HQdtvNUNPlQSgqNHLNLDlX7DRAj7V4dxrhBYPTL4xrOe77ttHOxsrY1zO+pOLe0lrZSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pppokbhl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SiyTGGrA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTIBeHeG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDPf2kZW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9C2933C9B;
	Fri, 29 Aug 2025 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756458487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT8tkb1gHxlcF3Nk61gZQsdQdGjnax6ZQU5myl5eEUU=;
	b=pppokbhl3LG2+41EjAhE4SWGZpLpdJ7e6ZVc3Cw5PQcm2GRJQunTCn+AHAIoWDLEivBsuY
	79f6KU3tg5y9CyoyTqQ/9Cl+cnKw9g3l5aFDfxsTOh6gOMAhbqE6C5Ywc8StGauWxfijoe
	iIyGvcqjPyyfvjF4XVDHHFWhHUZuYWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756458487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT8tkb1gHxlcF3Nk61gZQsdQdGjnax6ZQU5myl5eEUU=;
	b=SiyTGGrAZ9+TqBz/fvZSbuBEEZRnpa1VAPd2qiERGHbSZwn2RAGM1aXQgb0dNEx6A070Wt
	iOaGpKTlKEy3QlDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756458486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT8tkb1gHxlcF3Nk61gZQsdQdGjnax6ZQU5myl5eEUU=;
	b=cTIBeHeGDHlahJaVESv8Nc4Exc4+6XVH4pmTYDBHp52w/QXG7SWs69UknE4pBzwBR/lqsk
	SxIfVnbJi0Wzf7kWo+hvZhikrVvC33W8ZnAImSdEWOwqLSQqHP85Q9z35StNU01qhMFQXs
	OBARi2VfbAJzuUfD66iahmR4LOIG8Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756458486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kT8tkb1gHxlcF3Nk61gZQsdQdGjnax6ZQU5myl5eEUU=;
	b=TDPf2kZW5U7YaePioRdo2EfdQDBj4S+1/Dm4kZMQc85S/9eNJdru/j23tDYVHwysAGH+4a
	i5qiWlOE7SqaZ6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A86213326;
	Fri, 29 Aug 2025 09:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id trXZJPZtsWhjKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 29 Aug 2025 09:08:06 +0000
Message-ID: <23765f70-e869-4ef6-8ddd-24c0b1548fb2@suse.cz>
Date: Fri, 29 Aug 2025 11:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE counting
Content-Language: en-US
To: Ruan Shiyang <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, lkp@intel.com,
 ying.huang@linux.alibaba.com, akpm@linux-foundation.org, y-goto@fujitsu.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 mgorman@suse.de, vschneid@redhat.com, Ben Segall <bsegall@google.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,goodmis.org:email,suse.cz:mid,suse.de:email,arm.com:email,infradead.org:email,linaro.org:email,alibaba.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/29/25 05:51, Ruan Shiyang wrote:

A process nit: your RFC v3 had:

From: Li Zhijian <lizhijian@fujitsu.com>

and this one doesn't.

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

So the S-o-b from Li doesn't match anything now.
You can either reinstate that "From: Li ..." or add a "Co-developed-by: Li
..." right above the "S-o-b: Li ..." - that's for you two to decide who is
the main author.

More details in Documentation/process/submitting-patches.rst

> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
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


