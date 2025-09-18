Return-Path: <linux-kernel+bounces-784830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0AB3422C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B1416B2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12523D7CB;
	Mon, 25 Aug 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMQTpjUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nK8fbP6x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMQTpjUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nK8fbP6x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FF1DB54C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129637; cv=none; b=t5vyOM4panjvPvEnq2aBup0Wmw4jGQl69QPsIEe8B3g/vlA95WaMAI6Uu7gTpmenRRwIwLiqkY1D/1L31Uy7SPBsFaiCpb0RPUxTSjWeEsXnPoDC957832MU6zYtDiCeN0ghFf/+lkQBzRIWKpO7jT8tvQIdfaQ+i+47hirp3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129637; c=relaxed/simple;
	bh=p/s/yaJFoADfL/908Wm15liizTg55SB+APvBt+WV0oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWHyYKrUirPZUisgnw01h+iHEhaGkzKiYUKoq0bts//KRsDbBR2JmSDlB2UgP3C+CpZ6qAMbcJzyNb+X3lmbXgfsf+CqiRKvy326G0KLWy11QqFm0Qk9OnbDbuqnYcz9DWMUP/WDi6CjCAhqzoYl6bnPrwJlKVzQgN4ZVDUVFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMQTpjUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nK8fbP6x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMQTpjUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nK8fbP6x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 340071F792;
	Mon, 25 Aug 2025 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756129632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GlwXmq6kbIWIColIFVeW2+LyxHSdo8BUYgwpSLJsOE=;
	b=ZMQTpjUBWKxSxljjSDMmMkazWnWsCPK2VOyVp0Dky25NVF4tY+QNDlXzayd++5aghl7Krt
	MHp/QlFqp09Y5Sbur4hEKis/ltC3uOSMxhapefBosnAycmT1HQRuonPuHtk03ZcHFWyH2D
	bqqSdGvlQW5dbOKlHl7uE+S5WoTTrwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756129632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GlwXmq6kbIWIColIFVeW2+LyxHSdo8BUYgwpSLJsOE=;
	b=nK8fbP6x2CUvXEJZrBQ7qF7hfZHU4s9rlpfmqjdhvbL8A5NlVXfzOrzMw+spE9QZKCz6Na
	y7ZFI3WAYYvwgdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756129632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GlwXmq6kbIWIColIFVeW2+LyxHSdo8BUYgwpSLJsOE=;
	b=ZMQTpjUBWKxSxljjSDMmMkazWnWsCPK2VOyVp0Dky25NVF4tY+QNDlXzayd++5aghl7Krt
	MHp/QlFqp09Y5Sbur4hEKis/ltC3uOSMxhapefBosnAycmT1HQRuonPuHtk03ZcHFWyH2D
	bqqSdGvlQW5dbOKlHl7uE+S5WoTTrwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756129632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GlwXmq6kbIWIColIFVeW2+LyxHSdo8BUYgwpSLJsOE=;
	b=nK8fbP6x2CUvXEJZrBQ7qF7hfZHU4s9rlpfmqjdhvbL8A5NlVXfzOrzMw+spE9QZKCz6Na
	y7ZFI3WAYYvwgdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142541368F;
	Mon, 25 Aug 2025 13:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bpyKBGBprGiRKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Aug 2025 13:47:12 +0000
Message-ID: <d64a369e-c0e1-4dd1-b032-660f467914a6@suse.cz>
Date: Mon, 25 Aug 2025 15:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: rename struct mempool_s to struct mempool
To: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
Cc: cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250812083105.371295-1-hch@lst.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250812083105.371295-1-hch@lst.de>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/12/25 10:30, Christoph Hellwig wrote:
> Drop the pointless _s prefix and align to the usual struct naming to
> prepare for actually using the struct instead of the typedef so that
> random headers don't need to include mempool.h for just having a
> pointer to the mempool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/blkdev.h  | 2 +-
>  include/linux/mempool.h | 2 +-
>  include/linux/netfs.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 95886b404b16..c3f3ec5bb864 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -199,7 +199,7 @@ struct gendisk {
>  	unsigned int		zone_wplugs_hash_bits;
>  	atomic_t		nr_zone_wplugs;
>  	spinlock_t		zone_wplugs_lock;
> -	struct mempool_s	*zone_wplugs_pool;
> +	struct mempool		*zone_wplugs_pool;
>  	struct hlist_head	*zone_wplugs_hash;
>  	struct workqueue_struct *zone_wplugs_wq;
>  #endif /* CONFIG_BLK_DEV_ZONED */
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index 7b151441341b..34941a4b9026 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -15,7 +15,7 @@ struct kmem_cache;
>  typedef void * (mempool_alloc_t)(gfp_t gfp_mask, void *pool_data);
>  typedef void (mempool_free_t)(void *element, void *pool_data);
>  
> -typedef struct mempool_s {
> +typedef struct mempool {
>  	spinlock_t lock;
>  	int min_nr;		/* nr of elements at *elements */
>  	int curr_nr;		/* Current nr of elements at *elements */
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 185bd8196503..270ed0822efa 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -21,7 +21,7 @@
>  #include <linux/rolling_buffer.h>
>  
>  enum netfs_sreq_ref_trace;
> -typedef struct mempool_s mempool_t;
> +typedef struct mempool mempool_t;
>  struct folio_queue;
>  
>  /**


