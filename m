Return-Path: <linux-kernel+bounces-860614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB37BF082A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856AC1884B85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4EC2F5A02;
	Mon, 20 Oct 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lN2mc2KO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UJMIOlIQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0qJbGFi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkAfbvCP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B602EBB8A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955670; cv=none; b=cWz4DBGS25MiW4VlugzsLf0pxA2hsfjJWqGavBQAbIKSigJ4oE51YsYwVmJPeLCWoUTlQrLWIQr1OSrjSzima5kLL5T8NDUNgvxX011DW5kkpi8BzCtG3UeW0N6In1J/96nmP8YqMnhW8quMrLa/NIsMpwF+nyQRd+3ErJHwWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955670; c=relaxed/simple;
	bh=hk1Yj2Vg7iMjc9YdldmjH3p9lcVwdDaMG1mxjaGkvqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8zAq6TVXDPk5Cpns3x9wWqZgJU7rFQuD2V/7P6AZ/Ypy/m9lexz1juhBCScr2cUMNCY6G/SvWjuSPiow5ux5whJHrRd1eO9ogQMWZiBaJ1VwqvP9iN7HFhR7vOC/4soaxc1a8a7cg4cz8+73NqRMYjsOwFKn2wmPYaBqO4tPT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lN2mc2KO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UJMIOlIQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T0qJbGFi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkAfbvCP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C86DA1F38F;
	Mon, 20 Oct 2025 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760955661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jUAozH+dPZUUrBmwzJTPk2StlCwJpqlVY9Dw4T6M7g4=;
	b=lN2mc2KONJR7OIEadeeVC34Xb3W5qmc9KJht0YTFhIu2mxkS2gJlP0MUkxSmucNZFHWMtR
	EgPz5BP2CTKqODpLptN+7zHMlvjLOquIIVaFf4NRUUIp6Bf9hnQFJ9AnFMl+isET+64BQT
	KzuRPFBgRNm3FsY0VtWlh3VsBfgPuUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760955661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jUAozH+dPZUUrBmwzJTPk2StlCwJpqlVY9Dw4T6M7g4=;
	b=UJMIOlIQyctsRp5TJnuRD3Dma1n6/DZj8lV2glNd5UZ2brPQ8PbConWbgtMh81788a6Jjr
	DdfMrrosgL15FmDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T0qJbGFi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hkAfbvCP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760955657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jUAozH+dPZUUrBmwzJTPk2StlCwJpqlVY9Dw4T6M7g4=;
	b=T0qJbGFi10XyZt+NCDaMVl8kIrYLt48atJhTHhQioKzTMPT1Wj6Cgk1JHPaGTgMqhJO9/s
	0p/AS/Rx7fJT2g9EkTMXRcCLmWG3js0AVqkdo+BcpbYAO83FZVgFiCqWvH2WFZsuRYWthB
	KOdc7Ti7DRDroev6GUskK2iz4MBKrFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760955657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jUAozH+dPZUUrBmwzJTPk2StlCwJpqlVY9Dw4T6M7g4=;
	b=hkAfbvCPDP2GLehs9wd+fnGsOElSSDBtXtgyWci1Vyk0+wIBgpjqqOptoGY7Jf3fUMjiff
	kYJaPDsnH4S8HqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A39A213A8E;
	Mon, 20 Oct 2025 10:20:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxfgJQkN9mi1NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 Oct 2025 10:20:57 +0000
Message-ID: <da90b3a5-a256-49f7-a640-6585f2cce340@suse.cz>
Date: Mon, 20 Oct 2025 12:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz>
 <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
 <7791b2b8-5db8-458c-89e2-49a0876c13a3@suse.cz>
 <CAJuCfpEWGujJe3JOjmiKLOUr49Hw_3smT6iatY7kaRBPPCWpNg@mail.gmail.com>
 <3efc2a94-54c7-48a8-a804-c231d06b5ed5@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <3efc2a94-54c7-48a8-a804-c231d06b5ed5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C86DA1F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/20/25 04:01, Hao Ge wrote:
> 
>> I think retrying like this should work:
>>
>> +retry:
>>           old_exts = READ_ONCE(slab->obj_exts);
>>           handle_failed_objexts_alloc(old_exts, vec, objects);
>>           if (new_slab) {
>> @@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab,
>> struct kmem_cache *s,
>>                    * be simply assigned.
>>                    */
>>                   slab->obj_exts = new_exts;
>> -        } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
>> -                   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>> +        } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
>>                   /*
>>                    * If the slab is already in use, somebody can allocate and
>>                    * assign slabobj_exts in parallel. In this case the existing
>> @@ -2158,6 +2158,8 @@ int alloc_slab_obj_exts(struct slab *slab,
>> struct kmem_cache *s,
>>                   else
>>                           kfree(vec);
>>                   return 0;
>> +        } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>> +                goto retry;
>>           }
> 
> Agree with this. If there are no issues with my comment above,
> 
> I will send V2 based on Suren's suggestion.

Great.
> Additionally, I believe the "Fixes" field should be written as follows:
> 
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to 
> mark failed slab_ext allocations")
> 
> Am I wrong?

I think it was safe before this one:

f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")


