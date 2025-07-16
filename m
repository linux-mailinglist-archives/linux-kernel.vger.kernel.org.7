Return-Path: <linux-kernel+bounces-734248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B95B07EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FB1C405AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30C2BE652;
	Wed, 16 Jul 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amVHrlQq"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7C4501A;
	Wed, 16 Jul 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697856; cv=none; b=BRYz8F4wC8ph4lTxtbe+nczUAlhBbWY0K8bPG870f0KbopysLxM8luFvk5nkHHiOLiGQODFEtreZ9ruQa0LYvU2jZfkqKVgdZIhopzuAD41BMP1tOKCYW/Vur0UWi/+kpkwKhY0H5QSxbTCaZSc+nagBGDoe5/B3/MtBN4oDgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697856; c=relaxed/simple;
	bh=W+tj1VjebJyBlbDrUwyTO4k6ZV8Fx/M7ZW+IIVwIEeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgraYoU0WqEO0uCsg5iP0T4piNMsLWTIhhlmDkNiWqegadzI5OMX8cGPcMTSvWLyp06BYmvK4V86/kxJIT9vWe/iB8Dxue4waGWu2XrNoRIrSNiJkN+x5rrKKv448rtyJ0vRr6MMu82kc+iU58NmnuVXMCCU5V8HkaErXN+IdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amVHrlQq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748d982e97cso302618b3a.1;
        Wed, 16 Jul 2025 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752697854; x=1753302654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jToX5vgvYOWNpQ7PhcvwxjAp3iiECWlZTnbgwdsh67M=;
        b=amVHrlQq01/RHDjHkMha+Cs7NG1vXBEdIw80tdQ9bGaBLSKX3byryTLBpy3A41z0C7
         u60ybXFRod+tD9/E8u97Jvuc1AXsM7O3pEd/G1G2Lsp28yMNUfJnFzmWdywVKf/Nu/IJ
         DUNZvdUdK3GV/xdXmRF9CpqRzxjmlYEzWvaVJ7/gs2w9pUQfq2LnjKQQ5P7gPC2wR1pa
         Xz2Kl9f130jfEv29V3pAAXIJnp9vCn13LBoKDgW0P2qaCPb5FFm4kCavOddIyaToN2Z/
         N5lXKTCjFNsfSxxTfYiSAm93qPkH7VFkaGcCMPsac+/qA4P9pyDy9os0tHUNb095cwOo
         4OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697854; x=1753302654;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jToX5vgvYOWNpQ7PhcvwxjAp3iiECWlZTnbgwdsh67M=;
        b=pvfg/V9Isld4kmC22PlpjQ20VXjJFilbEiHq5M0EuqIlhVZ8e0fvoTmsLvPavYHs6e
         OcC+0Yz3cZ3XWy7p87iJbqa4M5Dp5ARQaLrnuuh9ka5UrynaNmzFXeHFGRSuUCFBjdWs
         bh0YsVH1+IHy7/oYFBZvH+LuiJbgfGPJE46IhvriaSCdOP8zsNr59wclGjdknNqzlnl1
         grfDMWIP8QQBO3gBwNP3WaUvtn2T2phDN4esYGmC6Gwxzs+HjyoXtA9RxEPZ05NhxU0Z
         vbtyeRGBQLtMBnHa4ldlALsa4FUkH/XojLdUvvJxpSO6JvulMPoCbzMwSis7psQ4D+f4
         zjJg==
X-Forwarded-Encrypted: i=1; AJvYcCUGb6ltacql5wvXb6A/38lBd5XOidIy6IKMkUkg1ZhXp2DvPPy+Wq2RF9h2beo6aXeScvA2cGmwvjOFzJUY@vger.kernel.org, AJvYcCWTIxmsVsuByKw8vHiVbp5fh5uBcUWr2FsNQVatkbYszcPuvKiloWm4ZexQV3brgEyv2tCwhw3E2jeg7nY=@vger.kernel.org, AJvYcCWtX07KWi2CNy4dQkhrQJdu8OKzvfg7ncc+2UPjQzrg9Nvr0UH7MNE7ZJOYZrujQQFsRe/LZ20jYCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWOFBfC4q4U/Qydq7ltaa3KivRwgefwsbgSgvTCBRgXYBA6B3
	Q67Ln3FNKvhhw7Ue9QI/B9D/bm2Xe/Px4OvuN63kfYFHCeU9+71f0XnlcdsTHQ==
X-Gm-Gg: ASbGncuLJFllOIifOKlMTvEKZu4FaoUmgZ9Mu9g8wRCDg/XP2H9oyLEVXYo2jctrJqO
	cvo+QBtCg0qPx4lg5YtAbS6Hu8PaIiFB+J9EQX3M1gqwlUcFJ4fEl3rBqs0i+25oLvB6cyFk9H4
	NBuAajO8138b7BnLEdAhOq8XdefDGP/zDTv6YlNaVDBUZMi3sNtkT3w6ty3x2Ey6Kjgcaqhy3eU
	vqjPKCdxtOtDtKEQQ792JGInPK4WYyxX8zJ3ZCHhWHSVeAucFgv5t35FlIN+4YXKptwS1upuYno
	AcnDA5FVJqkmrxwKEwNE4PaWVezjZpJXlHCZTx/gVqUYz1Scu7zlMkDL3iqoi1BKzpcd8HmnHZg
	c8r4ceSjuznFI0EQrQX3MhVU7FiQ+YZH6oYF37AEtpSxK2ga6j0I9VSGbbkuaxjZGHfYcZAI=
X-Google-Smtp-Source: AGHT+IHAttu6gwxIToTJ+F1XiyqkL1tlyMlREf+ZnPiny7r/1mgK6Gn/BYUZnN0LtcXBYnOaReNjgw==
X-Received: by 2002:a05:6300:619c:b0:232:c9de:4d98 with SMTP id adf61e73a8af0-23811055d11mr6953618637.11.1752697853925;
        Wed, 16 Jul 2025 13:30:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52cbcasm14152134a12.4.2025.07.16.13.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 13:30:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <039c31c3-af15-46e0-98fb-f3a54fcf73e5@roeck-us.net>
Date: Wed, 16 Jul 2025 13:30:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add MP2869 series and MP29502 driver
To: wenswang@yeah.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250709092734.455976-1-wenswang@yeah.net>
 <20250709093420.456304-1-wenswang@yeah.net>
 <20250709093420.456304-2-wenswang@yeah.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250709093420.456304-2-wenswang@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 02:34, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2869 series and mp29502 controller. The
> driver exposes telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
> ---
> V2 -> V3:
>      merge patches for MP29502 and MP2869
> 
> V1 -> V2:
>      add Rob's Acked-by
> 
>   Documentation/hwmon/index.rst   |   2 +
>   Documentation/hwmon/mp2869.rst  | 175 ++++++++
>   Documentation/hwmon/mp29502.rst |  93 +++++
>   MAINTAINERS                     |   9 +
>   drivers/hwmon/pmbus/Kconfig     |  18 +
>   drivers/hwmon/pmbus/Makefile    |   2 +
>   drivers/hwmon/pmbus/mp2869.c    | 711 ++++++++++++++++++++++++++++++++
>   drivers/hwmon/pmbus/mp29502.c   | 670 ++++++++++++++++++++++++++++++
>   8 files changed, 1680 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2869.rst
>   create mode 100644 Documentation/hwmon/mp29502.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2869.c
>   create mode 100644 drivers/hwmon/pmbus/mp29502.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b45bfb4ebf30..ebc5c92e50b0 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -172,8 +172,10 @@ Hardware Monitoring Kernel Drivers
>      menf21bmc
>      mlxreg-fan
>      mp2856
> +   mp2869
>      mp2888
>      mp2891
> +   mp29502
>      mp2975
>      mp2993
>      mp5023
> diff --git a/Documentation/hwmon/mp2869.rst b/Documentation/hwmon/mp2869.rst
> new file mode 100644
> index 000000000000..2d9d65fc86b6
> --- /dev/null
> +++ b/Documentation/hwmon/mp2869.rst
> @@ -0,0 +1,175 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp2869
> +====================
> +
> +Supported chips:
> +
> +  * MPS mp2869
> +
> +    Prefix: 'mp2869'
> +
> +  * MPS mp29608
> +
> +    Prefix: 'mp29608'
> +
> +  * MPS mp29612
> +
> +    Prefix: 'mp29612'
> +
> +  * MPS mp29816
> +
> +    Prefix: 'mp29816'
> +
> +Author:
> +
> +	Wensheng Wang <wenswang@yeah.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP2869 Dual Loop Digital Multi-phase Controller.
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
> +**curr2_input**
> +
> +**curr2_label**
> +
> +The driver provides the following attributes for output current:
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
> +**curr4_input**
> +
> +**curr4_label**
> +
> +**curr4_crit**
> +
> +**curr4_crit_alarm**
> +
> +**curr4_max**
> +
> +**curr4_max_alarm**
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
> +**power3_input**
> +
> +**power3_label**
> +
> +**power3_max**
> +
> +**power3_max_alarm**
> +
> +**power4_input**
> +
> +**power4_label**
> +
> +**power4_input**
> +
> +**power4_label**
> +
> +**power4_max**
> +
> +**power4_max_alarm**
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
> diff --git a/Documentation/hwmon/mp29502.rst b/Documentation/hwmon/mp29502.rst
> new file mode 100644
> index 000000000000..7743056f0aa6
> --- /dev/null
> +++ b/Documentation/hwmon/mp29502.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp29502
> +====================
> +
> +Supported chips:
> +
> +  * MPS mp29502
> +
> +    Prefix: 'mp29502'
> +
> +Author:
> +
> +	Wensheng Wang <wenswang@yeah.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP29502 Digital Multi-phase Controller.
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
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +The driver provides the following attributes for output power:
> +
> +**power2_input**
> +
> +**power2_label**
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 240793fbe64b..b4377f0eb3a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16839,6 +16839,15 @@ F:	scripts/module*
>   F:	tools/testing/selftests/kmod/
>   F:	tools/testing/selftests/module/
>   
> +MONOLITHIC POWER SYSTEM MULTI-PHASE CONTROLLER DRIVER
> +M:	Wensheng Wang <wenswang@yeah.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/mp2869.rst
> +F:	Documentation/hwmon/mp29502.rst
> +F:	drivers/hwmon/pmbus/mp2869.c
> +F:	drivers/hwmon/pmbus/mp29502.c
> +
>   MONOLITHIC POWER SYSTEM PMIC DRIVER
>   M:	Saravanan Sekar <sravanhome@gmail.com>
>   S:	Maintained
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 441f984a859d..d0bdd1b5feb6 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -364,6 +364,15 @@ config SENSORS_MP2856
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp2856.
>   
> +config SENSORS_MP2869
> +	tristate "MPS MP2869"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP2869 Dual Loop Digital Multi-Phase Controller.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp2869.
> +
>   config SENSORS_MP2888
>   	tristate "MPS MP2888"
>   	help
> @@ -382,6 +391,15 @@ config SENSORS_MP2891
>         This driver can also be built as a module. If so, the module will
>         be called mp2891.
>   
> +config SENSORS_MP29502
> +	tristate "MPS MP29502"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP29502 Dual Loop Digital Multi-Phase Controller.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp29502.
> +
>   config SENSORS_MP2975
>   	tristate "MPS MP2975"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 29cd8a3317d2..4c5ff3f32c5e 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -37,8 +37,10 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>   obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>   obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>   obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
> +obj-$(CONFIG_SENSORS_MP2869)	+= mp2869.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
> +obj-$(CONFIG_SENSORS_MP29502)	+= mp29502.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c
> new file mode 100644
> index 000000000000..af233ffd5230
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2869.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2869)
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +#define MFR_READ_PIN_EST	0x94
> +#define MFR_READ_IIN_EST	0x95
> +#define MFR_VOUT_SCALE_LOOP	0x29

This is a standard register.

> +#define MFR_SVI3_IOUT_PRT	0x67
> +#define STATUS_MFR_SPECIFIC	0x80

This is a standard register.

Guenter

