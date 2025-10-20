Return-Path: <linux-kernel+bounces-860398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF5BF00AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 506DE34A825
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B772EBB84;
	Mon, 20 Oct 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Y893FPr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZohy/yp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nP8jnnP9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpKe92SB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D11643B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950480; cv=none; b=Q86YrUWXVVYkOjgsiZuKoKuDofFqCr5L98TwPuBUreBujjx0Si0h9Twwcwcvv5oPeLP6KvkvyzxvXxeJzP/a19suPLmK5ueD7YL+/Y6VFYMDY2Vnu8ZxekrLJMnWQHNnIl75nxvqdhWYCgftgHXEjtyg/ejCqoIkkpxIPC8obAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950480; c=relaxed/simple;
	bh=Qx0U8iZiPNgmtEE/+Kexnyqpt96ybypEAkOUa5T09e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiVflcB5NCA/Y3SNviF76RhiPdkV9bfyENbnFHwFYhrYmkeY7FHtr1sCEsWX4H295+nrXGkBn4NUGcjt7PmQNH5xubO3Pq9HZ0jTB3OL1k7PbW9arypLWH2Sp0ftZI1BTxUSEcMfA/YBCbNXEM9Q8/VzB+Y1DUqj5qkNBjjtsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Y893FPr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rZohy/yp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nP8jnnP9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpKe92SB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0151F45B;
	Mon, 20 Oct 2025 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1SIAjLYaomhvx/XpGvZv7XhmwT4AyW39hM3cNjdMX1o=;
	b=0Y893FPrVwNQPbh2mfAbVxcLqPcH63TZrDuXr6GuImMklNrp7ERTBcayRvQBUNn6Wpe40h
	zrQqYGDsfmUeXPE0UmPHlhlBH4LYm22LpvHlhxx6HZaScj6NFjfEuH2Tx0Vw4SKlxKEk+N
	7YJuKvq6FgAzZ7lFrUKTSTyTm163QXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1SIAjLYaomhvx/XpGvZv7XhmwT4AyW39hM3cNjdMX1o=;
	b=rZohy/ypPjc0QOr/1jTe/L7MYzxcNyl1uyALdSdOrfXPIVQzSyIGfmdSr0LhpGDUgmL2It
	0D3MMC7ir500IfAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1SIAjLYaomhvx/XpGvZv7XhmwT4AyW39hM3cNjdMX1o=;
	b=nP8jnnP9wJPEZdlGhiRR8TXGJDAeQh5X9eZ624oGUvv0SAS/PKUdfogpfirNdE7oIzwxu2
	ckY9PAyoMoEvVyaE7PkMI9cp4RgLCNkc4ZfZX37/IRS47u6o1dzdRfVa85NB4/vV1AhNFc
	+aylBn5FzQZeuSAGQMI7FM7H8VXbYWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1SIAjLYaomhvx/XpGvZv7XhmwT4AyW39hM3cNjdMX1o=;
	b=cpKe92SBjkJUZFldsZPMxZfLcymMdfNorlgWXU9NyTQABsxkCYNI5jzFeBzYPuGBn4ajS7
	LqzhQDYBlOKZyPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA9AD13A8E;
	Mon, 20 Oct 2025 08:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g4LkMsP49Wg3YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 Oct 2025 08:54:27 +0000
Message-ID: <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>
Date: Mon, 20 Oct 2025 10:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
To: Mike Rapoport <rppt@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Al Viro <viro@ZenIV.linux.org.uk>
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org> <aPT0zNMZqt89cIXH@kernel.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aPT0zNMZqt89cIXH@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/19/25 16:25, Mike Rapoport wrote:
> On Sun, Oct 19, 2025 at 01:30:47AM +0100, Matthew Wilcox wrote:
>> On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
>> > Vast majority of allocations that use get_free_pages() and its derivatives
>> > cast the returned unsigned long to a pointer and then cast it back to
>> > unsigned long when freeing the memory.
>> > 
>> > These castings are useless and only obfuscate the code.
>> > 
>> > Make get_free_pages() and friends return 'void *' and free_pages() accept
>> > 'void *' as its address parameter.
>> 
>> No.  Linus has rejected this change before.  I can't find it now, it was
>> a long time ago. 

Here's a lore link
https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 
> If it was a long time ago, he might not object it now.

Did the circumstances change in a positive way? Using a semantic patch might
make it less painfull to apply in a flag day manner, although depends on how
much is that "a bit of manual tweaking" you mention.

>> Most of them shouldn't be using get_free_pages() at all, they should be
>> using kmalloc().

Changing to kmalloc() would have to be careful, what if the callers rely on
doing e.g. get_page() later. It would however be useful to dintinguish "I
want a page-sized buffer" (note that it's guaranteed to be aligned by
kmalloc() these days, which it wasn't in 2015) from "I really want a page".
But many of the latter cases maybe want a struct page then and are using
alloc_pages()? 
> Don't know if most but some of them could. Still, we'd have a bunch of
> get_free_pages() users with needless castings.
> And converting callers that should use kmalloc() is a long and tedious
> process, while here we get an API improvement in a single automated change.
Maybe a more feasible way would be to rename to something more coherent,
while keeping the old interfaces alive for a while for easier backporting.
because __get_free_pages() / free_pages() is not really great naming.
If possible it would be nice to also make __GFP_COMP implicit in the new API.


