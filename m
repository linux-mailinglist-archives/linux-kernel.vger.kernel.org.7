Return-Path: <linux-kernel+bounces-805943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC15B48FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E185D1B26B86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C530B50D;
	Mon,  8 Sep 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j200WoF8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC781DF26E;
	Mon,  8 Sep 2025 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338587; cv=none; b=CSY1kZ3gDM/RjzY4iHzG/gy+VL+uZ/D9vydeq0ksU2LUUS2PU98pBStK011b/6ddToattQeZ+FOArfjaIdNTrODmki1L5MOFfw9Gj+qM+shS1IB8tWFb0bq7++RdS5QhDQky6WFbIzDQHc1LqRgvhaUWJDt/A9h6Ig/7wlHkzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338587; c=relaxed/simple;
	bh=sUYa4hsMG9X79wWbvfsd3MfjnJKxA0DDn26Sm22gQY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgLJwMYFbtoGAqk9BvqigV1D3XWZZCP2YruNh/+FW8E/T2twfMzHYNpQpxK8mDGuNT+Zf0zDiK9esbuMPod6fd8KWA+Zwk/VbviE38PavvTbC//ImE6DysGVpc4dNaFyP/OVlJvyEHNI2cr7E7I/tBlz4vC113+0SSlTjhgvb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j200WoF8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c9a399346so32918375ad.0;
        Mon, 08 Sep 2025 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757338583; x=1757943383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8OYzu1SK6uep1Hui0fYSBmdGt1Jp5jxnTDE2WXSMNFw=;
        b=j200WoF8ucudjr6IPV4vx6k0xFQuDGPK+KewlMVDiIVjemcYjeZUJz2rrXIuLTMJlC
         ycSEH+su+7lrMVAKQU6Df00MddyQSIk4XiiWakoV9giRkgBf3axyCJvCUETUO5doo2l/
         akeClrWDTl7LXB4zFkfq5OOVODwvvvsHSjYn/g5KxSISHDqjitJ2oli7zIfBIdbriumX
         G5ETQeHSzjaaakN74Yb4s1Yz/hJNb3QZghRYguw0QIqpk8y+6c0oMjpkf9UYA4w7k+I/
         jBNwTaPsr42EZhWu0M5Cggb/9J5XTYE7sUuFZ2QVsO72DcXOWuro1yaejvLtFzxt1L+i
         ovRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338583; x=1757943383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OYzu1SK6uep1Hui0fYSBmdGt1Jp5jxnTDE2WXSMNFw=;
        b=kcOedSThfuCMoqtSSGJ31/I1annRQzMjCJpUFtG3PclE+WWe41iDbFZNKL+w0SlvZb
         nJ6oMdnUvpBZaYxghcKaAiHfeVleQ9nW6ZHHnDJxgeIg4ZUWnx7w9EjgjigNJqADDjmP
         C29kQnwpNUEhWx9GjTtIsqStEGbeKakDdaMp3Wvzvz16V0biT3+Iz0BC6tqsqbwLdHYk
         c0n3G/w8xDOZuCa4OUPYhKTP6y1CwpVscsPqQ2fnKmvyzN3h4BpRUXHZ82vIbacT81z/
         47UT0NipeQ5qHCwhoOQG+NHtVt1lMQDMjwJzVfjce42BVhwbq8CffUT+gMnbt5OlcocO
         Z4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7GMf5/9idLXET0rskASJafiJj6uQCgCg0mTxlBYnDOFb0jG7A0rwH469RtO4ZlMVIkDN33oPvTSAf4Mg=@vger.kernel.org, AJvYcCXvCuKVIxPcJRBsRZA7cp+gOEZeYzlGtfYSq+IGe2iKOjZpVNtaFaQUbK/2MfsMLTn3RgmD6uMyWLNqtL03@vger.kernel.org, AJvYcCXwgTtcYTpvRf5TGLX/Xl3qW12G/ExBJ82G2vOdfND+AG4zk8Y/zgnjWb4BwTijXSTXnttyI8H9rao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5IvAFwi3CX3Jz9QAdvGRHMTke2BhPLlr7S5I+dIo4ETvRXjN
	RcfQTKsuioWI3Pet4br63UanPYnAguT7CCi5rvmV6d49cqbuX8UHpRlK
X-Gm-Gg: ASbGncvnys9TwDrCdLR7yRa3HCmodkx+uzmo7tZe1ccZr9DBTSNzKb6qbZbyi2GutVp
	iFlNYyNoEBjfUQ/YverIqLiLQXNFajjdkoPDhejLQ+egD9AH2mMN3X5zNmhViYgHvWnnStaQ6RM
	AjV8RalY49ADehb93WUmERE7Vo31C5IVtOyEpE4lEmjOTPmykaQnDrHeBaYB3FHSIpVILd8pgt2
	dX8g3vWDKeHW4uhFYCWZT3N4e1SZ+3qlch3tkKBmsK1FoYhGOe7PNZDmsgfaynBQ9EqbADLtoTQ
	r4gwR27VZtsJWyyK0YrIhs4BVLYfaw75yd0116zAHkJzirodW/1jwLzNlc4FNyJzWG7RCCfDACY
	aLueEPOO2hTWV7wIxXe70R76XaNNX945MWucdgtdVQnw3ht9HIv/NDfPuaIBNfKABMFWU6GQ=
X-Google-Smtp-Source: AGHT+IEp2OKxGxcYiaHUOxg4a3Nqp74h27zD8P3uJd2ANGu7wGDnI0L9d0wracbJVxh2z9SrfdcVUA==
X-Received: by 2002:a17:903:20d5:b0:24c:ba71:c58d with SMTP id d9443c01a7336-2517257b8bfmr67598995ad.52.1757338583166;
        Mon, 08 Sep 2025 06:36:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b14206426sm175882265ad.17.2025.09.08.06.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:36:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1dd9473-262c-433b-994b-4bc70afc93c8@roeck-us.net>
Date: Mon, 8 Sep 2025 06:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: add MP2925 and MP2929 driver
To: wenswang@yeah.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908105951.1002332-1-wenswang@yeah.net>
 <20250908110128.1002655-1-wenswang@yeah.net>
 <20250908110128.1002655-2-wenswang@yeah.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250908110128.1002655-2-wenswang@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/25 04:01, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2925 and mp2929 controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
> ---
>   Documentation/hwmon/index.rst  |   1 +
>   Documentation/hwmon/mp2925.rst | 151 ++++++++++++++++
>   MAINTAINERS                    |   7 +
>   drivers/hwmon/pmbus/Kconfig    |   9 +
>   drivers/hwmon/pmbus/Makefile   |   1 +
>   drivers/hwmon/pmbus/mp2925.c   | 312 +++++++++++++++++++++++++++++++++
>   6 files changed, 481 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2925.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2925.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index d292a86ac5da..95bcf71ff6d9 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -175,6 +175,7 @@ Hardware Monitoring Kernel Drivers
>      mp2856
>      mp2888
>      mp2891
> +   mp2925
>      mp2975
>      mp2993
>      mp5023
> diff --git a/Documentation/hwmon/mp2925.rst b/Documentation/hwmon/mp2925.rst
> new file mode 100644
> index 000000000000..63eda215b6cb
> --- /dev/null
> +++ b/Documentation/hwmon/mp2925.rst
> @@ -0,0 +1,151 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp2925
> +====================
> +
> +Supported chips:
> +
> +  * MPS mp2925
> +
> +    Prefix: 'mp2925'
> +
> +  * MPS mp2929
> +
> +    Prefix: 'mp2929'
> +
> +Author:
> +
> +	Wensheng Wang <wenswang@yeah.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP2925 Dual Loop Digital Multi-phase Controller.
> +
> +Device compliant with:
> +
> +- PMBus rev 1.3 interface.
> +
> +The driver exports the following attributes via the 'sysfs' files
> +for input voltage:
> +
> +**in1_input**
> +
> +**in1_label**
> +
> +**in1_crit**
> +
> +**in1_crit_alarm**
> +
> +**in1_lcrit**
> +
> +**in1_lcrit_alarm**
> +
> +**in1_max**
> +
> +**in1_max_alarm**
> +
> +**in1_min**
> +
> +**in1_min_alarm**
> +
> +The driver provides the following attributes for output voltage:
> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in2_crit**
> +
> +**in2_crit_alarm**
> +
> +**in2_lcrit**
> +
> +**in2_lcrit_alarm**
> +
> +**in3_input**
> +
> +**in3_label**
> +
> +**in3_crit**
> +
> +**in3_crit_alarm**
> +
> +**in3_lcrit**
> +
> +**in3_lcrit_alarm**
> +
> +The driver provides the following attributes for input current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +The driver provides the following attributes for output current:
> +
> +**curr2_input**
> +
> +**curr2_label**
> +
> +**curr2_crit**
> +
> +**curr2_crit_alarm**
> +
> +**curr2_max**
> +
> +**curr2_max_alarm**
> +
> +**curr3_input**
> +
> +**curr3_label**
> +
> +**curr3_crit**
> +
> +**curr3_crit_alarm**
> +
> +**curr3_max**
> +
> +**curr3_max_alarm**
> +
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power2_input**
> +
> +**power2_label**
> +
> +The driver provides the following attributes for output power:
> +
> +**power3_input**
> +
> +**power3_label**
> +
> +**power4_input**
> +
> +**power4_label**
> +
> +The driver provides the following attributes for temperature:
> +
> +**temp1_input**
> +
> +**temp1_crit**
> +
> +**temp1_crit_alarm**
> +
> +**temp1_max**
> +
> +**temp1_max_alarm**
> +
> +**temp2_input**
> +
> +**temp2_crit**
> +
> +**temp2_crit_alarm**
> +
> +**temp2_max**
> +
> +**temp2_max_alarm**
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7ff55b5d32..6444cf742098 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17184,6 +17184,13 @@ S:	Maintained
>   F:	Documentation/hwmon/mp2891.rst
>   F:	drivers/hwmon/pmbus/mp2891.c
>   
> +MPS MP2925 DRIVER
> +M:	Noah Wang <wenswang@yeah.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/mp2925.rst
> +F:	drivers/hwmon/pmbus/mp2925.c
> +
>   MPS MP2993 DRIVER
>   M:	Noah Wang <noahwang.wang@outlook.com>
>   L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 55e492452ce8..d0e1eb500215 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -391,6 +391,15 @@ config SENSORS_MP2891
>         This driver can also be built as a module. If so, the module will
>         be called mp2891.
>   
> +config SENSORS_MP2925
> +    tristate "MPS MP2925"
> +    help
> +      If you say yes here you get hardware monitoring support for MPS
> +      MP2925 Dual Loop Digital Multi-Phase Controller.
> +
> +      This driver can also be built as a module. If so, the module will
> +      be called mp2925.
> +
>   config SENSORS_MP2975
>   	tristate "MPS MP2975"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 29cd8a3317d2..64c1b03bf47b 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>   obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
> +obj-$(CONFIG_SENSORS_MP2925)	+= mp2925.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> diff --git a/drivers/hwmon/pmbus/mp2925.c b/drivers/hwmon/pmbus/mp2925.c
> new file mode 100644
> index 000000000000..453995fca3bf
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2925.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2925)
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +/*
> + * Vender specific register MFR_VR_MULTI_CONFIG(0x08).
> + * This register is used to obtain vid scale.
> + */
> +#define MFR_VR_MULTI_CONFIG	0x08
> +
> +#define MP2925_VOUT_DIV	512
> +#define MP2925_VOUT_OVUV_UINT	195
> +#define MP2925_VOUT_OVUV_DIV	100
> +
> +#define MP2925_PAGE_NUM	2
> +
> +#define MP2925_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_PIN | \
> +							 PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> +							 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP | \
> +							 PMBUS_HAVE_STATUS_VOUT | \
> +							 PMBUS_HAVE_STATUS_IOUT | \
> +							 PMBUS_HAVE_STATUS_TEMP | \
> +							 PMBUS_HAVE_STATUS_INPUT)
> +
> +#define MP2925_RAIL2_FUNC	(PMBUS_HAVE_PIN | PMBUS_HAVE_VOUT | \
> +							 PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | \
> +							 PMBUS_HAVE_TEMP | PMBUS_HAVE_IIN | \
> +							 PMBUS_HAVE_STATUS_VOUT | \
> +							 PMBUS_HAVE_STATUS_IOUT | \
> +							 PMBUS_HAVE_STATUS_TEMP | \
> +							 PMBUS_HAVE_STATUS_INPUT)
> +
> +struct mp2925_data {
> +	struct pmbus_driver_info info;
> +	int vout_scale[MP2925_PAGE_NUM];
> +};
> +
> +#define to_mp2925_data(x) container_of(x, struct mp2925_data, info)
> +
> +static u16 mp2925_linear_exp_transfer(u16 word, u16 expect_exponent)
> +{
> +	s16 exponent, mantissa, target_exponent;
> +
> +	exponent = ((s16)word) >> 11;
> +	mantissa = ((s16)((word & 0x7ff) << 5)) >> 5;
> +	target_exponent = (s16)((expect_exponent & 0x1f) << 11) >> 11;
> +
> +	if (exponent > target_exponent)
> +		mantissa = mantissa << (exponent - target_exponent);
> +	else
> +		mantissa = mantissa >> (target_exponent - exponent);
> +
> +	return (mantissa & 0x7ff) | ((expect_exponent << 11) & 0xf800);
> +}
> +
> +static int mp2925_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/*
> +		 * The MP2925 does not follow standard PMBus protocol completely,
> +		 * and the calculation of vout in this driver is based on direct
> +		 * format. As a result, the format of vout is enforced to direct.
> +		 */
> +		ret = PB_VOUT_MODE_DIRECT;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2925_read_word_data(struct i2c_client *client, int page, int phase,
> +				 int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2925_data *data = to_mp2925_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * data->vout_scale[page],
> +					MP2925_VOUT_DIV);
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * MP2925_VOUT_OVUV_UINT,
> +					MP2925_VOUT_OVUV_DIV);
> +		break;
> +	case PMBUS_STATUS_WORD:
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_IOUT:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_PIN:
> +	case PMBUS_READ_IIN:
> +	case PMBUS_READ_TEMPERATURE_1:
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +	case PMBUS_OT_FAULT_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +		ret = -ENODATA;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2925_write_word_data(struct i2c_client *client, int page, int reg,
> +				  u16 word)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +		/*
> +		 * The PMBUS_VIN_OV_FAULT_LIMIT, PMBUS_VIN_OV_WARN_LIMIT,
> +		 * PMBUS_VIN_UV_WARN_LIMIT and PMBUS_VIN_UV_FAULT_LIMIT
> +		 * of MP2925 is linear11 format, and the exponent is a
> +		 * constant value(5'b11100)， so the exponent of word
> +		 * parameter should be converted to 5'b11100(0x1C).
> +		 */
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    mp2925_linear_exp_transfer(word, 0x1C));
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    (ret & ~GENMASK(11, 0)) |
> +				FIELD_PREP(GENMASK(11, 0),
> +					   DIV_ROUND_CLOSEST(word * MP2925_VOUT_OVUV_DIV,
> +							     MP2925_VOUT_OVUV_UINT)));
> +		break;
> +	case PMBUS_OT_FAULT_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +		/*
> +		 * The PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT of
> +		 * MP2925 is linear11 format, and the exponent is a
> +		 * constant value(5'b00000), so the exponent of word
> +		 * parameter should be converted to 5'b00000.
> +		 */
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    mp2925_linear_exp_transfer(word, 0x00));
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		/*
> +		 * The PMBUS_IOUT_OC_FAULT_LIMIT and PMBUS_IOUT_OC_WARN_LIMIT
> +		 * of MP2925 is linear11 format, and the exponent is a
> +		 * can not be changed.
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    mp2925_linear_exp_transfer(word,
> +								       FIELD_GET(GENMASK(15, 11),
> +										 ret)));
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +mp2925_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> +			   int page)
> +{
> +	struct mp2925_data *data = to_mp2925_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (FIELD_GET(GENMASK(5, 5), ret)) {
> +		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE,
> +						page == 0 ? 3 : 4);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = i2c_smbus_read_word_data(client, MFR_VR_MULTI_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(5, 5), ret))
> +			data->vout_scale[page] = 2560;
> +		else
> +			data->vout_scale[page] = 5120;
> +	} else if (FIELD_GET(GENMASK(4, 4), ret)) {
> +		data->vout_scale[page] = 1;
> +	} else {
> +		data->vout_scale[page] = 512;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mp2925_identify(struct i2c_client *client, struct pmbus_driver_info *info)
> +{
> +	int ret;
> +
> +	ret = mp2925_identify_vout_scale(client, info, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mp2925_identify_vout_scale(client, info, 1);
> +}
> +
> +static const struct pmbus_driver_info mp2925_info = {
> +	.pages = MP2925_PAGE_NUM,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +
> +	.func[0] = MP2925_RAIL1_FUNC,
> +	.func[1] = MP2925_RAIL2_FUNC,
> +	.read_word_data = mp2925_read_word_data,
> +	.read_byte_data = mp2925_read_byte_data,
> +	.write_word_data = mp2925_write_word_data,
> +	.identify = mp2925_identify,
> +};
> +
> +static int mp2925_probe(struct i2c_client *client)
> +{
> +	struct mp2925_data *data;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2925_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2925_info, sizeof(mp2925_info));
> +
> +	return pmbus_do_probe(client, &data->info);
> +}
> +
> +static const struct i2c_device_id mp2925_id[] = {
> +	{"mp2925", 0},
> +	{"mp2929", 1},

I don't see where {0, 1} is used. If the chips do not require chip
specific handling, drop and just pass 0 for both chips. If they do,
use an enum.

Thanks,
Guenter


