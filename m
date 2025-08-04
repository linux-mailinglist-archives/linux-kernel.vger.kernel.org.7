Return-Path: <linux-kernel+bounces-755339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB03B1A51F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E23A8203
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C59272E72;
	Mon,  4 Aug 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJGG7w14";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezTgJs7E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJGG7w14";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezTgJs7E"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3642701DA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318507; cv=none; b=RWl8y30fQQC3rCCd0KnJb8/ZebxeypLT61xhBODbeucKQ8EtBkzaw3Ftc5Mi+49rzrAyEC7d56Y96uP/wpWlECUFgN49ySSV2k35ynnU+nDY1vtSIbPZgduVG49etoizIQA2oWH4DloUFz4akeiNyLFiMYq+CllOFCVt80xC9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318507; c=relaxed/simple;
	bh=hD5sQ9IlCXhP4LbbOg4OezEonv19OqthhI5c8TZD6wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAnqdilKkU8YCFFQdkb+E0cRstwdy7i+6P7VyFA17N4Cw/gFZkdODXoyTMaLc34D4McjxP8c4idKZ7TG6u+ZX7YDyRwM5jPdqYDteJNi4awihBJ6dKuak0cWC/0e1uPeLmPHxk4s5QppBNMkM2yREXslej0pQOKhb94ou+yzHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJGG7w14; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ezTgJs7E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJGG7w14; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ezTgJs7E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9104521BC9;
	Mon,  4 Aug 2025 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754318502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h0vqtEeN81u265nhnk/fwouCOEfWX9zFBh1zKn1thl8=;
	b=GJGG7w14XBLpoAdBIXg4C5S8jEeieMRCsRgWX0S9r/ZPyb1vX1DQvUY3M1p79TGGfiD3gb
	19Hk1DmX6n7odWygvK86hpb+gXIColSB6mW/9QcRBe6dB1OYGHE0fYb+voeRfMbkGahiSi
	oUU9TQ0NEzE0LQG3J6QypivkY+W2oDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754318502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h0vqtEeN81u265nhnk/fwouCOEfWX9zFBh1zKn1thl8=;
	b=ezTgJs7EBlcMjlcbMvhDkTW09KQ4aRcFANct7H58tags1icpiAAFvZ8GldDYq6fG85QRR8
	kltSeLCnzJUTkvAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754318502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h0vqtEeN81u265nhnk/fwouCOEfWX9zFBh1zKn1thl8=;
	b=GJGG7w14XBLpoAdBIXg4C5S8jEeieMRCsRgWX0S9r/ZPyb1vX1DQvUY3M1p79TGGfiD3gb
	19Hk1DmX6n7odWygvK86hpb+gXIColSB6mW/9QcRBe6dB1OYGHE0fYb+voeRfMbkGahiSi
	oUU9TQ0NEzE0LQG3J6QypivkY+W2oDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754318502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h0vqtEeN81u265nhnk/fwouCOEfWX9zFBh1zKn1thl8=;
	b=ezTgJs7EBlcMjlcbMvhDkTW09KQ4aRcFANct7H58tags1icpiAAFvZ8GldDYq6fG85QRR8
	kltSeLCnzJUTkvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0A2133D1;
	Mon,  4 Aug 2025 14:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 12kHGqbGkGgKZwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 04 Aug 2025 14:41:42 +0000
Message-ID: <805fb8a3-6f95-4f20-b5da-87dc3b1e3b60@suse.cz>
Date: Mon, 4 Aug 2025 16:41:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Li Qiang <liqiang01@kylinos.cn>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com
References: <20250804123923.296230-1-liqiang01@kylinos.cn>
 <ab22e314-63d1-46cf-a54c-b2af8db4d97a@lucifer.local>
 <2a1b7ebc-f27c-444e-be89-df14ac1dc97d@lucifer.local>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <2a1b7ebc-f27c-444e-be89-df14ac1dc97d@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
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
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/4/25 15:59, Lorenzo Stoakes wrote:
> OK,
> 
> So I hacked -fopt-info-inline-all into the mm/ Makefile in a rather quick and
> dirty way and it seems some stuff gets inlined locally, but we're mostly hitting
> the '--param max-inline-insns-single limit reached' limit here.
> 
> Which maybe is just a point where the compiler possibly arbitrarily gives up?
> 
> Vlasta rightly pointed out off-list that given this appears to only be used in
> one place you'd expect inlining as register spill isn't such a concern (we'll
> spill saving the stack before function invocation anyway).
> 
> So there might actually be some validity here?
> 
> This is gcc 15.1.1 running on an x86-64 platform by the way.
> 
> mm/memory.c:1871:10: optimized:  Inlined zap_p4d_range/6380 into unmap_page_range/6381 which now has time 1458.996712 and size 65, net change of -11.
> mm/memory.c:1850:10: optimized:  Inlined zap_pud_range.isra/8017 into zap_p4d_range/6380 which now has time 10725.428482 and size 29, net change of -12.
> mm/memory.c:1829:10: missed:   not inlinable: zap_pud_range.isra/8017 -> zap_pmd_range.isra/8018, --param max-inline-insns-single limit reached
> mm/memory.c:1800:10: missed:   not inlinable: zap_pmd_range.isra/8018 -> zap_pte_range/6377, --param max-inline-insns-auto limit reached
> mm/memory.c:1708:8: optimized:  Inlined do_zap_pte_range.constprop/7983 into zap_pte_range/6377 which now has time 4244.320854 and size 148, net change of -15.
> mm/memory.c:1664:9: missed:   not inlinable: do_zap_pte_range.constprop/7983 -> zap_present_ptes.constprop/7985, --param max-inline-insns-single limit reached

I got some weird bloat-o-meter on this patch:

add/remove: 1/0 grow/shrink: 2/2 up/down: 693/-31 (662)
Function                                     old     new   delta
__handle_mm_fault                           3817    4403    +586
do_swap_page                                4497    4560     +63
mksaveddirty_shift                             -      44     +44
unmap_page_range                            4843    4828     -15
copy_page_range                             6497    6481     -16

but even without this patch, "objdump -t mm/memory.o" shows no zap
functions, so they are already inlined?

gcc also 15.1.1 but maybe opensuse has some non-default tunings.

