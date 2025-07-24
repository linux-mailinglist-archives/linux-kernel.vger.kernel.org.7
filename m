Return-Path: <linux-kernel+bounces-744522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432AAB10DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E801CE5126
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081182E54D5;
	Thu, 24 Jul 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eju9qaJv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ISBEXTp9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eju9qaJv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ISBEXTp9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B55263C7F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368318; cv=none; b=hAy7RiU8MC5CSK5dDz1QehGToBfKOUci620Ds9NdjDRxR8XzlAKp15x2TfXOQY0oqpQoBN1Tp9bshwDWKRGF5wE9ho7ab4AZvqM2xAczcaHRGOLlSvxNeZITUe7ToccRnoY3KCJXe2FbszMhkZ2ICUOKVMn13PkjKrUIMWVAXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368318; c=relaxed/simple;
	bh=ewfq/+yzE1oP3BB+kbJ7ABBI3H6siJPOKM5yYFnlusI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+jOCxmUgqbEZj5mVGjfQ+G2ixNxoMM5Y3SPxLzRb/nmVZuGx91GJ+41I7SsdwTI/FcW0ynQ0Obr6G/P0ZTg2bZNLvfcwI3kO3gun/7asOlNUAzIUpiJn7F4dtlOwhLZmASCx8qxLBCIDsE46fb4Q4JAEXC5+6RneWoZhVYrTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eju9qaJv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ISBEXTp9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eju9qaJv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ISBEXTp9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 731D11F394;
	Thu, 24 Jul 2025 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753368314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X04DjsKOa5+/UwUJIs6OjpEsdAubLYmuiRKetZmnjHo=;
	b=eju9qaJvgX7uIibKIhPCtq5ayo4xSBNhT2GAehjJbnuTTzkgfG/xTy3d2ltyC9WWkpeIYL
	H/GUtZH5XI7solDcN8E400qS7T6um+1jOP0vgNfa2VwhoBOmfOm6ZWAgy0HswPQ502Ud8f
	WQ06x29MqVb1JkcAvJV1gv7j8AMNimY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753368314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X04DjsKOa5+/UwUJIs6OjpEsdAubLYmuiRKetZmnjHo=;
	b=ISBEXTp9nox8/5HWEvGta9VB5cdBBNHfvq9Nq/jqOIil1Pc6b39wbBbOMOHYN/E1nhVj+e
	vSFWHXWat3YbUQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eju9qaJv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ISBEXTp9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753368314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X04DjsKOa5+/UwUJIs6OjpEsdAubLYmuiRKetZmnjHo=;
	b=eju9qaJvgX7uIibKIhPCtq5ayo4xSBNhT2GAehjJbnuTTzkgfG/xTy3d2ltyC9WWkpeIYL
	H/GUtZH5XI7solDcN8E400qS7T6um+1jOP0vgNfa2VwhoBOmfOm6ZWAgy0HswPQ502Ud8f
	WQ06x29MqVb1JkcAvJV1gv7j8AMNimY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753368314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X04DjsKOa5+/UwUJIs6OjpEsdAubLYmuiRKetZmnjHo=;
	b=ISBEXTp9nox8/5HWEvGta9VB5cdBBNHfvq9Nq/jqOIil1Pc6b39wbBbOMOHYN/E1nhVj+e
	vSFWHXWat3YbUQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FEC5136DC;
	Thu, 24 Jul 2025 14:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id grASF/pGgmgEOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Jul 2025 14:45:14 +0000
Message-ID: <3be82198-a992-4917-b5ac-b93bb0474ad1@suse.cz>
Date: Thu, 24 Jul 2025 16:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato
 <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>,
 kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
 <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
 <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
 <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz>
 <dbc20783-0ff5-4902-bd73-e9282bfd87ba@lucifer.local>
 <CAJuCfpEVrpHACx2G2=Gq7YadxkA-DnFpFmbUij=Xr1=w7yrLbg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpEVrpHACx2G2=Gq7YadxkA-DnFpFmbUij=Xr1=w7yrLbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,oracle.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 731D11F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/24/25 16:29, Suren Baghdasaryan wrote:
> On Thu, Jul 24, 2025 at 3:53 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> On Thu, Jul 24, 2025 at 10:38:06AM +0200, Vlastimil Babka wrote:
>> > On 7/24/25 04:30, Suren Baghdasaryan wrote:
>> > > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
>> > > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
>> > > after it calls rcuwait_wake_up(). What do you think about this
>> > > approach, folks?
>> >
>> > Yeah except it would be wasteful to do for all vma_refcount_put(). Should be
>> > enough to have this version (as Jann suggested) for inval_end_read: part of
>> > lock_vma_under_rcu.
> 
> Yes, definitely.
> 
>> > I think we need it also for the vma_refcount_put() done
>> > in vma_start_read() when we fail the seqcount check? I think in that case
>> > the same thing can be happening too, just with different race windows?
> 
> Yes.
> 
>> >
>> > Also as Jann suggested, maybe it's not great (or even safe) to perform
>> > __mmdrop() under rcu? And maybe some vma_start_read() users are even more
>> > restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-only, and
>> > use that.
>>
>> Agreed that doing this under RCU seems unwise.
>>
>> I know PTL relies on this as well as zap PTE page table reclaim, likely these
>> wouldn't interact with an mm going away (you'd hope!) but it seems unwise to
>> play around with assumptions here.
> 
> __mmdrop_delayed() is a viable option but I would hate adding
> mm->delayed_drop for !CONFIG_PREEMPT_RT just for this one case.
> Alternatively, we don't need to be in the rcu read section when we
> call vma_end_read() inside lock_vma_under_rcu(). We refcounted the
> vma, so it's locked and stable, no need for RCU at that point. We can
> move rcu_read_unlock() before vma_end_read(). However that's not the

Seems correct.

> case with the vma_refcount_put() inside vma_start_read(). We could
> change vma_start_read() semantics so that it drops rcu_read_lock
> before it returns.

Looks like there's no other users of vma_start_read() than
lock_vma_under_rcu() itself that we need to care about, so seems fine.

> That way we could do vma_refcount_put() after
> rcu_read_unlock() in both places.  The retry case in
> lock_vma_under_rcu() would have to reacquire rcu_read_lock() but that
> retry is not the usual path, so should not affect overall locking
> performance. What do you think about this alternative?

Sounds feasible.

I guess at that point it would be cleaner to combine vma_start_read() with
mas_walk() into a new function that does both and starts with
rcu_read_lock() itself so we don't have the ugly scheme of entering under
rcu lock and returning without it?


