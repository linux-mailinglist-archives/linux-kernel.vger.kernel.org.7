Return-Path: <linux-kernel+bounces-880925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFBC26E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DA704EC0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806618BC3D;
	Fri, 31 Oct 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM5s2fhu"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3D218AAF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941958; cv=none; b=et/mm/eES4WAj3z9AJyG4Ee+FgC3SQ8vHcwnlsF0uO9praqfNsqryctyXHc9t3+ohz7snuJ35qW1JBERjcWeVLfHF6zfXFDQMP0eP6uhsoDR884v3wrq/NOBkZ33ZmTaPZ0DmFOIKJMS3ct5jtjEOdhKLMv1mE+wn+jcdR30yCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941958; c=relaxed/simple;
	bh=OZnlu/P99xD39yEM/jQRo9EzFw+5pTj6Xfv5obqJg6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdFwI63Cph/lXQWNv2urrMeQyjwbtKgIJkSHquIJdEt982pbZrC30+kqo5XIpirDYZ/O7XUYQY63p00fbGFo9EJKH133rO+2h2rS7DipvGdgXAuzxAYppU/ZmFlYEWZiwoUXVWEEgS+oZhYu/R8mtGN+3WU3gqeqVH6R4Wtk4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM5s2fhu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4270491e9easo2284989f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941955; x=1762546755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLw1XhVo8Zz7HuWEutrVtWa4JpGlKfK4BOy5Ht7RQiI=;
        b=QM5s2fhugYTsnep0gmIb6RyQyQO8hh6uAW9wRRrbs/YrH4O6FPANIZOTHKhMXiXhI7
         KDhsOgEK+S2BIlQhGnN1Odc2s2pk4sLYeEKCn8jR30y+oLxBQvx73tqEJlIaETz+9IRt
         tPO7Qsj1bY3c6OMJ8ppfsnhwoTuUiR6AK+tjHTPi2J8akYljMXbd1vbihxlj9iOl7//v
         KwA3aA634vrjE9NcGsHG4YMOrX8hJ9OhryfELMoNQBJGeJ6utkc5beXghS64KjQ+1oj7
         B8ycDTzAiiQ1dZGPsfNrkckHZOyot2wV+k1cGBPi7t6ID9kqxrScpz+Xb/cEYA93Vr6o
         FfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941955; x=1762546755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLw1XhVo8Zz7HuWEutrVtWa4JpGlKfK4BOy5Ht7RQiI=;
        b=dr4X9gMz9sljnPLcA644ZAgWoMhCP5pRQWUh6gLT1hPGYxpxL8AA4TtMkOP+w4MUXu
         ASdMXE8TOvBIXwOveJ3D18PRm8LVlOsXVDNt3vgT16IVodyzuWdI+pW5zkfi00TqSB9Q
         GOaUbD4JuXCrMGyS+4jGowBlieGuwniRx1wt1E3w7X/D+gTuObINkTZvDtsiLn32msc9
         p0+4NTlmiyE+LyUfEMJyKTVYlr6b5rJVG3hBYB8GGvsObD8zI/LiafeVc1sM9KiKjLMX
         ADg4FZkkpDN3SXvbe3HzbaApHy97rtt/5YN4jbs+L8r92dx+eWrCl8Bp5b6/K1n6gZuE
         EhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX97+CG/x544TRcwIQqQldQclYPauqx0wI8PzZcORBGsVXPqqLtTMSpgXB6uigkzEsiB7utnMURty68oMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52rNnkcHniPbvEht96rEP4ODKO44Eoy7X0hHMANSt4Qytn+2m
	k5RywIxHUsggKCvbDjAaD10be+yvkuXzyPoYWuMQTRgU7bVbicUOgWfq
X-Gm-Gg: ASbGncsdLn8xM8aJ7kiZJqaEB21NxZLsDO+t+jBeLuYyoQjScI+rm7Tf1/6MuNxrRwy
	ikxPGKC4ALAyqQwMA/1UR+1JrQbGqeaXnocc7FmP+CBBvUsijuppdb9zwZKyelK5LvRnHZCZNLJ
	n7w3cIme4PLyyGdjvL77OROOtKPGY6luauTHKE55R36SNPNbyIVq6wOrIdORPdyKqjxYwHJ1O72
	DKgZ8eWXfOBvnGRFCx95aXgoVxVNtyzfL79igH0+0//+EC9zPmpgoSzyPoW+GdRZyw8Jobyyul1
	UZMnxG+6WlkUPWFaqAe0feMq55c+ibd0vuaF7+ZFyOyY+nbe8xat9jzkESXIDsLOaiD9tm3s1TV
	6IHhkIJjYaYtlrJFqfvAcpBSeJBL3WOvHZX9GxIUHlMRd2ecemG0dLvYJ9FlJGRr89/GyhbQtmv
	VV3+7uzN+eKQn1jEk=
X-Google-Smtp-Source: AGHT+IGGvXRnvMpYHfAemzINJevBEcBKmkv9lJaQU/L/ZBn+pwhaExUSqk59TmzFv9/u3WrPlu0tAQ==
X-Received: by 2002:a05:6000:25fb:b0:429:c0f1:fd38 with SMTP id ffacd0b85a97d-429c0f1fde2mr3628468f8f.59.1761941954656;
        Fri, 31 Oct 2025 13:19:14 -0700 (PDT)
Received: from localhost.localdomain ([78.212.20.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm1800360f8f.8.2025.10.31.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:19:14 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 1/2] iio: mpl3115: add threshold events support
Date: Fri, 31 Oct 2025 21:18:22 +0100
Message-Id: <20251031201821.88374-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031201821.88374-1-apokusinski01@gmail.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for pressure and temperature rising threshold events. For
both channels *_en and *_value (in raw units) attributes are exposed.

Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
and write_event_config() needs to be now guarded by data->lock.
Otherwise, it would be possible that 2 concurrent threads executing
these functions would access the data->ctrl_reg{1,4} at the same time
and then one would overwrite the other's result.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 219 +++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..472e9fd65776 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -14,10 +14,13 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
@@ -30,6 +33,8 @@
 #define MPL3115_WHO_AM_I 0x0c
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
+#define MPL3115_PRESS_TGT 0x16 /* MSB first, 16 bit */
+#define MPL3115_TEMP_TGT 0x18
 #define MPL3115_CTRL_REG1 0x26
 #define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
@@ -42,6 +47,8 @@
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
 #define MPL3115_INT_SRC_DRDY BIT(7)
+#define MPL3115_INT_SRC_PTH BIT(3)
+#define MPL3115_INT_SRC_TTH BIT(2)
 
 #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
 
@@ -56,6 +63,8 @@
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
 #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+#define MPL3115_CTRL4_INT_EN_PTH BIT(3)
+#define MPL3115_CTRL4_INT_EN_TTH BIT(2)
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
 
@@ -83,6 +92,7 @@ struct mpl3115_data {
 	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
+	u8 ctrl_reg4;
 };
 
 enum mpl3115_irq_pin {
@@ -306,6 +316,15 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_event_spec mpl3115_temp_press_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -321,7 +340,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 			.storagebits = 32,
 			.shift = 12,
 			.endianness = IIO_BE,
-		}
+		},
+		.event_spec = mpl3115_temp_press_event,
+		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
 	},
 	{
 		.type = IIO_TEMP,
@@ -337,7 +358,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 			.storagebits = 16,
 			.shift = 4,
 			.endianness = IIO_BE,
-		}
+		},
+		.event_spec = mpl3115_temp_press_event,
+		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
@@ -347,15 +370,45 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	int ret;
+	__be32 val_press;
+	__be16 val_temp;
 
 	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
-	if (!(ret & MPL3115_INT_SRC_DRDY))
+	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
+		     MPL3115_INT_SRC_DRDY)))
 		return IRQ_NONE;
 
-	iio_trigger_poll_nested(data->drdy_trig);
+	if (ret & MPL3115_INT_SRC_DRDY)
+		iio_trigger_poll_nested(data->drdy_trig);
+
+	if (ret & MPL3115_INT_SRC_PTH) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PRESSURE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+						    iio_get_time_ns(indio_dev));
+
+		/* Reset the SRC_PTH bit in INT_SOURCE */
+		i2c_smbus_read_i2c_block_data(data->client,
+					      MPL3115_OUT_PRESS,
+					      3, (u8 *)&val_press);
+	}
+
+	if (ret & MPL3115_INT_SRC_TTH) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+						    iio_get_time_ns(indio_dev));
+
+		/* Reset the SRC_TTH bit in INT_SOURCE */
+		i2c_smbus_read_i2c_block_data(data->client,
+					      MPL3115_OUT_TEMP,
+					      2, (u8 *)&val_temp);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -376,6 +429,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 		goto reg1_cleanup;
 
 	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
 
 	return 0;
 
@@ -389,15 +443,22 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	u8 ctrl_reg1 = data->ctrl_reg1;
-	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
+	u8 ctrl_reg1, ctrl_reg4;
 
-	if (state)
+	guard(mutex)(&data->lock);
+
+	ctrl_reg1 = data->ctrl_reg1;
+	ctrl_reg4 = data->ctrl_reg4;
+
+	if (state) {
 		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
-	else
-		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
+	} else {
+		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
 
-	guard(mutex)(&data->lock);
+		if (!ctrl_reg4)
+			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+	}
 
 	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
 }
@@ -406,10 +467,148 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 	.set_trigger_state = mpl3115_set_trigger_state,
 };
 
+static int mpl3115_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+
+	if (chan->type == IIO_PRESSURE)
+		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_PTH);
+
+	if (chan->type == IIO_TEMP)
+		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_TTH);
+
+	return -EINVAL;
+}
+
+static int mpl3115_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 int_en_mask;
+	u8 ctrl_reg1, ctrl_reg4;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
+		break;
+	case IIO_TEMP:
+		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&data->lock);
+
+	ctrl_reg1 = data->ctrl_reg1;
+	ctrl_reg4 = data->ctrl_reg4;
+
+	if (state) {
+		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 |= int_en_mask;
+	} else {
+		ctrl_reg4 &= ~int_en_mask;
+
+		if (!ctrl_reg4)
+			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+	}
+
+	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
+}
+
+static int mpl3115_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+	__be16 tmp;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_PRESS_TGT,
+						    sizeof(tmp), (u8 *)&tmp);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Target value for the pressure is
+		 * 16-bit unsigned value in 2 Pa units
+		 */
+		*val = be16_to_cpu(tmp) << 1;
+
+		return IIO_VAL_INT;
+	case IIO_TEMP:
+		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
+		if (ret < 0)
+			return ret;
+
+		/* Target value for the temperature is 8-bit 2's complement */
+		*val = sign_extend32(ret, 7);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mpl3115_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	__be16 tmp;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		val >>= 1;
+
+		if (val < 0 || val > U16_MAX)
+			return -EINVAL;
+
+		tmp = cpu_to_be16(val);
+
+		return i2c_smbus_write_i2c_block_data(data->client,
+						      MPL3115_PRESS_TGT,
+						      sizeof(tmp), (u8 *)&tmp);
+	case IIO_TEMP:
+		if (val < S8_MIN || val > S8_MAX)
+			return -EINVAL;
+
+		return i2c_smbus_write_byte_data(data->client,
+						 MPL3115_TEMP_TGT, val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
 	.read_avail = &mpl3115_read_avail,
 	.write_raw = &mpl3115_write_raw,
+	.read_event_config = mpl3115_read_event_config,
+	.write_event_config = mpl3115_write_event_config,
+	.read_event_value = mpl3115_read_thresh,
+	.write_event_value = mpl3115_write_thresh,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


