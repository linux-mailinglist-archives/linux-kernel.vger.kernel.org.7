Return-Path: <linux-kernel+bounces-790342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72431B3A59A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B7B18939EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3926E142;
	Thu, 28 Aug 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i81Gyigj"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED221CA02
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396928; cv=none; b=JNPuy8IkfZOPgvlXY9VkF8Yzzh6+JLjJGd54nhUpK3Ic9nC6KbyiBzA3o3FKukWWsfTYLgRfUUB1eHJzLo4+4pKSiiG09YTzej1WOtH7QeltqNIsoZnfjsPI6plcb8knfiZz622uZ5vgVkcnG1xSZVoBFtsj2DCq9lqLrbl0xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396928; c=relaxed/simple;
	bh=kiX7CyAFz4TZ0E4S53d0DGM11ONPCxFAmM2tnxhh46w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO5tP7aXDoWZYPX/doNfzcHrwIoyNnlcqhp6Qh52/PFTzIykpZnuhzoPuiDH4HqeIcAGA2HK87QWa1z7I+czUR9UcKPmqCVG3EnxcvioR3rOm668OGSnvphAnJ8u29OekALuBjMRjz5wdAejFOGroCOScCtqhLfUaSyK/58mneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i81Gyigj; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <794443b3-2f6d-4400-8844-6c8cdffd3be2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756396913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F34gXWs5azrE0OhbBDQ6CECJveSxbrw+7RsGT9yHBpo=;
	b=i81GyigjAdLCBhKAmtdN2MrGo3LqWPbqY4aTMllZThQ0+tzjtBcqvH20bb6Tc4pzuUqc05
	W99JfExr51YpCNY8x848lNrzDm7CFf3h6VPE5mNE/a4o5i4BJ2k/hseEtEQsoJbJJLIhX5
	5TUYqnE1zAxqgRYqMenFu+jmpA049DE=
Date: Thu, 28 Aug 2025 12:01:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: macb: Fix tx_ptr_lock locking
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>, Mike Galbraith
 <efault@gmx.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250828160023.1505762-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250828160023.1505762-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 12:00, Sean Anderson wrote:
> macb_start_xmit can be called with bottom-halves disabled (e.g.
> transmitting from softirqs) as well as with interrupts disabled (with
> netpoll). Because of this, all other functions taking tx_ptr_lock must
> disable IRQs, and macb_start_xmit must only re-enable IRQs if they
> were already enabled.
> 
> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 16d28a8b3b56..b0a8dfa341ea 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1228,7 +1228,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	int packets = 0;
>  	u32 bytes = 0;
>  
> -	spin_lock(&queue->tx_ptr_lock);
> +	spin_lock_irq(&queue->tx_ptr_lock);
>  	head = queue->tx_head;
>  	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
>  		struct macb_tx_skb	*tx_skb;
> @@ -1291,7 +1291,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  	    CIRC_CNT(queue->tx_head, queue->tx_tail,
>  		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
>  		netif_wake_subqueue(bp->dev, queue_index);
> -	spin_unlock(&queue->tx_ptr_lock);
> +	spin_unlock_irq(&queue->tx_ptr_lock);
>  
>  	return packets;
>  }
> @@ -1708,7 +1708,7 @@ static void macb_tx_restart(struct macb_queue *queue)
>  	struct macb *bp = queue->bp;
>  	unsigned int head_idx, tbqp;
>  
> -	spin_lock(&queue->tx_ptr_lock);
> +	spin_lock_irq(&queue->tx_ptr_lock);
>  
>  	if (queue->tx_head == queue->tx_tail)
>  		goto out_tx_ptr_unlock;
> @@ -1720,19 +1720,19 @@ static void macb_tx_restart(struct macb_queue *queue)
>  	if (tbqp == head_idx)
>  		goto out_tx_ptr_unlock;
>  
> -	spin_lock_irq(&bp->lock);
> +	spin_lock(&bp->lock);
>  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> -	spin_unlock_irq(&bp->lock);
> +	spin_unlock(&bp->lock);
>  
>  out_tx_ptr_unlock:
> -	spin_unlock(&queue->tx_ptr_lock);
> +	spin_unlock_irq(&queue->tx_ptr_lock);
>  }
>  
>  static bool macb_tx_complete_pending(struct macb_queue *queue)
>  {
>  	bool retval = false;
>  
> -	spin_lock(&queue->tx_ptr_lock);
> +	spin_lock_irq(&queue->tx_ptr_lock);
>  	if (queue->tx_head != queue->tx_tail) {
>  		/* Make hw descriptor updates visible to CPU */
>  		rmb();
> @@ -1740,7 +1740,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
>  		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
>  			retval = true;
>  	}
> -	spin_unlock(&queue->tx_ptr_lock);
> +	spin_unlock_irq(&queue->tx_ptr_lock);
>  	return retval;
>  }
>  
> @@ -2308,6 +2308,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct macb_queue *queue = &bp->queues[queue_index];
>  	unsigned int desc_cnt, nr_frags, frag_size, f;
>  	unsigned int hdrlen;
> +	unsigned long flags;
>  	bool is_lso;
>  	netdev_tx_t ret = NETDEV_TX_OK;
>  
> @@ -2368,7 +2369,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
>  	}
>  
> -	spin_lock_bh(&queue->tx_ptr_lock);
> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>  
>  	/* This is a hard error, log it. */
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
> @@ -2392,15 +2393,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>  			     skb->len);
>  
> -	spin_lock_irq(&bp->lock);
> +	spin_lock(&bp->lock);
>  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> -	spin_unlock_irq(&bp->lock);
> +	spin_unlock(&bp->lock);
>  
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
>  		netif_stop_subqueue(dev, queue_index);
>  
>  unlock:
> -	spin_unlock_bh(&queue->tx_ptr_lock);
> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  
>  	return ret;
>  }

Sorry, this should be [PATCH net].

--Sean

