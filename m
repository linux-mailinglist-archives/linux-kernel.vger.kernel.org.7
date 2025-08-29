Return-Path: <linux-kernel+bounces-791176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE368B3B2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3782F4684C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB7221F0A;
	Fri, 29 Aug 2025 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="L84ZwrlF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BnAmXJvT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4E8BEC;
	Fri, 29 Aug 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447610; cv=none; b=kesALwtCPKOVzyh2nRa6jUvJ079YW2B+wcRgoGRtCWPhT734GwqHFBDbR7J4fL/beqF8CDczpyPgdFKq+4AVKFaa5uHRxtsXLNGn3Nec79lFfQLIg5Z5o1x2L7TyW+cos+MvMy6rA3Za8eqHXJR0WPavqolg3xxLBgN4q4RCLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447610; c=relaxed/simple;
	bh=TapCIJzSpA5xsrH/nOaLl1kb+dAxgoIgKv6bTlhCBH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSbxi5imuDzynTp1whOp6GD2VE8ImtjIMWq8r8o2hD0hBYBg9BRcnTuYPWjabN5zDKyFQ31uTj7tyG2W0iQpDKxc/XtUuF6Xq0Ssi7W6UbQJ3u9HvzyYEwZ+xNKVaE374HXwvnMpxy3EQCZe6gnUO+mVKm4mAYFtWg1CDN5wHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=L84ZwrlF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BnAmXJvT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756447608; x=1787983608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yhSoS2gcwCfK6pxd7ltatSsRlXZ3B4ZnEmWhPcw3nIA=;
  b=L84ZwrlFqnqSUTctfOtqHxla4LVmjYcSVsfbO5e9utn73wLR2fsTX1qV
   NYbg5CXOgk3B9Bw36ZsW5aR1YhBUCvu4XonXxHqjoC2+SQJyL7ZkGPe3S
   9ZhNGSNoTqE7CRS2HdRTypj67bdAT2mV3AyvWxHUOXzO6eoc9crtKEmhY
   XSCzaCkpUViqFtGxqrpEp+nyams9hJD/cUe5UVJGmDSIFTVdGWGTVfajD
   X2BtAiqJ6iNTELghvZS5EZTSEGqKawI0hBDJPbcYK80abiXeVkUeKYgBw
   ePz6TA5pwFUkoACXzH/uHyT4f4xdzerOC6JVmsh9kGSleVIjYy9dAmhMA
   g==;
X-CSE-ConnectionGUID: Vx6WPkHrTJSNijI9O2t94w==
X-CSE-MsgGUID: sWq7ec2xRmqgqmY0djflPg==
X-IronPort-AV: E=Sophos;i="6.18,221,1751234400"; 
   d="scan'208";a="45969065"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Aug 2025 08:06:44 +0200
X-CheckPoint: {68B14373-29-299FBAB0-EF52EDE7}
X-MAIL-CPID: 9E8933FFEF0FDFBC4AA31CA6DAD71FDA_5
X-Control-Analysis: str=0001.0A002121.68B14308.005F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D34CC169B29;
	Fri, 29 Aug 2025 08:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756447599;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yhSoS2gcwCfK6pxd7ltatSsRlXZ3B4ZnEmWhPcw3nIA=;
	b=BnAmXJvT6pIpazDfP4tZLf4m0fzPhp0SQXYsg1a3Pl2D8tdLNl1AMcHdJtUiXpGzgha7Ih
	in1Cc5Y3Yy2h1rhRffhLOTn9mIsAxuqcUTaSD3fxLXfN6bQivBzNWILv8ANGvXHaYwx2Lx
	BkeRS48++WZ7DqDHKUJJDWZcadWauIJudHWhhOYkFNbULhnChu/DHVXKclXbrLSo41AHXi
	+eLeLA4EOWEf4o/37km2aKDJWG46f5FFzwQmLFfdFbb+4I1NuekKxDJGWuERlj4NTy5ETb
	5cSfHD47omfor0Vx1BRsrbS4G4LpnP9Miq67c1wv1EOm5u4eCnQT2AalSw9Rpg==
Message-ID: <47a8152b-85cf-44d9-b94e-29e3f462d507@ew.tq-group.com>
Date: Fri, 29 Aug 2025 08:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add TQMa91xxLA SOM
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
 <20250828094745.3733533-2-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20250828094745.3733533-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Alexander,

Am 28.08.25 um 11:47 schrieb Alexander Stein:
> TQMa91xxLA is a SOM variant in the TQ-Systems GmbH TQMa91xx series using
> NXP i.MX91 CPU on an LGA type board.
> MBa91xxCA is a starterkit base board for TQMa91xxLA on an adapter board.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---


Your commit is for TQMa91xxCA and TQMa91xxLA.
However, the commit message only specifies TQMa91xxLA.
The TQMa91xxCA is missing from the commit subject and message.


>   Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ebafa6ecbcb64..0843c5e9275be 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1433,6 +1433,24 @@ properties:
>                 - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
>             - const: fsl,imxrt1170
>   
> +      - description:
> +          TQMa91xxLA and TQMa91xxCA are two series of feature compatible SOM
> +          using NXP i.MX91 SOC in 11x11 mm package.
> +          TQMa91xxLA is designed to be soldered on different carrier boards.
> +          TQMa91xxCA is a compatible variant using board to board connectors.
> +          All SOM and CPU variants use the same device tree hence only one
> +          compatible is needed. Bootloader disables all features not present
> +          in the assembled SOC.
> +          MBa91xxCA mainboard can be used as starterkit for the SOM
> +          soldered on an adapter board or for the connector variant
> +          MBa91xxLA mainboard is a single board computer using the solderable
> +          SOM variant
> +        items:
> +          - enum:
> +              - tq,imx91-tqma9131-mba91xxca # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM on MBa91xxCA
> +          - const: tq,imx91-tqma9131        # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM
> +          - const: fsl,imx91
> +
>         - description:
>             TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
>             using NXP i.MX93 SOC in 11x11 mm package.

Best regards,
Max

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/


