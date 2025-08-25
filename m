Return-Path: <linux-kernel+bounces-784356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B6B33A64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D904017D2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20712C21DF;
	Mon, 25 Aug 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNHr2Pag"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951132D0C7E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113242; cv=none; b=HY8FXG+rNaMkvHP1IZfb7cjzCxEm0X1Zh5QHH5c4wd4q4jXkv4zjV4TaOfloO0aEL6a+rXSVZ1lu07Rv+r7hKVWRTq3KnhrI0HanAeJxhuxvhqzBnkbMPGXFbSiUbAchVh4qyDDZkFYyeqJwvmQOpaJzIopUklZoOgG41MdDP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113242; c=relaxed/simple;
	bh=XOAv6hQX72JTJoOiv3v9g2pt29fiKlNO0ZbSfNVbdcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkoVkxpgPb0gO7xoeyUK6b+OnBm/WI9H0Jx8JQ1b722MaGiEA/+bHWLX0EpgE/iEY59wEkSGMhSlNw3KKI5LcKZ5CqwUp6+xySAVvUybqsmGMhfwdvSdob7GaS+BJPAjJYVIy0LDWO4ODOp84zuCHpiEABgUBopCzMqxJHx1Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNHr2Pag; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336763f6fb8so6303181fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756113238; x=1756718038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP0weFM2+mVOhYEbkmdk331UXDeERciVJHGW33WlzMM=;
        b=HNHr2PagF+9eI2s+AkQZ+9SEM/lcRSwGz04ABnWz1/KmZFIyE0epujdc5uChztzoyf
         +g/vmnQBt0ykNmNQTCAj3LiDBvH8FJxaBQpvf57Sz5uK83+zdO4QFZeyqpNg/WKU/jJw
         vmOXvTDnSsOAvzsnr2f7sFyqKv41TJ+BJcA8BqwoGNmf2DNZt0zPM16kQp3vmvf1Sfbe
         z9PG5KqdPWW7ZOwaCAqwpaNtr28kctxT382yRtn677tW9bGdc6ukaAYtR6+kh5ME9s/1
         mrbOIdEdzd5XszZTpNQk5MqlZ/XtX3/H4Nj0lzXeezkfZHs9Mj0kNDBxaVMKawV+MiI1
         Hq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113238; x=1756718038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP0weFM2+mVOhYEbkmdk331UXDeERciVJHGW33WlzMM=;
        b=fRcGGTlQwOUOK3TYbPvIuVhkJadlkpvdOXK9gS6w5Y2D4063UfWpU6ftGVMrB9WUgp
         DAVGV6Ii5TlIuTZMo3gyBycpFRTrZjCMHgMQnbV4gK2K+zPyzEtJSByLejNf+P7wwWXg
         I9oZHsDKkths1MQ3ZdpSBMtaCgpCExwdxH9pgtsAp75D+yH3/l59MLOS2aF/LClRtWSX
         Z3gTbTeVFfL/XOux7/1DfHL/wmUokybkNsaZfHaAcVTX+O/CrWFmCp3B6u/eB9/lX7XS
         8S5DWx2pTQS2pQRawQl9o7CvymVK45BS47PxUYRtMudL3kY6sOzftn0MkNOQ8hhFnSSC
         tsQg==
X-Forwarded-Encrypted: i=1; AJvYcCXow7u6cxoL6DfK48rnNGdPDXMV7uO7wIqG9HtIUcZY/PnpsvsyySpsKDEoeP8LoH9pioU0Y9VX8bSZcH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhTUGKUg3F1iIOsMHYXCQvGVLKWd3PHi/3Lyy3+x+ZieRd/w8
	oqcCfHo5bkf3qpaHSBM+6aQzEjE7hiclQQRIlplpB0KkFL+VjKiDzsmQguiqqot2GTQtXi72ikz
	cRullHa0ck0+ZGapLlVj4YBdIJta7Jx6sQPFxdab9Ew==
X-Gm-Gg: ASbGncugDS2vcHOlYyebJUjQR53hY6aNPpHhoCQq7ceAmSWee0jeVI76XCpSnEBpaHe
	aANYPyAYyYlr7ZXjrwQQ8dIb2HlheSdOe9YvPkeUZEZODSKZ2BKKFgvh0y3LSrAvQSZ1zNWHt20
	2YHUerfT/t1/XZm8jn5MEymytHZkZS2gWm4jf0slHsQTXqY9JUCFVcdtFF/fvAP0moIp//iCKXy
	kizGGjt36ugKsI3TQ==
X-Google-Smtp-Source: AGHT+IHKuGX2jcjK7CW2YUAF7pKBQi7lJi+f3JtU7wjskayoF+TL/YdXsZFZxfIG1onC6ArpMYTltcHn/C0yATQLfLE=
X-Received: by 2002:a05:651c:2141:b0:336:5d7d:f034 with SMTP id
 38308e7fff4ca-3365d7df730mr16346691fa.1.1756113237446; Mon, 25 Aug 2025
 02:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820164946.3782702-1-Frank.Li@nxp.com>
In-Reply-To: <20250820164946.3782702-1-Frank.Li@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Aug 2025 11:13:46 +0200
X-Gm-Features: Ac12FXxQ7gXxoDsxZV2IH90hiejwNDEjwFXUKgIGdSa3W_TRCsJ2jdxesORaDrc
Message-ID: <CACRpkdYCWymgFYenTbw5TzH+De103pwf35Bq_WjCkCPJ999Xng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: gpio: Move fsl,mxs-pinctrl.txt into gpio-mxs.yaml
To: Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	NXP S32 Linux Team <s32@nxp.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:50=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> Move mxs-pinctrl part into gpio-mxs.yaml and add pinctrl examples to fix
> below CHECK_DTB warning:
>
> arch/arm/boot/dts/nxp/mxs/imx28-xea.dtb: pinctrl@80018000 (fsl,imx28-pinc=
trl):
>    'auart0-2pins@0', 'auart0@0',  ... 'usb1@1' do not match any of the re=
gexes: 'gpio@[0-9]+$', 'pinctrl-[0-9]+'
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(...)
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  80 ++++++++++-
>  .../bindings/pinctrl/fsl,mxs-pinctrl.txt      | 127 ------------------

GPIO bindings mostly affected, so I think Bartosz want to apply
this one. (Else tell me!)

Yours,
Linus Walleij

