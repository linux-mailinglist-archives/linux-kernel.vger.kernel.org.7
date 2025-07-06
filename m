Return-Path: <linux-kernel+bounces-717521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779AAF952F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D6B1CC0BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265A19AD5C;
	Fri,  4 Jul 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WspZ3CFv"
Received: from smtp.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E019005E;
	Fri,  4 Jul 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638454; cv=none; b=tGZO6I2UHc/pcehq0BXWEuGxdGWSIf+MBZXkZWuUAzLprIUXj5Cn4UVzImwhS4v7ReQFhowJ463xXWWVgFFUXMqDoSbYhiRWT8viHxwxtOJPcWXYpxhRANg9jesQJSXuyI7cFrzRMd9PgMnkCRGxleHsXRFGNVWe26dXXEPSydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638454; c=relaxed/simple;
	bh=+u2GpgGOhEl75nJxq3dmrduoPbHAFjg00Tgzqi123wM=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=CxGS+XZbofAp4wTn5g6n4iuJxJAiwXp2vm+hu/I6r3XeG4sY/S82ambTj2LDs+arQqu5gPGuVZbtuLcba2rJCLCFYupd5s4V7cMd302EYOaPf4ULWuSVZ0VrUrkVc6FvDTcWx3V5pnB4Dae1LHLUyC7JIaNaXqkk3igNn/KMwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WspZ3CFv; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Xh9tu0aMm2WitXh9tu0wY2; Fri, 04 Jul 2025 16:12:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751638379;
	bh=X6qAouzWloI4EGNQY3Oegqlye+V7PfXpkR1f2hKTYXQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=WspZ3CFvM4C4xfg8r2lyEW+vkMIlfXef7JRzzLTzxyPeTyxCXUEyO2y5ISqtvLXZf
	 g7tKwCwZ49XEXRbj5T3xHbAQJSr+l/FjqZ2cCUjCB4nlAuGzTQXh9ApbpKKqhO/SlM
	 Sckqq+cmp153hFSyuk66uikpiaGpLeXmDF6qaODJAkTbvtZ9Tz0IY21LcWEvi8eEZM
	 taVFO/QQ15+Yk8SG6ywQaPpI15bBW2vEA10UyeDOl0q8ZsVWVL0ui6SwDMcOQxIWRE
	 ctWgtdX/cGGsNL2OXnnLT+lkTxim11xgpVCBW79Fiz6TjdWAS8jC93Mr0Cw7g1DLMn
	 FNGAJI/k32FQQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 04 Jul 2025 16:12:59 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <f14dfb9a-caf7-4889-a892-6fd61a9a5ecd@wanadoo.fr>
Date: Fri, 4 Jul 2025 16:12:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] eeprom: add driver for ST M24LR series RFID/NFC
 EEPROM chips
References: <20250704123914.11216-1-abd.masalkhi@gmail.com>
 <20250704123914.11216-3-abd.masalkhi@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: abd.masalkhi@gmail.com
Cc: arnd@arndb.de, conor+dt@kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, luoyifan@cmss.chinamobile.com, robh@kernel.org
In-Reply-To: <20250704123914.11216-3-abd.masalkhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/07/2025 à 14:39, Abd-Alrhman Masalkhi a écrit :
> adds support for STMicroelectronics M24LRxx devices, which expose
> two separate I2C addresses: one for system control and one for EEPROM
> access. The driver implements both a sysfs-based interface for control
> registers (e.g. UID, password authentication) and an nvmem provider
> for EEPROM access.

Hi, some nitpicks below, mostly related to types.

...

> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/nvmem-provider.h>

Sometimes, alphabetical order is preferred.

> +
> +#define M24LR_WRITE_TIMEOUT	  25u
> +#define M24LR_READ_TIMEOUT	  (M24LR_WRITE_TIMEOUT)

...

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

Why returning a ssize_t?
regmap_bulk_read() returns an int.

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
...

> +static ssize_t m24lr_read(struct m24lr *m24lr, u8 *buf, size_t size,
> +			  unsigned int offset, bool is_eeprom)
> +{
> +	struct regmap *regmap;
> +	long ret;

Why long?
m24lr_regmap_read() returns a ssize_t. (+ see comment there for why a 
ssize_t)

(same comment applies to several places)

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
> +	long err;
> +
> +	if (is_eeprom)
> +		regmap = m24lr->eeprom_regmap;
> +	else
> +		regmap = m24lr->ctl_regmap;
> +
> +	n = min(size, m24lr->page_size);

min_t()?

> +	next_sector = roundup(offset + 1, m24lr->page_size);
> +	if (offset + n > next_sector)
> +		n = next_sector - offset;
> +
> +	mutex_lock(&m24lr->lock);
> +	while (n) {
> +		err = m24lr_regmap_write(regmap, buf, n, offset);
> +		if (IS_ERR_VALUE(err)) {
> +			mutex_unlock(&m24lr->lock);
> +			if (ret)
> +				return ret;
> +			else

Unneeded else.

> +				return err;
> +		}
> +
> +		offset += n;
> +		size -= n;
> +		ret += n;
> +		n = min(size, m24lr->page_size);

min_t()?
Or change the type of page_size?

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
> +	long ret;

long vs ssize_t vs int.

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
> +	long ret;

same

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
> +	struct m24lr *m24lr = priv;
> +
> +	if (!bytes)
> +		return bytes;
> +
> +	if (offset + bytes > m24lr->eeprom_size)
> +		return -EINVAL;
> +
> +	return m24lr_read(m24lr, val, bytes, offset, true);

We return an int now?

> +}

...

> +static ssize_t m24lr_ctl_sss_read(struct file *filep, struct kobject *kobj,
> +				  const struct bin_attribute *attr, char *buf,
> +				  loff_t offset, size_t count)
> +{
> +	struct m24lr *m24lr = attr->private;
> +
> +	if (!count)
> +		return count;
> +
> +	if (offset + count > m24lr->sss_len)

Does using size_add() would make sense?

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
> +	if (offset + count > m24lr->sss_len)

Same

> +		return -EINVAL;
> +
> +	return m24lr_write(m24lr, buf, count, offset, false);
> +}
> +static BIN_ATTR(sss, 0600, m24lr_ctl_sss_read, m24lr_ctl_sss_write, 0);

...

> +static struct attribute *m24lr_ctl_dev_attrs[] = {
> +	&dev_attr_unlock.attr,
> +	&dev_attr_new_pass.attr,
> +	&dev_attr_uid.attr,
> +	&dev_attr_total_sectors.attr,
> +	NULL,

Unneeded trailing ,

> +};

...

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
> +	if (err) {
> +		dev_err(dev, "device_property_read_u32_array\n");

return dev_err_probe() maybe?

> +		return err;
> +	}
> +	/* Create a second I2C client for the eeprom interface */
> +	eeprom_client = devm_i2c_new_dummy_device(dev, client->adapter, regs[1]);
> +	if (IS_ERR(eeprom_client)) {
> +		dev_err(dev,
> +			"Failed to create dummy I2C client for the EEPROM\n");

return dev_err_probe() maybe?
...

> +		return PTR_ERR(eeprom_client);
> +	}
> +
> +	ctl_regmap = devm_regmap_init_i2c(client, &m24lr_ctl_regmap_conf);
> +	if (IS_ERR(ctl_regmap)) {
> +		err = PTR_ERR(ctl_regmap);
> +		dev_err(dev, "Failed to init regmap\n");
> +		return err;
> +	}
> +
> +	eeprom_regmap_conf.name = "m24lr_eeprom";
> +	eeprom_regmap_conf.reg_bits = 16;
> +	eeprom_regmap_conf.val_bits = 8;
> +	eeprom_regmap_conf.disable_locking = true;
> +	eeprom_regmap_conf.max_register = chip->eeprom_size - 1;
> +
> +	eeprom_regmap = devm_regmap_init_i2c(eeprom_client,
> +					     &eeprom_regmap_conf);
> +	if (IS_ERR(eeprom_regmap)) {
> +		err = PTR_ERR(eeprom_regmap);
> +		dev_err(dev, "Failed to init regmap\n");
> +		return err;
> +	}
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
> +		return PTR_ERR(nvmem);
> +
> +	i2c_set_clientdata(client, m24lr);
> +	i2c_set_clientdata(eeprom_client, m24lr);
> +
> +	bin_attr_sss.size = chip->sss_len;
> +	bin_attr_sss.private = m24lr;
> +	err = sysfs_create_bin_file(&dev->kobj, &bin_attr_sss);
> +	if (err)
> +		return err;
> +
> +	/* test by reading the uid, if success store it */
> +	err = m24lr_read_reg_le(m24lr, &m24lr->uid, 2324, sizeof(m24lr->uid));
> +	if (IS_ERR_VALUE(err))

Missing sysfs_remove_bin_file() or error handling pah?

> +		return -ENODEV;
> +
> +	return 0;
> +}

...

CJ


