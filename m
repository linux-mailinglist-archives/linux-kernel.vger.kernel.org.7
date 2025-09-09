Return-Path: <linux-kernel+bounces-807213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9CB4A1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40A23ADCC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41C2FE049;
	Tue,  9 Sep 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbKkmzWf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A297246BA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397487; cv=none; b=UoQCQVKSNP5tEPoxoJpMjDYi1xvvsu1CdK6uzLGK2tCV1gOa8mv31pJdY4IGKmbZLjj+0lML9Yfkz/WUddJX9ILFLR8xor232ylfMxyvWx93Vb2CmYS8We8A5gIGzZChnJZRTImLssWBNlIw4iaUzYVrXdaOpFYR62gpJAgAp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397487; c=relaxed/simple;
	bh=nQqtfUtTb3gohcOmnZY+iaMen2eBTnTaTfdkMzfTTOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr1DbPcyJjUZ/Wvv9ZFkLjglu8+SI/iguZklAnmt0l6fP3ZVuB0bO6TBc7Ta4F3GvKTYTL1FdtXRrvjsPKhhFzeo19LwBcCvUXi2/wUR22nWBnC6jLM/yJiN9VkzqmPIM1/qm0o7k89S/pUtuXXXU3AS9G61Kx18V3jKXHN8DfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbKkmzWf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77247e25a69so464907b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757397485; x=1758002285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DggTN4E5dBZUCumd1C+59dNXXLSXOXcd98w2I28eygo=;
        b=IbKkmzWfK2muqOJ569dDHHX2pC8xX6a9wg3KmvubWdaeaVFs2oAZ0JrXlCtEKQeof3
         0YaY7ZqVBOsvPCDJhMdLQiPuHiyWc5gbsRMrkZYg+grIKBw0tDQIHOd9tYvaMEWGCgcJ
         ppMRwkjJ3odSx07SspFtsEf+CNzY20UzxnajUaWNg7IjBSxB8VWUOTCEvmYmB1hYt4mh
         SC/XGCbJWEVQ/HLG3/D8KOnrdy0WXdCp8mbVu7bZavNjjyxWoAo+wbL8OPsW2uyEwSqx
         kwPgyrac0o/wn4gOBJxsNZ5Ik8QRfwyRZmmzRHHmp11CEq5tqozpCX4cOkN5eH5W4xeK
         g0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757397485; x=1758002285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DggTN4E5dBZUCumd1C+59dNXXLSXOXcd98w2I28eygo=;
        b=R8BuGOIolm3nm5ACpvRIaRa2F5xJnAIPaRxa0tYJEX0DELKN9JmKjd5oJP7nrNPkk0
         rIdUyVq1bH0Q4NiW7tdjaS97YSRc5T1Tmc1BVabyOYZnDHqW74Ru+1LH4dDm/jnXZeU0
         q8Rfxasj4tCjQTrK+dfpMvpt99IvDBwvVa2vxKQXAOumT+Oxje9d5a7coKz4THtcT433
         SkAADUkhmuwKAhvSXGWMO6nT7lBvh2ZdeAwKuQ0/rRnOsmR6OImtnSj6EtPBvHvOVn2k
         5lAAZI4YJLM6NCH3p3iZTGBPKIG/RvsLTt6TNDSXXHmVUAA2v0QljZBpLyPrrHZqHkld
         sFPw==
X-Forwarded-Encrypted: i=1; AJvYcCVzrRIcxPiKF2toeLsVyBgOwy07bgQO6r+5c6CGkY8JYAGeWhbmXCuRStG0Zv0RROrSru9jgM2hyu50rLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPG7eBBkQoonUOLzL3mqcFKb+e3cGSevpDEqAkWdrycLlpcwW7
	dpnwlfEPlXZ19zj1UZ7n2+fD/Dvis/NKgM6EY1RNKePiiuwOH3qPELFr
X-Gm-Gg: ASbGncsiseHj40/5/W7D2ihtQ6qVpBhO8N+wvBNx+H+H2m6M8ssMnGoRW7QRsqTHbtu
	YxTRH/no/OrYKpp6+Zgq7MgmV1a2nqOWzk5t8KQkPh0wLu6yu3Iwv65cJV6ytiP9PGGlDbrR1xi
	/RgYsFmtg2ewn3+LwodaBFM8NdM8w++b1ZOZ/TN00JOTT4QbIrUsLLmi8ThZ9NVwR9pIZnOUDH/
	QArWjsPzai9AMVarEYLEC8osgHi2Ec9A1oQxIDnTdYxsEHeI/xhUyBd0W78TIp1c7/w3FuqUYVk
	uSHLzNfe8bk9Vv6UQmx+8w3s+NeN+e+jKBCMNiDedUb6guFT/Hu6pywK0cJtCGu9SM9weYbrKEt
	x8u8wRdVW8K874uhmPxGHEfiQwm9+Gg==
X-Google-Smtp-Source: AGHT+IEQaF8VkteRDiHl9DxWqny/r7YFyWqrpkAO6xB9vMqaCt5n2cMBeffBByxPadsRktPirb1Ygw==
X-Received: by 2002:a05:6a00:c8c:b0:771:f3c2:bbfc with SMTP id d2e1a72fcca58-7742de8eb0fmr7007745b3a.7.1757397484776;
        Mon, 08 Sep 2025 22:58:04 -0700 (PDT)
Received: from pcw-MS-7D22 ([115.145.175.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e76ebsm855505b3a.11.2025.09.08.22.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 22:58:04 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:57:59 +0900
From: Chanwon Park <flyinrm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: re-enable kswapd when memory pressure subsides or
 demotion is toggled
Message-ID: <aL/B57jl7y5K1tJ/@pcw-MS-7D22>
References: <aL6qGi69jWXfPc4D@pcw-MS-7D22>
 <20250908170650.8ede03581f38392a34d0d1f7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908170650.8ede03581f38392a34d0d1f7@linux-foundation.org>

On Mon, Sep 08, 2025 at 05:06:50PM -0700, Andrew Morton wrote:
> On Mon, 8 Sep 2025 19:04:10 +0900 Chanwon Park <flyinrm@gmail.com> wrote:
> 
> > If kswapd fails to reclaim pages from a node MAX_RECLAIM_RETRIES in a
> > row, kswapd on that node gets disabled. That is, the system won't wakeup
> > kswapd for that node until page reclamation is observed at least once.
> > That reclamation is mostly done by direct reclaim, which in turn enables
> > kswapd back.
> > 
> > However, on systems with CXL memory nodes, workloads with high anon page
> > usage can disable kswapd indefinitely, without triggering direct
> > reclaim. This can be reproduced with following steps:
> > 
> >    numa node 0   (32GB memory, 48 CPUs)
> >    numa node 2~5 (512GB CXL memory, 128GB each)
> >    (numa node 1 is disabled)
> >    swap space 8GB
> > 
> >    1) Set /sys/kernel/mm/demotion_enabled to 0.
> >    2) Set /proc/sys/kernel/numa_balancing to 0.
> >    3) Run a process that allocates and random accesses 500GB of anon
> >       pages.
> >    4) Let the process exit normally.
> 
> hm, OK, I guess this is longstanding misbehavior?
> 

Yes, unless there's any application forced to allocate pages on node 0
running, kswapd stays disabled until reboot.

> > 
> > Since kswapd_failures resets may be missed by ++ operation, it is
> > changed from int to atomic_t.
> 
> Possibly this should have been a separate (earlier) patch.  But I
> assume the need for this conversion was inroduced by this patch, so
> it's debatable.
> 

May be I should've done that, but I wasn't sure if it was the right
thing to do... It seemed that atomic_t was not needed before, and
changing the type alone meant it just adds overhead without any gain
(for that patch). But I also think splitting them is a logical thing to
do. Should I split and reupload the patch (with changes you made)?

> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1411,7 +1411,7 @@ typedef struct pglist_data {
> >  	int kswapd_order;
> >  	enum zone_type kswapd_highest_zoneidx;
> >  
> > -	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
> > +	atomic_t kswapd_failures;	/* Number of 'reclaimed == 0' runs */
> 
> This caused a number of 80-column horrors!  I had a fiddle, what do you
> think?
> 

The changes you made look good to me! Sorry for the noise.

Sorry, my previous reply missed the mailing lists.
Resending with proper Cc.

--
Best regards,
Chanwon Park

> --- a/mm/page_alloc.c~mm-re-enable-kswapd-when-memory-pressure-subsides-or-demotion-is-toggled-fix
> +++ a/mm/page_alloc.c
> @@ -2860,29 +2860,29 @@ static void free_frozen_page_commit(stru
>  		 */
>  		return;
>  	}
> +
>  	high = nr_pcp_high(pcp, zone, batch, free_high);
> -	if (pcp->count >= high) {
> -		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
> -				   pcp, pindex);
> -		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
> -		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
> -				      ZONE_MOVABLE, 0)) {
> -			struct pglist_data *pgdat = zone->zone_pgdat;
> -			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
> +	if (pcp->count < high)
> +		return;
>  
> -			/*
> -			 * Assume that memory pressure on this node is gone
> -			 * and may be in a reclaimable state. If a memory
> -			 * fallback node exists, direct reclaim may not have
> -			 * been triggered, leaving 'hopeless node' stay in
> -			 * that state for a while. Let kswapd work again by
> -			 * resetting kswapd_failures.
> -			 */
> -			if (atomic_read(&pgdat->kswapd_failures)
> -			    >= MAX_RECLAIM_RETRIES &&
> -			    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
> -				atomic_set(&pgdat->kswapd_failures, 0);
> -		}
> +	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
> +			   pcp, pindex);
> +	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
> +	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
> +			      ZONE_MOVABLE, 0)) {
> +		struct pglist_data *pgdat = zone->zone_pgdat;
> +		clear_bit(ZONE_BELOW_HIGH, &zone->flags);
> +
> +		/*
> +		 * Assume that memory pressure on this node is gone and may be
> +		 * in a reclaimable state. If a memory fallback node exists,
> +		 * direct reclaim may not have been triggered, causing a
> +		 * 'hopeless node' to stay in that state for a while.  Let
> +		 * kswapd work again by resetting kswapd_failures.
> +		 */
> +		if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES &&
> +		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
> +			atomic_set(&pgdat->kswapd_failures, 0);
>  	}
>  }
>  
> --- a/mm/show_mem.c~mm-re-enable-kswapd-when-memory-pressure-subsides-or-demotion-is-toggled-fix
> +++ a/mm/show_mem.c
> @@ -278,8 +278,8 @@ static void show_free_areas(unsigned int
>  #endif
>  			K(node_page_state(pgdat, NR_PAGETABLE)),
>  			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
> -			str_yes_no(atomic_read(&pgdat->kswapd_failures)
> -				   >= MAX_RECLAIM_RETRIES),
> +			str_yes_no(atomic_read(&pgdat->kswapd_failures) >=
> +				   MAX_RECLAIM_RETRIES),
>  			K(node_page_state(pgdat, NR_BALLOON_PAGES)));
>  	}
>  
> _
> 

