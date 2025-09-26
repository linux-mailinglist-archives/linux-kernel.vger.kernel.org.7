Return-Path: <linux-kernel+bounces-834278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6EBA4535
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FB6189100C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1820CCE4;
	Fri, 26 Sep 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Amc9kWCv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9QkMHzaM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1fdNvOQv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcUsi8RY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5B2045B7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898809; cv=none; b=MdRkgIkUyN6LR2s6ihEN6RsVbLpUGjZEcgi8arPp4xkIhvjZpeOf0q1RqhuRYKhg5aF9MWW3dLmC/dZZot3xKXDF/9eIppHprpgpvY4+9lfQ1gfmuU0QEzVq9CaFuW3NMFR76lx/XIlhKWdyGnzGeYBPDmd7OSH6I9Wb5Ahbl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898809; c=relaxed/simple;
	bh=CmbSomVZRveW/2dDOBiZe3eFLvryq4NMIHwN5P32t6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FC7cu8nTAZQNXx/eAD5dAcv5p2cmcq3j3bMYP9DkDhW875esV/BgGqGqbtXLMCqCebqusun9/azDHkOKY/5wy0K0Pa/AsxOzxmgXWYK0edLWwjOzQrHv5TNQME6awdrOnNqybqyqn+Ghq01QaBGnNsFRpf88A9ggkneGaSeDNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Amc9kWCv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9QkMHzaM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1fdNvOQv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcUsi8RY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B7C13425F;
	Fri, 26 Sep 2025 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758898804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/y2VxxdsRCyCO8bBQV6lvU0+2k2Q684722/aBmOhEU=;
	b=Amc9kWCv0nJPkBvPUi11/UPACVXbOoycDet/IA/iUAOo/lt6UjMJrlfnFMz2Zo9hdGTTQy
	+rq5hBeQ3fMj97lJNasNlaXkU6q8fliuP7CZBhCNffO55WOd6bx6VCIo6ww3/bEHX7+Cyq
	ToMLlbZC/4nqptajuTmw6I821m3lc48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758898804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/y2VxxdsRCyCO8bBQV6lvU0+2k2Q684722/aBmOhEU=;
	b=9QkMHzaMkD+iw+twa9HwIj1NaNWJQn5HL3g+eIUdok3UvP4pNYMbIMy/6s4UAc32vnd+MK
	YrOykDVzpomAreBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758898803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/y2VxxdsRCyCO8bBQV6lvU0+2k2Q684722/aBmOhEU=;
	b=1fdNvOQvhWePkW2jQ5Fmyi2AL/H6ZHQhyzkw1mpvj2lUbGkJ/SNmJgNM7SJC2BNTvgUz76
	x8mbeQPFQJY6Ufw/C3GyAmzMt/4O3d2m4Gg2vJQHndSPqGon4D2QaPCaGQtq7GWaYbnrg4
	FxHId0v5IJADCIGXxGUSblKnGS8n9FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758898803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/y2VxxdsRCyCO8bBQV6lvU0+2k2Q684722/aBmOhEU=;
	b=VcUsi8RYNl5DhqAjTUeSQFM4cIQ2E7McY7V3hEs5e6nrif2Av15E+a0+NYJ6Zh02UOf5G/
	F3bDnYffv9FBn7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E5F11386E;
	Fri, 26 Sep 2025 15:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NWiHGnOq1mhhdgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Sep 2025 15:00:03 +0000
Message-ID: <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>
Date: Fri, 26 Sep 2025 17:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, Elijah Wright <git@elijahs.space>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,oracle.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 9/25/25 11:54, Danilo Krummrich wrote:
> (+Cc: Lorenzo, Vlastimil, Liam, Uladzislau, MM)
> 
> On Wed Sep 24, 2025 at 9:36 PM CEST, Elijah Wright wrote:
>> this patch adds a basic slab module for kmem_cache, primarily wrapping
>> kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_destroy.
> 
> What's the motivation?
> 
> I mean, we will need kmem_cache soon. But the users will all be drivers, e.g.
> the GPU drivers that people work on currently.
> 
> Drivers shouldn't use "raw" allocators (such as Kmalloc [1] or Vmalloc [2]), but
> the corresponding "managed" allocation primitives, such as KBox [3], VBox [4],
> KVec, etc.
> 
> Therefore, the code below shouldn't be used by drivers directly, hence the
> question for motivation.
> 
> In any case, kmem_cache is a special allocator (special as in it can have a
> non-static lifetime in contrast to other kernel allocators) and should be
> integrated with the existing infrastructure in rust/kernel/alloc/.
> 
> I think there are multiple options for that; (1) isn't really an option, but I
> think it's good to mention anyways:
> 
>   (1) Allow for non-zero sized implementations of the Allocator trait [3], such
>       that we can store a reference count to the KmemCache. This is necessary to
>       ensure that a Box<T, KmemCache> can't out-live the KmemCache itself.
> 
>       The reason why I said it's not really an option is because it discards the
>       option for dynamic dispatch of the generic Box type.
> 
>   (2) Same as (1), but with a custom Box type. This keeps dynamic dispatch for
>       the generic Box type (i.e. KBox, VBox, KVBox), but duplicates quite some
>       code and still doesn't allow for dynamic dispatch for the KmemCacheBox.
> 
>   (3) Implement a macro to generate a custom KmemCache Allocator trait
>       implementation for every KmemCache instance with a static lifetime.
> 
>       This makes KmemCache technically equivalent to the other allocators, such
>       as Kmalloc, etc. but obviously has the downside that the KmemCache might
>       live much longer than required.

I don't know enough of Rust to follow why is that. What does mean "much longer"?

>       Technically, most KmemCache instances live for the whole module lifetime,
>       so it might be fine though.

I think so, yeah.

>       (This is what I think Alice proposed.)
> 
>   (4) Solve the problem on the C side and let kmem_cache_alloc() take care of
>       acquiring a reference count to the backing kmem_cache. The main question
>       here would be where to store the pointer for decreasing the reference
>       count on kmem_cache_free().

Pointer to what, the ref counter? If it's part of struct kmem_cache, then we
have pointer to that in kmem_cache_free(). Even when kfree() is used, it can
be (or rather already is) obtained. So that's not the issue (unless I
misunderstand).

But we wouldn't want to pay the cost of the atomic updates of the refcount
for all caches. If done only for Rust-created caches, the implementation
also would better not to add branches to all allocation/free fastpaths.

But also why is this refcounting needed? What would happen on the Rust side
if someone destroyed the cache too early? In the underlying C implementation
we notice it (reliably AFAICT), warn and abort the destroy (leaving it as a
kind of zombie) so I'd say it's safe. So if Rust needs to know if the
destroy was successful or premature, we could probably just return the
result instead of the current void.

>       Theoretically, it could be stored within the allocation itself, but it's a
>       bit of a yikes.
> 
>       However, it would resolve all the mentioned problems above.
> 
> I'd like to see (3) or (4), also depending on what the MM folks think.
> 
> - Danilo
> 
> [1] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Kmalloc.html
> [2] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Vmalloc.html
> [3] https://rust.docs.kernel.org/kernel/alloc/kbox/type.KBox.html
> [4] https://rust.docs.kernel.org/kernel/alloc/kbox/type.VBox.html
> [5] https://rust.docs.kernel.org/kernel/alloc/trait.Allocator.html


