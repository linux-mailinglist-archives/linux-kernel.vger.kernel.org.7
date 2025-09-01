Return-Path: <linux-kernel+bounces-795372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADFB3F0F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFCD7A2064
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06AB284694;
	Mon,  1 Sep 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KTszi41x"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E727E7DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756765114; cv=none; b=NOIIXi0heUfJCwr9raRu4vTfPJIymSjMUg7dYJbWKPtrX27yHsMlcyTw5CZYh7rzxHh8KA6DzIYsJz32anCPiWURCqMy3kl0238b4/FPW7OnMkgIOfq23OfrueipDRmc+b+eLPuhPITTAoESBJCSsetOMN+ywmwhF39e7J5YetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756765114; c=relaxed/simple;
	bh=QvCFQgTjuyNlM8J34Ggn8WKsTd0lz1Qdl41ztODapng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH8qNuL+PmYHrz2UWA8/6BfVN6zabniFZP1Jcjx7XUcYH4ntWq6N9VltmrYbMHuV41ss0gETvmKvpxjj9dYHfJxyT5GDpAZlzZUaWPze0ZwhbWYMKK7X92FvgMOzyazCkzNlqP32f5341L5LSiqzW0oBMxU+u/fObMaa+in157Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KTszi41x; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a5588c2-bac5-4d9a-a726-57c6d22341ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756765109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aEzpioEnVAaVyWyNZeOyoP4rfKIhvC7XDRdVAv5wyI=;
	b=KTszi41xFK5aOcCPIZ/WHGDkVYDB8Nn0oYztx9Mg4O2/Wh6EFjfUcyAHQ1D8reV1U13jm0
	6aJGFPbvPKDsjAML+vjZ+BG/Av8+/nLdirTRfy9pWDx5R8vGyiIz4izcWTYhQ1bwz6bF8l
	5K7YULnrmHNK/AfcH1NPULRd89QPAIE=
Date: Mon, 1 Sep 2025 23:18:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: thunder_bgx: decrement cleanup index before use
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Daney <david.daney@cavium.com>,
 "moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250901213314.48599-1-rosenp@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250901213314.48599-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/09/2025 22:33, Rosen Penev wrote:
> All paths in probe that call goto defer do so before assigning phydev
> and thus it makes sense to cleanup the prior index. It also fixes a bug
> where index 0 does not get cleaned up.
> 
> Fixes: b7d3e3d3d21a ("net: thunderx: Don't leak phy device references on -EPROBE_DEFER condition.")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index 21495b5dce25..90c718af06c1 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -1515,11 +1515,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
>   	 * for phy devices we may have already found.
>   	 */
>   	while (lmac) {
> +		lmac--;
>   		if (bgx->lmac[lmac].phydev) {
>   			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
>   			bgx->lmac[lmac].phydev = NULL;
>   		}
> -		lmac--;
>   	}
>   	of_node_put(node);
>   	return -EPROBE_DEFER;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

