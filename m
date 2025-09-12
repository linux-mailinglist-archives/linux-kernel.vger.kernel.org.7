Return-Path: <linux-kernel+bounces-813356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2224B54414
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490883BD3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E32D0C8C;
	Fri, 12 Sep 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsRhFjTR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2732C11C2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662795; cv=none; b=bIvUkZszHIfYBEjtz8kyLZUfOSrNg1+QJS238QbF2Dc2oiEe5YQAUuKYxjkcFpAtaIolPAJBVCE79zxeyTdKmG0/G3107bYP9fR+I4j2sitXSo7U0twUS1Q1m7LPCmRiPeAsqX5BKuSor3RnzheqLSXC9cD9gRoO9SFschbwyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662795; c=relaxed/simple;
	bh=VwXrMQmeb6YOlGFRyv2Gir/TZzEbOleCGYGL2ayKwvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdaEwg4cC2mMTLbJGE0Wxzqf3sYFay8wrU50OfbFVfVRSdOALD3G3RiV33W2apKWRcemY4NefFgkdw7wAo1MvJoj3plN08ExpWDIXVXLFEtqg/ZT8hdLGoL94CFkL2WsCkaRgrIG0t28Fa7l3jmNVZK3Yl27+hMItjXXc8poZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsRhFjTR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b071e806so14292411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757662791; x=1758267591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyNm+tCozG9qC/jzXWhOIDRR2bJgq3G4UbsBRU7rbeo=;
        b=XsRhFjTR6HTXooCKjW4IPEICJ9p3XcMkWVnwMDtNwNvSgfB5/+TjdbwV2ntNSDfJTo
         iUa3hlO/BZP+HLur8LEGvh+t4gkec+VkK4GROXp/Aym0ZXVbtvltYdy7uH+vocslAXfZ
         NhQwLB1fI/8agbXXCmfq1qIDI5jRZIhaEGnHFbP//tzIuy1lvNaw0zCBcmnvVa33WOYm
         tG4BvlVQ/yH81rw0Ye7MC4RlqXg8rOL0mFOlozOD5krHkn2ARyVzO9VNKCyDcxsb5/J7
         1wgp5JNda4nZKvKcxZXkv/JcpN6bstteVU0iOJLyW8uM7A80j4YNGCaGxwz8FDXNE+3T
         4+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662791; x=1758267591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyNm+tCozG9qC/jzXWhOIDRR2bJgq3G4UbsBRU7rbeo=;
        b=rXfxtqxBkIXb1DR3EoWXDbge9P/Q01G+lPewkbFIfCDB9gFNEJLNOA2KQPEeShYVGb
         Dw9jZiAo0HA3eEyAqLuOLYSIW1+i97nTRJ7qeYD8BGfMnTBgqdOZTclPCg8tuptcb1m2
         tQPxDMatazeOLqEqdlEdwX7BDWTUGMKbxDYw4fVk1qoMO6POOzWBKSOYYxPPQX+LVgqL
         Au8rYKNr/266tBGOx8UBS58RCfOBdfNzTkLJgWpsraJ9w0RLvc8xrlWaFd4xDoq/ML++
         T/8acwX3WNb4cGKrbltdj+ygTwggrvyqEwNtr32YZn4EctjU8GB22AZtuO1AU0Q+4nKt
         nDkg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLoZ41Ng1TsdJLLcLWT0DPFy9UtUSuxghAUXV1D6AmTjJ0ANyFiaffFYBRrD7bV1JhRWSca4R5hJFjUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8NfFFAaXqFFCLsbOy6dJqqcLtedytxY/7OOvghSlxQvbMdQx
	20rizXzhNOhJwkSYgL/BWC+AuU6AdetvSJHdT3pXHq2Eoz2tysN7ZrmMDJ31h3pjPsGEspNYJqp
	rkXR4fUVy1pmRtqlILikj1A1zMU8U+vxr1X3bniD7Cw==
X-Gm-Gg: ASbGnctUVeM3nyYZ4BHKi8KTp4JmW2UTjFZqUeBSwzVufpAf6zB5crL51zruw3IWx/i
	nEp0+14P5hjd94CNgjdQXy/M/tlSi8AzmG9pJww09xdjr1y0f9ubLSaKsywhw8PfI6iPJGZgl9u
	NMe3UnF/ruMH223C6EUAyIZR1g6UbHjEj02Cpk38AMrkeMDxWLAMN2hvniprkL+ohHnVzUTMC5R
	K64by8K7b9zZ3Ki3w==
X-Google-Smtp-Source: AGHT+IFXhI72vA/Xl1/pwftRCAsBnAJuIIqpKbZ1iyqRFZv+GhkiusAWIrKwOOg8AJLBaWAuYGw0FY79HwX8vz25qic=
X-Received: by 2002:a05:651c:20cb:10b0:336:cf86:d40c with SMTP id
 38308e7fff4ca-35140baca49mr3560901fa.39.1757662791293; Fri, 12 Sep 2025
 00:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912060650.2180691-1-gary.yang@cixtech.com> <20250912060650.2180691-3-gary.yang@cixtech.com>
In-Reply-To: <20250912060650.2180691-3-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Sep 2025 09:39:39 +0200
X-Gm-Features: Ac12FXwf3MTYvZ4rNhkqF-Rzzb6ggnJzjTZergFSHBamVYSApC1yF4VRUAQLrOE
Message-ID: <CACRpkdZKW9Pn4qJ_Fq=-VFk4KJLmoBqsNooU8bhLE1K4F7STtQ@mail.gmail.com>
Subject: Re: [v2 2/3] dt-bindings: pinctrl: Add cix,sky1-pinctrl
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

thanks for your patch!

Overall this is starting to look good.

Please make the bindings patch 1/3 because we usually put the bindings
first.

Some comments below!

On Fri, Sep 12, 2025 at 8:06=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:

> The pin-controller is used to control the Soc pins.
> There are two pin-controllers on Cix Sky1 platform.
> One is used under S0 state, the other is used under
> S5 state.
>
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
(...)
> +# Client device subnode's properties
> +patternProperties:
> +  'pins$':
> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      '(^pins|pins?$)':
> +        type: object
> +        additionalProperties: false
> +        description:
> +          A pinctrl node should contain at least one subnodes representi=
ng the
> +          pinctrl groups available on the machine. Each subnode will lis=
t the
> +          pins it needs, and how they should be configured, with regard =
to muxer
> +          configuration, pullups, and drive strength.

I'm not sure the binding maintainers want this info here, if the same is in=
side
pincfg-node.yaml, I would just skip it.

> +        $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +        properties:
> +          pinmux:
> +            description:
> +              Integer array, represents gpio pin number and mux setting.
> +              Supported pin number and mux varies for different SoCs, an=
d are
> +              defined as macros in arch/arm64/boot/dts/cix/sky1-pinfunc.=
h directly.

No reference to arch/arm64 in the bindings please. Just
drop this.

The bindings are used by U-Boot and FreeBSD as well so these
developers will be confused by any Linux-specific references.

> +
> +          bias-disable: true
> +
> +          bias-pull-up: true
> +
> +          bias-pull-down: true
> +
> +          drive-strength:
> +            description:
> +              Can support 15 levels, from DS_LEVEL1 to DS_LEVEL15.
> +              See arch/arm64/boot/dts/cix/sky1-pinfunc.h for valid argum=
ents.

Same thing.

> +
> +        required:
> +          - pinmux
> +
> +additionalProperties: false
> +
> +examples:
> +  # Pinmux controller node
> +  - |
> +    #define CIX_PAD_GPIO012_FUNC_GPIO012 (11 << 8 | 0x0)
> +    #define DS_LEVEL4 (4)
> +    iomuxc: pinctrl@4170000 {
> +        compatible =3D "cix,sky1-iomuxc";
> +        reg =3D <0x4170000 0x1000>;
> +
> +        wifi_vbat_gpio: wifi-vbat-gpio-pins {
> +            pins-wifi-vbat-gpio {
> +                pinmux =3D <CIX_PAD_GPIO012_FUNC_GPIO012>;
> +                bias-pull-up;
> +                drive-strength =3D <DS_LEVEL4>;
> +           };
> +        };
> +    };

This looks good to me, I don't know if the bindings maintainers have
opinions on the placement of defines in examples.

Yours,
Linus Walleij

