Return-Path: <linux-kernel+bounces-734516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E5B082A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB52173B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8A41B0F1E;
	Thu, 17 Jul 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ej2YWayh"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249D7263B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717496; cv=none; b=t5qPjje7NwFuzElKdMU1n4+/xoj8qW6jvPizpn0kfxK5ImVfX0txms0aDqjxbmijNV/0D63vdBWYqQd8vs+dE0veMSJnDHV0pM1s9ERmb4fP3wxYrRMbqIXC8eLAhiXH/TbAHm4Ou1NQk4zGzj7djtuk12hoS+Dg91Gb4OObBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717496; c=relaxed/simple;
	bh=is6KyaSXGSqCngT7e2V3DgRJv49jMlpRi0X3V1USDG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1KBPNJWSUpPa0RP3RI0QN+K4qbU6Ta4O9MchQDqDJikEVKeftPZKPgYrxkYrS6th3L5PuOlW6ADrSf5Cc3qsxZmnxKT4NDNMDrQFjRRE3D4oMT3N2T2ngqBa0bwdtVl5RRI+rwQZQRQ669izTpkKD8y/SIP1f44KOak8r6H2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ej2YWayh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752717492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwiwtufpFedxgqMjpz1kH9fqYtgdYnalndUuHDgZNrQ=;
	b=ej2YWayhpu5nKiqXw79QqDkgrdyzyfGGaXRuVp8PMbDHEzLV/kscqEvOIlRiPVdhMXBaAF
	39UxDtQqQHggdEJyLVlFy6G+S38dOM4yWDUqiwlwsBvknd+vkgRSj/qdwD5ctJcSTfHSiG
	uBJN9i0eqgZxLKf2cl/BDA8EaJYGZj0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org,  mhocko@kernel.org,  hannes@cmpxchg.org,
  shakeel.butt@linux.dev,  yosryahmed@google.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
In-Reply-To: <20250623185851.830632-3-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 23 Jun 2025 11:58:49 -0700")
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-3-dave@stgolabs.net>
Date: Wed, 16 Jul 2025 18:58:04 -0700
Message-ID: <87bjpjshn7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Davidlohr Bueso <dave@stgolabs.net> writes:

> This adds a general call for both parsing as well as the
> common reclaim semantics. memcg is still the only user and
> no change in semantics.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  mm/internal.h   |  2 +
>  mm/memcontrol.c | 77 ++------------------------------------
>  mm/vmscan.c     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 73 deletions(-)
> ...
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c13c01eb0b42..63ddec550c3b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -57,6 +57,7 @@
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/parser.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -6714,6 +6715,15 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  
>  	return nr_reclaimed;
>  }
> +#else
> +unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> +					   unsigned long nr_pages,
> +					   gfp_t gfp_mask,
> +					   unsigned int reclaim_options,
> +					   int *swappiness)
> +{
> +	return 0;
> +}
>  #endif
>  
>  static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> @@ -7708,6 +7718,94 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  
>  	return ret;
>  }
> +
> +enum {
> +	MEMORY_RECLAIM_SWAPPINESS = 0,
> +	MEMORY_RECLAIM_SWAPPINESS_MAX,
> +	MEMORY_RECLAIM_NULL,
> +};
> +static const match_table_t tokens = {
> +	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
> +	{ MEMORY_RECLAIM_SWAPPINESS_MAX, "swappiness=max"},
> +	{ MEMORY_RECLAIM_NULL, NULL },
> +};
> +
> +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
> +{
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int swappiness = -1;
> +	char *old_buf, *start;
> +	substring_t args[MAX_OPT_ARGS];
> +
> +	if (!buf || (!memcg && !pgdat))
> +		return -EINVAL;
> +
> +	buf = strstrip(buf);
> +
> +	old_buf = buf;
> +	nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
> +	if (buf == old_buf)
> +		return -EINVAL;
> +
> +	buf = strstrip(buf);

To be honest, not a big fan of this refactoring. Effectively parts of
the memcg user interface are moved into mm/vmscan.c. I get that you want
to use the exact same interface somewhere else, but still...

Is it possible to keep it in mm/memcontrol.c?
Also maybe split the actual reclaim mechanism and user's input parsing?

Thanks

