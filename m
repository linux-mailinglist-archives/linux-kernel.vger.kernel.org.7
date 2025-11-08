Return-Path: <linux-kernel+bounces-891442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 563ADC42AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C8134A4ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77820E011;
	Sat,  8 Nov 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AErEj0Wb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBD208D0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762595196; cv=none; b=EkQTT4xHDGE04hEli6Zpd0XsGfWv7RIB+0fEfmAqVrGTtvE1SM6HEtuUyCz08RaNz1xgB5DRz3B4PQ/vb5PPmYGdZbtSuoBdCfYHEol1r5MM/SQpE41rpPrmkTkWI9rSCJw2gtPlx1qZEiwie0Y5LpT9mB+Nz1A3to4w0r91E8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762595196; c=relaxed/simple;
	bh=7muQtF/Ps3f3Prt0anv07LxtYlAabYY8Z1NqAek/RGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+RMA4BBbFxmkFkcHI8UF6NB3mNf1G20VuOLi0aTWGQ11sRMqoDb7dyI3ofVTLzdVlBV2xEB9htNQNZbhXqos5CoHmcgh5TkuE4QspamGdqLJcEr5GiqotaVe0Fos6zOzEfeFIiB0kyzo3WeM5h7TLUPjPUbc5dbj11KXt6P4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AErEj0Wb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632b0621so10262665e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762595192; x=1763199992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5fKnhw/NCqAOhc6+zKFOhAFJG9FM08SQ0463gUm+Tk=;
        b=AErEj0Wbc0pFtu3+TMWpG0X6eqni9AMHPrx58kdzH/MseeCjuYhvxwjrUyDxYF+Nkh
         8/xeCG9xVhkxnoFDvHY0PqW098z/LwiKynQBLXD636fpa2RgyJXxTCNXPwR0rATpm2oP
         2HJB3H3JS2878yHaYWKB84p8cKeqXcZEvB//WOR3GAUFe/irBTZCJow75OTtvPEcg+5l
         nh941DZqph2qZK+RXyWaM1NmEG85DRp8GIsNDJGffoGO/EoFDgiGpOXRmrwosa46zhYK
         4EZJ2HBS+1/m6s34Cdn4Rt1hua8dTnahlfstdR8gwj1z47kFGMIDCYQd4MOQbPsLLbtV
         1Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762595192; x=1763199992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5fKnhw/NCqAOhc6+zKFOhAFJG9FM08SQ0463gUm+Tk=;
        b=tJ6rQUrOkfuJcB0WgYLNPgtAtmM3dqM3atXPr1wJSjzBN/20otLM0gtGA0V6sj4JnR
         CvJjvP/NhraoyRYZPcXrfQbdAE+GxftFqydBOIGrwaeHqh/EFU8EZu93Svw8/gKHAQOC
         S8zrczPudJyk3T9doPgxbkizOv89esYfz5jgvGMRnauC2E0JA0UyTc6nR8Eyl4Prfj1N
         3nRnkxTTSWpty/boFjPk8rr9DvrbYF9wMfIEXLw6iCprIzYpH7yN0/z4s8aujyCWXqqg
         hp9yNUNM3/jV1UCy81oAT34G7HYyYp969SAMwJlAJobdmMWI0RoMbfUPr3IyD8aEfZWU
         te3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/wbX2vNf8dq2EvNOOLjfjFOK0QEzR+Ez4mceRNfRFE3yEQPYfw/pb/M9V7tQ/08O86F7vvJJ3P/uN34s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wXvUVdkX1ILE6R8g+VJrSCiRhYOtZWctxUzsKRuFyy9qU7VA
	ZFWC09kfA9o5ayCz6TLGNcHTwFE0ttXkd3tYp4v/x9hEYFiGdctrpDzZMJbwiFE0ixk=
X-Gm-Gg: ASbGncuwseb7QH9IMBTttiUtWbS+z4jjlFlVhK5sPO7YFaNHp2oslM2GeaJdbmXAm1n
	VHqbze7IxUNcSso4hylWsKSnv2fT66T26KNHKvycOxLlho0E2OcbJUn9PKNe8+g/k/47Jqm8ei+
	5vSnV3ROIC3+ARZ9JHrL6GjCCPc5oM0ZYqG635ESkcfiZQ6YOjF5Dqpe7swYhRljo3s33PWYB30
	BZlbdEqRoEHU+1wVDcE/OSrJ9AregRdij38RNH5YoBskQcNWEJmsVEfu9RKdFHaYoZ/WJOM8fCL
	LCTfBRToLJ36D9fNJgnok0NRgVcpZ/kCfApRGie4GTcbtWUmkWnEsEWjiYOxeJGtoCmFUQCgxLm
	wmMdTNSy7uT7NT6jaAhGxGCBP8HouFZ4NOBsO/w9J12F3Nfej39A9ojqqvcgdtqlWqKm+qDZpr1
	gwSXJriUkZ
X-Google-Smtp-Source: AGHT+IEH/jRPr1v2VuWmGt7YU/kqwBRVt0nus66tigdVpePgNGEa74ypym8+2ImhYiYRq6hQphHHnA==
X-Received: by 2002:a05:600c:474d:b0:46f:b42e:e39e with SMTP id 5b1f17b1804b1-47773298044mr12511755e9.39.1762595192311;
        Sat, 08 Nov 2025 01:46:32 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm221049125e9.11.2025.11.08.01.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 01:46:31 -0800 (PST)
Message-ID: <04a2ca3f-c63b-42fa-b4a0-8cdf29887c88@tuxon.dev>
Date: Sat, 8 Nov 2025 11:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] rtc: renesas-rtca3: Add support for multiple reset
 lines
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107210706.45044-1-ovidiu.panait.rb@renesas.com>
 <20251107210706.45044-3-ovidiu.panait.rb@renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251107210706.45044-3-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 23:07, Ovidiu Panait wrote:
> Switch from devm_reset_control_get_shared() to
> devm_reset_control_array_get_shared() when retrieving resets.
> 
> The RZ/V2H SoC requires two resets for the RTC block instead of one,
> so this will allow to handle multiple resets without additional changes.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/rtc/rtc-renesas-rtca3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
> index ab816bdf0d77..3524053269ef 100644
> --- a/drivers/rtc/rtc-renesas-rtca3.c
> +++ b/drivers/rtc/rtc-renesas-rtca3.c
> @@ -726,7 +726,7 @@ static int rtca3_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	priv->rstc = devm_reset_control_get_shared(dev, NULL);
> +	priv->rstc = devm_reset_control_array_get_shared(dev);
>  	if (IS_ERR(priv->rstc))
>  		return PTR_ERR(priv->rstc);
>  


