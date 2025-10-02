Return-Path: <linux-kernel+bounces-840721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA07BB5134
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C64E54BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52928C2CE;
	Thu,  2 Oct 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdrZUm8/"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CA2BD036
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435381; cv=none; b=XuLv7v+EYZuPL4JHiHirBqUU9NhrPtCssGaIMTs66DWPcceQ2IIhRS0KvC3BeqcTAw53I7f/16JvsEI7L/hAtwigeDJS4kB9XAmm2ZHSYrjIkE7zdniKJu0dxukkJRhZQPyO6v2cY12A6IzlUtqfFIrhAluJC28xKk7DQfNzfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435381; c=relaxed/simple;
	bh=6FPUEALquhk+vxSbziWXS7XB72pS9nEdo3V5a45iILU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOaYV+HuSMurW4ywSDNaWd0ISy2Jzd/25G1Uor7X2Yh/sNfRHuwb7Tr6VphdPpkZRw588jysggGkz+ig0//0Z37IQJF1HxxTJ0jN1fSRYL8Yufue5Oq27CjTI4mWbN0HKWWLPKJJXIMcVn8F44vApi4SPn2SjoK49OrpgHtahYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdrZUm8/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3da3b34950so251114166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435378; x=1760040178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcMlC5LUde4mDf43AKd1K4g7ws7NF5+Rvc2t/AmCk+8=;
        b=AdrZUm8/9fqD2sX1bir3XHxdmupqxILUL7frR3K6m/DVrAGPNjLthXqGimSjCWJ3HJ
         xHb3pgRpG+i+RRb3DbGu24k9G/I7HMRvaXe7J5S0+BheYjXlapSIKBC4ZLnnPql/PIoy
         9h12oO2W3XDDlFRQLV0otyoakkLrlbTXBp4RCy4gjeM21eCCdPEyLa7iepdcgQOMjdQD
         MOZ2nVL8BXTyWOosBNtbJeVQjpFuLAmGJR7Twug1wHy390s+8+XGm7Pwni+Jyox0khfK
         RQ2Fgr6Yr9bfLQ7S4k0ROwvpPryLh0upCsUTZcF6psE+chVc5CtPHq0YvT+LaUNK/8jB
         VzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435378; x=1760040178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcMlC5LUde4mDf43AKd1K4g7ws7NF5+Rvc2t/AmCk+8=;
        b=s3WhjiO9uZR3vZ/e8zbotD36Z8QLQ+YTYtxcS19WRelFNlvv880mmTzKKj17zRFud2
         QKYi+HlpttFbnb9G4A5qYbfFB9EHZZhrkkZ+8deixZdAGHYLOf+5gcGazI+MxlheV0wq
         t9+devaLh+Xn9DxJEzBl+m1wYqApdVc2PWL6oOBmcJ9Rjp9ushLX7ub5KZh6GFd0+y0e
         mFcpblFRtQBNlUt/N8MhJb7L4fjSl6MFVparYUadKmrqDZ1BjbcbSQVnf4jelRfNAmZU
         /KcDvEmykmml+J5fEDm6QwuJtrcs72+b8ZG44emC0NY2/VzceUN6Y21HfBcNRxgOJ2j2
         omnA==
X-Gm-Message-State: AOJu0YwWBRURbKKtvCIHWP4yg2Z2MUtoFBQ31mEK0wdzh+8eJefPy9hp
	DV5aIvh28D+tj4yyr+I8DHS+wtooO8CPhJKka+tItTizlT9aoB7w3kIL
X-Gm-Gg: ASbGnct7Pyb5tj6QL067X7UdzNYhrswg/QNRULFDHxukINtTeoVLz53N4wFovycqCDT
	00LnN+HspVb7RVaUxyibZAi/KMzFwwPeYxa6X86lvYooF3pLTkXxCBIqONOPgKarR0Wt6a4UZCD
	GZFN2JSxFrmi3PFZDf+k9DcI1G8NRHgqlEA61+6+LWn4Cfv81Iaebr/rCNuVtkx4KKiakefHEM9
	QNZh2TLg+SiiIeUUWQeJfy+mtg9lg+1vNEefcW36SdqhvOrwiELQARIfchq+1mzgytBqjBe5wEO
	/MQxEsctd6QEXwhrNuvFKOTiWf7jIfEVhfln/Ev55iOqViD5LFf9a2lFhY5zNIyZW/Frw2jnAu6
	2AIjf5jTvmirtqbudQnhXanubbZO9DhSQYforPksANtfG
X-Google-Smtp-Source: AGHT+IHg9gM8XCrDWo7eM+upb/VtHZKVPWNJsXPFkFgCw0z7uYndYI6jplCbzBzQzMx0xQZMDxHaZg==
X-Received: by 2002:a17:907:868f:b0:b45:33bb:24f3 with SMTP id a640c23a62f3a-b49c2c5dd45mr82884666b.44.1759435377619;
        Thu, 02 Oct 2025 13:02:57 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:57 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 4/5] iio: mpl3115: add support for DRDY interrupt
Date: Thu,  2 Oct 2025 22:02:05 +0200
Message-Id: <20251002200206.59824-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 sensor features a "data ready" interrupt which indicates the
presence of new measurements.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 183 +++++++++++++++++++++++++++++++--
 1 file changed, 175 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 61830edd959b..e1b2c9f2bb43 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -7,40 +7,66 @@
  * (7-bit I2C slave address 0x60)
  *
  * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode,
- * interrupts, user offset correction, raw mode
+ * user offset correction, raw mode
  */
 
-#include <linux/module.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/delay.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 
 #define MPL3115_STATUS 0x00
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
 #define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
 #define MPL3115_WHO_AM_I 0x0c
+#define MPL3115_INT_SOURCE 0x12
+#define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG3 0x28
+#define MPL3115_CTRL_REG4 0x29
+#define MPL3115_CTRL_REG5 0x2a
 
 #define MPL3115_DEVICE_ID 0xc4
 
 #define MPL3115_STATUS_PRESS_RDY BIT(2)
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
+#define MPL3115_INT_SRC_DRDY BIT(7)
+
+#define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
+
 #define MPL3115_CTRL1_RESET BIT(2) /* software reset */
 #define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
 #define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
 #define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
+#define MPL3115_CTRL3_IPOL1 BIT(5)
+#define MPL3115_CTRL3_IPOL2 BIT(1)
+
+#define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+
+#define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
+
 struct mpl3115_data {
 	struct i2c_client *client;
+	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
 };
 
+enum mpl3115_irq_pin {
+	MPL3115_IRQ_INT1,
+	MPL3115_IRQ_INT2,
+};
+
 static int mpl3115_request(struct mpl3115_data *data)
 {
 	int ret, tries = 15;
@@ -153,9 +179,11 @@ static int mpl3115_fill_trig_buffer(struct iio_dev *indio_dev, u8 *buffer)
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	int ret, pos = 0;
 
-	ret = mpl3115_request(data);
-	if (ret < 0)
-		return ret;
+	if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
+		ret = mpl3115_request(data);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		ret = i2c_smbus_read_i2c_block_data(data->client,
@@ -234,10 +262,145 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MPL3115_INT_SRC_DRDY))
+		return IRQ_NONE;
+
+	iio_trigger_poll_nested(data->drdy_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int mpl3115_config_interrupt(struct mpl3115_data *data,
+				    u8 ctrl_reg1, u8 ctrl_reg4)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
+					ctrl_reg4);
+	if (ret < 0)
+		goto reg1_cleanup;
+
+	data->ctrl_reg1 = ctrl_reg1;
+
+	return 0;
+
+reg1_cleanup:
+	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+				  data->ctrl_reg1);
+	return ret;
+}
+
+static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 ctrl_reg1 = data->ctrl_reg1;
+	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
+
+	if (state)
+		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
+	else
+		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+
+	guard(mutex)(&data->lock);
+
+	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
+}
+
+static const struct iio_trigger_ops mpl3115_trigger_ops = {
+	.set_trigger_state = mpl3115_set_trigger_state,
+};
+
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
 };
 
+static int mpl3115_trigger_probe(struct mpl3115_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
+	int ret, irq, irq_type, irq_pin = MPL3115_IRQ_INT1;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0) {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq < 0)
+			return 0;
+
+		irq_pin = MPL3115_IRQ_INT2;
+	}
+
+	irq_type = irq_get_trigger_type(irq);
+	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
+					MPL3115_PT_DATA_EVENT_ALL);
+	if (ret < 0)
+		return ret;
+
+	if (irq_pin == MPL3115_IRQ_INT1) {
+		ret = i2c_smbus_write_byte_data(data->client,
+						MPL3115_CTRL_REG5,
+						MPL3115_CTRL5_INT_CFG_DRDY);
+		if (ret)
+			return ret;
+
+		if (irq_type == IRQF_TRIGGER_RISING) {
+			ret = i2c_smbus_write_byte_data(data->client,
+							MPL3115_CTRL_REG3,
+							MPL3115_CTRL3_IPOL1);
+			if (ret)
+				return ret;
+		}
+	} else if (irq_type == IRQF_TRIGGER_RISING) {
+		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
+						MPL3115_CTRL3_IPOL2);
+		if (ret)
+			return ret;
+	}
+
+	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
+						 "%s-dev%d",
+						 indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!data->drdy_trig)
+		return -ENOMEM;
+
+	data->drdy_trig->ops = &mpl3115_trigger_ops;
+	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+
+	ret = devm_request_threaded_irq(&data->client->dev, irq, NULL,
+					mpl3115_interrupt_handler,
+					IRQF_ONESHOT,
+					"mpl3115_irq", indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_trigger_register(&data->client->dev, data->drdy_trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
+	return 0;
+}
+
 static int mpl3115_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -277,6 +440,10 @@ static int mpl3115_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = mpl3115_trigger_probe(data, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mpl3115_trigger_handler, NULL);
 	if (ret < 0)
-- 
2.25.1


