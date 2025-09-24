Return-Path: <linux-kernel+bounces-829942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C437B9848E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA8A7B07F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519C236437;
	Wed, 24 Sep 2025 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV0dMrFn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82603153BED
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691677; cv=none; b=Fkbwjxe7bf3+6g+oIV3jdnJnx8Xqb3wbB0CQhy9uTh8CuDDoKgN+DSMi4Szttz3xNdozGYtlHc42aahr0GNkmgt7XCWOBwWSYOhONGib5cid5ZVXdQxB8XMWm1xEL1SsrDKVECctmybvHDmKwmoXM/w3/NCLIir2ux0+W1W9kiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691677; c=relaxed/simple;
	bh=UFjExh43UXaUp/tZZHYT7ARaZowSev2WWH8n7m8z8D8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvK3sbyKJHfKkN/pMdNRzgLjaQHodxl42gsZc6jLvcnZQOypm1wnNyImE37AclLyJcH5V7NtclYyJP6b7pDnXP7tThTUkNUbxZuBp5Y4lrr6yiwoOFc/KVILy2oyscNY1OqCqU73TDK+aMESMHH4bcnwJbjWIGBl68bRbQcRAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EV0dMrFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758691674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Op26YAffBp8tOKfuV5Tcf4HuI3YKE+atQUTpt3Pe7A8=;
	b=EV0dMrFnu3f9XgQkRYL4Tw8fVhfWVPpvd0Oqu8KReOZELGY0qbUA2T1vT1VejYQyqLVzG4
	0LHJGZiF2S3h7mmGk2S3hv6wpjtDsSjBf4Ybq88MTYcVs5BR7TV/OFNfQgJgwdagoyys2n
	A93+wopnCquFRPw3FAjziKmZRYb3aqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-mwBvHzs0PYa1mjDNUr6Fjw-1; Wed, 24 Sep 2025 01:27:52 -0400
X-MC-Unique: mwBvHzs0PYa1mjDNUr6Fjw-1
X-Mimecast-MFC-AGG-ID: mwBvHzs0PYa1mjDNUr6Fjw_1758691671
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3efa77de998so3027637f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758691671; x=1759296471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op26YAffBp8tOKfuV5Tcf4HuI3YKE+atQUTpt3Pe7A8=;
        b=xRwRaNjKx3m7uIxHUXipD7XYvLHew1UfJZckUxKtIQkk24kcOaNDiu4a+uhcYLOlby
         VD2rljXrh7S5JF26cNKLr8oBQSOesuM6KoRC4SDIuD2WA4OFnrwlDQxxPkh3oQ1WpwUw
         x84nGpAbWu9dABkIprB+EWhk8mt0ZVOKeXs2Id345X9QtU7H8QNftfVeS+UMOiqMjMz4
         +8E/2gD6d48PgWbQ7/x3Of9lmg8AmRvD+mrI+5KnteLTo3m8GDO+1anh1E96OaS+oUMW
         4OrUCIzxzhdmzR+21oxAiIHQWmYlCaKioGxnoETgKxr1g2b9DnHJmAGBMqnHXiF58aRX
         8upg==
X-Gm-Message-State: AOJu0Yyx+OQszB3pW+sMg8Uf4U4mpWZzVomEQ8h2AVmDZE+xm0+GeV98
	93/Xc1L6JHtKyMaX4iPQJvxgzH+kYdScaV1wXej4e1xp0W2MHdjrS5Wc9C1C1wTt1A3kGHV23Lo
	OZbkaU26bULbwEMqlF4xQH1pskWKe/SD04VLJOj4kT+D2bc9Ga4tLMvh8+GhVNgwdY234IUXJ3/
	qom/8u+KV9wiEZY+x/Ud/aVC93Ux30vDnBoDAT+yWRPOM=
X-Gm-Gg: ASbGncvmG9DUaMOFT8NX9JDPHWjQqArTMn+X7dz9XEivnRPFwDxLT33i5mOVQ8+EhcD
	dcYvwgc8v6DpWh9HVWuWlhPUFQueEltvRxAT8TTJkJw6VQ4m416+ptPvEO2VHWyrUuVb1q5knk9
	rV7Ngbsy8EnXipoCvMybFtsdIsr5A/mvAxJwCW/No2C9h6tbb7HdY9ZbvS4NpwdnytpPPXF3KAl
	UmhrrI1oDrJdgEZZjT2ooRM21QG8L0RlxAvEtuHtFyRHYKcRQF7b84s/H3a/FTrEVJYvyxJQaoa
	exa6gEdTlIr6+PJecFWmn3DrHa70/9I0Vuo=
X-Received: by 2002:a05:6000:2304:b0:3ee:1357:e18f with SMTP id ffacd0b85a97d-405c49a252amr4041719f8f.12.1758691670975;
        Tue, 23 Sep 2025 22:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+yFqhaqoFopq7rZf8kR+Ni9QC+PbuNvIk77bkhBjbuNAj+k34PkCijOGnyeAujdQIjd3OOA==
X-Received: by 2002:a05:6000:2304:b0:3ee:1357:e18f with SMTP id ffacd0b85a97d-405c49a252amr4041699f8f.12.1758691670369;
        Tue, 23 Sep 2025 22:27:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm28457392f8f.55.2025.09.23.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:27:49 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
Message-ID: <20250924012728-mutt-send-email-mst@kernel.org>
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>

On Wed, Sep 24, 2025 at 01:27:09AM -0400, Michael S. Tsirkin wrote:
> We have some rather subtle code around zeroing tail entries, minimizing
> cache bouncing.  Let's put it all in one place.
> 
> Doing this also reduces the text size slightly, e.g. for
> drivers/vhost/net.o
>   Before: text: 15,114 bytes
>   After: text: 15,082 bytes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Ugh net-next obviously. Sorry.


> ---
> 
> Lightly tested.
> 
>  include/linux/ptr_ring.h | 42 +++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 551329220e4f..a736b16859a6 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -243,6 +243,24 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/* Zero entries from tail to specified head.
> + * NB: if consumer_head can be >= r->size need to fixup tail later.
> + */
> +static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
> +{
> +	int head = consumer_head - 1;
> +
> +	/* Zero out entries in the reverse order: this way we touch the
> +	 * cache line that producer might currently be reading the last;
> +	 * producer won't make progress and touch other cache lines
> +	 * besides the first one until we write out all entries.
> +	 */
> +	while (likely(head >= r->consumer_tail))
> +		r->queue[head--] = NULL;
> +
> +	r->consumer_tail = consumer_head;
> +}
> +
>  /* Must only be called after __ptr_ring_peek returned !NULL */
>  static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  {
> @@ -261,8 +279,7 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
>  	 * to work correctly.
>  	 */
> -	int consumer_head = r->consumer_head;
> -	int head = consumer_head++;
> +	int consumer_head = r->consumer_head + 1;
>  
>  	/* Once we have processed enough entries invalidate them in
>  	 * the ring all at once so producer can reuse their space in the ring.
> @@ -270,16 +287,9 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	 * but helps keep the implementation simple.
>  	 */
>  	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
> -		     consumer_head >= r->size)) {
> -		/* Zero out entries in the reverse order: this way we touch the
> -		 * cache line that producer might currently be reading the last;
> -		 * producer won't make progress and touch other cache lines
> -		 * besides the first one until we write out all entries.
> -		 */
> -		while (likely(head >= r->consumer_tail))
> -			r->queue[head--] = NULL;
> -		r->consumer_tail = consumer_head;
> -	}
> +		     consumer_head >= r->size))
> +		__ptr_ring_zero_tail(r, consumer_head);
> +
>  	if (unlikely(consumer_head >= r->size)) {
>  		consumer_head = 0;
>  		r->consumer_tail = 0;
> @@ -513,7 +523,6 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
>  				      void (*destroy)(void *))
>  {
>  	unsigned long flags;
> -	int head;
>  
>  	spin_lock_irqsave(&r->consumer_lock, flags);
>  	spin_lock(&r->producer_lock);
> @@ -525,17 +534,14 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
>  	 * Clean out buffered entries (for simplicity). This way following code
>  	 * can test entries for NULL and if not assume they are valid.
>  	 */
> -	head = r->consumer_head - 1;
> -	while (likely(head >= r->consumer_tail))
> -		r->queue[head--] = NULL;
> -	r->consumer_tail = r->consumer_head;
> +	__ptr_ring_zero_tail(r, r->consumer_head);
>  
>  	/*
>  	 * Go over entries in batch, start moving head back and copy entries.
>  	 * Stop when we run into previously unconsumed entries.
>  	 */
>  	while (n) {
> -		head = r->consumer_head - 1;
> +		int head = r->consumer_head - 1;
>  		if (head < 0)
>  			head = r->size - 1;
>  		if (r->queue[head]) {
> -- 
> MST


