Return-Path: <linux-kernel+bounces-813816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9371B54B09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59603B6059
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC512EFD87;
	Fri, 12 Sep 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zf7Oej6B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQV0Qu9k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zf7Oej6B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQV0Qu9k"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D818274FDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676854; cv=none; b=CSi2ePrwkYsG1TRmuPHAwoF7lQ1axH6+M237bNi7yC++1/b7T4O4xMkAriJKapDvexQ5NBAsQiRQ29pjY7ig5SGsSFhXqzZdIlWZPEuy51PVwK2iT4CITD8VzQG2EN+1crGoUyduQpo9FdQ35U5fvnMD74ubN9uqt5YCvphAkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676854; c=relaxed/simple;
	bh=MT3jIYv/K5VB9DNRELBjrgTbBPZVRRD4zYgnDiq2BJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3T7QpdbHRqj7AkbF5aEh49YcqtXDXGv1sMV9H3ByEO0f7l5+ZuLQiciGnouaQ3sDUnqHnE7FmOITUXzbIPSMCqIDLkB0ws1/qU5JKjXiYHU1pFfAHlanuQLkp+zhnwXy7S+/HB2LzZzOzdmfmOYELfhJaQuAdAS6MCx377SidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zf7Oej6B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQV0Qu9k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zf7Oej6B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQV0Qu9k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACD905D6F3;
	Fri, 12 Sep 2025 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757676848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4X2W5Z+TjYnsv3B3buYTBJ72l3+aaTmtUZSpQraAFL4=;
	b=zf7Oej6BR+qhl59ldyrIIBOR0zLY6mqy/pEaCt2cFQiK2dRzNqFeO3WpVh04je+S6tHmkY
	KbkmA6/F4Z2fg7h8aG3xNdLxxVsQ8Nc3vFussH7Ch7MFvvxPqicIit73MOL/0ITDd1tvHU
	Go9n8oGC1IrEbJoaURo9ZjBKH7TFt8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757676848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4X2W5Z+TjYnsv3B3buYTBJ72l3+aaTmtUZSpQraAFL4=;
	b=EQV0Qu9kAqGNkY1fn1+2AUAl1Z9RGx3iOktacBXLf2J7dMz2w/Z01tjfFwsv9scrMr/zX3
	buTkUEDJKUQcaXCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757676848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4X2W5Z+TjYnsv3B3buYTBJ72l3+aaTmtUZSpQraAFL4=;
	b=zf7Oej6BR+qhl59ldyrIIBOR0zLY6mqy/pEaCt2cFQiK2dRzNqFeO3WpVh04je+S6tHmkY
	KbkmA6/F4Z2fg7h8aG3xNdLxxVsQ8Nc3vFussH7Ch7MFvvxPqicIit73MOL/0ITDd1tvHU
	Go9n8oGC1IrEbJoaURo9ZjBKH7TFt8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757676848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4X2W5Z+TjYnsv3B3buYTBJ72l3+aaTmtUZSpQraAFL4=;
	b=EQV0Qu9kAqGNkY1fn1+2AUAl1Z9RGx3iOktacBXLf2J7dMz2w/Z01tjfFwsv9scrMr/zX3
	buTkUEDJKUQcaXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99ABF13869;
	Fri, 12 Sep 2025 11:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ReskIzAFxGhEagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Sep 2025 11:34:08 +0000
Message-ID: <96ee75c2-d561-4e9b-977f-72a3b056a08f@suse.cz>
Date: Fri, 12 Sep 2025 13:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] slab: validate slab before using it in
 alloc_single_from_partial()
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
 <20250911-slub-slab-validation-v1-5-8b67eb3b3dc5@suse.cz>
 <aMP6f_fJ27flhdSq@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aMP6f_fJ27flhdSq@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/12/25 12:48, Harry Yoo wrote:
> On Thu, Sep 11, 2025 at 07:02:38PM +0200, Vlastimil Babka wrote:
>> We touch slab->freelist and slab->inuse before checking the slab pointer
>> is actually sane. Do that validation first, which will be safer. We can
>> thus also remove the check from alloc_debug_processing().
>> 
>> This adds a new "s->flags & SLAB_CONSISTENCY_CHECKS" test but
>> alloc_single_from_partial() is only called for caches with debugging
>> enabled so it's acceptable.
>> 
>> In alloc_single_from_new_slab() we just created the struct slab and call
>> alloc_debug_processing() to mainly set up redzones, tracking etc, while
>> not really expecting the consistency checks to fail. Thus don't validate
>> it there.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 909c71372a2f542b6e0d67c12ea683133b246b66..93df6e82af37c798c3fa5574c9d825f0f4a83013 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1651,11 +1651,6 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
>>  			struct slab *slab, void *object, int orig_size)
>>  {
>>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>> -		if (!validate_slab_ptr(slab)) {
>> -			slab_err(s, slab, "Not a valid slab page");
>> -			return false;
>> -		}
>> -
>>  		if (!alloc_consistency_checks(s, slab, object))
>>  			goto bad;
>>  	}
>> @@ -2825,15 +2820,19 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>>  
>>  	lockdep_assert_held(&n->list_lock);
>>  
>> +	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>> +		if (!validate_slab_ptr(slab)) {
>> +			slab_err(s, slab, "Not a valid slab page");
>> +			return NULL;
>> +		}
>> +	}
>> +
>>  	object = slab->freelist;
>>  	slab->freelist = get_freepointer(s, object);
>>  	slab->inuse++;
>>  
>> -	if (!alloc_debug_processing(s, slab, object, orig_size)) {
>> -		if (validate_slab_ptr(slab))
>> -			remove_partial(n, slab);
>> +	if (!alloc_debug_processing(s, slab, object, orig_size))
>>  		return NULL;
> 
> Is it intentional to not remove the slab from the partial list
> when alloc_debug_processing() returns false?

No, good catch, will fix. Thanks!

>> -	}
>>  
>>  	if (slab->inuse == slab->objects) {
>>  		remove_partial(n, slab);
>> 
>> -- 
>> 2.51.0
> 


