Return-Path: <linux-kernel+bounces-774896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D976B2B8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3122524701
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591C21D3DC;
	Tue, 19 Aug 2025 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IPSkTInh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GWS0n9tp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C219F135;
	Tue, 19 Aug 2025 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582395; cv=none; b=O/QdSuOU4ZnVP9gUFzoiLI0+zzoIKgQ/zGzYAMnxAacI6NxaGt01P0asHgWpZ4Qizou8mrivVgvlDxB0NSKvA0yBXaP3woclsPN2LaKpFJscvKlnqLsRS0TSJydB8ZLi90azuhtWIyp7DBeknvge0wzepc9XHAzuO2fE0WS9AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582395; c=relaxed/simple;
	bh=7SE/MWNUIpqD+lQT8z32lhaobqwEGn23lGpJ8NP/BJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp0v04xxjItgZXdnZwwtXaOAiJ3zVigD7n5EZ0TsY3O1dBh8mYZrxVPacflZZk7gIJpBturPTMQTL7gFLG8pX6Q3lzZLGhthfd2oOmEG8jZaVoonhvk5L3XCvdizDS5Ab5XwYQzbMig90pFbIdAadpXAIBekYLU8eL6KOSBO5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IPSkTInh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GWS0n9tp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755582393; x=1787118393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nCL3QwkJnOTRYEn9BtTPEX3wFqEJoR9A5wWGYPLvuo=;
  b=IPSkTInh8BH/cjZyXwPIps4Nj1XqpId1Reqvvx+THKENjsZiARSYLKxd
   Dcr1KVP/GCGpqKX/kbX4zLk42kY7kADkAOOrAI3veIL0fFDXlokqA+tkU
   +u9ffL3ArRXBVWi3nQv5SILgOXx+zilpR0IK5qNfQTWlCgNvcpfZf4WWO
   HVQe1l9fg6sZnwhKliOo8ZT2yXc50dMTZ+ZBSpo6uPbJMDIxE06S1xjNo
   T7RrHZo4NAUcuU51knQ2cgopMsnOeoal5D2OapaFhod2o51K9YojjM/J4
   KQzoYFYrI9608g5aivu4EuvJjJmXC6tUwugvJM9JIfoWDVDVbfOKZ56Ed
   g==;
X-CSE-ConnectionGUID: l/Kii1V6RmSQnbDfi2tSnw==
X-CSE-MsgGUID: mrA2fpkWSOSZPhAPjUiBAg==
X-IronPort-AV: E=Sophos;i="6.17,300,1747692000"; 
   d="scan'208";a="45794423"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2025 07:46:30 +0200
X-CheckPoint: {68A40FB6-D-820F521C-C7779E56}
X-MAIL-CPID: 8AD0AB6E002B742D345C793ABC4510B1_4
X-Control-Analysis: str=0001.0A002121.68A40F50.002B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A990169523;
	Tue, 19 Aug 2025 07:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755582385;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9nCL3QwkJnOTRYEn9BtTPEX3wFqEJoR9A5wWGYPLvuo=;
	b=GWS0n9tpmRlEDConDS9JHV39aMOHYjdgWOzGkJgoeMcW8xxrqzl3Pt/FSfG5W2icrP6lxc
	UDSLzIMuKukSs+CYSBKNXAznLslkfe4ViYTyLJSpbNzOiwkYUOGReTKokTpR1JSFLYGh6B
	0meTvTDzw0S6x4aHbYeJ52XvVkoow+otUsjmfz/8qps27Ccjenwnzl57KyzYMxm5SlZC3Y
	QpZKUOWnS9xLd8S1d/keAHb7bZXuLyqGCIwpH4pPunjwe86NK40u4nkNKeiGd/mYgW4Ufk
	hDIc34aIhIBjnSW/aaor4/Qn2673WtOP30gDrQAI4trlRTOxSCL+wGjWJiANsw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject:
 Re: [PATCH 07/15] ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
Date: Tue, 19 Aug 2025 07:46:25 +0200
Message-ID: <5920180.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250818-ls1021a_dts_warning-v1-7-7a79b6b4a0e2@nxp.com>
References:
 <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
 <20250818-ls1021a_dts_warning-v1-7-7a79b6b4a0e2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Montag, 18. August 2025, 22:48:18 CEST schrieb Frank Li:
> Rename node name esdhc@1560000 to mmc@1560000 to fix below CHECK_DTBS
> warnings:
>   arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.d=
tb: esdhc@1560000 (fsl,ls1021a-esdhc): $nodename:0: 'esdhc@1560000' does no=
t match '^mmc(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nx=
p/ls/ls1021a.dtsi
> index d095c6107745d75b108a430a5eb15e4f2511e81f..3921d9c4912713064dec1e10a=
c00cc0916d8974e 100644
> --- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> @@ -154,7 +154,7 @@ qspi: spi@1550000 {
>  			status =3D "disabled";
>  		};
> =20
> -		esdhc: esdhc@1560000 {
> +		esdhc: mmc@1560000 {

As mentioned in the cover letter to [1] this would break some version of
u-boot because they explicitly reference '/soc/esdhc@1560000' node name.

Best regards
Alexander

>  			compatible =3D "fsl,ls1021a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x1560000 0x0 0x10000>;
>  			interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



