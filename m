Return-Path: <linux-kernel+bounces-829951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19691B984E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910DA2E064C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7E23B63E;
	Wed, 24 Sep 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCNp+WfP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88E21FF4C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693050; cv=none; b=lm1QKFFotL2LTStjUeVWDP/VOEARVtfB2Fhhu5rzSdectd2vdyP0TIbPElUK7NexOE8+7Grg1c+ZVjdNlTblIfR8WRoVf7GRNPYCwz7NKkKZX1c7fBeqNrigeApGULqxFZCiIrexgGDz4zvMNEGOpjnwdSqUJLdjyjNPnzhbcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693050; c=relaxed/simple;
	bh=/J1NuLRSXzUZpYo/ANfB3d4ysGO2emGoUiZYdgGvFRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5CxBjp5cISU07zFFKsupnPJ+1lfZn6MK9ZCb/B5JUlK/34TZsALA++Pe94MH/yHlipPQ6eYAcSd4FwNlxGFbwP9n+AbXKs67WSJURQVIyzZ28DFtMCUc8ribA1QCg+WeqxnMvWTE0XJq4W+JlK6E5I2pJSLEk7y//l64BNptmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCNp+WfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758693047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppJ/4+p6+d9eQBtSGx+90R7i7ZmKWove36hByh++FaI=;
	b=bCNp+WfPpo2E9wEB5C6YKA/v9rOsG06o4yWxa/fEtrxy4Mzf9zOvdMQmRANmFsy97IeuZT
	yyAaLblf1nRVpjZd/KwzhVcyCN6es6lzSlxDmwgUw/YotHwtXZzInH/eCQk7lckz5qKYQk
	G4sHlTBDscGMhv3oi9nDz/fzND07nJ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-hmxh-9AqNACpCRwxbqNJzA-1; Wed, 24 Sep 2025 01:50:39 -0400
X-MC-Unique: hmxh-9AqNACpCRwxbqNJzA-1
X-Mimecast-MFC-AGG-ID: hmxh-9AqNACpCRwxbqNJzA_1758693038
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2c1556aeso19460335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693038; x=1759297838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppJ/4+p6+d9eQBtSGx+90R7i7ZmKWove36hByh++FaI=;
        b=Qx+5To4q24p/nFd4OZVO6vTmbOC5ir+Jt7wOprDZchbCVMuLqO9BLlm0A6We+QKxmL
         zo4b3UPHm6BFSGkZHEowQTGAOx0Oauu4yhOThEs3wbUuA0CFYB2kfa3i4mYqzyvoYuIp
         vRz5DIvFH65TiWFzL1Q8nFwHh1yfr4Djg2LG/PbxqR8w7pw68z5ULu5HaKop8Q5dS3cU
         15Fn8RQxqc+khrl7Nw4WOuX/MFAORahv+hXANaXVgMepKjvtC/JvM3RZkqwicF292fDk
         Qq/S6ldnIf+wgPhM2LnoN2Ywd3Xqpkqd4HY03z8TErieY2DLxNuf2ZsFI7Epv70liTKL
         IvqA==
X-Forwarded-Encrypted: i=1; AJvYcCUzQo36rLLWimfHptQ+6HrqDRPpTLr/D7Rnom1WT38R95z3XtQ8ffaBBa7XgLnUvYef6rWFGwxacLM6dao=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuAUnyVfLiusFnoI4e+SbszQraQW0DCFmfnJUx4MW3OlWxbMc
	h4YnFhbi62LxdzUbOLzCHzQOdnIdCpYVvklty1W0rHXm1J5yZLa81xaJtvRMQd6awtCMMi8bnt3
	2nVCyQxKSmKp0/hSsQuAXAYDx/qUgODigbvpDs7mKCaSsQoAu5k++F+bSRfm3fgz8gw==
X-Gm-Gg: ASbGnctDodsDGMGl0uqBXx+2SwRUEVUeRHks1VTXt9yoz6H0CsCbxY8/en4tRJKj3qL
	+u5nFk1Mun3FtGnp88dmKDZ6mHayzJFkMAkFuVIIV/37BnTNNO8CZrUh3CcCbbTHEC6YCS3afqS
	UaK7pC5p0aWpAdV/Rtx55MIKm5nXKfRvO4MRbcyhfO6Dm2P45KNuEkGQvzWrS4YBWYczYw6d2FS
	EcQBwc/DMZt9c8MO7ib/3d3eWqlKsb9WEt6qoCLXpfHo1MEuoil1w398tIE8yBt83ybEZl1vrsg
	XeJajY5Avd0VQUYqsnTI3QHOP4s1aHIubLM=
X-Received: by 2002:a05:600c:1d11:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46e1dac604cmr44570215e9.27.1758693038301;
        Tue, 23 Sep 2025 22:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI5yChju2CNQTfr7bjk/jSZjz66aaKFh1WsB19/2l6F8R6L8aK5fNSSg13stYE6WzGdJUdzA==
X-Received: by 2002:a05:600c:1d11:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46e1dac604cmr44570045e9.27.1758693037866;
        Tue, 23 Sep 2025 22:50:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e21c8b7eesm22011065e9.4.2025.09.23.22.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:50:37 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:50:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 3/8] TUN, TAP & vhost_net: Stop netdev queue
 before reaching a full ptr_ring
Message-ID: <20250924014703-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-4-simon.schippers@tu-dortmund.de>
 <20250923104348-mutt-send-email-mst@kernel.org>
 <71afbe18-3a5a-44ca-bb3b-b018f73ae8c6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71afbe18-3a5a-44ca-bb3b-b018f73ae8c6@tu-dortmund.de>

On Wed, Sep 24, 2025 at 07:41:28AM +0200, Simon Schippers wrote:
> Hi,
> first of all thank you very much for your detailed replies! :)
> 
> On 23.09.25 16:47, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 12:15:48AM +0200, Simon Schippers wrote:
> >> Stop the netdev queue ahead of __ptr_ring_produce when
> >> __ptr_ring_full_next signals the ring is about to fill. Due to the
> >> smp_wmb() of __ptr_ring_produce the consumer is guaranteed to be able to
> >> notice the stopped netdev queue after seeing the new ptr_ring entry. As
> >> both __ptr_ring_full_next and __ptr_ring_produce need the producer_lock,
> >> the lock is held during the execution of both methods.
> >>
> >> dev->lltx is disabled to ensure that tun_net_xmit is not called even
> >> though the netdev queue is stopped (which happened in my testing,
> >> resulting in rare packet drops). Consequently, the update of trans_start
> >> in tun_net_xmit is also removed.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tun.c | 16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 86a9e927d0ff..c6b22af9bae8 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -931,7 +931,7 @@ static int tun_net_init(struct net_device *dev)
> >>  	dev->vlan_features = dev->features &
> >>  			     ~(NETIF_F_HW_VLAN_CTAG_TX |
> >>  			       NETIF_F_HW_VLAN_STAG_TX);
> >> -	dev->lltx = true;
> >> +	dev->lltx = false;
> >>  
> >>  	tun->flags = (tun->flags & ~TUN_FEATURES) |
> >>  		      (ifr->ifr_flags & TUN_FEATURES);
> >> @@ -1060,14 +1060,18 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  
> >>  	nf_reset_ct(skb);
> >>  
> >> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +	queue = netdev_get_tx_queue(dev, txq);
> >> +
> >> +	spin_lock(&tfile->tx_ring.producer_lock);
> >> +	if (__ptr_ring_full_next(&tfile->tx_ring))
> >> +		netif_tx_stop_queue(queue);
> >> +
> >> +	if (unlikely(__ptr_ring_produce(&tfile->tx_ring, skb))) {
> >> +		spin_unlock(&tfile->tx_ring.producer_lock);
> >>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>  		goto drop;
> >>  	}
> > 
> > The comment makes it sound like you always keep one slot free
> > in the queue but that is not the case - you just
> > check before calling __ptr_ring_produce.
> > 
> 
> I agree.
> 
> > 
> > But it is racy isn't it? So first of all I suspect you
> > are missing an mb before netif_tx_stop_queue.
> > 
> 
> I don’t really get this point right now.

ring full next is a read. stop queue is a write. if you are
relying on ordering them in some way you need a full mb generally.




> > Second it's racy because more entries can get freed
> > afterwards. Which maybe is ok in this instance?
> > But it really should be explained in more detail, if so.
> > 
> 
> Will be covered in the next mail.
> 
> > 
> > 
> > Now - why not just check ring full *after* __ptr_ring_produce?
> > Why do we need all these new APIs, and we can
> > use existing ones which at least are not so hard to understand.
> > 
> > 
> 
> You convinced me about changing my implementation anyway but here my (old) 
> idea:
> I did this in V1-V4. The problem is that vhost_net is only called on 
> EPOLLIN triggered by tun_net_xmit. Then, after consuming a batch from the 
> ptr_ring, it must be able to see if the netdev queue stopped or not. If 
> this is not the case the ptr_ring might get empty and vhost_net is not 
> able to wake the queue again (because it is not stopped from its POV), 
> which happened in my testing in my V4.
> 
> This is the reason why, now in the V5, in tun_net_xmit I stop the netdev 
> queue before producing. With that I exploit the smp_wmb() in 
> __ptr_ring_produce which is paired with the READ_ONCE in __ptr_ring_peek 
> to ensure that the consumer in vhost_net sees that the netdev queue 
> stopped after consuming a batch.

yea you said it somewhere in code, too, and I am not sure I understand it all, but
wmb isn't paired with READ_ONCE generally. barrier pairing
is described in memory-barriers.txt, READ_ONCE is not a barrier
at all.

> > 
> > 
> >> -
> >> -	/* dev->lltx requires to do our own update of trans_start */
> >> -	queue = netdev_get_tx_queue(dev, txq);
> >> -	txq_trans_cond_update(queue);
> >> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >>  
> >>  	/* Notify and wake up reader process */
> >>  	if (tfile->flags & TUN_FASYNC)
> >> -- 
> >> 2.43.0
> > 


