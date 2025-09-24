Return-Path: <linux-kernel+bounces-830009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D9B98719
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774F12A6B59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8662594B7;
	Wed, 24 Sep 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0uNQ9Qz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C80257831
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696945; cv=none; b=ZcJ4/nWCkzBufQZbzvpKfzuLFswQ6H7FodI1ECRn7/tptOPT9KziXJNnEqWwLUI4lE7dP2yFO58yUFjWfg0rNieTMLqzRYxl/4Ujeb6+97QKhxkmPv7iy2gksTwzkI2x3M3QD/Gv4XBgGA6SMVgSN3GQpn/5MTOciovh7EIzRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696945; c=relaxed/simple;
	bh=IYyT2OvtNRU8mKssTIxBwKkXN9e3ywY0bC2fvBkYVDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbaXiySqHfKpQabbYV00AC6v66fKA3vLpx7YmDZDvmbM0iTGy2MsJeiNUQ/fbNWh/T0J1xvvLRdNw6k5G6+F4zDpSaQaVsYghDRzFfdXQa8Z6JTAQ96RKmWpvJNckkLV3iNf4UsSCmR9VNhjPRuSD3cXrPm3dzGxe+7nq11A6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0uNQ9Qz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758696942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
	b=Z0uNQ9QzwbiKczodG2ncIYEfkzHPU36ugWv8gFGiVizdv1AinXqzVHEiz0zKz5vmH6bTbc
	zW9+c0JMbHwixkL7fjFkTyi3IAgeyaT36oT91qD5GffNUiMeAEiVKguNwyn6zzOAy7XZ3z
	jL/6w1Rds3iwoB1uDRKMDCx0P7o+3S8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-7Pq6XuC1MI-lZHLpQS3v9g-1; Wed, 24 Sep 2025 02:55:33 -0400
X-MC-Unique: 7Pq6XuC1MI-lZHLpQS3v9g-1
X-Mimecast-MFC-AGG-ID: 7Pq6XuC1MI-lZHLpQS3v9g_1758696933
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4612d068c47so44638355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696932; x=1759301732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
        b=dc4pw2tAl7KQEjyWEwdrFCAzJ1CNLmx+VuleOD8V0LxNcMV93I5w9gRuIj6/WK1V0f
         cgWkXwXay9J2P9AlUkhAGGUpcK1YY2VJdeSCmlFbzRZl/JXzrmoXeWMAkJjpm2gE85K9
         PZ+QcjYxvBwT7kpSttitSnfzfUmnAq+e7Vl4HkfZTpyZnaatVO47s0QMB7u4dy7sWsNs
         okmzqu0z031IrTRxM1Z5kKYXIJN2zRkJt1H0pID2AHG/XJBgwIc1qL5tq0PURzQ3e9a+
         YfLnqxgA4xT1KzYVwzOPnvKPgJEYh4goIthGKPGB00h65y7j1NNXdSLAaHY2VW5X0T0T
         8Xbw==
X-Forwarded-Encrypted: i=1; AJvYcCXHTkFcn28BwocOjg0vythpjT8u2k0ouCpALQtbhJlHMrjpkIdQtbINBir63hTdm5+G1jRfCUcFnRKoFxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqeYHC3watJfw8h7P/n/0+DszJVOvoNlF5byd3bknrK3I2PoW
	R0CCvaIRq3h1AYh6y1R+h0R9DTo9+xoSlh+hiZ8juSdcuppJW/9tUhIqOP5EF19xkH+fco/kAbT
	eVv4U3FUIksHeqPYaoTnRU9iQ5uUiabAbs/B6zR3z8wFUzn8yephXFlwvuj+J806eeQ==
X-Gm-Gg: ASbGnct7vaDa8JPrMk+QrUbozlspcT1O54OwZG/bUDbPxoyllgkKJRuUuH0B18hw5fT
	eGDrpHnOkojzkeeUcZZk9SJ9oKM78mCMIKbZGytLfmRP49orFz284DR6ZciVDioRSU9+vAnw9AC
	F+ks0XyiazXlBoe8NOztpJUxyxitMFA/jXpmMVijrO/nwit4bGbH2jmJOdNtBcRxJtu8PF5Xelt
	dTgZzJF61ppcZXrkmABsg07dKZ46V7r1swGsYXYmasLjh5WrVNicpOVI4LyETUpDWzwdYza5T6R
	n0c99S9vpHOHD3QLmunm4x9Oe6WvEMHId/c=
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314975e9.31.1758696932401;
        Tue, 23 Sep 2025 23:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzQnJawr202LYF/GiG0rNphKRkGOKkt//h6RbI08Bh3KFW0jxQ55p1coTiwy7Vic6NwDCxDw==
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314625e9.31.1758696931825;
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f99178390csm13966234f8f.44.2025.09.23.23.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250924024416-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>

On Wed, Sep 24, 2025 at 07:56:33AM +0200, Simon Schippers wrote:
> On 23.09.25 18:36, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> >> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> >> entry of the ptr_ring and then waking the netdev queue when entries got
> >> invalidated to be used again by the producer.
> >> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> >> if the netdev queue is stopped before invalidating entries. Like that the
> >> netdev queue can be safely woken after invalidating entries.
> >>
> >> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> >> __ptr_ring_produce within tun_net_xmit guarantees that the information
> >> about the netdev queue being stopped is visible after __ptr_ring_peek is
> >> called.
> >>
> >> The netdev queue is also woken after resizing the ptr_ring.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 88 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..f8292721a9d6 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>  	return ret ? ret : total;
> >>  }
> >>  
> >> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&q->ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&q->ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&q->ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full.
> > 
> > So what? Maybe it would be a bit suboptimal? But with your design, I do
> > not get what prevents this:
> > 
> > 
> > 	stopped? -> No
> > 		ring is stopped
> > 	discard
> > 
> > and queue stays stopped forever
> > 
> > 
> 
> I totally missed this (but I am not sure why it did not happen in my 
> testing with different ptr_ring sizes..).
> 
> I guess you are right, there must be some type of locking.
> It probably makes sense to lock the netdev txq->_xmit_lock whenever the 
> consumer invalidates old ptr_ring entries (so when r->consumer_head >= 
> r->consumer_tail). The producer holds this lock with dev->lltx=false. Then 
> the consumer is able to wake the queue safely.
> 
> So I would now just change the implementation to:
> tun_net_xmit:
> ...
> if ptr_ring_produce
>     // Could happen because of unproduce in vhost_net..
>     netif_tx_stop_queue
>     ...
>     goto drop
> 
> if ptr_ring_full
>     netif_tx_stop_queue
> ...
> 
> tun_ring_recv/tap_do_read (the implementation for the batched methods 
> would be done in the similar way):
> ...
> ptr_ring_consume
> if r->consumer_head >= r->consumer_tail
>     __netif_tx_lock_bh
>     netif_tx_wake_queue
>     __netif_tx_unlock_bh
> 
> This implementation does not need any new ptr_ring helpers and no fancy 
> ordering tricks.
> Would this implementation be sufficient in your opinion?


Maybe you mean == ? Pls don't poke at ptr ring internals though.
What are we testing for here?
I think the point is that a batch of entries was consumed?
Maybe __ptr_ring_consumed_batch ? and a comment explaining
this returns true when last successful call to consume
freed up a batch of space in the ring for producer to make
progress.


consumer_head == consumer_tail also happens rather a lot,
though thankfully not on every entry.
So taking tx lock each time this happens, even if queue
is not stopped, seems heavyweight.





> >> The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(q->tap)->dev;
> >> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> > 
> > 
> > After an entry is consumed, you can detect this by checking
> > 
> > 	                r->consumer_head >= r->consumer_tail
> > 
> > 
> > so it seems you could keep calling regular ptr_ring_consume
> > and check afterwards?
> > 
> > 
> > 
> > 
> >> +	spin_unlock(&q->ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static ssize_t tap_do_read(struct tap_queue *q,
> >>  			   struct iov_iter *to,
> >>  			   int noblock, struct sk_buff *skb)
> >> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>  					TASK_INTERRUPTIBLE);
> >>  
> >>  		/* Read frames from the queue */
> >> -		skb = ptr_ring_consume(&q->ring);
> >> +		skb = tap_ring_consume(q);
> >>  		if (skb)
> >>  			break;
> >>  		if (noblock) {
> >> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
> >>  	ret = ptr_ring_resize_multiple_bh(rings, n,
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  __skb_array_destroy_skb);
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >>  
> >>  	kfree(rings);
> >>  	return ret;
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index c6b22af9bae8..682df8157b55 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >>  	return total;
> >>  }
> >>  
> >> +static void *tun_ring_consume(struct tun_file *tfile)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&tfile->tx_ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full. The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(tfile->tun)->dev;
> >> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  {
> >>  	DECLARE_WAITQUEUE(wait, current);
> >>  	void *ptr = NULL;
> >>  	int error = 0;
> >>  
> >> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +	ptr = tun_ring_consume(tfile);
> >>  	if (ptr)
> >>  		goto out;
> >>  	if (noblock) {
> >> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  
> >>  	while (1) {
> >>  		set_current_state(TASK_INTERRUPTIBLE);
> >> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +		ptr = tun_ring_consume(tfile);
> >>  		if (ptr)
> >>  			break;
> >>  		if (signal_pending(current)) {
> >> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  tun_ptr_free);
> >>  
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >> +
> >>  	kfree(rings);
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.43.0
> > 


