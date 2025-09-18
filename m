Return-Path: <linux-kernel+bounces-790056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D10B39ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB15D170AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952353126C0;
	Thu, 28 Aug 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYY4mWUE"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29430DEB2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387554; cv=none; b=qPVPcaanEfz02ujJEdCCY7cZFTQ0yMlY4vq/X59BySp03Qx1+3aipQqFHiDqY7A5tU85qsuq86FUPUdghkzFezocLJEsRdCaHygpJJLOrK+iAsR66w/fId+W/EuDinbaAg96sL7aDb6PrUdyzzOaDQdoPCkfe90GX8DFX2oJen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387554; c=relaxed/simple;
	bh=4R1o8OnRO95zAYNa32y4YQirY4N/kppGRq2Q9m5npAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GxyfPSliNQBumDWLYkFraW+Q7jnuJUVFmdpwb/TjLPKNUpW2+qcGc220pwTeOepvF7SE2TCSKDRo/kYYaSymVIu9h8Q/mbg+pKx+ECSVUd/fBJG4MqnKmXTAtEHN2n4t7rQE4aDk89L3df3kwGh/29yVGJhvAY7Lz3Mfoaytxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYY4mWUE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04da72a3-d219-4dbd-bb9a-b3bf26a57f5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756387550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFoSS4PZpPrRGUUkLCK1RHwD6lWbjJyYY8TTiLpbu7M=;
	b=tYY4mWUEVkmHj+EjoP/f+vfQiARCeIeMmfCmzo/DQL35OjmkX5YseIR32bniO1OEYjlCKl
	9HOzTZFySIGVd/SIrmQmEU0y2qbsKQzq4GvgocgVvVDNPjlNdHsiNceCGf7Scsa7TBKwnp
	6MG4KC9aNnj8TFlYQtfnY05IPlGSTLQ=
Date: Thu, 28 Aug 2025 14:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
To: Miaoqian Lin <linmq006@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828121858.67639-1-linmq006@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828121858.67639-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:18, Miaoqian Lin wrote:
> Replace NULL check with IS_ERR() check after calling page_pool_create()
> since this function returns error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.
> 
> Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ----
> Changes in v3:
> - fix IS_ERR
> Changes in v2:
> - use err = PTR_ERR(ring->pp);
> v1 link: https://lore.kernel.org/all/20250805025057.3659898-1-linmq006@gmail.com
> v2 link: https://lore.kernel.org/all/20250828065050.21954-1-linmq006@gmail.com
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 92a16ddb7d86..13666d50b90f 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -267,8 +267,10 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   	pp.dma_dir = priv->dma_dir;
>   
>   	ring->pp = page_pool_create(&pp);
> -	if (!ring->pp)
> +	if (IS_ERR(ring->pp)) {
> +		err = PTR_ERR(ring->pp);
>   		goto err_ring;
> +	}
>   
>   	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
>   		goto err_pp;

You should wait for 24h before submission of the next version. That's a 
general rule for netdev.

But given that this change is quite small...

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

