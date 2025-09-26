Return-Path: <linux-kernel+bounces-834003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B5BA394D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406CC1C018B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C62EB86C;
	Fri, 26 Sep 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1/bGgHv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6F2EB86B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888626; cv=none; b=ufEnQU05rkbtVctLYFCqAmuagUHT99C56sh4+k9ap3GkAAFZ7520iVRtBubpFaYaMfW7C/wwjgdMNvBy5gClgaIXd9LmaOrPuFmUOLFgAuxUZzwnsYOWXwilw0cKnH/HI7AG5DOS781mYvOJJD0FgHs595tDl8vLiLEc27by0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888626; c=relaxed/simple;
	bh=QmVvZsx4ee37csg0iSkTnmewXI3jUcQu84l13YGmXH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZwxyc/ThMGtHnrQ3f6ah8iFaEajkBTbusKfxkMc0jONBBRkZvyWC0AayKWOMNojnhQ0lxY+8ehfEosT4Pv47cgsmSCvv1LTWebOl7CDhr7jJZ00UAgGxat2vj6D3odYRXH0dV+6sC3VkoYefqNYn9eeEzXzZ0zWuEuD2Sx5880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1/bGgHv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46cf7bbfda8so11522815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758888623; x=1759493423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kL+ZIbwlRmEu9z7ptF6pUSFQVruxoW4vttGzBi4Nhq0=;
        b=N1/bGgHvX/sJ4kNenJmQY4mDjdJeS/dD5N8aKXpjWJjWFE+U7NLhH8v31YNLF49GRJ
         giFCa1Q+GK5M5zYGlreJKsynkgwghcCVsPRgPxhb89GzfnimWrm0uUDvklFLJo3OKxtE
         eEc2Wmw4jYynPLz9u/0rS8U3BClacCC5xzoSIehcDwFCI20EmwHUxWGA73P6y7U8ylP4
         o/9yQozS9cCIgaBHOSQ8s6u72uaq9lzLi+o26LiwSwnmLLUfYfqbr7wP+IFCA+1fGBKb
         sidOnKhgycRTVnqR8LBhRyMYlaxfQ4gkdSySpLi/a9tZRnpZsvhpMjIRtrxfyt/oR0F1
         Z/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888623; x=1759493423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kL+ZIbwlRmEu9z7ptF6pUSFQVruxoW4vttGzBi4Nhq0=;
        b=SbG68zUazoHHMhjRVvH8V68nB4kRBi61rIooL69xXIGjFMOAWdXqh5lDT/b6s4uP01
         mx4hyLuDDIIhUwScHVsxNmW6uofYuHFm5IswjKs4GW7gjY2gtzXxKZXlfk8uQ8SQw3lX
         Exrn1bWU2ihBBHLRDa+KuEMU3i70PEE9BbTo+ul6ekKqhYGVqeFNJ/PtX6U8yzQqchXT
         4rOX39RpjQY5sGQam1MIi4gaf81BFRG4zSJxfw6AoO6iUOICPPzSO1xan4vCFiieFFXc
         hoGFYfn9S9UfnurKDirrG3cFRUK7N/Ro3N621urrz2gCA8ZR+RTovGXSYD2xKwyJrplv
         CIzw==
X-Forwarded-Encrypted: i=1; AJvYcCUsYOm8N4jeXy3sCSzwMoYezARGgGvfpdzSU6stW+sxoSJrxgOgsuA5lfNVKV9lz78Pwv1K6h+GZv92Ag8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDz1WQ8w8nOvHeO2kwZ+/Psxc/ftJbd2ItEk4TOmtJj7epNiO
	5L/jqtKcGNdMe9pxUCeusvs41XxlIA7XyJ7HRGkvDQVCZwMLkFS7gZ4L
X-Gm-Gg: ASbGncvOdkbqXB8NeuqPQO/wmkmb/BDNuaiHNOSbz79uOYr+nVkQsCu6nLVHIMeQQ6f
	/mfaHzxQgs0UTb0q5ma/DMZHw8B78FZnv+8chNZQQcj7n5YyNf43kZcm1nO40+ECf48RFMP4mKO
	5lVoMcr0SBWIK2DJ+NEAb090VG3SNt/qIZuaTjrsnPa6/e8yX4O3nDj99tfIq1lM9APrT+Xg4Y9
	zoWvG4ETNcumxiZBLdnGL0pJIBtvWz3ISXsE8V7/0L+jqM2HZLdHCoPAPpnErxvqp9xtag0Q3jL
	OqbisTsKxIfCkSfJ/ePq3wg69AM0bRk3kMGz7siBXlpkbBa7I1NHQxU/cMZi7gC1R4ma1UOq9cz
	puOLdamxdVhq4S9tADhINCwY87+PyEfg=
X-Google-Smtp-Source: AGHT+IGraRNpSpME416+vPjkDU//qMfU2Qf2fsAL1HCCTTewevBLvWPHPKU0OoJEe9aTQP3dC78zvQ==
X-Received: by 2002:a05:600c:518d:b0:46e:410f:f645 with SMTP id 5b1f17b1804b1-46e410ff8admr11051865e9.21.1758888622974;
        Fri, 26 Sep 2025 05:10:22 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm7117301f8f.37.2025.09.26.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:10:22 -0700 (PDT)
Message-ID: <3550caed57f460a3d28ed585eda2d955bd846930.camel@gmail.com>
Subject: Re: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Sep 2025 13:10:49 +0100
In-Reply-To: <20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: 
	<20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
	 <20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 01:40 +0300, Cosmin Tanislav wrote:
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

Just one small nit from me. With it:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzt2h_adc.c | 306 +++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 318 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/rzt2h_adc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eed08d25cb7a..220d17039084 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21837,6 +21837,7 @@ L:	linux-iio@vger.kernel.org
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
> index 000000000000..6a49788a5c67
> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,306 @@
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

...

>=20
> +
> +static int rzt2h_adc_pm_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct rzt2h_adc *adc =3D iio_priv(indio_dev);

Not seeing the point of the pointer arithmetic. You can pass your device po=
inter
(adc) directly in platform_set_drvdata()

- Nuno S=C3=A1


