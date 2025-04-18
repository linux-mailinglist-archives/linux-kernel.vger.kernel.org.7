Return-Path: <linux-kernel+bounces-610552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166ECA93633
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CD463959
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBA52222BB;
	Fri, 18 Apr 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyHS+5cN"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234720B1FC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973669; cv=none; b=M2I2wmUspa83tyFCALy9yowdXmPMr2FdPnLR0koxpmk2myvYSdtrOWqnmZGtPqyIDOX6M4CpGYM9KLCyuHPKgOgON+7a7RRoKgHojsfKoXUiMppT9Eyk5CIhBJS2HE1bwFtH40pOmtvapiymlMbCbWHBsGCsfczUIXn896L5hMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973669; c=relaxed/simple;
	bh=1/8UG517LA2DgnY4VMkVPhPvNHydcaS9/NaQ2b/Q90M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdFmhB6taYvz4zANnmWSAv8T0HhYZ9xmaKjZDFMj7SiSAGdc6gY3B6yFBunYeDln62xm/etcjxP13OZTHK2c9+kON4GXNykCgSuTkq6Y6oB5m2cjs9ixwC6ywM5Dv4B6TxkRZxTRXdqCnkbTMDA/laK5nmD2PWgr3G9IA0oYfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyHS+5cN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1637217f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744973665; x=1745578465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=au9euEFgTYdZixK5I9CPSxaI0WV2CLlMT4SQ96By6cs=;
        b=nyHS+5cNr6eWds5AqONKF1uROf4lcdCEM54KUMdsTKX4uahJ5hQvMDixs2JMIXHm/X
         P4h4f+H7yKEAw5sdtOc/FIZnI37lZxIBKlvny11mhsE8BoJIhzl9c+miTrHj6ORGFjWy
         LsNCmmE5E8SG9MsZ38qsmlzxsO6ichgjj98sCE8HeS+ui6KGut4sPi982HyysnHZLClz
         EfcelFSQ/5gx+yqRNGlbt9GQCE5nkfEeXxHnf3HoRsMqmlg2tjD7hi13vMmBRAxBJW9J
         SaFXOmMVxMot7/svdsieVlbOai3jIQ3VdYPfQuvGy/k6hJxE7R0Yd3GK4TTnnh9o9a9b
         cxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973665; x=1745578465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au9euEFgTYdZixK5I9CPSxaI0WV2CLlMT4SQ96By6cs=;
        b=P4hVGVnCTjzUDI9K45/tc4vrl3/63rVKHlX0QHgprjLcY8Rf1UNyzy6SuQpGOUvhuh
         jLn27R55g/6yljQb0186h9z3nA/MELH8PhJvbx+NG4PojNbipSxFpdUJM9ei7/y/REgZ
         3DR653MA5byzw3Y7cmdLI311T8Xb4EPlX+wdJ/y1XfJxpYLsxvVTXSklqwDJL1TKBGlf
         Y+lR+1CumLsCBwMAIBtEgtiRVUh+gpd6/3fBY0prxPjeJfumqRdaFxfLA8k/fxBco/It
         nuMWXT6+7mJoau8ec35OWQyTP0WqHJqgrCyjGHsftAckGMcj6ShsgJN/+sFK3bF1bcQ/
         0LXg==
X-Forwarded-Encrypted: i=1; AJvYcCXEFWW0KnzWErCSaWwYe6JXGw112Ii+c2b/qtin30TulwUjP6DcV4B+iHDS4qpLumUy6kDCKI2lmt1CywY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x3lixhHKzdEi6ET+y0p536TXq8bSRpD56n6Sl5yL8AvkUk3j
	wT9Pf4xenod0eWmiTiM3Q1t7ZhzW68mLdwRjPgOLO9y3SIsnTln9HZMMTiEN0TY=
X-Gm-Gg: ASbGncvOksSZooxAQCYRmMVteGFOzsr+k6cR/nQUACcIlMUrAO2Xf5Wpfi8vlIjIhiO
	A9srDjRYpIoh3wPW34fk+uQSDCNkce7MgOcuIJ5hF5CRcybFnQFLgFI4EYyJStpMBmYHgAw/Qg6
	GdxWpcE9hn83B4OzfKSTzPYHH3fIa4ta8nRE/vs0lpTFQpSiOZSL521wzawP3zhIVN1nGC1W+9d
	vzR8JDAuWqu7056h5FnolXP2dEQccnQjDzteGPpDakiWGf5k7iQMTyOZDrqj8c1lQap9tDcxBLE
	1dppcwsj6xn0GABVaH3flYO1+IpmDt9MoMB7qSwAuh42ty/Go1nhCHr+qV5YegmiNAx5UL08M95
	WEzIikMsYeZHd9A==
X-Google-Smtp-Source: AGHT+IGFn7+MSrW5VzenZnnJ9w528Q6bQtEiGXih7aQhRS/wsl6XbxhTNW3ERnJTPiWNnQMdxNNYxQ==
X-Received: by 2002:a5d:598b:0:b0:39c:cc7:3c97 with SMTP id ffacd0b85a97d-39efbaf133dmr1825540f8f.50.1744973665370;
        Fri, 18 Apr 2025 03:54:25 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acca9sm17735885e9.12.2025.04.18.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:54:24 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:54:22 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
	stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 1/5 RESEND] thermal: qcom-spmi-temp-alarm: enable
 stage 2 shutdown when required
Message-ID: <aAIvXnAmlPKbcV45@mai.linaro.org>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-2-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320202408.3940777-2-anjelique.melendez@oss.qualcomm.com>

On Thu, Mar 20, 2025 at 01:24:04PM -0700, Anjelique Melendez wrote:
> From: David Collins <david.collins@oss.qualcomm.com>
> 
> Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> stage 2 automatic PMIC partial shutdown to be enabled in order to
> avoid repeated faults in the event of reaching over-temperature
> stage 3.  Modify the stage 2 shutdown control logic to ensure that
> stage 2 shutdown is enabled on all affected PMICs.  Read the
> digital major and minor revision registers to identify these
> PMICs.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index c2d59cbfaea9..b2077ff9fe73 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/bitops.h>
> @@ -16,6 +17,7 @@
>  
>  #include "../thermal_hwmon.h"
>  
> +#define QPNP_TM_REG_DIG_MINOR		0x00
>  #define QPNP_TM_REG_DIG_MAJOR		0x01
>  #define QPNP_TM_REG_TYPE		0x04
>  #define QPNP_TM_REG_SUBTYPE		0x05
> @@ -71,6 +73,7 @@ struct qpnp_tm_chip {
>  	struct device			*dev;
>  	struct thermal_zone_device	*tz_dev;
>  	unsigned int			subtype;
> +	unsigned int			dig_revision;
>  	long				temp;
>  	unsigned int			thresh;
>  	unsigned int			stage;
> @@ -78,6 +81,7 @@ struct qpnp_tm_chip {
>  	/* protects .thresh, .stage and chip registers */
>  	struct mutex			lock;
>  	bool				initialized;
> +	bool				require_s2_shutdown;
>  
>  	struct iio_channel		*adc;
>  	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
> @@ -255,7 +259,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  
>  skip:
>  	reg |= chip->thresh;
> -	if (disable_s2_shutdown)
> +	if (disable_s2_shutdown && !chip->require_s2_shutdown)
>  		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
>  
>  	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> @@ -350,7 +354,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  {
>  	struct qpnp_tm_chip *chip;
>  	struct device_node *node;
> -	u8 type, subtype, dig_major;
> +	u8 type, subtype, dig_major, dig_minor;
>  	u32 res;
>  	int ret, irq;
>  
> @@ -403,6 +407,30 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "could not read dig_major\n");
>  
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read dig_minor\n");
> +		return ret;
> +	}
> +
> +	chip->dig_revision = (dig_major << 8) | dig_minor;

I would move this inside the block below.

> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
> +		/*
> +		 * Check if stage 2 automatic partial shutdown must remain
> +		 * enabled to avoid potential repeated faults upon reaching
> +		 * over-temperature stage 3.
> +		 */
> +		switch (chip->dig_revision) {
> +		case 0x0001:
> +		case 0x0002:
> +		case 0x0100:
> +		case 0x0101:
> +			chip->require_s2_shutdown = true;
> +			break;
> +		}
> +	}

And move this block after the test below

> +
>  	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
>  				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
>  		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
> -- 
> 2.34.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

