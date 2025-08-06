Return-Path: <linux-kernel+bounces-757951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D29B1C8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C238818C3E24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4422918DE;
	Wed,  6 Aug 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7P08CXk"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89328D85F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494139; cv=none; b=kphJPyTYPxel8mQnLbrG491v3wO+d09zYD+LNrdxgjIjO8N99Px2T0E21FB0cQ+O7SYwodT90q2TUooLZxr62V+l0OZwQfwH0t2w0fiR0F6mAObPTH+SRqH7QBhOahp165T5Eykx/FOXCe0XTwZpVflJ6QFs7egoF6PhX4bNfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494139; c=relaxed/simple;
	bh=njnkMeXbBDfv59fZU5JyPP1/vQsmLknJZSUpgVpQIic=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=bSS3uu/elkvUFT9h6M/WAIe1hkn9JzB+2QmE9e9OM5hu6yTzoC8VAleQpAOGDOcdr1wonSnZIhrDuU9aiUZLiOBqjaPLBfJ5YaOk2RtHyeAOu9YdVFYrb3FZ3ASRK76SsppCp9swEQbsVt10mSNlMy/BXp8d9IGXRWlCzywvIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7P08CXk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b783ea5014so3336462f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754494136; x=1755098936; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ASSxJEQXfE633CevXWqyyh5f9WPRpCDbV8wTQIWfMY=;
        b=u7P08CXklqtrakIE7WQtSZt9fTEh9XfBYF0vu9B6liWJjyNQ5Wef+qDfYQQUnHl7E3
         qrdIp7Uo9nBrQ9VP2ldUknh2jA88XN/TPUqu0sfePGGNMQDAhGrVaMLEZaCF9yK7KL+F
         Fb2f2GxF/eTd3d00nk9Ryji0lqW4vFhO/bT3Rd0Bxs8/jwXj5j+TUvcxTEVWta+pp1qX
         IgTU68NoEA7ABggj0D25BhvBfjhO/8u4j5Tmy7Qpsa21hDrDwZt6BgMJbIFpbms9GPj6
         8667NnK52xUICloHNOtOSOrRRpvBQbt3gwFR/XKuRkqdSpiqEcO+e1zJblVfNZ+z4J5t
         aBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494136; x=1755098936;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ASSxJEQXfE633CevXWqyyh5f9WPRpCDbV8wTQIWfMY=;
        b=J9vYNXHqLR5NwWDxGT3GikgxvrbOl7b3a2lQ1qiQohVRoAj6jVURXQXDW1aBZMnBVP
         HIzF/2bKRB8t6XHVEhzpp9uEjxMF46qS57p8exjKlbuSqv2C2VFX4p1x+6FB3rst6QKp
         YDfJqkQAg3tyTsWDf71rDKY7BxzZVKdiM8njBy602bEileW2Z5xE9e++r3fd5q8N/KE2
         /hEL/Ui6o1rAyTKHI2D1YFihFb8/3mNxxkZpxN5b7TFBr28xAApSzcnoxxIby5Djr1o6
         n+YXdpi4pZZz7v9k37CgvnStoSLxL/rI/Wjhk1amLoXCCZ5HacX3X5MbqEOfKty4rzBt
         fASw==
X-Forwarded-Encrypted: i=1; AJvYcCUElUOgj68H0Umpq4DCrGRVTN9X7n7fuLvRmNhusmPws3aUh770q79gLVHG8BVd/rtxyCXbhhcIZVaCFVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBesrslepo0uK2CJydOvqxPC3PZuHotrszz2pnP7d9Zd3XS80w
	Wyp7BV/uOHUfOAb9ienf98Cp3kBJO0/7k1OnKWlAaxTrHaw3s4siHlE3wau96S0rL9Q=
X-Gm-Gg: ASbGncvIQ1hhSk9c9daS5cEXTk4vUNYx1sJSJmhuQnTjM4/DiD++8DF3jumoY5djKUV
	5IjwRmpARNln6O9ezpqOJX4IukBlZ5Hp2tJAwE/vwLJjSfTU3n4lRows8sKWoRSIT4YlsOBUlL+
	ykyKtKsJ6WqcAHCZOthfM4Lnt5MNpoIfaTtLMzYAUS5SOVjwmQ4afvAOK6HDWUnh0MO43llEeXR
	Ug1NztrikzVdaXVuLX5qvDmK9sgHzwEIIcm32AtEA1fsMKG4nYHcPc3d46nG3IqtueJwElqQCLR
	WJQlC1IvFAnNnG8Su4fZYipv+bHtQITNkgfapiGWRwotHvbxPKUvODUOdzoB/l0Or0SGni2zCiM
	uED8y27ji/cnusB9UbsKDeU4X4Mg=
X-Google-Smtp-Source: AGHT+IGms6BpP/B6mpjSuEArIcBP3P6tAGM77/jKb6ok4h3wKMwoMthR/0suEVsblhKxO8hTtm5llg==
X-Received: by 2002:a5d:64e8:0:b0:3b8:d3cc:8dc with SMTP id ffacd0b85a97d-3b8f491cc2emr2641189f8f.28.1754494135791;
        Wed, 06 Aug 2025 08:28:55 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm23490188f8f.67.2025.08.06.08.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 16:28:54 +0100
Message-Id: <DBVG9ID1KS59.27QTXCZOWJVNM@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/3] Input: aw86927 - add driver for Awinic AW86927
X-Mailer: aerc 0.20.0
References: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
 <20250806-aw86927-v1-2-23d8a6d0f2b2@fairphone.com>
In-Reply-To: <20250806-aw86927-v1-2-23d8a6d0f2b2@fairphone.com>

Hi Griffin,

On Wed Aug 6, 2025 at 4:10 PM BST, Griffin Kroah-Hartman wrote:
> Add support for the I2C-connected Awinic AW86927 LRA haptic driver.
>
> This driver includes a hardcoded sine waveform to be uploaded to the
> AW86927's SRAM for haptic playback.
> This driver does not currently support all the capabilities of the
> AW86927, such as F0 calibration, RTP mode, and CONT mode.
>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  drivers/input/misc/Kconfig   |  11 +
>  drivers/input/misc/Makefile  |   1 +
>  drivers/input/misc/aw86927.c | 841 +++++++++++++++++++++++++++++++++++++=
++++++

[...]

> +static int aw86927_probe(struct i2c_client *client)
> +{
> +	struct aw86927_data *haptics;
> +	unsigned int read_buf;
> +	int err;
> +
> +	haptics =3D devm_kzalloc(&client->dev, sizeof(struct aw86927_data), GFP=
_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +
> +	haptics->dev =3D &client->dev;
> +	haptics->client =3D client;
> +
> +	i2c_set_clientdata(client, haptics);
> +	dev_set_drvdata(&client->dev, haptics);
> +
> +	haptics->regmap =3D devm_regmap_init_i2c(client, &aw86927_regmap_config=
);
> +	if (IS_ERR(haptics->regmap))
> +		return dev_err_probe(haptics->dev, PTR_ERR(haptics->regmap),
> +					"Failed to allocate register map\n");
> +
> +	haptics->input_dev =3D devm_input_allocate_device(haptics->dev);
> +	if (!haptics->input_dev)
> +		return -ENOMEM;
> +
> +	haptics->reset_gpio =3D devm_gpiod_get(haptics->dev, "reset", GPIOD_OUT=
_HIGH);
> +	if (IS_ERR(haptics->reset_gpio))
> +		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	/* Hardware reset */
> +	aw86927_hw_reset(haptics);
> +
> +	/* Software reset */
> +	err =3D regmap_write(haptics->regmap, AW86927_RSTCFG, AW86927_RSTCFG_SO=
FTRST);
> +	if (err)
> +		return dev_err_probe(haptics->dev, PTR_ERR(haptics->regmap),
> +					"Failed Software reset\n");
> +
> +	/* Wait ~3s until I2C is accessible */
> +	usleep_range(3000, 3500);

3 ms or 3 seconds?

[..]

Best regards,
Alexey

