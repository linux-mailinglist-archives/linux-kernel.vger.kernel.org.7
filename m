Return-Path: <linux-kernel+bounces-790577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026AB3AA77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4963B7C26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326D30F527;
	Thu, 28 Aug 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="arIalO2E"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F724A046
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407563; cv=none; b=NbyvTL7A7+NoTP7fhS+9w7Kuakp6aR0WLULiTEwVs0ruorU4hWJrIGmsfduv06P0xRhCf7SrQux/1BzfmAeER4fJ0cKvlZw7GvUB/N+3zdrfK3mamYUDjzVW2/IYTk6etC2n20B+rFjRuEIaCjRYufEl8ITfXvdKH0oOUDYd4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407563; c=relaxed/simple;
	bh=Zmz0Aw990myHpqldRe5n7SyeapD5TSr3Pltd/LULcUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI6NDb4V7DZwMhXv+W4jngAwr62/r1AMyJfQTnsEGJ1gAPtignZl0NOu0S1lcMLrf06fNObcjXLxyyTml24iAWTjNqxAw7eLMzJe4iuwedQUrEfyEwKyg3RWcJHy6r91S3WiMSgz9UqADlM0a+NTKzqXernsyPn0Cj198qX9EXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=arIalO2E; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88432a1ed9aso13419239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407560; x=1757012360;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyaf/4BSH7hDRyvOEUvNtiGEJXHPeCfEjTWnaMhf1RY=;
        b=CbhLldsOJymXoI0zxMQP9wwy+N0B3pkTHeJGBYCdLOzCMvyR8kNs+hKbxJ97frskGf
         typlCNxJ52Uz0TdQyb5S4nkRYuZEFUN8wvzakqZqMBWpuUtXPJjZprecgr7d9SNiNo1g
         VW0wDQpHPOR4LO1DS++9xBxgECNi0+gwg1wvw6aYjcPEofqkPcm/X38d91mV1716LMa6
         3ZqMIW+dhAfi83jcGw9HOtQpoeZwMvNEwMZbN/w0t/LAOyDTQVtykmV+m1QCT3F9rSWj
         jxVX8qco8ITcM80tHUxzXY8uWqHWiPONuVUYRp/uztVywYXHYQTCaoMl4jsHwWgRJHx2
         c3sw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqfSlCpFw+D85SdAqVD15Mh67NeTDJa4ygfWfIR8itRzv3oUpQM8L30RhFjelJQtEhX8jSbhHe6PSH1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2WvPu3rBLWSBCjMCz2PoGjBHMvgTqSPIYAAnA54vtIDgMiIz
	F1i4ko56IB+dM8kpkNhHxJ25up7E39iX+BPjJcAlaPOosXovyERCSL0zCPWeGgZDZLvg5dD4+LS
	mT7x4HdhbNPd5i0i2PUApYM80ljke55Bs/p/OZxAB8/uN4KZcFUGgtiM3ii6ISfgg1MykxVF0Xm
	xzeGdWe9VwIR8pXFvU3T6hTjJH+ASarQqVddnaK+yGK3yfAL3/IkafAbHaw0dHk4KRApQOJJjrM
	fYpjbiP0fBnfYbZrGg+FF4h
X-Gm-Gg: ASbGncupPOQ0XemHUJ/EB1BpCSIekvt54Vq4Wp6YFFdoRQJ+k+NnV3h2Vhu52G5myGt
	MaEMK9gM+Boo4CTq9vauxwAqXixyuzK6qhSbGHK/SNoSIgX2xQxo8SnjF93BqQVpHY5hGtj4W8+
	KU9BwiSf8ct3uVwvViQLBiYFyP5nHBjUI6m+aPn3Q47aAcwtqDes8rD9UpYFXzKEt6QUEXByoT2
	TX960y/kEyN5meQ4VlP/nshhhi/oYSVjqGi0B9F+XwTZyDbUMBopMeHrXX0XpI7nb4SlY+GvcfK
	mwKtNd9IrDLUSzMHVF2dA6NguQbmwcI9oo+Wx11Smuv9gVr+vwgBKAmKLsb4jIMEqYhzgl9p59P
	WPAq9iTtL7ovUQZYs5gsinEevbhVsQk6ctAtahToobyZDyRIBqfG4CtmsyJte96cW1AVYtebFQf
	PDDeQr
X-Google-Smtp-Source: AGHT+IFZiFGKQM1DvYsh+m+58wlY2vGJ6wuPSyGI4G+uNwBSnfGKIDRCC6hzB+7aWcXP3D2AzqXOpJ+tNC//
X-Received: by 2002:a05:6602:360d:b0:87c:2a76:4cf9 with SMTP id ca18e2360f4ac-886f18f66ebmr1273836139f.1.1756407560271;
        Thu, 28 Aug 2025 11:59:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d78cb0851sm8883173.19.2025.08.28.11.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:59:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d903d0cbaso28561516d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756407559; x=1757012359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyaf/4BSH7hDRyvOEUvNtiGEJXHPeCfEjTWnaMhf1RY=;
        b=arIalO2EwwhbefRDeg2J+cpaFaXCg9k5drQ+M07wVQiljmWJ+Wg8MOLBYZT5cwvbHt
         /y7Dqt2Zors98fTifRTalAbdj3gi3Dt/13xkbaM+v/NLHJK5su0wOJrYUKsnyCOaf8ot
         JbJP2kbDzrYAkb8DNw3EHmjZr/uPU86tc8cXU=
X-Forwarded-Encrypted: i=1; AJvYcCW+o8E4fy4NzBD/6s0alANo3ZMi7jf/JQX7SxXCsasK1MNh0hlKud0DR6vSAl7YfMTAKDI6q24FbYGJvrw=@vger.kernel.org
X-Received: by 2002:a05:6214:212e:b0:70d:c9bc:6281 with SMTP id 6a1803df08f44-70dd59c076fmr121328986d6.34.1756407559246;
        Thu, 28 Aug 2025 11:59:19 -0700 (PDT)
X-Received: by 2002:a05:6214:212e:b0:70d:c9bc:6281 with SMTP id 6a1803df08f44-70dd59c076fmr121328696d6.34.1756407558674;
        Thu, 28 Aug 2025 11:59:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0ecb87e7sm33752585a.22.2025.08.28.11.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:59:17 -0700 (PDT)
Message-ID: <9b69b764-5691-4bcd-8784-eb657f13a3a4@broadcom.com>
Date: Thu, 28 Aug 2025 11:59:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] net, bcmgenet: Fix locking of netpoll facing functions
To: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Breno Leitao <leitao@debian.org>
References: <bfb21521a33b8335216ec2523bc461583ea6f7a7.camel@gmx.de>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <bfb21521a33b8335216ec2523bc461583ea6f7a7.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/26/25 01:24, Mike Galbraith wrote:
> Lockdep reports ring->lock to not be irq safe during netpoll/netconsole
> session, resulting in a potential deadlock scenario.
> 
>   Chain exists of:
>     &host->lock --> target_list_lock --> &ring->lock
>    Possible interrupt unsafe locking scenario:
>          CPU0                    CPU1
>          ----                    ----
>     lock(&ring->lock);
>                                  local_irq_disable();
>                                  lock(&host->lock);
>                                  lock(target_list_lock);
>     <Interrupt>
>       lock(&host->lock);
>    *** DEADLOCK ***
> 
> Prevent that via use of irqsave/restore spinlock variant when polling.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>

Your patch did not make it to the adequate mailing list which should be 
at least netdev@vger.kernel.org. This is effectively a partial revert of 
b0447ecb533270cf857ebee1133cb8ff67115423 ("net: bcmgenet: relax lock 
constraints to reduce IRQ latency") therefore I would want Doug to chime 
in and review this.

Thanks!

> ---
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c |   10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2022,14 +2022,15 @@ static int bcmgenet_tx_poll(struct napi_
>   		container_of(napi, struct bcmgenet_tx_ring, napi);
>   	unsigned int work_done = 0;
>   	struct netdev_queue *txq;
> +	unsigned long flags;
>   
> -	spin_lock(&ring->lock);
> +	spin_lock_irqsave(&ring->lock, flags);
>   	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
>   	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
>   		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
>   		netif_tx_wake_queue(txq);
>   	}
> -	spin_unlock(&ring->lock);
> +	spin_unlock_irqrestore(&ring->lock, flags);
>   
>   	if (work_done == 0) {
>   		napi_complete(napi);
> @@ -2128,6 +2129,7 @@ static netdev_tx_t bcmgenet_xmit(struct
>   	struct bcmgenet_tx_ring *ring = NULL;
>   	struct enet_cb *tx_cb_ptr;
>   	struct netdev_queue *txq;
> +	unsigned long flags;
>   	int nr_frags, index;
>   	dma_addr_t mapping;
>   	unsigned int size;
> @@ -2149,7 +2151,7 @@ static netdev_tx_t bcmgenet_xmit(struct
>   
>   	nr_frags = skb_shinfo(skb)->nr_frags;
>   
> -	spin_lock(&ring->lock);
> +	spin_lock_irqsave(&ring->lock, flags);
>   	if (ring->free_bds <= (nr_frags + 1)) {
>   		if (!netif_tx_queue_stopped(txq))
>   			netif_tx_stop_queue(txq);
> @@ -2239,7 +2241,7 @@ static netdev_tx_t bcmgenet_xmit(struct
>   		bcmgenet_tdma_ring_writel(priv, ring->index,
>   					  ring->prod_index, TDMA_PROD_INDEX);
>   out:
> -	spin_unlock(&ring->lock);
> +	spin_unlock_irqrestore(&ring->lock, flags);
>   
>   	return ret;
>   
> 


-- 
Florian

