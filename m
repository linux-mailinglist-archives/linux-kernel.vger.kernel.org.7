Return-Path: <linux-kernel+bounces-834044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E87BA3AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907E2384465
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4CA273800;
	Fri, 26 Sep 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7XDtirT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPVE3V0R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7XDtirT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPVE3V0R"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C201397
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890899; cv=none; b=jbTcg4qCOsJDdc28w5J3PsjCFIjzzd+mg9Ix2Ie8fmp8x9cnWTO5/xLXw1lJdiDeFJhJWfJheDqbDfp4SG1QbmXYJzBQ71DaWJu8fwWsMZCl0GDEm1D3qcHFlW4Uy6c0cYziD0P6Q6muQ1KTKb5swXasJZx6ze4Pew4vs2foFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890899; c=relaxed/simple;
	bh=XAJzD3owH0uzGfYd3jO02WFTW7xAUKMiXaDebfzpIKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm78YKIuOToF0yja4r4c4oXfCPCOBTjByTqtKCN0zYuxqBgBlixNkW4Wo8DzpYAL5MIDyjmPpZmGeaeVmP7wxE6SD6wj1yQDF/ltWiAnoZrjBl2whc4B9KB1+qg0W/a3Km2GqlGkqJV3KSL/cSA17s6MqzlhvGa3Jd96zMJo7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7XDtirT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPVE3V0R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7XDtirT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPVE3V0R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BF9225A58;
	Fri, 26 Sep 2025 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758890894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jnr4Kn8GWP5TG3It+qgp1kqMyJPwqj/59ydFZ9RfHEA=;
	b=W7XDtirTEal0lLHBXekgCOhjOvVh2Gy4Sw38JnDjLek/8kOXspyn+yJvGSrUKN6vFSWXP+
	7FD/24u+Z8MhyfOoEQ72KOyisudi87ACrzQlzS5jOl/Enk91Dyauyc72/BtSXpG4RspesF
	8WxPQvsP1VSKW7oGLMEalGFM98YYqoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758890894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jnr4Kn8GWP5TG3It+qgp1kqMyJPwqj/59ydFZ9RfHEA=;
	b=zPVE3V0RuAFATmAp+zqCpuCYxHVFCyflTiq4KJEY2hZXL2c43UdngPbuofutxafa4JeUAM
	4f5G0mRWxydManDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758890894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jnr4Kn8GWP5TG3It+qgp1kqMyJPwqj/59ydFZ9RfHEA=;
	b=W7XDtirTEal0lLHBXekgCOhjOvVh2Gy4Sw38JnDjLek/8kOXspyn+yJvGSrUKN6vFSWXP+
	7FD/24u+Z8MhyfOoEQ72KOyisudi87ACrzQlzS5jOl/Enk91Dyauyc72/BtSXpG4RspesF
	8WxPQvsP1VSKW7oGLMEalGFM98YYqoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758890894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jnr4Kn8GWP5TG3It+qgp1kqMyJPwqj/59ydFZ9RfHEA=;
	b=zPVE3V0RuAFATmAp+zqCpuCYxHVFCyflTiq4KJEY2hZXL2c43UdngPbuofutxafa4JeUAM
	4f5G0mRWxydManDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3420D1386E;
	Fri, 26 Sep 2025 12:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5eFoDI6L1mhjSwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Sep 2025 12:48:14 +0000
Message-ID: <96d00a94-1a4b-4378-8d89-0554f89778e1@suse.cz>
Date: Fri, 26 Sep 2025 14:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] alloc_tag: Fix boot failure due to NULL
 pointer dereference
Content-Language: en-US
To: ranxiaokai627@163.com, akpm@linux-foundation.org, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 usamaarif642@gmail.com, surenb@google.com, shakeel.butt@linux.dev,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ran.xiaokai@zte.com.cn
References: <20250926080659.741991-1-ranxiaokai627@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250926080659.741991-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com,linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,gmail.com,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 9/26/25 10:06, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> There is a boot failure when both CONFIG_DEBUG_KMEMLEAK and
> CONFIG_MEM_ALLOC_PROFILING are enabled.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:__alloc_tagging_slab_alloc_hook+0x181/0x2f0
> Call Trace:
>  kmem_cache_alloc_noprof+0x1c8/0x5c0
>  __alloc_object+0x2f/0x290
>  __create_object+0x22/0x80
>  kmemleak_init+0x122/0x190
>  mm_core_init+0xb6/0x160
>  start_kernel+0x39f/0x920
>  x86_64_start_reservations+0x18/0x30
>  x86_64_start_kernel+0x104/0x120
>  common_startup_64+0x12c/0x138
> 
> In kmemleak, mem_pool_alloc() directly calls kmem_cache_alloc_noprof(),
> as a result, the alloc_tag structure associated with object_cache is not
> defined neither initialized. So current->alloc_tag is NULL,
> leading to a null pointer dereference.

Agree with Harry. This should be enough:

"as a result, current->alloc_tag is NULL, leading to a null pointer
dereference."

> Move the checks for SLAB_NO_OBJ_EXT, SLAB_NOLEAKTRACE, and
> __GFP_NO_OBJ_EXT to the parent function __alloc_tagging_slab_alloc_hook()
> to fix this.
> 
> Also this distinguishes the SLAB_NOLEAKTRACE case between the actual memory
> allocation failures case, make CODETAG_FLAG_INACCURATE more accurate.

Good point.

> Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")

That's in mm-stable so the fix should go there (probably too late to fold
now) if it's to be in the merge window PR.

> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 867a07260acf..09cbe580842c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2197,15 +2197,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>  	struct slab *slab;
>  
> -	if (!p)
> -		return NULL;
> -
> -	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> -		return NULL;
> -
> -	if (flags & __GFP_NO_OBJ_EXT)
> -		return NULL;
> -
>  	slab = virt_to_slab(p);
>  	if (!slab_obj_exts(slab) &&
>  	    alloc_slab_obj_exts(slab, s, flags, false)) {
> @@ -2223,6 +2214,15 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  {
>  	struct slabobj_ext *obj_exts;
>  
> +	if (!object)
> +		return;
> +
> +	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> +		return;
> +
> +	if (flags & __GFP_NO_OBJ_EXT)
> +		return;
> +
>  	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
>  	/*
>  	 * Currently obj_exts is used only for allocation profiling.


