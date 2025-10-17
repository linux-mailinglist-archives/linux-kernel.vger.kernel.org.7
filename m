Return-Path: <linux-kernel+bounces-857541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06659BE710A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0F1AA007B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF626CE32;
	Fri, 17 Oct 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1DG/+IjA"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13B334693
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688766; cv=none; b=UjEiNvUsFHh9xz+ZQxUHKplf1MO6iLlGR0mq5mW0enBRBLtiNkT3JtzVhGCfhm9MM2vnDvpTVQdYHQ+GUFL0X81EMMwrQ/kf0dOqF/ZytlV4VoBUDdtgTdZ4arI406T7kXrOawXpkeJO3rRSP2QK5VUqO3ZXtCTA55u4myHRCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688766; c=relaxed/simple;
	bh=dDd/qLxqBlbYRZpf/bwD7pPzOiBJCSHMnkHW7F1GpQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evhZyfaX58bU0m3HG7Rkr/3W0FFnW0A6V7KJi1+3Rh0Q/Y9DT/XR9Sneyfu5gPrwSzrJFbrA/g0KTNc49YFklPslJFPsppgagtoVPDXUHAQw7rB9uGVH0xqVdQvVq9RuhR0NC+lH/Ss7M084eiKcG415wk0cK0inESwUG6gAFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1DG/+IjA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6E2674E41119;
	Fri, 17 Oct 2025 08:12:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44CCD606DB;
	Fri, 17 Oct 2025 08:12:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9612102F2335;
	Fri, 17 Oct 2025 10:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760688760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NJjT2JTC9ylxQljIJBrb2cQRLsiK/uJusVJtAAHk1zY=;
	b=1DG/+IjAL6/yKV9K0zdE5G4URgtsryYRLLBce/08EeYxxsAMVQ1qGZVipJ2hFonKdNGSVt
	yTX4PP/uUcVzPy1o6yfNBVICQ7+rs2X5ETODB+Rvb9sMAfFVPeM/UzlXrPOnNWSPqb8qXG
	IchD6FYxIx26bupVYtbXwl3D8bF1bW3r9e0NS8CemLmdKROd1rwBVWH0TzinhEgkQu8Yam
	/tbBvKY3Bl6BUs4yQqqPuVSWGkn//lke6K2cd0WkRJIYJDZwuIr4BII56/ReAXPfYnS8fl
	qYDUG3fu0lwRANqiZP5xru9cfcPk5siJOnTg82kI0K1N/ej3P0mH1BTaIzLMsA==
Message-ID: <7c2dd51f-a601-4c64-9295-0cf63ab8d749@bootlin.com>
Date: Fri, 17 Oct 2025 10:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: cgbc-hwmon: Add missing NULL check after
 devm_kzalloc()
To: Li Qiang <liqiang01@kylinos.cn>, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017063414.1557447-1-liqiang01@kylinos.cn>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251017063414.1557447-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/17/25 8:34 AM, Li Qiang wrote:
> The driver allocates memory for sensor data using devm_kzalloc(), but
> did not check if the allocation succeeded. In case of memory allocation
> failure, dereferencing the NULL pointer would lead to a kernel crash.
> 
> Add a NULL pointer check and return -ENOMEM to handle allocation failure
> properly.
> 
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  drivers/hwmon/cgbc-hwmon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
> index 772f44d56ccf..3aff4e092132 100644
> --- a/drivers/hwmon/cgbc-hwmon.c
> +++ b/drivers/hwmon/cgbc-hwmon.c
> @@ -107,6 +107,9 @@ static int cgbc_hwmon_probe_sensors(struct device *dev, struct cgbc_hwmon_data *
>  	nb_sensors = data[0];
>  
>  	hwmon->sensors = devm_kzalloc(dev, sizeof(*hwmon->sensors) * nb_sensors, GFP_KERNEL);
> +	if (!hwmon->sensors)
> +		return -ENOMEM;
> +
Thanks for your patch.

Reviewed-by: Thomas Richard <thomas.richard@bootlin.com>

Best Regards,

Thomas

