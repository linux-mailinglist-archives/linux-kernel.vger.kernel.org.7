Return-Path: <linux-kernel+bounces-852394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF5BD8DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEB734FE432
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322622FDC5D;
	Tue, 14 Oct 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0ypyxAb"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3102C2FDC29
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439450; cv=none; b=ik6RnEA9WiJHwuVEJVfoopHlXyubwvJ6hVH28bbDF9YAicOH3oi0GWi4cUF2CbwqzhhOj1OKZC3uypiTZ391JM227XiJ3mmlGnmqKrCL/6T1pAaq3l6FXpI3IYOjlCZoZTih//qZ4nV+Kjjh0PaZ3RruHWmopOb7g8bymawhYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439450; c=relaxed/simple;
	bh=h0H6MhygcHpVeEe3ayRJhd0DlNHjer2rMmDiK65tgNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd/nF4Tjgx47/0Hcv+eu2pzz2AQmwHuUG/Rqudn/h/fjaNHKpG3fgcDpYF2RwHegxO4E77EP2ENqKa1PWc4TvyaOpARSceRIoBhww1WQeWDSE8IMkyOpLeLCDqnhAxpIVyO1gitQOlVXu7rbAr3MxAlN8gJgeqHHmzzZuG4I6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0ypyxAb; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-77fac63ba26so49986847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760439447; x=1761044247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGzolF9q1IpbbklG5j2EadJMhIpSSosnmlJzCW1vwdk=;
        b=m0ypyxAbUMaX9Ll9fkB6zUZwxACK80pNkvk8W8aSq6klfbFdR1Pi64xS9xDt3zEIlz
         hwnj/nVKxt/m4/mDJ4wcpQd3g6FpDkhEexyr3/auHxcidcB/eoHcCfD7vvoxOOpghRQy
         RJLqHE4W/pRCH8IwKO9G01qOCMqcvC8C4nMaihkPL18aj4XJhmAzo356bP1oj03BKQlv
         O5UyNQwo24nM+MkmV5N07yDdTgVRs1JhxYfvMBuWg2o5YZNgi8Jeq2+elY29l2xHF64j
         veOIn1VrVrDWZmyLZEfHz9k1wzC+Mkk3Bbz1YSFA2oI71xvAElvPWBY4WMhaFgDv47LD
         txxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439447; x=1761044247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGzolF9q1IpbbklG5j2EadJMhIpSSosnmlJzCW1vwdk=;
        b=gNlQWHKjLu66uXX37SG4eDwJ6t/9TPXQNtUeNnwXKg+i5kBQYXkf5wnBLAapAUCtt5
         dndVh4/Dvlm10UgvJRkQ2apxw/xnPbQPTaY+9GihTpyMRL37nVmHCULeqz9e+2OBrcT4
         vM+7aGk39HrSy2+vA2XVs0tiDMU9FUSh0++8f79HWyzStJUPJBKVhHWOl6BKYA0+d+uf
         O4QIEjLHbiGKmIu1WSplUaq4w9aXjYVgftI4Dd01NnNZ71Wq6YQieriaQxgSu43GR1C1
         2OGKmklrQYfnwEX4yKTxbqY/suFiStkXJ63XelDUeJscWMzsJeGNJU6TpstbxsAEjCo5
         fhsg==
X-Forwarded-Encrypted: i=1; AJvYcCXsVVJJirxOxPBWGY0AnTGw4EP94O8KGJbF8PweuuUQaAPN24jNUL8FB8tk98x/nYKskPuXBqpchlmQR7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmS/chx83OdyRwitUzjA+c0i3Hb3MakANuiowafQIU4xsR5Qk
	BdA7rYZrq6/43KQ0DoAGEgdAkH4aJ51rtz6TPYmZvjq3O0tTRfg6S7ARjcfOfTUmHmdG/T/myoK
	XcPafp+d+PhtMUSNahwg2kFEjJ2pVwBtx7/rDW5g39Q==
X-Gm-Gg: ASbGncvMHwXSBVFnxT6Omb/mkt00SXriUFjx492V13hC1tZd1wt+0NBb16fOdWTPMKy
	odrF56oAqYIyw1PMOTuYkg2qNJKsJ2D4VvJNSl6bUfjSQrqghABXLrRufh5yahQPz92Q5GNidYn
	OYsxKTv24F1UxUnsqrhEzTS1FyZ6r/308GTQYac1QllAqWfaF7lDU3aY4UVVSdaMPzuRTUsXGhH
	aeKu6l8aWx0MFdWgG07lZpxBZIIxB0QIsqfQT6i
X-Google-Smtp-Source: AGHT+IEgeGSPp5tZrYwz7LuhOGgC2QQoV6jKld35rrrEDILk6KVu5XlJczlMevH7xUUTupvZG733g6Xg/DOqB7cpoSI=
X-Received: by 2002:a53:d649:0:b0:636:d3f9:6418 with SMTP id
 956f58d0204a3-63ccb864da8mr16445847d50.22.1760439446953; Tue, 14 Oct 2025
 03:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015712.2922237-1-gary.yang@cixtech.com> <20251014015712.2922237-3-gary.yang@cixtech.com>
In-Reply-To: <20251014015712.2922237-3-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:57:11 +0200
X-Gm-Features: AS18NWAM1tuEn3mlDY7wbHC5_VT-EX1J8T4IWs4ITMBNmXaEI1pGIgOsxThjx3c
Message-ID: <CACRpkdaXW-BFM=HvqLiSY-Mkmhso2ETmkZzOX328aSadUEBdSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: cix: Add pin-controller support for sky1
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

this looks very nice, as long as we finish the bindings we can
soon merge this I hope.

Some small comments!

On Tue, Oct 14, 2025 at 3:57=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:


> There are two pin-controllers on Cix Sky1 platform.
> one is used under S0 state, the other is used under S0 and S5 state.
>
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
(...)

> +config PINCTRL_SKY1
> +       tristate "Cix Sky1 pinctrl driver"
> +       depends on ARCH_CIX

Maybe depends on ARCH_CIX || COMPILE_TEST so we
get some compile testing in the test farms and also a test
on the rest of the dependencies.

(Makes the bots complain so we can fix all such things!)

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/pinctrl/machine.h>

Do you really need <linux/pinctrl/machine.h>?

Another thing you might want to consider is whether the
designware GPIO will use this pin controller as
"back-end" for the GPIOs using gpio-ranges in the
GPIO controller nodes, for example (I just made this up):

gpio-ranges =3D <&pinctrl1 0 20 10>, <&pinctrl2 10 50 20>;

Then you might want to implement the GPIO
accelerator operations in struct pinmux_ops, i.e. these:

 * @gpio_request_enable: requests and enables GPIO on a certain pin.
 *      Implement this only if you can mux every pin individually as GPIO. =
The
 *      affected GPIO range is passed along with an offset(pin number) into=
 that
 *      specific GPIO range - function selectors and pin groups are orthogo=
nal
 *      to this, the core will however make sure the pins do not collide.
 * @gpio_disable_free: free up GPIO muxing on a certain pin, the reverse of
 *      @gpio_request_enable
 * @gpio_set_direction: Since controllers may need different configurations
 *      depending on whether the GPIO is configured as input or output,
 *      a direction selector function may be implemented as a backing
 *      to the GPIO controllers that need pin muxing.
 * @strict: do not allow simultaneous use of the same pin for GPIO and anot=
her
 *      function. Check both gpio_owner and mux_owner strictly before appro=
ving
 *      the pin request.

And nowadays it is also worth considering using:

        bool (*function_is_gpio) (struct pinctrl_dev *pctldev,
                                  unsigned int selector);

To make the pinctrl core awara of a certain function selector being the
GPIO function (which makes the accelerated functions work much better
with the strict mode).

This can all be added later in separate patches, but this is a good time
to make sure nothing stands in the way of doing this.

Yours,
Linus Walleij

