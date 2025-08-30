Return-Path: <linux-kernel+bounces-793057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CACB3CD67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738DF1B26955
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84B2D29C2;
	Sat, 30 Aug 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOEc+eJi"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230332853E2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572528; cv=none; b=kv+97GVWJ/pDMfR7FPQFuSp1Y7eMiZWlrVzDPF/8PJaZ+v/emLk6RjYLWh9R0FMaupncRR5XGBvO0q8SUMJswHKBLOtCyqLSWJsEsSrbBF7FW7Dw74BKIxFf3RwEHzHzT3rh0JSTGcPi+h/yBLwy6MthCYT24NOF+ywQtKn20lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572528; c=relaxed/simple;
	bh=pL0Y/tA1FQ3f1lp+caPxhjKsPy45nrMI/uBEpcjgahA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYLlX4tw8tZlPnB/ZhKE9V6fy8aTvKOYqurrplMH4kwc2DhtnTSZmqVB9vje1aJyMs3LtryzpS9Xx0XXMZRAZ1TFt47SiMDXh56qTZzoyFrgN83oxNzn1lR+g+WOiQsX3UJ2hZLqvpAML1vTWaw+k89M0leQxruPvw+Lm7Xkou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oOEc+eJi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3cbb5e7f5aaso423684f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756572524; x=1757177324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Am/D2MIaLs89LH0/OBcxUYQRA2iV/u3RL9jcdWVzU=;
        b=oOEc+eJimC0cc49JAq1G7T/kNnYWQJJaOkdMPLLqHfQA+//5r/8AHM88IjH86EBvFM
         A3E7FXNo1w7s3lAAwyrKdNB3biqAxGLQrkpZEqTHRdTe71tPk5TFrcyJQ199qtCYgb6H
         WLfVdFgR/0Yb1uHbfHKgSsRI1Z4A82htpzDrz5BRgdRwnVmTBVhR9mUFpwsZwqb+0WUQ
         kcn4Z7B/1yDlNs9Pln0Rc7l3/8waWHhPhm5OHk9ZaOSU57geihRrBJhu7ETGGDCaGMVe
         lwFz4Dc9NFbAuT75ZWNb13Wp+h39QneSe1M+ndJmDPhXzir9fGWuZyi4JEl7TMtwHkpA
         qzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572524; x=1757177324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Am/D2MIaLs89LH0/OBcxUYQRA2iV/u3RL9jcdWVzU=;
        b=MN1lWiF+Rge86Fw7Qf9mL4q6UM7Kn2EIDUh5U9E6PCoxV7n6KXBLgIITAZz3Nbgw2f
         oBo/jtMK53FPKbfDMFRExJBndC0jG+cZ31dRoGjH7Dkr1tIFgTxFI9IZBswjn7sS7UJF
         Yt0xMYKBUAdOy8eQSgl1ofVIpKC6I+OThXSTqUWLegXXYHe5s/3I9Vei6sSDIqfjsdmE
         blshMBXAXaxy9BnJapqihY3F2HlzaQChOYBisqA25rECWGoMNdjVxzHz9Hk8bTwrsj2f
         Q9BMdNr3HcmQz9m93bwxoCJxEnjD3wOQxvfe/pLOQrV2DTMTBNkmXrHWVxgoBfXI/38J
         9NHg==
X-Forwarded-Encrypted: i=1; AJvYcCUHyOrrJo+Cq99I3pX8lw0yjOO3q9FlcORB4dn/i3PeQKR8h6jWndfEh+/y27phFXo9RHOf3bCvikvbZ3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+mWOagTQ48oMNWBx3FQhnJg49pYP1LysBlz8xxj0ObcABeMV
	KL7tyeZkDitYK2MscpvFGWIk+MalLfIpEgjtNJSc5diabuCazoIr/brD8Tqhb/gHIv0=
X-Gm-Gg: ASbGnct4mvNJelBxw/DMKwv3SlB2SrDpD9qrh2lmuAW8g6yd5rkmAPY2gnN86fzzoxM
	zpOcG/4eHc3LXFHOSDrripfvkgBES6yXdCmPbTN2P8XiGzksJ5+eXf1TgJZAR72R8qI7kiAu/4R
	Gj/i8AcEG2DUPb4rBT3nb98fBMcwmADtuOejx7wIfRdxLvPEqJghwW/nHfMl4LhPBFEdQ9lST/E
	HXONTxElvhRB61x9grvpFjFx00Pxdp8eedqEcXidaJB4RJ7eNUItIcq2bdLnGelKSUMpnqVlrvX
	k5eWlTqbE88s1BWvC6p14vIPzgzCaVCVBAoCiCsq8OYu5rKGyr+SlPzwheTH5NukjLwRBYEM9UP
	fFOnkZec1LV2U3nBKEZRlgH2CqkY91noOrw7vrcs=
X-Google-Smtp-Source: AGHT+IHrD1CCygt9VhpZMao/pWEV9H2CEgmVnFAV/e9OSZMvWIN5W6294UyPv80QFR88fzw4agBOrg==
X-Received: by 2002:a05:6000:250c:b0:3cd:edee:c7ea with SMTP id ffacd0b85a97d-3d0fce99928mr1901993f8f.9.1756572524321;
        Sat, 30 Aug 2025 09:48:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf274dde69sm7818129f8f.14.2025.08.30.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:48:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 18:48:31 +0200
Subject: [PATCH v2 2/5] iio: adc: exynos_adc: Drop touchscreen support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v2-2-4f8299343d32@linaro.org>
References: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9651;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pL0Y/tA1FQ3f1lp+caPxhjKsPy45nrMI/uBEpcjgahA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosytkEcxfjHQT7VpZUcY+dplKHe4fxjk2DaMcg
 wuZIqCSX8qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMrZAAKCRDBN2bmhouD
 14esEACT+lG3NVpPCnP6LNODNDUDPVIO42ESqvarp2mk7F4HExWVhyrF3bEKOu2gYO/lJbG4qx2
 lrVEf4KKD48ZpgAOSH2zLuZlS+nHzP+HQ8bhkIAnCf555wKYFFmIKDTu3oHlqbhKHPjlRtCdA3l
 wtWkRmukT196jrOC/7QYR7t9b29Nw9Wd1vMuGia16FBfAN43yyuaAx71Owfmj8qPqJWmlcqQfsz
 m8dmIQfqS5DXjWmzCrhWSlTJ01CjJIEMt++P5Z0HB0+fDSwS4t4L0kP7+QDZ9/RV5j4OS9Brk+q
 7xdUZyQBV+ek+dCOGERMxoAzH8iQuP6ANYK5hA2+XFPT6usd9U4iBh/3aTG4BcCGhYc/yuLlf74
 FbJOQLVofJuoMrK/G+QzsxBzFY/QBIFVq8NAnFdj3o2PYExtLCv0MtOSmremRE13LxpmDyLdkhp
 DG8MuBcL1gT3xELHncCPwojydENBSlFhVOLxCvUSBsZkoQgnOgu/R+7DHj0EFilbOPRLs9snW5C
 u21Gy/0/fbOh6mI6mY42hy2EXEhLmdbx7p6dQSjPPW+AaRRFZLPfc4UzQLrIa/lMvQgndvhqMu5
 5FVcSWmo/NlT4IJqrgue/ODrSvRY7nMsiesFkZDSSlwrvxtSTF3ERxcZmKO+IGLuLzlW+8KMY7/
 v9xEoRs8iaXPEuA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

With last user of touchscreen via ADC (S3C24xx SoC) gone, drop the
remaining code from Samsung SoC ADC driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/exynos_adc.c | 196 +------------------------------------------
 1 file changed, 1 insertion(+), 195 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 17fd33c6bd6d0dcf41771331ecb328e58d820ed0..30f6d8436e775a8d2177951b436cd45152307ea2 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -19,11 +19,9 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/err.h>
-#include <linux/input.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
@@ -35,14 +33,12 @@
 
 /* S3C/EXYNOS4412/5250 ADC_V1 registers definitions */
 #define ADC_V1_CON(x)		((x) + 0x00)
-#define ADC_V1_TSC(x)		((x) + 0x04)
 #define ADC_V1_DLY(x)		((x) + 0x08)
 #define ADC_V1_DATX(x)		((x) + 0x0C)
 #define ADC_V1_DATY(x)		((x) + 0x10)
 #define ADC_V1_UPDN(x)		((x) + 0x14)
 #define ADC_V1_INTCLR(x)	((x) + 0x18)
 #define ADC_V1_MUX(x)		((x) + 0x1c)
-#define ADC_V1_CLRINTPNDNUP(x)	((x) + 0x20)
 
 /* Future ADC_V2 registers definitions */
 #define ADC_V2_CON1(x)		((x) + 0x00)
@@ -61,17 +57,12 @@
 /* Bit definitions for S3C2410 / S3C6410 ADC */
 #define ADC_S3C2410_CON_SELMUX(x) (((x) & 7) << 3)
 
-/* touch screen always uses channel 0 */
-#define ADC_S3C2410_MUX_TS	0
-
 /* ADCTSC Register Bits */
 #define ADC_S3C2443_TSC_UD_SEN		(1u << 8)
 #define ADC_S3C2410_TSC_YM_SEN		(1u << 7)
 #define ADC_S3C2410_TSC_YP_SEN		(1u << 6)
 #define ADC_S3C2410_TSC_XM_SEN		(1u << 5)
 #define ADC_S3C2410_TSC_XP_SEN		(1u << 4)
-#define ADC_S3C2410_TSC_PULL_UP_DISABLE	(1u << 3)
-#define ADC_S3C2410_TSC_AUTO_PST	(1u << 2)
 #define ADC_S3C2410_TSC_XY_PST(x)	(((x) & 0x3) << 0)
 
 #define ADC_TSC_WAIT4INT (ADC_S3C2410_TSC_YM_SEN | \
@@ -79,12 +70,6 @@
 			 ADC_S3C2410_TSC_XP_SEN | \
 			 ADC_S3C2410_TSC_XY_PST(3))
 
-#define ADC_TSC_AUTOPST	(ADC_S3C2410_TSC_YM_SEN | \
-			 ADC_S3C2410_TSC_YP_SEN | \
-			 ADC_S3C2410_TSC_XP_SEN | \
-			 ADC_S3C2410_TSC_AUTO_PST | \
-			 ADC_S3C2410_TSC_XY_PST(0))
-
 /* Bit definitions for ADC_V2 */
 #define ADC_V2_CON1_SOFT_RESET	(1u << 2)
 
@@ -116,13 +101,11 @@
 struct exynos_adc {
 	struct exynos_adc_data	*data;
 	struct device		*dev;
-	struct input_dev	*input;
 	void __iomem		*regs;
 	struct regmap		*pmu_map;
 	struct clk		*clk;
 	struct clk		*sclk;
 	unsigned int		irq;
-	unsigned int		tsirq;
 	unsigned int		delay;
 	struct regulator	*vdd;
 
@@ -131,12 +114,6 @@ struct exynos_adc {
 	u32			value;
 	unsigned int            version;
 
-	bool			ts_enabled;
-
-	bool			read_ts;
-	u32			ts_x;
-	u32			ts_y;
-
 	/*
 	 * Lock to protect from potential concurrent access to the
 	 * completion callback during a manual conversion. For this driver
@@ -507,55 +484,13 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
-{
-	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long time_left;
-	int ret;
-
-	mutex_lock(&info->lock);
-	info->read_ts = true;
-
-	reinit_completion(&info->completion);
-
-	writel(ADC_S3C2410_TSC_PULL_UP_DISABLE | ADC_TSC_AUTOPST,
-	       ADC_V1_TSC(info->regs));
-
-	/* Select the ts channel to be used and Trigger conversion */
-	info->data->start_conv(info, ADC_S3C2410_MUX_TS);
-
-	time_left = wait_for_completion_timeout(&info->completion,
-						EXYNOS_ADC_TIMEOUT);
-	if (time_left == 0) {
-		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
-		if (info->data->init_hw)
-			info->data->init_hw(info);
-		ret = -ETIMEDOUT;
-	} else {
-		*x = info->ts_x;
-		*y = info->ts_y;
-		ret = 0;
-	}
-
-	info->read_ts = false;
-	mutex_unlock(&info->lock);
-
-	return ret;
-}
-
 static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 {
 	struct exynos_adc *info = dev_id;
 	u32 mask = info->data->mask;
 
 	/* Read value */
-	if (info->read_ts) {
-		info->ts_x = readl(ADC_V1_DATX(info->regs));
-		info->ts_y = readl(ADC_V1_DATY(info->regs));
-		writel(ADC_TSC_WAIT4INT | ADC_S3C2443_TSC_UD_SEN, ADC_V1_TSC(info->regs));
-	} else {
-		info->value = readl(ADC_V1_DATX(info->regs)) & mask;
-	}
+	info->value = readl(ADC_V1_DATX(info->regs)) & mask;
 
 	/* clear irq */
 	if (info->data->clear_irq)
@@ -566,46 +501,6 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Here we (ab)use a threaded interrupt handler to stay running
- * for as long as the touchscreen remains pressed, we report
- * a new event with the latest data and then sleep until the
- * next timer tick. This mirrors the behavior of the old
- * driver, with much less code.
- */
-static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
-{
-	struct exynos_adc *info = dev_id;
-	struct iio_dev *dev = dev_get_drvdata(info->dev);
-	u32 x, y;
-	bool pressed;
-	int ret;
-
-	while (READ_ONCE(info->ts_enabled)) {
-		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
-		if (ret == -ETIMEDOUT)
-			break;
-
-		pressed = x & y & ADC_DATX_PRESSED;
-		if (!pressed) {
-			input_report_key(info->input, BTN_TOUCH, 0);
-			input_sync(info->input);
-			break;
-		}
-
-		input_report_abs(info->input, ABS_X, x & ADC_DATX_MASK);
-		input_report_abs(info->input, ABS_Y, y & ADC_DATY_MASK);
-		input_report_key(info->input, BTN_TOUCH, 1);
-		input_sync(info->input);
-
-		usleep_range(1000, 1100);
-	}
-
-	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
-
-	return IRQ_HANDLED;
-}
-
 static int exynos_adc_reg_access(struct iio_dev *indio_dev,
 			      unsigned reg, unsigned writeval,
 			      unsigned *readval)
@@ -657,70 +552,12 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
 	return 0;
 }
 
-static int exynos_adc_ts_open(struct input_dev *dev)
-{
-	struct exynos_adc *info = input_get_drvdata(dev);
-
-	WRITE_ONCE(info->ts_enabled, true);
-	enable_irq(info->tsirq);
-
-	return 0;
-}
-
-static void exynos_adc_ts_close(struct input_dev *dev)
-{
-	struct exynos_adc *info = input_get_drvdata(dev);
-
-	WRITE_ONCE(info->ts_enabled, false);
-	disable_irq(info->tsirq);
-}
-
-static int exynos_adc_ts_init(struct exynos_adc *info)
-{
-	int ret;
-
-	if (info->tsirq <= 0)
-		return -ENODEV;
-
-	info->input = input_allocate_device();
-	if (!info->input)
-		return -ENOMEM;
-
-	info->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	info->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-
-	input_set_abs_params(info->input, ABS_X, 0, 0x3FF, 0, 0);
-	input_set_abs_params(info->input, ABS_Y, 0, 0x3FF, 0, 0);
-
-	info->input->name = "S3C24xx TouchScreen";
-	info->input->id.bustype = BUS_HOST;
-	info->input->open = exynos_adc_ts_open;
-	info->input->close = exynos_adc_ts_close;
-
-	input_set_drvdata(info->input, info);
-
-	ret = input_register_device(info->input);
-	if (ret) {
-		input_free_device(info->input);
-		return ret;
-	}
-
-	ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,
-				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
-				   "touchscreen", info);
-	if (ret)
-		input_unregister_device(info->input);
-
-	return ret;
-}
-
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
 	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
-	bool has_ts = false;
 	int ret;
 	int irq;
 
@@ -753,27 +590,10 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
-
-	if (has_ts) {
-		irq = platform_get_irq(pdev, 1);
-		if (irq == -EPROBE_DEFER)
-			return irq;
-
-		info->tsirq = irq;
-	} else {
-		info->tsirq = -1;
-	}
-
 	info->dev = &pdev->dev;
 
 	init_completion(&info->completion);
@@ -842,11 +662,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	else
 		info->delay = 10000;
 
-	if (has_ts)
-		ret = exynos_adc_ts_init(info);
-	if (ret)
-		goto err_iio;
-
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed adding child nodes\n");
@@ -858,11 +673,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 err_of_populate:
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
-	if (has_ts) {
-		input_unregister_device(info->input);
-		free_irq(info->tsirq, info);
-	}
-err_iio:
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
@@ -882,10 +692,6 @@ static void exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
-		free_irq(info->tsirq, info);
-		input_unregister_device(info->input);
-	}
 	device_for_each_child(&indio_dev->dev, NULL,
 				exynos_adc_remove_devices);
 	iio_device_unregister(indio_dev);

-- 
2.48.1


