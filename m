Return-Path: <linux-kernel+bounces-848850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A0BCEB11
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0075B4EAB65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C66275AF3;
	Fri, 10 Oct 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wQnbXGxa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+vXJ0/lx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wQnbXGxa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+vXJ0/lx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE822586E8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134963; cv=none; b=Bpnqd2o7Eceuk4LThUEKNpA3CzEzV2XRHdxUSibNIC8U6Na2vshP9YZW31Fn+kc6KyZB6FCJ80huIXRioyH8BOre7m9Ir4CbmhiFJ4ZddZ1a61m+XU3eN+RoiQdzrMfmjYfIqMIE/OwguYs/XLKyxuA7f1q+pxu2706mcmfuH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134963; c=relaxed/simple;
	bh=4OpfVHsgXFRtJQaKFNYeAexFCPgXL097OheNEdXKjAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxQf1smU+cRW92DYvllMDV77xjKwu2qAJS9aRW2NdwPWWMpYbMgQnZd5xk1tkivOFo4KTmBrkyIVNZwNTWcKKlS40hDNJ9Vx9NbFgURQBWhU2JrjFNDU4od/+A9G/l/e/Ii6Rr7jS6AHzIQLgeZLfOy6DAYPBjHNrynjwxrQjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wQnbXGxa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+vXJ0/lx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wQnbXGxa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+vXJ0/lx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E9C721296;
	Fri, 10 Oct 2025 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760134959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CoidhoAJMSRHlOc80UKzkj3wdpRYS95gkUwEBw2geM=;
	b=wQnbXGxavvVRIPwBWqxS4dmndlHd8frgaINOfWP/mUP2Cx9w2kOSnVCrlq6SZDZvXXO31g
	aNfY5RwUAdK6gflQm+X60bCn6Ytt7fy/RY0ruN+kUOzZJ5Z/eI1hI29Z7uKJpP+4FbYdsp
	ASsWR0rzzQvyrnnXGQcjRVH+zORXTmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760134959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CoidhoAJMSRHlOc80UKzkj3wdpRYS95gkUwEBw2geM=;
	b=+vXJ0/lxsMo+WUC2cvqXnw/4jrzn34kKJ8Xr2P9rGhSkY+67FrDJhyQE5V9ZcA0AvgnH7R
	32uPE+0Yd0cBUkCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wQnbXGxa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+vXJ0/lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760134959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CoidhoAJMSRHlOc80UKzkj3wdpRYS95gkUwEBw2geM=;
	b=wQnbXGxavvVRIPwBWqxS4dmndlHd8frgaINOfWP/mUP2Cx9w2kOSnVCrlq6SZDZvXXO31g
	aNfY5RwUAdK6gflQm+X60bCn6Ytt7fy/RY0ruN+kUOzZJ5Z/eI1hI29Z7uKJpP+4FbYdsp
	ASsWR0rzzQvyrnnXGQcjRVH+zORXTmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760134959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CoidhoAJMSRHlOc80UKzkj3wdpRYS95gkUwEBw2geM=;
	b=+vXJ0/lxsMo+WUC2cvqXnw/4jrzn34kKJ8Xr2P9rGhSkY+67FrDJhyQE5V9ZcA0AvgnH7R
	32uPE+0Yd0cBUkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DA911375D;
	Fri, 10 Oct 2025 22:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YYxXHi+H6WgGTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 10 Oct 2025 22:22:39 +0000
Message-ID: <b63f1f40-a8f5-4b54-b025-d8d1daf78c9b@suse.cz>
Date: Sat, 11 Oct 2025 00:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Boot fails with 59faa4da7cd4 and 3accabda4da1
Content-Language: en-US
To: Phil Auld <pauld@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>
References: <20251010151116.GA436967@pauld.westford.csb>
 <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
 <e4f2a3e3-649a-423b-9696-6406ef56340f@suse.cz>
 <20251010184259.GB436967@pauld.westford.csb>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <20251010184259.GB436967@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8E9C721296
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 10/10/25 20:42, Phil Auld wrote:
> On Fri, Oct 10, 2025 at 08:27:30PM +0200 Vlastimil Babka wrote:
>> On 10/10/25 20:19, Linus Torvalds wrote:
>> > On Fri, 10 Oct 2025 at 08:11, Phil Auld <pauld@redhat.com> wrote:
>> >>
>> >> After several days of failed boots I've gotten it down to these two
>> >> commits.
>> >>
>> >> 59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
>> >> 3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache
>> >>
>> >> The first is such an early failure it's silent. With just 3acca I
>> >> get :
>> >>
>> >> [    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
>> >> [    9.348115] #PF: supervisor read access in kernel mode
>> >> [    9.353264] #PF: error_code(0x0000) - not-present page
>> >> [    9.358413] PGD 0 P4D 0
>> >> [    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
>> >> [    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
>> >> [    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
>> >> [    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
>> >> [    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
>> > 
>> > That decodes to
>> > 
>> >    0:           mov    0x10(%rsi),%rax
>> >    4:           mov    0x8(%rsi),%rsi
>> >    8:           test   %rax,%rax
>> >    b:           je     0x18
>> >    d:           mov    0x18(%rax),%ecx
>> >   10:           test   %ecx,%ecx
>> >   12:           jne    0xfd
>> >   18:           movslq %gs:0x250eee4(%rip),%rax
>> >   20:           mov    0xe0(%r14,%rax,8),%rax
>> >   28:*          mov    0x40(%rax),%r13          <-- trapping instruction
>> >   2c:           mov    %r13,%rdi
>> >   2f:           call   0xffffffffffff81e4
>> >   34:           mov    %rax,%rbp
>> >   37:           test   %rax,%rax
>> >   3a:           je     0x59
>> > 
>> > which is the code around that barn_replace_empty_sheaf() call.
>> > 
>> > In particular, the trapping instruction is from get_barn(), it's the "->barn" in
>> > 
>> >         return get_node(s, numa_mem_id())->barn;
>> > 
>> > so it looks like 'get_node()' is returning NULL here:
>> > 
>> >         return s->node[node];
>> > 
>> > That 0x250eee4(%rip) is from "get_node()" becoming
>> > 
>> >   18:           movslq  %gs:numa_node(%rip), %rax  # node
>> >   20:           mov    0xe0(%r14,%rax,8),%rax # ->node[node]
>> > 
>> > instruction, and then that ->barn dereference is the trapping
>> > instruction that tries to read node->barn:
>> > 
>> >   28:*          mov    0x40(%rax),%r13   # node->barn
>> > 
>> > but I did *not* look into why s->node[node] would be NULL.
>> > 
>> > Over to you Vlastimil,
>> 
>> Thanks, yeah will look ASAP. I suspect the "nodes with zero memory" is
>> something that might not be handled well in general on x86. I know powerpc
>> used to do these kind of setups first and they have some special handling,
>> so numa_mem_id() would give you the closest node with memory in there and I
>> suspect it's not happening here. CPU 21 is node 6 so it's one of those
>> without memory. I'll see if I can simulate this with QEMU and what's the
>> most sensible fix
>>
> 
> Thanks for taking a look.  I thought the NPS4 thing might be playing a role.

From what I quickly found I understood that NPS4 is supposed to create extra
numa nodes per socket (4 instead of 1) and interleave the memory between
them. So it seems weird to me it would assign everything to one node and
leave 3 others memoryless?

> I'm happy to take any test/fix code you have for a spin on this system. 
 
Thanks. Here's a candidate fix in case you can test. I'll finalize it
tomorrow. The slab performance won't be optimal on cpus on those memoryless
nodes, that's why I'd like to figure out if it's a BIOS bug or not. If
memoryless nodes are really intended we should look into initializing things
so that numa_mem_id() works as expected and points to nearest populated
node.

----8<----
From 097c6251882bf5537162d17b6726575288ba9715 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Sat, 11 Oct 2025 00:13:20 +0200
Subject: [PATCH] slab: fix NULL pointer when trying to access barn

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 60 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 135c408e0515..bd3c2821e6c3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -507,7 +507,12 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 /* Get the barn of the current cpu's memory node */
 static inline struct node_barn *get_barn(struct kmem_cache *s)
 {
-	return get_node(s, numa_mem_id())->barn;
+	struct kmem_cache_node *n = get_node(s, numa_mem_id());
+
+	if (!n)
+		return NULL;
+
+	return n->barn;
 }
 
 /*
@@ -4982,6 +4987,10 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	}
 
 	barn = get_barn(s);
+	if (!barn) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
 
 	full = barn_replace_empty_sheaf(barn, pcs->main);
 
@@ -5153,13 +5162,20 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (unlikely(pcs->main->size == 0)) {
 
 		struct slab_sheaf *full;
+		struct node_barn *barn;
 
 		if (pcs->spare && pcs->spare->size > 0) {
 			swap(pcs->main, pcs->spare);
 			goto do_alloc;
 		}
 
-		full = barn_replace_empty_sheaf(get_barn(s), pcs->main);
+		barn = get_barn(s);
+		if (!barn) {
+			local_unlock(&s->cpu_sheaves->lock);
+			return allocated;
+		}
+
+		full = barn_replace_empty_sheaf(barn, pcs->main);
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -5314,6 +5330,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *sheaf = NULL;
+	struct node_barn *barn;
 
 	if (unlikely(size > s->sheaf_capacity)) {
 
@@ -5355,8 +5372,11 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 		pcs->spare = NULL;
 		stat(s, SHEAF_PREFILL_FAST);
 	} else {
+		barn = get_barn(s);
+
 		stat(s, SHEAF_PREFILL_SLOW);
-		sheaf = barn_get_full_or_empty_sheaf(get_barn(s));
+		if (barn)
+			sheaf = barn_get_full_or_empty_sheaf(barn);
 		if (sheaf && sheaf->size)
 			stat(s, BARN_GET);
 		else
@@ -5426,7 +5446,7 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 	 * If the barn has too many full sheaves or we fail to refill the sheaf,
 	 * simply flush and free it.
 	 */
-	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
+	if (!barn || data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
 	    refill_sheaf(s, sheaf, gfp)) {
 		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
@@ -5943,10 +5963,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
  * put the full sheaf there.
  */
 static void __pcs_install_empty_sheaf(struct kmem_cache *s,
-		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty)
+		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
+		struct node_barn *barn)
 {
-	struct node_barn *barn;
-
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	/* This is what we expect to find if nobody interrupted us. */
@@ -5956,8 +5975,6 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
 		return;
 	}
 
-	barn = get_barn(s);
-
 	/*
 	 * Unlikely because if the main sheaf had space, we would have just
 	 * freed to it. Get rid of our empty sheaf.
@@ -6002,6 +6019,11 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	barn = get_barn(s);
+	if (!barn) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	put_fail = false;
 
 	if (!pcs->spare) {
@@ -6084,7 +6106,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
-	__pcs_install_empty_sheaf(s, pcs, empty);
+	__pcs_install_empty_sheaf(s, pcs, empty, barn);
 
 	return pcs;
 }
@@ -6121,8 +6143,9 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 
 static void rcu_free_sheaf(struct rcu_head *head)
 {
+	struct kmem_cache_node *n;
 	struct slab_sheaf *sheaf;
-	struct node_barn *barn;
+	struct node_barn *barn = NULL;
 	struct kmem_cache *s;
 
 	sheaf = container_of(head, struct slab_sheaf, rcu_head);
@@ -6139,7 +6162,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	 */
 	__rcu_free_sheaf_prepare(s, sheaf);
 
-	barn = get_node(s, sheaf->node)->barn;
+	n = get_node(s, sheaf->node);
+	if (!n)
+		goto flush;
+
+	barn = n->barn;
 
 	/* due to slab_free_hook() */
 	if (unlikely(sheaf->size == 0))
@@ -6157,11 +6184,12 @@ static void rcu_free_sheaf(struct rcu_head *head)
 		return;
 	}
 
+flush:
 	stat(s, BARN_PUT_FAIL);
 	sheaf_flush_unused(s, sheaf);
 
 empty:
-	if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
+	if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
 		barn_put_empty_sheaf(barn, sheaf);
 		return;
 	}
@@ -6191,6 +6219,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 		}
 
 		barn = get_barn(s);
+		if (!barn) {
+			local_unlock(&s->cpu_sheaves->lock);
+			goto fail;
+		}
 
 		empty = barn_get_empty_sheaf(barn);
 
@@ -6304,6 +6336,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		goto do_free;
 
 	barn = get_barn(s);
+	if (!barn)
+		goto no_empty;
 
 	if (!pcs->spare) {
 		empty = barn_get_empty_sheaf(barn);
-- 
2.51.0



