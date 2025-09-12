Return-Path: <linux-kernel+bounces-814018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFECB54E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986BE48008B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734A302755;
	Fri, 12 Sep 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnDuceut"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E42FD7BB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681083; cv=none; b=iTM16XLnoxdkP7uW0/tPNI1x6Kt/polEhL9XdPeLGVrSxobKriD44+osKcFrLGxnrmBhFZyqJtNj/uWrpLXx5xz6vOoHwtyj7neuobtN6R+dR9P3iYTAoCNUsob0ASMvekMD7NmXcexjz76HTpY/dUAtPOa8HBMILwEFSl2fUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681083; c=relaxed/simple;
	bh=NXr6761UnhNuatR0gAI5tVaJNfUBA797kNPb6NrQOPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXA/C0ZneQiSPhY5oiZAWxSQIwZP60WDswE3mRXEIPpaR1Gj76lZI2kmswJcJRpvpBhV1KJoAIb7hUFMnsjNM5OkC0yik6XnAqBn7inLe0gp7meZBizXScXOhWDU2gaKiCZajjcHUNKONtaWggkoEOu3Lupt3oHSKNETCy5ejuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnDuceut; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F554C8EC48;
	Fri, 12 Sep 2025 12:44:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 614D760638;
	Fri, 12 Sep 2025 12:44:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0B03102F29BF;
	Fri, 12 Sep 2025 14:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757681077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2b6HqIAwNVuz6HRHHTPZk9huV16GAiHxG1lpPMSNBlI=;
	b=GnDuceutqH80p8LWOeAakA2FLIXSNBXHGWu/zEJp6N6tBXCPD/mv94P/sjigfLv1q4Qwh+
	ZfqvlXpf3D3MsBxq1ed6GOWBN6zUG0aUvyIi4hUTxONP7ztiDddSsq2bE+K/XX6kLbJyuI
	cBxe+S/bpNpLgGRZl9ZyejtrH24TXRiEFroO+4GIp/EE9LfviWCRcQs2Vi2E6IflEvc75k
	/YCrPXzGcfJCmjtrCs3PLU1q+Bk4GP/zW7QlHQy+zMTNOviHdIqWbMvvBNa3SBTYejBQPa
	Hc74fvQjOMsmOK7MqS7C5wPvtU+j7qJQQCrM3NcKLHI0HaWqu5Wncf5/dFIihg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: marvell: Convert
 marvell,armada-370-xp boards to DT schema
In-Reply-To: <20250805232502.2827725-1-robh@kernel.org>
References: <20250805232502.2827725-1-robh@kernel.org>
Date: Fri, 12 Sep 2025 14:44:25 +0200
Message-ID: <87wm63on6e.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

"Rob Herring (Arm)" <robh@kernel.org> writes:

> Convert Marvell Armada 370/XP based boards to DT schema format.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>


Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

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
> -Boards with a SoC of the Marvell 98DX3236, 98DX3336 and 98DX4251 families
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
> --=20
> 2.47.2
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

