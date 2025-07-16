Return-Path: <linux-kernel+bounces-734255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DEDB07F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF11895E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030B2D0C7C;
	Wed, 16 Jul 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LknWfePa"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD126FA4B;
	Wed, 16 Jul 2025 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698213; cv=none; b=MJYsafdKq+oW813to/1P2Fn+WZaaamTtjfZKTOC8NjzOaHF3Orbje81UzzuBuYZi2OroCLxFEc4LM6OdTvE3v4aNAYj9XsZ257xc7TBDUeAGMzir5Te6EomB8+JjiXBwGr5FwqcVPyqPBLXdwnwEgj/m6CJJdE1CYcI0h6ryEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698213; c=relaxed/simple;
	bh=MlMNGYQ8dO20s6aDXbSVRiR+xyHC7RFvXF/g3yeXQIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAQZx5ZKm1HgZ/qD9Jttu38SmI6Pe+ynNLQN69s/J7bYOM1UiWv8NHaPlB+wjzuXM4EDVjzm7pVFbYlj2RukYB4ieFTNB7fPFXKQcwgg95nKRZILhVosWw690U9peKssLO1mPTP2R6aAG05lQX+S+H5PsCdwFmLURSYhEyflURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LknWfePa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso229824b3a.0;
        Wed, 16 Jul 2025 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752698211; x=1753303011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dGK7tdjJS9+xErtdZGDdl6eWBQ2higLM/1xo+A5Ke+E=;
        b=LknWfePaNtIRvt1s0FyO5kG/kQt4deEOnFC7YciyfIs7AnZIgeN0FTyQlJSBYQ2+OG
         AJa82iRen5Mvu+pX9acuKQ/9dYIqR8WoqZYyCyfJRe3PfBKXMmvA/r2BzqR76HEYBTXI
         RnnG041ahEApPrmMLzt305vSsjwhsn/SJ+13X6kyk4iq1V7OkDWU1qsjsk+dZEeLvtPp
         /366qannB7q10M8sKt0xEmQUO68+H5bGMVRqgVTmF3iZRDdxVlqyExiOR/UgMO9b6Oja
         7RS+yDDKYOtj3omysfhMhXPhpWmXfeK2XiOjGoW3AR4WxaDI77FLTFRcZLQer7jy+Pi9
         Z6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752698211; x=1753303011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGK7tdjJS9+xErtdZGDdl6eWBQ2higLM/1xo+A5Ke+E=;
        b=spSA3udKgTWk1kGd/7CcyMOWtC5eEVs05Kkp1x0pqm11PmSC1eUsEvt9YU43K9urwn
         QMWnfUChJiCJYi7N8l00V7XV/cuNKRAxBcn/x02WOphMrosS6tskr5lzopMK/0+5Sfo1
         /VJFd+DcF6qP2q7jFrhdbXgBOp/DPzXxqjUTWHi9ZQ5i8oHEwuYwY2EplIT4f5qlzZC0
         MgNzfEiF/nAA3G+SkVPW/uCnPIIS3Q0eGNBshk/pqidzLq8DFriTqYJiWEE5LdoBAI6l
         53Te+NwKXnAILhjytW+465mevguU78Lrls4jijlnL9R1H8WzArUNyHclXLN+O3IgzBQq
         DVmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/td0NKnA7fNibDc4I4cwJ/WS9YNUkcLdVZ5mfi+gahmj2jQeBQQzMqZFNU3QViGr+EVeZHbOaEgXy@vger.kernel.org, AJvYcCUfgoYRDaz+OMqq+i/UFQlV6aVplASJ3ijcpiws6l/w3SdGydAJjb9F8JDGzEefOE/9I3bS+CUOMfUJfwI=@vger.kernel.org, AJvYcCV+0mK3cCf0uaFs5VM2HgR+z+kMVW8zLo1cPtIOXW6Qv+Ewem0n1bYIE4umMiIOesiHJcZ5iP2dqk0F@vger.kernel.org, AJvYcCXBbZh+Yr4UzPWa7hoplNITk2Egn9ZjWlTTa63Z4tksp5PhYmduDXjXi26TNGApJK8eCsYmgfHE20dKXTn4@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlaEPKce9ZLQFwZkOhJUMhholmMj6cCLKitQjBB67m+FobBZL
	Ht3a86ocH5sV/2FoGQf9yVSLaLzhP7TYk/TwRZBcCOwYF7tbhtwwXQw2
X-Gm-Gg: ASbGncuzF5ByjOpmrwqeCRTTbdEJ+fNtEfb8VpPMk6lWpHlP5AmOAJK3FMctWYN57xq
	nG2jOHwa5ws4dPL6V8F6RJOyX60Fz2ECC8EJAjOJMT8ItWVEyL0nAMluzDQ3/lFmAZzejGdnMMO
	IX+0Zl34q8ltrvcyCR4ZtQTygVjJ8tgY/xxPWgrDPYE/ruB3RsHYUZY3iL4619c/fPS98siBmQ3
	OyUhddk8dB8idirh+sSAPIqwj5cDJy7LT57bkGNCnf4XbUo5v6s2Baf4TQ0mQXLRf/+okXMyTW5
	G8ZUa0w5Fxw5SMK1FmlC0pmu+NPugw0uKZxzjTQdaTphAr6ZRyvgjGQAZt8BoPh+hDrtrtuQxaU
	kqZJHeeyBq7p35f2FxKzfy2XP+JoQQYZCcEatpmIzYlY69u3JIzAk90NqwSPl60ulDj40yos=
X-Google-Smtp-Source: AGHT+IHC2TDtP7ayXT+F/AwOOBUrWElNyGsML+/uuXUSdQ8RGpxEC7Y5K3FXXAP7ltt9S4GgUr6SGA==
X-Received: by 2002:a05:6a00:2d19:b0:749:14b5:921f with SMTP id d2e1a72fcca58-75724a8ac06mr5687709b3a.18.1752698210983;
        Wed, 16 Jul 2025 13:36:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7134sm15293965b3a.19.2025.07.16.13.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 13:36:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ac652108-68aa-49d1-a448-1c0ee6ca157e@roeck-us.net>
Date: Wed, 16 Jul 2025 13:36:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) Add support for MPS multi-phase
 mp2869a/mp29612a controllers
To: tzuhao.wtmh@gmail.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Henry Wu <Henry_Wu@quantatw.com>, Grant Peltier <grantpeltier93@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Cherrence Sarip <cherrence.sarip@analog.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Leo Yang <leo.yang.sy0@gmail.com>,
 John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Alex Vdovydchenko <xzeol@yahoo.com>, Ninad Palsule <ninad@linux.ibm.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
References: <20250630112120.588246-1-Henry_Wu@quantatw.com>
 <20250630112120.588246-2-Henry_Wu@quantatw.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250630112120.588246-2-Henry_Wu@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 04:20, tzuhao.wtmh@gmail.com wrote:
> From: Henry Wu <Henry_Wu@quantatw.com>
> 
> Add support for the mp2869a and mp29612a controllers from Monolithic Power
> Systems, Inc. (MPS). These are dual-loop, digital, multi-phase modulation
> controllers.
> 
> Signed-off-by: Henry Wu <Henry_Wu@quantatw.com>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/mp2869a.rst |  86 +++++++++
>   drivers/hwmon/pmbus/Kconfig     |  10 ++
>   drivers/hwmon/pmbus/Makefile    |   1 +
>   drivers/hwmon/pmbus/mp2869a.c   | 299 ++++++++++++++++++++++++++++++++
>   5 files changed, 397 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2869a.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2869a.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b45bfb4ebf30..10bf4bd77f7b 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -172,6 +172,7 @@ Hardware Monitoring Kernel Drivers
>      menf21bmc
>      mlxreg-fan
>      mp2856
> +   mp2869a
>      mp2888
>      mp2891
>      mp2975
> diff --git a/Documentation/hwmon/mp2869a.rst b/Documentation/hwmon/mp2869a.rst
> new file mode 100644
> index 000000000000..a98ccb3d630d
> --- /dev/null
> +++ b/Documentation/hwmon/mp2869a.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp2896a
> +=====================
> +
> +Supported chips:
> +
> +  * MPS MP2896A
> +
> +    Prefix: 'mp2896a'
> +
> +  * MPS MP29612A
> +
> +    Prefix: 'mp29612a'
> +
> +Author:
> +
> +    Henry Wu <Henry_WU@quantatw.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP2896A, a digital, multi-phase voltage regulator controller with PMBus interface.
> +
> +This device:
> +
> +- Supports up to two power rails.
> +- Supports multiple PMBus pages for telemetry and configuration.
> +- Supports VOUT readout in **VID format only** (no support for direct format).
> +- Supports AMD SVI3 VID protocol with 5-mV/LSB resolution (if applicable).
> +- Uses vendor-specific registers for VOUT scaling and phase configuration.
> +
> +Device supports:
> +
> +- SVID interface.
> +- AVSBus interface.
> +
> +Device compliant with:
> +
> +- PMBus rev 1.3 interface.
> +
> +Sysfs Interface
> +---------------
> +
> +The driver provides the following sysfs attributes:
> +
> +**Current measurements:**
> +
> +- Index 1: "iin"
> +- Indexes 2, 3: "iout"
> +
> +**curr[1-3]_alarm**
> +**curr[1-3]_input**
> +**curr[1-3]_label**
> +
> +**Voltage measurements:**
> +
> +- Index 1: "vin"
> +- Indexes 2, 3: "vout"
> +
> +**in[1-3]_crit**
> +**in[1-3]_crit_alarm**
> +**in[1-3]_input**
> +**in[1-3]_label**
> +**in[1-3]_lcrit**
> +**in[1-3]_lcrit_alarm**
> +
> +**Power measurements:**
> +
> +- Index 1: "pin"
> +- Indexes 2, 3: "pout"
> +
> +**power[1-3]_alarm**
> +**power[1-3]_input**
> +**power[1-3]_label**
> +
> +**Temperature measurements:**
> +
> +**temp[1-2]_crit**
> +**temp[1-2]_crit_alarm**
> +**temp[1-2]_input**
> +**temp[1-2]_max**
> +**temp[1-2]_max_alarm**
> +
> +
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 441f984a859d..93b558761cc6 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -364,6 +364,16 @@ config SENSORS_MP2856
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp2856.
>   
> +config SENSORS_MP2869A
> +	tristate "MP2869A PMBus sensor"
> +	depends on I2C && PMBUS
> +	help
> +	  If you say yes here you get support for the MPS MP2869A MP29612A
> +	  voltage regulator via the PMBus interface.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mp2869a.
> +
>   config SENSORS_MP2888
>   	tristate "MPS MP2888"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 29cd8a3317d2..42087d0dedbc 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>   obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>   obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>   obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
> +obj-$(CONFIG_SENSORS_MP2869A)   += mp2869a.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> diff --git a/drivers/hwmon/pmbus/mp2869a.c b/drivers/hwmon/pmbus/mp2869a.c
> new file mode 100644
> index 000000000000..e61f1380dbc1
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2869a.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MP2856A/MP29612A
> + * Monolithic Power Systems VR Controller
> + *
> + * Copyright (C) 2023 Quanta Computer lnc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +/* Vendor specific registers. */
> +#define MP2869A_VOUT_MODE			 0x20

Standard register.

> +#define MP2869A_VOUT_MODE_MASK		 GENMASK(7, 5)
> +#define MP2869A_VOUT_MODE_VID		 (0 << 5)
> +
> +#define MP2869A_READ_VOUT			 0x8b

Standard register.
> +
> +#define MP2869A_MFR_VOUT_SCALE_LOOP	 0x29

Standard register.

Guenter


