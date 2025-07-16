Return-Path: <linux-kernel+bounces-733899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFBB07A58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570D916CFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E02F3C3E;
	Wed, 16 Jul 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkhQ5iRB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54427991E;
	Wed, 16 Jul 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681031; cv=none; b=brCmBL5Ndr4ZzdoW7RKpKMvGT9THgMkzCfZKf4CLNZlFl91r5vvFTF0VRUn2vz7Q8JAR3BLO0EC6DvsuMZTaEjrD3vyAvFd25X1xO+uOJ6H2Cxp2WkcSUNisHsJGQtqbR/sZxxk3Q328zrIgu0mPMgKfMqIEXX07glBwUc5mPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681031; c=relaxed/simple;
	bh=U6liLS73og2VmOX90y6m2VYoStDNyADA3oaHx0uEJcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyQ9M7z/Xi01wENc6nfVh6jfvdloDUOVQ3uvmtn9Q3SY5noKbObgIV18shl7TvWe0BS5687n/LhtimHyb7Bp0savY9anxQRpeLU8E7nX73MlvAna0xR1RnJFvFH37B5BXLhNc1mzK6n+RfKVY/eDSE7RKh2OajA/P1sNKMuobis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkhQ5iRB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235a3dd4f0dso43853685ad.0;
        Wed, 16 Jul 2025 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752681029; x=1753285829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uy3/sWUVvTpJ8epPV0x+E3QPYf0Bgh6x09Pucl/boaQ=;
        b=EkhQ5iRBAoOqYQsdMub+LcWibj9D3aK2gwTIaqeuPL/6qIUIabc0enQHU9ro0NacCM
         dm0yezlenNqiXLw3bqKMjdZtjKI8dUiCg/G/SGCXuHGvUUISTo/HmaooNBGXPvpVGUP6
         oIASdaTgZc8cFSaJHRW6CxF3e5jcyg5LG/wM50OJ7tN1SJ9agKhDgTaxYb8xYcLx2+rl
         rRFZOSVx1Q6XKrFDOxZrTpbax1YGLKFMK2THXoDoUxOq+a1dzz1w64D5lJ1KNPw3ECJY
         SGXlNO/04OVXYfCW+QOssb5TBDj/2cLlJVuW9FHhM20R2Zp/PrtVX0VR9zveSFVdvLYl
         SWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681029; x=1753285829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy3/sWUVvTpJ8epPV0x+E3QPYf0Bgh6x09Pucl/boaQ=;
        b=ZnicfnGrgJGppIawH3+fIRM5QDNtsHWGaRY000gRrBm2XzyNonBePYKgP6JHiGgdW7
         y6WVACxTz0q7+JXJEkgutz1NvHb7hvWVWXR7AIAx6C3P6W8+xvPQM8CHzY3OdFVSGn6s
         TbX6tKkSAs8Dg17Av06P+eu9PQqioOQfX5oR99mzsdU9xvB07hm4P5EdSn/vblIlzy+P
         hueOQBiLt/K162HTkWAFml8de15+nigxlepnxjuHXx907xpGzdYeCnh8/NT8cWY1lMKW
         B4BIemtK9/ThbIaR/lA67FOu79z2vmzt073WS+8BocfkLXBZYY3SCA+AzcXodaZnpZkZ
         Y1jA==
X-Forwarded-Encrypted: i=1; AJvYcCU+39KLs6FXh4QCIyF3qMHCFBzdvHPllNDTRrI90oFRQKRihoCrI3KEj+xdAuLt9XxwNhIKicOwE6byf81M@vger.kernel.org, AJvYcCWQ4QEmvg4UrxX4c5D+wSLdNSTXuPIkNMQgvGSIAz5DUfVwBJ1LKeR8F8vKU9yYfLXugCEEaREBM/Ej@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUj+VUd499oM+jMrVE5mW86WTKz2iRDzQ3A2Jg2NcFOzx7X1r
	aY5Z6JsniheBbCTJp3jPBbbROH616mK+gnsiPTO8dDVbzcpIrEvNVc4do+O8cw==
X-Gm-Gg: ASbGncsiqi83NH9EXr+Pw1Gks6ZlhvzTljL4vfiGaebQRBD8WhEQ0nUSW4GN1/eSOJV
	v1SKKAYQ6TQT1QpfZm89nRCJyszR5PSEdZ30Qxd5HW6QGrzYIF7sMs/3RMSMrNB27xtE0up9Vda
	k0WEfSRe3bxcA4KBF7JbaQSBItSXu4H/ki+lPmiEY9y72X//U1/F9XnAxWw2NpmcpbPu7e99/t8
	qwSnx2ytIas47vkqP4aV5A7DiFbJ/kCzTWmmPDrkjeU/Sw8VvAwFhpppnx/0tKe8e7yQFN00Tu4
	W8DuLj/R2UockPtef7J6h9kld+Y+EwKEZN33Umea951uENP7N7lXkJNLNrHNMfGJUuWNTzteTK7
	I0majPbNheRDLPafpChpIf1OMAOW05nYrL7YgnrKwfm5+eoyTM56p5R3Yo4uz/0NyAdgBr68=
X-Google-Smtp-Source: AGHT+IFcUmrOLDgbLvGRU5fQ9/WQd24FE/a5JmpOGwqNr2n46alnuNALslorog713SKQAbhyUXzPyw==
X-Received: by 2002:a17:903:1cf:b0:234:8ec1:4af6 with SMTP id d9443c01a7336-23e24f7d214mr53193115ad.45.1752681028494;
        Wed, 16 Jul 2025 08:50:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f234251sm1709338a91.42.2025.07.16.08.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:50:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cceed588-9699-423e-8a33-33dcad471133@roeck-us.net>
Date: Wed, 16 Jul 2025 08:50:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hwmon: ina238: Add support for INA228
To: Jonas Rebmann <jre@pengutronix.de>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
 <20250715-ina228-v1-4-3302fae4434b@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715-ina228-v1-4-3302fae4434b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 13:49, Jonas Rebmann wrote:
> Add support for the Texas Instruments INA228 Ultra-Precise
> Power/Energy/Charge Monitor.
> 
> The INA228 is very similar to the INA238 but offers four bits of extra
> precision in the temperature, voltage and current measurement fields.
> It also supports energy and charge monitoring, the latter of which is
> not supported through this patch.
> 
> While it seems in the datasheet that some constants such as LSB values
> differ between the 228 and the 238, they differ only for those registers
> where four bits of precision have been added and they differ by a factor
> of 16 (VBUS, VSHUNT, DIETEMP, CURRENT).
> 
> Therefore, the INA238 constants are still applicable with regard
> to the bit of the same significance.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>   drivers/hwmon/ina238.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
> index 44f7ce3c1d7b5a91f67d12c1d29e1e560024a04c..f8c74317344a5bbdf933a32b8c7e5aba13beda30 100644
> --- a/drivers/hwmon/ina238.c
> +++ b/drivers/hwmon/ina238.c
> @@ -107,6 +107,7 @@
>   #define INA238_DIE_TEMP_LSB		1250000 /* 125.0000 mC/lsb */
>   #define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
>   #define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
> +#define INA228_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
>   
>   static const struct regmap_config ina238_regmap_config = {
>   	.max_register = INA238_REGISTERS,
> @@ -114,9 +115,10 @@ static const struct regmap_config ina238_regmap_config = {
>   	.val_bits = 16,
>   };
>   
> -enum ina238_ids { ina238, ina237, sq52206 };
> +enum ina238_ids { ina238, ina237, sq52206, ina228 };
>   
>   struct ina238_config {
> +	bool has_20bit_voltage_current; /* vshunt, vbus and current are 20-bit fields */
>   	bool has_power_highest;		/* chip detection power peak */
>   	bool has_energy;		/* chip detection energy */
>   	u8 temp_shift;			/* fixed parameters for temp calculate */
> @@ -137,6 +139,7 @@ struct ina238_data {
>   
>   static const struct ina238_config ina238_config[] = {
>   	[ina238] = {
> +		.has_20bit_voltage_current = false,
>   		.has_energy = false,
>   		.has_power_highest = false,
>   		.temp_shift = 4,
> @@ -146,6 +149,7 @@ static const struct ina238_config ina238_config[] = {
>   		.temp_lsb = INA238_DIE_TEMP_LSB,
>   	},
>   	[ina237] = {
> +		.has_20bit_voltage_current = false,
>   		.has_energy = false,
>   		.has_power_highest = false,
>   		.temp_shift = 4,
> @@ -155,6 +159,7 @@ static const struct ina238_config ina238_config[] = {
>   		.temp_lsb = INA238_DIE_TEMP_LSB,
>   	},
>   	[sq52206] = {
> +		.has_20bit_voltage_current = false,
>   		.has_energy = true,
>   		.has_power_highest = true,
>   		.temp_shift = 0,
> @@ -163,6 +168,16 @@ static const struct ina238_config ina238_config[] = {
>   		.bus_voltage_lsb = SQ52206_BUS_VOLTAGE_LSB,
>   		.temp_lsb = SQ52206_DIE_TEMP_LSB,
>   	},
> +	[ina228] = {
> +		.has_20bit_voltage_current = true,
> +		.has_energy = true,
> +		.has_power_highest = false,
> +		.temp_shift = 0,
> +		.power_calculate_factor = 20,
> +		.config_default = INA238_CONFIG_DEFAULT,
> +		.bus_voltage_lsb = INA238_BUS_VOLTAGE_LSB,
> +		.temp_lsb = INA228_DIE_TEMP_LSB,
> +	},
>   };
>   
>   static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u32 *val)
> @@ -199,6 +214,56 @@ static int ina238_read_reg40(const struct i2c_client *client, u8 reg, u64 *val)
>   	return 0;
>   }
>   
> +static int ina228_read_shunt_voltage(struct device *dev, u32 attr, int channel,
> +				     long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +	int field;
> +	int err;
> +
> +	err = ina238_read_reg24(data->client, INA238_SHUNT_VOLTAGE, &regval);
> +	if (err)
> +		return err;
> +
> +	/* bits 3-0 Reserved, always zero */
> +	field = regval >> 4;
> +
> +	/*
> +	 * gain of 1 -> LSB / 4
> +	 * This field has 16 bit on ina238. ina228 adds another 4 bits of
> +	 * precision. ina238 conversion factors can still be applied when
> +	 * dividing by 16.
> +	 */
> +	*val = (field * INA238_SHUNT_VOLTAGE_LSB) * data->gain / (1000 * 4) / 16;
> +	return 0;
> +}
> +
> +static int ina228_read_bus_voltage(struct device *dev, u32 attr, int channel,
> +				   long *val)
> +{
> +	struct ina238_data *data = dev_get_drvdata(dev);
> +	int regval;
> +	int field;
> +	int err;
> +
> +	err = ina238_read_reg24(data->client, INA238_BUS_VOLTAGE, &regval);
> +	if (err)
> +		return err;
> +
> +	/* bits 3-0 Reserved, always zero */
> +	field = regval >> 4;
> +
> +	/*
> +	 * gain of 1 -> LSB / 4
> +	 * This field has 16 bit on ina238. ina228 adds another 4 bits of
> +	 * precision. ina238 conversion factors can still be applied when
> +	 * dividing by 16.
> +	 */
> +	*val = (field * data->config->bus_voltage_lsb) / 1000 / 16;
> +	return 0;
> +}

Sign extension missing for both. Yes, I understand, the bus voltage is always positive,
but the shunt voltage isn't.

> +
>   static int ina238_read_in(struct device *dev, u32 attr, int channel,
>   			  long *val)
>   {
> @@ -211,6 +276,8 @@ static int ina238_read_in(struct device *dev, u32 attr, int channel,
>   	case 0:
>   		switch (attr) {
>   		case hwmon_in_input:
> +			if (data->config->has_20bit_voltage_current)
> +				return ina228_read_shunt_voltage(dev, attr, channel, val);
>   			reg = INA238_SHUNT_VOLTAGE;
>   			break;
>   		case hwmon_in_max:
> @@ -234,6 +301,8 @@ static int ina238_read_in(struct device *dev, u32 attr, int channel,
>   	case 1:
>   		switch (attr) {
>   		case hwmon_in_input:
> +			if (data->config->has_20bit_voltage_current)
> +				return ina228_read_bus_voltage(dev, attr, channel, val);
>   			reg = INA238_BUS_VOLTAGE;
>   			break;
>   		case hwmon_in_max:
> @@ -341,13 +410,27 @@ static int ina238_read_current(struct device *dev, u32 attr, long *val)
>   
>   	switch (attr) {
>   	case hwmon_curr_input:
> -		err = regmap_read(data->regmap, INA238_CURRENT, &regval);
> -		if (err < 0)
> -			return err;
> +		if (data->config->has_20bit_voltage_current) {
> +			err = ina238_read_reg24(data->client, INA238_CURRENT, &regval);
> +			if (err)
> +				return err;
> +			/* 4 Lowest 4 bits reserved zero */
> +			regval >>= 4;

It is still a signed register and thus needs sign extension.

> +		} else {
> +			err = regmap_read(data->regmap, INA238_CURRENT, &regval);
> +			if (err < 0)
> +				return err;
> +			/* sign-extend */
> +			regval = (s16)regval;
> +		}
>   
>   		/* Signed register, fixed 1mA current lsb. result in mA */
> -		*val = div_s64((s16)regval * INA238_FIXED_SHUNT * data->gain,
> +		*val = div_s64(regval * INA238_FIXED_SHUNT * data->gain,
>   			       data->rshunt * 4);

Reading this again, I suspect that "regval * INA238_FIXED_SHUNT * data->gain"
is a 32-bit value (it is never extended to 64 bit) which may overflow. That probably
never happened with the old chips, but regval is now a 20-bit value so overflows
are more likely than before. The code needs to make sure that the expression
has a 64-bit result.

> +
> +		/* Account for 4 bit offset */
> +		if (data->config->has_20bit_voltage_current)
> +			*val /= 16;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
> @@ -773,6 +856,7 @@ static int ina238_probe(struct i2c_client *client)
>   }
>   
>   static const struct i2c_device_id ina238_id[] = {
> +	{ "ina228", ina228 },
>   	{ "ina237", ina237 },
>   	{ "ina238", ina238 },
>   	{ "sq52206", sq52206 },
> @@ -781,6 +865,10 @@ static const struct i2c_device_id ina238_id[] = {
>   MODULE_DEVICE_TABLE(i2c, ina238_id);
>   
>   static const struct of_device_id __maybe_unused ina238_of_match[] = {
> +	{
> +		.compatible = "ti,ina228",
> +		.data = (void *)ina228
> +	},
>   	{
>   		.compatible = "ti,ina237",
>   		.data = (void *)ina237
> 


