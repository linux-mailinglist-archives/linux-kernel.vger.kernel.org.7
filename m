Return-Path: <linux-kernel+bounces-857892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F8BE82AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC3A6580B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DA32AAC7;
	Fri, 17 Oct 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kEserYOD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pgzi70xs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rdUu+4RH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9++KeDQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11368320CA6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698257; cv=none; b=AHR3Ce4fKYgaw3TmnADOYJ5D37qc3nUK6Gbb1tZ5II0yteFMyFAYyq92sj2Y5aHSZ4el6DoUIYtQD/YJ8PfqOVUAN7UuN7Gf6siBmJ2hrD67J8bJ/p9XTXR0ggW72KdIupkGMequUcH5O+vSD0HnCEknwYC3CYrt3cjN9iCl0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698257; c=relaxed/simple;
	bh=8+bNtA3FgKC2Uxwju7A7G+FkIExYGI8yIA9Wmtym+fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUqLuLxGSgt9pAp2g1kyTEigOcW3w6surqOVZUvvYBuCzUJzboVXgbwvKVIhfrhd/NN7QemtzTMy7EJQPGblIgAGK+QHMtyFIbv+MobMTBPgSEjz7TkMbWGKkx57TO8udpb/2kCodu96CHkxbQ0l/uOGQs86HLgfpThasjhK9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kEserYOD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pgzi70xs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rdUu+4RH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9++KeDQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27B5F1FE33;
	Fri, 17 Oct 2025 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760698251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PM4LvESjlxri1zpp6vFK06PmdSmf7nPh7+Rq9mCaMw=;
	b=kEserYODQ1NQlb0UU4M3ueJ3R6GrfFkgYZTUnv3eQNpYBnjdLz/k6F+xzRY5YaRUG2wO/q
	vSImeS8ba/zGf6DVJluKTMoOwwQqfQjI6OLcajSd4+6rlBvlOtIdNtZLqmkd92xB+H9UEp
	8ANMUo1rq68mvWGDQeevgHsj7c+Kuc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760698251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PM4LvESjlxri1zpp6vFK06PmdSmf7nPh7+Rq9mCaMw=;
	b=Pgzi70xsKmTHTVC//R9Wfu2fSPU/gAFoncw/5Aj1BFz7JHbqcr/YP5kV/9XMLh1K1vkL1p
	Mox1x4/s7/WbpBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760698250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PM4LvESjlxri1zpp6vFK06PmdSmf7nPh7+Rq9mCaMw=;
	b=rdUu+4RHyct0iiYy+MA+ak6xf7fpY0IeTeFUFJ5v4swQ0QhXrjVU28wqM0rXueATnCenhp
	GnMQQydafP83DQXzKcik2IXxtlY/VyOdgsAx2T0R4UC1FMjAKUPEXcwDjAFoZMYclKurd1
	JkrJrPPfbPOOhvL/AUseJ76DqNLFiYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760698250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+PM4LvESjlxri1zpp6vFK06PmdSmf7nPh7+Rq9mCaMw=;
	b=a9++KeDQg2WP9ZxiWakCB3cvR+Op92WSkwFBPqR02HE7IokrfB8Awcg3TevD3GfDwIbOXS
	jHEEKhDbWI+I1sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09EE113A71;
	Fri, 17 Oct 2025 10:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mwEVAYof8miWAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 17 Oct 2025 10:50:50 +0000
Message-ID: <910a1d39-ca72-4e79-9f6d-66415794d9a9@suse.cz>
Date: Fri, 17 Oct 2025 12:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: add flags in cache_show
Content-Language: en-US
To: Kassey Li <kassey.li@oss.qualcomm.com>, akpm@linux-foundation.org,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
References: <20251017064839.585204-1-kassey.li@oss.qualcomm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251017064839.585204-1-kassey.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,qualcomm.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/17/25 08:48, Kassey Li wrote:
> Flags info is useful to check the slab type.
> 
> for example, _SLAB_RECLAIM_ACCOUNT:
> 
>     0x50100 _SLAB_PANIC _SLAB_RECLAIM_ACCOUNT _SLAB_CMPXCHG_DOUBLE
> 
> Signed-off-by: Kassey Li <kassey.li@oss.qualcomm.com>

Many of the flags are represented by files in /sys/kernel/slab/<cache>/
If you miss some, we could add it there. Changing slabinfo output could
break some users and the raw hex value is not a stable representation of the
flags anyway.

> ---
>  mm/slab_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 932d13ada36c..f43239211e69 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1083,7 +1083,7 @@ static void print_slabinfo_header(struct seq_file *m)
>  	 * without _too_ many complaints.
>  	 */
>  	seq_puts(m, "slabinfo - version: 2.1\n");
> -	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
> +	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> <flags>");
>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
>  	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
>  	seq_putc(m, '\n');
> @@ -1112,9 +1112,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  	memset(&sinfo, 0, sizeof(sinfo));
>  	get_slabinfo(s, &sinfo);
>  
> -	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
> +	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d 0x%-8x",
>  		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
> -		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
> +		   sinfo.objects_per_slab, (1 << sinfo.cache_order), s->flags);
>  
>  	seq_printf(m, " : tunables %4u %4u %4u",
>  		   sinfo.limit, sinfo.batchcount, sinfo.shared);


