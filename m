Return-Path: <linux-kernel+bounces-892614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94601C45747
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40C384E6494
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603262F8BCD;
	Mon, 10 Nov 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HeaEcVZW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BMX9bJVA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dh0EguRo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1w9JFlP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C2A926
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764821; cv=none; b=F4OypmqAVAqKiJ9pfVx2+5axZH8fc26vBPcOQWxmRPTqibifCa7MsTqIXxZe7nS22PGfmbpOXQLlIvLesEKXqOV6MhZiI08Ii4G1/bnTWPpFDXQOZtpo2ipCkvAHwefG490FYHI3kOYg3h+mv7Q/XrJ2j7BJA1Bet3/eXTwx4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764821; c=relaxed/simple;
	bh=qVlWnzS1xtUhlVDQs3YpszWCpu1gtxDAeMRpRXWs1GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6LxSaVeT0IBaEItbKWE5/HQAYJV+hcbGtRF//+qWZpaQYRZDXGUZvi6j0vdrOZlmQfLhCn9wW7icPEhcY2kygQDK46GLTjFi1NYh0wDzN3Zg2pdzqUscBOIvrSF7Jn2+5yGWSE+/WJ6zNxB/Le04dzJ0xeddRoRtS90A6R0Zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HeaEcVZW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BMX9bJVA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dh0EguRo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1w9JFlP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8E9F1F399;
	Mon, 10 Nov 2025 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762764818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhVGXXl82HA74C7MBfa4J8WEYKtUPGSE84qDiektqPs=;
	b=HeaEcVZWPmhyP07OZdkA1LCc8+GyEblamiy30/X92AvCU37Qdi5HjumXVJw1tzqA5y1khK
	4UrRmuFiZAlvSdpxL3oZLWzYAGJGBm3TyX2BY5Kq1TN2AWxk4KZCci4aIbo00VzAeSqlb5
	Dz+4yiEmAp76qmwJJZFLTOoC6XuFDcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762764818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhVGXXl82HA74C7MBfa4J8WEYKtUPGSE84qDiektqPs=;
	b=BMX9bJVAXlf80cwNa2Me8Y8oIGZkVGa375flp5UMmdp28uPmX4OOQtc6fFpGlW4L20DXT5
	BM+rPP2YTkGh6fCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dh0EguRo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S1w9JFlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762764817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhVGXXl82HA74C7MBfa4J8WEYKtUPGSE84qDiektqPs=;
	b=Dh0EguRoSSDR9MGAZeI2PxlGkax2JYYakxzunVGBJh2OsvD5KpaJ9NDLLswvkJJ9UyvlR5
	7u+9P+lKUfncy2QJwHSy4lcnnA5oQofh76KpmiRpAlMPlvhnA8+jENRsO2Ahg81HlF4InQ
	VQ5Mz0TE0gSAGQU/owSzPqwR3r0Nfgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762764817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhVGXXl82HA74C7MBfa4J8WEYKtUPGSE84qDiektqPs=;
	b=S1w9JFlPp6jK++XeYlLt4YGq4rDiDKZeSsNb4DyUfRkwNG6Fz2NBXLQ13XLMirNna82yeL
	toDE9K8GdZxDv6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADB5013BCB;
	Mon, 10 Nov 2025 08:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2oJ+KBGoEWlFRwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Nov 2025 08:53:37 +0000
Message-ID: <cff1f137-06dd-4045-942a-b5e56a63f47d@suse.cz>
Date: Mon, 10 Nov 2025 09:53:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vmstat: correct the comment above
 preempt_disable_nested()
Content-Language: en-US
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, harry.yoo@oracle.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20251110084437.46701-1-qi.zheng@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251110084437.46701-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D8E9F1F399
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

On 11/10/25 09:44, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The comment explaining why these parts use preempt_disable_nested() is in
> __mod_zone_page_state(), not in __mod_node_page_state(), so we should see
> __mod_zone_page_state(). Just correct it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmstat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b53b07aa29e81..65de88cdf40e6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -392,7 +392,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  		delta >>= PAGE_SHIFT;
>  	}
>  
> -	/* See __mod_node_page_state */
> +	/* See __mod_zone_page_state() */
>  	preempt_disable_nested();
>  
>  	x = delta + __this_cpu_read(*p);
> @@ -438,7 +438,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
>  	s8 __percpu *p = pcp->vm_stat_diff + item;
>  	s8 v, t;
>  
> -	/* See __mod_node_page_state */
> +	/* See __mod_zone_page_state() */
>  	preempt_disable_nested();
>  
>  	v = __this_cpu_inc_return(*p);
> @@ -461,7 +461,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  
>  	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
>  
> -	/* See __mod_node_page_state */
> +	/* See __mod_zone_page_state() */
>  	preempt_disable_nested();
>  
>  	v = __this_cpu_inc_return(*p);
> @@ -494,7 +494,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
>  	s8 __percpu *p = pcp->vm_stat_diff + item;
>  	s8 v, t;
>  
> -	/* See __mod_node_page_state */
> +	/* See __mod_zone_page_state() */
>  	preempt_disable_nested();
>  
>  	v = __this_cpu_dec_return(*p);
> @@ -517,7 +517,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
>  
>  	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
>  
> -	/* See __mod_node_page_state */
> +	/* See __mod_zone_page_state() */
>  	preempt_disable_nested();
>  
>  	v = __this_cpu_dec_return(*p);


