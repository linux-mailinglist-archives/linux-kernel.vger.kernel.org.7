Return-Path: <linux-kernel+bounces-610565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453AA9365A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45884465FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC1274676;
	Fri, 18 Apr 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8iWYNMW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596F274679
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974957; cv=none; b=b6I1+7L9LkaIDvYwrlJWkFMctLi6FfAxTg3cGS+ZUpACrGQIL0hz65O9POu4mOgT1IfQ3whhUH+AF15GwfHtTO4rnQcEhfmx4zg//8nOSx8B6g/IqtB4dKnDmBvKIbSWIEwt6EYLbRU5sCewRW24g0mnpXPqID7/DFI4RTTHw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974957; c=relaxed/simple;
	bh=n4swobHnDNUwLAENenY29umYN5A4cEqdjrUkZ0UBV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jys1wv+YQAQxexybJW781/S33FQ065aWQlLAEohXeAafaI0vPL/37sYfpx6HVYHlimskPPg8bqo6RxiSkDHN8PP2ax6pIDWw9lSiSTahzi8xW7A0dt+i4dGIY4DI9qqc3oSa/oSscrmtAsqwvPC1AuRIvTqMpttQVUvlepR3lZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8iWYNMW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so17938355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744974953; x=1745579753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4z+4vitFF1HLmYGp5qH1vxFH58VNRpmJ23zED24ccPg=;
        b=V8iWYNMWKmMi4XNcOCybvrj1m1u96A0Itwh5WAUEbkmR5e2AyM4oXOLWjH+fS+Rrcy
         SMyGwKrOsJT9eQgELLv7fbtorxM9U1YG7wMAIEFUEnnQdMDDk8bU2nL2jLw/c2IzhGfa
         tmk7RQuv9M4yac+/DnbiTJ31scqHtktUowdmIZHPumBMsMQbX2wsMT7WXtMT00WTtsYj
         qAzc1/ES+1ei+hg8dJuEc4IKOEhw/zfMBZqQPoc0qjLKNIYNR8Wxr+/By6XtuL4G69yu
         BmEaTVW87kiZs4d/aknM4Sz3BBt13r2g2UopHpuxsNUqJM22MycpMKxkN8etcp+kadw/
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974953; x=1745579753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4z+4vitFF1HLmYGp5qH1vxFH58VNRpmJ23zED24ccPg=;
        b=QyQQ/wwPdMNGVqY7LOyIVJwFqcZlV5JVIP6JhaNsjNnjBm4OiHWvK2iv05EnZumPdw
         Xlar0WXaRiJjiYBC62DCdZgMBRL7GH5mZElfLZTNoAguvFw/sOnE1tPkSNhYYuEgjN0b
         XcIBQ+Wdb+ihpInKaZn9MnX8MRyN/yGBFwm+6VBQuRs9CbmpiefG0Mxuvv2VLoByAZQQ
         WVjtSN7E3fLduORLeiqqOX7qPnLuluqi2LDg5GFHyRgHWCvhTyPVhtcH24ERaxutNFnJ
         GHX5bLLafXkKVGILwvQCKboUYQ5iY9RgAuDU825J5VOQyu5xtqaWKLvkaLyH994YoU4/
         kI3w==
X-Forwarded-Encrypted: i=1; AJvYcCUq9d2zB33aQHldJHAPbatKMI5P9eL6nDkexilCE84AUHCuYlVn8m3MuMn3+eIBhgaxUbMjTxsOND7fcmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXsUkD6B89r6xJv2up5PkzpeYxE/U+zJz/b2xScaI2JNiivrE
	q8L2UZCAvMHshBC9ewDQTxLA5z20qxjQzNV+RVEgR11xPkti/wdUo0w0342xgn8=
X-Gm-Gg: ASbGncsSJvjiyBbEaC9w7XTq5HOHjXboAsJdb95AcfWnTR5+z5Wc/04wHE/+6h8UjKv
	ECXMmlOJB6FUE6/zEE7S2xQzKHWvMaPTHfrNH4NVGVD9jtr65aymkQqt3MOAv/a4UOIHxTO8LSy
	rb4MdZPoEM3n6dRnaAmxCOsTrn57Og6z4zxvXXtar20rg39VxY27wJdnhbh7pyxk89vhMScO/Fx
	OLaJtjgoRwG30dQveJFRLVglJM3FTF/D/lgdjmvQTU5KLyKz3cFFLYMzmBPdogn+XVanaZEEvfL
	6/QG2J1KT6ZlhII5rSb2/Od+fE6ebsbQ+Og8UVhf3uPIH7nPAEfVMI5rdkD408xtR5T95+z2FGb
	5O5Q=
X-Google-Smtp-Source: AGHT+IGgzDneWpjqDYsrvMrlNm2kziIqWIKfA6WRzSUivYakLEXrOn3tJvonIi77xE/vY/on/myTfg==
X-Received: by 2002:a05:600c:8508:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-4406aba4af7mr24333745e9.15.1744974953462;
        Fri, 18 Apr 2025 04:15:53 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd35sm18383865e9.22.2025.04.18.04.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:15:52 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:15:50 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
	stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 3/5 RESEND] thermal: qcom-spmi-temp-alarm: Prepare to
 support additional Temp Alarm subtypes
Message-ID: <aAI0Zm5M9ba9ehyI@mai.linaro.org>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>

On Thu, Mar 20, 2025 at 01:24:06PM -0700, Anjelique Melendez wrote:
> In preparation to support newer temp alarm subtypes, add the "ops" and
> "configure_trip_temps" references to spmi_temp_alarm_data. This will
> allow for each Temp Alarm subtype to define its own
> thermal_zone_device_ops and properly configure thermal trip temperature.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 38 ++++++++++++++-------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 1cc9369ca9e1..514772e94a28 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/bitfield.h>
> @@ -71,8 +71,10 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
>  struct qpnp_tm_chip;
>  
>  struct spmi_temp_alarm_data {
> +	const struct thermal_zone_device_ops *ops;
>  	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
>  	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
> +	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
>  };
>  
>  struct qpnp_tm_chip {
> @@ -312,18 +314,39 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
> +{
> +	int crit_temp, ret;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> +	if (ret)
> +		crit_temp = THERMAL_TEMP_INVALID;
> +
> +	mutex_lock(&chip->lock);
> +
> +	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +}

The qpnp_tm_configure_trip_temp() is called with the lock held which is really
unusual to have this assymetry when dealing with the locks.

In the other side, this code assume it is ok the userspace can change the
critical temperature of the board. Is it really a good idea ?

>  static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
>  };
>  
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
>  };
>  
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen2_v1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
>  };
>  
> @@ -336,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  {
>  	int ret;
>  	u8 reg = 0;
> -	int crit_temp;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -355,15 +377,7 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  	if (chip->stage)
>  		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
>  
> -	mutex_unlock(&chip->lock);
> -
> -	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> -	if (ret)
> -		crit_temp = THERMAL_TEMP_INVALID;
> -
> -	mutex_lock(&chip->lock);
> -
> -	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +	ret = chip->data->configure_trip_temps(chip);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -483,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	 * before the hardware initialization is completed.
>  	 */
>  	chip->tz_dev = devm_thermal_of_zone_register(
> -		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
> +		&pdev->dev, 0, chip, chip->data->ops);
>  	if (IS_ERR(chip->tz_dev))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
>  				     "failed to register sensor\n");
> -- 
> 2.34.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

