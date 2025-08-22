Return-Path: <linux-kernel+bounces-782040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B57B31A38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324EFA071F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732743043BC;
	Fri, 22 Aug 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe7DaGHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43573054D3;
	Fri, 22 Aug 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870346; cv=none; b=CouOBoDGVRTlegK73wkPTqHw0+XT3t+fbnk5BXt4mttmWbrYaI5nfHfc3q9vGULO1DmvYaa2GFW92L9zwZB377pzcb2gKUYl8+eG0AOIocMZtuqQqYupqNCPRtUbpxqCtG38guB99Eit/x7itmBQcrLkpyc0Q/7YCCo8TLVBiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870346; c=relaxed/simple;
	bh=rT3MSPfZlh65W7yN7CiBtVflGvq26AZffT9noNylwS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAskp8Z7FSSGk1FDld0WFR2lvsTUBXUq+chnNVZISSWfqihpzu5WzcATB2dRFN4U7Ip9a4FUCER3vUkFBc5Qmhz7/KSkOkt5x+BnwBkGaICI1IS4oeKp9f41makO6zWhWG4/P4OD6UrnaHYsivOr4avKmu+uwDvZlc71PrAzbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe7DaGHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB2C113D0;
	Fri, 22 Aug 2025 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755870346;
	bh=rT3MSPfZlh65W7yN7CiBtVflGvq26AZffT9noNylwS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fe7DaGHPXNM/kHgO3D0Nf5vMK3XgshrnCq/WFGm6ET+bVclylUXj14ab8+VWxEFet
	 EPoaQzhYUe4NPcCrUMw6NCtCoGvK76p2YcND/JK3MnXM2M4QSgdNG2qIBI25k4/nxc
	 m4VCX0CNCU78vW+3vmBPu91xMARzqXEwy6bWn4391EehTlppsGQ8daY0Cl6xu+kBAx
	 Aqa1QWITa7kK98BoGeeEcr5omQM6Jat3hHScHkhj/caQASAyKSMDrUrYj8h8Y7v2IO
	 udt7DltEK4BWNvvJhQPDvXVttnWUI1U5Nps3YJQJFg1VSMTvBDStcWUvkJ8SDMokvM
	 esCfPcTTLGpMg==
Message-ID: <2fc14ecb-537f-46e1-ae3d-0616f785d222@kernel.org>
Date: Fri, 22 Aug 2025 15:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: x86-android-tablets: Remove the use of
 dev_err_probe()
To: Xichao Zhao <zhao.xichao@vivo.com>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250820085101.395377-1-zhao.xichao@vivo.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250820085101.395377-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 20-Aug-25 10:51 AM, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/platform/x86/x86-android-tablets/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> index 2a9c47178505..db76ba3abd7b 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -265,8 +265,7 @@ static __init int x86_instantiate_spi_dev(const struct x86_dev_info *dev_info, i
>  	spi_devs[idx] = spi_new_device(controller, &board_info);
>  	put_device(&controller->dev);
>  	if (!spi_devs[idx])
> -		return dev_err_probe(&controller->dev, -ENOMEM,
> -				     "creating SPI-device %d\n", idx);
> +		return -ENOMEM;
>  
>  	return 0;
>  }


