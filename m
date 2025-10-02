Return-Path: <linux-kernel+bounces-840689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6061BB4FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6069B3262BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0C2765D0;
	Thu,  2 Oct 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtMB58od"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06712741BC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432761; cv=none; b=qLUlsk+N1M7GZAVsSRhatT570E+lc+7ow20iE98rP3SXlcWMYWDQZNhKG1dRKf/15vH8CDOEIWjfuJ1gPhzv2BCnbqWzO4DoD/t0Ui4dVAS9Ez7j/oXznFEZyGSNfuxGJcg36D3BiAIF+J0wxpcG5e7vmGJeKitzh2UvAJXY9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432761; c=relaxed/simple;
	bh=EYCmAP2B58rza1pmO67EikNUlQoH1ubGX1nFMa61uJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aohj1IXT1prWYTlFBpQzq3M1ve9O612jkQagscShv5uzCatyM2gqr3un6VSWFMgFGAu62b2HNjQZCfABjYTDpmoaBykUMM0enQugR7LFo7nNKCHiA1TR1tHLqyIvhi19gXWtbaukiqfjYrOVfrvPRCos0Y5F3L4yb4UscgXqEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtMB58od; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-72ce9790ab3so16759357b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432759; x=1760037559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTEm/KM3nO+P6ZFw8LYiN73U+Rr4Kx1wTBiXsd/aQ7Y=;
        b=WtMB58odEWZ5lKUPKP0ZuHD+BODAqKSIgH8YbY6oS6NDs6l7ugOXh50R4BnUDy03Uc
         zAM1IhnzlvY3edhqr+waCdqymVm1NidAyhWAXDS1CKwB3vcs1hPzV9D6QZ26ITju+Ptq
         RM9ft9e7AyFiUnHij4u/+NgOquWomaIkm4qfnjR42f4N7qZPh0E8H6CHmKy8UiCoqZmv
         yVDQ2Pqnt2JAn/hocstSpE6GdsCpztsq3akPL+t/6PBwMjoWxGyojKMtWS3gZyacbYmS
         otf0UiCOhTkGCMQ7FTXgGtRbEaZbvk79/P/IO/yYhLVP8WhUaV8fwSX1YjDy+ZVncRMF
         49sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432759; x=1760037559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTEm/KM3nO+P6ZFw8LYiN73U+Rr4Kx1wTBiXsd/aQ7Y=;
        b=xDKN22O77Hoa4Abr4/tf1nERXI5uC19ie6VMKk0kjbQHflyZRD+p1hKE8p0Swf97YT
         5scQRThZDEfaLT/cKcljGrPq1rUYAyDPIBcBCag+nKtVYvgNlPlg1f2jcjnVI/zqFZq8
         I9ulhlNTvbN52PqSv3dVZmdf5k5+qJpP5k1V9G/k7D25HIRmwHOW0uD1oMNl9EUqRNuX
         QW0xJdqJwol/J/k0z6B/kML7PkG/KDU2qssnQtnkxb+NeC4DUjEGAIP8nUnlJfstGTyO
         /54y62VPiwOi83eHknleSpRuqJTqAtO91RD3XVLE8H8Aqfed+yNgHpcNwmXQQga8TeU3
         q0mw==
X-Forwarded-Encrypted: i=1; AJvYcCUDji1QsopEtKu/Gm2QpdSFqwJmNwYuMy5ytEjLkOste84nQ4UMoegYrmxsLvVyDZBNquy5EHrKRyz4HDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUzgyK0sWFJozWylT/2il/p47dwxWt/z2q2J+btnmhfmmymGe
	3deGDneWu9D3Q7MDs3HN9Yz3VtcLM9pn5ZbXiGrEK06Wy0OKE+AIw0TizsMokS6w3RJWXWsBRtW
	etsGkexeVsRopfPEydzCuLah6G2ELIZY=
X-Gm-Gg: ASbGncvTMnqr2XrRF6tSnhV4zyaGBMLo6BEmXzu8f4rpC5W5rIAiHpph/W4RBm5XUxW
	tcjoL+l4WRUIn4AOylhozGL10nabiFpqA4pJEXnACMQzi83XWzj0VZGoAuHfdCP6C+1A+XuVYTe
	zfHmKiCluGFUOIpcj4NWuYw2gIk4UZo+2IfSDSOORlbuiBVIW4eoU96zYNzUEulEec7yUl9fRlb
	uA2yP4jmog6LUfy6/a0yPmeLOP8llgM2FOsfY4boQ==
X-Google-Smtp-Source: AGHT+IEVtvbFpBLouDHWhbnJwj9NSB8Pq7ept+0Odbowddpf/FU0e2Uma5u5HxHffyYlalF9KHMt5Jw9aECDeN/zoBQ=
X-Received: by 2002:a53:b10f:0:b0:635:4ecd:5fd2 with SMTP id
 956f58d0204a3-63b9a10a963mr341381d50.47.1759432758769; Thu, 02 Oct 2025
 12:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63cef5c3643d359e8ec13366ca79377f12dd73b1.1759398641.git.geert+renesas@glider.be>
 <609ec2e6-c877-4fc5-95b7-935ae2549b3a@gmail.com>
In-Reply-To: <609ec2e6-c877-4fc5-95b7-935ae2549b3a@gmail.com>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Thu, 2 Oct 2025 21:19:02 +0200
X-Gm-Features: AS18NWDGIVU_xL1fm5D1v8Yjg5VdVlAOAuUPKHvGlBNPozwO0Loo6YBnGyRj8GE
Message-ID: <CAH+2xPBmWkb-m2S68SybAakJsFRizX-0T0YtXiHGFt+2Q=kpvA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Add missing serial console speed
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors. 2. okt. 2025 kl. 14.32 skrev Matti Vaittinen
<mazziesaccount@gmail.com>:
>
> On 02/10/2025 12:53, Geert Uytterhoeven wrote:
> > Without a serial console speed specified in chosen/stdout-path in the
> > DTB, the serial console uses the default speed of the serial driver,
> > unless explicitly overridden in a legacy console= kernel command-line
> > parameter.
> >
> > After dropping "ti,omap3-uart" from the list of compatible values in DT,
> > AM33xx serial ports can no longer be used with the legacy OMAP serial
> > driver, but only with the OMAP-flavored 8250 serial driver (which is
> > mutually-exclusive with the former).  However, replacing
> > CONFIG_SERIAL_OMAP=y by CONFIG_SERIAL_8250_OMAP=y (with/without enabling
> > CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP) may not be sufficient to restore
> > serial console functionality: the legacy OMAP serial driver defaults to
> > 115200 bps, while the 8250 serial driver defaults to 9600 bps, causing
> > no visible output on the serial console when no appropriate console=
> > kernel command-line parameter is specified.
> >
> > Fix this for all AM33xx boards by adding ":115200n8" to
> > chosen/stdout-path.  This requires replacing the "&uartN" reference by
> > the corresponding "serialN" DT alias.
> >
> > Fixes: ca8be8fc2c306efb ("ARM: dts: am33xx-l4: fix UART compatible")
> > Fixes: 077e1cde78c3f904 ("ARM: omap2plus_defconfig: Enable 8250_OMAP")
> > Closes: https://lore.kernel.org/CAMuHMdUb7Jb2=GqK3=Rn+Gv5G9KogcQieqDvjDCkJA4zyX4VcA@mail.gmail.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Tested-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

>
> (Tested booting on Beaglebone black with a config and kernel command
> line which were NOT affected by the issue. Well, prints do still get
> through the UART to my minicom, so things seem to work for me after this
> change as well :) )
>
> The change does also look Ok to me.
>
> Yours,
>         -- Matti

