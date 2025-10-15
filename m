Return-Path: <linux-kernel+bounces-854889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6ABDFB09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9632E3558F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0E3376B0;
	Wed, 15 Oct 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3V+MR6Um";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Roig1Q4i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u89Q4jB+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8Mb/VEI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21C29BDB9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546235; cv=none; b=bp2gHh+beH9R0TMUidS3fYHehARE1h5p5D4iKOxat6vGWB5rJOLPoYEeu4P+9DmldxFwpJxydm7vcFctLwg3ARlJvkiQEJ9AxnWXVMl1FzWngYp2XgUmhOhoq6NXSw5zxCtyqtO8w7q9CUjHAUd5glGN/5uQRaOkhltDWwPuI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546235; c=relaxed/simple;
	bh=O8GPJexAR7PWOiHZKRL4cEfnMthwio+cDVrJSeNZCFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9qGDeyhKNSfMXzSYRvof5YR2ucKCKEioVt/97RyN29Kv+TgfzJ0lX/EI3DP2ZGARCWDPOIhDe/dS/NOUEOdylUKgFED9+kJVHglRyO7RO0Vbh/xjiyqUZwJ4Lw9HHq5Q0mdCOpE4uGJU/Hn0WaRHLIq+Fa2DPZPazusI70NzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3V+MR6Um; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Roig1Q4i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u89Q4jB+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8Mb/VEI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4531338D8;
	Wed, 15 Oct 2025 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760546232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rPAcpK/s6GPGz/dK/BEAl7H9IF92YQTxk2EK4TwnJ2I=;
	b=3V+MR6UmRgVGhVa2MloG89lwpYgG8lkCdbdgeG2FKQOwPYRnBzsflXie97xD0wPVVsjSCx
	DIPY2umrj+ij2U6eGyIyQhxD//bfwep9HRaDh/rajtjELtT/L6cNvHlHjMDOJTntw+q3zm
	1+QC84G9R6CPyDPdcAy3uK64fKAmj9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760546232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rPAcpK/s6GPGz/dK/BEAl7H9IF92YQTxk2EK4TwnJ2I=;
	b=Roig1Q4iJYRMQtgkcDZUzWbPkMbCpmFO6DBFTfPa9tNKKfvQWpNGzGH2H49Ol/NSrlIUWM
	+xx7famPlH7y/xDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u89Q4jB+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z8Mb/VEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760546231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rPAcpK/s6GPGz/dK/BEAl7H9IF92YQTxk2EK4TwnJ2I=;
	b=u89Q4jB+kGYd6UpR7wnOEgwxrqftAKVA5nLITNNFJu3vbQZWvUWpEQ3ufDGKyblJ87cSF/
	Wr1OEZOSL9FRTSwyFGAsll1BzdFknbGM/WsWRsUcsv+uBnAhHSe6t+m/nsSNXkScLpmkRS
	y/U6Nc5Xm9R1HVu31GwCsKpCI5Yitqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760546231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rPAcpK/s6GPGz/dK/BEAl7H9IF92YQTxk2EK4TwnJ2I=;
	b=z8Mb/VEITpUtc7AnaKU1qH3GLpIxudpINp2GEHGbg09xBMXv0h4WDOxKehrzsUnNjNRCy4
	vSp1U0olmgllLHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5EA113A42;
	Wed, 15 Oct 2025 16:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F+kBJ7fN72hICAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 16:37:11 +0000
Message-ID: <6728a58d-7849-4eba-bce4-68968dd55afe@suse.cz>
Date: Wed, 15 Oct 2025 18:37:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] slab: reset obj_ext when it is not actually valid
 during freeing
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251015141642.700170-1-hao.ge@linux.dev>
 <CAJuCfpEpO_HaJuV3ukDtTdw_5zCq9R0MnMexC5PoEwOcKWjuYg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpEpO_HaJuV3ukDtTdw_5zCq9R0MnMexC5PoEwOcKWjuYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C4531338D8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 10/15/25 18:29, Suren Baghdasaryan wrote:
> On Wed, Oct 15, 2025 at 7:17 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL and
>> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
>> release of the associated folio, a VM_BUG_ON_FOLIO() check in
>> folio_memcg_kmem() is triggered because it was mistakenly assumed that
>> a valid folio->memcg_data was not cleared before freeing the folio.
>>
>> When freeing a slab, we clear slab->obj_exts and reset it to 0
>> if the obj_ext array has been successfully allocated.
>> So let's reset slab->obj_exts to 0 when freeing a slab if
>> the obj_ext array allocated fail to allow them to be returned
>> to the buddy system more smoothly.
>>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>> v5: Adopt the simpler solution proposed by Vlastimil;
>>     Many thanks to him
>> ---
>>  mm/slub.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1f15598fbfd..2e4340c75be2 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2170,8 +2170,16 @@ static inline void free_slab_obj_exts(struct slab *slab)
>>         struct slabobj_ext *obj_exts;
>>
>>         obj_exts = slab_obj_exts(slab);
>> -       if (!obj_exts)
>> +       if (!obj_exts) {
>> +               /*
>> +                * If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> +                * In this case, we will end up here.
>> +                * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag first when freeing a slab.
>> +                * Then let's set it to 0 as below.
>> +                */
>> +               slab->obj_exts = 0;
>>                 return;
>> +       }
> 
> How about this instead:
> 
> static inline void free_slab_obj_exts(struct slab *slab)
> {
>         struct slabobj_ext *obj_exts;
> 
>         obj_exts = slab_obj_exts(slab);
> +        /*
> +         * Reset obj_exts to ensure all bits including OBJEXTS_ALLOC_FAIL
> +         * are always cleared.
> +         */
> +        slab->obj_exts = 0;
>         if (!obj_exts)
>                 return;
> 
>         /*
>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
>          * corresponding extension will be NULL. alloc_tag_sub() will throw a
>          * warning if slab has extensions but the extension of an object is
>          * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
>          * the extension for obj_exts is expected to be NULL.
>          */
>         mark_objexts_empty(obj_exts);
>         kfree(obj_exts);
> -        slab->obj_exts = 0;

You have an older base, check current mainline, we evaluate slab->obj_exts
later in the function

> }
> 
>>
>>         /*
>>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
>> --
>> 2.25.1
>>


