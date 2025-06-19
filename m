Return-Path: <linux-kernel+bounces-694078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD3AE079C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715533A3B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924E269B01;
	Thu, 19 Jun 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OgNUewMC"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172023D2A5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340409; cv=none; b=s8TFduOI9cFjJclQpT4RFDMvET9HN1qSDQY0VgZXLXeZ5tMm1UWzfeup7Hlq448BBFxKffZ1E6WQFx0yt+ZV4fUPyyAYL6Y7aUmLpHTkdT4J7VhNENisN9Qum/TgDZsmDXGnW3bXj2tulAK9DlnAO4bMUz67You1eFh/lNJWMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340409; c=relaxed/simple;
	bh=AFNN1yB4RcqoBrnRVEyf/13FBByrQ/oIzN3ZyKgPTYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciCEi9/GbRx7IDxfubUMildRTeJhhsWR0iL0z9wXrH+NSFMef9j7f1mhsD++/+mmNs2Sd9NUioBkmRlqXhQs3IpwLLJot3+a47mdjN2vmCh5cKRQOUv5p4v/iL9RYflXZ348t7Ut6A124kpVwffOUllqGjvxp40fS/amih8WQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgNUewMC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1bc7c4e-0fe7-43ad-a061-d51964ddb668@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750340394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iitUIID32ZSrtvqzDCiNlseD6qhYfmYNxL5htoPw5bI=;
	b=OgNUewMCfPJzyQG1U57v06Pz+4xJbqW9O0Q28bZ+DyGBUTYMSJlZDvYxu+4GnaMMHIJwAi
	YQXXD4KNXl3CU6SaGKAOYaTjtubQ+Cj/M7rHbztyidpvMP8zSnx4ohlsH/09dGwCPtbqdi
	K5aI88B3fFTEFgXnq6s+UAb1vWVGWaQ=
Date: Thu, 19 Jun 2025 14:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 07/10] bng_en: Add resource management support
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-8-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-8-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Get the resources and capabilities from the firmware.
> Add functions to manage the resources with the firmware.
> These functions will help netdev reserve the resources
> with the firmware before registering the device in future
> patches. The resources and their information, such as
> the maximum available and reserved, are part of the members
> present in the bnge_hw_resc struct.
> The bnge_reserve_rings() function also populates
> the RSS table entries once the RX rings are reserved with
> the firmware.
> 

[...]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> index c14f03daab4b..9dd13c5219a5 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> @@ -104,4 +104,14 @@ void hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t flags);
>   void *hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
>   			 dma_addr_t *dma);
>   
> +static inline int
> +bnge_hwrm_func_cfg_short_req_init(struct bnge_dev *bdev,
> +				  struct hwrm_func_cfg_input **req)
> +{
> +	u32 req_len;
> +
> +	req_len = min_t(u32, sizeof(**req), bdev->hwrm_max_ext_req_len);
> +	return __hwrm_req_init(bdev, (void **)req, HWRM_FUNC_CFG, req_len);
> +}
> +

Could you please explain how does this suppose to work? If the size of
request will be bigger than the max request length, the HWRM request
will be prepared with smaller size and then partially transferred to FW?

[...]

