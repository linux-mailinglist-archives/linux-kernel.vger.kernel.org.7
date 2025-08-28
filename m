Return-Path: <linux-kernel+bounces-790259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B83B3A39A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DD7C4B05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFD254B1B;
	Thu, 28 Aug 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jAJh2ab9"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130D1F1932
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393742; cv=none; b=TUTtBodQef1gtODEGQ7YfLDCNb6DrZ9/bMbxDPc4rFIMJmySn4wuKbTQw/6As+0cmQhJRGgzzh9SdkbW59+gn0Gib1UkNAIHUFVt7iqn7LLI63lnML5T9nNMMusKtYaEiEPC3f19Y6mKl+A7SwM+D90hr5s9HgIIHFJBVALmmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393742; c=relaxed/simple;
	bh=icOFXtpyTr+v62nWJkhrG9QgJ0lD5a5gT8SO+Skige0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWCMpatvpflYjBRYIxcpT7rzlFHEP4UCPJoX8xmyif7NhCg+WDFU7fIj2NRA+D0zcy405AbqSuufbJJxLvzVw1ggZJb+nd6Hee7tj+htRdqdlVs84OVLelhlSDT5u4lekWXBaDM+3Wq9yglKRHK0okNijUZDHiftZ7fA+9VJiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jAJh2ab9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c5a5a2d-59f6-4a31-9c09-7df8f9117a31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756393727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+I3SDsSbN1coFtYj99WmS0+2o5TVYr/BtAhlhZ/HgE=;
	b=jAJh2ab95ttb0ewNQ7bbtJPVHIl6fvKKfYzEJgfu1RIsYfdVjNlT0LAkZJK9EN/Jd5rhIC
	Hu+gSU3G7bjeXP9t/36VyBy8e/64MYv0nePmOuWp+JQ19NzBgaxaAMOzvovZguALS50MBG
	xqa5Zy88eVhwu009ucC3Ey3wEhWgC9U=
Date: Thu, 28 Aug 2025 16:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v02 13/14] hinic3: Fix missing napi->dev in
 netif_queue_set_napi
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
 <71685e8f14c4523add7580dbfd078b1b2763f7c3.1756378721.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <71685e8f14c4523add7580dbfd078b1b2763f7c3.1756378721.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:10, Fan Gong wrote:
> As netif_queue_set_napi checks napi->dev, if it doesn't have it and
> it will warn_on and return. So we should use netif_napi_add before
> netif_queue_set_napi because netif_napi_add has "napi->dev = dev".
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   drivers/net/ethernet/huawei/hinic3/hinic3_irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index 33eb9080739d..a69b361225e9 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -42,11 +42,11 @@ static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
>   
> +	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
>   	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
>   			     NETDEV_QUEUE_TYPE_RX, &irq_cfg->napi);
>   	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
>   			     NETDEV_QUEUE_TYPE_TX, &irq_cfg->napi);
> -	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
>   	napi_enable(&irq_cfg->napi);
>   }
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

