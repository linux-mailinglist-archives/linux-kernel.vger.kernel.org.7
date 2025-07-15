Return-Path: <linux-kernel+bounces-732182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9BB06324
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE79B581432
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFD26B765;
	Tue, 15 Jul 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7hca3F6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A406265637;
	Tue, 15 Jul 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593769; cv=none; b=IiBdBG/3QpTITBSDHy2rG2dGRnU0723VPeueFmfParvk6jp+2K+u73Ri1YlBPKw7lg2sA1/b4Kh4q61w/rdDBDFxBZN3wseupxYcVvzc/xfyx5rBWokue05CE4Eojj9aPjmGcAFXo8cpvCdxwsyGrCx/NJbw26fk5Gxl/qA5yQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593769; c=relaxed/simple;
	bh=iXgG2U7yP2cpQZY6q5jgQ6TH3iOXMrkY1Ht0Nm+Lm58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLOc6IhmeXwNL6UbyKjrDqLVS7AxsxufmmpwBvHQWkF+bxDVfWDvq5C9L/N9/sH8Q7EvsNEoSW+o+JHeozXU/VYfSrYdpAa8uslmppeXnLV8zAnTbNP5gaVis7RZpsLA73n8ljqGOScWi+DOhqXDg/dZ+THb+uS9USFD397vbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7hca3F6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45555e3317aso25085785e9.3;
        Tue, 15 Jul 2025 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752593765; x=1753198565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1muAs6uZIQeqlPfNJnrlB3AEMhYTlA+qimVUOMJkFwI=;
        b=X7hca3F6I/BIqLaCyakYmxhYSLPWHI+XgSaFxRWOw8BLnW67KzCPF4GxETVcf312gL
         QVLIGgQ7VRDkGGd7XPSuTOjsNuxcGcRkYf07ktSYlC23Ip79HIbBvDwzWfwOb06bn7Gh
         s7RBexFlM1lPI/G+kGfI6sipMUSAuxR7lhBNX9pFEoJgGBswoKUliSNFB2CPzFCCYGo8
         l07x2ovy232aDgtsHpy5piQSMJwvtuTG9MvJfFef87r6gdt2f9bGiExK0S1ATcmrANR1
         aHJntLdYuDaLvIornO3KL5n/UrQvovg4nhjYa7iCGkER8ZMvGW0aIud16H6hZbLXORgu
         fQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593765; x=1753198565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1muAs6uZIQeqlPfNJnrlB3AEMhYTlA+qimVUOMJkFwI=;
        b=a3Y061YWcjxAv2XCe0FwgO+KjG92W1EBQcK+jTp6wQrTPCv6pBchI8NjkD5MnxLrlT
         AiNJnAK0gZ6mqvEed5YTGWc1vbR1ODXJ3HFcjweyMk4GT4EyL2f88ClLN/6IjdenlCK4
         5q9lp8rU8HdosdGIK0CMiWxyI1fTDAm5UBNgnH1q2fVXePgCbhv6QOxEuvn71m2EKun9
         TqOxvS1KJgW2qn2DyDSb8ok2qERgPU721kytohdu73kMKtWq4cxxyN+dsW/E7lMly6ay
         oTuHrQIFTa63QNd1YMya9SaCIsCS1ugV1yRCQyTTaPPMOPqGUvrt+cB2ogzo584thKlF
         LEnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2MxdTMRcTfR+zjypEW2x+z+I9pqlRrtzEappDWdrX+wGGKiChAahFub2Ww/IJMmcWatDIdGlruQQZix3Y@vger.kernel.org, AJvYcCXjp/xv0uBRtCrhCucKwJcNPy81vr8psIKmZn4K/89YGpxIgdSzoNdeIRXyzkqBB7xLeD7f8FLyeufE@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3gPNZgg8PNVVcphWMaYa3gQ7MGdXobYnD+X9M8RlnH6cOalF
	vo0NwzIdK7aVFgCgLa6gC2x6qRApWpiKKjUWEssDVqzxUWrjly0Vb85C
X-Gm-Gg: ASbGncu3qTt5hxETsloqVvuq3uVJ3gMk3t5M4/C4Nj79wWnBIIdCD+uz7eQPfpiwXEK
	B6lCVA8luTTI0TdhSzNSZ84XxbjEq8gYYSqAI49RELcyPm3cYzWlDZ5h6tPvsSwQCk5278iU0pV
	rB6IKdMeZaozpoGS2qZjCysA+fVgN0fHmjrOCVvIf/EijS7LUTAl/bkSDY0ZTpyauUXTPnQCno0
	Yrh8LqKy9vDRF6aL1oEqF4V6eZDd83hWIjw9kxHzNhFy70LC6VQmwWpKmG1mpAjazyvIYcVN6Se
	4jHgYxVn5MVuzPRX5vmurX88FSAg6Yf7s8NGgXfmtK6ae5Ukh/QFg7V68ZNgu9ZZSWeGGI1JFwn
	Mc6JFYCBg+por9oKKevPj
X-Google-Smtp-Source: AGHT+IEKThzNTB5vsFlWZwdtTDFUHMxfMcTMzybZXLq+o94NFDo+mDhKuRFN+8IXALjz3Cv9TL9bVg==
X-Received: by 2002:a05:600c:1c14:b0:456:28f4:a576 with SMTP id 5b1f17b1804b1-45628f4a959mr23728935e9.27.1752593764796;
        Tue, 15 Jul 2025 08:36:04 -0700 (PDT)
Received: from masalkhi.. ([61.8.131.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dbddsm15675398f8f.63.2025.07.15.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:36:04 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: abd.masalkhi@gmail.com
Cc: arnd@arndb.de,
	christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	robh@kernel.org
Subject: Re: [PATCH v6 2/3] eeprom: add driver for ST M24LR series RFID/NFC EEPROM chips
Date: Tue, 15 Jul 2025 15:36:02 +0000
Message-ID: <20250715153602.1149-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706105311.395162-3-abd.masalkhi@gmail.com>
References: <20250706105311.395162-3-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping.

Best regards,
Abd-Alrhman Masalkhi

> adds support for STMicroelectronics M24LRxx devices, which expose
> two separate I2C addresses: one for system control and one for EEPROM
> access. The driver implements both a sysfs-based interface for control
> registers (e.g. UID, password authentication) and an nvmem provider
> for EEPROM access.
> 
> Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> ---
> Changes in v6:
>  - Added cleanup on UID read failure (removes bin file before returning)
>  - Used size_add() to prevent overflow in sysfs read/write bounds check
>  - Corrected type of return variables (using ssize_t consistently)
>  - Replaced dev_err() with dev_err_probe()
>  - Small style and formatting cleanups
>  - Link to v5: https://lore.kernel.org/all/20250704123914.11216-3-abd.masalkhi@gmail.com/
> 
> Changes in v5:
>  - Fixed function signatures in m24lr_ctl_sss_read and m24lr_ctl_sss_write
>    to use const struct bin_attribute *attr
>  - Link to v4: https://lore.kernel.org/lkml/20250608182714.3359441-3-abd.masalkhi@gmail.com/
> 
> Changes in v4:
>  - Moved the source file to the eeprom/ directory
>  - Removed use of unlikely() macro
>  - Removed use of EIO as a fallback error
>  - Stopped dynamically creating sysfs attributes
>  - Replaced per-sector SSS attributes with a single bin_attribute
>    for all SSS
>  - Introduced total_sectors sysfs attribute to report the number
>    of valid sectors
>  - Avoided sharing a single show/store callback across multiple
>    attribute types
>  - Link to v3: https://lore.kernel.org/lkml/20250606120631.3140054-3-abd.masalkhi@gmail.com/
> 
> Changes in v3:
>  - Fully support the M24LR chips, including EEPROM access, no need for
>    the standard at24 driver to handle EEPROM separately.
>  - Rename the driver file from m24lr_ctl.c to m24lr.c.
>  - Rename all identifiers from the m24lr_ctl prefix to m24lr.
>  - Retain the m24lr_ctl prefix for control-related routines to distinguish
>    them from EEPROM-related logic.
>  - Drop usage of the I2C mux API.
>  - Use the NVMEM subsystem to handle EEPROM access.
>  - Add REGMAP support for EEPROM register access.
>  - Update Kconfig entry to reflect that the driver now supports both
>    control and EEPROM functionality.
>  - Link to v2: https://lore.kernel.org/lkml/20250601153022.2027919-3-abd.masalkhi@gmail.com/
> 
> Changes in v2:
>  - Fix compiling Errors and Warnings
>  - Replace scnprintf with sysfs_emit
>  - Drop success log message from probe.
>  - Link to v1: https://lore.kernel.org/lkml/20250531081159.2007319-3-abd.masalkhi@gmail.com/
> 
> Comment:
>  - Running checkpatch emit a warning for non-const regmap_config.
>    The variable must remain auto and mutable due to runtime manipulation.
> ---
>  drivers/misc/eeprom/Kconfig  |  18 +
>  drivers/misc/eeprom/Makefile |   1 +
>  drivers/misc/eeprom/m24lr.c  | 662 +++++++++++++++++++++++++++++++++++
>  3 files changed, 681 insertions(+)
>  create mode 100644 drivers/misc/eeprom/m24lr.c
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index cb1c4b8e7fd3..cb0ce243babd 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -119,4 +119,22 @@ config EEPROM_EE1004
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called ee1004.
>  
> +config EEPROM_M24LR
> +	tristate "STMicroelectronics M24LR RFID/NFC EEPROM support"
> +	depends on I2C && SYSFS
> +	select REGMAP_I2C
> +	select NVMEM
> +	select NVMEM_SYSFS
> +	help
> +	  This enables support for STMicroelectronics M24LR RFID/NFC EEPROM
> +	  chips. These dual-interface devices expose two I2C addresses:
> +	  one for EEPROM memory access and another for control and system
> +	  configuration (e.g. UID, password handling).
> +
> +	  This driver provides a sysfs interface for control functions and
> +	  integrates with the nvmem subsystem for EEPROM access.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called m24lr.
> +
>  endmenu
> diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
> index 65794e526d5d..8f311fd6a4ce 100644
> --- a/drivers/misc/eeprom/Makefile
> +++ b/drivers/misc/eeprom/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
>  obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
>  obj-$(CONFIG_EEPROM_IDT_89HPESX) += idt_89hpesx.o
>  obj-$(CONFIG_EEPROM_EE1004)	+= ee1004.o
> +obj-$(CONFIG_EEPROM_M24LR) += m24lr.o
> diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
> new file mode 100644
> index 000000000000..3f9c4e8ab41c
> --- /dev/null
> +++ b/drivers/misc/eeprom/m24lr.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * m24lr.c - Sysfs control interface for ST M24LR series RFID/NFC chips
> + *
> + * Copyright (c) 2025 Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> + *
> + * This driver implements both the sysfs-based control interface and EEPROM
> + * access for STMicroelectronics M24LR series chips (e.g., M24LR04E-R).
> + * It provides access to control registers for features such as password
> + * authentication, memory protection, and device configuration. In addition,
> + * it manages read and write operations to the EEPROM region of the chip.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#define M24LR_WRITE_TIMEOUT	  25u
> +#define M24LR_READ_TIMEOUT	  (M24LR_WRITE_TIMEOUT)
> +
> +/**
> + * struct m24lr_chip - describes chip-specific sysfs layout
> + * @sss_len:       the length of the sss region
> + * @page_size:	   chip-specific limit on the maximum number of bytes allowed
> + *		   in a single write operation.
> + * @eeprom_size:   size of the EEPROM in byte
> + *
> + * Supports multiple M24LR chip variants (e.g., M24LRxx) by allowing each
> + * to define its own set of sysfs attributes, depending on its available
> + * registers and features.
> + */
> +struct m24lr_chip {
> +	unsigned int sss_len;
> +	unsigned int page_size;
> +	unsigned int eeprom_size;
> +};
> +
> +/**
> + * struct m24lr - core driver data for M24LR chip control
> + * @uid:           64 bits unique identifier stored in the device
> + * @sss_len:       the length of the sss region
> + * @page_size:	   chip-specific limit on the maximum number of bytes allowed
> + *		   in a single write operation.
> + * @eeprom_size:   size of the EEPROM in byte
> + * @ctl_regmap:	   regmap interface for accessing the system parameter sector
> + * @eeprom_regmap: regmap interface for accessing the EEPROM
> + * @lock:	   mutex to synchronize operations to the device
> + *
> + * Central data structure holding the state and resources used by the
> + * M24LR device driver.
> + */
> +struct m24lr {
> +	u64 uid;
> +	unsigned int sss_len;
> +	unsigned int page_size;
> +	unsigned int eeprom_size;
> +	struct regmap *ctl_regmap;
> +	struct regmap *eeprom_regmap;
> +	struct mutex lock;	 /* synchronize operations to the device */
> +};
> +
> +static const struct regmap_range m24lr_ctl_vo_ranges[] = {
> +	regmap_reg_range(0, 63),
> +};
> +
> +static const struct regmap_access_table m24lr_ctl_vo_table = {
> +	.yes_ranges = m24lr_ctl_vo_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(m24lr_ctl_vo_ranges),
> +};
> +
> +static const struct regmap_config m24lr_ctl_regmap_conf = {
> +	.name = "m24lr_ctl",
> +	.reg_stride = 1,
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.disable_locking = false,
> +	.cache_type = REGCACHE_RBTREE,/* Flat can't be used, there's huge gap */
> +	.volatile_table = &m24lr_ctl_vo_table,
> +};
> +
> +/* Chip descriptor for M24LR04E-R variant */
> +static const struct m24lr_chip m24lr04e_r_chip = {
> +	.page_size = 4,
> +	.eeprom_size = 512,
> +	.sss_len = 4,
> +};
> +
> +/* Chip descriptor for M24LR16E-R variant */
> +static const struct m24lr_chip m24lr16e_r_chip = {
> +	.page_size = 4,
> +	.eeprom_size = 2048,
> +	.sss_len = 16,
> +};
> +
> +/* Chip descriptor for M24LR64E-R variant */
> +static const struct m24lr_chip m24lr64e_r_chip = {
> +	.page_size = 4,
> +	.eeprom_size = 8192,
> +	.sss_len = 64,
> +};
> +
> +static const struct i2c_device_id m24lr_ids[] = {
> +	{ "m24lr04e-r", (kernel_ulong_t)&m24lr04e_r_chip},
> +	{ "m24lr16e-r", (kernel_ulong_t)&m24lr16e_r_chip},
> +	{ "m24lr64e-r", (kernel_ulong_t)&m24lr64e_r_chip},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, m24lr_ids);
> +
> +static const struct of_device_id m24lr_of_match[] = {
> +	{ .compatible = "st,m24lr04e-r", .data = &m24lr04e_r_chip},
> +	{ .compatible = "st,m24lr16e-r", .data = &m24lr16e_r_chip},
> +	{ .compatible = "st,m24lr64e-r", .data = &m24lr64e_r_chip},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, m24lr_of_match);
> +
> +/**
> + * m24lr_parse_le_value - Parse hex string and convert to little-endian binary
> + * @buf:	Input string buffer (hex format)
> + * @reg_size:	Size of the register in bytes (must be 1, 2, 4, or 8)
> + * @output:	Output buffer to store the value in little-endian format
> + *
> + * Converts a hexadecimal string to a numeric value of the given register size
> + * and writes it in little-endian byte order into the provided buffer.
> + *
> + * Return: 0 on success, or negative error code on failure
> + */
> +static __maybe_unused int m24lr_parse_le_value(const char *buf, u32 reg_size,
> +					       u8 *output)
> +{
> +	int err;
> +
> +	switch (reg_size) {
> +	case 1: {
> +		u8 tmp;
> +
> +		err = kstrtou8(buf, 16, &tmp);
> +		if (!err)
> +			*output = tmp;
> +		break;
> +	}
> +	case 2: {
> +		u16 tmp;
> +
> +		err = kstrtou16(buf, 16, &tmp);
> +		if (!err)
> +			*(__le16 *)output = cpu_to_le16(tmp);
> +		break;
> +	}
> +	case 4: {
> +		u32 tmp;
> +
> +		err = kstrtou32(buf, 16, &tmp);
> +		if (!err)
> +			*(__le32 *)output = cpu_to_le32(tmp);
> +		break;
> +	}
> +	case 8: {
> +		u64 tmp;
> +
> +		err = kstrtou64(buf, 16, &tmp);
> +		if (!err)
> +			*(__le64 *)output = cpu_to_le64(tmp);
> +		break;
> +	}
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * m24lr_regmap_read - read data using regmap with retry on failure
> + * @regmap:  regmap instance for the device
> + * @buf:     buffer to store the read data
> + * @size:    number of bytes to read
> + * @offset:  starting register address
> + *
> + * Attempts to read a block of data from the device with retries and timeout.
> + * Some M24LR chips may transiently NACK reads (e.g., during internal write
> + * cycles), so this function retries with a short sleep until the timeout
> + * expires.
> + *
> + * Returns:
> + *	 Number of bytes read on success,
> + *	 -ETIMEDOUT if the read fails within the timeout window.
> + */
> +static ssize_t m24lr_regmap_read(struct regmap *regmap, u8 *buf,
> +				 size_t size, unsigned int offset)
> +{
> +	int err;
> +	unsigned long timeout, read_time;
> +	ssize_t ret = -ETIMEDOUT;
> +
> +	timeout = jiffies + msecs_to_jiffies(M24LR_READ_TIMEOUT);
> +	do {
> +		read_time = jiffies;
> +
> +		err = regmap_bulk_read(regmap, offset, buf, size);
> +		if (!err) {
> +			ret = size;
> +			break;
> +		}
> +
> +		usleep_range(1000, 2000);
> +	} while (time_before(read_time, timeout));
> +
> +	return ret;
> +}
> +
> +/**
> + * m24lr_regmap_write - write data using regmap with retry on failure
> + * @regmap: regmap instance for the device
> + * @buf:    buffer containing the data to write
> + * @size:   number of bytes to write
> + * @offset: starting register address
> + *
> + * Attempts to write a block of data to the device with retries and a timeout.
> + * Some M24LR devices may NACK I2C writes while an internal write operation
> + * is in progress. This function retries the write operation with a short delay
> + * until it succeeds or the timeout is reached.
> + *
> + * Returns:
> + *	 Number of bytes written on success,
> + *	 -ETIMEDOUT if the write fails within the timeout window.
> + */
> +static ssize_t m24lr_regmap_write(struct regmap *regmap, const u8 *buf,
> +				  size_t size, unsigned int offset)
> +{
> +	int err;
> +	unsigned long timeout, write_time;
> +	ssize_t ret = -ETIMEDOUT;
> +
> +	timeout = jiffies + msecs_to_jiffies(M24LR_WRITE_TIMEOUT);
> +
> +	do {
> +		write_time = jiffies;
> +
> +		err = regmap_bulk_write(regmap, offset, buf, size);
> +		if (!err) {
> +			ret = size;
> +			break;
> +		}
> +
> +		usleep_range(1000, 2000);
> +	} while (time_before(write_time, timeout));
> +
> +	return ret;
> +}
> +
> +static ssize_t m24lr_read(struct m24lr *m24lr, u8 *buf, size_t size,
> +			  unsigned int offset, bool is_eeprom)
> +{
> +	struct regmap *regmap;
> +	ssize_t ret;
> +
> +	if (is_eeprom)
> +		regmap = m24lr->eeprom_regmap;
> +	else
> +		regmap = m24lr->ctl_regmap;
> +
> +	mutex_lock(&m24lr->lock);
> +	ret = m24lr_regmap_read(regmap, buf, size, offset);
> +	mutex_unlock(&m24lr->lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * m24lr_write - write buffer to M24LR device with page alignment handling
> + * @m24lr:     pointer to driver context
> + * @buf:       data buffer to write
> + * @size:      number of bytes to write
> + * @offset:    target register address in the device
> + * @is_eeprom: true if the write should target the EEPROM,
> + *             false if it should target the system parameters sector.
> + *
> + * Writes data to the M24LR device using regmap, split into chunks no larger
> + * than page_size to respect device-specific write limitations (e.g., page
> + * size or I2C hold-time concerns). Each chunk is aligned to the page boundary
> + * defined by page_size.
> + *
> + * Returns:
> + *	 Total number of bytes written on success,
> + *	 A negative error code if any write fails.
> + */
> +static ssize_t m24lr_write(struct m24lr *m24lr, const u8 *buf, size_t size,
> +			   unsigned int offset, bool is_eeprom)
> +{
> +	unsigned int n, next_sector;
> +	struct regmap *regmap;
> +	ssize_t ret = 0;
> +	ssize_t err;
> +
> +	if (is_eeprom)
> +		regmap = m24lr->eeprom_regmap;
> +	else
> +		regmap = m24lr->ctl_regmap;
> +
> +	n = min_t(unsigned int, size, m24lr->page_size);
> +	next_sector = roundup(offset + 1, m24lr->page_size);
> +	if (offset + n > next_sector)
> +		n = next_sector - offset;
> +
> +	mutex_lock(&m24lr->lock);
> +	while (n) {
> +		err = m24lr_regmap_write(regmap, buf + offset, n, offset);
> +		if (IS_ERR_VALUE(err)) {
> +			if (!ret)
> +				ret = err;
> +
> +			break;
> +		}
> +
> +		offset += n;
> +		size -= n;
> +		ret += n;
> +		n = min_t(unsigned int, size, m24lr->page_size);
> +	}
> +	mutex_unlock(&m24lr->lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * m24lr_write_pass - Write password to M24LR043-R using secure format
> + * @m24lr: Pointer to device control structure
> + * @buf:   Input buffer containing hex-encoded password
> + * @count: Number of bytes in @buf
> + * @code:  Operation code to embed between password copies
> + *
> + * This function parses a 4-byte password, encodes it in  big-endian format,
> + * and constructs a 9-byte sequence of the form:
> + *
> + *	  [BE(password), code, BE(password)]
> + *
> + * The result is written to register 0x0900 (2304), which is the password
> + * register in M24LR04E-R chip.
> + *
> + * Return: Number of bytes written on success, or negative error code on failure
> + */
> +static ssize_t m24lr_write_pass(struct m24lr *m24lr, const char *buf,
> +				size_t count, u8 code)
> +{
> +	__be32 be_pass;
> +	u8 output[9];
> +	ssize_t ret;
> +	u32 pass;
> +	int err;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	if (count > 8)
> +		return -EINVAL;
> +
> +	err = kstrtou32(buf, 16, &pass);
> +	if (err)
> +		return err;
> +
> +	be_pass = cpu_to_be32(pass);
> +
> +	memcpy(output, &be_pass, sizeof(be_pass));
> +	output[4] = code;
> +	memcpy(output + 5, &be_pass, sizeof(be_pass));
> +
> +	mutex_lock(&m24lr->lock);
> +	ret = m24lr_regmap_write(m24lr->ctl_regmap, output, 9, 2304);
> +	mutex_unlock(&m24lr->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t m24lr_read_reg_le(struct m24lr *m24lr, u64 *val,
> +				 unsigned int reg_addr,
> +				 unsigned int reg_size)
> +{
> +	ssize_t ret;
> +	__le64 input = 0;
> +
> +	ret = m24lr_read(m24lr, (u8 *)&input, reg_size, reg_addr, false);
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	if (ret != reg_size)
> +		return -EINVAL;
> +
> +	switch (reg_size) {
> +	case 1:
> +		*val = *(u8 *)&input;
> +		break;
> +	case 2:
> +		*val = le16_to_cpu((__le16)input);
> +		break;
> +	case 4:
> +		*val = le32_to_cpu((__le32)input);
> +		break;
> +	case 8:
> +		*val = le64_to_cpu((__le64)input);
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	return 0;
> +}
> +
> +static int m24lr_nvmem_read(void *priv, unsigned int offset, void *val,
> +			    size_t bytes)
> +{
> +	ssize_t err;
> +	struct m24lr *m24lr = priv;
> +
> +	if (!bytes)
> +		return bytes;
> +
> +	if (offset + bytes > m24lr->eeprom_size)
> +		return -EINVAL;
> +
> +	err = m24lr_read(m24lr, val, bytes, offset, true);
> +	if (IS_ERR_VALUE(err))
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int m24lr_nvmem_write(void *priv, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	ssize_t err;
> +	struct m24lr *m24lr = priv;
> +
> +	if (!bytes)
> +		return -EINVAL;
> +
> +	if (offset + bytes > m24lr->eeprom_size)
> +		return -EINVAL;
> +
> +	err = m24lr_write(m24lr, val, bytes, offset, true);
> +	if (IS_ERR_VALUE(err))
> +		return err;
> +
> +	return 0;
> +}
> +
> +static ssize_t m24lr_ctl_sss_read(struct file *filep, struct kobject *kobj,
> +				  const struct bin_attribute *attr, char *buf,
> +				  loff_t offset, size_t count)
> +{
> +	struct m24lr *m24lr = attr->private;
> +
> +	if (!count)
> +		return count;
> +
> +	if (size_add(offset, count) > m24lr->sss_len)
> +		return -EINVAL;
> +
> +	return m24lr_read(m24lr, buf, count, offset, false);
> +}
> +
> +static ssize_t m24lr_ctl_sss_write(struct file *filep, struct kobject *kobj,
> +				   const struct bin_attribute *attr, char *buf,
> +				   loff_t offset, size_t count)
> +{
> +	struct m24lr *m24lr = attr->private;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	if (size_add(offset, count) > m24lr->sss_len)
> +		return -EINVAL;
> +
> +	return m24lr_write(m24lr, buf, count, offset, false);
> +}
> +static BIN_ATTR(sss, 0600, m24lr_ctl_sss_read, m24lr_ctl_sss_write, 0);
> +
> +static ssize_t new_pass_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct m24lr *m24lr = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return m24lr_write_pass(m24lr, buf, count, 7);
> +}
> +static DEVICE_ATTR_WO(new_pass);
> +
> +static ssize_t unlock_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct m24lr *m24lr = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return m24lr_write_pass(m24lr, buf, count, 9);
> +}
> +static DEVICE_ATTR_WO(unlock);
> +
> +static ssize_t uid_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct m24lr *m24lr = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return sysfs_emit(buf, "%llx\n", m24lr->uid);
> +}
> +static DEVICE_ATTR_RO(uid);
> +
> +static ssize_t total_sectors_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct m24lr *m24lr = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return sysfs_emit(buf, "%x\n", m24lr->sss_len);
> +}
> +static DEVICE_ATTR_RO(total_sectors);
> +
> +static struct attribute *m24lr_ctl_dev_attrs[] = {
> +	&dev_attr_unlock.attr,
> +	&dev_attr_new_pass.attr,
> +	&dev_attr_uid.attr,
> +	&dev_attr_total_sectors.attr,
> +	NULL,
> +};
> +
> +static const struct m24lr_chip *m24lr_get_chip(struct device *dev)
> +{
> +	const struct m24lr_chip *ret;
> +	const struct i2c_device_id *id;
> +
> +	id = i2c_match_id(m24lr_ids, to_i2c_client(dev));
> +
> +	if (dev->of_node && of_match_device(m24lr_of_match, dev))
> +		ret = of_device_get_match_data(dev);
> +	else if (id)
> +		ret = (void *)id->driver_data;
> +	else
> +		ret = acpi_device_get_match_data(dev);
> +
> +	return ret;
> +}
> +
> +static int m24lr_probe(struct i2c_client *client)
> +{
> +	struct regmap_config eeprom_regmap_conf = {0};
> +	struct nvmem_config nvmem_conf = {0};
> +	struct device *dev = &client->dev;
> +	struct i2c_client *eeprom_client;
> +	const struct m24lr_chip *chip;
> +	struct regmap *eeprom_regmap;
> +	struct nvmem_device *nvmem;
> +	struct regmap *ctl_regmap;
> +	struct m24lr *m24lr;
> +	u32 regs[2];
> +	long err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	chip = m24lr_get_chip(dev);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	m24lr = devm_kzalloc(dev, sizeof(struct m24lr), GFP_KERNEL);
> +	if (!m24lr)
> +		return -ENOMEM;
> +
> +	err = device_property_read_u32_array(dev, "reg", regs, ARRAY_SIZE(regs));
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to read 'reg' property\n");
> +
> +	/* Create a second I2C client for the eeprom interface */
> +	eeprom_client = devm_i2c_new_dummy_device(dev, client->adapter, regs[1]);
> +	if (IS_ERR(eeprom_client))
> +		return dev_err_probe(dev, PTR_ERR(eeprom_client),
> +				     "Failed to create dummy I2C client for the EEPROM\n");
> +
> +	ctl_regmap = devm_regmap_init_i2c(client, &m24lr_ctl_regmap_conf);
> +	if (IS_ERR(ctl_regmap))
> +		return dev_err_probe(dev, PTR_ERR(ctl_regmap),
> +				      "Failed to init regmap\n");
> +
> +	eeprom_regmap_conf.name = "m24lr_eeprom";
> +	eeprom_regmap_conf.reg_bits = 16;
> +	eeprom_regmap_conf.val_bits = 8;
> +	eeprom_regmap_conf.disable_locking = true;
> +	eeprom_regmap_conf.max_register = chip->eeprom_size - 1;
> +
> +	eeprom_regmap = devm_regmap_init_i2c(eeprom_client,
> +					     &eeprom_regmap_conf);
> +	if (IS_ERR(eeprom_regmap))
> +		return dev_err_probe(dev, PTR_ERR(eeprom_regmap),
> +				     "Failed to init regmap\n");
> +
> +	mutex_init(&m24lr->lock);
> +	m24lr->sss_len = chip->sss_len;
> +	m24lr->page_size = chip->page_size;
> +	m24lr->eeprom_size = chip->eeprom_size;
> +	m24lr->eeprom_regmap = eeprom_regmap;
> +	m24lr->ctl_regmap = ctl_regmap;
> +
> +	nvmem_conf.dev = &eeprom_client->dev;
> +	nvmem_conf.owner = THIS_MODULE;
> +	nvmem_conf.type = NVMEM_TYPE_EEPROM;
> +	nvmem_conf.reg_read = m24lr_nvmem_read;
> +	nvmem_conf.reg_write = m24lr_nvmem_write;
> +	nvmem_conf.size = chip->eeprom_size;
> +	nvmem_conf.word_size = 1;
> +	nvmem_conf.stride = 1;
> +	nvmem_conf.priv = m24lr;
> +
> +	nvmem = devm_nvmem_register(dev, &nvmem_conf);
> +	if (IS_ERR(nvmem))
> +		return dev_err_probe(dev, PTR_ERR(nvmem),
> +				     "Failed to register nvmem\n");
> +
> +	i2c_set_clientdata(client, m24lr);
> +	i2c_set_clientdata(eeprom_client, m24lr);
> +
> +	bin_attr_sss.size = chip->sss_len;
> +	bin_attr_sss.private = m24lr;
> +	err = sysfs_create_bin_file(&dev->kobj, &bin_attr_sss);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Failed to create sss bin file\n");
> +
> +	/* test by reading the uid, if success store it */
> +	err = m24lr_read_reg_le(m24lr, &m24lr->uid, 2324, sizeof(m24lr->uid));
> +	if (IS_ERR_VALUE(err))
> +		goto remove_bin_file;
> +
> +	return 0;
> +
> +remove_bin_file:
> +	sysfs_remove_bin_file(&dev->kobj, &bin_attr_sss);
> +
> +	return err;
> +}
> +
> +static void m24lr_remove(struct i2c_client *client)
> +{
> +	sysfs_remove_bin_file(&client->dev.kobj, &bin_attr_sss);
> +}
> +
> +ATTRIBUTE_GROUPS(m24lr_ctl_dev);
> +
> +static struct i2c_driver m24lr_driver = {
> +	.driver = {
> +		.name = "m24lr",
> +		.of_match_table = m24lr_of_match,
> +		.dev_groups = m24lr_ctl_dev_groups,
> +	},
> +	.probe	  = m24lr_probe,
> +	.remove = m24lr_remove,
> +	.id_table = m24lr_ids,
> +};
> +module_i2c_driver(m24lr_driver);
> +
> +MODULE_AUTHOR("Abd-Alrhman Masalkhi");
> +MODULE_DESCRIPTION("st m24lr control driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0

