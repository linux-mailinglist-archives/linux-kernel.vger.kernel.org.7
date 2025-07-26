Return-Path: <linux-kernel+bounces-746724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67EFB12A75
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD484543B14
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2552459F3;
	Sat, 26 Jul 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n1KMTaVq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C555129E6E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532764; cv=none; b=Cn/7TQolX9I2Ab2+SY0dywJkIXBfY/KgLLpG8M9TNp27WEBBzMcdCWrsd5FDCDKsBExOpv/JwFsnpxuhXqhtFSVNcQHGBVWIQB54f1JRqtgy5DskQMzdPs8X/WdyJORcdyVKVw3Em5AsIjrH9b1hXedCyorWRU4Q8HXARnN1/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532764; c=relaxed/simple;
	bh=Qj8xmJan2LK+BHvaLztM8VNKIqLUCSjZjtH6t2iwuJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWJBsEHPgRIe8qtuhj4/KKGGI7motNQpjcHEfZhV82lGaba9aKC+emQu5WR707lI9wwy2mbv5GeAnL/drwIIVKg8j0p8hjDczJR033zxvrMDQ/pH58yPhk+gVxkSnJcZVlEEFRrPt1RSFEWpo83ftwbKUYSdMj0cYwkoFDQRCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n1KMTaVq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7825e2775so99604f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532760; x=1754137560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sKBpqY2B+IDd8yyAp15vgM0TBWDUb6Cv3p8yXr6mCo=;
        b=n1KMTaVq7/bUYM47dheBuaWbe0zBy7KMBw5+OVYaSXCOhptdalLrxh0yL5UZrpF5Ev
         dkzxxZkqUXb4xQLtYlEm7J4X5zAVcWAGHCt0B1ptmu6JRRsvMZoNGBC5QhPDlBaeqXlf
         xUw/sXJI774YASUDz5okyiPYH4Ntaj668Ie72nkh+A0yuIdyJO2fN/27mrcNfk+hWRD/
         XcMb17ONDXh6WFOoDiVkj0YW6mz2iHSPleJB54TJLBC4qy5rQBjd/xTf02AtVrLvspRv
         t7X/rczOXiQvK6DpXuQPGaRqBaGxEMSmAtsdEZ1gqwixE4N+Phkd7bda+2Dn+z/tNiB2
         aD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532760; x=1754137560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sKBpqY2B+IDd8yyAp15vgM0TBWDUb6Cv3p8yXr6mCo=;
        b=KMH23AFqNTbmvWEoHmVGjFE2Q4ackAfB/uwk5WKM9x65oAHkLajvqR6T2GQxPOBWbB
         77Kx6yfo2jmYn+HweFOhK/6eauJV/+9kfpZYd1fSCZ/+06UtUzgPLamH6eLJBY/Uo42T
         apyUKmYfJfJAolUYLozQuCrsf6u6moUvZJZcQVVOWRuS+fHOG/PVmtDaHG6XIGwTbOtf
         mK1gBSSMI8vwP3SqIVOSC8ejWOZQOZ/1XutA/PUE79I/DmUyFV/rQvNNysVzHhJao7IO
         DZHvZsz37R5R7KJoOu2eFNFx4ADlVZp2nCSZONzCiXLG+6g+nF5JYpB22cgN1X+a75/s
         ZfRw==
X-Forwarded-Encrypted: i=1; AJvYcCWxI+cqjND2ZQo71TFwmf6ePy3GXGripYk7MimgoFZ+SBLpoExIbak0oNw1jV+cMvfFZX2YiS3PaoRHK3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXMikTXY/NgsWt4N1mLEFCcm2CK5Dn/DpTNJD0VWEICxqdDuA
	SocaiWr5vSsva2KiVLIdgfty5oyK53bkSgRiroS90cL8qVmLuPnGEA2yyCIWG2hMnhvem4oM5Eg
	LsWLe
X-Gm-Gg: ASbGncsRdgjaSLl25w8pYt7L9bxLlEQDMSbgNpzHtQLf+iydDwrCq0BVtsSE9DJMja3
	VOroMjT9MoPLJDG3p9FbRstV8qihoDiSwtDJkm8c0NccTcq8N9qEnIdMvndUWm61EknEuj/eVbw
	NqFudk7blhJf0F4yokU816OyFhUlxCqNgfyhAaK+ds4ftWMN0Lqo88kKk0pD40Votfa0Kizj/QG
	hpgakihAdxP9PPdMFrve2LrpiekiuVsbaPGl5FCSfTwM4T/wOsa8EYPQBLBee2u7rV1MuX7ACls
	PjuCXirsOVUACC1T8v6GXK19DdL/k2cnWdSsHUu+wUAPolqA9Yl1b7hKXeXoOdw1Vjc6Y0Mo5zx
	ejEm9oIZDmEsR4497ZyG168IwWc2peTg=
X-Google-Smtp-Source: AGHT+IGeYixUzUd4ZH35Vr/kQW/mEy7T/EC7YckpDFzouohgitZ0DFUojarJrRWbyqCaIlzRzH5/ew==
X-Received: by 2002:a05:6000:1a85:b0:3a5:2f23:3789 with SMTP id ffacd0b85a97d-3b7767338c2mr4019946f8f.15.1753532759717;
        Sat, 26 Jul 2025 05:25:59 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f03650sm2730023f8f.44.2025.07.26.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:25:59 -0700 (PDT)
Message-ID: <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
Date: Sat, 26 Jul 2025 15:25:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Implement Time-Aware Traffic Scheduling (TAPRIO) hardware offload for
> "tc qdisc replace" operations, enabling IEEE 802.1Qbv compliant gate
> scheduling on Cadence MACB/GEM controllers.
> 
> Parameter validation checks performed:
> - Queue count bounds checking (1 < queues <= MACB_MAX_QUEUES)
> - TC entry limit validation against available hardware queues
> - Base time non-negativity enforcement
> - Speed-adaptive timing constraint verification
> - Cycle time vs. total gate time consistency checks
> - Single-queue gate mask enforcement per scheduling entry
> 
> Hardware programming sequence:
> - GEM doesn't support changing register values if ENST is running,
>    hence disable ENST before programming
> - Atomic timing register configuration (START_TIME, ON_TIME, OFF_TIME)
> - Enable the configured queues via ENST_CONTROL register
> 
> This implementation ensures deterministic gate scheduling while preventing
> invalid configurations.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 155 +++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ff87d3e1d8a0..4518b59168d5 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -36,6 +36,7 @@
>   #include <linux/reset.h>
>   #include <linux/firmware/xlnx-zynqmp.h>
>   #include <linux/inetdevice.h>
> +#include <net/pkt_sched.h>
>   #include "macb.h"
>   
>   /* This structure is only used for MACB on SiFive FU540 devices */
> @@ -4084,6 +4085,160 @@ static void macb_restore_features(struct macb *bp)
>   	macb_set_rxflow_feature(bp, features);
>   }
>   
> +static int macb_taprio_setup_replace(struct net_device *ndev,
> +				     struct tc_taprio_qopt_offload *conf)

This function is unused in this patch. Nothing mentions it.

> +{
> +	u64 total_on_time = 0, start_time_sec = 0, start_time = conf->base_time;
> +	struct queue_enst_configs  *enst_queue;

Extra space here -----------------^

> +	u32 configured_queues = 0, speed = 0;
> +	struct tc_taprio_sched_entry *entry;
> +	struct macb *bp = netdev_priv(ndev);
> +	struct ethtool_link_ksettings kset;
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	int err = 0, i;

No need to initialize err with zero.
	
         size_t i;

as it is used along with conf->num_entries which has size_t type.

> +
> +	/* Validate queue configuration */
> +	if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {

Can this happen?

> +		netdev_err(ndev, "Invalid number of queues: %d\n", bp->num_queues);
> +		return -EINVAL;
> +	}
> +
> +	if (conf->num_entries > bp->num_queues) {
> +		netdev_err(ndev, "Too many TAPRIO entries: %lu > %d queues\n",
> +			   conf->num_entries, bp->num_queues);
> +		return -EINVAL;
> +	}
> +
> +	if (start_time < 0) {
> +		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
> +			   conf->base_time);
> +		return -ERANGE;
> +	}
> +
> +	/* Get the current link speed */
> +	err = phylink_ethtool_ksettings_get(bp->phylink, &kset);
> +	if (unlikely(err)) {
> +		netdev_err(ndev, "Failed to get link settings: %d\n", err);
> +		return err;
> +	}
> +
> +	speed = kset.base.speed;
> +	if (unlikely(speed <= 0)) {
> +		netdev_err(ndev, "Invalid speed: %d\n", speed);
> +		return -EINVAL;
> +	}
> +
> +	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);

To simplify the error path you can use something like:

         struct queue_enst_configs *enst_queue __free(kfree) = kcalloc(...);

and drop the "goto cleanup" below.


> +	if (!enst_queue)
> +		return -ENOMEM;
> +
> +	/* Pre-validate all entries before making any hardware changes */
> +	for (i = 0; i < conf->num_entries; i++) {
> +		entry = &conf->entries[i];
> +
> +		if (entry->command != TC_TAPRIO_CMD_SET_GATES) {
> +			netdev_err(ndev, "Entry %d: unsupported command %d\n",
> +				   i, entry->command);
> +			err = -EOPNOTSUPP;
> +			goto cleanup;
> +		}
> +
> +		/* Validate gate_mask: must be nonzero, single queue, and within range */
> +		if (!is_power_of_2(entry->gate_mask)) {
> +			netdev_err(ndev, "Entry %d: gate_mask 0x%x is not a power of 2 (only one queue per entry allowed)\n",
> +				   i, entry->gate_mask);
> +			err = -EINVAL;
> +			goto cleanup;
> +		}
> +
> +		/* gate_mask must not select queues outside the valid queue_mask */
> +		if (entry->gate_mask & ~bp->queue_mask) {
> +			netdev_err(ndev, "Entry %d: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
> +				   i, entry->gate_mask, bp->num_queues);
> +			err = -EINVAL;
> +			goto cleanup;
> +		}
> +
> +		/* Check for start time limits */
> +		start_time_sec = div_u64(start_time, NSEC_PER_SEC);
> +		if (start_time_sec > ENST_MAX_START_TIME_SEC) {
> +			netdev_err(ndev, "Entry %d: Start time %llu s exceeds hardware limit\n",
> +				   i, start_time_sec);
> +			err = -ERANGE;
> +			goto cleanup;
> +		}
> +
> +		/* Check for on time limit*/

Missing one space here -------------------^

> +		if (entry->interval > ENST_MAX_HW_INTERVAL(speed)) {
> +			netdev_err(ndev, "Entry %d: interval %u ns exceeds hardware limit %lu ns\n",
> +				   i, entry->interval, ENST_MAX_HW_INTERVAL(speed));
> +			err = -ERANGE;
> +			goto cleanup;
> +		}
> +
> +		/* Check for off time limit*/
> +		if ((conf->cycle_time - entry->interval) > ENST_MAX_HW_INTERVAL(speed)) {
> +			netdev_err(ndev, "Entry %d: off_time %llu ns exceeds hardware limit %lu ns\n",
> +				   i, conf->cycle_time - entry->interval,
> +				   ENST_MAX_HW_INTERVAL(speed));
> +			err = -ERANGE;
> +			goto cleanup;
> +		}
> +
> +		enst_queue[i].queue_id = order_base_2(entry->gate_mask);
> +		enst_queue[i].start_time_mask =
> +			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
> +				  (start_time % NSEC_PER_SEC);
> +		enst_queue[i].on_time_bytes =
> +			ENST_NS_TO_HW_UNITS(entry->interval, speed);
> +		enst_queue[i].off_time_bytes =
> +			ENST_NS_TO_HW_UNITS(conf->cycle_time - entry->interval, speed);
> +
> +		configured_queues |= entry->gate_mask;
> +		total_on_time += entry->interval;
> +		start_time += entry->interval;
> +	}
> +
> +	/* Check total interval doesn't exceed cycle time */
> +	if (total_on_time > conf->cycle_time) {
> +		netdev_err(ndev, "Total ON %llu ns exceeds cycle time %llu ns\n",
> +			   total_on_time, conf->cycle_time);
> +		err = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	netdev_dbg(ndev, "TAPRIO setup: %lu entries, base_time=%lld ns, cycle_time=%llu ns\n",
> +		   conf->num_entries, conf->base_time, conf->cycle_time);
> +
> +	/* All validations passed - proceed with hardware configuration */
> +	spin_lock_irqsave(&bp->lock, flags);

You can use guard(spinlock_irqsave)(&bp->lock) or scoped_guard(spinlock_irqsave, 
&bp->lock)

> +
> +	/* Disable ENST queues if running before configuring */
> +	if (gem_readl(bp, ENST_CONTROL))

Is this read necessary?

> +		gem_writel(bp, ENST_CONTROL,
> +			   GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET);

This could be replaced by GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you define 
GEM_ENST_DISABLE_QUEUE_SIZE along with GEM_ENST_DISABLE_QUEUE_OFFSET.

> +
> +	for (i = 0; i < conf->num_entries; i++) {
> +		queue = &bp->queues[enst_queue[i].queue_id];
> +		/* Configure queue timing registers */
> +		queue_writel(queue, ENST_START_TIME, enst_queue[i].start_time_mask);
> +		queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
> +		queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
> +	}
> +
> +	/* Enable ENST for all configured queues in one write */
> +	gem_writel(bp, ENST_CONTROL, configured_queues);

Can this function be executed while other queues are configured? If so, would 
the configured_queues contains it (as well as conf)?

> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	netdev_info(ndev, "TAPRIO configuration completed successfully: %lu entries, %d queues configured\n",
> +		    conf->num_entries, hweight32(configured_queues));
> +
> +cleanup:
> +	kfree(enst_queue);

With the suggestions above, this could be dropped.

Thank you,
Claudiu

> +	return err;
> +}
> +
>   static const struct net_device_ops macb_netdev_ops = {
>   	.ndo_open		= macb_open,
>   	.ndo_stop		= macb_close,


