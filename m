Return-Path: <linux-kernel+bounces-721568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D4AFCB03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B851894F66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E472DCBF8;
	Tue,  8 Jul 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOz8J1zA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7Fp/wpn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOz8J1zA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7Fp/wpn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E52DC351
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979169; cv=none; b=W+2jmmyiwcRdbTpTCM19g+BlVFTSM0fb11DFHZMbGulHOSPcGXkxKIWnbmM0dw/krelhQ1DQXgC+1dnvL93VcdvnyW2/U+g+6C7gexamMQ27IxEssMxBvJ9HgeRBYfN5tIPxyE3CVNwXJBp0ZkxtIcm77QxPb6xIRSg8H9Lqtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979169; c=relaxed/simple;
	bh=b24voVm+vXhBnVlrrEP1tl+wJA1jMMdeykUXhI18Zjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9qwDqTmv2bJXB4+1sDNjfgSJ23EFQLUIVk5oGntg7J+7wxfpcAB4f7V4CFFJ+4+/w/89f2vmqMRM+6U6OGNmewmhCd2Zuw0nfWQYeVww82etFyOMKD75vfezEoUj/Gx3+PfqZd8qXi08ieFm6VPPmZn0eAfPOmb4tFrfpfNeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOz8J1zA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b7Fp/wpn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOz8J1zA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b7Fp/wpn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0521F785;
	Tue,  8 Jul 2025 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751979165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u5MDak1uUHlCPQAyXAZzrdGQnFgldSEs0l5aw63CNaI=;
	b=wOz8J1zA9U5/sCL1T3lw5mNTDp+tzVlMI81GMZLul/FAvlFnFf+qgb+nS5IhXBsb6RihHe
	2TmBDfCM3Z05QUz0kP6i6k6s+5KO0RcAy1Wvz2Aey4r/7dB9w59hzJga02C2qQSdYKdk1J
	J+bg/tudz5qoraPO2hmPBuQiMCUk44o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751979165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u5MDak1uUHlCPQAyXAZzrdGQnFgldSEs0l5aw63CNaI=;
	b=b7Fp/wpnexbhB7PDzUmYDULO3cS1CYk+lWA7tlt5qAu2XWIeg+GXNxhbzXbsoRmVR09HCz
	S0T7FcyI1b5MHkBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wOz8J1zA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="b7Fp/wpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751979165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u5MDak1uUHlCPQAyXAZzrdGQnFgldSEs0l5aw63CNaI=;
	b=wOz8J1zA9U5/sCL1T3lw5mNTDp+tzVlMI81GMZLul/FAvlFnFf+qgb+nS5IhXBsb6RihHe
	2TmBDfCM3Z05QUz0kP6i6k6s+5KO0RcAy1Wvz2Aey4r/7dB9w59hzJga02C2qQSdYKdk1J
	J+bg/tudz5qoraPO2hmPBuQiMCUk44o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751979165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u5MDak1uUHlCPQAyXAZzrdGQnFgldSEs0l5aw63CNaI=;
	b=b7Fp/wpnexbhB7PDzUmYDULO3cS1CYk+lWA7tlt5qAu2XWIeg+GXNxhbzXbsoRmVR09HCz
	S0T7FcyI1b5MHkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8018D13A68;
	Tue,  8 Jul 2025 12:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mEu7Hp0UbWiKKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Jul 2025 12:52:45 +0000
Message-ID: <4c5852cc-2ca5-432b-8426-01c108df66cb@suse.cz>
Date: Tue, 8 Jul 2025 14:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Content-Language: en-US
To: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <20250707164908.631462-1-vitaly.wool@konsulko.se>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250707164908.631462-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E0521F785
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,gmail.com,kernel.org,google.com,linux.dev,oracle.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 7/7/25 18:49, Vitaly Wool wrote:
> Reimplement k[v]realloc_node() to be able to set node and
> alignment should a user need to do so. In order to do that while
> retaining the maximal backward compatibility, add
> k[v]realloc_node_align() functions and redefine the rest of API
> using these new ones.
> 
> With that change we also provide the ability for the Rust part of
> the kernel to set node and alignment in its K[v]xxx
> [re]allocations.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> ---
>  include/linux/slab.h | 40 ++++++++++++++++++---------
>  mm/slub.c            | 64 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 71 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d5a8ab98035c..13abcf4ada22 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -465,9 +465,15 @@ int kmem_cache_shrink(struct kmem_cache *s);
>  /*
>   * Common kmalloc functions provided by all allocators
>   */
> -void * __must_check krealloc_noprof(const void *objp, size_t new_size,
> -				    gfp_t flags) __realloc_size(2);
> -#define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
> +void * __must_check krealloc_node_align_noprof(const void *objp, size_t new_size,
> +					       unsigned long align,
> +					       gfp_t flags, int nid) __realloc_size(2);
> +#define krealloc_node_noprof(_p, _s, _f, _n) \
> +	krealloc_node_align_noprof(_p, _s, 1, _f, _n)
> +#define krealloc_noprof(...)		krealloc_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
> +#define krealloc_node_align(...)	alloc_hooks(krealloc_node_align_noprof(__VA_ARGS__))
> +#define krealloc_node(...)		alloc_hooks(krealloc_node_noprof(__VA_ARGS__))
> +#define krealloc(...)			alloc_hooks(krealloc_noprof(__VA_ARGS__))

Hm wonder if krealloc() and krealloc_node_align() would be enough. Is
krealloc_node() only used between patch 3 and 4?
Also perhaps it would be more concise to only have
krealloc_node_align_noprof() with alloc_hooks wrappers filling the
NUMA_NO_NODE (and 1), so we don't need to #define the _noprof variant of
everything. The _noprof callers are rare so they can just always use
krealloc_node_align_noprof() directly and also fill in the NUMA_NO_NODE (and 1).

>  void kfree(const void *objp);
>  void kfree_sensitive(const void *objp);
> @@ -1041,18 +1047,23 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
>  #define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
>  #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
>  
> -void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node) __alloc_size(1);
> -#define kvmalloc_node_noprof(size, flags, node)	\
> -	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node)
> +void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
> +			     gfp_t flags, int node) __alloc_size(1);
> +#define kvmalloc_node_align_noprof(_size, _align, _flags, _node)	\
> +	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, NULL), _align, _flags, _node)
> +#define kvmalloc_node_noprof(_size, _flags, _node)	\
> +	kvmalloc_node_align_noprof(_size, 1, _flags, _node)
> +#define kvmalloc_node_align(...)		\
> +	alloc_hooks(kvmalloc_node_align_noprof(__VA_ARGS__))
>  #define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))

Ditto.

>  
> -#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
> -#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
> +#define kvmalloc_noprof(...)			kvmalloc_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
> +#define kvmalloc(...)				alloc_hooks(kvmalloc_noprof(__VA_ARGS__))
>  #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
>  
> -#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
> +#define kvzalloc_node(_s, _f, _n)		kvmalloc_node(_s, (_f)|__GFP_ZERO, _n)
>  #define kmem_buckets_valloc(_b, _size, _flags)	\
> -	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
> +	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), 1, _flags, NUMA_NO_NODE))
>  
>  static inline __alloc_size(1, 2) void *
>  kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
> @@ -1068,13 +1079,16 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>  #define kvmalloc_array_noprof(...)		kvmalloc_array_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
>  #define kvcalloc_node_noprof(_n,_s,_f,_node)	kvmalloc_array_node_noprof(_n,_s,(_f)|__GFP_ZERO,_node)
>  #define kvcalloc_noprof(...)			kvcalloc_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
> -
>  #define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
>  #define kvcalloc_node(...)			alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
>  #define kvcalloc(...)				alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
>  
> -void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> -		__realloc_size(2);
> +void *kvrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
> +				  gfp_t flags, int nid) __realloc_size(2);
> +#define kvrealloc_node_align(...)		kvrealloc_node_align_noprof(__VA_ARGS__)
> +#define kvrealloc_node_noprof(_p, _s, _f, _n)	kvrealloc_node_align_noprof(_p, _s, 1, _f, _n)
> +#define kvrealloc_node(...)			alloc_hooks(kvrealloc_node_noprof(__VA_ARGS__))
> +#define kvrealloc_noprof(...)			kvrealloc_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
>  #define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))

Ditto.

>  extern void kvfree(const void *addr);
> diff --git a/mm/slub.c b/mm/slub.c
> index c4b64821e680..881244c357dd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4845,7 +4845,7 @@ void kfree(const void *object)
>  EXPORT_SYMBOL(kfree);
>  
>  static __always_inline __realloc_size(2) void *
> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
>  {
>  	void *ret;
>  	size_t ks = 0;
> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  	if (!kasan_check_byte(p))
>  		return NULL;
>  
> +	/* refuse to proceed if alignment is bigger than what kmalloc() provides */
> +	if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
> +		return NULL;
> +
> +	/*
> +	 * If reallocation is not necessary (e. g. the new size is less
> +	 * than the current allocated size), the current allocation will be
> +	 * preserved unless __GFP_THISNODE is set. In the latter case a new
> +	 * allocation on the requested node will be attempted.
> +	 */
> +	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> +		     nid != page_to_nid(vmalloc_to_page(p)))

We need virt_to_page() here not vmalloc_to_page().

> +		goto alloc_new;
> +
>  	if (is_kfence_address(p)) {
>  		ks = orig_size = kfence_ksize(p);
>  	} else {

