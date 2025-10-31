Return-Path: <linux-kernel+bounces-879769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207CC23FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1154EC189
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAEA32C93D;
	Fri, 31 Oct 2025 09:00:52 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741532C305
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901251; cv=none; b=KLD1shzSwYYRq+AwYfFB6BbB3a9BZLQNZ0Ph7GIgmskQxdsCl6DZN57zvxqZSE8KypwiO6RGDYZBcJkC9JP6CcNaFaqRES93/kPDEzINAhEZOolhO+TNWOx+PN/dHBmoENMfLObwfBgfQt7RyGimTWuFu3mRnHZFwP49uNpUM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901251; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH9DKe+r3/krHzIV9iRUoSCvrLMpTWCRlSJQlutNOvyC6lTJfIM/tAHUcU1rSSsOa129fJV7+Xu5yPGC3GzvpxRs7j2NE8rK1mPJL3kTvoDOBXLVHOqGjRUlYvPF3+viU8EKnKRKqjUvxfCxD5EfgjjrLHlaten1xOUdcPYEa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89ead335934so201682085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901249; x=1762506049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=rL/Mc5VuByctAeSExWXF5awKqPk0G4JIR0Pk80ade+NfiwFYR1AB/9Z7lKTku4uvUJ
         7FAqh0aZM027LBg+PQyyM3MhArDQMF821AqKnKGSuToiSrCccc4EV1NjUF5+7ejqyCQ6
         ZilmW129IteLmb9XdjQqtQH2HtUKiPxLLC5owBCMgolyUwTYKQoFh4ejTJzESKUIAvuj
         4YVrAbQqMZm8J0VLRb0tfT+juJRCOxDeVAk2fnRZ2misLMWZMIH5pWEkRBVfrdwsk3Vz
         Ybsrhxxw4xzXSOiNosj8zKcwRUQjE054LvLWszdrA2bkNjgnbfJVFllewRUpBIkSUJnG
         hBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU45AOm3w86lnz9NgYZfhIK+8MNjD0i/jfLDkpmZGtQPb4pDVuKMa/0aj7BGZEbcK9q27XUHr8huTmGczs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTlEbfAeiUmT4yiVQ7CX3li9yuHF2TdW22I0gCRko4LQhMlXT
	OpDIp5HpcYDDrgcxRpd4LV18hEgjTP84zORQpzBk421tG4pfHmaSoha/qvc2gvkJ
X-Gm-Gg: ASbGnctIPoaTj0uTWmj/PQTVgB2mwSaqtoEXk6o1Ec5rxp11ErJFjaDC4SndUFlcoLk
	v6P+P1UmfQEWaQZaxiDg6cxzVbGIziRbMYKX+D/0seOF9RsHgvV7OUVEmLGUc9X7VpcWV2olyWl
	VgY7KsyqzG3yPGsCqqLllrom3AmBvom6ATHz/3QvYg9FTIoJfvCsJxCdxoZeI2GxYdDLJaIQIp1
	BJE3J9wpdwPYVSSz6zA7t3aEZL5I45tDmBZzp2LS7KVZ03hLYe0uSHZxTGdTEE65SJrsUSeA0cr
	F6BauYi06416HcVNbf6TMYk9xwe4zjNctnr2Q456JFKd8R3vaWJdXgyeJ3cdvULS5S5IQBJ2KQu
	k1NxMyS6SADlTPEehb/biEnAqlLV+Ng7mHFpY3yn8w2BNz2wepes/x6kwGbi7fMHSPqqqe8vCdh
	ky6l/j7rzwgljdC74NKBoV0Do+6ZzadZ6g8sThJBjAZeaOhHGVkIT0rlqj0/M=
X-Google-Smtp-Source: AGHT+IEy4dI3g4hqSC7z7tx/EjqSZS2wVyElxBhGDIrPH3XmFTHra/dDJTGKvm92y+hCY1ZO9PJO5w==
X-Received: by 2002:a05:620a:1906:b0:893:1370:308a with SMTP id af79cd13be357-8ab9bb6e88amr295726985a.87.1761901248449;
        Fri, 31 Oct 2025 02:00:48 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00c86313sm76100385a.15.2025.10.31.02.00.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:00:48 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78f30dac856so23116726d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:00:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhv8Nt2jSZMGwunRfgfAH8tdzR4vm7WQ7TvUmKzv74p4jxid62/6kU365Wf9EHCM5hJhtGYbTn3RtRwd0=@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

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

