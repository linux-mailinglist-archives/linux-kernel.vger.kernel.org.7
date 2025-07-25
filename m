Return-Path: <linux-kernel+bounces-745867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF43B11FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1486F1CC2B29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506321E8337;
	Fri, 25 Jul 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeoI53/k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqd1Cxbj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eeoI53/k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqd1Cxbj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888619E99F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452704; cv=none; b=hxAHXpgxqFHCgCHcUflu5fb8zgbgkoz9iYn0ITyfHkV7yHR2twjakrn//gEiU0prbjDL5wpwrImcO94I9aPgCowsEMrNjL5tbYzvItjpltHjKl7AYwqhYq6B9iUDBnDY4smpn3oPpj0N17Zl1f6FfYHT3ORfSDWHbQtCLgfBeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452704; c=relaxed/simple;
	bh=9HzTBxe9abeMvIegnzjaS9GWkJMyoqMNXQgV42DKb/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFV6yyMf0pqxI8vJW15xY4Q6uOWSE/5XbblD/+AUiV2po0e3KGHJa1+nBTcvhBkiyTw1qnrg/Uxcepo0gMRfuk+VJwz0gz8wik+v5ARlNLy5QF0lvrekMRJwZ5kyzS0a8Xm27UwKQjGEw2t2gNP0CNVOjPPAvmpMm+4mcWxoWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeoI53/k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqd1Cxbj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eeoI53/k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqd1Cxbj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B016C1F394;
	Fri, 25 Jul 2025 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753452700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eAGZ6zkd43INa2PK8t/9x1oBVSmCYvtg6tI5nWgOVbs=;
	b=eeoI53/k0Ph6v/E5nLIT/+Keh0VuMnrNwhavcfDeHyPXOCVyHGvAUWmgOgFyNBih5b/pab
	nRRxPNBgR+pbKigWlChWBAcnF2PUpCztO7xO7SmwJzDzrgJva2DR2QJEuckRGsT03GJyS0
	foSk3TJUFrxIwyG7HyD1x5RD1ea/9Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753452700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eAGZ6zkd43INa2PK8t/9x1oBVSmCYvtg6tI5nWgOVbs=;
	b=jqd1CxbjgDwG5DibKVgmNpfxicoUJDLThMn5CHmWSNcrodUutv8fIb3hAQCmJB7zmHpYTS
	1sY6ukh8/tu+mLAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753452700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eAGZ6zkd43INa2PK8t/9x1oBVSmCYvtg6tI5nWgOVbs=;
	b=eeoI53/k0Ph6v/E5nLIT/+Keh0VuMnrNwhavcfDeHyPXOCVyHGvAUWmgOgFyNBih5b/pab
	nRRxPNBgR+pbKigWlChWBAcnF2PUpCztO7xO7SmwJzDzrgJva2DR2QJEuckRGsT03GJyS0
	foSk3TJUFrxIwyG7HyD1x5RD1ea/9Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753452700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eAGZ6zkd43INa2PK8t/9x1oBVSmCYvtg6tI5nWgOVbs=;
	b=jqd1CxbjgDwG5DibKVgmNpfxicoUJDLThMn5CHmWSNcrodUutv8fIb3hAQCmJB7zmHpYTS
	1sY6ukh8/tu+mLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AFB91373A;
	Fri, 25 Jul 2025 14:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMWAJZyQg2gmTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Jul 2025 14:11:40 +0000
Message-ID: <1d849190-214e-413e-a082-d7f862b653cc@suse.cz>
Date: Fri, 25 Jul 2025 16:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/25/25 14:16, Jann Horn wrote:
> If an anon folio is mapped into userspace, its anon_vma must be alive,
> otherwise rmap walks can hit UAF.
> 
> There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> walks that seems to indicate that there can be pages with elevated mapcount
> whose anon_vma has already been freed, but I think we never figured out
> what the cause is; and syzkaller only hit these UAFs when memory pressure
> randomly caused reclaim to rmap-walk the affected pages, so it of course
> didn't manage to create a reproducer.
> 
> Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folios to
> hopefully catch such issues more reliably.
> 
> [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
> [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Changes in v2:
> - applied akpm's fixup (use FOLIO_MAPPING_ANON, ...)
> - remove CONFIG_DEBUG_VM check and use folio_test_* helpers (David)
> - more verbose comment (Lorenzo)
> - replaced "page" mentions with "folio" in commit message
> - Link to v1: https://lore.kernel.org/r/20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com
> ---
>  include/linux/rmap.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 20803fcb49a7..6cd020eea37a 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -449,6 +449,28 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>  	default:
>  		VM_WARN_ON_ONCE(true);
>  	}
> +
> +	/*
> +	 * Anon folios must have an associated live anon_vma as long as they're
> +	 * mapped into userspace.
> +	 * Note that the atomic_read() mainly does two things:
> +	 *
> +	 * 1. In KASAN builds with CONFIG_SLUB_RCU_DEBUG, it causes KASAN to
> +	 *    check that the associated anon_vma has not yet been freed (subject

I think more precisely it checks that the slab folio hosting the anon_vma
could not have been yet freed, IIUC? If the anon_vma itself has been freed
then this will not trigger.

> +	 *    to KASAN's usual limitations). This check will pass if the
> +	 *    anon_vma's refcount has already dropped to 0 but an RCU grace
> +	 *    period hasn't passed since then.

AFAIU this says it more accurately and matches my interpretation above?

> +	 * 2. If the anon_vma has not yet been freed, it checks that the
> +	 *    anon_vma still has a nonzero refcount (as opposed to being in the
> +	 *    middle of an RCU delay for getting freed).

Again the RCU delay would apply to the slab page, unless you talk about the
CONFIG_SLUB_RCU_DEBUG specific path (IIRC).

That said, I wonder if here in __folio_rmap_sanity_checks() we are even in a
situation where we rely on SLAB_TYPESAFE_BY_RCU in order to not touch
something that's not anon_vma anymore? I think we expect it to exist? Can we
thus invent a CONFIG_SLUB_RCU_DEBUG-specific assert that assert the anon_vma
itself has not been freed yet (i.e. even if within a grace period?).

I was wondering what actually does rely on SLAB_TYPESAFE_BY_RCU, thanks
Lorenzo for pointing me to folio_get_anon_vma(). But that's only used
elsewhere than here, no?

> +	 */
> +	if (folio_test_anon(folio) && !folio_test_ksm(folio)) {

So you verified this compiles out completely without DEBUG_VM?

> +		unsigned long mapping = (unsigned long)folio->mapping;
> +		struct anon_vma *anon_vma;
> +
> +		anon_vma = (void *)(mapping - FOLIO_MAPPING_ANON);
> +		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
> +	}
>  }
>  
>  /*
> 
> ---
> base-commit: 1d1c610e32ab2489c49fccb7472a6bef136a0a8b
> change-id: 20250724-anonvma-uaf-debug-a9db0eb4177b
> 


