Return-Path: <linux-kernel+bounces-843764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871BBC0309
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8C3BB933
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77F1E1DE7;
	Tue,  7 Oct 2025 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Ncs3+K94"
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89731C6FF6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814495; cv=none; b=fdIAgRrF4fMkj2d30ARqusNMeRtI0BQtdGJ786/EpCVVUwl3DWBmxFCJV5qRPWhqJ+Y5PDaFbyGIuj6mi/qWwqcLrgMndLT0Bwx7m0eXVqflUY0izazGCMp3i5xFrvOLejY0xNELNgRXjQRIFVI3wG25HcqD+T41QocgKKWaqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814495; c=relaxed/simple;
	bh=ioe1x/PmH1iPsnqnYGXKHAk9dJBXQEaoWR4Ps56hTtw=;
	h=References:Subject:Date:Message-Id:Content-Disposition:
	 In-Reply-To:Content-Type:To:Cc:From:Mime-Version; b=bw8yK+1Ro+cYj8L0cN7WO65BLl94u1a34RgbrvKtHO7b3FGspXBRUT9Nh3np0hhJvLrVncoc3nOPizvtPuwA81obwlG4y0wHZ6Dy1DRRYjBwePWof97RLakqvw1Xr5gtBONahh1zCdcDfpMaXCvQ+o4c5jGqNQ6vnzctBGw3zHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Ncs3+K94; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1759814440;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2OWP7OjahPFwqujua+9lES4WFVOxQRzRe9QjVYi71Cg=;
 b=Ncs3+K940uj2/CpaLfEgpWG3kyT53JODffAquBIPUq20UnMUntoHzADYJk5t7eCdRusCu9
 vzhNXjQcbfN2pFKqURXMJckurokOqOvoD360ucuagE2jw5TibIOO+OoU/6LvMrE4f54tBX
 xYMTgmzS6bFL2728DvCI6DGiLvdlYNJFAn73QXmQdH6Afo6rqHWYtAw0QXZWo2S7D/FrvK
 P44Us1ZJ4hoHNYO5z47+Xertaw1Gl/hnuCCVntbpbom7+L8v6I+jB2Y7cZhW5l3rXooFNz
 0IF9y4EyuPgFiss9Z/kv/ORaT46Kj9p1ujI6YLohg55/gcUM7nXnxe/Eq7Vx8Q==
References: <20251006231845.3082485-2-robertpang@google.com>
Subject: Re: [PATCH] bcache: add "clock" cache replacement policy
Date: Tue, 7 Oct 2025 13:20:37 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <744rdoputvsokkcgud6j7lrs5hlqnxy6oc2sjfxcvxancdinez@stncekhcbzzz>
Received: from studio.lan ([120.245.64.214]) by smtp.feishu.cn with ESMTPS; Tue, 07 Oct 2025 13:20:37 +0800
Content-Disposition: inline
In-Reply-To: <20251006231845.3082485-2-robertpang@google.com>
X-Lms-Return-Path: <lba+268e4a326+11928f+vger.kernel.org+colyli@fnnas.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Coly Li <colyli@fnnas.com>
To: "Robert Pang" <robertpang@google.com>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>, 
	<linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Coly Li" <colyli@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On Mon, Oct 06, 2025 at 04:18:46PM +0800, Robert Pang wrote:
> This new policy extends the FIFO policy to approximate the classic clock policy
> (O(n) time complexity) by considering bucket priority, similar to the LRU
> policy.
> 

Current bcache GC is single thread, clock is good here. BTW, could you please
also add the clock entry into bcache kernel document,
- Documentation/admin-guide/bcache.rst
- Documentation/ABI/testing/sysfs-block-bcache

> This policy addresses the high IO latency (1-2 seconds) experienced on
  ^^^^^^^^^^^-> I assume this policy means LRU, am I correct?

> multi-terabyte cache devices when the free list is empty. The default LRU
> policy's O(n log n) complexity for sorting priorities for the entire bucket
> list causes this delay.
> 

Can you provide performance numbers about lock replacement algorithm and add
them into the commit log?

Yes, for performance optimization, we always need to see the difference made
by this improvement.

Thanks.

Coly Li



> Signed-off-by: Robert Pang <robertpang@google.com>
> ---
>  drivers/md/bcache/alloc.c         | 34 +++++++++++++++++++++++++++----
>  drivers/md/bcache/bcache_ondisk.h |  1 +
>  drivers/md/bcache/sysfs.c         |  1 +
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 48ce750bf70a..c65c48eab169 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -69,7 +69,8 @@
>  #include <linux/random.h>
>  #include <trace/events/bcache.h>
>  
> -#define MAX_OPEN_BUCKETS 128
> +#define MAX_OPEN_BUCKETS	128
> +#define CHECK_PRIO_SLICES	16
>  
>  /* Bucket heap / gen */
>  
> @@ -211,19 +212,41 @@ static void invalidate_buckets_lru(struct cache *ca)
>  	}
>  }
>  
> -static void invalidate_buckets_fifo(struct cache *ca)
> +/*
> + * When check_prio is true, this FIFO policy examines the priority of the
> + * buckets and invalidates only the ones below a threshold in the priority
> + * ladder. As it goes, the threshold will be raised if not enough buckets are
> + * invalidated. Empty buckets are also invalidated. This evaulation resembles
> + * the LRU policy, and is used to approximate the classic clock-sweep cache
> + * replacement algorithm.
> + */
> +static void invalidate_buckets_fifo(struct cache *ca, bool check_prio)
>  {
>  	struct bucket *b;
>  	size_t checked = 0;
> +	size_t check_quota = 0;
> +	uint16_t prio_threshold = ca->set->min_prio;
>  
>  	while (!fifo_full(&ca->free_inc)) {
>  		if (ca->fifo_last_bucket <  ca->sb.first_bucket ||
>  		    ca->fifo_last_bucket >= ca->sb.nbuckets)
>  			ca->fifo_last_bucket = ca->sb.first_bucket;
>  
> +		if (check_prio && checked >= check_quota) {
> +			BUG_ON(ca->set->min_prio > INITIAL_PRIO);
> +			prio_threshold +=
> +				DIV_ROUND_UP(INITIAL_PRIO - ca->set->min_prio,
> +					     CHECK_PRIO_SLICES);
> +			check_quota += DIV_ROUND_UP(ca->sb.nbuckets,
> +						    CHECK_PRIO_SLICES);
> +		}
> +
>  		b = ca->buckets + ca->fifo_last_bucket++;
>  
> -		if (bch_can_invalidate_bucket(ca, b))
> +		if (bch_can_invalidate_bucket(ca, b) &&
> +		    (!check_prio ||
> +		     b->prio <= prio_threshold ||
> +		     !GC_SECTORS_USED(b)))
>  			bch_invalidate_one_bucket(ca, b);
>  
>  		if (++checked >= ca->sb.nbuckets) {
> @@ -269,11 +292,14 @@ static void invalidate_buckets(struct cache *ca)
>  		invalidate_buckets_lru(ca);
>  		break;
>  	case CACHE_REPLACEMENT_FIFO:
> -		invalidate_buckets_fifo(ca);
> +		invalidate_buckets_fifo(ca, false);
>  		break;
>  	case CACHE_REPLACEMENT_RANDOM:
>  		invalidate_buckets_random(ca);
>  		break;
> +	case CACHE_REPLACEMENT_CLOCK:
> +		invalidate_buckets_fifo(ca, true);
> +		break;
>  	}
>  }
>  
> diff --git a/drivers/md/bcache/bcache_ondisk.h b/drivers/md/bcache/bcache_ondisk.h
> index 6620a7f8fffc..d45794e01fe1 100644
> --- a/drivers/md/bcache/bcache_ondisk.h
> +++ b/drivers/md/bcache/bcache_ondisk.h
> @@ -288,6 +288,7 @@ BITMASK(CACHE_REPLACEMENT,		struct cache_sb, flags, 2, 3);
>  #define CACHE_REPLACEMENT_LRU		0U
>  #define CACHE_REPLACEMENT_FIFO		1U
>  #define CACHE_REPLACEMENT_RANDOM	2U
> +#define CACHE_REPLACEMENT_CLOCK		3U
>  
>  BITMASK(BDEV_CACHE_MODE,		struct cache_sb, flags, 0, 4);
>  #define CACHE_MODE_WRITETHROUGH		0U
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 826b14cae4e5..c8617bad0648 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -45,6 +45,7 @@ static const char * const cache_replacement_policies[] = {
>  	"lru",
>  	"fifo",
>  	"random",
> +	"clock",
>  	NULL
>  };
>  
> -- 
> 2.51.0.710.ga91ca5db03-goog

