Return-Path: <linux-kernel+bounces-880636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60544C26336
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5394F9383
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DE2ED866;
	Fri, 31 Oct 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ7y6Hb1"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425802F658D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928916; cv=none; b=dLBXzXodk1XntToQ/RXMa/toGFUv2vw8orw1UrL65DfChH05kJm47f5a9ntFcks9qJjo/bnQ3Dia28rKaYGu1xctcNvqQ5ZTLF8NNoGDVvzUtdTxdNaGY+9JWAYwDvSg1YnYlSwJikWJaAmhz6qU+LHZQwJBv2pEzKWz0eFWxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928916; c=relaxed/simple;
	bh=5kmQq7WJLX2koFEJb0nLbANptn/vC1hqkAXIpQVeYyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9Ewv9b2lfzEVLAIpuZ3FDKsSFJA9djhbn4yz/W1c9z4d4lMR4olc6dsg5+1n9fiU2xLdz/sQRJ3QHizOpiDaUMfobrqIjol2l6mKOqWpuzaZkvbcPypQ45t1iOWSXbEPHQCnMC2jF+4zKqeJ9DGf65x7AJTYexlfzPOlH2fk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ7y6Hb1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1934935a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761928903; x=1762533703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xmnfwJ9uChdu7snFsfiUQa1g3k0ftv31458S0do0GG8=;
        b=HQ7y6Hb147xcteD+u+mqDBcyCmeNrXeKIrdykDjc0j7K7gdRF5ELM0iTCiGkpv1jzJ
         +6A0umdytsr0lwjj0AK1b4qUzpA+Q9pWh8M4tlwLs1E47EKEmDTRLZGH+VqEoEpO6Jcf
         jWHdy6eARMMYQ/gGSZNXmJSrYIndZBd/zr8I207v2K51+FeN26Vc/TsfeVBRdS/hbbwv
         G6kXfxf+g0+GNrYGcfocTcR+HKM4tfZJUSEOgBWl50JH9xAwWoRugoTrAx8N+Spb2E6F
         jLPsbx9IgUD/BHKsxvXYRVlVF4pOfJPfhG9J5ogQfu5zZqNcwU4CwLrsMk938o8LJSYx
         pPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928903; x=1762533703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmnfwJ9uChdu7snFsfiUQa1g3k0ftv31458S0do0GG8=;
        b=awQ3WvswWYhc2a8e34IBWK4FnbvtE8d2EUWRhcT9kfNHbF5EaoFitasfFjG0w5Algc
         mHdO9pciA1KxDnnFtR2B5xJYYWtejKJlTWCjLpfwgcYXQymwxo/SBtyiyI/FwfS8Sj6k
         T0dYOqPmePC3dE6SKrPTVF3SNLgu6swOtje8JXP7WAovXq9WL/6lI69+MgQ2jTyz8l8n
         eUvGmvLf2RWgU1RpYMUNjeMjOQVDH2bP6bQ2ctrMhEpnv/g+riOPOqfbyvhf/wzTWTt9
         VcWogmko8HE+t/GxU3cJHhU6bYR5R6QGPy9seiJh72MtDON/uH1CrNGKYokqXKpI7xtO
         Y03A==
X-Forwarded-Encrypted: i=1; AJvYcCVICDw8l9o2IIPm+l5E/gIVYSulaHZyhbKIh2HUDDxHFN0pDZgmpQrAxpNlVHQw/SvB66Z42xC6xVL99Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+AVDIVRjYtFDp4Hy8D0eKFNstIBRrAXYXMTU/jjfHZbPIj4dG
	MOlKAzs1FS3w9ExZDrfcSzrvXehwkjg2nafzrPSaUHyawtF1RShZPis8
X-Gm-Gg: ASbGnculZB5xl71w87/GCCa1BfrohR3v9g2bgMuMamY+ejEPqlLbtQBpw2JlX4vNRxv
	GYVTzwwZ0lhVuZUMbVWYQ3A0/Twfs07AYscUDduEqYbjf6MtlQua86kKoNijqk0QnXz/YvjBIx2
	lTKCgpXi7jLy5PYa/ZKH8ppqh7EmVbPkP4wfyjS4FBY89d7oalm/uAxvV2VpizovUeRNJA2OAVk
	5/8E1tvIlgc97G7Js0R+qmzb8Vn9DPwK8mtp0bomqUtHK4iTTlFmKC3C+R4RcUexHo6b+zWkABc
	GxmLBEQXAIqnGV5HT3Fsla92NZ+EL0pwoYdXcRJZ5oH+m7kyTa0ZUiOEIl2/yYmm9Thf1IhRwPx
	sxYVGU8h/WhVVoxdmNME3C0qK4H+8tGEtPbIr+j350F66cxJFRSwbPPkPs6CKOv3xAm9wFUgYnK
	CjgUkhPsUcKSWIPafLG7G6VCScCs6edV4e0u+0IZlu6MObARfgN6MLR2QgnpEaBfZg8/YROQ==
X-Google-Smtp-Source: AGHT+IFVmnOVvRSM3OO6J4X1cC5xGRgTx6vu3BUS6e7KqVLMJW3wTOJjGxZic1sHccsX+T6uykxZ7g==
X-Received: by 2002:a17:902:f689:b0:269:936c:88da with SMTP id d9443c01a7336-2951a474e88mr62168265ad.41.1761928902596;
        Fri, 31 Oct 2025 09:41:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f574sm28648165ad.53.2025.10.31.09.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:41:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bfd9a2b0-47c1-4e88-861c-87226cb74184@roeck-us.net>
Date: Fri, 31 Oct 2025 09:41:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: add support for MCP998X
To: victor.duicu@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net
Cc: marius.cristea@microchip.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251031155831.42763-1-victor.duicu@microchip.com>
 <20251031155831.42763-3-victor.duicu@microchip.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251031155831.42763-3-victor.duicu@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/31/25 08:58, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 

If possible, please send me register dumps for the supported chips.

> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/mcp9982.rst |  94 ++++
>   MAINTAINERS                     |   2 +
>   drivers/hwmon/Kconfig           |  10 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/mcp9982.c         | 756 ++++++++++++++++++++++++++++++++
>   6 files changed, 864 insertions(+)
>   create mode 100644 Documentation/hwmon/mcp9982.rst
>   create mode 100644 drivers/hwmon/mcp9982.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 51a5bdf75b08..f052d80d752e 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -171,6 +171,7 @@ Hardware Monitoring Kernel Drivers
>      mc33xs2410_hwmon
>      mc34vr500
>      mcp3021
> +   mcp9982
>      menf21bmc
>      mlxreg-fan
>      mp2856
> diff --git a/Documentation/hwmon/mcp9982.rst b/Documentation/hwmon/mcp9982.rst
> new file mode 100644
> index 000000000000..58fa4fadf59e
> --- /dev/null
> +++ b/Documentation/hwmon/mcp9982.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +Kernel driver MCP998X
> +=====================
> +
> +Supported chips:
> +
> +  * Microchip Technology MCP998X/MCP9933 MCP998XD/MCP9933D
> +
> +    Prefix: 'mcp9982'
> +
> +    Datasheet:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> +
> +Authors:
> +
> +   - Victor Duicu <victor.duicu@microchip.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for the MCP998X family containing: MCP9982,
> +MCP9982D, MCP9983, MCP9983D, MCP9984, MCP9984D, MCP9985, MCP9985D,
> +MCP9933 and MCP9933D.
> +
> +The MCP998X Family is a high accuracy 2-wire multichannel automotive
> +temperature monitor.
> +
> +The chips in the family have different numbers of external channels,
> +ranging from 1 (MCP9982) to 4 channels (MCP9985). Reading diodes in
> +anti-parallel connection is supported by MCP9984/85/33 and
> +MCP9984D/85D/33D. Dedicated hardware shutdown circuitry is present
> +only in MCP998XD and MCP9933D.
> +
> +Temperatures are read in millidegrees Celsius, ranging from -64 to
> +191.875 with 0.125 precision.
> +
> +The chips measure temperatures with a variable conversion rate.
> +Update_interval = Conversion/Second, so the available options are:
> +
> +- 16000 (ms) = 1 conv/16 sec
> +- 8000 (ms) = 1 conv/8 sec
> +- 4000 (ms) = 1 conv/4 sec
> +- 2000 (ms) = 1 conv/2 sec
> +- 1000 (ms) = 1 conv/sec
> +- 500 (ms) = 2 conv/sec
> +- 250 (ms) = 4 conv/sec
> +- 125 (ms) = 8 conv/sec
> +- 64 (ms) = 16 conv/sec
> +- 32 (ms) = 32 conv/sec
> +- 16 (ms) = 64 conv/sec
> +
> +Usage Notes
> +-----------
> +
> +Parameters that can be configured in device tree:
> +- anti-parallel diode mode operation
> +- resistance error correction on channels 1 and 2
> +- resistance error correction on channels 3 and 4
> +Chips 82/83 and 82D/83D do not support anti-parallel diode mode.
> +For chips with "D" in the name resistance error correction must be on.
> +Please see Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
> +for details.
> +
> +There are two power states:
> +- Active state: in which the chip is converting on all channels at
> +  the programmed rate.
> +- Standby state: in which the host must initiate a conversion cycle.
> +Chips with "D" in the name work in Active state and those without
> +work in Standby state.
> +
> +Chips with "D" in the name can't set update interval slower than 1 second.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Update interval is read-write,
> +the rest are read only.
> +
> +======================= ==================================================
> +temp1_label		User name for internal channel.
> +temp1_input		Measured temperature for internal channel.
> +
> +temp2_label		User name for external channel 1.
> +temp2_input		Measured temperature for external channel 1.
> +
> +temp3_label		User name for external channel 2.
> +temp3_input		Measured temperature for external channel 2.
> +
> +temp4_label		User name for external channel 3.
> +temp4_input		Measured temperature for external channel 3.
> +
> +temp5_label		User name for external channel 4.
> +temp5_input		Measured temperature for external channel 4.
> +======================= ==================================================
> \ No newline at end of file
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 103e0b56f88e..30d52d8dd807 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16947,6 +16947,8 @@ M:	Victor Duicu <victor.duicu@microchip.com>
>   L:	linux-hwmon@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
> +F:	Documentation/hwmon/mcp9982.rst
> +F:	drivers/hwmon/mcp9982.c
>   
>   MICROCHIP MMC/SD/SDIO MCI DRIVER
>   M:	Aubin Constans <aubin.constans@microchip.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2760feb9f83b..d8e4603336b8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1376,6 +1376,16 @@ config SENSORS_MCP3021
>   	  This driver can also be built as a module. If so, the module
>   	  will be called mcp3021.
>   
> +config SENSORS_MCP9982
> +       tristate "Microchip Technology MCP9982 driver"
> +       depends on I2C


Also needs to select REGEMAP_I2C.

> +       help
> +         Say yes here to include support for Microchip Technology's MCP998X/33
> +         and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called mcp9982.
> +
>   config SENSORS_MLXREG_FAN
>   	tristate "Mellanox FAN driver"
>   	depends on MELLANOX_PLATFORM
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 73b2abdcc6dd..10614d9dc933 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -169,6 +169,7 @@ obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>   obj-$(CONFIG_SENSORS_MC33XS2410) += mc33xs2410_hwmon.o
>   obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
>   obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> +obj-$(CONFIG_SENSORS_MCP9982)	+= mcp9982.o
>   obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>   obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
>   obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
> diff --git a/drivers/hwmon/mcp9982.c b/drivers/hwmon/mcp9982.c
> new file mode 100644
> index 000000000000..b6750361f648
> --- /dev/null
> +++ b/drivers/hwmon/mcp9982.c
> @@ -0,0 +1,756 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive
> + * Temperature Monitor Family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Victor Duicu <victor.duicu@microchip.com>
> + *
> + * Datasheet can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device/devres.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/time64.h>
> +#include <linux/unaligned.h>
> +
> +/* MCP9982 Registers */
> +#define MCP9982_HIGH_BYTE_ADDR(index)		(2 * (index))
> +#define MCP9982_ONE_SHOT_ADDR			0x0A
> +#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR	0x0B
> +#define MCP9982_INTERNAL_LOW_LIMIT_ADDR		0x0C
> +#define MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR	0x0D
> +#define MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR	0x0E
> +#define MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR	0x0F
> +#define MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR	0x10
> +#define MCP9982_INTERNAL_THERM_LIMIT_ADDR	0x1D
> +#define MCP9982_EXT1_THERM_LIMIT_ADDR		0x1E
> +#define MCP9982_CFG_ADDR			0x22
> +#define MCP9982_CONV_ADDR			0x24
> +#define MCP9982_HYS_ADDR			0x25
> +#define MCP9982_CONSEC_ALRT_ADDR		0x26
> +#define MCP9982_ALRT_CFG_ADDR			0x27
> +#define MCP9982_RUNNING_AVG_ADDR		0x28
> +#define MCP9982_HOTTEST_CFG_ADDR		0x29
> +#define MCP9982_STATUS_ADDR			0x2A
> +#define MCP9982_EXT_FAULT_STATUS_ADDR		0x2B
> +#define MCP9982_HIGH_LIMIT_STATUS_ADDR		0x2C
> +#define MCP9982_LOW_LIMIT_STATUS_ADDR		0x2D
> +#define MCP9982_THERM_LIMIT_STATUS_ADDR		0x2E
> +#define MCP9982_HOTTEST_HIGH_BYTE_ADDR		0x2F
> +#define MCP9982_HOTTEST_LOW_BYTE_ADDR		0x30
> +#define MCP9982_HOTTEST_STATUS_ADDR		0x31
> +#define MCP9982_THERM_SHTDWN_CFG_ADDR		0x32
> +#define MCP9982_HRDW_THERM_SHTDWN_LIMIT_ADDR	0x33
> +#define MCP9982_EXT_BETA1_CFG_ADDR		0x34
> +#define MCP9982_EXT_BETA2_CFG_ADDR		0x35
> +#define MCP9982_EXT_IDEAL1_ADDR			0x36
> +#define MCP9982_EXT_IDEAL2_ADDR			0x37
> +#define MCP9982_EXT_IDEAL3_ADDR			0x38
> +#define MCP9982_EXT_IDEAL4_ADDR			0x39
> +/* 80h is the start address for temperature memory block */
> +#define MCP9982_TEMP_MEM_BLOCK_ADDR(index)	(2 * (index) + 0x80)
> +/* Addresses in the STATUS MEMORY BLOCK */
> +#define MCP9982_STATUS_BLOCK_MEMORY		0x90
> +#define MCP9982_STATUS_BLOCK_DIODE_FAULT	0x91
> +#define MCP9982_STATUS_BLOCK_HIGH_LIMIT		0x92
> +#define MCP9982_STATUS_BLOCK_LOW_LIMIT		0x93
> +#define MCP9982_STATUS_BLOCK_THERM_LIMIT	0x94
> +#define MCP9982_STATUS_BLOCK_HOTTEST_HIGH_BYTE	0x95
> +#define MCP9982_STATUS_BLOCK_HOTTEST_LOW_BYTE	0x96
> +#define MCP9982_STATUS_BLOCK_HOTTEST		0x97
> +
> +/* MCP9982 Bits */
> +#define MCP9982_CFG_MSKAL			BIT(7)
> +#define MCP9982_CFG_RS				BIT(6)
> +#define MCP9982_CFG_ATTHM			BIT(5)
> +#define MCP9982_CFG_RECD12			BIT(4)
> +#define MCP9982_CFG_RECD34			BIT(3)
> +#define MCP9982_CFG_RANGE			BIT(2)
> +#define MCP9982_CFG_DA_ENA			BIT(1)
> +#define MCP9982_CFG_APDD			BIT(0)
> +
> +#define MCP9982_STATUS_BUSY			BIT(5)
> +
> +/* The maximum number of channels a member of the family can have */
> +#define MCP9982_MAX_NUM_CHANNELS		5
> +#define MCP9982_BETA_AUTODETECT			16
> +#define MCP9982_IDEALITY_DEFAULT		18
> +#define MCP9982_OFFSET				64
> +#define MCP9982_SCALE				256
> +#define MCP9982_DEFAULT_CONSEC_ALRT_VAL		112
> +#define MCP9982_DEFAULT_HYS_VAL			10
> +#define MCP9982_DEFAULT_CONV_VAL		6
> +#define MCP9982_WAKE_UP_TIME_MS			125
> +#define MCP9982_CONVERSION_TIME_MS		125
> +
> +static const struct hwmon_channel_info * const mcp9985_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),

Why not support limits and alarm attributes (but define the registers) ?

> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_UPDATE_INTERVAL),
> +	NULL
> +};
> +
> +/**
> + * struct mcp9982_features - features of a mcp9982 instance
> + * @name:			chip's name
> + * @phys_channels:		number of physical channels supported by the chip
> + * @hw_thermal_shutdown:	presence of hardware thermal shutdown circuitry
> + * @allow_apdd:			whether the chip supports enabling APDD
> + */
> +struct mcp9982_features {
> +	const char	*name;
> +	u8		phys_channels;
> +	bool		hw_thermal_shutdown;
> +	bool		allow_apdd;
> +};
> +
> +static const struct mcp9982_features mcp9933_chip_config = {
> +	.name = "mcp9933",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = false,
> +	.allow_apdd = true,
> +};
> +
> +static const struct mcp9982_features mcp9933d_chip_config = {
> +	.name = "mcp9933d",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = true,
> +	.allow_apdd = true,
> +};
> +
> +static const struct mcp9982_features mcp9982_chip_config = {
> +	.name = "mcp9982",
> +	.phys_channels = 2,
> +	.hw_thermal_shutdown = false,
> +	.allow_apdd = false,
> +};
> +
> +static const struct mcp9982_features mcp9982d_chip_config = {
> +	.name = "mcp9982d",
> +	.phys_channels = 2,
> +	.hw_thermal_shutdown = true,
> +	.allow_apdd = false,
> +};
> +
> +static const struct mcp9982_features mcp9983_chip_config = {
> +	.name = "mcp9983",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = false,
> +	.allow_apdd = false,
> +};
> +
> +static const struct mcp9982_features mcp9983d_chip_config = {
> +	.name = "mcp9983d",
> +	.phys_channels = 3,
> +	.hw_thermal_shutdown = true,
> +	.allow_apdd = false,
> +};
> +
> +static const struct mcp9982_features mcp9984_chip_config = {
> +	.name = "mcp9984",
> +	.phys_channels = 4,
> +	.hw_thermal_shutdown = false,
> +	.allow_apdd = true,
> +};
> +
> +static const struct mcp9982_features mcp9984d_chip_config = {
> +	.name = "mcp9984d",
> +	.phys_channels = 4,
> +	.hw_thermal_shutdown = true,
> +	.allow_apdd = true,
> +};
> +
> +static const struct mcp9982_features mcp9985_chip_config = {
> +	.name = "mcp9985",
> +	.phys_channels = 5,
> +	.hw_thermal_shutdown = false,
> +	.allow_apdd = true,
> +};
> +
> +static const struct mcp9982_features mcp9985d_chip_config = {
> +	.name = "mcp9985d",
> +	.phys_channels = 5,
> +	.hw_thermal_shutdown = true,
> +	.allow_apdd = true,
> +};
> +
> +static const unsigned int mcp9982_update_interval[11] = {
> +	16000,
> +	8000,
> +	4000,
> +	2000,
> +	1000,
> +	500,
> +	250,
> +	125,
> +	64,
> +	32,
> +	16,
> +};
> +
> +/* MCP9982 regmap configuration */
> +static const struct regmap_range mcp9982_regmap_wr_ranges[] = {
> +	regmap_reg_range(MCP9982_ONE_SHOT_ADDR, MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
> +	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
> +	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
> +	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_HOTTEST_CFG_ADDR),
> +	regmap_reg_range(MCP9982_THERM_SHTDWN_CFG_ADDR, MCP9982_THERM_SHTDWN_CFG_ADDR),
> +	regmap_reg_range(MCP9982_EXT_BETA1_CFG_ADDR, MCP9982_EXT_IDEAL4_ADDR),
> +};
> +
> +static const struct regmap_access_table mcp9982_regmap_wr_table = {
> +	.yes_ranges = mcp9982_regmap_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_wr_ranges),
> +};
> +
> +static const struct regmap_range mcp9982_regmap_rd_ranges[] = {
> +	regmap_reg_range(MCP9982_HIGH_BYTE_ADDR(0), MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
> +	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
> +	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
> +	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_EXT_IDEAL4_ADDR),
> +	regmap_reg_range(MCP9982_TEMP_MEM_BLOCK_ADDR(0), MCP9982_STATUS_BLOCK_HOTTEST),
> +};
> +
> +static const struct regmap_access_table mcp9982_regmap_rd_table = {
> +	.yes_ranges = mcp9982_regmap_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_rd_ranges),
> +};
> +
> +static bool mcp9982_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MCP9982_ONE_SHOT_ADDR:
> +	case MCP9982_INTERNAL_HIGH_LIMIT_ADDR:
> +	case MCP9982_INTERNAL_LOW_LIMIT_ADDR:
> +	case MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR:
> +	case MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR:
> +	case MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR:
> +	case MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR:
> +	case MCP9982_INTERNAL_THERM_LIMIT_ADDR:
> +	case MCP9982_EXT1_THERM_LIMIT_ADDR:
> +	case MCP9982_CFG_ADDR:
> +	case MCP9982_CONV_ADDR:
> +	case MCP9982_HYS_ADDR:
> +	case MCP9982_CONSEC_ALRT_ADDR:
> +	case MCP9982_ALRT_CFG_ADDR:
> +	case MCP9982_RUNNING_AVG_ADDR:
> +	case MCP9982_HOTTEST_CFG_ADDR:
> +	case MCP9982_THERM_SHTDWN_CFG_ADDR:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config mcp9982_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &mcp9982_regmap_rd_table,
> +	.wr_table = &mcp9982_regmap_wr_table,
> +	.volatile_reg = mcp9982_is_volatile_reg,
> +	.max_register = MCP9982_STATUS_BLOCK_HOTTEST,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @regmap:			device register map
> + * @chip:			pointer to structure holding chip features
> + * @labels:			labels of the channels
> + * @sampl_idx:			index representing the current sampling frequency
> + * @time_limit:			time when it is safe to read
> + * @enabled_channel_mask:	mask containing which channels should be enabled
> + * @num_channels:		number of active physical channels
> + * @recd34_enable:		state of Resistance Error Correction(REC) on channels 3 and 4
> + * @recd12_enable:		state of Resistance Error Correction(REC) on channels 1 and 2
> + * @apdd_enable:		state of anti-parallel diode mode
> + * @run_state:			chip is in run state, otherwise is in standby state
> + * @wait_before_read:		whether we need to wait a delay before reading a new value
> + */
> +struct mcp9982_priv {
> +	struct regmap *regmap;
> +	const struct mcp9982_features *chip;
> +	const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +	unsigned int sampl_idx;
> +	unsigned long  time_limit;
> +	unsigned long enabled_channel_mask;
> +	u8 num_channels;
> +	bool recd34_enable;
> +	bool recd12_enable;
> +	bool apdd_enable;
> +	bool run_state;
> +	bool wait_before_read;
> +};
> +
> +static int mcp9982_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	unsigned int reg_status;
> +	struct mcp9982_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +	u8 bulk_read[3];
> +
> +	if (priv->run_state) {
> +		/*
> +		 * When working in Run mode, after modifying a parameter (like update
> +		 * interval) we have to wait a delay before reading the new values.
> +		 * We can't determine when the conversion is done based on the BUSY bit.
> +		 */
> +		if (priv->wait_before_read) {
> +			if (!time_after(jiffies, priv->time_limit))
> +				mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
> +			priv->wait_before_read = false;
> +		}
> +	} else {
> +		ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * In Standby state after writing in OneShot register wait for
> +		 * the start of conversion and then poll the BUSY bit.
> +		 */
> +		mdelay(MCP9982_WAKE_UP_TIME_MS);
> +		ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
> +					       reg_status, !(reg_status & MCP9982_STATUS_BUSY),
> +					       (mcp9982_update_interval[priv->sampl_idx]) *
> +					       USEC_PER_MSEC, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			/*
> +			 * The Block Read Protocol first returns the number of user readable
> +			 * bytes, held in bulk_read[0], followed by the data.
> +			 */
> +			ret = regmap_bulk_read(priv->regmap, MCP9982_TEMP_MEM_BLOCK_ADDR(channel),
> +					       &bulk_read, sizeof(bulk_read));
> +
> +			if (ret)
> +				return ret;
> +
> +			*val = ((get_unaligned_be16(bulk_read + 1) >> 5) -
> +			       (MCP9982_OFFSET << 3)) * 125;
> +
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			*val = mcp9982_update_interval[priv->sampl_idx];
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9982_read_label(struct device *dev,
> +			      enum hwmon_sensor_types type,
> +			      u32 attr, int channel, const char **str)
> +{
> +	struct mcp9982_priv *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			if (priv->labels[channel]) {
> +				*str = priv->labels[channel];
> +				return 0;
> +			} else {
> +				return -EOPNOTSUPP;
> +			}
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mcp9982_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	unsigned int i, previous_sampl_idx;
> +	struct mcp9982_priv *priv = dev_get_drvdata(dev);
> +	unsigned long new_time_limit;
> +	bool use_previous_freq = false;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			previous_sampl_idx = priv->sampl_idx;
> +
> +			/*
> +			 * For MCP998XD and MCP9933D update interval
> +			 * can't be slower than 1 second.
> +			 */
> +			i = priv->chip->hw_thermal_shutdown ? 4 : 0;
> +			for (; i < ARRAY_SIZE(mcp9982_update_interval); i++)
> +				if (val == mcp9982_update_interval[i])
> +					break;
> +
> +			if (i == ARRAY_SIZE(mcp9982_update_interval))
> +				return -EINVAL;
> +

Clamping would be much better in situations like this since users
typically don't know the valid ranges. Also, it is much better so
select the closes value instead of requiring the user to know the
exact supported values.

> +			ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +			if (ret)
> +				return ret;
> +
> +			priv->sampl_idx = i;
> +
> +			/*
> +			 * When changing the frequency in Run mode, wait a delay based
> +			 * on the previous value to ensure the new value becomes active.
> +			 */
> +			if (priv->run_state)
> +				use_previous_freq = true;
> +			else
> +				return 0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* update conversion delay in runmode */
> +	if (use_previous_freq) {
> +		new_time_limit = msecs_to_jiffies(mcp9982_update_interval[previous_sampl_idx]);
> +		use_previous_freq = false;
> +	} else {
> +		new_time_limit = msecs_to_jiffies(mcp9982_update_interval[priv->sampl_idx]);
> +	}
> +
> +	new_time_limit += jiffies + msecs_to_jiffies(MCP9982_CONVERSION_TIME_MS);
> +
> +	if (time_after(new_time_limit, priv->time_limit)) {
> +		priv->time_limit = new_time_limit;
> +		priv->wait_before_read = true;
> +	}
> +

That is a lot of complexity to support one-shot (standby) mode. I think a use case
description is warranted here.

> +	return 0;
> +}
> +
> +static umode_t mcp9982_is_visible(const void *_data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct mcp9982_priv *priv = _data;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			if (priv->labels[channel])
> +				return 0444;
> +			else
> +				return 0;
> +		case hwmon_temp_input:
> +			if (test_bit(channel, &priv->enabled_channel_mask))
> +				return 0444;
> +			else
> +				return 0;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return 0644;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct hwmon_ops mcp9982_hwmon_ops = {
> +	.is_visible = mcp9982_is_visible,
> +	.read = mcp9982_read,
> +	.read_string = mcp9982_read_label,
> +	.write = mcp9982_write,
> +};
> +
> +static int mcp9982_init(struct device *dev, struct mcp9982_priv *priv)
> +{
> +	int ret;
> +	u8 val;
> +
> +	/* Chips 82/83 and 82D/83D do not support anti-parallel diode mode. */
> +	if (!priv->chip->allow_apdd && priv->apdd_enable == 1)
> +		return dev_err_probe(dev, -EINVAL, "Incorrect setting of APDD.\n");
> +
> +	/* Chips with "D" work in Run state and those without work in Standby state. */
> +	if (priv->chip->hw_thermal_shutdown)
> +		priv->run_state = true;
> +

That seems a bit absolute and quite unusual. The non-D chips _support_ standby state,
but that does not mean it should or has to be permanently enforced. Forcing chips
to run in standby mode has significant performance impact, so this should not be
universally enforced based on the chip type.

> +	/*
> +	 * For chips with "D" in the name, resistance error correction must be on
> +	 * so that hardware shutdown feature can't be overridden.
> +	 */
> +	if (priv->chip->hw_thermal_shutdown)
> +		if (!priv->recd34_enable || !priv->recd12_enable)
> +			return dev_err_probe(dev, -EINVAL, "Incorrect setting of RECD.\n");
> +	/*
> +	 * Set default values in registers.
> +	 * APDD, RECD12 and RECD34 are active on 0.
> +	 */
> +	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RS, !priv->run_state) |
> +	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RANGE, 1) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
> +	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, MCP9982_DEFAULT_CONV_VAL);
> +	if (ret)
> +		return ret;
> +	priv->sampl_idx = MCP9982_DEFAULT_CONV_VAL;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, MCP9982_DEFAULT_HYS_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR,
> +			   MCP9982_DEFAULT_CONSEC_ALRT_VAL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Only external channels 1 and 2 support beta compensation.
> +	 * Set beta auto-detection.
> +	 */
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_BETA1_CFG_ADDR, MCP9982_BETA_AUTODETECT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_BETA2_CFG_ADDR, MCP9982_BETA_AUTODETECT);
> +	if (ret)
> +		return ret;
> +
> +	/* Set ideality factor to default for all external channels. */
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL1_ADDR, MCP9982_IDEALITY_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL2_ADDR, MCP9982_IDEALITY_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL3_ADDR, MCP9982_IDEALITY_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL4_ADDR, MCP9982_IDEALITY_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	priv->wait_before_read = false;
> +	priv->time_limit = jiffies;
> +
> +	return 0;
> +}
> +
> +static int mcp9982_parse_fw_config(struct device *dev, int device_nr_channels)
> +{
> +	unsigned int reg_nr;
> +	struct mcp9982_priv *priv = dev_get_drvdata(dev);
> +
> +	/* For unit tests */
> +	if (!dev_fwnode(dev)) {
> +		priv->num_channels = device_nr_channels;
> +		priv->enabled_channel_mask = BIT(priv->num_channels) - 1;
> +		priv->apdd_enable = false;
> +		priv->recd12_enable = true;
> +		priv->recd34_enable = true;
> +		return 0;
> +	}
> +
> +	priv->apdd_enable =
> +		device_property_read_bool(dev, "microchip,enable-anti-parallel");
> +
> +	priv->recd12_enable =
> +		device_property_read_bool(dev, "microchip,parasitic-res-on-channel1-2");
> +
> +	priv->recd34_enable =
> +		device_property_read_bool(dev, "microchip,parasitic-res-on-channel3-4");
> +
> +	priv->num_channels = device_get_child_node_count(dev) + 1;
> +
> +	if (priv->num_channels > device_nr_channels)
> +		return dev_err_probe(dev, -E2BIG,
> +				     "More channels than the chip supports.\n");
> +
> +	/* Initialise internal channel( which is always present ). */
> +	priv->labels[0] = "internal diode";

This must come before the dev_fwnode() check above.

> +	priv->enabled_channel_mask = 1;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		reg_nr = 0;
> +		fwnode_property_read_u32(child, "reg", &reg_nr);

Why ignore the error from this function ? Either check the error or explain
why it is ignored.

> +		if (!reg_nr || reg_nr >= device_nr_channels)

This is a bit confusing. So the valid range is [1, device_nr_channels - 1] ?
I _think_ it is supposed to reflect the number of _external_ channels
(in other words, there is no child for the internal channel), but that
is a bit confusing and asks for a comment.

> +			return dev_err_probe(dev, -EINVAL,
> +			  "The index of the channels does not match the chip.\n");

That is a confusing error message.

> +
> +		fwnode_property_read_string(child, "label", &priv->labels[reg_nr]);
> +		set_bit(reg_nr, &priv->enabled_channel_mask);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct hwmon_chip_info mcp998x_chip_info;
> +	struct mcp9982_priv *priv;
> +	const struct mcp9982_features *chip;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct mcp9982_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
> +
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map.\n");
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	chip = i2c_get_match_data(client);
> +	if (!chip)
> +		return -EINVAL;
> +	priv->chip = chip;
> +
> +	ret = mcp9982_parse_fw_config(dev, chip->phys_channels);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp9982_init(dev, priv);
> +	if (ret)
> +		return ret;
> +
> +	mcp998x_chip_info.ops = &mcp9982_hwmon_ops;
> +	mcp998x_chip_info.info = mcp9985_info;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, chip->name, priv,
> +							 &mcp998x_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id mcp9982_id[] = {
> +	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9933_chip_config },
> +	{ .name = "mcp9933d", .driver_data = (kernel_ulong_t)&mcp9933d_chip_config },
> +	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config },
> +	{ .name = "mcp9982d", .driver_data = (kernel_ulong_t)&mcp9982d_chip_config },
> +	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9983_chip_config },
> +	{ .name = "mcp9983d", .driver_data = (kernel_ulong_t)&mcp9983d_chip_config },
> +	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9984_chip_config },
> +	{ .name = "mcp9984d", .driver_data = (kernel_ulong_t)&mcp9984d_chip_config },
> +	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9985_chip_config },
> +	{ .name = "mcp9985d", .driver_data = (kernel_ulong_t)&mcp9985d_chip_config },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp9982_id);
> +
> +static const struct of_device_id mcp9982_of_match[] = {
> +	{
> +		.compatible = "microchip,mcp9933",
> +		.data = &mcp9933_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9933d",
> +		.data = &mcp9933d_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9982",
> +		.data = &mcp9982_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9982d",
> +		.data = &mcp9982d_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9983",
> +		.data = &mcp9983_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9983d",
> +		.data = &mcp9983d_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9984",
> +		.data = &mcp9984_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9984d",
> +		.data = &mcp9984d_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9985",
> +		.data = &mcp9985_chip_config,
> +	}, {
> +		.compatible = "microchip,mcp9985d",
> +		.data = &mcp9985d_chip_config,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp9982_of_match);
> +
> +static struct i2c_driver mcp9982_driver = {
> +	.driver	 = {
> +		.name = "mcp9982",
> +		.of_match_table = mcp9982_of_match,
> +	},
> +	.probe = mcp9982_probe,
> +	.id_table = mcp9982_id,
> +};
> +module_i2c_driver(mcp9982_driver);
> +
> +MODULE_AUTHOR("Victor Duicu <victor.duicu@microchip.com>");
> +MODULE_DESCRIPTION("MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Driver");
> +MODULE_LICENSE("GPL");


