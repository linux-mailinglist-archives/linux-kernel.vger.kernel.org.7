Return-Path: <linux-kernel+bounces-801834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CAB44A89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181533AE549
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EBD2D7DCD;
	Thu,  4 Sep 2025 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKkfQf2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2F1A76BB;
	Thu,  4 Sep 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029590; cv=none; b=KK2ZsPu5hPV/NqXF1Sgm0i+HXLiCgu9Smtur9U8fWubAru/oNwB5lO4AK3cxurbcUx+W8fxvmHeU8Zm48TM9ApBUmmcqbJ0wWJ/OCZ3beoAlacA2SNoG+4ZuRt5onGChlX716qibnDlTLKUC/3XnPqn7MSXRqzfeBQ68H/b+5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029590; c=relaxed/simple;
	bh=i1kFtWy98vImxO8YkS1RH8GElz9dgakxtm96c9NmdD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9atK7t36C9C+xyR2diUHjs/xSXLe4epKl+micJVDeIwerPCZhH0oRwWa93G0gRPEBM9seIqndip7G6x0CSM3cNlHoGaFwY4MPrfya4taSOIeqH62wJAo7AoZuRyIezEEmS9vAxBFWZflprcbKbt60+Aw0ljsBc31aTEA7PG2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKkfQf2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F298C4CEF4;
	Thu,  4 Sep 2025 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757029589;
	bh=i1kFtWy98vImxO8YkS1RH8GElz9dgakxtm96c9NmdD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RKkfQf2F2iXVQnd3u2s1Vpw416n8APKIV+klP8CIlxhOGsrFQcEruD3e1jJY4TS/+
	 GNGL5Eu9fnKALGAGXmc5WdjSoiu8hGFxf2x23O9DqXuWXx6cVe/LbA1tYi9gx4qF6Q
	 czU4cIgWTR8ArAkIpF/IixIPcs86X65pelkr+qtHkVuvHOMK4jrRe3Hbu+ztl3JJ5h
	 KanIaXDpZKJxlwkPpx0yu/sA4jMVB/bnjB+JBIHXWf6I1ec0NAvs6I4iyGagAXaTMT
	 NSjZ8ZMiRKnAKWXYLtA1KwgleVv/iqKs3VLUU+3LRkiexc4IFhpBpLvRaExOIzB6RV
	 G5bHBnMLjOQCQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so2501926a12.0;
        Thu, 04 Sep 2025 16:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdpB4in2RG6KAeMisqCffBcI2P/JUAOwDorSIeU1ao7v1BW9rYQXvRrMnKZjbzbT8kMj7ncw0QvK+RWT8z@vger.kernel.org, AJvYcCXpZf5kOBUepYNIOFcw3FcrOfRK5Dzui/9iBkVU6ck00dRhX57MRsKLVki39a/xjqSgNC+7SaBDRUyn@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGMfBS46UG0LzV+3HBsB3HN5KveXsIyIkCdATphBv4hEjKFlN
	SjPWKaaT9oLAzunUpjNQrK0XrZ3ze6UZGsKrPZTEVd9baqkpVqbkBe6/g5OEEJbquWpsOvL5SIR
	Qd5aMzDK2VIrj976htpI/xYQVB8B0xA==
X-Google-Smtp-Source: AGHT+IEz5bRGq1Ef5wXJp0xhiW6NY7VImt7KxXjfQYc7qioU1N0YZwuPJSsQyLbbm0HDP2yexpCWjHdRGmZMKty8ZyY=
X-Received: by 2002:a05:6402:370c:b0:61d:1182:7679 with SMTP id
 4fb4d7f45d1cf-61d26d72ffamr19643711a12.27.1757029588044; Thu, 04 Sep 2025
 16:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805232502.2827725-1-robh@kernel.org>
In-Reply-To: <20250805232502.2827725-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Sep 2025 18:46:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQ_5X0STH=eSbjtkLkvgr+iPDwtLQYCntgiO8s1Dwy4A@mail.gmail.com>
X-Gm-Features: Ac12FXzGVurdBcMt-pBPjtPBNvxvRRQD8iIew05zyJeySdOtVRKk7OooxuRiu0A
Message-ID: <CAL_JsqLQ_5X0STH=eSbjtkLkvgr+iPDwtLQYCntgiO8s1Dwy4A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: marvell: Convert marvell,armada-370-xp
 boards to DT schema
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:25=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Convert Marvell Armada 370/XP based boards to DT schema format.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/arm/marvell/98dx3236.txt         | 23 ------
>  .../bindings/arm/marvell/armada-370-xp.txt    | 24 ------
>  .../arm/marvell/marvell,armada-370-xp.yaml    | 78 +++++++++++++++++++
>  3 files changed, 78 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx323=
6.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
370-xp.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell=
,armada-370-xp.yaml

Ping on this and the 5 other board conversions.

>
> diff --git a/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt b=
/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
> deleted file mode 100644
> index 64e8c73fc5ab..000000000000
> --- a/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Marvell 98DX3236, 98DX3336 and 98DX4251 Platforms Device Tree Bindings
> -----------------------------------------------------------------------
> -
> -Boards with a SoC of the Marvell 98DX3236, 98DX3336 and 98DX4251 familie=
s
> -shall have the following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armadaxp-98dx3236"
> -
> -In addition, boards using the Marvell 98DX3336 SoC shall have the
> -following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armadaxp-98dx3336"
> -
> -In addition, boards using the Marvell 98DX4251 SoC shall have the
> -following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armadaxp-98dx4251"
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-370-xp.=
txt b/Documentation/devicetree/bindings/arm/marvell/armada-370-xp.txt
> deleted file mode 100644
> index c6ed90ea6e17..000000000000
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-370-xp.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Marvell Armada 370 and Armada XP Platforms Device Tree Bindings
> ----------------------------------------------------------------
> -
> -Boards with a SoC of the Marvell Armada 370 and Armada XP families
> -shall have the following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armada-370-xp"
> -
> -In addition, boards using the Marvell Armada 370 SoC shall have the
> -following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armada370"
> -
> -In addition, boards using the Marvell Armada XP SoC shall have the
> -following property:
> -
> -Required root node property:
> -
> -compatible: must contain "marvell,armadaxp"
> -
> diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,armada=
-370-xp.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,armada=
-370-xp.yaml
> new file mode 100644
> index 000000000000..e65eadfbd097
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,armada-370-xp=
.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/marvell,armada-370-xp.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada 370 and Armada XP platforms
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +  - Gregory Clement <gregory.clement@bootlin.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ctera,c200-v2
> +              - dlink,dns327l
> +              - globalscale,mirabox
> +              - netgear,readynas-102
> +              - netgear,readynas-104
> +              - marvell,a370-db
> +              - marvell,a370-rd
> +              - seagate,dart-2
> +              - seagate,dart-4
> +              - seagate,cumulus-max
> +              - seagate,cumulus
> +              - synology,ds213j
> +          - const: marvell,armada370
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - enum:
> +              - mikrotik,crs305-1g-4s
> +              - mikrotik,crs326-24g-2s
> +              - mikrotik,crs328-4c-20s-4s
> +          - const: marvell,armadaxp-98dx3236
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - const: marvell,db-xc3-24g4xg
> +          - const: marvell,armadaxp-98dx3336
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - const: marvell,db-dxbc2
> +          - const: marvell,armadaxp-98dx4251
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - enum:
> +              - lenovo,ix4-300d
> +              - linksys,mamba
> +              - marvell,rd-axpwifiap
> +              - netgear,readynas-2120
> +              - synology,ds414
> +          - const: marvell,armadaxp-mv78230
> +          - const: marvell,armadaxp
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - const: plathome,openblocks-ax3-4
> +          - const: marvell,armadaxp-mv78260
> +          - const: marvell,armadaxp
> +          - const: marvell,armada-370-xp
> +
> +      - items:
> +          - enum:
> +              - marvell,axp-db
> +              - marvell,axp-gp
> +              - marvell,axp-matrix
> +          - const: marvell,armadaxp-mv78460
> +          - const: marvell,armadaxp
> +          - const: marvell,armada-370-xp
> +
> +additionalProperties: true
> --
> 2.47.2
>

