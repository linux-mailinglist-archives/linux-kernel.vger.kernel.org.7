Return-Path: <linux-kernel+bounces-758929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C03B1D5C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D37ACD05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455E260592;
	Thu,  7 Aug 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YDc+KMLp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fr070QO1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YDc+KMLp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fr070QO1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE423D281
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562351; cv=none; b=Wy6wUrjF0IKgJ0CjkIV9b95VMYKLEEO8yZlGQVmjbsWHlaM77/zT5cFAZ6S781J0/Mu9KJZT+nbxvqrtNzY/+fSXHsSOr5T55JwvaAJGfVtlm3yb4yc20MstFiawAuPQL0niV7UZfh848ELN/yHmbEEK/jplwWif/dPSRonGdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562351; c=relaxed/simple;
	bh=Los14N1lZpnxneFo2KPJ9mh+B/nQbkeGnrvYl7rPD2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ug8mn0wAdMeUX1Douc0xXzLeS2+Agy42cN3J0El670bH9b9I8GmtapOl1VQCZzbdyHCPqRVfADezOfDJwWxTSjoIKTY00lK0IEkpTuSM/Iuu4PpUQOm5bL0vlzF/bZD59EytuYE2vgCod4gY1LGJQEoTxDYSHXLufWcVqOlQIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YDc+KMLp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fr070QO1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YDc+KMLp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fr070QO1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8619633CD1;
	Thu,  7 Aug 2025 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754562341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y+3VvCsoxNp5my7hzH07+UXcTWds5y41HFvpaJwE24c=;
	b=YDc+KMLpPBukUqO/26f+re2k1QlkiUyoesR8sfdj3FWt0HVH8LY/6QN3TEVcSz5aRrPuPO
	cMyIjrQJTZCUqhZ6329yrhyKk8Hi/2nxsAHNJIU5xR02b4yU9YUJa1ob/ONroBFjzqOdx2
	Wvlf1gmObFO5Gj6jWhPzmXKHJWn+AJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754562341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y+3VvCsoxNp5my7hzH07+UXcTWds5y41HFvpaJwE24c=;
	b=Fr070QO1dbYv5zCv6Ftd93YOCXKzUcpI1Ae6H7UBLS3c+3+bHUb00KR//Dud6TIF4BlMX6
	aYn1nNnEgYmLmLCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YDc+KMLp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fr070QO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754562341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y+3VvCsoxNp5my7hzH07+UXcTWds5y41HFvpaJwE24c=;
	b=YDc+KMLpPBukUqO/26f+re2k1QlkiUyoesR8sfdj3FWt0HVH8LY/6QN3TEVcSz5aRrPuPO
	cMyIjrQJTZCUqhZ6329yrhyKk8Hi/2nxsAHNJIU5xR02b4yU9YUJa1ob/ONroBFjzqOdx2
	Wvlf1gmObFO5Gj6jWhPzmXKHJWn+AJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754562341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y+3VvCsoxNp5my7hzH07+UXcTWds5y41HFvpaJwE24c=;
	b=Fr070QO1dbYv5zCv6Ftd93YOCXKzUcpI1Ae6H7UBLS3c+3+bHUb00KR//Dud6TIF4BlMX6
	aYn1nNnEgYmLmLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C1A5136DC;
	Thu,  7 Aug 2025 10:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id paqRFSV/lGikTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 07 Aug 2025 10:25:41 +0000
Message-ID: <0668d246-ccbb-4a74-96d8-c13bf180053f@suse.cz>
Date: Thu, 7 Aug 2025 12:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
Content-Language: en-US
To: Li Qiang <liqiang01@kylinos.cn>, akpm@linux-foundation.org,
 david@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, Nadav Amit <nadav.amit@gmail.com>
References: <9d60bae4-a61b-4d4a-a0a8-19058df30b0f@lucifer.local>
 <20250806055111.1519608-1-liqiang01@kylinos.cn>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250806055111.1519608-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8619633CD1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,oracle.com,kernel.org,google.com,suse.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 8/6/25 07:51, Li Qiang wrote:
> Tue, 5 Aug 2025 14:35:22, Lorenzo Stoakes wrote:
>> I'm not sure, actual workloads would be best but presumably you don't have
>> one where you've noticed a demonstrable difference otherwise you'd have
>> mentioned...
>> 
>> At any rate I've come around on this series, and think this is probably
>> reasonable, but I would like to see what increasing max-inline-insns-single
>> does first?
> 
> Thank you for your suggestions. I'll pay closer attention 
> to email formatting in future communications.
> 
> Regarding the performance tests on x86_64 architecture:
> 
> Parameter Observation:
> When setting max-inline-insns-single=400 (matching arm64's 
> default value) without applying my patch, the compiler 
> automatically inlines the critical functions.
> 
> Benchmark Results:
> 
> Configuration			Baseline		With Patch			max-inline-insns-single=400
> UnixBench Score			1824			1835 (+0.6%)			1840 (+0.9%)
> vmlinux Size (bytes)	35,379,608		35,379,786 (+0.005%)	35,529,641 (+0.4%)
> 
> Key Findings:
> 
> The patch provides significant performance gain (0.6%) with 
> minimal size impact (0.005% increase). While 
> max-inline-insns-single=400 yields slightly better 
> performance (0.9%), it incurs a larger size penalty (0.4% increase).
> 
> Conclusion:
> The patch achieves a better performance/size trade-off 
> compared to globally adjusting the inline threshold. The targeted 
> approach (selective __always_inline) appears more efficient for 
> this specific optimization.

Another attempt at my opensuse tumbleweed system gcc 15.1.1:

add/remove: 1/0 grow/shrink: 4/7 up/down: 1069/-520 (549)
Function                                     old     new   delta
unmap_page_range                            6493    7424    +931
add_mm_counter                                 -     112    +112
finish_fault                                1101    1117     +16
do_swap_page                                6523    6531      +8
remap_pfn_range_internal                    1358    1360      +2
pte_to_swp_entry                             123     122      -1
pte_move_swp_offset                          219     218      -1
restore_exclusive_pte                        356     325     -31
__handle_mm_fault                           3988    3949     -39
do_wp_page                                  3926    3810    -116
copy_page_range                             8051    7930    -121
swap_pte_batch                               817     606    -211
Total: Before=66483, After=67032, chg +0.83%

The functions changed by your patch were already inlined, and yet this force
inlining apparently changed some heuristics to change also completely
unrelated functions.

So that just shows how fragile these kinds of attempts to hand-hold gcc for
a specific desired behavior is, and I'd be wary of it.

