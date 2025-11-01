Return-Path: <linux-kernel+bounces-881360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C61C2812C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4861188AF39
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98562C0291;
	Sat,  1 Nov 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KpiUUIGQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFF34CDD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009061; cv=none; b=WLCHXrAxJSS31LMSO+D/ZahtOueY9DCcFp3RX5rPBy8EISBOjwtbK9nnwnqbErl65H+Mq1Bwo9YB/QpJ5ROxvM3+pHHW/tDq+30BQ7siOIl1poA0lS856vA3iuYYnnbwcOkuLizTAiwxUnN5J4yquSMvMaTL99aS73HDALuMKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009061; c=relaxed/simple;
	bh=UX6a+St/oon0bMcSt/uBqo7nx1nv8SZZ1H93Yc3b+SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALemlm1BShxaU7SeX1xVySL475+vYsTGR4n3GkbE7WEVIK5AeNMI8zwkuvcSD8b2Azz9JScdxTXD2q1SywuOQJFbG2vwIZ3vOOeePH4C0NXAX49OsmX9L9ya01kfhkAWt5JpA3KkXLoBjg99fojoZQu/ate3C3tev+TCAKDctvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KpiUUIGQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso27248925e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762009056; x=1762613856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqDn1RC8UO2IDPb+c3+sWenx5mUO6CHUTILYTfEVrJQ=;
        b=KpiUUIGQWDvMUNPYVfsTF6YOcunazgTEyC6ydYBt339ok4PzSJfQ6GW4Aqb0kNSIu8
         iKjmOI0GlGHnuW6m6mbv+ypWeG/WJ+kluruY32GRxOc7ulwgHxBtq2pQTuSjZDGWH1bA
         8ZOS9tn56883pSj8hzz4c8gK12DdFdYY2vGOrQqAOQtxgkLV1MEwFlWgc7ocWwGEKDMi
         ++PW6dCyOj/oJJPRPhHbyONmLFGuWqDVGIAbZ63RsTq32jZAHl5ycvlpMS5Ygiv7DNTp
         d0Ob5X983SjuEjq3zbDaQ3nC7CqOwLY3uOD0otseT9NvAPFG8wQlE4kRu09gLi6VMeIk
         9+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009056; x=1762613856;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqDn1RC8UO2IDPb+c3+sWenx5mUO6CHUTILYTfEVrJQ=;
        b=tpwSIKGJLQwxzfvG3yxQVqV3ybvkpjBIEb8VyfhhxkLjMHmNSBkJ6KqFn0yedBpJkV
         zIP0QD5v23wys4FTgtofB0u+fGeHbhzoesLV/nTi6tQc85AOKvxlzTpfce0U7Z4Lv+2A
         t2lKXZISUx07sh2C2mIgyRV58z2upXHf/09dUFha4H1559Tfiwwg+8y59QFJCMGgD8/1
         NVgkTvZaAX+5WYvnuSMN7VLvTAxcq+qPUrsOaF20jaKwRk0XJ78yRTnXj7zAvOjw4WV+
         UdjHZbqtE/DzncyT9xISfbobInO/ZYSJ3XnHXO8ULBEj0hMO1bUQDHBv0fkyj4uimu9t
         +z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdT3YhC3tl3MqummxZeHjfLeHKVW+a65c6PeBxuFyVqFubwkx+yBzGv+ZNBDuNN2W2zhOIFZcTfVXZMQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTvWfUFNxJQc+CwxqXPfJlfvO1rX8s5GMTR+DUbfJ/iORhHnW
	dxjzcunUXAAVsR7SKh/v4sN72oY90TIKjGKGtP2+89MbV3yKCH82IAN4Akp+iJI6BSw=
X-Gm-Gg: ASbGnctIA00F46+6IkRgrvSlDdwDRG/Upn9dE2goK20nqlAfEd6+9gUw/n7lLk/SphC
	oMunrTUJngyZHsinODGFw5oi9U2Sntf3OnMppWDVJP6WnWbIdk99TGQVxbsAZzVF0yhLU2rVgc4
	zCRExqr5ysjlq/KXOS/3UXRTeEzLFvVEv9qkgErVAaMSeD0vfXap6+GHdYi3LdG3qM/Hxy/Czmc
	8GBtiRklADbS+4TQpG3GGK4HN1SwIbQK1Ud/25nr0LIweGzQK0D+8M89kIrc+W6UHB+seIdHFvg
	aIOMsJ7NPRGm4h0CXM4wjWWrc6Fs8G0vfX54n/eKqqr/gaLzJ7NIIgTmaArL4ermRCqkPTSao8/
	R9uw1dl33mTkLD28BOlpICeEqfM1j1TUihlKFTWCFnruW4g4930ib5WCgxROeZgSL7TdAYt11I0
	6F9WNaFv3u
X-Google-Smtp-Source: AGHT+IEqIrsV+gOof4n3Jx/bwouIFoZoJa8acq7wXUb7wBmEv6oMx40rV85tqc9myqKF+jTACk906Q==
X-Received: by 2002:a05:600c:3b9f:b0:471:6f4:602a with SMTP id 5b1f17b1804b1-4773086bee3mr82378005e9.23.1762009055927;
        Sat, 01 Nov 2025 07:57:35 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c23b8d9sm60335475e9.0.2025.11.01.07.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 07:57:35 -0700 (PDT)
Message-ID: <5d306cb4-a383-4efd-a3ff-add07ef28e8b@tuxon.dev>
Date: Sat, 1 Nov 2025 16:57:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug
 in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aQYKqxD6qCQwFCye@stanley.mountain>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aQYKqxD6qCQwFCye@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/25 15:27, Dan Carpenter wrote:
> The devm_regmap_field_alloc() function never returns NULL, it returns
> error pointers.  Update the error checking to match.
> 
> Fixes: 58128aa88867 ("reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> index eea56687cd0a..4ecb9acb2641 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -158,8 +158,8 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
>  	field.msb = __fls(args[1]);
>  
>  	pwrrdy = devm_regmap_field_alloc(dev, regmap, field);
> -	if (!pwrrdy)
> -		return -ENOMEM;
> +	if (IS_ERR(pwrrdy))
> +		return PTR_ERR(pwrrdy);
>  
>  	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
>  


