Return-Path: <linux-kernel+bounces-854851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F0BDF928
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD6B540FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BE2FE055;
	Wed, 15 Oct 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0d8Yabi7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zlu9F5O1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0d8Yabi7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zlu9F5O1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA50335BD6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544532; cv=none; b=TDj2nWVT5Jvvs12d9rPF/k9QY9sD5Tf61PjHiJ7zBUreInd2MJvIt9uko2Xi142NsEVv8upOIMCIfnA/xyftL95f4k7TGUPaHG1CiVqsKvpbE3On90xdgqJaWOGKRz3RIcIDjLTL5SehkhO5qiBvMYTurxEkUGdz1xVgAUlwe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544532; c=relaxed/simple;
	bh=bzEewTRks3prZa9spy61uKO8xMFONzDzDm4tneWE/r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puM1S78LUCPMZluD3h71+NS7sIjZ0ew5wGqyPvkCvWeuI38jCOqCzFNu30RNrMubPtKUTdl+SUrMasmGDGv67R4JWqWFpcE8b4QixhygbaH4lUn0Ml3/l3zhh7pXCx6PXsnqFHfYov0jDINbWLiqbmjQJSHKdRVAOoUjC+3og68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0d8Yabi7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zlu9F5O1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0d8Yabi7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zlu9F5O1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1EE7210B9;
	Wed, 15 Oct 2025 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760544528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6UQ/oferKnYZ70n+TKPZJIlqLdRtpozdd+b9K7tyxTU=;
	b=0d8Yabi7FbV/imG+A18nv2oT1FAHT4U1WsiFQ5guJgiJW3uSKAmcZF8loktXZTbyHaxW1b
	rmMu5/lo3pXwOpcMlxdmf/8+zoMvcbv5VKlKCwLuuElf5xxRuxTYVqH2v+pgKJRXRmuyN4
	qlFjGWXZFmWwMnvBeCVILbB3qiXxMRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760544528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6UQ/oferKnYZ70n+TKPZJIlqLdRtpozdd+b9K7tyxTU=;
	b=Zlu9F5O149VMRHC5yZju51p9/YVF1QOxu2KvwGD2g6AY8Nj84/fDPx13+4sy5rxDaMkegK
	FA2lO0qf00vB8CCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760544528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6UQ/oferKnYZ70n+TKPZJIlqLdRtpozdd+b9K7tyxTU=;
	b=0d8Yabi7FbV/imG+A18nv2oT1FAHT4U1WsiFQ5guJgiJW3uSKAmcZF8loktXZTbyHaxW1b
	rmMu5/lo3pXwOpcMlxdmf/8+zoMvcbv5VKlKCwLuuElf5xxRuxTYVqH2v+pgKJRXRmuyN4
	qlFjGWXZFmWwMnvBeCVILbB3qiXxMRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760544528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6UQ/oferKnYZ70n+TKPZJIlqLdRtpozdd+b9K7tyxTU=;
	b=Zlu9F5O149VMRHC5yZju51p9/YVF1QOxu2KvwGD2g6AY8Nj84/fDPx13+4sy5rxDaMkegK
	FA2lO0qf00vB8CCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86F2213A42;
	Wed, 15 Oct 2025 16:08:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DR0YHxDH72hOagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 16:08:48 +0000
Message-ID: <421c7c42-bf7d-4277-b364-525c63254205@suse.cz>
Date: Wed, 15 Oct 2025 18:08:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: simplify and cleanup pcp locking
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251015145143.3001503-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251015145143.3001503-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 10/15/25 16:51, Joshua Hahn wrote:
> On Wed, 15 Oct 2025 11:36:09 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> The pcp locking relies on pcp_spin_trylock() which has to be used
>> together with pcp_trylock_prepare()/pcp_trylock_finish() to work
>> properly on !SMP !RT configs. This is tedious and error-prone.
>> 
>> We can remove pcp_spin_lock() and underlying pcpu_spin_lock() because we
>> don't use it. Afterwards pcpu_spin_unlock() is only used together with
>> pcp_spin_trylock(). Therefore we can add the UP_flags parameter to them
>> and handle pcp_trylock_prepare()/finish() within them.
>> 
>> Additionally for the configs where pcp_trylock_prepare() is a no-op (SMP
>> || RT) make it pass &UP_flags to a no-op inline function. This ensures
>> typechecking and makes the local variable "used" so we can remove the
>> __maybe_unused attributes.
>> 
>> In my compile testing, bloat-o-meter reported no change on SMP config,
>> so the compiler is capable of optimizing away the no-ops same as before,
>> and we have simplified the code using pcp_spin_trylock().
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Hello Vlastimil, I hope you are doing well!
> 
> Thank you for this patch. This is a pattern that I found quite cumbersome,
> so this patch really makes the code so much easier to understand and read.

Hi, that's good to hear!
>> ---
>> based on mm-new
>> ---
>>  mm/page_alloc.c | 99 +++++++++++++++++++++++----------------------------------
>>  1 file changed, 40 insertions(+), 59 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0155a66d7367..2bf707f92d83 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -99,9 +99,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>>  /*
>>   * On SMP, spin_trylock is sufficient protection.
>>   * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
>> + * Pass flags to a no-op inline function to typecheck and silence the unused
>> + * variable warning.
>>   */
>> -#define pcp_trylock_prepare(flags)	do { } while (0)
>> -#define pcp_trylock_finish(flag)	do { } while (0)
>> +static inline void __pcp_trylock_prepare(unsigned long *flags) { }
>> +#define pcp_trylock_prepare(flags) __pcp_trylock_prepare(&(flags))
>> +#define pcp_trylock_finish(flags)	do { } while (0)
>>  #else
> 
> I have one question here. I was a bit unsure why we do the typechecking and
> silencing for the unused variable warning for only pcp_trylock_prepare, but
> not for pcp_trylock_finish. Is it because pcp_trylock_finish will always
> be called after pcp_trylock_prepare, so the flag will have been used at
> that point? 

Exactly.

> I was concerned that there would have been some area where only
> pcp_trylock_finish would have been used, but compiling with W=1 seems to show
> no errors on my end : -) So it looks good to me! Feel free to add:

Yeah we can change that if ever we end up with some code that needs it
(hopefully not).

> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thanks!

> Thank you! I hope you have a great day!
> Joshua


