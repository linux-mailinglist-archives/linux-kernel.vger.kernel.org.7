Return-Path: <linux-kernel+bounces-863217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997ABF7460
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C2E18C1C51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED143431FC;
	Tue, 21 Oct 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh//w81L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8D4AEE2;
	Tue, 21 Oct 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059379; cv=none; b=jW0DPLbTLEuhCLvGZiazX6NTk5snqBq9/OoO8ppZzyQlJNeYF12Q7j6F3GGFB2jwjDbUQ49qKN6y70bsutfSe7Wy8VrsB81E/wKUPXf4JpMXNqxa4w2VjxSXnQEdntp2RIlDHdTCME8QncQnBXIUyNPx93ENW2EHr6cjAQaGIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059379; c=relaxed/simple;
	bh=5U/hwM6oStRUswmzcr0DDq1CXsslSOAL1jIHn7nowgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE00Wc8AW1c0W49aB5dYuRNASko3GGnnd3qVKqeMeCn8F5rTbITM7sobJLO6pL+Cc8GAOHUZZ6STMp9VxkGsL6kvSN/ih5HJvAfFZ1RZihlVXh17HPsrUMunV1h+vNqS0YQ1aLhuO3mKxQcdxu1ZDbIESQeVOkEodXluw+bqSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh//w81L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E163FC4CEF1;
	Tue, 21 Oct 2025 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761059379;
	bh=5U/hwM6oStRUswmzcr0DDq1CXsslSOAL1jIHn7nowgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eh//w81L8H2VOFwI5+wCMVxu86xgZmHHchIe0BoP7Qj4b8T8SYrBd9l4+nwEoD9/9
	 rmQk/iKuEFuAyr5mRHu6wqkmlsCbeDN47I8ecFm2NO52P6q3rQ7dLGRb+ysdb+gOF7
	 R7De5rLMSD54lnrvpVAp2/vn9y36UzILxllaTC5ubJovJFtDkdpT5Z5ebBwTlTWkhE
	 GA/JmcE/o7YXcoeXVapxbAmwvREpTaezrIhEi4U7g+8/7Q7C1Sig1I4YFoCLN58mSe
	 nViY5HoQTRpxjHgMKI7VDV4YjRJXkGElbRK8Hu1fEF0cvfERBOOoxYjAX71Z65dAAm
	 BL71bz6rUn72w==
Date: Tue, 21 Oct 2025 16:09:35 +0100
From: Lee Jones <lee@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
Message-ID: <20251021150935.GK475031@google.com>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>

On Thu, 25 Sep 2025, Janne Grunau wrote:

> Struct apple_smc's mutex was not initialized before use. Surprisingly
> this only resulted in occasional NULL pointer dereferences in
> apple_smc_read() calls from the probe() functions of sub devices.
> 
> Fixes: e038d985c9823 ("mfd: Add Apple Silicon System Management Controller")

You need to Cc: Stable as well.  Please submit a [RESEND] with that done.

> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/mfd/macsmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
> index 870c8b2028a8fc0e905c8934c2636824cbe5d527..3a117cf19145e86b642f40dc165b542b8df69070 100644
> --- a/drivers/mfd/macsmc.c
> +++ b/drivers/mfd/macsmc.c
> @@ -413,6 +413,7 @@ static int apple_smc_probe(struct platform_device *pdev)
>  	if (!smc)
>  		return -ENOMEM;
>  
> +	mutex_init(&smc->mutex);
>  	smc->dev = &pdev->dev;
>  	smc->sram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &smc->sram);
>  	if (IS_ERR(smc->sram_base))
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250925-macsmc-mutex_init-80d7cb2aacfa
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 

-- 
Lee Jones [李琼斯]

