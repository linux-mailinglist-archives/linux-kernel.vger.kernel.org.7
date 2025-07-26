Return-Path: <linux-kernel+bounces-746722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27608B12A71
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8517FFFC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6652459D2;
	Sat, 26 Jul 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PMDQg5YK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDE1401B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532690; cv=none; b=WSwTenEbQQ3jme3LUhKNd6TWRRkO0yGFXj7aca8h6jaRxr0m+Omxqp5oUWVZe49SRajdCiU9m1cuLYSF0j+TkqJfKkAt44cEInBOGkL9ONVBRBYdXYW3uocWhkAl5aCrB5y8fueT6Q4b0bY1PgrrJ5DpDeVk6cDnD5MPnS4N5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532690; c=relaxed/simple;
	bh=Gcg7oQZ0Cs0mV7ViF/tp6fRs8Jom9HiTXVsGYMDCurI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiZGRQ3dUmR5OLMH8JJlbtcgpG4QodstOhMbTysJ8F9917cXc018FrX57bsvNBfQjMs2AeSHxW1Oy66x3GhKtBQXWp3eBo51ENA8/OsUZHNAc9JF//mnlxnHk618Lnd83oRzCvFwkA+BqjlU5Q0y+t8MpatEm/hSYYv6tTLa69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PMDQg5YK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7746135acso1091395f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532686; x=1754137486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEeI24M9CKXGYXMqbCaZiOJCU3qI95QDta4O7potMz0=;
        b=PMDQg5YKmx+8xLZ2zlib6zcQ3XDaj7XQuFaIMNYcPdqhX2e0Eo14b4uy9bUiDtoPeX
         G1WjRCLZigQo1rm7HrYE1LgrMJGr6vZgPVaMJ1YXNv9iHj4lVTZeM2F5R1JCerPghnI0
         jm3oJWRPK/Tajv4Y4cEY1VGLeXjqcwESawTN9Cdr6NInkhCCf94lYPRZoXbku0hCH1aM
         o538CyMz5HnCUX53K1Z5fNyoBT0GtDMSwidCm8gFJcIe+jxAlZdik5ukBPwXyBgvK1bN
         tqEvHu2/9SbkRkEa5RzTTKz6GnpgAcekBa2Ophw/PSGUMXln4iXEDB65NDwD+CMdH3jK
         h79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532686; x=1754137486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEeI24M9CKXGYXMqbCaZiOJCU3qI95QDta4O7potMz0=;
        b=bs+9OZc01pfYlc3KVquMJIVWMNwjE+uW77ZsJlmI96fYrTybPP/Df31i9k2PVhd3wj
         lEHsJTjKv752ycvivVk2zynJ+GtkZATnKfuCD7KJO9mnSDOn2Z5eyhldhl8p+kchRd1B
         jbSVImxzy5+sV4QTZvV06xYEPrp3kWNCykP3zaoQw1BM+WXFUG4F9HpAE0qjlrLzup2d
         Hl/KX4WFh83E6E+KE9qh1EhjNWzu79U8/4S3LL+Odd74rTIGUqx+ENgOSyeD02fqA+Zm
         CW0dsd37a1Vx3kygHJCEU4pRMbk6LFV8zcq/dD+xKrUGgBaUrefb9Akk6UYlN+IyvC4H
         bbuA==
X-Forwarded-Encrypted: i=1; AJvYcCVouTr8lD/IfbeYz0d+cTHaNboB2VQoWcxXx3okmFgUjWlqJATUHEv2DUoRux5hnDs5kCbgPWow4SiN47o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOextTVuMKtl1YcLXf/xDBe/QecqbVK5odoXselS6yZe3BawuI
	fXcMWrTuPLt3wpQV2sigg8USu4mX6PmSJT1xUsAuBO6hnGnY2uAwMnS6BoHpN+EH1PE=
X-Gm-Gg: ASbGnctvaxMptZ/SwiWhZfKKqtTF5m+x+pTFVvKbcMndjArbMQXSQl/B7lt/vbfC/bi
	VIIWO3VId2ylwwYdlBn7GrI3wSBMFQ7V4QIuBGZX3KAbG8d0dHHZcTejuDxMJuInzLw3mnDGQM5
	DogYlwu2j4Buig8FsztaQ2Ygb+14zM4pPLR9i0Ju24u1yGiRPu9oTQlwUwkjFoYeZjqhFSqz8Wo
	GUSxcwrFmYNumsKnpB1GLK8kg7afy5BIqphVTrfhJx81ltYr+EmsHQzTnnTHD5DLpSqRD3H6k6p
	kL3hqOnwVQd4MFB9yM0XFlPr+EF0aivvZkBMlCj3PgJPHfvxSkE3ee7npCf2idvUJiwYLkfw54K
	8DlN9KmtOorgNpwVvDsD9KBwe2IxGnvA=
X-Google-Smtp-Source: AGHT+IE0jHlZPoPK8hKHJN3yPZz6TMVC1vW7UvpmfxXPIn46UPBQb25NsX9NHtvvmEs7OLsBgg+hmw==
X-Received: by 2002:a5d:588f:0:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3b7765ee46cmr3851519f8f.19.1753532686049;
        Sat, 26 Jul 2025 05:24:46 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587c9155a5sm21663515e9.19.2025.07.26.05.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:24:45 -0700 (PDT)
Message-ID: <3cb5f213-3c06-46c5-a314-ce9fb5b1d175@tuxon.dev>
Date: Sat, 26 Jul 2025 15:24:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: macb: Integrate ENST timing parameters
 and hardware unit conversion
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-3-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-3-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Vineeth,

On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add Enhanced Network Scheduling and Timing (ENST) support to
> queue infrastructure with speed-dependent timing calculations for
> precise gate control.
> 
> Hardware timing unit conversion:
> - Timing values programmed as hardware units based on link speed
> - Conversion formula: time_bytes = time_ns / divisor
> - Speed-specific divisors:
>    * 1 Gbps:   divisor = 8
>    * 100 Mbps: divisor = 80
>    * 10 Mbps:  divisor = 800
> 
> Infrastructure changes:
> - Extend macb_queue structure with ENST timing control registers
> - Add queue_enst_configs structure for per-entry TC configuration storage
> - Map ENST register offsets into existing queue management framework
> - Define ENST_NS_TO_HW_UNITS() macro for automatic speed-based conversion
> 
> This enables hardware-native timing programming while abstracting the
> speed-dependent conversions
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb.h      | 32 ++++++++++++++++++++++++
>   drivers/net/ethernet/cadence/macb_main.c |  6 +++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index e456ac65d6c6..ef3995564c5c 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -857,6 +857,16 @@
>   
>   #define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
>   
> +/* ENST macros*/
> +#define ENST_NS_TO_HW_UNITS(ns, speed_mbps) \
> +		DIV_ROUND_UP((ns) * (speed_mbps), (ENST_TIME_GRANULARITY_NS * 1000))
> +
> +#define ENST_MAX_HW_INTERVAL(speed_mbps) \
> +		DIV_ROUND_UP(GENMASK(GEM_ON_TIME_SIZE - 1, 0) * ENST_TIME_GRANULARITY_NS * 1000,\
> +		(speed_mbps))
> +
> +#define ENST_MAX_START_TIME_SEC GENMASK(GEM_START_TIME_SEC_SIZE - 1, 0)

These are not used in this patch.

> +
>   /* struct macb_dma_desc - Hardware DMA descriptor
>    * @addr: DMA address of data buffer
>    * @ctrl: Control and status bits
> @@ -1262,6 +1272,11 @@ struct macb_queue {
>   	unsigned int		RBQP;
>   	unsigned int		RBQPH;
>   
> +	/* ENST register offsets for this queue */
> +	unsigned int		ENST_START_TIME;
> +	unsigned int		ENST_ON_TIME;
> +	unsigned int		ENST_OFF_TIME;
> +
>   	/* Lock to protect tx_head and tx_tail */
>   	spinlock_t		tx_ptr_lock;
>   	unsigned int		tx_head, tx_tail;
> @@ -1450,4 +1465,21 @@ struct macb_platform_data {
>   	struct clk	*hclk;
>   };
>   
> +/**
> + * struct queue_enst_configs - Configuration for Enhanced Scheduled Traffic (ENST) queue
> + * @queue_id:         Identifier for the queue
> + * @start_time_mask:  Bitmask representing the start time for the queue
> + * @on_time_bytes:    "on" time nsec expressed in bytes
> + * @off_time_bytes:   "off" time nsec expressed in bytes
> + *
> + * This structure holds the configuration parameters for an ENST queue,
> + * used to control time-based transmission scheduling in the MACB driver.
> + */
> +struct queue_enst_configs {

s/queue_enst_config/macb_queue_enst_config

> +	u8 queue_id;

Could you please move this above to avoid any padding?

> +	u32 start_time_mask;
> +	u32 on_time_bytes;
> +	u32 off_time_bytes;
> +};
> +

This structure is not used in this patch. Can you please introduce it in the 
patch it is used?


>   #endif /* _MACB_H */
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd..ff87d3e1d8a0 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4305,6 +4305,9 @@ static int macb_init(struct platform_device *pdev)
>   			queue->TBQP = GEM_TBQP(hw_q - 1);
>   			queue->RBQP = GEM_RBQP(hw_q - 1);
>   			queue->RBQS = GEM_RBQS(hw_q - 1);
> +			queue->ENST_START_TIME = GEM_ENST_START_TIME(hw_q);
> +			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(hw_q);
> +			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(hw_q);

You can drop these lines here and move it outside of the if (hw_q) {} else {} block.

>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>   			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
>   				queue->TBQPH = GEM_TBQPH(hw_q - 1);
> @@ -4319,6 +4322,9 @@ static int macb_init(struct platform_device *pdev)
>   			queue->IMR  = MACB_IMR;
>   			queue->TBQP = MACB_TBQP;
>   			queue->RBQP = MACB_RBQP;
> +			queue->ENST_START_TIME = GEM_ENST_START_TIME(0);
> +			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(0);
> +			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(0);

With the above suggested change, these lines could be dropped.

On the other hand these lines are used in patch 3. So I would prefer to have 
them introduced there.

Thank you,
Claudiu

>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>   			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
>   				queue->TBQPH = MACB_TBQPH;


