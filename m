Return-Path: <linux-kernel+bounces-884573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D4C307CF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D211897C04
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35F318130;
	Tue,  4 Nov 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F22ZyU0O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEnDLU+I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F22ZyU0O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEnDLU+I"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462753164DE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251875; cv=none; b=jXWJS7718VMySnEcesnfiuH1kW7DJCw4c/uK9ENQjyRonNPTeMwoceFjbM+GZZBXzGMUwnY3EBh7HoTaQ0SYCudADyB4FqMLrRMIAQ9JuHKOIYUknJJmcbcHYyKvhHqDWW/ofxr3mxm6XbVqkRn8BFk69044jdqMkR53Et6tkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251875; c=relaxed/simple;
	bh=HUhx+zgXHd8oGRJ/I1/At+HU+rC9Llwj9/KDr6/MggI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0FebWOXKbHoxGFgJ4XAeJaxuECzkKfjb8ej4Jrmar8Tew8kjEctAP74wXRgp+FfTnwNNC+B2RcOr5xwh6QhNfvCEIWNHFFSi6K+Z63NuX2nFb89nx0qmQqmXXvGwPid/XQ88yGY2E3OucU5+iBNzWPIHAeKoUNzLAqZBy0JHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F22ZyU0O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEnDLU+I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F22ZyU0O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEnDLU+I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 327021F387;
	Tue,  4 Nov 2025 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762251871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUST+k1U2v9lp03HQYKCUSRvVl3dhQ0RkvE1dYJyp1o=;
	b=F22ZyU0OIGfXA1u0JS5EOCFYZyKpvScHY10HJUuFKjT6B5JHaDP4ESwA5uodFGiDjuxoG1
	CYY22Vg4A9ObiRMF49kJNWO9EJEd6YG3L8Mwn7D6HpvCvRrlFKU+xXF1yF+LGYBEpzmvSa
	mak0CaKaLl5LBOkp1JjFXu5jS+4G5N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762251871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUST+k1U2v9lp03HQYKCUSRvVl3dhQ0RkvE1dYJyp1o=;
	b=dEnDLU+IQsczLobueRkov04DKkoK6RLqFABHB2TaJN9RLqxNp7+ee6pWLzBhn5d+eFlbXe
	u94X+Qt7X8IvyPCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F22ZyU0O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dEnDLU+I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762251871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUST+k1U2v9lp03HQYKCUSRvVl3dhQ0RkvE1dYJyp1o=;
	b=F22ZyU0OIGfXA1u0JS5EOCFYZyKpvScHY10HJUuFKjT6B5JHaDP4ESwA5uodFGiDjuxoG1
	CYY22Vg4A9ObiRMF49kJNWO9EJEd6YG3L8Mwn7D6HpvCvRrlFKU+xXF1yF+LGYBEpzmvSa
	mak0CaKaLl5LBOkp1JjFXu5jS+4G5N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762251871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUST+k1U2v9lp03HQYKCUSRvVl3dhQ0RkvE1dYJyp1o=;
	b=dEnDLU+IQsczLobueRkov04DKkoK6RLqFABHB2TaJN9RLqxNp7+ee6pWLzBhn5d+eFlbXe
	u94X+Qt7X8IvyPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 253AD136D1;
	Tue,  4 Nov 2025 10:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T53hCF/UCWktUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Nov 2025 10:24:31 +0000
Message-ID: <f59e2a0e-1da3-4670-84ee-679c2001f58f@suse.cz>
Date: Tue, 4 Nov 2025 11:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: prevent infinite loop in kmalloc_nolock() with
 debugging
To: Dev Jain <dev.jain@arm.com>, Harry Yoo <harry.yoo@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
 <5bb311a5-b59f-4897-b4d0-4e06d7d2b3f2@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <5bb311a5-b59f-4897-b4d0-4e06d7d2b3f2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 327021F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/4/25 6:26 AM, Dev Jain wrote:
> 
> On 03/11/25 5:54 pm, Vlastimil Babka wrote:
>> In review of a followup work, Harry noticed a potential infinite loop.
>> Upon closed inspection, it already exists for kmalloc_nolock() on a
>> cache with debugging enabled, since commit af92793e52c3 ("slab:
>> Introduce kmalloc_nolock() and kfree_nolock().")
>>
>> When alloc_single_from_new_slab() fails to trylock node list_lock, we
>> keep retrying to get partial slab or allocate a new slab. If we indeed
>> interrupted somebody holding the list_lock, the trylock fill fail
> 
> Hi Vlastimil,
> 
> I see that we always take n->list_lock spinlock by disabling irqs. So
> how can we interrupt someone holding the list_lock?

From a NMI or e.g. a kprobe->bpf hook, which are the use cases for
kmalloc_nolock(). The word "interrupt" thus doesn't mean IRQ, but I'm
not sure which word would be better. "Preempt" would be perhaps even
more potentially misleading.

> If we are already in a path holding list_lock, and trigger a slab
> allocation
> and recursively end up in the same path again, we can get the situation
> you mention, is that possible?

There shouldn't be such recursion in the code itself, in the absence of
NMI/kprobe/etc.
>> deterministically and we end up allocating and defer-freeing slabs
>> indefinitely with no progress.
>>
>> To fix it, fail the allocation if spinning is not allowed. This is
>> acceptable in the restricted context of kmalloc_nolock(), especially
>> with debugging enabled.
>>
>> Reported-by: Harry Yoo <harry.yoo@oracle.com>
>> Closes: https://lore.kernel.org/all/aQLqZjjq1SPD3Fml@hyeyoo/
>> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and
>> kfree_nolock().")
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> as we discussed in the linked thread, 6.18 hotfix to be included in
>> slab/for-next-fixes
>> ---
>>   mm/slub.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index d4367f25b20d..f1a5373eee7b 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4666,8 +4666,12 @@ static void *___slab_alloc(struct kmem_cache
>> *s, gfp_t gfpflags, int node,
>>       if (kmem_cache_debug(s)) {
>>           freelist = alloc_single_from_new_slab(s, slab, orig_size,
>> gfpflags);
>>   -        if (unlikely(!freelist))
>> +        if (unlikely(!freelist)) {
>> +            /* This could cause an endless loop. Fail instead. */
>> +            if (!allow_spin)
>> +                return NULL;
>>               goto new_objects;
>> +        }
>>             if (s->flags & SLAB_STORE_USER)
>>               set_track(s, freelist, TRACK_ALLOC, addr,
>>
>> ---
>> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
>> change-id: 20251103-fix-nolock-loop-854e0101672f
>>
>> Best regards,

