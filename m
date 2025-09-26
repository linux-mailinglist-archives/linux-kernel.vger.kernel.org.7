Return-Path: <linux-kernel+bounces-834162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0302BA414B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77A42A2277
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED82E1B3925;
	Fri, 26 Sep 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxttf/m6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xto6P6Dh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xAozLJnU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIYV8Jdm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC934BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896223; cv=none; b=PZh7CSrIIjai0Qz5ErE3eSiQyF9cj6xMZqC6ZrBtB0xuKcOq6LaKz/vG/VXB+3iG+RHGJ0g9Q8Mi6YGpy9+H51OHBLpaKstU0FG0M0tNtenXOOO/mrQuDf9cjhXB6sorxsPR1G5kZgAbd8k58N9aRlAqCI2J23JSLjvFJDWQSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896223; c=relaxed/simple;
	bh=4MBoYLuYXZzkWePFT3NyogbNNb3lPyIxkywi+EBIJKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk07hMHbuvhJn7yypYr1dutXIxuraIrvyn2TSBxJbmRzYPYaZNbUADhpV1ZXKl20+YamAhioUuM0HW3fIELm5E2gFyNhGSrcNdo10oGW+afE5OutFzDc/12wIAjqiFctmKg3nFljEa6Mn8LETXv8xmRwT/WF0JuIVX0QFaKpfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxttf/m6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xto6P6Dh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xAozLJnU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIYV8Jdm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D1D6249C2;
	Fri, 26 Sep 2025 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758896218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DXg90uzZG/vu8mNq7Fg3jlaCLKzUg4EaRQ6I0iV61WE=;
	b=kxttf/m6UZKsvW/fl1yBUo6nYi8m/gMWNlc9Kzb3Qht2ESoRIwWIS7tDpyH8YPhbOsMO5f
	ZSTppWkYHOhBvJT7bycR/SFTJTMvDByGbPiHLVUbpMN5p8aBX7raH+c+Ill8Op2bBLvRCZ
	/SFiNk8untHlq6mhZz2rgtaEDCIolfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758896218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DXg90uzZG/vu8mNq7Fg3jlaCLKzUg4EaRQ6I0iV61WE=;
	b=xto6P6DhpKMVZuTf2kJWJq5l/4W2srND/OMt1+wSJHOUvHzKONFyU2Qzp5kg/fQzhsBY4t
	oUfl8AbA1+bBf9DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xAozLJnU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yIYV8Jdm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758896217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DXg90uzZG/vu8mNq7Fg3jlaCLKzUg4EaRQ6I0iV61WE=;
	b=xAozLJnUa3S037/4F8SIYgtCC7XgG1EiwCivyq+Pznrd45DibT0mdbtwSZCMPRsocemo6q
	xH3u10HCpUFiwV324XKbjf20EPOzGAOJiJtbn4/bM+U453rM1nr9+QIJS2TklwRBdMXfb7
	hRtMTo2Bsp532jIzOp8BNMrC9Ny8ocI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758896217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DXg90uzZG/vu8mNq7Fg3jlaCLKzUg4EaRQ6I0iV61WE=;
	b=yIYV8JdmAbh4JYc9aHiKJwpdwCj4obsYLo3Mnx77UPbi8rV2xBYjRFwZoRERv40pJRwGsS
	TodLGBDzufbMzoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5931373E;
	Fri, 26 Sep 2025 14:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zDJjOVig1mgDaQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Sep 2025 14:16:56 +0000
Message-ID: <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
Date: Fri, 26 Sep 2025 16:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Content-Language: en-US
To: Vincent Mailhol <mailhol@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,linutronix.de,linux-foundation.org,infradead.org,redhat.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0D1D6249C2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

+CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were never
added to the section, should we?

On 9/24/25 20:03, Vincent Mailhol wrote:
> The Linux kernel coding style [1] advises to avoid common variable
> names in function-like macros to reduce the risk of collisions.

I think it would be better if the tools like sparse could recognize if the
shadowing happens inside a macro only and thus really unlikely to cause a
misuse due to confusion (code thinks it's manipulating an outer instance but
instead it's the inner one), because macros in their definition would never
intend to manipulate a possible outer instance, right? Or are there any
other problems due to shadowing besides this risk?

> Throughout local_lock_internal.h, several macros use the rather common
> variable names 'l' and 'tl'. This already resulted in an actual
> collision: the __local_lock_acquire() function like macro is currently
> shadowing the parameter 'l' of the:
> 
>   class_##_name##_t class_##_name##_constructor(_type *l)
> 
> function factory from linux/cleanup.h.
> 
> Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
> throughout the file to fix the current name collision and to prevent
> future ones.
> 
> [1] https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

That said I don't oppose the change, but not my call.

> ---
> Changes in v2:
> 
>   - __lock conflicted with an existing definition in lockdep.c. Use
>     instead __l (and also, to keep things consistent, use __tl instead
>     of tl for the trylock).
> 
>   - Apply the renaming to the entire file and not just to
>     __local_lock_acquire().
> 
>   - Rewrite the patch description accordingly.
> 
> Link to v1: https://lore.kernel.org/r/20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org
> ---
>  include/linux/local_lock_internal.h | 56 ++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..a80b3fd7552376cd926aeaac8f53bcc44c8d2173 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -96,18 +96,18 @@ do {								\
>  
>  #define __local_lock_acquire(lock)					\
>  	do {								\
> -		local_trylock_t *tl;					\
> -		local_lock_t *l;					\
> +		local_trylock_t *__tl;					\
> +		local_lock_t *__l;					\
>  									\
> -		l = (local_lock_t *)(lock);				\
> -		tl = (local_trylock_t *)l;				\
> +		__l = (local_lock_t *)(lock);				\
> +		__tl = (local_trylock_t *)__l;				\
>  		_Generic((lock),					\
>  			local_trylock_t *: ({				\
> -				lockdep_assert(tl->acquired == 0);	\
> -				WRITE_ONCE(tl->acquired, 1);		\
> +				lockdep_assert(__tl->acquired == 0);	\
> +				WRITE_ONCE(__tl->acquired, 1);		\
>  			}),						\
>  			local_lock_t *: (void)0);			\
> -		local_lock_acquire(l);					\
> +		local_lock_acquire(__l);				\
>  	} while (0)
>  
>  #define __local_lock(lock)					\
> @@ -130,50 +130,50 @@ do {								\
>  
>  #define __local_trylock(lock)					\
>  	({							\
> -		local_trylock_t *tl;				\
> +		local_trylock_t *__tl;				\
>  								\
>  		preempt_disable();				\
> -		tl = (lock);					\
> -		if (READ_ONCE(tl->acquired)) {			\
> +		__tl = (lock);					\
> +		if (READ_ONCE(__tl->acquired)) {		\
>  			preempt_enable();			\
> -			tl = NULL;				\
> +			__tl = NULL;				\
>  		} else {					\
> -			WRITE_ONCE(tl->acquired, 1);		\
> +			WRITE_ONCE(__tl->acquired, 1);		\
>  			local_trylock_acquire(			\
> -				(local_lock_t *)tl);		\
> +				(local_lock_t *)__tl);		\
>  		}						\
> -		!!tl;						\
> +		!!__tl;						\
>  	})
>  
>  #define __local_trylock_irqsave(lock, flags)			\
>  	({							\
> -		local_trylock_t *tl;				\
> +		local_trylock_t *__tl;				\
>  								\
>  		local_irq_save(flags);				\
> -		tl = (lock);					\
> -		if (READ_ONCE(tl->acquired)) {			\
> +		__tl = (lock);					\
> +		if (READ_ONCE(__tl->acquired)) {		\
>  			local_irq_restore(flags);		\
> -			tl = NULL;				\
> +			__tl = NULL;				\
>  		} else {					\
> -			WRITE_ONCE(tl->acquired, 1);		\
> +			WRITE_ONCE(__tl->acquired, 1);		\
>  			local_trylock_acquire(			\
> -				(local_lock_t *)tl);		\
> +				(local_lock_t *)__tl);		\
>  		}						\
> -		!!tl;						\
> +		!!__tl;						\
>  	})
>  
>  #define __local_lock_release(lock)					\
>  	do {								\
> -		local_trylock_t *tl;					\
> -		local_lock_t *l;					\
> +		local_trylock_t *__tl;					\
> +		local_lock_t *__l;					\
>  									\
> -		l = (local_lock_t *)(lock);				\
> -		tl = (local_trylock_t *)l;				\
> -		local_lock_release(l);					\
> +		__l = (local_lock_t *)(lock);				\
> +		__tl = (local_trylock_t *)__l;				\
> +		local_lock_release(__l);				\
>  		_Generic((lock),					\
>  			local_trylock_t *: ({				\
> -				lockdep_assert(tl->acquired == 1);	\
> -				WRITE_ONCE(tl->acquired, 0);		\
> +				lockdep_assert(__tl->acquired == 1);	\
> +				WRITE_ONCE(__tl->acquired, 0);		\
>  			}),						\
>  			local_lock_t *: (void)0);			\
>  	} while (0)
> 
> ---
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> change-id: 20250923-local_lock_internal_fix_shadow-2e2a24e95e76
> 
> Best regards,


