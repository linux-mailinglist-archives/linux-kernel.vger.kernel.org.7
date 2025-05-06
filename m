Return-Path: <linux-kernel+bounces-636723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3EAACF3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CA33BE0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05EE21B182;
	Tue,  6 May 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tuFG8mL8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391E2153DA
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565532; cv=none; b=NVJKFQArpwmX7p60CATCulhq6yF725TpT3mb4/jtb0ImDO9YcGH0EaG0cEGN9v3VJo9UhPBG6uQX437deI1a3WMxla/pY7q7HJB30MCbJOEsK7FFOoEqsEjhlPwOtVE45oj1UfS06rVM809HOCif6CkWnZ1RUnOpz66D/dsAn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565532; c=relaxed/simple;
	bh=z7O+cJ2s2VXn/7thHiJDbQY7RdvV9lwOOzqK+FZqCpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVHs1bf2PlucdTbvil+gpdknKzTIV0BFf9NvYnX/EeQptsb42bLEHqYGPsotbWnQCA+vGWTFJTB3T4R1+Rzw+coWs+fA8qMClothoIdtnlUqATn9EgPq0grR4zNOp2s6afcrb4jjMwucaFrXhvOFa8AF42RDPxKla5xsXKFqqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tuFG8mL8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso50763835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746565528; x=1747170328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxjDKD+JKSiLqw8gK8zG+KrBnxfs5SYwuaGv7cdl5fk=;
        b=tuFG8mL84FquZoOheVVBWxOFQasfvzWViWkaacoMAJyXImsAIJQrTDp9ow8oSf3ZeM
         cpQpVs1Jak/bo1BBSkTEgyf9qmS401GUmcND2oByYzbTfa9JdkzB4+5+QBa5PXLraczV
         vxnKPBD0Aw4I1CG3nhwI8XLtKyFs2Zg9Tn1UJcMdoeZii2jfBeNHK/J5HHobQlOgUyj8
         YmrOboTw+wUlWhTWlfKidYQU5O39yhtxUOjX4ZRTjZs3PPxhpI8J7NKskuG1XUOtvGC0
         gfSvw1vRw6Lni3O8C8ig7lsJzcpPt0ofO5THHvCs28PSm4uazrHFIi9ziWuxvFT1PRhD
         +jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565528; x=1747170328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxjDKD+JKSiLqw8gK8zG+KrBnxfs5SYwuaGv7cdl5fk=;
        b=fqHq/dCOXzOkDAFSPIMV7nN9xaJqLO7mlGcThenn8XA6Gb/mRCHtWTi7P1kFXn1jxt
         u/Adq7HyizcCn3wrIAhbdfiAySjs5tMTpJw4yM7rsQCcuI5Sn6Db+2YezyHUMfHnQits
         SoAYZzawsgsw9g09YaYOIDiQenY8DGa/lVsIQkLYnDPejPMOOE/EHpXFVcWaNIqJ7g5d
         I4FdXKFM4kM1aJG2+eAw1D334lQEssDykSwxxRH7KMVPBv0NtFhxMYZ0fjmghBHJVYcW
         b14ctqgqMZJWQ63P1Jedp+E2z58JSPLKjTqO9oiRxwvh9tXJF9uqlYh4IQU4daQ8FmSv
         1Luw==
X-Forwarded-Encrypted: i=1; AJvYcCXQnsQ29lI9JbM9++7XWHyce6V18/PaTEAhhjqq2fqAfZR7UOIoMSdWqaAukBHfVEqi18JktimX6kYXLa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnaoFaEXr73Jyq/K5MkFXHR83uIaVu5rsxkl6veF1eGyrGpWS
	UtHAKe3Y6r0s1m1nrt69dTcj/WbxQXqWmY47CXEtpM8ZK91Z+S0YHgY1tvhmVic=
X-Gm-Gg: ASbGncsAl1Zp1T3crvUYD9b3rAtHBEOAGLc0giTQN/jOGj6r+XXljTMfDzxt8/SU9Yy
	v/u2pbPzTByM7jCfGCtnb6WpNV2HqcpQonHoEXVc84fwNNzQ5+/qHvihoHHDcRXqvRe3GOnQqx5
	obW2wg6d2eAk6cLMCXlcmzrducSH2WL5LmvyPLq0grn+i3U03HljUm4/FuDI1nE0jIpDLQTFupt
	ZbO5nZ/ASeuvq8HML4hoWzzsliDuzwidZSTOubLGN61DtgqW8VcSANcwJ/V3nX+oZbhH+h9CPiv
	UzQcC0UOorFAnvPfrI1siS4O7DLHvnkrBHPTAtKaIwSVFha2Po04vt15mLIJSNDVXgmURCletWe
	kyu5M451FMMLqzg1TPNc6F1M=
X-Google-Smtp-Source: AGHT+IH/I6vCXS+EzMw3gIbUrM+QZJy17d3GmYqQtggUh+d00T+nsunpp1HkxxkyT/ZZ+4Ldp/Ngiw==
X-Received: by 2002:a05:600c:5006:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-441d44de12dmr3049785e9.22.1746565527940;
        Tue, 06 May 2025 14:05:27 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4351abdsm6794475e9.23.2025.05.06.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:05:27 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 06 May 2025 23:03:51 +0200
Subject: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5739;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=P/FuxJZA+9kES7o8SpZCT2TnVHvYO5j9LvTN2jJFlis=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQqvSYb7upmDlGwPPAjCt+jzb1+BmrOz3byPtZXjL22
 xdt5d08HaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACZiKM/w39XKa/n7HcWltiHn
 3DYW79QLWLLIjffi7mmB6gmCEU2pbxn+B+twGNwW4WFwFilxef0w4veF/t6tPT3noo+nbmB93vm
 BHQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  4 ++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a986eb1284106da4980ac36cb0b5990e4e3bd948..049fd8616769d32778aa238b348b2fb82fa83745 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,6 +33,10 @@
 
 #include "ad7606.h"
 
+#define AD7606_CALIB_GAIN_MIN	0
+#define AD7606_CALIB_GAIN_STEP	1024
+#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values.
@@ -125,6 +129,8 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
+					struct iio_chan_spec *chan);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.max_samplerate = 300 * KILO,
@@ -180,6 +186,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
@@ -195,6 +202,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -246,6 +254,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -357,6 +366,49 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
+					struct iio_chan_spec *chan)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* channel number (here) is from 1 to num_channels */
+		if (reg < 1 || reg > num_channels) {
+			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (ret == -EINVAL)
+			/* Keep the default register value. */
+			continue;
+		if (ret)
+			return ret;
+
+		if (r_gain > AD7606_CALIB_GAIN_MAX)
+			return dev_err_probe(st->dev, -EINVAL,
+					     "wrong gain calibration value.");
+
+		/* Chan reg is 1-based index. */
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1410,6 +1462,10 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 				chan->info_mask_separate_available |=
 					BIT(IIO_CHAN_INFO_CALIBBIAS) |
 					BIT(IIO_CHAN_INFO_CONVDELAY);
+				ret = st->chip_info->calib_gain_setup_cb(
+					indio_dev, chan);
+				if (ret)
+					return ret;
 			}
 
 			/*
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..94165d217b69d54cbce9109b8c0f9dc0237cf304 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -50,6 +50,8 @@ struct ad7606_state;
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
+typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev,
+					    struct iio_chan_spec *chan);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -66,6 +68,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_gain_setup_cb: callback to setup of gain calibration for each channel
  * @calib_offset_avail: pointer to offset calibration range/limits array
  * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
@@ -81,6 +84,7 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
 	const int			*calib_offset_avail;
 	const int			(*calib_phase_avail)[2];
 };

-- 
2.49.0


