Return-Path: <linux-kernel+bounces-747631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62BB1361E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752F6177E39
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7E224B12;
	Mon, 28 Jul 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YOHmIu6c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pQ+UXydN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YOHmIu6c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pQ+UXydN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84C1DC9B5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690563; cv=none; b=KqnmOgrTGGJIi32A7WVKS8F8LN7cPIhiEykH1RGnc1cZ+WBRz0yyIYbhq5Uj59UpuO8StpjCraG5CpVgr62TEcx8or+55VcGAONughpTyyUBrKSl/gRcFMOI5Uhvi6aQ2cQ4Mi+ASD2QFuOIP04PIEk4+0wEsUdr3enSL4bXnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690563; c=relaxed/simple;
	bh=PcD6AUaKMhrQKNEzKtDh8L0CzKuVz0LArTcjrvQqk5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozZIS/i1LWi0DkRm6/dR1qK/KITMwWa6Oi8fOpAQI5Au/jGB4qwDdANnddMrWPW0PbPArM1PpOr75HTXYW9JsMEUavVG2fUBDUp+zB3BeaMvp0jSY66q5LZ5lSBpyrvDRqbQeXiOmDT3L62EWqhP+bVXu/57Yk8WGrXbYd+HETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YOHmIu6c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pQ+UXydN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YOHmIu6c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pQ+UXydN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35130216EE;
	Mon, 28 Jul 2025 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753690554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HXhzMaFuh7vb5Rrfd9w/8LMRu0pb0blUMzRiad8fKbo=;
	b=YOHmIu6cvuvYkmWFnd1acUhY1cMMwLMAoPiyU8zd6MVLu2mR/qKBHWvArwtJz2jYPOxGzM
	rK+om4zwmjJt9NAMFlGRM0hC0fOmo+7JKOyu+yujxzdUCMLzJ9iRildyRljuqZpouVVCUN
	4UXbK2eS1Xc385L9LHRJtNs5TSy/X7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753690554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HXhzMaFuh7vb5Rrfd9w/8LMRu0pb0blUMzRiad8fKbo=;
	b=pQ+UXydNBn8vugRHXLpfN/zC9+2Y2K6NVoKYrKFd8fB67MbEnix0itIqkID7uar3NyA9lg
	bX/HAeoUvc+tYnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753690554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HXhzMaFuh7vb5Rrfd9w/8LMRu0pb0blUMzRiad8fKbo=;
	b=YOHmIu6cvuvYkmWFnd1acUhY1cMMwLMAoPiyU8zd6MVLu2mR/qKBHWvArwtJz2jYPOxGzM
	rK+om4zwmjJt9NAMFlGRM0hC0fOmo+7JKOyu+yujxzdUCMLzJ9iRildyRljuqZpouVVCUN
	4UXbK2eS1Xc385L9LHRJtNs5TSy/X7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753690554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HXhzMaFuh7vb5Rrfd9w/8LMRu0pb0blUMzRiad8fKbo=;
	b=pQ+UXydNBn8vugRHXLpfN/zC9+2Y2K6NVoKYrKFd8fB67MbEnix0itIqkID7uar3NyA9lg
	bX/HAeoUvc+tYnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7CB3138A5;
	Mon, 28 Jul 2025 08:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +3bxMbkxh2haFwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 28 Jul 2025 08:15:53 +0000
Date: Mon, 28 Jul 2025 10:15:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: david@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@kernel.org>
Subject: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIcxs2nk3RNWWbD6@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi,

Currently, we have several mechanisms to pick a zone for the new memory we are
onlining.
Eventually, we will land on zone_for_pfn_range() which will pick the zone.

Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
The former will put every single hotpluggled memory in ZONE_MOVABLE
(unless we can keep zones contiguous by not doing so), while the latter
will put it in ZONA_MOVABLE IFF we are within the established ratio
MOVABLE:KERNEL.

It seems, the later doesn't play well with CXL memory where CXL cards hold really
large amounts of memory, making the ratio fail, and since CXL cards must be removed
as a unit, it can't be done if any memory block fell within
!ZONE_MOVABLE zone.

One way to tackle this would be update the ratio every time a new CXL
card gets inserted, but this seems suboptimal.
Another way is that since CXL memory works with selfhosted memmap, we could relax
the check when 'auto-movable' and only look at the ratio if we aren't
working with selfhosted memmap.

Something like the following (acthung: it's just a PoC)
Comments? Ideas? 

 diff --git a/drivers/base/memory.c b/drivers/base/memory.c
 index 5c6c1d6bb59f..ff87cfb3881a 100644
 --- a/drivers/base/memory.c
 +++ b/drivers/base/memory.c
 @@ -234,7 +234,7 @@ static int memory_block_online(struct memory_block *mem)
  		return -EHWPOISON;
 
  	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 -				  start_pfn, nr_pages);
 +				  start_pfn, nr_pages, mem->altmap);
 
  	/*
  	 * Although vmemmap pages have a different lifecycle than the pages
 @@ -473,11 +473,11 @@ static ssize_t phys_device_show(struct device *dev,
  static int print_allowed_zone(char *buf, int len, int nid,
  			      struct memory_group *group,
  			      unsigned long start_pfn, unsigned long nr_pages,
 -			      int online_type, struct zone *default_zone)
 +			      int online_type, struct zone *default_zone, struct vmem_altmap *altmap)
  {
  	struct zone *zone;
 
 -	zone = zone_for_pfn_range(online_type, nid, group, start_pfn, nr_pages);
 +	zone = zone_for_pfn_range(online_type, nid, group, start_pfn, nr_pages, altmap);
  	if (zone == default_zone)
  		return 0;
 
 @@ -509,13 +509,13 @@ static ssize_t valid_zones_show(struct device *dev,
  	}
 
  	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, group,
 -					  start_pfn, nr_pages);
 +					  start_pfn, nr_pages, mem->altmap);
 
  	len = sysfs_emit(buf, "%s", default_zone->name);
  	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
 -				  MMOP_ONLINE_KERNEL, default_zone);
 +				  MMOP_ONLINE_KERNEL, default_zone, mem->altmap);
  	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
 -				  MMOP_ONLINE_MOVABLE, default_zone);
 +				  MMOP_ONLINE_MOVABLE, default_zone, mem->altmap);
  	len += sysfs_emit_at(buf, len, "\n");
  	return len;
  }
 diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
 index 23f038a16231..89f7b9c5d995 100644
 --- a/include/linux/memory_hotplug.h
 +++ b/include/linux/memory_hotplug.h
 @@ -328,7 +328,7 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
  					  unsigned long pnum);
  extern struct zone *zone_for_pfn_range(int online_type, int nid,
  		struct memory_group *group, unsigned long start_pfn,
 -		unsigned long nr_pages);
 +		unsigned long nr_pages, struct vmem_altmap *altmap);
  extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
  				      struct mhp_params *params);
  void arch_remove_linear_mapping(u64 start, u64 size);
 diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
 index 69a636e20f7b..6c6600a9c839 100644
 --- a/mm/memory_hotplug.c
 +++ b/mm/memory_hotplug.c
 @@ -1048,7 +1048,7 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 
  struct zone *zone_for_pfn_range(int online_type, int nid,
  		struct memory_group *group, unsigned long start_pfn,
 -		unsigned long nr_pages)
 +		unsigned long nr_pages, struct vmem_altmap *altmap)
  {
  	if (online_type == MMOP_ONLINE_KERNEL)
  		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
 @@ -1056,6 +1056,10 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  	if (online_type == MMOP_ONLINE_MOVABLE)
  		return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
 
 +	/* Selfhosted memmap, skip ratio check */
 +	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE && altmap)
 +		return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
 +
  	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE)
  		return auto_movable_zone_for_pfn(nid, group, start_pfn, nr_pages);

-- 
Oscar Salvador
SUSE Labs

