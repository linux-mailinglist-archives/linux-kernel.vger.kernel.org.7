Return-Path: <linux-kernel+bounces-846618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FDBC88C4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328FB4EF3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1052DC76A;
	Thu,  9 Oct 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw9bR0aC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102122D7D2F;
	Thu,  9 Oct 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006583; cv=none; b=ll/kB/SVXuQwBgzfQWelEfryMRu0QXb99lpHNIHgTMM37lvIZEtYC+ZIhLdXS34hPVzjZbfJIcaEoWih8i+bFY3dFKt+ePzujsD+E3aDY6CQqxTw2JWBObVQMwVZNVM7Apn1kfqXLUeybmBHLQZWORtnJ7f1myGKFsT3uiAvFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006583; c=relaxed/simple;
	bh=mdk8PnGzSM3BqDdXV3TUYYgE8s1iy5xihWA50nVp52s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxKSdc9/bNJydIGHVJqrgIFDEEpczkrOhptAo+BSDJvj5+IP0jG48G2aiVqrNn22O1pA0WsRg4N3LNzL8QD8QzApcT4pJgsgpw+TZWpkm1X46YQmQkciOD/qcZoznLfWHNzSjbaF3+TtDsxqy9q2tJ9ex48kEuVZ9W33PpAzxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw9bR0aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A8C4CEE7;
	Thu,  9 Oct 2025 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760006581;
	bh=mdk8PnGzSM3BqDdXV3TUYYgE8s1iy5xihWA50nVp52s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lw9bR0aCYH5002kE/8Wg4tshe756eE+qnQZZFf/3yW5HiIpSXvrYzQi2lsa3WzSTs
	 HXEt6HKbdv8+nmfSGPUdwII6J+VCuQfixo4QBWYrlmJcb2vGck18kZkYJi89bWrJlV
	 tNpUB8CSIAmSxaS0/0GCOtCGE6FzI37b1uJmldYo/daDF1fAefgu/HWZYEw617ljG4
	 omT3P6xCDzwLrGZHScahD0z3nFwULpPgHtcuve63KFeGkkKYa5R/n6VnNsTvtD1Kqr
	 8plqyTcuQJOptGfL08w73+Zr3zXjr7qfsLU96JtKsIjFnKfu8vWEBi6hUtxLP8d8Bw
	 RhDnCwdPUOE8A==
Date: Thu, 9 Oct 2025 11:42:56 +0100
From: Lee Jones <lee@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v3 2/4] mfd: sony-cronos-cpld: Add driver for Sony Cronos
 CPLD
Message-ID: <20251009104256.GD8757@google.com>
References: <966245414.1748564.1758824280649.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966245414.1748564.1758824280649.JavaMail.zimbra@raptorengineeringinc.com>

When you resubmit this, make sure you send the set threaded.  Each patch
is now spread around throughout all of your recipient's inboxes making
the set impossible to keep track of.

> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller for
> the Sony Interactive Entertainment Cronos x86 server platform. As both
> functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
>  .../ABI/testing/sysfs-driver-sie-cronos       |  87 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  11 +
>  drivers/mfd/Makefile                          |   2 +
>  drivers/mfd/sony-cronos-cpld.c                | 490 ++++++++++++++++++
>  include/linux/mfd/sony/cronos/core.h          |  17 +
>  include/linux/mfd/sony/cronos/registers.h     |  62 +++
>  7 files changed, 676 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-sie-cronos
>  create mode 100644 drivers/mfd/sony-cronos-cpld.c
>  create mode 100644 include/linux/mfd/sony/cronos/core.h
>  create mode 100644 include/linux/mfd/sony/cronos/registers.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-sie-cronos b/Documentation/ABI/testing/sysfs-driver-sie-cronos
> new file mode 100644
> index 000000000000..ba00abf2ced6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-sie-cronos
> @@ -0,0 +1,87 @@
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/revision
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RO) Reports the current version of the Cronos CPLD firmware
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/device_id
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RO) Reports the device ID of the Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/bmc_mac
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RO) Reports the MAC address of the hardware as defined by the
> +		VPD attached to the Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/status_2
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RO) Reports the last boot status code latched into Cronos
> +		CPLD status register 2.  Bits 3:2 indicate the BMC last reset
> +		reason code.
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/uart_mux
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RW) Allows configuration of the on-board UART multiplexer
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/switch_flash
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RW) Allows configuration of boot flash for the switch device
> +		attached to the Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/switch_reset
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RW) Allows software reset of the switch device attached to the
> +		Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/bmc_flash
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RW) Allows configuration of boot flash for the BMC device
> +		attached to the Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD
> +
> +What:		/sys/bus/i2c/devices/.../sony-cronos-cpld.*.auto/payload_power
> +Date:		Sept 2025
> +KernelVersion:	6.18
> +Contact:	Timothy Pearson <tpearson@raptorengineering.com>
> +Description:	(RW) Allows software power control of the payload attached to
> +		the Cronos CPLD
> +
> +Users:		User space applications for system boards equipped with a
> +		Sony Cronos CPLD

This doesn't need to / shouldn't reside in the kernel.

Why not use I2C and handle all of this in userspace?

> \ No newline at end of file

???

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e897f2ba9eb..a1052663fb27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23458,6 +23458,13 @@ S:	Maintained
>  F:	drivers/ssb/
>  F:	include/linux/ssb/
>  
> +SONY CRONOS CPLD DRIVER
> +M:	Georgy Yakovlev <Georgy.Yakovlev@sony.com>

This person is going to have to Ack the fact that you're making them the
person responsible for maintaining this.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> +F:	drivers/mfd/sony-cronos-cpld.c
> +F:	include/linux/mfd/sony/cronos/
> +
>  SONY IMX208 SENSOR DRIVER
>  M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 425c5fba6cb1..cd0c624022f6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2341,6 +2341,17 @@ config MFD_QCOM_PM8008
>  	  under it in the device tree. Additional drivers must be enabled in
>  	  order to use the functionality of the device.
>  
> +config MFD_SONY_CRONOS_CPLD
> +	tristate "Sony Cronos CPLD Support"

Does this driver support CPLD functionality?

Or does the HDL just happen to reside on a CPLD?

> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +      Support for the Sony Cronos system control CPLDs. Additional drivers must
> +      be enabled in order to use the functionality of the device, including LED
> +      control and the system watchdog. The controller itself is a custom design
> +      tailored to the specific needs of the Sony Cronos hardware platform.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f7bdedd5a66d..f30b0a6a6192 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -294,4 +294,6 @@ obj-$(CONFIG_MFD_QNAP_MCU)	+= qnap-mcu.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>  
> +obj-$(CONFIG_MFD_SONY_CRONOS_CPLD)     += sony-cronos-cpld.o
> +
>  obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
> diff --git a/drivers/mfd/sony-cronos-cpld.c b/drivers/mfd/sony-cronos-cpld.c
> new file mode 100644
> index 000000000000..b52fc4d4839d
> --- /dev/null
> +++ b/drivers/mfd/sony-cronos-cpld.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Multi-function device driver for Sony Cronos CPLDs

Drop all mentions of MFD.

> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022-2025  Raptor Engineering, LLC
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/sony/cronos/core.h>
> +#include <linux/mfd/sony/cronos/registers.h>

This list should be in alphabetical order.

> +static const struct mfd_cell cronos_cpld_devs[] = {
> +	{
> +		.name = "cronos-watchdog",
> +		.of_compatible = "sony,cronos-watchdog",
> +	},
> +	{
> +		.name = "cronos-led",
> +		.of_compatible = "sony,cronos-led",
> +	},
> +};

Use MFD_CELL_OF().

> +static ssize_t payload_power_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)

Use 100-chars to prevent these simple line-feeds.

I won't mention line-feeds again, but there are a lot of them.

> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int payloadpower = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG,
> +			  &payloadpower);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", payloadpower);
> +}
> +
> +static ssize_t payload_power_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u8 val = 0;
> +	int ret;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(ddata->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG,
> +			   val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t bmc_flash_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int bmcflash = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG,
> +			  &bmcflash);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", bmcflash);
> +}
> +
> +static ssize_t bmc_flash_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t len)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u8 val = 0;
> +	int ret;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(ddata->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG,
> +			   val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t switch_reset_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int switchreset = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG,
> +			  &switchreset);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", switchreset);
> +}
> +
> +static ssize_t switch_reset_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int switchreset = 0;
> +	u8 val = -EINVAL;
> +	int ret;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG,
> +			  &switchreset);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(ddata->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG,
> +			   switchreset);
> +	if (ret) {
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t switch_flash_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int switchflash = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap,
> +			  CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG,
> +			  &switchflash);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", switchflash);
> +}
> +
> +static ssize_t switch_flash_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u8 val = 0;
> +	int ret;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(ddata->regmap,
> +			   CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG, val);
> +	if (ret) {
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t uart_mux_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int uartmux = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_UART_MUX_REG, &uartmux);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", uartmux);
> +}
> +
> +static ssize_t uart_mux_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u8 val = 0;
> +	int ret;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(ddata->regmap, CRONOS_CPLD_UART_MUX_REG, val);
> +	if (ret) {
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u16 revision = 0;
> +	int ret;
> +
> +	ret = regmap_bulk_read(ddata->regmap, CRONOS_CPLD_REVISION_LOW_REG,
> +			       &revision, 2);
> +	if (ret)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "0x%04x\n", revision);
> +}
> +
> +static ssize_t device_id_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u16 device_id = 0;
> +	int ret;
> +
> +	ret = regmap_bulk_read(ddata->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG,
> +			       &device_id, 2);
> +	if (ret)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "0x%04x\n", device_id);
> +}
> +
> +static ssize_t bmc_mac_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	u8 bmc_mac[6];
> +	int ret;
> +
> +	ret = regmap_bulk_read(ddata->regmap, CRONOS_CPLD_BMC_MAC_LOW_REG,
> +			       bmc_mac, 6);
> +	if (ret)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%pM\n", bmc_mac);
> +}
> +
> +static ssize_t status_2_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct sony_cronos_cpld *ddata = dev_get_drvdata(dev);
> +	unsigned int last_boot = 0;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_STATUS_2_REG, &last_boot);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%02x\n", last_boot);
> +}
> +
> +static DEVICE_ATTR_RO(revision);
> +static DEVICE_ATTR_RO(device_id);
> +static DEVICE_ATTR_RO(bmc_mac);
> +static DEVICE_ATTR_RO(status_2);
> +
> +static DEVICE_ATTR_RW(uart_mux);
> +static DEVICE_ATTR_RW(switch_flash);
> +static DEVICE_ATTR_RW(switch_reset);
> +static DEVICE_ATTR_RW(bmc_flash);
> +static DEVICE_ATTR_RW(payload_power);
> +
> +static struct attribute *cronos_cpld_sysfs_entries[] = {
> +	&dev_attr_revision.attr,      &dev_attr_device_id.attr,
> +	&dev_attr_bmc_mac.attr,	      &dev_attr_status_2.attr,
> +	&dev_attr_uart_mux.attr,      &dev_attr_switch_flash.attr,
> +	&dev_attr_switch_reset.attr,  &dev_attr_bmc_flash.attr,
> +	&dev_attr_payload_power.attr, NULL,
> +};
> +
> +static const struct attribute_group cronos_cpld_attr_group = {
> +	.attrs = cronos_cpld_sysfs_entries,
> +};

All of this can be dealt with from your userspace app.

> +static int sony_cronos_get_device_type(struct sony_cronos_cpld *ddata)
> +{
> +	int device_id;
> +	int byte_high;
> +	int byte_low;
> +	int ret;
> +
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_DEVICE_ID_HIGH_REG,
> +			  &byte_high);
> +	if (ret) {
> +		dev_err(ddata->dev, "Cannot read ddata ID high byte.\n");
> +		return -EIO;
> +	}
> +	ret = regmap_read(ddata->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG,
> +			  &byte_low);
> +	if (ret) {
> +		dev_err(ddata->dev, "Cannot read ddata ID low byte.\n");
> +		return -EIO;
> +	}
> +
> +	device_id = byte_high << 8;
> +	device_id |= byte_low;
> +
> +	if (device_id != CRONOS_CPLD_DEVICE_ID) {
> +		dev_err(ddata->dev, "Unsupported device ID 0x%04x\n",
> +			device_id);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(ddata->dev, "Device detected (device ID 0x%04X)\n", device_id);

No one is going to read or care about this after development.

You can remove it.

> +	return ret;
> +}
> +
> +static bool cronos_cpld_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
> +	case CRONOS_LEDS_SMC_STATUS_REG:
> +	case CRONOS_LEDS_SWITCH_STATUS_REG:
> +	case CRONOS_LEDS_CCM1_STATUS_REG:
> +	case CRONOS_LEDS_CCM2_STATUS_REG:
> +	case CRONOS_LEDS_CCM3_STATUS_REG:
> +	case CRONOS_LEDS_CCM4_STATUS_REG:
> +	case CRONOS_LEDS_CCM_POWER_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +
> +	case CRONOS_CPLD_UART_MUX_REG:
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool cronos_cpld_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_REVISION_HIGH_REG:
> +	case CRONOS_CPLD_REVISION_LOW_REG:
> +	case CRONOS_CPLD_DEVICE_ID_HIGH_REG:
> +	case CRONOS_CPLD_DEVICE_ID_LOW_REG:
> +
> +	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
> +	case CRONOS_LEDS_SMC_STATUS_REG:
> +	case CRONOS_LEDS_SWITCH_STATUS_REG:
> +	case CRONOS_LEDS_CCM1_STATUS_REG:
> +	case CRONOS_LEDS_CCM2_STATUS_REG:
> +	case CRONOS_LEDS_CCM3_STATUS_REG:
> +	case CRONOS_LEDS_CCM4_STATUS_REG:
> +	case CRONOS_LEDS_CCM_POWER_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +
> +	case CRONOS_CPLD_STATUS_2_REG:
> +	case CRONOS_CPLD_UART_MUX_REG:
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +
> +	case CRONOS_CPLD_BMC_MAC_LOW_REG ... CRONOS_CPLD_BMC_MAC_HIGH_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool cronos_cpld_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_REVISION_HIGH_REG:
> +	case CRONOS_CPLD_REVISION_LOW_REG:
> +
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static struct regmap_config cronos_cpld_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = CRONOS_CPLD_REVISION_HIGH_REG,
> +	.writeable_reg = cronos_cpld_is_writeable_reg,
> +	.readable_reg = cronos_cpld_is_readable_reg,
> +	.volatile_reg = cronos_cpld_is_volatile_reg,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +#ifdef CONFIG_OF

How else can the driver be instantiated?

If only via Device Tree, then make the whole driver depend on it.

> +static const struct of_device_id cronos_cpld_dt_ids[] = {
> +	{
> +		.compatible = "sony,cronos-cpld",
> +	},

This one-line entry should be on a single line.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cronos_cpld_dt_ids);
> +#endif
> +
> +static int sony_cronos_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct sony_cronos_cpld *ddata;

I don't see why you have 'cpld' all over the place.

We don't usually use 'soc' or 'asic' in the same way.

> +	int ret;
> +
> +	ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, ddata);
> +	ddata->dev = &i2c->dev;

Why are you storing this?
> +
> +	ddata->regmap = devm_regmap_init_i2c(i2c, &cronos_cpld_regmap_config);
> +	if (IS_ERR(ddata->regmap)) {
> +		dev_err_probe(ddata->dev, PTR_ERR(ddata->regmap),
> +			      "Failed to allocate register map\n");
> +		return ret;

I think you mean:

	return dev_err_probe(...);

> +	}
> +
> +	ret = sony_cronos_get_device_type(ddata);
> +	if (ret)
> +		return ret;
> +
> +	ret = mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, cronos_cpld_devs,
> +			      ARRAY_SIZE(cronos_cpld_devs), NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(ddata->dev, "Cannot register child devices\n");

"Failed to ..." is better.

> +		return ret;
> +	}
> +
> +	ret = sysfs_create_group(&ddata->dev->kobj, &cronos_cpld_attr_group);
> +	if (ret)
> +		dev_err(ddata->dev, "Error creating sysfs entries\n");
> +
> +	return ret;
> +}
> +
> +static void sony_cronos_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct sony_cronos_cpld *ddata = i2c_get_clientdata(i2c);
> +
> +	sysfs_remove_group(&ddata->dev->kobj, &cronos_cpld_attr_group);
> +	mfd_remove_devices(ddata->dev);

devm_*

> +}
> +
> +static struct i2c_driver sony_cronos_i2c_driver = {

Why i2c_driver (this is not a trick question)?

> +	.driver = {
> +		.name = "sony-cronos-cpld",
> +		.of_match_table = of_match_ptr(cronos_cpld_dt_ids),
> +	},
> +	.probe    = sony_cronos_i2c_probe,
> +	.remove   = sony_cronos_i2c_remove,

No need to tab these out.
> +};
> +

Remove this line.

> +module_i2c_driver(sony_cronos_i2c_driver);
> +
> +MODULE_DESCRIPTION("Multi-function device driver for Sony Cronos CPLDs");
> +MODULE_AUTHOR("Raptor Engineering, LLC <tpearson@raptorengineering.com>");
> +MODULE_LICENSE("GPL");
> \ No newline at end of file
> diff --git a/include/linux/mfd/sony/cronos/core.h b/include/linux/mfd/sony/cronos/core.h

Call it sony-cronos.h and omit the need for all of these empty sub-directories.

> new file mode 100644
> index 000000000000..6f80b90af5ca
> --- /dev/null
> +++ b/include/linux/mfd/sony/cronos/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022  Raptor Engineering, LLC
> + */
> +
> +#ifndef __MFD_SONY_CRONOS_CORE_H__
> +#define __MFD_SONY_CRONOS_CORE_H__
> +
> +#include <linux/mfd/sony/cronos/registers.h>
> +
> +struct sony_cronos_cpld {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +#endif /* __MFD_SONY_CRONOS_H__ */
> diff --git a/include/linux/mfd/sony/cronos/registers.h b/include/linux/mfd/sony/cronos/registers.h

This can go in core.h, right?

> new file mode 100644
> index 000000000000..60ec04bd3903
> --- /dev/null
> +++ b/include/linux/mfd/sony/cronos/registers.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022  Raptor Engineering, LLC
> + */
> +
> +#ifndef __SONY_CRONOS_H__
> +#define __SONY_CRONOS_H__
> +
> +#define CRONOS_CPLD_DEVICE_ID		0x0134
> +
> +/*
> + * Registers and control masks / values
> + */

This comment is superfluous.

> +#define CRONOS_CPLD_REVISION_HIGH_REG			0x73
> +#define CRONOS_CPLD_REVISION_LOW_REG			0x72
> +#define CRONOS_CPLD_DEVICE_ID_HIGH_REG			0x71
> +#define CRONOS_CPLD_DEVICE_ID_LOW_REG			0x70
> +
> +#define CRONOS_CPLD_BRIGHTNESS_RED_REG			0x17
> +#define CRONOS_CPLD_BRIGHTNESS_GREEN_REG		0x18
> +#define CRONOS_CPLD_BRIGHTNESS_BLUE_REG			0x19
> +
> +#define CRONOS_CPLD_LEDS_BRIGHTNESS_SET_MASK		0x7F
> +#define CRONOS_LEDS_MAX_BRIGHTNESS			0x7F
> +
> +#define CRONOS_LEDS_SMC_STATUS_REG			0x10
> +#define CRONOS_LEDS_SWITCH_STATUS_REG			0x11
> +
> +#define CRONOS_LEDS_CCM1_STATUS_REG			0x15
> +#define CRONOS_LEDS_CCM2_STATUS_REG			0x13
> +#define CRONOS_LEDS_CCM3_STATUS_REG			0x12
> +#define CRONOS_LEDS_CCM4_STATUS_REG			0x14

Why not put them all in order of the reg map?

> +#define CRONOS_LEDS_CCM_POWER_REG			0x16
> +
> +#define CRONOS_CPLD_UART_MUX_REG			0x0e
> +#define CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG	0x00
> +#define CRONOS_CPLD_SWITCH_RESET_CMD_REG		0x01
> +#define CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG		0x02
> +#define CRONOS_CPLD_PAYLOAD_POWER_CTL_REG		0x0a
> +#define CRONOS_CPLD_BMC_MAC_LOW_REG			0x30
> +#define CRONOS_CPLD_BMC_MAC_HIGH_REG			0x35
> +
> +#define CRONOS_WDT_CLR_REG		0x03
> +#define CRONOS_WDT_CTL_REG		0x0c
> +
> +#define CRONOS_CPLD_STATUS_2_REG	0x05
> +
> +#define CRONOS_BMC_RESET_REG		0x03
> +#define CRONOS_BMC_RESET_VAL		0xc2
> +
> +#define CRONOS_WDT_CLR_VAL		0xc3
> +#define CRONOS_WDT_ENABLE_MASK		0x80
> +#define CRONOS_WDT_ENABLE_VAL		0x80
> +#define CRONOS_WDT_DISABLE_VAL		0x00
> +#define CRONOS_WDT_TIMEOUT_MASK		0x07
> +#define CRONOS_WDT_CTL_RESET_VAL	0x00
> +
> +

2 line spacing?

> +#endif /* __SONY_CRONOS_H__ */
> -- 
> 2.39.5

-- 
Lee Jones [李琼斯]

