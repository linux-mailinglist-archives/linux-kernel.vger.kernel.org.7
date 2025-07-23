Return-Path: <linux-kernel+bounces-742399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4471B0F13B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CC23AC4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9722D94B9;
	Wed, 23 Jul 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OkXkdk/F"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DA299A84
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270319; cv=none; b=OjfZyIcWt+MpjtAcqaVSq+Oy+nSJvy3f9X7+bP1YcQW6CKwtDf9xb6THmhEwSLDGFKXYBK1fRc0VQiovH/QIJWLU7nIbr4OSqPkrxqbb7OXQGX9dFSSxOlxRmsuuH9V5hOVFiXbSPz3b4H1EfTk2UcmA/lt9g/1491Z0p4cTp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270319; c=relaxed/simple;
	bh=MzfCHmBha6Q99Kkz33+/BuRWFNKt27I2lSXdNRhOn7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wszg3MIFstK+CWrq8wO9AdXIkaeTlQYFlNtw6C+G5smy3i8LAHl7OtJBWKHaJ7nYw4XqeaFXk89znwqtq5U/m0MFM7cFTdczaDfzCRNXovzL3E7XG9lI++R0dZYLbVEOlMqvrPowCUBFQQyoySsRi3BPhiP4Kehg71TG5EwOQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OkXkdk/F; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Jul 2025 07:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753270305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMn280ldD7P7MRnOeYtZF4M3wweQEZD57ZL/8Ws818w=;
	b=OkXkdk/FtIFnnKaGse7LcZVWp4SopXeSozhXITgV7qc4rKYRGSeqCK0+u1E8ExbwCiPdWm
	BYD0elvIj5+ElXkmTLbmDqoD3HOaQ8k0Rlx1Ftw56zww+CgMaN3RpbSZn6aEHAbmWsENzN
	Y5FcFa0vF7hl67O/zBcziDYH050HTeg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: rientjes@google.com, vbabka@suse.cz, cl@gentwo.org, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, surenb@google.com, 
	pasha.tatashin@soleen.com, akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH 1/1] mm: slub: Introduce one knob to control the track of
 slub object
Message-ID: <mw52yqm7wfe5afb5ybvfkpdgo4pm4wobmzv3um2cov3amekzmi@ye5drijf7njj>
References: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 23, 2025 at 04:03:28PM +0800, Zhenhua Huang wrote:
> Mem profiling feature tracks both "alloc_slab_page"(page level) and slub
> object level allocations. To track object level allocations,
> slabobj_ext consumes 16 bytes per object for profiling slub object if
> CONFIG_MEMCG is set.
> Based on the data I've collected, this overhead accounts for approximately
> 5.7% of slub memory usage — a considerable cost.
> w/ noslub  slub_debug=-
> Slab:              87520 kB
> w/o noslub slub_debug=-
> Slab:              92812 kB
> 
> While In some scenarios, we may choose not to delve into SLUB allocation
> details if initial triage indicates that SLUB memory usage is within
> acceptable limits. To support this, a control knob is introduced to enable
> or disable SLUB object tracking.
> The "noslub" knob disables SLUB tracking, preventing further allocation of
> slabobj_ext structures.

...Have there been actual scenarios where this would be useful?

We've already got a knob for memory allocation profiling as a whole;
most allocations are slub allocations, so if you're looking at memory
allocation profiling you probably want slub.

> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  Documentation/mm/allocation-profiling.rst |  7 +++++-
>  include/linux/alloc_tag.h                 |  8 +++++++
>  lib/alloc_tag.c                           | 26 +++++++++++++++++------
>  mm/slub.c                                 | 10 ++++-----
>  4 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
> index 316311240e6a..9ecae74e0365 100644
> --- a/Documentation/mm/allocation-profiling.rst
> +++ b/Documentation/mm/allocation-profiling.rst
> @@ -18,7 +18,7 @@ kconfig options:
>    missing annotation
>  
>  Boot parameter:
> -  sysctl.vm.mem_profiling={0|1|never}[,compressed]
> +  sysctl.vm.mem_profiling={0|1|never}[,compressed][,noslub]
>  
>    When set to "never", memory allocation profiling overhead is minimized and it
>    cannot be enabled at runtime (sysctl becomes read-only).
> @@ -30,6 +30,11 @@ Boot parameter:
>    If compression fails, a warning is issued and memory allocation profiling gets
>    disabled.
>  
> +  The optional noslub parameter disables tracking of individual SLUB objects. This
> +  approach, similar to how page owner tracking works, relies on slub_debug for SLUB
> +  object insights instead. While this reduces memory overhead, it also limits the
> +  ability to observe detailed SLUB allocation behavior.
> +
>  sysctl:
>    /proc/sys/vm/mem_profiling
>  
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8f7931eb7d16..af3c139712ce 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -134,6 +134,13 @@ static inline bool mem_alloc_profiling_enabled(void)
>  				   &mem_alloc_profiling_key);
>  }
>  
> +DECLARE_STATIC_KEY_TRUE(slub_mem_alloc_profiling_key);
> +
> +static inline bool slub_mem_alloc_profiling_enabled(void)
> +{
> +	return static_key_enabled(&slub_mem_alloc_profiling_key);
> +}
> +
>  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
>  {
>  	struct alloc_tag_counters v = { 0, 0 };
> @@ -227,6 +234,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>  
>  #define DEFINE_ALLOC_TAG(_alloc_tag)
>  static inline bool mem_alloc_profiling_enabled(void) { return false; }
> +static inline bool slub_mem_alloc_profiling_enabled(void) { return false; }
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
>  				 size_t bytes) {}
>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 0142bc916f73..b79b0d987427 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -33,6 +33,8 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>  EXPORT_SYMBOL(mem_alloc_profiling_key);
>  
>  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> +DEFINE_STATIC_KEY_TRUE(slub_mem_alloc_profiling_key);
> +EXPORT_SYMBOL(slub_mem_alloc_profiling_key);
>  
>  struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
>  unsigned long alloc_tag_ref_mask;
> @@ -710,6 +712,7 @@ static inline void free_mod_tags_mem(void) {}
>  static int __init setup_early_mem_profiling(char *str)
>  {
>  	bool compressed = false;
> +	bool noslub = false;
>  	bool enable;
>  
>  	if (!str || !str[0])
> @@ -725,16 +728,19 @@ static int __init setup_early_mem_profiling(char *str)
>  		if (kstrtobool(token, &enable))
>  			return -EINVAL;
>  
> -		if (str) {
> -
> -			if (strcmp(str, "compressed"))
> +		while ((token = strsep(&str, ",")) != NULL) {
> +			if (strcmp(token, "compressed") == 0)
> +				compressed = true;
> +			else if (strcmp(token, "noslub") == 0)
> +				noslub = true;
> +			else
>  				return -EINVAL;
> -
> -			compressed = true;
>  		}
>  		mem_profiling_support = true;
> -		pr_info("Memory allocation profiling is enabled %s compression and is turned %s!\n",
> -			compressed ? "with" : "without", enable ? "on" : "off");
> +		pr_info("Memory allocation profiling is enabled %s compression, %s slub track and is turned %s!\n",
> +			compressed ? "with" : "without",
> +			noslub ? "without" : "with",
> +			enable ? "on" : "off");
>  	}
>  
>  	if (enable != mem_alloc_profiling_enabled()) {
> @@ -749,6 +755,12 @@ static int __init setup_early_mem_profiling(char *str)
>  		else
>  			static_branch_disable(&mem_profiling_compressed);
>  	}
> +	if (noslub == static_key_enabled(&slub_mem_alloc_profiling_key)) {
> +		if (noslub)
> +			static_branch_disable(&slub_mem_alloc_profiling_key);
> +		else
> +			static_branch_enable(&slub_mem_alloc_profiling_key);
> +	}
>  
>  	return 0;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 31e11ef256f9..e8378b092b30 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2093,7 +2093,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
>  }
>  
> -/* Should be called only if mem_alloc_profiling_enabled() */
> +/* Should be called only if slub_mem_alloc_profiling_enabled() */
>  static noinline void
>  __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
> @@ -2102,7 +2102,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
>  	/*
>  	 * Currently obj_exts is used only for allocation profiling.
> -	 * If other users appear then mem_alloc_profiling_enabled()
> +	 * If other users appear then slub_mem_alloc_profiling_enabled()
>  	 * check should be added before alloc_tag_add().
>  	 */
>  	if (likely(obj_exts))
> @@ -2112,11 +2112,11 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  static inline void
>  alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
> -	if (mem_alloc_profiling_enabled())
> +	if (slub_mem_alloc_profiling_enabled())
>  		__alloc_tagging_slab_alloc_hook(s, object, flags);
>  }
>  
> -/* Should be called only if mem_alloc_profiling_enabled() */
> +/* Should be called only if slub_mem_alloc_profiling_enabled() */
>  static noinline void
>  __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			       int objects)
> @@ -2143,7 +2143,7 @@ static inline void
>  alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			     int objects)
>  {
> -	if (mem_alloc_profiling_enabled())
> +	if (slub_mem_alloc_profiling_enabled())
>  		__alloc_tagging_slab_free_hook(s, slab, p, objects);
>  }
>  
> -- 
> 2.34.1
> 

