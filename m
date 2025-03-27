Return-Path: <linux-kernel+bounces-578264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC5AA72D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18D57A5431
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211621148B;
	Thu, 27 Mar 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CapdY+uj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E6210F4A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070012; cv=none; b=TFIXWyEwjoq95FL5Oz34qqz5rp35PEuanon1qVm1ab5Dc9PXWCYwZOZvb4Gc+0mxP+XUBZRqOuYPhRqGemD5fHawnCKTFs7lfbVWgbJyqQ8TwGNAqd7EOrMb5B6PkLiwWxEJkcfhxUGzVRR25DxePj/icnXx833eLyDvKI0h5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070012; c=relaxed/simple;
	bh=+PmHtqP+PacgxsBGEnwVK2XvaGr72pqoAeQ4kqGa7YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlkmklJ36zq8e4/qjLaaPD/MgCs0BtIMFgL5gKItN7r9OYaaamvSKdWpk3c2Pw932q9WMR0IfYgXGMzqaZS0VuD7lokcDi5Ln3qpgFeoFdfxcQ60pTgt6IR21LpCFiVATtNj4fpC6OWk+heuokKwcZklpOdRNmD9NtnIRQTvNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CapdY+uj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso647760f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743070009; x=1743674809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/O6q7bejAltmiEzMDRxT5+/8dEuiu9gJZK2rMUr+Rg=;
        b=CapdY+ujkwUPvIZvSjAN82pZcVQD73kS0i3yTF2KV5f6t0s+oAki5KiW6MZ2oZSHp7
         hd3WRqtoMFxdzcvz3tx5MOl36ecx4APIwXBQocOloHh6D2gFNoMfz83pVgFObC7HO/qf
         eGtTZ4Us6fGLR0Jlyst/5PDgWGKFDDr4vL0A2DbZf9VWpkgJFGddcymjipmgAFD7jD1n
         qMy/162Lp1gO8zHcJkdyVqe1FWS1+3O9IxkpC3t8UEDKmAJ7U2TL3YP0+tMhPap9VOMx
         GP3WYLF4DQaLBBc9SOz7H2DnxEX2GL7u7s0N1AbNKfeTt1c3Om2guFnMaH3Ci87GjhUf
         k/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743070009; x=1743674809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/O6q7bejAltmiEzMDRxT5+/8dEuiu9gJZK2rMUr+Rg=;
        b=HPAY0jlNFKDvf2QuoCKTMddfHXYWNTdKcxgVd6UMwIoENNWF7kYjRbgTL7rIH5Bz7S
         oxbavmkA7jEDnUWNy7HP7p4x+7swECqbcshOh3EnunQnvBZjqmDzuPH8lqb8f4S55/3x
         n2kNc+EdKX+BlcPpd64AnAPcKLxjUG1sA588MM5EYKNb3S7hcUMsh9GXfLz1cLR3Eeem
         1NCKL3Gqwsx8vvrPXHVjnLKvOPZceNI/Tc3EYJRZLK0ywsUcEpYoVsRcGrGcFzQt/8+Y
         HpspkVYKKJ/njsQ2q2gWEAxEhCo98xzMuzm52/ENYZgUQ5nQ/i+Z8jLekOeGio58l6fX
         jdSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pAuT6FuQtTwFMtcSqTnr1XqjnE1kdlnFCwz9LWMJcvu3R8PqUPKeR2VH6qWU8P52JHcwnMK0Yk0GTEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJE8i1LqBiTY7FXzi2LQ9Keb4eJ1KOQF8WjmyaeHGWXPhC2O1s
	pJEtWQHU/m9KoqUPjI+su69YBPnXL8Q2vIJWXYybgiEV3J4FVJ2B32AaFknxGFo=
X-Gm-Gg: ASbGnctwwNqZJvmeVwf4iSCsvLM2FtZBzKhsHzAhVAhCy7PKbQ1c3ET6qhBg/F1e7s/
	OivNLzzQdFOkYNm4p+7MjERJXY05ntJJz0l6fpv/kS2/HDLEpJ2xdPeqvN2OGzW24oravIR2c92
	/spTkGzRgUduU7LzCoQ+Ox3Uv2sHXQuHwOz0yYP9Mwx2cgDHd124VMEulgQH+0EnMi4uQMXRsX9
	G24SBFRvLQ7vTv158hEZj3beEZBCfp3Tax6h6euClFlK43WejXCmS0BHW/hD6gnDdARyKszMsS8
	p/v4DgSKGXXrJgUEKsPrjeRtIAJGHPvlINWjPSg5yJ1Pow4jXHwZRpIv7YcMMOCylx/FNQ==
X-Google-Smtp-Source: AGHT+IGvM3C0/0a6CuVWf39x1bf4iiKd+cye+L2n5VXYP7sQy+JSX0iliAFk//gnp8fS9mODz7FcYw==
X-Received: by 2002:a5d:5989:0:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39ad17608a0mr2417231f8f.29.1743070008999;
        Thu, 27 Mar 2025 03:06:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac3ce3dd1sm10843204f8f.88.2025.03.27.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:06:47 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH v6 5/6] ASoC: codecs: wcd938x: add mux control support for hp audio mux
Date: Thu, 27 Mar 2025 10:06:32 +0000
Message-Id: <20250327100633.11530-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250327100633.11530-1-srinivas.kandagatla@linaro.org>
References: <20250327100633.11530-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi mux is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

move to using mux control to enable both regulator and handle gpios,
deprecate the usage of gpio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 sound/soc/codecs/Kconfig   |  1 +
 sound/soc/codecs/wcd938x.c | 55 ++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ee35f3aa5521..a2829d76e108 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
 	tristate
 	depends on SOUNDWIRE || !SOUNDWIRE
 	select SND_SOC_WCD_CLASSH
+	select MULTIPLEXER
 
 config SND_SOC_WCD938X_SDW
 	tristate "WCD9380/WCD9385 Codec - SDW"
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index dfaa3de31164..d588ab3546d5 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/mux/consumer.h>
 #include <linux/regulator/consumer.h>
 
 #include "wcd-clsh-v2.h"
@@ -178,6 +179,8 @@ struct wcd938x_priv {
 	int variant;
 	int reset_gpio;
 	struct gpio_desc *us_euro_gpio;
+	struct mux_control *us_euro_mux;
+	unsigned int mux_state;
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
@@ -188,6 +191,7 @@ struct wcd938x_priv {
 	bool comp1_enable;
 	bool comp2_enable;
 	bool ldoh;
+	bool mux_setup_done;
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
@@ -3237,15 +3241,26 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
 
 static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
 {
-	int value;
-
-	struct wcd938x_priv *wcd938x;
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int ret;
 
-	wcd938x = snd_soc_component_get_drvdata(component);
+	if (wcd938x->us_euro_mux) {
+		if (wcd938x->mux_setup_done)
+			mux_control_deselect(wcd938x->us_euro_mux);
 
-	value = gpiod_get_value(wcd938x->us_euro_gpio);
+		ret = mux_control_try_select(wcd938x->us_euro_mux, !wcd938x->mux_state);
+		if (ret) {
+			dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
+			wcd938x->mux_setup_done = false;
+			return false;
+		}
+		wcd938x->mux_setup_done = true;
+	} else {
+		gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
+	}
 
-	gpiod_set_value(wcd938x->us_euro_gpio, !value);
+	wcd938x->mux_state = !wcd938x->mux_state;
 
 	return true;
 }
@@ -3261,11 +3276,26 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return dev_err_probe(dev, wcd938x->reset_gpio,
 				     "Failed to get reset gpio\n");
 
-	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
-						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio))
-		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
-				     "us-euro swap Control GPIO not found\n");
+	wcd938x->us_euro_mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(wcd938x->us_euro_mux)) {
+		if (PTR_ERR(wcd938x->us_euro_mux) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		/* mux is optional and now fallback to using gpio */
+		wcd938x->us_euro_mux = NULL;
+		wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro", GPIOD_OUT_LOW);
+		if (IS_ERR(wcd938x->us_euro_gpio))
+			return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
+					     "us-euro swap Control GPIO not found\n");
+	} else {
+		ret = mux_control_try_select(wcd938x->us_euro_mux, wcd938x->mux_state);
+		if (ret) {
+			dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
+			wcd938x->mux_setup_done = false;
+			return ret;
+		}
+		wcd938x->mux_setup_done = true;
+	}
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
@@ -3581,6 +3611,9 @@ static void wcd938x_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 
+	if (wcd938x->us_euro_mux && wcd938x->mux_setup_done)
+		mux_control_deselect(wcd938x->us_euro_mux);
+
 	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
-- 
2.39.5


