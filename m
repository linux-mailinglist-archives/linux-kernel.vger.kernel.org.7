Return-Path: <linux-kernel+bounces-846257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4FBC7684
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E30E342DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2D261B62;
	Thu,  9 Oct 2025 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4e7agll"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53824339D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986746; cv=none; b=hozBmRUPySqo2wDXgF3R/Mau8ZhycSed2wzW8k59uC9e4bPQ7WKtnQJEA0tflNVeXB/98PC5evu9rwuJKF32gjd34zUVjOukG6KSPhY/WKm9N298D9EP8JOxDou9FIvmyDMcW/RV/2xAZyDSLpKylHNuhWAaI56CZ4//eAjwaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986746; c=relaxed/simple;
	bh=g69ct24MmjxArPvb4htIE2j+DUcuAxYXbKaKt9nNwNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J22c/Z2NJWU4kJD/MOl6cHFm0zvzba45lpe+sH6vtXBntB9ZFLhrC3vNOWEvbmmJ79JEWyplBVqXeYaAOtNOetyHKwFXL4eYjzW0DByt1PXJPcWYl3Pr5L95EYCI0CMQClXG2IlvZIn582sxz4lnmUdUO3RoSs0BRajquDWiWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4e7agll; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso4517605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759986743; x=1760591543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAc4vwDFuA0RvRFYPmaQPlYUcz1xA/Dd48r7PtXPvic=;
        b=E4e7agllQnLM6hFBvGfLWoi/8M+39pIb1nkfi5LO3p+AxVNHgLR3GbCculbNlqweyb
         4csUgn9whveHADhFW0tUQM9mCbCOcCK6H6q7uInewWjCoOXIqxDYzSO5FyOYIadOWBBC
         9PyZ467fiM+2RJUi0rrIUTwVkf+QbHnmn+EXvQUjbwD4XHDRN+fO/VmWhunTjNK3ZZLG
         0P72nmZo1zatv4WJd+GMDiFFNY33N/KbfJG/7KB4nEJe4HSU7+GKkVWy+SEwTa6FQORx
         Ye+hZboIXtSW8y7MHp5jrGq1aKr7qk0EGQch15JzDrYsq6Le0rMB1csCg0FvPfyJktNT
         Tjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759986743; x=1760591543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAc4vwDFuA0RvRFYPmaQPlYUcz1xA/Dd48r7PtXPvic=;
        b=JnlDukdfERHcLbMkMastsOe0Q68SfvaARPSNAbt44N9FiyhxQvCD4nf6VEkGoPuweS
         WDZhSxKhdqKkiRQqxyYHEIv2/c83Oyuzy4C7V2V9QDjDummEXT4G/9SBz5+GPtN6H8uG
         aR1IqWdBRfBC/wpsJCbCW1pXidUP/DGVEnYzrb4OmK3YPBJcqZOoQzOHfZQ4MWSZhN9+
         nBn1RwlTFRd2h4DzVhRnlzQviZjVdlO6RjqumdsrikbVHFeBnc/BLjxUHI8NO/qyWTIE
         Wf6UK6q5Du3X1oXVd/VLs1l8I7n85WwlztVKXNlZu5dwZoET2Yv54IEjMRloKSl/50Yj
         0d6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+EXVhZrq7jomT0GN+I0SkBsEinklDQxOF1OYSsggynkumEGkFkvf96oJFyyJtQttdImHCSVWDTZC/IwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mRInKh8yrqQdpVGaYcLIsVVojfJZY4iepphEJk2D9QtWAS95
	PjPap1F8XrqIUM7LA72uXUxTjEmRcofIqJOFi7r4LvbZBuMD759e0DktEj81yvQbKSH1x1kmxnF
	XhEbEoXvSWi/09kdjLr6Qs0LdiFXPJ+Q=
X-Gm-Gg: ASbGncvO0hQrFIXI8NWflwFw/ERSDwwFbEQZHH++9wbdLAQQFLAKH80yBK0ltv4l2KT
	0d+agR79tYyj2KOHN4N/qllXuOhWIfxhg2EO6Vk/A2oLYmP7l4IAuX1gPhQWv92hJTrPwIm584J
	ngZkDCKeNn9zstWlKj5OOXPvyxkwHRdMUmv8yIKk6cSbgwEhV2LeV6fLtIHDrzkABL+MlYrz01j
	wZd0U+JlOO1wtiwUOIhPhMF9tPfvyHc
X-Google-Smtp-Source: AGHT+IHEqPFGpsLkjdTJExInkzeCUrYeoBDzsTotN3s9CHFAoYRfgbeWdXnEHXE7zwgYrarYKck5hazoT/ajbub9quM=
X-Received: by 2002:a05:6000:1a85:b0:3eb:60a6:3167 with SMTP id
 ffacd0b85a97d-4266e8f7f02mr3364005f8f.32.1759986742670; Wed, 08 Oct 2025
 22:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008073046.23231-1-clamor95@gmail.com> <20251008073046.23231-12-clamor95@gmail.com>
 <20251008-craving-composite-81aa70b6e882@spud>
In-Reply-To: <20251008-craving-composite-81aa70b6e882@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 9 Oct 2025 08:12:11 +0300
X-Gm-Features: AS18NWCooDACEZg9v1dc4kKxxOAalz7xHeMkJMNqgQiJE_XE0BU4PgbUW_JYKFI
Message-ID: <CAPVz0n1OEA=WHTzBtVBLQ=6vTAwG_uP1tC3Vbrb67wZDUtyVYA@mail.gmail.com>
Subject: Re: [PATCH v4 11/24] dt-bindings: display: tegra: document Tegra132
 MIPI calibration device
To: Conor Dooley <conor@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 00:14=
 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Oct 08, 2025 at 10:30:33AM +0300, Svyatoslav Ryhel wrote:
> > Document MIPI calibration device found in Tegra132.
>
> Could you explain why a fallback is not suitable? The patchset is really
> too big for me to trivially check that the change is correct.

First of all, this compatible already exists in Linux kernel, I have
just documented it to satisfy warnings. Secondly, each Tegra SoC
generation has unique set of registers which should be configured.
They all differ, hence fallback is not suitable here.

> With an explanation,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml  | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra114-mipi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,te=
gra114-mipi.yaml
> > index 193ddb105283..9a500f52f01d 100644
> > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-m=
ipi.yaml
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-m=
ipi.yaml
> > @@ -18,6 +18,7 @@ properties:
> >      enum:
> >        - nvidia,tegra114-mipi
> >        - nvidia,tegra124-mipi
> > +      - nvidia,tegra132-mipi
> >        - nvidia,tegra210-mipi
> >        - nvidia,tegra186-mipi
> >
> > --
> > 2.48.1
> >

