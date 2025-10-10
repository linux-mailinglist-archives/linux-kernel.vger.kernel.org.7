Return-Path: <linux-kernel+bounces-848644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E8BCE3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCBC19A7D36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2752FD1D7;
	Fri, 10 Oct 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UK3qpMe0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="94IGIneb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UK3qpMe0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="94IGIneb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975322FE591
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120893; cv=none; b=j0+czgpptftguapxOsLd6lqsnnMRfKBulWVuJ1fgw64SYC0FBB+wbWtIXm/Up1hsN2vhFkK7Lc7MODvaG9XVmP40WNcj0SuSPSk/2hTxJtzgoSCznXYNZGLN9/TWyozJqvPTrPC4FARhpBIGbnf8owZM8MtO3SVBNFncEGYC9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120893; c=relaxed/simple;
	bh=JfJNniXdOCvJRlHf+hVhrPhEahD7TGAZFhtG7dtNJz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIVMQCq2l1gSJHL+I+U6PQBbyALp8T+PQDd+FLT9xQ6vy9XPyHvupto8O8US+xLHO0M6KDDhKHK/vfznc448uA6SGW8PdYiwX5E7dXmnM5eb/yZhX5WXmdpD//MDXvu4lFSE/puy9hkqlk3VCWKKlRzNP368fw5YeIkoBfJC9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UK3qpMe0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=94IGIneb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UK3qpMe0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=94IGIneb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BA5A2119C;
	Fri, 10 Oct 2025 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760120851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CueUJ6XmXbiW/zHe2/YUqtwlamQZpKhUrxeZQ2bug14=;
	b=UK3qpMe0aAexXWOcL/OYi8peoGsO/EdJSRuU7LpZLz5xI24FVra98yOQoSbRSN/WWfuJiX
	UbItqwHPf+eVDygJ8MHDwDep2tbVuoZt7lNnQJ/zP6ifLZlbSKyEn85kcnHLjsRL2mNN/1
	+54ViubzkDXyQk/JjHitiW8SKHWm65g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760120851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CueUJ6XmXbiW/zHe2/YUqtwlamQZpKhUrxeZQ2bug14=;
	b=94IGInebxch6UTzrFp69mub6FlTByZkla5PR6MoFFM4VCrzPQV1Jz3Gv85bbz4r2c4JqyC
	I/z7d10X+JofVpCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760120851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CueUJ6XmXbiW/zHe2/YUqtwlamQZpKhUrxeZQ2bug14=;
	b=UK3qpMe0aAexXWOcL/OYi8peoGsO/EdJSRuU7LpZLz5xI24FVra98yOQoSbRSN/WWfuJiX
	UbItqwHPf+eVDygJ8MHDwDep2tbVuoZt7lNnQJ/zP6ifLZlbSKyEn85kcnHLjsRL2mNN/1
	+54ViubzkDXyQk/JjHitiW8SKHWm65g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760120851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CueUJ6XmXbiW/zHe2/YUqtwlamQZpKhUrxeZQ2bug14=;
	b=94IGInebxch6UTzrFp69mub6FlTByZkla5PR6MoFFM4VCrzPQV1Jz3Gv85bbz4r2c4JqyC
	I/z7d10X+JofVpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F07BE1375D;
	Fri, 10 Oct 2025 18:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLxeOhJQ6Wj5dAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 10 Oct 2025 18:27:30 +0000
Message-ID: <e4f2a3e3-649a-423b-9696-6406ef56340f@suse.cz>
Date: Fri, 10 Oct 2025 20:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Boot fails with 59faa4da7cd4 and 3accabda4da1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Phil Auld <pauld@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20251010151116.GA436967@pauld.westford.csb>
 <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/10/25 20:19, Linus Torvalds wrote:
> On Fri, 10 Oct 2025 at 08:11, Phil Auld <pauld@redhat.com> wrote:
>>
>> After several days of failed boots I've gotten it down to these two
>> commits.
>>
>> 59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
>> 3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache
>>
>> The first is such an early failure it's silent. With just 3acca I
>> get :
>>
>> [    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
>> [    9.348115] #PF: supervisor read access in kernel mode
>> [    9.353264] #PF: error_code(0x0000) - not-present page
>> [    9.358413] PGD 0 P4D 0
>> [    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
>> [    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
>> [    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
>> [    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
>> [    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
> 
> That decodes to
> 
>    0:           mov    0x10(%rsi),%rax
>    4:           mov    0x8(%rsi),%rsi
>    8:           test   %rax,%rax
>    b:           je     0x18
>    d:           mov    0x18(%rax),%ecx
>   10:           test   %ecx,%ecx
>   12:           jne    0xfd
>   18:           movslq %gs:0x250eee4(%rip),%rax
>   20:           mov    0xe0(%r14,%rax,8),%rax
>   28:*          mov    0x40(%rax),%r13          <-- trapping instruction
>   2c:           mov    %r13,%rdi
>   2f:           call   0xffffffffffff81e4
>   34:           mov    %rax,%rbp
>   37:           test   %rax,%rax
>   3a:           je     0x59
> 
> which is the code around that barn_replace_empty_sheaf() call.
> 
> In particular, the trapping instruction is from get_barn(), it's the "->barn" in
> 
>         return get_node(s, numa_mem_id())->barn;
> 
> so it looks like 'get_node()' is returning NULL here:
> 
>         return s->node[node];
> 
> That 0x250eee4(%rip) is from "get_node()" becoming
> 
>   18:           movslq  %gs:numa_node(%rip), %rax  # node
>   20:           mov    0xe0(%r14,%rax,8),%rax # ->node[node]
> 
> instruction, and then that ->barn dereference is the trapping
> instruction that tries to read node->barn:
> 
>   28:*          mov    0x40(%rax),%r13   # node->barn
> 
> but I did *not* look into why s->node[node] would be NULL.
> 
> Over to you Vlastimil,

Thanks, yeah will look ASAP. I suspect the "nodes with zero memory" is
something that might not be handled well in general on x86. I know powerpc
used to do these kind of setups first and they have some special handling,
so numa_mem_id() would give you the closest node with memory in there and I
suspect it's not happening here. CPU 21 is node 6 so it's one of those
without memory. I'll see if I can simulate this with QEMU and what's the
most sensible fix

>             Linus


