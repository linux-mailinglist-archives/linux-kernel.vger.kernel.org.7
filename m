Return-Path: <linux-kernel+bounces-818816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EAB596BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9F13A714F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BD21D3DC;
	Tue, 16 Sep 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9aHHxgI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPijuh2v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9aHHxgI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPijuh2v"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FF21CA13
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027467; cv=none; b=V5spZBTxxO3Dxc7wkUhfsFHE0fJE266wIHPR8O2MAUYQDKLw70nNi6FrXqF+QbEpPvFvh/Zh8S1aQ7ymfJiGq6P8seQYc7k38mAiJy+qQ4V4rOAwGoki6ED17MOx7xXjNuNxOzN21SlINLU1mBRJK+E+9g7gE+L6r4bi2ujLEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027467; c=relaxed/simple;
	bh=CzoIkVdd3FYdaOi0LweryO3N/tRmRx8qHEkZMhQTWow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rijlQp3+MpPlfWyffAHQPC0L+JJ+quIBh/Rh+RBSyZsWaTJ8lvwsR1OGbBpuLISowo+2cr0KHaEJYOiMecRjxoNW6IFePX+rdR5dMJEsj05KJMAX6At1P5gyM/vgOdKvZp+I4Yz07y3Xod7gEAjmpJ6s7qQKjDnw6gtLqEUfDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9aHHxgI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPijuh2v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9aHHxgI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPijuh2v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A32E41F78A;
	Tue, 16 Sep 2025 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758027462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CkP3NToZFKJteLfj2RxkpRM0Xk1p7/95fzpEMEOduZQ=;
	b=v9aHHxgILtD7B7ZCmg/JFQHJO1CryXdfu0GjttwmMRX/T3evsvqN+k8Hg+ZMT/Z55cgp/J
	1nwBbpV0lIVgOj50GeMEZtHThwexz9RRH0z/K71if81GYeGvX0NqmBLbYG59WiZFHK+oxr
	mX5GSI+mTsywfn97ISKZcN+gCXDUnvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758027462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CkP3NToZFKJteLfj2RxkpRM0Xk1p7/95fzpEMEOduZQ=;
	b=cPijuh2vNSlFsC1dxz/LoaNAMnopEa9d4FS38vfXaLaYrDoUClEqblrv/La0F8R7GP1Zos
	22lXexXbzHWKKJCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v9aHHxgI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cPijuh2v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758027462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CkP3NToZFKJteLfj2RxkpRM0Xk1p7/95fzpEMEOduZQ=;
	b=v9aHHxgILtD7B7ZCmg/JFQHJO1CryXdfu0GjttwmMRX/T3evsvqN+k8Hg+ZMT/Z55cgp/J
	1nwBbpV0lIVgOj50GeMEZtHThwexz9RRH0z/K71if81GYeGvX0NqmBLbYG59WiZFHK+oxr
	mX5GSI+mTsywfn97ISKZcN+gCXDUnvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758027462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CkP3NToZFKJteLfj2RxkpRM0Xk1p7/95fzpEMEOduZQ=;
	b=cPijuh2vNSlFsC1dxz/LoaNAMnopEa9d4FS38vfXaLaYrDoUClEqblrv/La0F8R7GP1Zos
	22lXexXbzHWKKJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838C813A63;
	Tue, 16 Sep 2025 12:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c9XCH8ZeyWg5BgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 16 Sep 2025 12:57:42 +0000
Message-ID: <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
Date: Tue, 16 Sep 2025 14:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hannes@cmpxchg.org, usamaarif642@gmail.com,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, 00107082@163.com, pyyjason@gmail.com,
 pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250915230224.4115531-1-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250915230224.4115531-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,gmail.com,google.com,oracle.com,163.com,soleen.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A32E41F78A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/16/25 01:02, Suren Baghdasaryan wrote:
> While rare, memory allocation profiling can contain inaccurate counters
> if slab object extension vector allocation fails. That allocation might
> succeed later but prior to that, slab allocations that would have used
> that object extension vector will not be accounted for. To indicate
> incorrect counters, "accurate:no" marker is appended to the call site
> line in the /proc/allocinfo output.
> Bump up /proc/allocinfo version to reflect the change in the file format
> and update documentation.
> 
> Example output with invalid counters:
> allocinfo - version: 2.0
>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc accurate:no
>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create accurate:no
>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

With this format you could instead print the accumulated size of allocations
that could not allocate their objext (for the given tag). It should be then
an upper bound of the actual error, because obviously we cannot recognize
moments where these allocations are freed - so we don't know for which tag
to decrement. Maybe it could be more useful output than the yes/no
information, although of course require more storage in struct codetag, so I
don't know if it's worth it.

Maybe a global counter of sum size for all these missed objexts could be
also maintained, and that wouldn't be an upper bound but an actual current
error, that is if we can precisely determine that when freeing an object, we
don't have a tag to decrement because objext allocation had failed on it and
thus that allocation had incremented this global error counter and it's
correct to decrement it.

> ---
> Changes since v1[1]:
> - Changed the marker from asterisk to accurate:no pair, per Andrew Morton
> - Documented /proc/allocinfo v2 format
> - Update the changelog
> - Added Acked-by from v2 since the functionality is the same,
> per Shakeel Butt, Usama Arif and Johannes Weiner
> 
> [1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@google.com/
> 
>  Documentation/filesystems/proc.rst |  4 ++++
>  include/linux/alloc_tag.h          | 12 ++++++++++++
>  include/linux/codetag.h            |  5 ++++-
>  lib/alloc_tag.c                    |  4 +++-
>  mm/slub.c                          |  2 ++
>  5 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 915a3e44bc12..1776a06571c2 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable module) and the function calling
>  the allocation. The number of bytes allocated and number of calls at each
>  location are reported. The first line indicates the version of the file, the
>  second line is the header listing fields in the file.
> +If file version is 2.0 or higher then each line may contain additional
> +<key>:<value> pairs representing extra information about the call site.
> +For example if the counters are not accurate, the line will be appended with
> +"accurate:no" pair.
>  
>  Example output.
>  
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 9ef2633e2c08..d40ac39bfbe8 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>  	ref->ct = NULL;
>  }
>  
> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> +{
> +	tag->ct.flags |= CODETAG_FLAG_INACCURATE;
> +}
> +
> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> +{
> +	return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> +}
> +
>  #define alloc_tag_record(p)	((p) = current->alloc_tag)
>  
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
> @@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(void) { return false; }
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
>  				 size_t bytes) {}
>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
>  #define alloc_tag_record(p)	do {} while (0)
>  
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index 457ed8fd3214..8ea2a5f7c98a 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -16,13 +16,16 @@ struct module;
>  #define CODETAG_SECTION_START_PREFIX	"__start_"
>  #define CODETAG_SECTION_STOP_PREFIX	"__stop_"
>  
> +/* codetag flags */
> +#define CODETAG_FLAG_INACCURATE	(1 << 0)
> +
>  /*
>   * An instance of this structure is created in a special ELF section at every
>   * code location being tagged.  At runtime, the special section is treated as
>   * an array of these.
>   */
>  struct codetag {
> -	unsigned int flags; /* used in later patches */
> +	unsigned int flags;
>  	unsigned int lineno;
>  	const char *modname;
>  	const char *function;
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 79891528e7b6..12ff80bbbd22 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void *arg)
>  static void print_allocinfo_header(struct seq_buf *buf)
>  {
>  	/* Output format version, so we can change it. */
> -	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> +	seq_buf_printf(buf, "allocinfo - version: 2.0\n");
>  	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
>  }
>  
> @@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>  
>  	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>  	codetag_to_text(out, ct);
> +	if (unlikely(alloc_tag_is_inaccurate(tag)))
> +		seq_buf_printf(out, " accurate:no");
>  	seq_buf_putc(out, ' ');
>  	seq_buf_putc(out, '\n');
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index af343ca570b5..9c04f29ee8de 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
>  	 */
>  	if (likely(obj_exts))
>  		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
> +	else
> +		alloc_tag_set_inaccurate(current->alloc_tag);
>  }
>  
>  static inline void


