Return-Path: <linux-kernel+bounces-721309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99054AFC78F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE61BC3843
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D90262FFF;
	Tue,  8 Jul 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCIIW5hR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE481E2838
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968335; cv=none; b=Z6eejb25Vxi8rxE4ogvBFL2vV93hj/Y9Sk1e0/TKs5w8L4sLftVFABrLWlnFwmbb4Xno0tek9jxanvVhAWvvWXlp6liqmUnIO2tnPbsi1dxAfdBuAWxsvfLtXy+nrSQPTNtPrIjv7K0QjvQfyZTM8TSCEz8QO1V7TB5j7zI7Mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968335; c=relaxed/simple;
	bh=/0Y1Y7OTqONCmx1m/8TUQikKpKzMmzQI4UbNLHxksNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfPmAuyTWSV/qSzM1amOLbf4OgAwm9grhD1TP+ZQCHu2Lgrc7gjZYLio+7gEzZskkEbdbsgRCQTHUuSQXvpA+QKuHnLGsOwtJgzxLG/Cjh6PTmbHYatH60h0e8teT8aWWLVUD0go+EDoFbMCJn6fFhYsJSP5WbLhShWRoKJfTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCIIW5hR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751968332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X5BK60lt8yHW2mcPT6pFw1X0evw7hr2NRoNEBvx6z8=;
	b=FCIIW5hRlKDl0aaxY2Cv4PSpWMxf2T0AB1LjFG9bVejd68fIHNeUQo7422OTdF1vwFDo7W
	iOeErN4c71i/Sq+tNapUhzMJfy6P7232G2RjP33K9vH8t8D0w+CD+rlj44feKhYhEnY/fZ
	26qvTgEljZWmMHGIjfQ6TdlQWNd3rLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_lgoUS06P_emjAOAUXcXeA-1; Tue, 08 Jul 2025 05:52:11 -0400
X-MC-Unique: _lgoUS06P_emjAOAUXcXeA-1
X-Mimecast-MFC-AGG-ID: _lgoUS06P_emjAOAUXcXeA_1751968330
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704d1fso27349125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968330; x=1752573130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2X5BK60lt8yHW2mcPT6pFw1X0evw7hr2NRoNEBvx6z8=;
        b=fvzPkrpyJJVKb0GJ/cpjQcIcyDuANSE7cFy7d7QhAk2LIx8RQ/kki8EYfyVhCwz7TI
         6VYp1Z+7F2ky3M5gCnmi8BpSQiiEzxITb3W2vQ1p4D51PPPRhqnADqdoM8y8FoW+0Xsv
         tIZiax96rs/rd9rwwh8imvK1S9T2VOYfXPXPp4HjynSreUjog5kZRdzujUaobF2yM1gc
         tBNiDNKH+JFEJS24v475kna7ICrjpg5GQSm/dOY5UZAsrnICMSnL7+MgjJqft0udsgBN
         9pgu810WAvX6yvbzDvGHHY5LgTMqteJxNPDnj8lGrXntr/krCTWSJ9hWSwK/RDIOF4ht
         xedQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNFKHDyy+TeQyxga3RUt46zLPH2y7iXO1NLve1LKIyQn3zMfREWdSOWz6fZyTTatD3klF7tIgMVK1kT8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtSbgSG+fC/ASISkj5w+EILcl3K424tJpoCLhzpH4yrD392+8
	WHAAMmv6/elhg548qM77YIHydwm+IYP1LqlmFLRdJ74lyAaV/Y+5Kuzj4FGMedZ5sARXWWbatpl
	u445vM5rSzD4K79Wd6PMQmnROU8ELCIe7CI/fJueBvIJBc0fBbPMG2PxMCeuvz9epvg==
X-Gm-Gg: ASbGncu0Uv2dQcVd+nBTN84s6DsSdszB1XGmPCIER6ziWaAjXDufQZM1xBL41WTQc5/
	FIVqJXf48wGDX4TlKcM+jQlD31lVWTuKx+5U4EhC/8k0JMOqSp3oQpkzdYPQwc0jGlDuaWZygTe
	EXaHcmreE6DxBXvK2b90gIbcdNg5MrdqMJYtxJuvRMH/OKZj0NRZEZRK5e/zpqRDa1Mfjawh7AX
	SHJUCobbjQESYMAfY6gRs8nxyE2dqigWcK5d2DlyJpFmL2cG/7l6aQqLy2hA2FAiRfKqhv1myRa
	Khp4oC518saAeU+kPgflyXSMb8k0EYclnJelMDP4AZgquXh2y+M/HiEtmNCD4Rr/EUwepg==
X-Received: by 2002:a05:600c:190c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-454c6531885mr70789385e9.9.1751968329696;
        Tue, 08 Jul 2025 02:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMDOBH0qBMZ6iN2OTX9dqvc0LhZZ2FR75EoU2J03ehS7fOg9IG4eoFaiP/Vpy/EZIcQItAhw==
X-Received: by 2002:a05:600c:190c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-454c6531885mr70788875e9.9.1751968329162;
        Tue, 08 Jul 2025 02:52:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd45957fsm16437885e9.17.2025.07.08.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:52:08 -0700 (PDT)
Message-ID: <d51a84c7-d534-44cc-88bc-73db8721e50e@redhat.com>
Date: Tue, 8 Jul 2025 11:52:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 07/12] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-8-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-8-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 63afdf2beea6..b5a82748b39b 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -228,6 +228,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
>  	return info;
>  }
>  
> +static void mtip_atable_get_entry_port_number(struct switch_enet_private *fep,
> +					      unsigned char *mac_addr, u8 *port)
> +{
> +	int block_index, block_index_end, entry;
> +	u32 mac_addr_lo, mac_addr_hi;
> +	u32 read_lo, read_hi;
> +
> +	mac_addr_lo = (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
> +			    (mac_addr[1] << 8) | mac_addr[0]);
> +	mac_addr_hi = (u32)((mac_addr[5] << 8) | (mac_addr[4]));
> +
> +	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
> +	block_index_end = block_index + ATABLE_ENTRY_PER_SLOT;
> +
> +	/* now search all the entries in the selected block */
> +	for (entry = block_index; entry < block_index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		*port = MTIP_PORT_FORWARDING_INIT;
> +
> +		if (read_lo == mac_addr_lo &&
> +		    ((read_hi & 0x0000FFFF) ==
> +		     (mac_addr_hi & 0x0000FFFF))) {
> +			/* found the correct address */
> +			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
> +				*port = FIELD_GET(AT_PORT_MASK, read_hi);
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
> +		mac_addr, *port);
> +}
> +
>  /* Clear complete MAC Look Up Table */
>  void mtip_clear_atable(struct switch_enet_private *fep)
>  {
> @@ -825,11 +858,217 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
>  
>  static void mtip_switch_tx(struct net_device *dev)
>  {
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +
> +	spin_lock(&fep->hw_lock);
> +	bdp = fep->dirty_tx;
> +
> +	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
> +		if (bdp == fep->cur_tx && fep->tx_full == 0)
> +			break;
> +
> +		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> +				 MTIP_SWITCH_TX_FRSIZE, DMA_TO_DEVICE);
> +		bdp->cbd_bufaddr = 0;
> +		skb = fep->tx_skbuff[fep->skb_dirty];
> +		/* Check for errors */
> +		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> +				   BD_ENET_TX_RL | BD_ENET_TX_UN |
> +				   BD_ENET_TX_CSL)) {
> +			dev->stats.tx_errors++;
> +			if (status & BD_ENET_TX_HB)  /* No heartbeat */
> +				dev->stats.tx_heartbeat_errors++;
> +			if (status & BD_ENET_TX_LC)  /* Late collision */
> +				dev->stats.tx_window_errors++;
> +			if (status & BD_ENET_TX_RL)  /* Retrans limit */
> +				dev->stats.tx_aborted_errors++;
> +			if (status & BD_ENET_TX_UN)  /* Underrun */
> +				dev->stats.tx_fifo_errors++;
> +			if (status & BD_ENET_TX_CSL) /* Carrier lost */
> +				dev->stats.tx_carrier_errors++;
> +		} else {
> +			dev->stats.tx_packets++;
> +		}
> +
> +		if (status & BD_ENET_TX_READY)
> +			dev_err(&fep->pdev->dev,
> +				"Enet xmit interrupt and TX_READY.\n");
> +
> +		/* Deferred means some collisions occurred during transmit,
> +		 * but we eventually sent the packet OK.
> +		 */
> +		if (status & BD_ENET_TX_DEF)
> +			dev->stats.collisions++;
> +
> +		/* Free the sk buffer associated with this last transmit */
> +		dev_consume_skb_irq(skb);
> +		fep->tx_skbuff[fep->skb_dirty] = NULL;
> +		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;
> +
> +		/* Update pointer to next buffer descriptor to be transmitted */
> +		if (status & BD_ENET_TX_WRAP)
> +			bdp = fep->tx_bd_base;
> +		else
> +			bdp++;
> +
> +		/* Since we have freed up a buffer, the ring is no longer
> +		 * full.
> +		 */
> +		if (fep->tx_full) {
> +			fep->tx_full = 0;
> +			if (netif_queue_stopped(dev))
> +				netif_wake_queue(dev);
> +		}
> +	}
> +	fep->dirty_tx = bdp;
> +	spin_unlock(&fep->hw_lock);
>  }
>  
> +/* During a receive, the cur_rx points to the current incoming buffer.
> + * When we update through the ring, if the next incoming buffer has
> + * not been given to the system, we just set the empty indicator,
> + * effectively tossing the packet.
> + */
>  static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
>  {
> -	return -ENOMEM;
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	u8 *data, rx_port = MTIP_PORT_FORWARDING_INIT;
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status, pkt_len;
> +	struct net_device *pndev;
> +	struct ethhdr *eth_hdr;
> +	int pkt_received = 0;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +	struct page *page;
> +
> +	/* First, grab all of the stats for the incoming packet.
> +	 * These get messed up if we get called due to a busy condition.
> +	 */
> +	bdp = fep->cur_rx;
> +
> +	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
> +		if (pkt_received >= budget)
> +			break;
> +
> +		pkt_received++;
> +
> +		if (!fep->usage_count)
> +			goto rx_processing_done;
> +
> +		status ^= BD_ENET_RX_LAST;
> +		/* Check for errors. */
> +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> +			      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
> +			      BD_ENET_RX_CL)) {
> +			dev->stats.rx_errors++;
> +			if (status & BD_ENET_RX_OV) {
> +				/* FIFO overrun */
> +				dev->stats.rx_fifo_errors++;
> +				goto rx_processing_done;
> +			}
> +			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
> +				      | BD_ENET_RX_LAST)) {
> +				/* Frame too long or too short. */
> +				dev->stats.rx_length_errors++;
> +				if (status & BD_ENET_RX_LAST)
> +					netdev_err(dev, "rcv is not +last\n");
> +			}
> +			if (status & BD_ENET_RX_CR)	/* CRC Error */
> +				dev->stats.rx_crc_errors++;
> +
> +			/* Report late collisions as a frame error. */
> +			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
> +				dev->stats.rx_frame_errors++;
> +			goto rx_processing_done;
> +		}
> +
> +		/* Get correct RX page */
> +		page = fep->page[bdp - fep->rx_bd_base];
> +		/* Process the incoming frame */
> +		pkt_len = bdp->cbd_datlen;
> +		data = (__u8 *)__va(bdp->cbd_bufaddr);
> +
> +		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
> +					pkt_len, DMA_FROM_DEVICE);
> +		net_prefetch(page_address(page));

Both `__va(bdp->cbd_bufaddr)` and `page_address(page)` should point to
the same same memory. Please use constantly one _or_ the other  - likely
page_address(page) is the best option.

> +
> +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +			swap_buffer(data, pkt_len);
> +
> +		if (data) {

The above check is not needed. If data is null swap_buffer will still
unconditionally dereference it.

Also it looks like it can't be NULL.

/P


