Return-Path: <linux-kernel+bounces-809503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD79B50E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5676D7B8BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EF30ACE5;
	Wed, 10 Sep 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="go5DBxfn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrjWjHnm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QViWeyT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wRNwhZZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CF3074AF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486786; cv=none; b=WOySySy6D4j5Nsq/pU75OQaNoOXSnVT8DZdPIs9zD/Gqm2Oq/wAB3/oqIe7tb3aeEPQHzSuGqXybI62FDW9kyYR1ZU6kK/DbaUUcaKjMi7VVcnI2UwAeu3I1Gnyop3Fg45osqmbTHZvIFzEV7eg8rHRpCYuf61quHZcttFmcNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486786; c=relaxed/simple;
	bh=IXEKXwo/Fpo4Y5Ko8Fjc3zC+agZWMQ0630l0oeSY31Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/Awh8KyjHEMScy1NIvDyq74yaTGy/mu4jasEhiSfvzwk68MQi2sJvvEwcMBNVOzNfuD/jvFwprdRHEK9j1yygm1jGpPuTzVKy0lPE1tEtw9v9vAET2w11kbWNQ6fu5l6Yv611c6oB0A1wY6IJOaHVejr96OPIOnWmOeqUtqwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=go5DBxfn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yrjWjHnm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QViWeyT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wRNwhZZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE229336D2;
	Wed, 10 Sep 2025 06:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757486782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0SWlXWK9IoyrtqaxCrVuElAesP0OmdLAfgcptXBJGo=;
	b=go5DBxfnUciK8DNc6Kw+BHvxTCNLZhVXWl769n8CgfPDb3GK/Ly9TKNIKxbz9wsBO2avr/
	nZf/VQkz6XR0Tx3fX0FrESjbiEjAjuUG+XDomkY5V16WITFzdHnJVySLP5RLCsMuMM3YI3
	z4pIuSqkvKyxbR7MJDnoMFzjZgAxcDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757486782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0SWlXWK9IoyrtqaxCrVuElAesP0OmdLAfgcptXBJGo=;
	b=yrjWjHnmXioONkhUoxK4mVQJHjajK+6GUCKK63hqPUxIBYj3LclaSe2gfF8j0izaHqMRgu
	WSM5VEaOj2ThHBCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QViWeyT9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1wRNwhZZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757486781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0SWlXWK9IoyrtqaxCrVuElAesP0OmdLAfgcptXBJGo=;
	b=QViWeyT9DgvWUvcT4QsDQk/0YxRq22xm5Gr2ajBWLnbDlzkbAnrZegT0wixoAw4Pj3gj0k
	3ImmPBEeHbtWsvNaaC2JdlMLMDxy/KHQqT1pl75TlPb8IieTdAMQf+P0I6l9JZGAF2veuZ
	inBTrOyCVEE5499Bxh6UDP/bX2omajw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757486781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p0SWlXWK9IoyrtqaxCrVuElAesP0OmdLAfgcptXBJGo=;
	b=1wRNwhZZBp7geP79OL2o/1+FYiwDMkHHacc2fu7a8KIoIe7PS5zTxGifoghAMR41z0DiOS
	kD+La3IIsPIxcEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5FFB13301;
	Wed, 10 Sep 2025 06:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0jAILL0ewWhrDQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 06:46:21 +0000
Message-ID: <f8127c0c-9de5-4430-ade4-45df78862d28@suse.cz>
Date: Wed, 10 Sep 2025 08:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/slub: Refactor note_cmpxchg_failure for better
 readability
Content-Language: en-US
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, Harry Yoo <harry.yoo@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250909013307.1093853-1-ye.liu@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250909013307.1093853-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EE229336D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/9/25 03:33, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Use IS_ENABLED() and standard if-else to make the code clearer.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>

Thanks, added to slab/for-next

> 
> ---
> Changes in v3:
> - Add "---" in front of the change log.
> Changes in v2:
> - Insert newline after && as it's more than 80 columns.
> ---
>  mm/slub.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..5711d6d29a3f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3064,18 +3064,17 @@ static inline void note_cmpxchg_failure(const char *n,
>  
>  	pr_info("%s %s: cmpxchg redo ", n, s->name);
>  
> -#ifdef CONFIG_PREEMPTION
> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> +	if (IS_ENABLED(CONFIG_PREEMPTION) &&
> +	    tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
>  		pr_warn("due to cpu change %d -> %d\n",
>  			tid_to_cpu(tid), tid_to_cpu(actual_tid));
> -	else
> -#endif
> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
> +	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
>  		pr_warn("due to cpu running other code. Event %ld->%ld\n",
>  			tid_to_event(tid), tid_to_event(actual_tid));
> -	else
> +	} else {
>  		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
>  			actual_tid, tid, next_tid(tid));
> +	}
>  #endif
>  	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
>  }


