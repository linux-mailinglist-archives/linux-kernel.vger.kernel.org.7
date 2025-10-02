Return-Path: <linux-kernel+bounces-840229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71ABB3E32
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F819C77FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6C3101C4;
	Thu,  2 Oct 2025 12:28:39 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B6201017
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408118; cv=none; b=jxRWAlV/zMSExjRfk2H/9215BbdEnrOy6RJdzbEZfL+2cJjpJU6wVDkEACro3CFmp47vLnRg59iP1fJ29T7+0TtfcWCrU0PIGh5tJgqATge3yEmXFcRMGYw5ynj89/8LYhO4n7NCGPvOUnyF0WUf+GKPGdwiqZXP94S6v6EvT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408118; c=relaxed/simple;
	bh=crq8yfuHaLUS3p5H/zdDJJGaYFs9968BkE02+nGHfFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVhCwCvUHPgnGWYuHEt4B+NBQa5uMUpirTRgntqcsqED3eqY10sauXt7pJMoppf8UgDyj0klX1CtVwO+4e+MvSardUCWBzzLpLc67YCTtoHI4titwEov5Qq1wbRf9V/7y8GzCKvaivGxSfxZmQDvuxTTscmZgQN425/fAFL+caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso793613a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408115; x=1760012915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJO2rpeSfonOqfgPMdFd9YnOjY8waVVypT7pLmPKhlg=;
        b=oYWDxDaaOL5LmHBsrxVKenjKEzPHEXgLfk5ii0weWDxcktiHrZtNunkBNrP+oP3R+n
         vNB4GMigjPx8QiCfiF8wph2iwkSfTXAMSK8LA9qhoYokzFVz64+7EV0h6JVoy0qP3d8k
         bWYOg/S36LRL6MLDu3MsNiTXIj14q4ss2SvOvKYOxF0W4CtP5X9RGvNRmHw0hR8Ee3mH
         AXHnBOaXk9o643dOaWJ3MDq4wA01XHW1XR+rFZ3oFJjSqs6sP1Pn7WZerbdC7OHsdWD3
         1xj84tCsIAeOouSukljWtk0WLRTzNVJ8ea4QyKq3xCQbbZ/3DT6WrEABBGwZPIe+ucl3
         Bgkw==
X-Forwarded-Encrypted: i=1; AJvYcCXs7Y5eSXkibagWAXQvMyncKma4QhCJd5xpbhy2yN17fZuwBcPvLeSNh2bGSieG4waJ7z2jPVs+/7c6XnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWQKfQ4g3NM0Pr2Wpro9O8qzul88YpfOA67vwyWnHqrFXgD5t
	DIFk/ikpZNAwyhC21rYGEEXwFtri812XmHbYUo/4xsjQx1vUb/XiHW5miM4hhQPB0SQ=
X-Gm-Gg: ASbGnctXl6auN134bgcDk2YlDuC0rmYt90QqxWlkjAVrkdywNfwggPf2PGEexXvxbU4
	nbpuVvOh9LF3pkuitEUOW1BDRF+E4eC8Oqf0eYGSwRhL0yvpgOWljeUj0NNlWBTrAT/w6kwufN9
	XKzdRTBEfkJ3ajTeVtj48FP+KiksfvCH9lQTp+GSk/KynqsBB6uImMFDLahR7iskrrqyGWAEIHv
	SKfDnZz3ncT6/ZfPTeLTFVbPgqsA5+HFR9xjnLR/JHVkmOXocP5SHWTZTYeBJIBvQGwDzfyqeAs
	x6ZhwEaotEFuMg+1+3gvJC/dZ4EnAu0bhpcw3VTbV2maiSIKesZ4MKFROxBe7sfMflr55ixlt5B
	k9cJi3TKVGNcuHasdU5ppGW8CaADevX+/CEXxiRk4dxEwEW3U+GCpB/BEvnfvB2Y4SnBvOOPfct
	lis9+jOjey
X-Google-Smtp-Source: AGHT+IEHsAqlGEElhAP85a0JuJs/hfHxbw9OcWF/I5IsEKFRBhA/Opmr/WTtyejjLbXH/CBvUMde+A==
X-Received: by 2002:a05:6402:51cf:b0:634:5371:d713 with SMTP id 4fb4d7f45d1cf-63678bb76bdmr8468080a12.14.1759408114806;
        Thu, 02 Oct 2025 05:28:34 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f5bbsm1708458a12.49.2025.10.02.05.28.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:28:33 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1919298a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0+nn01tRI9w07GWEiiuL7fboUTdRUGi7Z5ymU2itbsfPlCf8m0knmLVECuhNuH8Qq9Esmyy+eW64lW0s=@vger.kernel.org
X-Received: by 2002:a05:6402:1d53:b0:634:b5b5:9fb5 with SMTP id
 4fb4d7f45d1cf-63678bb704emr8111645a12.10.1759408113266; Thu, 02 Oct 2025
 05:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:28:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
X-Gm-Features: AS18NWC-_9Ox7ciqPoYRQmMsFw1knBxTffAhjo8400Hfa4uqpwmBsatJ-il-O0c
Message-ID: <CAMuHMdXPEZJ11sfLDk=O1oZq_OKz22G9wz3Sw5acMr1QVYG_Qg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add support for the A/D 12-Bit successive approximation converters found
> in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Conversions can be performed in single or continuous mode. Result of the
> conversion is stored in a 16-bit data register corresponding to each
> channel.
>
> The conversions can be started by a software trigger, a synchronous
> trigger (from MTU or from ELC) or an asynchronous external trigger (from
> ADTRGn# pin).
>
> Only single mode with software trigger is supported for now.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thanks for your patch!

> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
>           To compile this driver as a module, choose M here: the
>           module will be called rzg2l_adc.
>
> +config RZT2H_ADC
> +       tristate "Renesas RZ/T2H / RZ/N2H ADC driver"

depends on ARCH_RENESAS || COMPILE_TEST

> +       select IIO_ADC_HELPER
> +       help
> +         Say yes here to build support for the ADC found in Renesas
> +         RZ/T2H / RZ/N2H SoCs.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called rzt2h_adc.
> +
>  config SC27XX_ADC
>         tristate "Spreadtrum SC27xx series PMICs ADC"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST

> --- /dev/null
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,309 @@
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
> +#define RZT2H_NAME                     "rzt2h-adc"
> +
> +#define RZT2H_ADCSR_REG                        0x00

I would drop the "_REG"-suffix from register definitions...

> +#define RZT2H_ADCSR_ADIE_MASK          BIT(12)

... and the "_MASK"-suffix from single-bit definitions.  But this is
my personal preference/taste.  Perhaps IIO uses a different convention?

> +#define RZT2H_ADCSR_ADCS_MASK          GENMASK(14, 13)
> +#define RZT2H_ADCSR_ADCS_SINGLE                0b00
> +#define RZT2H_ADCSR_ADST_MASK          BIT(15)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

