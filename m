Return-Path: <linux-kernel+bounces-745966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D6B12104
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056F1CC4132
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C12BDC33;
	Fri, 25 Jul 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jU63o8H6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YduZZemj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jU63o8H6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YduZZemj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD95475E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457890; cv=none; b=eXgi/UREmjTZZwH4fO39DXHZvq0PYSDYDkud2VMsi4/pr7bxxk6QRvrKhsrTyFyUCbjO9iuL9HygiVx2adlyz3mKvEgmVgX9pBXxQtAxgTPhaqBFdZJhUVfZKxBho33IbxYfc+koUMM/FyRqYmJUiRcDfDQroXBfgLdaxN03OK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457890; c=relaxed/simple;
	bh=tQ/P5C61wIxyRNtFLhePXGyrWoTkEU/TQ03faUD5nu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtmVIPHXrGZ8bT1QWrc+hKlXPRssUwYxbwIei6m4QBcg8URZ42N7URENRlbQezDKnIrHVnYlmytl9l4LVc3szxHodb79S//IM91PBYXvRba9+dQHmCGGiOvZz/QV7Icw2J6VbQaa6uFRhnsotAl/GAEKOAiE9yZDRchQqVbFMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jU63o8H6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YduZZemj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jU63o8H6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YduZZemj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D49021A16;
	Fri, 25 Jul 2025 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753457886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6V8dlxI5N0x3RCAaUdHAjtLVSGrpxU1om7131VAmWE=;
	b=jU63o8H65eYOqvR5IaEhiTTYZHWrdT5bBXODEEc80wmY/RAUDbh2DxIxWr4saKQhxeH2vn
	RMkDus4UfqrFtOlv7L9Qtn6mp8N57fC0Rq8LP+8tSoAiQYKjE5tPsABC6VlyORE+l2WcQu
	t6e+KVD6IFF94MRgPxhg+fxbFYE4nfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753457886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6V8dlxI5N0x3RCAaUdHAjtLVSGrpxU1om7131VAmWE=;
	b=YduZZemj1T5Q4zM5L0Hz1Uy7on05op+5jS8WB1DS7nVokKtka+aElLXpTygkH8cP6REWl7
	xxAOmJPyb9Y3Q5DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jU63o8H6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YduZZemj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753457886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6V8dlxI5N0x3RCAaUdHAjtLVSGrpxU1om7131VAmWE=;
	b=jU63o8H65eYOqvR5IaEhiTTYZHWrdT5bBXODEEc80wmY/RAUDbh2DxIxWr4saKQhxeH2vn
	RMkDus4UfqrFtOlv7L9Qtn6mp8N57fC0Rq8LP+8tSoAiQYKjE5tPsABC6VlyORE+l2WcQu
	t6e+KVD6IFF94MRgPxhg+fxbFYE4nfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753457886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C6V8dlxI5N0x3RCAaUdHAjtLVSGrpxU1om7131VAmWE=;
	b=YduZZemj1T5Q4zM5L0Hz1Uy7on05op+5jS8WB1DS7nVokKtka+aElLXpTygkH8cP6REWl7
	xxAOmJPyb9Y3Q5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53F731373A;
	Fri, 25 Jul 2025 15:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x9MfFN6kg2itaAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Jul 2025 15:38:06 +0000
Message-ID: <1a43ebfa-0c4f-4029-ad81-125aba68b764@suse.cz>
Date: Fri, 25 Jul 2025 17:38:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
 <1d849190-214e-413e-a082-d7f862b653cc@suse.cz>
 <CAG48ez23CPO-m6kPaEs8kLUfRVCN+QMbsEn7BocfaJuq=gRwaA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAG48ez23CPO-m6kPaEs8kLUfRVCN+QMbsEn7BocfaJuq=gRwaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6D49021A16
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 7/25/25 16:44, Jann Horn wrote:
> On Fri, Jul 25, 2025 at 4:11 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> On 7/25/25 14:16, Jann Horn wrote:
>> > If an anon folio is mapped into userspace, its anon_vma must be alive,
>> > otherwise rmap walks can hit UAF.
>> >
>> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
>> > walks that seems to indicate that there can be pages with elevated mapcount
>> > whose anon_vma has already been freed, but I think we never figured out
>> > what the cause is; and syzkaller only hit these UAFs when memory pressure
>> > randomly caused reclaim to rmap-walk the affected pages, so it of course
>> > didn't manage to create a reproducer.
>> >
>> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folios to
>> > hopefully catch such issues more reliably.
>> >
>> > [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
>> > [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
>> >
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> > Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

>> > ---
>> > Changes in v2:
>> > - applied akpm's fixup (use FOLIO_MAPPING_ANON, ...)
>> > - remove CONFIG_DEBUG_VM check and use folio_test_* helpers (David)
>> > - more verbose comment (Lorenzo)
>> > - replaced "page" mentions with "folio" in commit message
>> > - Link to v1: https://lore.kernel.org/r/20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com
>> > ---
>> >  include/linux/rmap.h | 22 ++++++++++++++++++++++
>> >  1 file changed, 22 insertions(+)
>> >
>> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> > index 20803fcb49a7..6cd020eea37a 100644
>> > --- a/include/linux/rmap.h
>> > +++ b/include/linux/rmap.h
>> > @@ -449,6 +449,28 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>> >       default:
>> >               VM_WARN_ON_ONCE(true);
>> >       }
>> > +
>> > +     /*
>> > +      * Anon folios must have an associated live anon_vma as long as they're
>> > +      * mapped into userspace.
>> > +      * Note that the atomic_read() mainly does two things:
>> > +      *
>> > +      * 1. In KASAN builds with CONFIG_SLUB_RCU_DEBUG, it causes KASAN to
>> > +      *    check that the associated anon_vma has not yet been freed (subject
>>
>> I think more precisely it checks that the slab folio hosting the anon_vma
>> could not have been yet freed, IIUC? If the anon_vma itself has been freed
>> then this will not trigger.
> 
> The point of CONFIG_SLUB_RCU_DEBUG, which I'm talking about here, is
> that it allows KASAN to catch UAF once the anon_vma has been freed and
> an RCU grace period has passed; it is not necessary that the slab
> folio has been freed.
> 
> You can see that working in the linked syzkaller reports - KASAN
> tracked the object as freed after slab_free_after_rcu_debug(), which
> is an RCU callback scheduled from kmem_cache_free().
> 
>> > +      *    to KASAN's usual limitations). This check will pass if the
>> > +      *    anon_vma's refcount has already dropped to 0 but an RCU grace
>> > +      *    period hasn't passed since then.
>>
>> AFAIU this says it more accurately and matches my interpretation above?
>>
>> > +      * 2. If the anon_vma has not yet been freed, it checks that the
>> > +      *    anon_vma still has a nonzero refcount (as opposed to being in the
>> > +      *    middle of an RCU delay for getting freed).
>>
>> Again the RCU delay would apply to the slab page, unless you talk about the
>> CONFIG_SLUB_RCU_DEBUG specific path (IIRC).
> 
> Yes, right, the "RCU delay" in the second bullet point refers to
> CONFIG_SLUB_RCU_DEBUG.

OK I misunderstood that while bullet 1 notes the check only happens with
CONFIG_SLUB_RCU_DEBUG, I assumed the description is still meant semantically
from the point of anon_vma users (particularly what "freed" means - moment
of kfree() vs KASAN quarantine). Once considered from the point of what
happens with the object under CONFIG_SLUB_RCU_DEBUG, it all makes sense.

> Here I'm saying "If the anon_vma has not yet been freed" because
> that's the only case in which I can reliably say what will happen, and
> this is the main case that isn't already covered by the first bullet
> point in a CONFIG_SLUB_RCU_DEBUG build.
> 
>> That said, I wonder if here in __folio_rmap_sanity_checks() we are even in a
>> situation where we rely on SLAB_TYPESAFE_BY_RCU in order to not touch
>> something that's not anon_vma anymore? I think we expect it to exist?
> 
> Yes, we expect it to exist. That's why I'm not just asserting that the
> anon_vma is still considered live by KASAN, but also that its refcount
> is non-zero.
> 
>> Can we
>> thus invent a CONFIG_SLUB_RCU_DEBUG-specific assert that assert the anon_vma
>> itself has not been freed yet (i.e. even if within a grace period?).
> 
> That is essentially what I'm doing - checking that the count is
> nonzero verifies that it's not within a grace period, and the implicit
> KASAN check verifies it can't be in a KASAN quarantine after the grace
> period is over.

OK I guess that's sufficient and we'd be unlikely to find a bug scenario
where anon_vma was kfree'd() and thus KASAN with CONFIG_SLUB_RCU_DEBUG is
waiting for the grace period, yet it doesn't have a zero refcount.


