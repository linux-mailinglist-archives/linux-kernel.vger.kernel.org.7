Return-Path: <linux-kernel+bounces-744063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6EB10798
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DEBAC0574
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B240263C91;
	Thu, 24 Jul 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="M1zSPh/+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="C1LqdSyf"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D42638BF;
	Thu, 24 Jul 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352320; cv=none; b=d618bHWjtDIDCqw7cSUIkAy0s63whLzYuqmqU1FEQ9sJ9Q2rFEowRWdY96yypttvWSdkj630M3fVx3K22lonfD9SxQ+vjU6hPf8zscDdGIFoM6vpSjdRX4OmiemnBCpyx+xP/99yPXT/oN5XcCDYu6tLUM7YTyHULMFVgAa0Fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352320; c=relaxed/simple;
	bh=JLkLYAH22NWgewI322Vrwpot7jEz+TvDPcHtEM57dY4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blbRC3VdRbgGe3dwmEPPRQDm+4cQhvcbLxPfXj/GUnsQlgP8yI87aZXhuDmXUPV7qVGqNtBY3W9qmNad0/LQwVU8lwOKdFF6+4n+f9mLaWh32w2Fm5AUeAoWcG6xc0DtaB/En3LiL5RVv4593fRqLU5rBJItkkhfaIXYCAxf0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=M1zSPh/+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=C1LqdSyf reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753352317; x=1784888317;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hiOv6C/osTxNoBk72SCJemyk6qpcTT9EtOlEQ172ii0=;
  b=M1zSPh/+kXUfMyq6XzS+tFqfoV4nAvtXgrapB78P0X1r142tlxUPalyn
   BmGqDu3+Al7ggwplgbaIy2ccy4zacUoYZdubC0RQW1AoDj+ZdU0neOlnJ
   GCPI9vfqCRlJuipspShp6cfG5H31LrEa0pvaZRrEfgjEGnmkxeSXK3WNE
   Ve3I2/8rhrFIs8PIEU2aHMqOfiVE4mHHT3D2uz0UIhp6U5ZqO/uCfpJ5R
   hB408xOFamfpYGQpI1NdbzHfQq+Se7yYKpg/7Ez73NXpVcfK3ip0/MA9E
   ubfyvM78OYQ6shV98u73NCR9CoWZasDDvDsJx6uXb+sNlzh5yT40NvpGj
   g==;
X-CSE-ConnectionGUID: UuHEozAeSU+hDFJUEFRMjQ==
X-CSE-MsgGUID: UEqPGTtkSUqZZKPgemzn6w==
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="45397445"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2025 12:17:24 +0200
X-CheckPoint: {68820833-41-FE216C80-D1ADDD01}
X-MAIL-CPID: A07D5907D5C628A30C31B649D2719C0D_4
X-Control-Analysis: str=0001.0A00211B.688207DF.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A755416829F;
	Thu, 24 Jul 2025 12:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753352239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hiOv6C/osTxNoBk72SCJemyk6qpcTT9EtOlEQ172ii0=;
	b=C1LqdSyflPIbcD2U9v4RWxYpSFTyQ0p3JRnY1O/JHfae1FTAqA+O+uFGg0GYv4Mo7vF3RS
	2F8VHf71Uqfq49G8djYxfcbV+ow2tsIjsxhXjbPHbkJhBb1J7LOh/qozDYIEcGyam5XKbw
	2LHyBxBAljMFbZ0G6IP1j/GhQFUmVV0ugGO9i1yzBiptQbNuecGejBP/hDm9B0taef2ikw
	R/pOalXQ7/dbdUdgXSIGT47FurwqKiwjtonHR3HfA10BMSl4QthQtSD8UfzZYyYhB3pc4Y
	17WQApXH9KtBg/yYm0WL34Y4eSgxd9qvfc0+U9Zlf52Q+2KAusTJyBbqFF1tpw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: mathieu.poirier@linaro.org, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..."
 <arm-scmi@vger.kernel.org>,
 "open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..."
 <imx@lists.linux.dev>,
 "moderated list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..."
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 RESEND] dt-bindings: firmware: imx95-scmi: Allow linux,
 code for protocol@81
Date: Thu, 24 Jul 2025 12:17:17 +0200
Message-ID: <2793923.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250718094723.3680482-1-peng.fan@nxp.com>
References: <20250718094723.3680482-1-peng.fan@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 18. Juli 2025, 11:47:22 CEST schrieb Peng Fan:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> BBM protocol supports a single power button, supported by driver
> imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritt=
en
> using linux,code. Add a reference to this schema and add linux,code as a
> supported property.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> Resend [1].
> I not see a reason that why this patch could block i.MX95 remoteproc supp=
ort[2].
> But to speed up the work, I took Alexander's work and resend it. Hope this
> could catch 6.17
>=20
> [1]https://lore.kernel.org/imx/20250513-whimsical-almond-quoll-e3ad5b@sud=
eepholla/
> [2]https://lore.kernel.org/linux-remoteproc/PAXPR04MB8459A0F330554EB69E99=
0E048850A@PAXPR04MB8459.eurprd04.prod.outlook.com/T/#t

Thanks for resending, I lost track of this patch and though it as applied a=
lready.

Best regards,
Alexander

>=20
>  .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml   | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.ya=
ml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> index 2bda2e0e1369..7a5a02da2719 100644
> --- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> @@ -24,13 +24,19 @@ properties:
>          const: 0x80
> =20
>    protocol@81:
> -    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> -    unevaluatedProperties: false
> +    type: object
> +    allOf:
> +      - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> +      - $ref: /schemas/input/input.yaml#
> +    additionalProperties: false
> =20
>      properties:
>        reg:
>          const: 0x81
> =20
> +      linux,code:
> +        default: 116  # KEY_POWER
> +
>    protocol@82:
>      description:
>        SCMI CPU Protocol which allows an agent to start or stop a CPU. It=
 is
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



