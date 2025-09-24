Return-Path: <linux-kernel+bounces-830673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B4B9A440
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1589D7A2153
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4D307AEC;
	Wed, 24 Sep 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhtjSPTV"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1921F63F9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724463; cv=none; b=ndl5J6elIWFyAMyNlzJOSUCXJ0p1mAbFK7hK24KuyNd+0AMahQHA763fv0faB/oMhi3q/wnhA2jqGeNomxCxSrZduF43DoXlkm2Sp10K4Dtq/J3rObD5+aDlYuPYPTRsBiCpnbhp2iuDv2PySXlIl7xin5btiWtiQiYFtd6QrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724463; c=relaxed/simple;
	bh=A9PimX6bUbgQ7SeUVDOv0qB4SMDat/5djDZWcI5N8yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUNnlbxpgrDQeqR7uy6vd2PBF6SXsinOase3pbS8QeYiu+Br+8Rv20B9CE5PCBO5zvtyi7fawZpHfVyGshRVinhN9bv0747U86IXlaR6nwLpK/lGHNjt3e42gR+v1446l/FyxEOQv3Hwhi3MiIfq3H9IcaclVlZLSJ5MGPbH6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhtjSPTV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso7690047f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724459; x=1759329259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGuldXcjqf8OihVldC7MI7YO4JLmIiQzrU/Ak4hlUT8=;
        b=NhtjSPTVz6CE3h3aDhfNIovy3mbAnnxgziyM+bPBfvo9A2UwJeIfhBwFJDtXGaTWEe
         uGonJrwJx/3c98ZVLPIW45eSjanFE/fd4KVxLDrNEd0DrewnmE28toJjmOFOZ7IWHpNk
         553OmJb34FcS/+n4iF09QPaWghFXF2n3jSsgPLKhzZZf4tjajXVIAd+0ltstLtXmADTt
         BjI/tHjmVZLVV2KQU4b1RMoKl+lrMQFVZDKN9T4u37KDxO0yfK5sDWEBVlpts4ozz0vN
         GXwdYqERFvmHBcpzu0SbLi7h7bHhfF8JP1WFPxN4mQ/F/eRHa+Dy2VBNKgsQCtBhhda1
         ztoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724459; x=1759329259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGuldXcjqf8OihVldC7MI7YO4JLmIiQzrU/Ak4hlUT8=;
        b=PtiQM9DFN5bj3Z+yuDTK1/fSpaVdyNpTDU9gtljgE6fklKN3B5KahxCtiKCy0Fzwqv
         LT+x3NV9wdZ/d/6K55fL8oZYc5J73fi+FEqJ2DzZFgdmAoxJ+Hx/D5aU6mC8h9EUXnK9
         +9Qh90qdnGrqiqy/kw5+XLmuWR+It6xDmXR8WTaT/Z7ay1PvQP4DMOSRPVc9Xvlb46Je
         p6loiYNfJArKPe/3BRaj1B+LjuoDkfHgFXxGuc9OyePC8Ad1YM4b547BTCXnw2fESS3i
         uBeHG3zQsNzEyYu9SSYPEokQpS2X2hxnpudYVjmbBHsaZm1QrZz+5Ew6VMam4dciZu5g
         IDIA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHDINC61Q8iVm0/YmHo/DZW7LT60jwhkIqxxRArcNOSn0WYI2Znq9riG0XFGhu/9YL4A1XEKbsVJSSos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5OGIZHhE9YzT2eUGj7XFeUNOLgnFYTR5a23CDt9hT1I10N5Rr
	Dnvkrv8sUubAPGeonH1R+VHT5SPRpAUiUISFQClJ0janMRGdiELK5cgB
X-Gm-Gg: ASbGncv9N3CE6fSwFss05H2fvgJuWEdVXYwNSsCw+qB8uIEIalLwN6PLXO61foORa7D
	J/JO+Au4HYCdEEZnjY0fN7a3pMqFYgKlFWYgohqeM1H0uJyQEe4hEJwD4ziHv6p8tUWqCYm8OUF
	xQVIHKtEQSUqf4IR6+50M+3yesYqLZKNTsS2hdg/8ZIEnrjt23cm6LoMuA6uE/hedDAAJSyffCA
	WCZWsfToLiHBhLczlhcqW1MpM32fFCZn7X/i/7NFla52cHHgnY2y0DkFnyh4cc1ymT2QMRp3Fe4
	5JPVzpIAIIUrh53pMjx6m7yl47cxHcjIGa8ZP0VgYTQIU3QEoIOCdXYYbdtORg75fsFqrKNI8La
	T0jBE251A6jQ/iyFtn8HWeg==
X-Google-Smtp-Source: AGHT+IGLJblPflhmFCHt94DviBP9O/s0y5YTbBNNacFFsu0nA3nuXpOv6LIYJxuAR0FgwMMN3hA1gg==
X-Received: by 2002:a05:6000:220f:b0:3ec:3cac:7dfd with SMTP id ffacd0b85a97d-40e44c3da28mr207611f8f.26.1758724458762;
        Wed, 24 Sep 2025 07:34:18 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbffaeasm28405985f8f.62.2025.09.24.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:34:18 -0700 (PDT)
Message-ID: <404c05f20becd0fc8e3256425843187b40a3b625.camel@gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd	 <sboyd@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, 	linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-clk@vger.kernel.org
Date: Wed, 24 Sep 2025 15:34:45 +0100
In-Reply-To: <20250923160524.1096720-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: 
	<20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
	 <20250923160524.1096720-4-cosmin-gabriel.tanislav.xa@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Cosmin,

Some comments/questions from me...
=20
On Tue, 2025-09-23 at 19:05 +0300, Cosmin Tanislav wrote:
> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>=20
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
>=20
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
>=20
> Only single mode with software trigger is supported for now.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzt2h_adc.c | 328 +++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 340 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/rzt2h_adc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07e0d37cf468..d550399dc390 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21828,6 +21828,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0L:	linux-renesas-soc@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.=
yaml
> +F:	drivers/iio/adc/rzt2h_adc.c
> =C2=A0
> =C2=A0RENESAS RTCA-3 RTC DRIVER
> =C2=A0M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..cab5eeba48fe 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called rzg2l_adc.
> =C2=A0
> +config RZT2H_ADC
> +	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> +	select IIO_ADC_HELPER
> +	help
> +	=C2=A0 Say yes here to build support for the ADC found in Renesas
> +	=C2=A0 RZ/T2H / RZ/N2H SoCs.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called rzt2h_adc.
> +
> =C2=A0config SC27XX_ADC
> =C2=A0	tristate "Spreadtrum SC27xx series PMICs ADC"
> =C2=A0	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc010..ed647a734c51 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> +obj-$(CONFIG_RZT2H_ADC) +=3D rzt2h_adc.o
> =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> new file mode 100644
> index 000000000000..d855a79b3d96
> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +
> +#define RZT2H_NAME			"rzt2h-adc"
> +
> +#define RZT2H_ADCSR_REG			0x00
> +#define RZT2H_ADCSR_ADIE_MASK		BIT(12)
> +#define RZT2H_ADCSR_ADCS_MASK		GENMASK(14, 13)
> +#define RZT2H_ADCSR_ADCS_SINGLE		0b00
> +#define RZT2H_ADCSR_ADST_MASK		BIT(15)
> +
> +#define RZT2H_ADANSA0_REG		0x04
> +#define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
> +
> +#define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
> +
> +#define RZT2H_ADCALCTL_REG		0x1f0
> +#define RZT2H_ADCALCTL_CAL_MASK		BIT(0)
> +#define RZT2H_ADCALCTL_CAL_RDY_MASK	BIT(1)
> +#define RZT2H_ADCALCTL_CAL_ERR_MASK	BIT(2)
> +
> +#define RZT2H_ADC_MAX_CHANNELS		16
> +#define RZT2H_ADC_VREF_MV		1800
> +#define RZT2H_ADC_RESOLUTION		12
> +
> +struct rzt2h_adc {
> +	void __iomem *base;
> +	struct device *dev;
> +
> +	struct completion completion;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
> +
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +
> +	u16 data[RZT2H_ADC_MAX_CHANNELS];
> +};
> +
> +static void rzt2h_adc_start_stop(struct rzt2h_adc *adc, bool start,
> +				 unsigned int conversion_type)
> +{
> +	u16 mask;
> +	u16 reg;
> +
> +	reg =3D readw(adc->base + RZT2H_ADCSR_REG);
> +
> +	if (start) {
> +		/* Set conversion type */
> +		reg &=3D ~RZT2H_ADCSR_ADCS_MASK;
> +		reg |=3D FIELD_PREP(RZT2H_ADCSR_ADCS_MASK, conversion_type);
> +	}
> +
> +	/* Toggle end of conversion interrupt and start bit. */
> +	mask =3D RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK;
> +	if (start)
> +		reg |=3D mask;
> +	else
> +		reg &=3D ~mask;
> +
> +	writew(reg, adc->base + RZT2H_ADCSR_REG);
> +}
> +
> +static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int
> conversion_type)
> +{
> +	rzt2h_adc_start_stop(adc, true, conversion_type);
> +}
> +
> +static void rzt2h_adc_stop(struct rzt2h_adc *adc)
> +{
> +	rzt2h_adc_start_stop(adc, false, 0);
> +}
> +

I'm not 100% convince the above two helpers add much value given the usage =
they
have. I do understand that they make things a bit more readable but still..=
.

rzt2h_adc_start_stop(adc, false/true, ...) is already fairly clear about it=
's
happening. Dont't feel strong about it anyways so up to you.

> +static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch,=
 int
> *val)
> +{
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(adc->dev);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&adc->lock);
> +
> +	reinit_completion(&adc->completion);
> +
> +	/* Enable a single channel */
> +	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
> +
> +	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);

This is the only place where this is called. So we could just pass
RZT2H_ADCSR_ADCS_SINGLE inside the function. Unless this will be extended i=
n the
near future?

> +
> +	/*
> +	 * Datasheet Page 2770, Table 41.1:
> +	 * 0.32us per channel when sample-and-hold circuits are not in use.
> +	 */
> +	ret =3D wait_for_completion_timeout(&adc->completion,
> usecs_to_jiffies(1));
> +	if (!ret) {
> +		ret =3D -ETIMEDOUT;
> +		goto disable;
> +	}
> +
> +	*val =3D adc->data[ch];
> +	ret =3D IIO_VAL_INT;
> +
> +disable:
> +	rzt2h_adc_stop(adc);
> +
> +	pm_runtime_put_autosuspend(adc->dev);
> +
> +	return ret;
> +}
> +
> +static void rzt2h_adc_set_cal(struct rzt2h_adc *adc, bool cal)
> +{
> +	u16 val;
> +
> +	val =3D readw(adc->base + RZT2H_ADCALCTL_REG);
> +	if (cal)
> +		val |=3D RZT2H_ADCALCTL_CAL_MASK;
> +	else
> +		val &=3D ~RZT2H_ADCALCTL_CAL_MASK;
> +
> +	writew(val, adc->base + RZT2H_ADCALCTL_REG);
> +}
> +
> +static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
> +{
> +	u16 val;
> +	int ret;
> +
> +	rzt2h_adc_set_cal(adc, true);
> +
> +	ret =3D read_poll_timeout(readw, val, val &
> RZT2H_ADCALCTL_CAL_RDY_MASK,
> +				200, 1000, true, adc->base +
> RZT2H_ADCALCTL_REG);
> +	if (ret) {
> +		dev_err(adc->dev, "Calibration timed out: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (val & RZT2H_ADCALCTL_CAL_ERR_MASK) {
> +		dev_err(adc->dev, "Calibration failed\n");
> +		return -EINVAL;
> +	}
> +
> +	rzt2h_adc_set_cal(adc, false);

Should we disable calibrations in the error path (or right after
read_poll_timeout()) or it does not really matter?

> +
> +	return 0;
> +}
> +
> +static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return rzt2h_adc_read_single(adc, chan->channel, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D RZT2H_ADC_VREF_MV;
> +		*val2 =3D RZT2H_ADC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info rzt2h_adc_iio_info =3D {
> +	.read_raw =3D rzt2h_adc_read_raw,
> +};
> +
> +static irqreturn_t rzt2h_adc_isr(int irq, void *private)
> +{
> +	struct rzt2h_adc *adc =3D private;
> +	unsigned long enabled_channels;
> +	unsigned int ch;
> +
> +	enabled_channels =3D readw(adc->base + RZT2H_ADANSA0_REG);
> +	if (!enabled_channels)
> +		return IRQ_NONE;

Is the above possible at all? In rzt2h_adc_read_single() we do write the sa=
me
register...

> +
> +	for_each_set_bit(ch, &enabled_channels, adc->num_channels)
> +		adc->data[ch] =3D readw(adc->base + RZT2H_ADDR_REG(ch));
> +

Is there any particular reason for reading all enabled channels in the IRQ =
when
we kind of just care for one channel? If there's nothing non obvious happen=
ing
It seems that the IRQ could just do complete(...) and reading the result in=
=20
rzt2h_adc_read_single()

- Nuno S=C3=A1


