Return-Path: <linux-kernel+bounces-834463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376ABA4BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8AA1BC8289
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAF30C342;
	Fri, 26 Sep 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nRwpXO+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LR7sDKlf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nRwpXO+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LR7sDKlf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F40307ACC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906725; cv=none; b=hQRQSfUVGfuQny67a8aAj2AQOht9rNMtEd+UsMczwxs5Wui3JeamuLMBHEGvlf78lU5MJ/DNj/Tre1E/0HOk1S0dzs8RsC2Vz+xSbiCcVyHyiq0M1v7Ci7Gslgj92YXC4y1rCO7lQ++XI+vC5khWL27aqV6jqB8fsaAcjUtV7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906725; c=relaxed/simple;
	bh=U9N4TeOnkxvqTKSBciFqns4wvFOW1A7fVPj0etLrAFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fz5gDDYNYQbrgbIxGWNyfdE4itPXGm2IkKeK0iM9wrrirSrWdHmBUg7mN5PfK0sNMoz3pQCEemXB9qypv9vdHogf2JpH+pYUnGynMYasKL1UyxldISLhgCgr8jo5nH8lGff+aro91PRTAuIVVUlUF2h8nPaDdlXTGDXVjtVXBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nRwpXO+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LR7sDKlf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nRwpXO+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LR7sDKlf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5131B243F7;
	Fri, 26 Sep 2025 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758906720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IKHikqJ1cn2yMHDVFPGBQhz/2NMrhqlW0Rdo3rkQdqw=;
	b=nRwpXO+EozLOwUrBDa+iKRMbOE56Uo1YAqA4ShhGZ9N6+0/Mnppklo/HXx51bKxIm9K4Z+
	pSpXULhlqcJQp9MSBdivQAYCZHSCrYYSNDuJIOUXLzkr+mZxia/xpLzt4Ej+P7OQGAiPDN
	WE4OcYvjh9etGPI9l9FNwU8NWVIgOKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758906720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IKHikqJ1cn2yMHDVFPGBQhz/2NMrhqlW0Rdo3rkQdqw=;
	b=LR7sDKlfHO9YZuEM9w1sG8Fqn766R0+/Auz4r5Kgb3Azgngf+U1RS41J2xBYM7fsomZGWF
	ofYq0PV/OoT8nECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nRwpXO+E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LR7sDKlf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758906720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IKHikqJ1cn2yMHDVFPGBQhz/2NMrhqlW0Rdo3rkQdqw=;
	b=nRwpXO+EozLOwUrBDa+iKRMbOE56Uo1YAqA4ShhGZ9N6+0/Mnppklo/HXx51bKxIm9K4Z+
	pSpXULhlqcJQp9MSBdivQAYCZHSCrYYSNDuJIOUXLzkr+mZxia/xpLzt4Ej+P7OQGAiPDN
	WE4OcYvjh9etGPI9l9FNwU8NWVIgOKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758906720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IKHikqJ1cn2yMHDVFPGBQhz/2NMrhqlW0Rdo3rkQdqw=;
	b=LR7sDKlfHO9YZuEM9w1sG8Fqn766R0+/Auz4r5Kgb3Azgngf+U1RS41J2xBYM7fsomZGWF
	ofYq0PV/OoT8nECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 324BE1373E;
	Fri, 26 Sep 2025 17:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NJS6C2DJ1mjSIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Sep 2025 17:12:00 +0000
Message-ID: <57b01f59-f4b1-4f5f-bb63-fd8eea19b7ba@suse.cz>
Date: Fri, 26 Sep 2025 19:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>
Cc: Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>
 <DD2UB5P01XW7.1GW33112S22Y@kernel.org>
 <DD2URCNO2P88.168J48GHSJRRL@kernel.org>
 <1f5ae3bd-db21-4042-b177-55464644ce2e@suse.cz>
 <DD2W3LCC7FWA.2X90YAPLI1FGC@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <DD2W3LCC7FWA.2X90YAPLI1FGC@kernel.org>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	FREEMAIL_CC(0.00)[elijahs.space,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,oracle.com,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5131B243F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 9/26/25 18:58, Danilo Krummrich wrote:
> On Fri Sep 26, 2025 at 6:32 PM CEST, Vlastimil Babka wrote:
>> On 9/26/25 17:55, Danilo Krummrich wrote:
> 
>>> 	// Frees foo and causes the "zombie" cache to actually be destroyed.
>>> 	kmem_cache_free(foo);
>>
>> The free will be fine. But not cause the cache destruction, as that would
>> require checks on each free. But should be fine wrt safety if we only leak
>> some memory due to a wrong usage, no?
> 
> Yes, technically that's safe, but we wouldn't prevent the leak, which still
> is not desirable (and not our ambition for a Rust API).
> 
> From a C standpoint, both the warning and the cache leak could be solved by
> making kmem_cache_destroy() fallible as you mentioned previously.
> 
> On the Rust side the cache would be represented with a struct KmemCache<T>
> (where T is the type that should be allocated by the cache).
> 
> kmem_cache_destroy() would be called from KmemCache<T>::drop(), which is not
> fallible. But even if it were, we can't enforce that users keep the KmemCache
> instance alive as long as there are allocations.
> 
> So, either we always keep the KmemCache<T> alive for the whole module lifetime
> (which depending on whether its built-in or not could be considered a memory
> leak as well). Or we ensure that the last kmem_cache_free() also frees the cache
> if kmem_cache_destroy() was called previously.

The rust wrapper side could do that so we don't have to add that check in
all kmem_cache_free() calls, maybe?
Also either way it could perhaps be difficult/expensive (memory barriers
etc) to properly handle a racing kmem_cache_free() and kmem_cache_destroy()
in a way that ensures the cache is always being destroyed, and not have the
kmem_cache_destroy() observe the destroy was premature, while the racing
kmem_cache_free() doesn't yet observe that destroy was attempted, and not
try to remove it.
> OOC, does the cache pointer remain valid if kmem_cache_destroy() is called while
> allocations still exist? I.e. is this, except for the WARN(), valid code?
> 
> 	kmem_cache_destroy(cache);
> 	kmem_cache_free(foo);
> 	kmem_cache_destroy(cache);
Currently not, but making it valid hopefully should not be difficult,
without affecting fast path.

> At a quick glance it appears to me that things would go south in
> kmem_cache_release(). Anyways, I don't think it would help, if it would be the
> case.

It would help if it was safe and the rust wrapper side did this retry?

