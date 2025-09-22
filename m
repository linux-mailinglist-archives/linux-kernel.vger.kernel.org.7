Return-Path: <linux-kernel+bounces-827436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FAB91C38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB873B02F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FE27EC80;
	Mon, 22 Sep 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HQpnWgms"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440927E06C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552024; cv=none; b=d2i39MuCPPYEpOahur7PGAFs0e9j6cIdMGdGX0WRJZOq7MZSIVuVfaCcWXM4sIrgZPja7EKLYzCuhdPRtY2ho00NZmA2c2Ljt2viU2+5FJ2/49gJjU1JoSac8NmJLXFhRVEalsUu68piQY4G53ffuk5ovHEd6R/l69EXhtTSMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552024; c=relaxed/simple;
	bh=yepCEkqx+tJ9SfMA2OEX+XtK06+n5ZYh63moEPd46x0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id9CAgkoXk7Zht5tbjaW0L8S4mdDSvSa57putWrZ2nWZ2VMHhi1E38uUZx5QsNEC0aiLstL10JSyA7l6xGN7DmXiVl2v/0QZcfpTx6Fy8+PfIJBF5P+f+wmI7+iKQQr3M7EUxdZjhYNkZ+EoacN4N3kI0sNmw7eIHf+xZ6ZUpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HQpnWgms; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-366ce79fbeeso18674441fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758552021; x=1759156821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLBAazs/nxJF8yxwNh5gEJHCO5ze8QeHzK+y6Ysr1Nk=;
        b=HQpnWgms0Ja5FSezEBH0iFDJ8euwgu2ncgsNS8/YeJF8xycl3PLLMxe1/AX9Adi5Ux
         CH+RRN1lnbwYWtvPTaRGV0YkP8wBKGjr95EFIvt8e3esJYkZThPuodOPvGxlOwd94ezV
         JYR4zCKUfu4s+2x/rjNgpo3UpVheYXfpDpeLgDA96Wu4j/eDqfyEVxhoRJ934W3/d7++
         u4Sn94eX5y3aPro7rGzEIhqWSyz9RNUzjzz9267JHiete7HgUx8e/InOJl8swpe4fgQd
         fqZB0Tnd0O5jfcGDWF3wkRflmZXSavNgJJcjrIUg4IumZra74Q5pD/1TpDazikVDH+7H
         5uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552021; x=1759156821;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLBAazs/nxJF8yxwNh5gEJHCO5ze8QeHzK+y6Ysr1Nk=;
        b=Eo5TTb7KK9wArEkCvPqMMBPAYZQlegxFQY06vv3kw3aLBguoGC5EtsAASMQFtB/Mek
         A2aM69frdKgJ9B0QwIBs62Sf303eaByKTFhzU8yt0Y0URjZm/QWG0bIvqjK3Nf9ONNle
         P2KqrjULlPm9lW4urlq9qnLUM166aktNPv3ubX2yZm1jovRuVoHOHhiadp0GL0aS6njb
         2wHY1b5QcTRwjL8dwThrIaTxzl2YdkRs+pfL7HhvsikFVFWCinzQ4plCO/RlU5tgh9b5
         7SrMo76MyKE4FBHEnqKCmbntGKiuzOLwr/zPYHVXjvFsurt4WB9oj7l6DLZf4mFiKgxT
         0Nug==
X-Forwarded-Encrypted: i=1; AJvYcCVz26P2iW1or1bUqXlx9IYgmMsinYNnHXhrTN+6sfYs4HjTWfx4ewqA1GS/OltI3BsfdEt1CpLA16qpmZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+ZufSADplTNGEK7tcIksVX4xD34yqtzRus1DmYNPvu6IK78t
	0zdqQvGkQWlMN67LCmifpRbOUwgFOjrIu85a2KF2soJ+6bUgE6SGPBXvf1DCZexJ7JfAwF4bM+X
	xU7hw532aEnI27okf4sy9ywn+7yDqK2CPUFKTFxKdlg==
X-Gm-Gg: ASbGncvAqFKhsbZTocLhJBEzqZ6CqrV5gVQaN507jFtvXl8a1GlKRwrBB/eIq2qep76
	UnAd/Iw56dImSF07SoCM332Cdg8ZyNbGmamuhnYc+zeVpe+MxxKHIfK3+96xFqvmbBHw7mF4Jro
	9wpFxA1zl/0zVXOtH72M4MINx+qcnzuu6d3/0x1IVFKc1mmEjeluQPm578EOixsEs6RmOogz8sn
	0Hy1AekmMlsUB8gecmVdP1FdD2P17EBDdTEBA==
X-Google-Smtp-Source: AGHT+IEtl7gRzMLbqHBpWHIR87hQXX3FGhxljgXueBTPbiKB62hfEksllYkVt1kYIENgJIzsIXJLZZ/2dbBopV9ru0I=
X-Received: by 2002:a05:651c:552:b0:336:72e1:7f45 with SMTP id
 38308e7fff4ca-3641a9e760amr29584451fa.24.1758552020948; Mon, 22 Sep 2025
 07:40:20 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:40:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:40:18 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250922142427.3310221-2-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922142427.3310221-1-ioana.ciornei@nxp.com> <20250922142427.3310221-2-ioana.ciornei@nxp.com>
Date: Mon, 22 Sep 2025 07:40:18 -0700
X-Gm-Features: AS18NWC7aoxTWWKVeKbCbIcNgPLnDms_wQkRSqMIUUGXxxUoQ0T1B-fPxmnWVhY
Message-ID: <CAMRc=MfefZjPrBCLHNUry7JvWUKe7SnuqtkF0_w13d+sRkn9SQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] dt-bindings: gpio: add QIXIS FPGA based GPIO controller
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sep 2025 16:24:16 +0200, Ioana Ciornei <ioana.ciornei@nxp.com> said:
> Add a device tree binding for the QIXIS FPGA based GPIO controller.
> Depending on the board, the QIXIS FPGA exposes registers which act as a
> GPIO controller, each with 8 GPIO lines of fixed direction.
>
> Since each QIXIS FPGA layout has its particularities, add a separate
> compatible string for each board/GPIO register combination supported.
>
> Since these GPIO controllers are trivial, make use of the newly added
> trivial-gpio.yaml file instead of creating an entirely new one.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - Used the newly added trivial-gpio.yaml file
> - Removed redundant "bindings" from commit title
> - Added only one compatible string for the gpio controllers on
>   LX2160ARDB since both registers have the same layout.
> Changes in v3:
> - none
> Changes in v4:
> - none
> Changes in v5:
> - none
>
>  Documentation/devicetree/bindings/gpio/trivial-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml b/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
> index c994177de940..3f4bbd57fc52 100644
> --- a/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
> @@ -22,6 +22,8 @@ properties:
>            - cznic,moxtet-gpio
>            - dlg,slg7xl45106
>            - fcs,fxl6408
> +          - fsl,ls1046aqds-fpga-gpio-stat-pres2
> +          - fsl,lx2160ardb-fpga-gpio-sfp
>            - gateworks,pld-gpio
>            - ibm,ppc4xx-gpio
>            - loongson,ls1x-gpio
> --
> 2.25.1
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

