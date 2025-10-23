Return-Path: <linux-kernel+bounces-867139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919DC01AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F79056652E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A331D758;
	Thu, 23 Oct 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dxITQKQ4"
Received: from mx-relay87-hz1.antispameurope.com (mx-relay87-hz1.antispameurope.com [94.100.132.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB7314A79
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228308; cv=pass; b=Tcg1JJ++2oHw5GZzmZ38Kj/JWHKj6viRTS2pW5JacBl9C8cO7V1p7QepZxmBe8e5dZ4eftBixxZ5q5VV6HCtfaRPLhnKvb/65UaYP6kYJ3X9KkUaVJ+by22nCDBWXUyi83H3Ok2bTFNsuz8wBUjIDbCAgNfHrsDJhV/AwrsaOK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228308; c=relaxed/simple;
	bh=bZ2zMBOqCI4gSRYdvAN5yceGY8g7ev4vHxJ6FMgFQX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmxrc1yKpMAdmJ8PQ2paVMgR3LKBK0+x0+0gxlPoEbTE4n4aUflyu3hAx0iiFpZ3m9ef/t3IotYlTz1pAC8LzvNBjTsfql2yR9Wwq9aOLU0VChDbERq93MeEq8S2zxBtC1KoKsmucVDOHiRbPZI9igeluEMErcFuRZWapJi/ZoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dxITQKQ4; arc=pass smtp.client-ip=94.100.132.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate87-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=3sTwvMaOD2KlqMJn2cmd2U+t/IC6uSpDaPUIgltSHNY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761228232;
 b=Tflkx14duqHUgfmOEZrx1mIUrQLVGrOZYeS0QXnltHWokA3ei3s4ka709w7D/ufkOE7XevuN
 RMsJbAd1QiBZcEH9Z15Mpfrdobk8RWbREPORfHjc1FtTY5tNxpkiyiTzZEuiViQO9Mxk9CFHUi+
 bdRUQ1npGlQEEyGYyvGHcMfxV+XS7110Mf7uvk0BhcQqImkkwD+lKQHNba3d5GiyLICkm6URQLW
 yxr+fyXVcIcuieesVIYhNqTm1K0xnJIS+6Yu8kwwS9fS+0CJsO/+mkIjzJ4P8AstQPSytIrLk7R
 Mx+l4R81LzdAOFcHKPzNYYED91iXo1ixCj37AiIQV94JA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761228232;
 b=CgDwpGkjAcDFGI062K0is0MYGXXtn4NMNDmGqWo/0dqNwrEkwbCwv93O+z3Sz3b3Qbe+Add7
 2CmkEY61RCHIfF+rLQkYp6bHkls1Yrc3lsUE6TmENG29pipw4P+9j6AX/snqbf0uVDIWL6pWFYf
 h96zSpOySCH7/MMRII4hmvGWJt3z6jk7oW22wht0SnvoYnteQg+069SJrFLO8H78GnuSgFTBjzP
 hLZX9pJ3mxY38mSqaJQ+fOj3RE7iIAmFt6FrbsiL2HdjM3UDfOjNKuXSDXih7lktRHWLFGFge9H
 MZNzsCIv7tYJsfKkSGDDrZQ4hpW5aX1jqgEkuQ7FWY3KA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay87-hz1.antispameurope.com;
 Thu, 23 Oct 2025 16:03:51 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 81F9BCC0CC1;
	Thu, 23 Oct 2025 16:03:37 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev,
 =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Subject:
 Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting and
 Ethernet
Date: Thu, 23 Oct 2025 16:03:37 +0200
Message-ID: <3381308.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
References:
 <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay87-hz1.antispameurope.com with 4csnnQ15tNz29l9Q
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a7de4b4405587fa83fe7bed496fa611d
X-cloud-security:scantime:1.783
DKIM-Signature: a=rsa-sha256;
 bh=3sTwvMaOD2KlqMJn2cmd2U+t/IC6uSpDaPUIgltSHNY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761228231; v=1;
 b=dxITQKQ4dggiZY4h+sOLKl2U1M9IoA/Z6Zadn4fE+oVG8WuCw+NN+0V3pbZWk0DlmY+wplAZ
 +Y5KRfp0lBJGYX5BshC9TZg4g/jtUtxZFDCfGmfHIQzmkiA4q16opQr+Mz2/7juvJ0Y+0TrXvia
 28QkqeEoNGJL+AzGKioR2rwUCxyYcREBKdWlkdiIIclykrQlg6kdY45kH0iVYaJQ9TGItxTjeMx
 lv6S5pVTgwsmyk9W2rv7eJwaIhLOWw4c2Fzhqg/LDymGCT5tsRD6oym43udZuTLwyCbnTpgrleI
 xrGttQ+pOKTf7d2Xr0xunLI+VFoUZ+Bro2cn+kjCztuag==

Hi,

Am Donnerstag, 23. Oktober 2025, 14:19:15 CEST schrieb Jo=E3o Paulo Gon=E7a=
lves:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Enable the necessary missing configs for the i.MX95 to boot and also
> have Ethernet working:
>=20
> * CONFIG_NXP_ENETC4 for the network controller driver
> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
>=20
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> ---
>  arch/arm64/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e09=
43e7b0e1dcee3a9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=3Dy
>  CONFIG_FSL_DPAA_ETH=3Dy
>  CONFIG_FSL_DPAA2_ETH=3Dy
>  CONFIG_FSL_ENETC=3Dy
> +CONFIG_NXP_ENETC4=3Dm
>  CONFIG_FSL_ENETC_VF=3Dy
>  CONFIG_FSL_ENETC_QOS=3Dy
> +CONFIG_NXP_NETC_BLK_CTRL=3Dm

Are you sure this should be module? Shouldn't NFS boot be supported by
default? I might be wring here though.

Best regards
Alexander

>  CONFIG_HIX5HD2_GMAC=3Dy
>  CONFIG_HNS_DSAF=3Dy
>  CONFIG_HNS_ENET=3Dy
> @@ -615,6 +617,7 @@ CONFIG_PINCTRL_IMX8DXL=3Dy
>  CONFIG_PINCTRL_IMX8ULP=3Dy
>  CONFIG_PINCTRL_IMX91=3Dy
>  CONFIG_PINCTRL_IMX93=3Dy
> +CONFIG_PINCTRL_IMX_SCMI=3Dy
>  CONFIG_PINCTRL_MSM=3Dy
>  CONFIG_PINCTRL_IPQ5018=3Dy
>  CONFIG_PINCTRL_IPQ5332=3Dy
> @@ -1349,6 +1352,7 @@ CONFIG_CLK_IMX8MQ=3Dy
>  CONFIG_CLK_IMX8QXP=3Dy
>  CONFIG_CLK_IMX8ULP=3Dy
>  CONFIG_CLK_IMX93=3Dy
> +CONFIG_CLK_IMX95_BLK_CTL=3Dy
>  CONFIG_TI_SCI_CLK=3Dy
>  CONFIG_COMMON_CLK_MT8192_AUDSYS=3Dy
>  CONFIG_COMMON_CLK_MT8192_CAMSYS=3Dy
>=20
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251023-upstream-imx95-smarc-defconfig-8972db535918
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



