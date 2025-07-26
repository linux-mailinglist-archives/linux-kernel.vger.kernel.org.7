Return-Path: <linux-kernel+bounces-746725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925C6B12A76
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC91C802C5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5D243367;
	Sat, 26 Jul 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WSBWYHnx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEB21ADC5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532793; cv=none; b=d5VNp2JnYhmOT1M6GMtYFj2ssPABge2hlugK8ii6b0XF3FNzjpB/nDw8QMVWOyfkzBSUbEkrxL9MuJnTpX7PoyfstzMeZ+Z7ByiMX6xqs4qCERmiSzyFT+W6KCrn7wjnOI15mN4sAKEq9d9W6q/TcKoiCjboyzR8uUwfsdXwLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532793; c=relaxed/simple;
	bh=ORT+AyzCNauahigfOOr8rKaf1lI9LpQh+BWhq5gZ6T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+AvH04B4RkbDumcpmPGD3s2/YB80EXXoXMZGyWS8rXFk7Fl6Yx+XB1t7b/pp6fdNP8glE8lJK/znXoHgFH2CmxSPetU+Soxi49PA7zXfsMh1xvHweE03sD0wmU9h5EAkTN8oF4qF7ZBKE8e3dKYMO+uHLYJ0yFI5dHzIR39ucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WSBWYHnx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1670508f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532790; x=1754137590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXz74LT5V7fJ3YDNhO9MJuXuVY37cDbTp53DDZ/S1x0=;
        b=WSBWYHnxLKBlJSRKeatVVyE3eRzzYHHVTNm/ew9F8HvKLErsPWj7yjsiH2ssCTghJe
         K+xghI8AtrxGk7VfBLk40KP8im+4NRHfR+Tt8F0V2P9f/gw/Dkg6sMTW7YvfkvkK/LJb
         kUR/QlE5cokutXZisZ2/V46HJJzBpsuRjs8fGrngMqF91BphTkcMQq63km1yoqRxe22x
         ZvZcVi3NCquCtvL7w4Ir2Dk+NQ8n17Yd+sEV1IgfGO/9VsgMEGt/QcoJ3xD1cR33YIIw
         flKLGQF8GMivjNIFYEAH5HATdnUBtRicBMk8eTl3XGvCpQBuYWlnM+EECEzoFeS7Plpo
         3jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532790; x=1754137590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXz74LT5V7fJ3YDNhO9MJuXuVY37cDbTp53DDZ/S1x0=;
        b=Mdd2JrVtznVUFCgzSwpmcENwDPaBqdW8Sa4kE7xlkOraB+OooTKx+8iVy70AitsHCT
         WE6HGt5yrOVAlzlpDNhw6JXC9jHq6N2/Z4Jn7JOKhdfMNjOoVIi6HEyMWiov/qdIPTPt
         D1a8tRRgHigKmNteYD9MOlf8gOw8Pcp8+DZNlioSMhEO7y0uYGYY63M8bYmy6j5V35MN
         /H2WJymJIdB7f+PII24UZ9VYtSw/mzQAJjEUxOI1eQeo24X9DlSKEp+GEolYe9F/tymV
         iO/HMqwroCudX1x+CkcK7+YMgH2+q0ayDq+tWFEPlEWvplh7Nz7TIn2IxFD8Z4YviuoS
         jfXA==
X-Forwarded-Encrypted: i=1; AJvYcCWx84c2Wr3iiu8SIvbr0rYPhh2tKq2Xd6KThny0e2i/ayFzYB9sLtyPMaUnAQzh4XFtjx3JwcunpnLls4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lQqZ/2W8O5I3kH/U19f4NKi2jMDmP1ofwpni+HllEpGXT2Dn
	ESMNwvacF5V8S3SWPMpuBSX5qu6GtvUkdwoOxOfcKUNB0FyYuhzVKUPD/m8XTVbtWCY=
X-Gm-Gg: ASbGnctJD0NXdL7QInn24Yrk4CQuGq0fmvgRUjVrlpHKKI42s6BFTQpG6rYuhQPBSrW
	unOiINjxSqHkVGpEEUl7/ucWsyLjhqM7yAiHJ1ba4T7r2EKs+Wxhq6B0RUhjiKv2gH618xb2UXr
	L1Nfbz9AJMQLox9zRrw7rAcw/a7sU/Fh/9tOBbN/0YKi9CwwqGWvybI0Qj47L6ASjw0b0giyLTb
	KaIL8BDB5uBhpHTZM64a1gvNq2lYlhJOJr50emNWWxeRPJcXVk8npqYah4MPz65uVhG+AsH8Y3S
	drmDBbLp6X1AzLYgADaZTd42zMcjRNi6dDgCoKINa3J48ngE3dO592GX1ipZwRSZmH2KOB46Ygz
	+FGVl4+8D+MVqD7I9p2nn2057WxMpXFU=
X-Google-Smtp-Source: AGHT+IFbQ7M+MHUoszE4dog/+tPFHS7TlxIikU0HmuOERDkjmR+L1tPTzLfHQsgc+ZBVZL843JY1SA==
X-Received: by 2002:a05:6000:2407:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b7765e6ba2mr3918155f8f.3.1753532790477;
        Sat, 26 Jul 2025 05:26:30 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04546sm2622442f8f.53.2025.07.26.05.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:26:29 -0700 (PDT)
Message-ID: <9f16ace1-f1e7-41b0-bc7d-f358cd043271@tuxon.dev>
Date: Sat, 26 Jul 2025 15:26:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: macb: Implement TAPRIO DESTROY command
 offload for gate cleanup
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-5-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-5-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add hardware offload support for "tc qdisc destroy" operations to safely
> remove IEEE 802.1Qbv time-gated scheduling configuration and restore
> default queue behavior.
> 
> Cleanup sequence:
> - Reset network device TC configuration state
> - Disable Enhanced Network Scheduling and Timing for all queues
> - Clear all ENST timing control registers (START_TIME, ON_TIME, OFF_TIME)
> - Atomic register programming with proper synchronization
> 
> This ensures complete removal of time-aware scheduling state, returning
> the controller to standard FIFO queue operation without residual timing
> constraints
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 4518b59168d5..6b3eff28a842 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4239,6 +4239,34 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
>   	return err;
>   }
>   
> +static void macb_taprio_destroy(struct net_device *ndev)

This function is unused in this patch. Nothing mentions it.

> +{
> +	struct macb *bp = netdev_priv(ndev);
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	u32 enst_disable_mask;
> +	u8 i;

unsigned int

> +
> +	netdev_reset_tc(ndev);
> +	enst_disable_mask = GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET;

You can use GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you 
GEM_ENST_DISABLE_QUEUE_SIZE is defined

> +	netdev_dbg(ndev, "TAPRIO destroy: disabling all gates\n");
> +
> +	spin_lock_irqsave(&bp->lock, flags);

guard()

> +
> +	/* Single disable command for all queues */
> +	gem_writel(bp, ENST_CONTROL, enst_disable_mask);
> +
> +	/* Clear all queue ENST registers in batch */
> +	for (i = 0; i < bp->num_queues; i++) {

You can follow the pattern across macb_main.c and replace it with:

         for (unsigned int q = 0, queue = &bp->queues[q]; q < bp->num_queues; 
++q, ++queue)

> +		queue = &bp->queues[i];

And drop this line

Thank you,
Claudiu

> +		queue_writel(queue, ENST_START_TIME, 0);
> +		queue_writel(queue, ENST_ON_TIME, 0);
> +		queue_writel(queue, ENST_OFF_TIME, 0);
> +	}
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +}
> +
>   static const struct net_device_ops macb_netdev_ops = {
>   	.ndo_open		= macb_open,
>   	.ndo_stop		= macb_close,


