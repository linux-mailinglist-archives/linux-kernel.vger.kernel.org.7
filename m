Return-Path: <linux-kernel+bounces-894788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BEC4C19B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206D03BF1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F4313E15;
	Tue, 11 Nov 2025 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JS4l+i7O"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01322069A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845510; cv=none; b=MwbWIQLkonh1a+64R2KRDFysd3GMkaHsBAhFPIS5St/AYAjq7v3raYVRy46vpN7OpZF5TDp8L1MmSF7yh/oO6TsPbANrOtqIDt89ENtmL+rTh8/tnw1aFSQX56oQsr3FJvlBvY1Qf/9+bgM7Y49+Twqc1pbzdRsCBIzpfK8Jix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845510; c=relaxed/simple;
	bh=QjeAK/V1hSOIidYt60eVOijnzpDc5EzkM8SbDMhoEUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrzIIwNXNR77+W0A+4nqByuyrgLwZiabBq8MfbsJ4+2aUGzuji3w9Jd6jLMVdYm3Lglys5X2laD0EUpiJmlCRSm4vDyzMLel1wHoC8arXCIsj44J73xQu7IVlM1M+LOZ3Wqa9h3CmMa8mC8vXNiFE93UOR5KCam29npr0UXkEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JS4l+i7O; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6d13986f8so358500a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762845508; x=1763450308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DNECm8WO7Z3HdUuOFhmBYrNsRLb25kfzzIgggmDWEs=;
        b=JS4l+i7ObUbzkg89Yy1J16HnfJmHKWc/oCzaL8bNbup1eDcCo0K5n5Q7jyct/uFEkR
         E0evnHR7N5eryey1pQ89ErzPcuKEb1HYxJhQDENSve9JiNw8cjyDft/fqDafkRD3e9M2
         gBfIXzrA3aB3AWep1q93PNn0aH8ns2VToI0Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845508; x=1763450308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DNECm8WO7Z3HdUuOFhmBYrNsRLb25kfzzIgggmDWEs=;
        b=S/fKC3AFaXnqhkn3UsRH2oXYd6AlioG0gjYsjaSMIu/QFBq4t8padcrmrNBUC7WZrN
         OKjP6IsEe5krpfeRWwJUHqEeim4UZk+rRzSZCOPS59IlUXth4bS6ROAYO6P58+krrSv6
         +rFBkO63ynZPlCIDo2/h3lurXjeeuTYY9cfm+vB8ysKYnILWPn3iEC0N90Di8rlOWGMQ
         aaAaXnAh4547WI0IATXIWy0syO04q0G4bsY6c2aEQW5R1awbknYPclANkYg595KFv9OU
         eEG1kj89q5qwCdiXPfiAk2dJCQsA23ErO6JnvvOZQIhYK9t8p7grOV0BIcIVyenDqcX6
         lOcA==
X-Forwarded-Encrypted: i=1; AJvYcCWItfT86uAgktX4d3cSy2zI6Ovj5nevlw2OY79tjDjaMeCo+/DhMcL22m3LwJRlt0s58MsyPduUWVUdKdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyKwQaAPrNLWY8ai+0vpP7T0yE8T1qHIPAnybirve7GuHUIsr
	ycLU/9Vp2aKmGKkTvbI+PY3JYyvBVtPfdGYYl70gmbWsgQv5niQ4w7jitYTJANvEb1Sqi7PS6D9
	eHshWOkFu911B4sVt25g7Bsnp238fEKT6uU0koE8p
X-Gm-Gg: ASbGncsouL62wNqU440gIYl1ZPXxrWyFslhWUL15CpBPg16QxK+V+KktVY9fFJARarj
	HVfg91paSzMFSwNx27u3PB3KcMy3wBv68uQk8UvdBAGN4Po79ZoOU6RyELvF1Mzt0HB6C+7mrqJ
	+fI5zeFByvxWfdF2py3izzpt5eIv1aN3YRB5TAWWbFXT5a6HNByUs6TPCIuRntCcEi3/cVqsFno
	nclZ5oIR1VWTPyDqHxN4GHFlhLzqDtePqr5DYqr0UsUVWudLNRONxDwWfpZxZPOHX+CzpLxcmfK
	ClLatySFDGEQqRxBQM5LXp94JJZDuUDuwEXO
X-Google-Smtp-Source: AGHT+IGFmBeQ1KeQGhBdXMMah9cAVTlZPF7zYgIoM3d6h6tPzR4X9P4PbQV8tIudZI29zZhOnq3tZM6yeAns4b6eY+k=
X-Received: by 2002:a9d:7f84:0:b0:785:6792:4b3 with SMTP id
 46e09a7af769-7c720bfa5b2mr875905a34.10.1762845508048; Mon, 10 Nov 2025
 23:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093426.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
In-Reply-To: <20251111093426.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 11 Nov 2025 15:18:16 +0800
X-Gm-Features: AWmQ_bkDI05jvVfre0pjIY8zr4xu_0hzg8oICEOEmixXEUt8EEYFfI9I8Iu9sd8
Message-ID: <CAEXTbpc9=Gt7QrFrtV60+EvKdmBGsVpJxg7yYaa6HfuGGB3OqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: HID: i2c-hid: elan: Introduce FocalTech FT8112
To: daniel_peng@pegatron.corp-partner.google.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Nov 11, 2025 at 9:34=E2=80=AFAM
<daniel_peng@pegatron.corp-partner.google.com> wrote:
>
> From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
>
> The FocalTech FT8112 touch screen chip same as Ilitek ili2901 controller
> has a reset gpio. The difference is that they have different
> post_gpio_reset_on_delay_ms.
> FocalTech FT8112 also uses 3.3V power supply.
>
> Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> ---
>
>  .../bindings/input/focaltech,ft8112.yaml      | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/focaltech,ft8=
112.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/focaltech,ft8112.yam=
l b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
> new file mode 100644
> index 000000000000..391825b24fcb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/focaltech,ft8112.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FocalTech FT8112 touchscreen controller
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>

List yourself as the maintainer of this binding file instead of the
subsystem maintainer.
> +
> +description:
> +  Supports the FocalTech FT8112 touchscreen controller.
> +  This touchscreen controller uses the i2c-hid protocol with a reset GPI=
O.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - focaltech,ft8112
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  panel: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vcc33-supply: true
> +
> +  vccio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vcc33-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      touchscreen@38 {
> +        compatible =3D "focaltech,ft8112";
> +        reg =3D <0x38>;
> +
> +        interrupt-parent =3D <&pio>;
> +        interrupts =3D <15 IRQ_TYPE_LEVEL_LOW>>;

You have an extra '>' here. This should be caught by `make
dt_binding_check`. Please check [1] and [2], and make sure the patches
are tested before you send them out.

[1]: https://www.kernel.org/doc/Documentation/devicetree/writing-schema.md
[2]: https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-=
sources-with-the-devicetree-schema/
> +
> +        reset-gpios =3D <&pio 126 GPIO_ACTIVE_LOW>;
> +        vcc33-supply =3D <&pp3300_tchscr_x>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddecf1ef3bed..69f54515fe98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12326,6 +12326,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/dtor/input.git
>  F:     Documentation/devicetree/bindings/input/
>  F:     Documentation/devicetree/bindings/serio/
>  F:     Documentation/input/
> +F:     drivers/hid/

Why did you add this?

>  F:     drivers/input/
>  F:     include/dt-bindings/input/
>  F:     include/linux/gameport.h

Regards,
Pin-yen

