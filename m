Return-Path: <linux-kernel+bounces-839144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7174BB0EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F0F3A55E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE821303A2B;
	Wed,  1 Oct 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B8beRsMw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/fpq+Hfk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e7B17Kkc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="weQKRlnn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8A25A33F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330579; cv=none; b=qrEIXAgyR4TQfqz3iGTcziwI3tzV5QJBqO6SEddpVjVhnOGnszRMpkyrGByVBLlno/4zbordtvUkq/11VedJBz3UZ65zZaR6NefOUg6bHfdANmiMQoJmcFBcoagta7CYUt3qPr/CCmt/6JoafTF4APOEUJ+XD8v3LT0Uw55bwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330579; c=relaxed/simple;
	bh=YLSbAkSdEatvfoYDJJNnEpPbNs8ZtNj4zXiFFAAVD6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIodTDu/VVLpBzFN7/7IXw5G/uzVwZWJYVes0TubXcl+vNMfAidUySCo+DZzfTLAso0PYYxO9SO/pzspOwIzqGefMqP1CYEHpr+9+WwtATXnFqVUYAfii+/7MuUrJtRmmcAwPsi1sUcZ4rvAEUCAOEnXhCMnRZQlWGT7KHQqvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B8beRsMw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/fpq+Hfk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e7B17Kkc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=weQKRlnn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1C221FB68;
	Wed,  1 Oct 2025 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759330574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZhtT0gMzluiTXihxlk/KdiCQJObMccQuGLJ1fCA3Tw=;
	b=B8beRsMwsgThdOpOnz46NTYz5Yw7rY5zsGfZ6HBNpLQ3kO4xnFd95SzbOwz5KWr9F/Qi/1
	QRxxzpaRbJ4wiPMuyE35Wo/060bcGYB/d9Aexvh8xtOEnlOIGHT6ToyTZcjzWVxghp7SX1
	TdhOld8jVhjPJ1NHmcZxRgNVLNxy3sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759330574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZhtT0gMzluiTXihxlk/KdiCQJObMccQuGLJ1fCA3Tw=;
	b=/fpq+Hfk71kDH7JbsCDVNdqbMlK62EG1d7p9A4Dw9EO2S1gyunXciSOwZI2aS4sYiB1nVj
	aP7nEnRDrnO/IoBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759330573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZhtT0gMzluiTXihxlk/KdiCQJObMccQuGLJ1fCA3Tw=;
	b=e7B17KkcDsAGU+wBEg0xMqKhca2+w3HspG/SG/oscV8W8+NY2xf8Oa96zLMQGCQXTWCdlX
	wzOnREFosnjQ2VoXm+axUyUBAfsYBUNEmHMSoHyx7nJO+Xz2ZEnKP4XQhvje2bsRk5nOQZ
	NmxYTOdFhLyy2pG/X+197K+4SI90Cg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759330573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZhtT0gMzluiTXihxlk/KdiCQJObMccQuGLJ1fCA3Tw=;
	b=weQKRlnnB3ehydu6Q5++VBJftePIMuk/48sR33UW6Iatb1SxCFSDMooBITsTMot0VS40TD
	BXPz7pUFYk5ugkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E399913A42;
	Wed,  1 Oct 2025 14:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lmZZNw1B3WhrLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 14:56:13 +0000
Message-ID: <4a793133-6cb3-42d4-948f-84eae6fa7df3@suse.cz>
Date: Wed, 1 Oct 2025 16:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: avoid kswapd thrashing due to NUMA
 restrictions
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250919162134.1098208-1-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250919162134.1098208-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[google.com,suse.com,nvidia.com,kvack.org,vger.kernel.org,gourry.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 9/19/25 6:21 PM, Johannes Weiner wrote:
> On NUMA systems without bindings, allocations check all nodes for free
> space, then wake up the kswapds on all nodes and retry. This ensures
> all available space is evenly used before reclaim begins. However,
> when one process or certain allocations have node restrictions, they
> can cause kswapds on only a subset of nodes to be woken up.
> 
> Since kswapd hysteresis targets watermarks that are *higher* than
> needed for allocation, even *unrestricted* allocations can now get
> suckered onto such nodes that are already pressured. This ends up
> concentrating all allocations on them, even when there are idle nodes
> available for the unrestricted requests.
> 
> This was observed with two numa nodes, where node0 is normal and node1
> is ZONE_MOVABLE to facilitate hotplugging: a kernel allocation wakes
> kswapd on node0 only (since node1 is not eligible); once kswapd0 is
> active, the watermarks hover between low and high, and then even the
> movable allocations end up on node0, only to be kicked out again;
> meanwhile node1 is empty and idle.

Is this because node1 is slow tier as Zi suggested, or we're talking
about allocations that are from node0's cpu, while allocations on
node1's cpu would be fine?

Also this sounds like something that ZONELIST_ORDER_ZONE handled until
it was removed. But it wouldn't help with the NUMA binding case.

> Similar behavior is possible when a process with NUMA bindings is
> causing selective kswapd wakeups.
> 
> To fix this, on NUMA systems augment the (misleading) watermark test
> with a check for whether kswapd is already active during the first
> iteration through the zonelist. If this fails to place the request,
> kswapd must be running everywhere already, and the watermark test is
> good enough to decide placement.

Suppose kswapd finished reclaim already, so this check wouldn't kick in.
Wouldn't we be over-pressuring node0 still, just somewhat less?

> With this patch, unrestricted requests successfully make use of node1,
> even while kswapd is reclaiming node0 for restricted allocations.
> 
> [gourry@gourry.net: don't retry if no kswapds were active]
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cf38d499e045..ffdaf5e30b58 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3735,6 +3735,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  	struct pglist_data *last_pgdat = NULL;
>  	bool last_pgdat_dirty_ok = false;
>  	bool no_fallback;
> +	bool skip_kswapd_nodes = nr_online_nodes > 1;
> +	bool skipped_kswapd_nodes = false;
>  
>  retry:
>  	/*
> @@ -3797,6 +3799,19 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			}
>  		}
>  
> +		/*
> +		 * If kswapd is already active on a node, keep looking
> +		 * for other nodes that might be idle. This can happen
> +		 * if another process has NUMA bindings and is causing
> +		 * kswapd wakeups on only some nodes. Avoid accidental
> +		 * "node_reclaim_mode"-like behavior in this case.
> +		 */
> +		if (skip_kswapd_nodes &&
> +		    !waitqueue_active(&zone->zone_pgdat->kswapd_wait)) {
> +			skipped_kswapd_nodes = true;
> +			continue;
> +		}
> +
>  		cond_accept_memory(zone, order, alloc_flags);
>  
>  		/*
> @@ -3888,6 +3903,15 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		}
>  	}
>  
> +	/*
> +	 * If we skipped over nodes with active kswapds and found no
> +	 * idle nodes, retry and place anywhere the watermarks permit.
> +	 */
> +	if (skip_kswapd_nodes && skipped_kswapd_nodes) {
> +		skip_kswapd_nodes = false;
> +		goto retry;
> +	}
> +
>  	/*
>  	 * It's possible on a UMA machine to get through all zones that are

