Return-Path: <linux-kernel+bounces-837511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E7BAC78D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7C32259B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0172BD5A7;
	Tue, 30 Sep 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYW6DrhC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F022F6586
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228016; cv=none; b=B1c+JGbA5mdsJEpbY/C0qY6O5Cu9dM8gDaq3gGIKnyL9qtolAJbjDKRBXAB5I6vR53UDcJALYb1zhbZDh/etP7eKA91KI+64M3RU993VJnY6Oz/I5COt91q91ym0mlgnr1qU+nVSgdiC+cOr2DCClIduNrb6GZr1t5vbqelwVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228016; c=relaxed/simple;
	bh=/pFct7L/3TmKoirc4ay3nHD+g0DEGiC6uEE/GEYyMR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEFsJey2wd0h9dBmRJ408USvPTYfbFYLKWDIxSuVcBAS1dEgOKya6hrnUwSGWUTex9JQBTsDi1WvDy+2iYFKLitIIVJkQ/H6rlkNk8gHmeOnvQniIAKaOhALs7WB/Sxy+jmPGPnsJUcUzom0eimiB6tM/W2SsaGEiGWEn5nS7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYW6DrhC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26e68904f0eso58212065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759228014; x=1759832814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rHYCUF3M3bApeVBfy1czKkXiFP6t0sLs+mu2ZklUCC8=;
        b=XYW6DrhCeytLRri1gs+0afJgLKEJ4h4TmgIcTbCe/g2iIANH1IXWJV3LQCYSy3UTd3
         A0UfmLYIb0bUnMSdbkpr52+a75exqiI2LrTVhwvD2fljIAAwoT1tgzrefa/TuH+ueNDE
         aGssiuH5oKNusPcYKOa47TmK+Wb+Npgp58TGMehl63gjQjS4QDfKcNPFwpxz2xKqoCn3
         G/DH8ubUIQALfSYe4eyc2BvIsJnFb8sFdUjs+Vw0DkrxuoJqyOluRQJMiHpZfNDcVDe8
         DHaavLsaHFKYP1KQMj0cMZ64S1emMTAZ3N81QgvbC4JAcoYjMiowEfGmGqmcX1aU0//Y
         zbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759228014; x=1759832814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHYCUF3M3bApeVBfy1czKkXiFP6t0sLs+mu2ZklUCC8=;
        b=HIxYGHUwUnFTdceHScPSZ5bpaLFSaxBSrE85AtUsCXbjjDuGk/ZVSe8qh3rqzWc7js
         BbWvqyfazO73ik8Kbx6sDK+T4QTirZXicooXEFH8Vo8M7+A6rGMIhLc4RX093wT780lB
         f83DcU2TzZx7oW+vMlvwp5o89mAAuRXlgdCJCqk645ziTO09g5ff2utGdUdbBpyromvS
         sXfBq0x1kYG3W6pXNw650Qqjy7oYjq9rUDYbAgcdrFlNtmE7dv5e0JC0oMpPm6exVrli
         TieMarZJ09m4c39Nrso8I2iU9PBGvw14byJa+KgxpWv8NpyTnkimjqXgWtuY4WORzpKP
         6CWA==
X-Forwarded-Encrypted: i=1; AJvYcCWKhM/x3NaUrIx45v4DD0btuq6LWKe7n2ZhpU8m0uqn01a74XY0bso2ZTMEN8oB8eODeXJQ9peF9Tb5WF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Gnof4TE91b8Gju+g5fb5Y1FFRTnLPO0CJU1ucFzgxkkWoFRu
	7H+5cTXW38VsfHzxQqSDarHi9BeOlTVROtOcrWwlEbgFGYxOwjLVQRL8
X-Gm-Gg: ASbGncvjehB3E91AHoy20lxT8TA0e5mBkgaNFEJ4yLwTYlMhhSZG8o0A+4y3cs7d/1m
	LLLyFNs7BZTjybRCwjq/oii1NBmQxLEzdlyG22IfooXVHq953vB88EgLgIWcht5kHhfF5y3JcJy
	++THahnS7Bc5LsgZEVeafilKa4ZIHjT2E7oNq8HtPUAV9ti6RIfwJSg8FknwUR3KcCRQY+YdR/G
	6tEDDwfXOzjJ6E6UMIgK1tYnZ5UdXeeTh7Dsv7RID/iuthbp9TTvoY0u2tEfurnmAVbLOA8Z9Z3
	iI+NKARvwcnM4T93v1V1IbuERxJ4iRzDJM5SxK+Q66gXaXo1qMqx2NrmOsJ8Hr4ZNwxLPY0SIwG
	G7jP+oWwC84KmU/MeO6Ll90fyrVVUsnsSUmVAQfqfiq5Nr709f9Vx2nNZn8KD6C5YTP+94rgFM3
	h0Eq8n1/DVFwz0LIMEbd8htn2Yx+ZPqg==
X-Google-Smtp-Source: AGHT+IHyO4juYjcFOs9ygZMd8gLEwThxV9Bz494Qnh1VF+UsR7xWJvDDdlI/i2g2T1XCNCwT25MFWQ==
X-Received: by 2002:a17:902:d50b:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-27ed4a7ebb9mr232993795ad.37.1759228014001;
        Tue, 30 Sep 2025 03:26:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a339dsm13330921a12.40.2025.09.30.03.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:26:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c0ebd50a-0e44-4262-ab10-33803b3dbfb7@roeck-us.net>
Date: Tue, 30 Sep 2025 03:26:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (pmbus/max17616): add driver for max17616
To: Kim Seer Paller <kimseer.paller@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
 <20250930-upstream-max17616-v1-2-1525a85f126c@analog.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250930-upstream-max17616-v1-2-1525a85f126c@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 22:02, Kim Seer Paller wrote:
> Add support for MAX17616/MAX17616A current-limiter with
> overvoltage/surge, undervoltage, reverse polarity, loss of ground
> protection with PMBus interface. The PMBus interface allows monitoring
> of input/output voltages, output current and temperature.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

I am a bit concerned about VOUT_UV_FAULT_LIMIT which is completely non-standard.
Did you check with real hardware that in2_lcrit is not instantiated ?

Thanks,
Guenter

> ---
>   Documentation/hwmon/index.rst    |  1 +
>   Documentation/hwmon/max17616.rst | 62 ++++++++++++++++++++++++++++++++++
>   MAINTAINERS                      |  2 ++
>   drivers/hwmon/pmbus/Kconfig      |  9 +++++
>   drivers/hwmon/pmbus/Makefile     |  1 +
>   drivers/hwmon/pmbus/max17616.c   | 73 ++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 148 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 51a5bdf75b08656ee6499c6b5c50a51fc4d7c210..62c5d10f16ae722dd2e6a4f8953ae24b5f541666 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -151,6 +151,7 @@ Hardware Monitoring Kernel Drivers
>      max1619
>      max16601
>      max1668
> +   max17616
>      max197
>      max20730
>      max20751
> diff --git a/Documentation/hwmon/max17616.rst b/Documentation/hwmon/max17616.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..936447159f87a9c6b270b903c46b43a90caddb23
> --- /dev/null
> +++ b/Documentation/hwmon/max17616.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver max17616
> +====================
> +
> +Supported chips:
> +
> +  * Analog Devices MAX17616/MAX17616A
> +
> +    Prefix: 'max17616'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max17616-max17616a.pdf
> +
> +Author:
> +
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Analog Devices MAX17616/MAX17616A
> +Current-Limiter with OV/Surge, UV, Reverse Polarity, Loss of Ground Protection
> +with PMBus Interface.
> +
> +The MAX17616/MAX17616A is a 3V to 80V, 7A current-limiter with overvoltage,
> +surge, undervoltage, reverse polarity, and loss of ground protection. Through
> +the PMBus interface, the device can monitor input/output voltages, output current
> +and temperature.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate
> +the devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
> +for details.
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +Sysfs entries
> +-------------
> +
> +================= ========================================
> +in1_label         "vin"
> +in1_input         Measured input voltage
> +in1_alarm	  Input voltage alarm
> +in2_label	  "vout1"
> +in2_input	  Measured output voltage
> +curr1_label	  "iout1"
> +curr1_input	  Measured output current.
> +curr1_alarm	  Output current alarm
> +temp1_input       Measured temperature
> +temp1_alarm       Chip temperature alarm
> +================= ========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89d35faf93c9d2e984b73f5c09d09044ee6eddb2..267ab428260a29c38fa508190bdfa2677bba58c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14923,6 +14923,8 @@ L:	linux-hwmon@vger.kernel.org
>   S:	Supported
>   W:	https://ez.analog.com/linux-software-drivers
>   F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
> +F:	Documentation/hwmon/max17616.rst
> +F:	drivers/hwmon/pmbus/max17616.c
>   
>   MAX2175 SDR TUNER DRIVER
>   M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index da04ff6df28bd12909c9140662d6b932a150bd97..def5faad8fdf56eb31fe216322ead57ee43a1ac5 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -320,6 +320,15 @@ config SENSORS_MAX16601
>   	  This driver can also be built as a module. If so, the module will
>   	  be called max16601.
>   
> +config SENSORS_MAX17616
> +	tristate "Analog Devices MAX17616/MAX17616A"
> +	help
> +	  If you say yes here you get hardware monitoring support for Analog
> +	  Devices MAX17616/MAX17616A.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called max17616.
> +
>   config SENSORS_MAX20730
>   	tristate "Maxim MAX20710, MAX20730, MAX20734, MAX20743"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4c5ff3f32c5ecbea069dce8af3e3e8365892b278..9cebe488fdf18b2aa164c0fc2ac7d1d8ffd2b970 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_LTC4286)	+= ltc4286.o
>   obj-$(CONFIG_SENSORS_MAX15301)	+= max15301.o
>   obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
>   obj-$(CONFIG_SENSORS_MAX16601)	+= max16601.o
> +obj-$(CONFIG_SENSORS_MAX17616)	+= max17616.o
>   obj-$(CONFIG_SENSORS_MAX20730)	+= max20730.o
>   obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
>   obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
> diff --git a/drivers/hwmon/pmbus/max17616.c b/drivers/hwmon/pmbus/max17616.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1d4a0ddb95bb6e8349932062be0d918f935cd846
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/max17616.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hardware monitoring driver for Analog Devices MAX17616/MAX17616A
> + *
> + * Copyright (C) 2025 Analog Devices, Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info max17616_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.m[PSC_VOLTAGE_IN] = 512,
> +	.b[PSC_VOLTAGE_IN] = -18,
> +	.R[PSC_VOLTAGE_IN] = -1,
> +
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.m[PSC_VOLTAGE_OUT] = 512,
> +	.b[PSC_VOLTAGE_OUT] = -18,
> +	.R[PSC_VOLTAGE_OUT] = -1,
> +
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.m[PSC_CURRENT_OUT] = 5845,
> +	.b[PSC_CURRENT_OUT] = 80,
> +	.R[PSC_CURRENT_OUT] = -1,
> +
> +	.format[PSC_TEMPERATURE] = direct,
> +	.m[PSC_TEMPERATURE] = 71,
> +	.b[PSC_TEMPERATURE] = 19653,
> +	.R[PSC_TEMPERATURE] = -1,
> +
> +	.func[0] =  PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +		    PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT |
> +		    PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
> +		    PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int max17616_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &max17616_info);
> +}
> +
> +static const struct i2c_device_id max17616_id[] = {
> +	{ "max17616" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max17616_id);
> +
> +static const struct of_device_id max17616_of_match[] = {
> +	{ .compatible = "adi,max17616" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max17616_of_match);
> +
> +static struct i2c_driver max17616_driver = {
> +	.driver = {
> +		.name = "max17616",
> +		.of_match_table = max17616_of_match,
> +	},
> +	.probe = max17616_probe,
> +	.id_table = max17616_id,
> +};
> +module_i2c_driver(max17616_driver);
> +
> +MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
> +MODULE_DESCRIPTION("PMBus driver for Analog Devices MAX17616/MAX17616A");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("PMBUS");
> 


