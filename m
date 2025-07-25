Return-Path: <linux-kernel+bounces-746280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A34B124D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83107588242
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1F24BCE8;
	Fri, 25 Jul 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfmlcAJB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0D3D994;
	Fri, 25 Jul 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472683; cv=none; b=qpHBOh0akRsJXUpo1So/G7kxnk8v7CnapIQYptSIfQwRb17ECcmri79qMmHzaPGbj+0ccFGEWIKJuhihSIhgKrcK05Y3q762bHI3ZDKjGTh/ugBNVKbxIElwW16i/4ydnYO8bNu/e3KrxU0YRTtMT2PSOaC2ALmfD2i+qMX6qSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472683; c=relaxed/simple;
	bh=IIs40TVDXzF3SFS5jCMcnUpiHQ+TvMbvfA/vqUCVkpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8RcmlUt7nADiMBuvMIIUj0B4s8EPxVBRITY19k1l/ZNe5/wQBHNH23q4Q53EnwLm/g8E0roiBGHlO4wymQis+BOSt1htqDudUDw8fclYM9LDeX7Z6J9naI51nRwhrDKgjFKyzWCDL4O8ODnsjE3xFd2ijBtzo6AoFd/tLdOYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfmlcAJB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748d982e92cso1724970b3a.1;
        Fri, 25 Jul 2025 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753472679; x=1754077479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpHBJvt1sSzmNw2Fom7sXrfWjO+q2MjYnz5Aw8ygOYQ=;
        b=DfmlcAJBTYjmwysgFhRvok9RnrP763+4ZuoVKdugkEer9EO3qtD9K4+8O2NZ/zfbZ4
         xViLqhoYgKTl2Vj3R9bi4LQ5ycPvD3xNrCRDzvCabHJj5ozewroLKYVfVw1mOxPANfHF
         7c/QHHqFqhIb3fQsVpYNpwfbYr+5YqRQ+vgTeOKCu2v7fMBk5c/tTw30h2LtQlj1SvO9
         WtmP5GbmceAr/Ai+mHEFaxOozs941aRT1/9IZGm3emHitnM7c+zeoXn7xF6j78gQWm+h
         xcBGjag+itxtP46pgpm6H4nNbamtP9hIQytwpp5OH3yqE6D8B2TEpb6mWxXJ668qxGHG
         O+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753472679; x=1754077479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHBJvt1sSzmNw2Fom7sXrfWjO+q2MjYnz5Aw8ygOYQ=;
        b=k37HeIQ2RoGdEGv5XLm9bwurZCM0dANLCJQOK+2r2v2RFhiAHjrQLZoIMTjjcOmPln
         DplO4ei6D/j054k34nzzM3sYX+ZpuUyPBWLgnIIBarwEL1+JM0ynVC6z0+RRVAu4IUOV
         FVaYg6hlTrkYN0ZQ3P+dfQKztHpfU9ralkK7J4KTmmY5jJX9lI2ue/Vh2motfi0LZB9M
         hjHK2dxTrUSwcfbA7G8nJDttCQmWw8y0DLlSp9YN+GWgdrQeX9nznR0/MjzWgrXOdwqW
         KOoT98npYIVFwSU782aeGIS+U6s0MMqTb6O6R8khJQ9h8oGiU/gOSOck7n0tT1ZaT+gR
         Ev9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6mOOmmneac9aEVWB3CmKWLdc7+qaTcyJNy9wO+OIKKE5UT8JbLgwHO2NaXp2nnFyipfLYQ0eyI0Xp4U07@vger.kernel.org, AJvYcCUaU4V60VMH0vHNqOKRrDH6G/M1ICKmG77cmhlHQALP79xewQPy+8fUh3/GkPD3wMfZ18yihVgkDRjo@vger.kernel.org, AJvYcCVW2PyfkRCn0dHPB5bYdqo57YufOuOHsDT6riv6ZIuAzRGTrB5kq78ldG1x1lYtTWgtIfCwyRs6QXOrgBY=@vger.kernel.org, AJvYcCWGh4jmGFWP3DsRRQ2g4KVmn6cJpYpAYeDHhUfM0pfzJcuAt9bq833stSV+uzcwb/K6j7Crq/MZKNjp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gq728KeEor4tD8ok/KN8gMiuqJlQJgxP9SUn4XW86XTQwH6l
	yNylw0vgoAJu5a0tfzIbiNk38DrTvcofWymkk3vk7cicgcWNRQUI4aw1
X-Gm-Gg: ASbGnctuGtDBCKWBZfNQFus94KBqNKxNrLhWdEIaf50qs1gOBpxWz5AMG38248U3aGU
	jfR8Ag6qshALHU/EvmRhDGSm2h5dv9/doqT9tni7mw8VEVf+QGKivq7FwA82tlqRoDKE7TrpeKu
	KxjgQxrUvjzQhC3gQ6XD+3N0FtEukzUftoBOM346fvF9IPDw1z6/CyJeCwZbP8VVq++x5Q3amL2
	C4vmQZR+TPhfRbX3oy/bQSsfPXpJdsMb9kgvFvLcxMzpNVnPaSLG6pt43UEg/ineq2Cifv15IMt
	t454B+mjk2TxqSv1/REpVJSWRGfEDZekdcfbpjbBTQ646UWV8NkpuBf9CAQzKJqFlQcnYNCzCWg
	OkvUKqVU76Ey6HzY8TatyPO0nefj0xjiH/rA=
X-Google-Smtp-Source: AGHT+IFXYlTx9nS9phIVS3ylWC0poKZZgBR2HRmqQEc6iRd3pxH/PTEOSnj188B4B4veUXG/4UGNDA==
X-Received: by 2002:a05:6a00:1790:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-7633626d5afmr5102323b3a.3.1753472679062;
        Fri, 25 Jul 2025 12:44:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a18bsm350251b3a.13.2025.07.25.12.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:44:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 25 Jul 2025 12:44:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/4] hwmon: add MP2869,MP29608,MP29612 and MP29816
 series driver
Message-ID: <56672864-c114-4cb2-8fab-707131930e77@roeck-us.net>
References: <20250724091011.550761-1-wenswang@yeah.net>
 <20250724091306.551131-1-wenswang@yeah.net>
 <20250724091306.551131-2-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724091306.551131-2-wenswang@yeah.net>

On Thu, Jul 24, 2025 at 05:13:04PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a
> and mp29816/mp29816a/mp29816b/mp29816c controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
> ---
> V3 -> V4:
>     1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
>     2. add description for vender specific registers
> 
> V2 -> V3:
>     merge patches for MP2869,mp29608,mp29612,mp29816,mp29502
> 
> V1 -> V2:
>     add Rob's Acked-by
> 
>  Documentation/hwmon/index.rst  |   1 +
>  Documentation/hwmon/mp2869.rst | 175 ++++++++
>  MAINTAINERS                    |   7 +
>  drivers/hwmon/pmbus/Kconfig    |   9 +
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/mp2869.c   | 719 +++++++++++++++++++++++++++++++++
>  6 files changed, 912 insertions(+)
>  create mode 100644 Documentation/hwmon/mp2869.rst
>  create mode 100644 drivers/hwmon/pmbus/mp2869.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b45bfb4ebf30..7e278aa0aac3 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -172,6 +172,7 @@ Hardware Monitoring Kernel Drivers
>     menf21bmc
>     mlxreg-fan
>     mp2856
> +   mp2869
>     mp2888
>     mp2891
>     mp2975
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8bebd0886df..0234790a4137 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16882,6 +16882,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>  F:	drivers/video/backlight/mp3309c.c
>  
> +MPS MP2869 DRIVER
> +M:	Wensheng Wang <wenswang@yeah.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/mp2869.rst
> +F:	drivers/hwmon/pmbus/mp2869.c
> +
>  MPS MP2891 DRIVER
>  M:	Noah Wang <noahwang.wang@outlook.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 441f984a859d..f3bf7b7fb76d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -364,6 +364,15 @@ config SENSORS_MP2856
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp2856.
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
>  config SENSORS_MP2888
>  	tristate "MPS MP2888"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 29cd8a3317d2..6177047414ee 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>  obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
> +obj-$(CONFIG_SENSORS_MP2869)	+= mp2869.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c
> new file mode 100644
> index 000000000000..dbc12ed20bad
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2869.c
> @@ -0,0 +1,719 @@
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
> +/*
> + * Vender specific registers, the register MFR_VOUT_SCALE_LOOP(0x29),
> + * MFR_SVI3_IOUT_PRT(0x67), READ_PIN_EST(0x94)and READ_IIN_EST(0x95)
> + * redefine the standard PMBUS register. The MFR_VOUT_LOOP_CTRL(0x29)
> + * is used to identify the vout scale and the MFR_SVI3_IOUT_PRT(0x67)
> + * is used to identify the iout scale. The READ_PIN_EST(0x94) is used
> + * to read input power per rail. The MP2891 does not have standard
> + * READ_IIN register(0x89), the iin telemetry can be obtained through
> + * the vendor redefined register READ_IIN_EST(0x95).
> + */
> +#define MFR_VOUT_SCALE_LOOP	0x29

Please use PMBUS_VOUT_SCALE_LOOP.

> +#define MFR_SVI3_IOUT_PRT	0x67
> +#define MFR_READ_PIN_EST	0x94
> +#define MFR_READ_IIN_EST	0x95
> +#define MFR_TSNS_FLT_SET	0xBB
> +
> +#define MP2869_VIN_OV_FAULT_GAIN	4
> +#define MP2869_READ_VOUT_DIV	1024
> +#define MP2869_READ_IOUT_DIV	32
> +#define MP2869_OVUV_LIMIT_SCALE	10
> +#define MP2869_OVUV_DELTA_SCALE	50
> +#define MP2869_TEMP_LIMIT_OFFSET	40
> +#define MP2869_IOUT_LIMIT_UINT	8
> +#define MP2869_POUT_OP_GAIN	2
> +
> +#define MP2869_PAGE_NUM	2
> +
> +#define MP2869_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
> +							PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | \
> +							PMBUS_HAVE_TEMP | PMBUS_HAVE_PIN | \
> +							PMBUS_HAVE_IIN | \
> +							PMBUS_HAVE_STATUS_VOUT | \
> +							PMBUS_HAVE_STATUS_IOUT | \
> +							PMBUS_HAVE_STATUS_TEMP | \
> +							PMBUS_HAVE_STATUS_INPUT)
> +
> +#define MP2869_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> +							 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP | \
> +							 PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | \
> +							 PMBUS_HAVE_STATUS_VOUT | \
> +							 PMBUS_HAVE_STATUS_IOUT | \
> +							 PMBUS_HAVE_STATUS_TEMP | \
> +							 PMBUS_HAVE_STATUS_INPUT)
> +
> +enum chips {mp2869, mp29608, mp29612, mp29816};

Information about those chips is sparse, but it looks like the main
difference is the number of supported rails. There is no code difference.
Given that, is it even neccessary to specify more than one model ?

> +
> +struct mp2869_data {
> +	struct pmbus_driver_info info;
> +	bool mfr_thwn_flt_en;
> +	int vout_scale[MP2869_PAGE_NUM];
> +	int iout_scale[MP2869_PAGE_NUM];
> +};
> +
> +#define to_mp2869_data(x)	container_of(x, struct mp2869_data, info)
> +
> +static u16 mp2869_reg2data_linear11(u16 word)
> +{
> +	s16 exponent;
> +	s32 mantissa;
> +	s64 val;
> +
> +	exponent = ((s16)word) >> 11;
> +	mantissa = ((s16)((word & 0x7ff) << 5)) >> 5;
> +	val = mantissa;
> +
> +	if (exponent >= 0)
> +		val <<= exponent;
> +	else
> +		val >>= -exponent;
> +
> +	return val;
> +}
> +
> +static int
> +mp2869_identify_thwn_flt(struct i2c_client *client, struct pmbus_driver_info *info,
> +			 int page)
> +{
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (FIELD_GET(GENMASK(13, 13), ret))
> +		data->mfr_thwn_flt_en = true;
> +	else
> +		data->mfr_thwn_flt_en = false;

Could be simplified to
	data->mfr_thwn_flt_en = FIELD_GET(GENMASK(13, 13), ret);

> +
> +	return 0;
> +}
> +
> +static int
> +mp2869_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> +			   int page)
> +{
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MFR_VOUT_SCALE_LOOP);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
> +	 * by vout_scale.
> +	 * Obtain vout scale from the register MFR_VOUT_SCALE_LOOP, bits 12-10
> +	 * MFR_VOUT_SCALE_LOOP[12:10]:
> +	 * 000b - 6.25mV/LSB, 001b - 5mV/LSB, 010b - 2.5mV/LSB, 011b - 2mV/LSB
> +	 * 100b - 1mV/Lsb, 101b - (1/256)mV/LSB, 110b - (1/512)mV/LSB,
> +	 * 111b - (1/1024)mV/LSB
> +	 */
> +	switch (FIELD_GET(GENMASK(12, 10), ret)) {
> +	case 0:
> +		data->vout_scale[page] = 6400;
> +		break;
> +	case 1:
> +		data->vout_scale[page] = 5120;
> +		break;
> +	case 2:
> +		data->vout_scale[page] = 2560;
> +		break;
> +	case 3:
> +		data->vout_scale[page] = 2048;
> +		break;
> +	case 4:
> +		data->vout_scale[page] = 1024;
> +		break;
> +	case 5:
> +		data->vout_scale[page] = 4;
> +		break;
> +	case 6:
> +		data->vout_scale[page] = 2;
> +		break;
> +	case 7:
> +		data->vout_scale[page] = 1;
> +		break;
> +	default:
> +		data->vout_scale[page] = 1;
> +		break;

A static array indexed with FIELD_GET(GENMASK(12, 10), ret) would simplify
this code substantially.

> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mp2869_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> +			   int page)
> +{
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The output current is equal to the READ_IOUT(0x8C) register value
> +	 * multiply by iout_scale.
> +	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT[2:0].
> +	 * The value is selected as below:
> +	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
> +	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
> +	 * 110b - 1A/LSB, 111b - 2A/LSB
> +	 */
> +	switch (ret & GENMASK(2, 0)) {
> +	case 0:
> +	case 6:
> +		data->iout_scale[page] = 32;
> +		break;
> +	case 1:
> +		data->iout_scale[page] = 1;
> +		break;
> +	case 2:
> +		data->iout_scale[page] = 2;
> +		break;
> +	case 3:
> +		data->iout_scale[page] = 4;
> +		break;
> +	case 4:
> +		data->iout_scale[page] = 8;
> +		break;
> +	case 5:
> +		data->iout_scale[page] = 16;
> +		break;
> +	default:
> +		data->iout_scale[page] = 64;
> +		break;

Same here.

> +	}
> +
> +	return 0;
> +}
> +
> +static int mp2869_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/*
> +		 * The calculation of vout in this driver is based on direct format.
> +		 * As a result, the format of vout is enforced to direct.
> +		 */
> +		ret = PB_VOUT_MODE_DIRECT;
> +		break;
> +	case PMBUS_STATUS_BYTE:
> +		/*
> +		 * If the tsns digital fault is enabled, the TEMPERATURE flag
> +		 * of PMBUS_STATUS_BYTE should come from STATUS_MFR_SPECIFIC
> +		 * register bit1.
> +		 */
> +		if (data->mfr_thwn_flt_en) {
> +			ret = pmbus_read_byte_data(client, page, reg);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = (ret & ~GENMASK(2, 2)) |
> +			   FIELD_PREP(GENMASK(2, 2),
> +				      FIELD_GET(GENMASK(1, 1),
> +						pmbus_read_byte_data(client, page,
> +								     PMBUS_STATUS_MFR_SPECIFIC)));
> +		} else {
> +			ret = -ENODATA;
> +		}

		if (!data->mfr_thwn_flt_en)
			return -ENODATA;
		...

> +		break;
> +	case PMBUS_STATUS_TEMPERATURE:
> +		/*
> +		 * If the tsns digital fault is enabled, the OT Fault and OT Warning
> +		 * flag of PMBUS_STATUS_TEMPERATURE should come from STATUS_MFR_SPECIFIC
> +		 * register bit1.
> +		 */
> +		if (data->mfr_thwn_flt_en) {
> +			ret = pmbus_read_byte_data(client, page, reg);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = (ret & ~GENMASK(7, 6)) |
> +			   FIELD_PREP(GENMASK(6, 6),
> +				      FIELD_GET(GENMASK(1, 1),
> +						pmbus_read_byte_data(client, page,
> +								     PMBUS_STATUS_MFR_SPECIFIC))) |
> +			     FIELD_PREP(GENMASK(7, 7),
> +					FIELD_GET(GENMASK(1, 1),
> +						  pmbus_read_byte_data(client, page,
> +								       PMBUS_STATUS_MFR_SPECIFIC)));
> +		} else {
> +			ret = -ENODATA;
> +		}

Same as above.

> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2869_read_word_data(struct i2c_client *client, int page, int phase,
> +				 int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		/*
> +		 * If the tsns digital fault is enabled, the OT Fault flag
> +		 * of PMBUS_STATUS_WORD should come from STATUS_MFR_SPECIFIC
> +		 * register bit1.
> +		 */
> +		if (data->mfr_thwn_flt_en) {
> +			ret = pmbus_read_word_data(client, page, phase, reg);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = (ret & ~GENMASK(2, 2)) |
> +			     FIELD_PREP(GENMASK(2, 2),
> +					FIELD_GET(GENMASK(1, 1),
> +						  pmbus_read_byte_data(client, page,
> +								       PMBUS_STATUS_MFR_SPECIFIC)));
> +		} else {
> +			ret = -ENODATA;
> +		}

Same as above.

> +		break;
> +	case PMBUS_READ_VIN:
> +		/*
> +		 * The MP2869 PMBUS_READ_VIN[10:0] is the vin value, the vin scale is
> +		 * 31.25mV/LSB. And the vin scale is set to 31.25mV/Lsb(using r/m/b scale)
> +		 * in MP2869 pmbus_driver_info struct, so the word data bit0-bit10 can be
> +		 * returned to pmbus core directly.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = FIELD_GET(GENMASK(10, 0), ret);
> +		break;
> +	case PMBUS_READ_IIN:
> +		/*
> +		 * The MP2869 redefine the standard 0x95 register as iin telemetry
> +		 * per rail.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, MFR_READ_IIN_EST);
> +		if (ret < 0)
> +			return ret;
> +
> +		break;
> +	case PMBUS_READ_PIN:
> +		/*
> +		 * The MP2869 redefine the standard 0x94 register as pin telemetry
> +		 * per rail. The MP2869 MFR_READ_PIN_EST register is linear11 format,
> +		 * but the pin scale is set to 1W/Lsb(using r/m/b scale). As a result,
> +		 * the pin read from MP2869 should be converted to W, then return
> +		 * the result to pmbus core.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, MFR_READ_PIN_EST);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2869_reg2data_linear11(ret);
> +		break;
> +	case PMBUS_READ_VOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret &  GENMASK(11, 0)) * data->vout_scale[page],
> +					MP2869_READ_VOUT_DIV);
> +		break;
> +	case PMBUS_READ_IOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale[page],
> +					MP2869_READ_IOUT_DIV);
> +		break;
> +	case PMBUS_READ_POUT:
> +		/*
> +		 * The MP2869 PMBUS_READ_POUT register is linear11 format, but the pout
> +		 * scale is set to 1W/Lsb(using r/m/b scale). As a result, the pout read
> +		 * from MP2869 should be converted to W, then return the result to pmbus
> +		 * core.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2869_reg2data_linear11(ret);
> +		break;
> +	case PMBUS_READ_TEMPERATURE_1:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = FIELD_GET(GENMASK(10, 0), ret);
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(12, 9), ret))
> +			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE +
> +				(FIELD_GET(GENMASK(12, 9), ret) + 1) * MP2869_OVUV_DELTA_SCALE;
> +		else
> +			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE;
> +		break;
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(12, 9), ret))
> +			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE -
> +				(FIELD_GET(GENMASK(12, 9), ret) + 1) * MP2869_OVUV_DELTA_SCALE;
> +		else
> +			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE;
> +
> +		ret = ret < 0 ? 0 : ret;

How would ret ever be < 0 here ?

> +		break;
> +	case PMBUS_OT_FAULT_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +		/*
> +		 * The scale of MP2869 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
> +		 * is 1°C/LSB and they have 40°C offset.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = (ret & GENMASK(7, 0)) - MP2869_TEMP_LIMIT_OFFSET;
> +		break;
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = (ret & GENMASK(7, 0)) * MP2869_VIN_OV_FAULT_GAIN;
> +		break;
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = FIELD_GET(GENMASK(9, 0), ret);
> +		break;
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) * data->iout_scale[page] *
> +						MP2869_IOUT_LIMIT_UINT, MP2869_READ_IOUT_DIV);
> +		break;
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = (ret & GENMASK(7, 0)) * MP2869_POUT_OP_GAIN;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2869_write_word_data(struct i2c_client *client, int page, int reg,
> +				  u16 word)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2869_data *data = to_mp2869_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		/*
> +		 * The MP2869 PMBUS_VOUT_UV_FAULT_LIMIT[8:0] is the limit value,
> +		 * and bit9-bit15 should not be changed.
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(12, 9), ret))
> +			ret = pmbus_write_word_data(client, page, reg,
> +						    (ret & ~GENMASK(8, 0)) |
> +				FIELD_PREP(GENMASK(8, 0),
> +					   DIV_ROUND_CLOSEST(word +
> +						(FIELD_GET(GENMASK(12, 9),
> +						ret) + 1) *
> +					MP2869_OVUV_DELTA_SCALE,
> +					MP2869_OVUV_LIMIT_SCALE)));
> +		else
> +			ret = pmbus_write_word_data(client, page, reg,
> +						    (ret & ~GENMASK(8, 0)) |
> +					FIELD_PREP(GENMASK(8, 0),
> +						   DIV_ROUND_CLOSEST(word,
> +								     MP2869_OVUV_LIMIT_SCALE)));
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		/*
> +		 * The MP2869 PMBUS_VOUT_OV_FAULT_LIMIT[8:0] is the limit value,
> +		 * and bit9-bit15 should not be changed.
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(12, 9), ret))
> +			ret = pmbus_write_word_data(client, page, reg,
> +						    (ret & ~GENMASK(8, 0)) |
> +				FIELD_PREP(GENMASK(8, 0),
> +					   DIV_ROUND_CLOSEST(word -
> +							(FIELD_GET(GENMASK(12, 9),
> +							ret) + 1) *
> +						MP2869_OVUV_DELTA_SCALE,
> +						MP2869_OVUV_LIMIT_SCALE)));
> +		else
> +			ret = pmbus_write_word_data(client, page, reg,
> +						    (ret & ~GENMASK(8, 0)) |
> +				FIELD_PREP(GENMASK(8, 0),
> +					   DIV_ROUND_CLOSEST(word,
> +							     MP2869_OVUV_LIMIT_SCALE)));
> +		break;
> +	case PMBUS_OT_FAULT_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +		/*
> +		 * If the tsns digital fault is enabled, the PMBUS_OT_FAULT_LIMIT and
> +		 * PMBUS_OT_WARN_LIMIT can not be written.
> +		 */
> +		if (data->mfr_thwn_flt_en) {
> +			ret = -EINVAL;

			return -EINVAL;

> +		} else {
> +			/*
> +			 * The MP2869 scale of MP2869 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
> +			 * have 40°C offset. The bit0-bit7 is the limit value, and bit8-bit15
> +			 * should not be changed.
> +			 */
> +			ret = pmbus_read_word_data(client, page, 0xff, reg);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = pmbus_write_word_data(client, page, reg,
> +						    (ret & ~GENMASK(7, 0)) |
> +						 FIELD_PREP(GENMASK(7, 0),
> +							    word + MP2869_TEMP_LIMIT_OFFSET));
> +		}
> +		break;
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +		/*
> +		 * The MP2869 PMBUS_VIN_OV_FAULT_LIMIT[7:0] is the limit value, and bit8-bit15
> +		 * should not be changed. The scale of PMBUS_VIN_OV_FAULT_LIMIT is 125mV/Lsb,
> +		 * but the vin scale is set to 31.25mV/Lsb(using r/m/b scale), so the word data
> +		 * should divide by MP2869_VIN_OV_FAULT_GAIN(4)
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    (ret & ~GENMASK(7, 0)) |
> +					FIELD_PREP(GENMASK(7, 0),
> +						   DIV_ROUND_CLOSEST(word,
> +								     MP2869_VIN_OV_FAULT_GAIN)));
> +		break;
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +		/*
> +		 * The PMBUS_VIN_UV_LIMIT[9:0] is the limit value, and bit10-bit15 should
> +		 * not be changed. The scale of PMBUS_VIN_UV_LIMIT is 31.25mV/Lsb, and the
> +		 * vin scale is set to 31.25mV/Lsb(using r/m/b scale), so the word data can
> +		 * be written directly.
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    (ret & ~GENMASK(9, 0)) |
> +						FIELD_PREP(GENMASK(9, 0),
> +							   word));
> +		break;
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    DIV_ROUND_CLOSEST(word *
> +									MP2869_READ_IOUT_DIV,

Odd alignment

> +						    MP2869_IOUT_LIMIT_UINT *
> +							data->iout_scale[page]));
> +		break;
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +		/*
> +		 * The POUT_OP_WARN_LIMIT[11:0] is the limit value, and bit12-bit15 should
> +		 * not be changed. The scale of POUT_OP_WARN_LIMIT is 2W/Lsb.
> +		 */
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    (ret & ~GENMASK(11, 0)) |
> +					FIELD_PREP(GENMASK(11, 0),
> +						   DIV_ROUND_CLOSEST(word,
> +								     MP2869_POUT_OP_GAIN)));
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2869_identify(struct i2c_client *client, struct pmbus_driver_info *info)
> +{
> +	int ret;
> +
> +	/* Identify whether tsns digital fault is enable */
> +	ret = mp2869_identify_thwn_flt(client, info, 1);
> +	if (ret < 0)
> +		return 0;
> +
> +	/* Identify vout scale for rail1. */
> +	ret = mp2869_identify_vout_scale(client, info, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify vout scale for rail2. */
> +	ret = mp2869_identify_vout_scale(client, info, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify iout scale for rail 1. */
> +	ret = mp2869_identify_iout_scale(client, info, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify iout scale for rail 2. */
> +	return mp2869_identify_iout_scale(client, info, 1);
> +}
> +
> +static const struct pmbus_driver_info mp2869_info = {
> +	.pages = MP2869_PAGE_NUM,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +
> +	.m[PSC_VOLTAGE_IN] = 32,
> +	.R[PSC_VOLTAGE_IN] = 0,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +
> +	.m[PSC_CURRENT_OUT] = 1,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.b[PSC_CURRENT_OUT] = 0,
> +
> +	.m[PSC_TEMPERATURE] = 1,
> +	.R[PSC_TEMPERATURE] = 0,
> +	.b[PSC_TEMPERATURE] = 0,
> +
> +	.m[PSC_POWER] = 1,
> +	.R[PSC_POWER] = 0,
> +	.b[PSC_POWER] = 0,
> +
> +	.func[0] = MP2869_RAIL1_FUNC,
> +	.func[1] = MP2869_RAIL2_FUNC,
> +	.read_word_data = mp2869_read_word_data,
> +	.write_word_data = mp2869_write_word_data,
> +	.read_byte_data = mp2869_read_byte_data,
> +	.identify = mp2869_identify,
> +};
> +
> +static int mp2869_probe(struct i2c_client *client)
> +{
> +	struct pmbus_driver_info *info;
> +	struct mp2869_data *data;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2869_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2869_info, sizeof(*info));
> +	info = &data->info;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct i2c_device_id mp2869_id[] = {
> +	{"mp2869", mp2869},
> +	{"mp29608", mp29608},
> +	{"mp29612", mp29612},
> +	{"mp29816", mp29816},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mp2869_id);
> +
> +static const struct of_device_id __maybe_unused mp2869_of_match[] = {
> +	{.compatible = "mps,mp2869", .data = (void *)mp2869},
> +	{.compatible = "mps,mp29608", .data = (void *)mp29608},
> +	{.compatible = "mps,mp29612", .data = (void *)mp29612},
> +	{.compatible = "mps,mp29816", .data = (void *)mp29816},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2869_of_match);
> +
> +static struct i2c_driver mp2869_driver = {
> +	.driver = {
> +		.name = "mp2869",
> +		.of_match_table = mp2869_of_match,
> +	},
> +	.probe = mp2869_probe,
> +	.id_table = mp2869_id,
> +};
> +
> +module_i2c_driver(mp2869_driver);
> +
> +MODULE_AUTHOR("Wensheng Wang <wenswang@yeah.net>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP2869");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("PMBUS");

