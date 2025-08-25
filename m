Return-Path: <linux-kernel+bounces-784081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA3B3367A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5104F2019C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779002836A0;
	Mon, 25 Aug 2025 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="J/whjBZu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="j6/LFKZV"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8121C831A;
	Mon, 25 Aug 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103429; cv=none; b=g38LYhlnOEEg8R70MBhErkVZBSFMryzC7soCsSLngHnARb/MCoOAGvXd3CMqxWp30EMIZyG+7FFPbENswtND9kXlCcrISooj7xQwbe7/13thyU/QjtjlAKBzhYAQVy8fn+vPkDCAUcuDJ4CfLlau+qLh/YRVQ/YF20VBej67xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103429; c=relaxed/simple;
	bh=0JpXSBDuq/9S1RKfbejNB6wgFT2GEwW1Y0Oq+7tcl/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4+9dk7pTYzCO6m68oYrGts+5ahMj8OVufH5dmn1ho/MrdX1rSkvcv1Xv1T9rlzEBnGxBzp+VqbuWZFpBHxYVuoSzO2Ia3+gmSlOPGEPOFCJdxs31z2dVQa2KPFrw0B/96ZhocP7cscc9gES0vTlviW/v5aesn/WA9gwzRn4xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=J/whjBZu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=j6/LFKZV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756103426; x=1787639426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVClrZYqVmS8mvDO5nHVAP+mpH/d3telWA6Jj0IEuHM=;
  b=J/whjBZuGBV/BxFpt3e7SRHqkN1Vu7pErNvlh+fwcbQnIdzmY3rcMp9G
   FE7Yf70o+tWv+vMdm8w232nY9ckhi1acUk2UrcVQQfXaPQvgUMeoNm/nu
   mX0na0+8rLzIpoC4l5VAFvqQCfjgFBjwpSRywShkuIAkcZuFdaaX08cIf
   m34C1KiDmFcFEFCcVQYGvFMtdGEfUY8ATanljAWmEqKcthm+Jr+gHs9Wn
   D4DV5eD7i2fnYyIhL5J0Hur/oku/wCD6DoytvOHSDYz2YPXNsn559fLZ4
   yew0645g1AE1wnKYalBKeT+1OYCR4woN6oKURMisfXhA6IKa4ZDtch1Tr
   w==;
X-CSE-ConnectionGUID: 6VonDOvySGKuggn1bEsNYw==
X-CSE-MsgGUID: 7vjS2wWkRxG2z5SHniuKPA==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45884651"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 08:30:22 +0200
X-CheckPoint: {68AC02FE-1F-820F521C-C7779E56}
X-MAIL-CPID: BD5D3ABEBB39283A27FFCA9035FF8422_4
X-Control-Analysis: str=0001.0A002123.68AC0294.00AD,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E325316626E;
	Mon, 25 Aug 2025 08:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756103418;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hVClrZYqVmS8mvDO5nHVAP+mpH/d3telWA6Jj0IEuHM=;
	b=j6/LFKZVNymhmmyzEM42kZsPyDpEoBbmub53LLTzfsqHI5PH1DufScz1JZIyh2Z/cfFFHn
	Ab3FBnxhDPy//LteoYOno/TM5HysHHRQrrfaDe0c8SWw6C8EjGq0Ndl+Omig7NxSVvXQOK
	Vxnkzyt71oYgQPOMHK85GepACPF9Rdd3DuKvxwwwIPghUX07fs0EwFXoMehK6TWV2nJyUG
	23XdJh5neKY99mdg+qRWBUI1uOScsm+6/+xOApnzxkX+LYTVeNeEr+5mPGwOCQx2olWD6/
	bb9EQFFyVucvoE5BkKsZuJ1CoPfdY3WcndFGuc+9mX2NXcR8tYfsN4eoz1N+fA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 0/4] ARM: dts: clean up most ls1021a CHECK_DTB warning
Date: Mon, 25 Aug 2025 08:30:17 +0200
Message-ID: <6192530.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
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
Am Freitag, 22. August 2025, 16:49:57 CEST schrieb Frank Li:
> clean up most ls1021a CHECK_DTB warning.
>=20
> Old uboot check esdhc@1560000. The new uboot already switch to check both
> esdhc@1560000 and mmc@1560000. So we can rename it now.

Please be aware you are not the only vendor. Do you have a link for
the corresponding change, so other can easily keep up?

Best regards,
Alexander

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v3:
> - rebase guoshawn/imx/dt tree. Remove patches that were already merged.
> - Link to v2: https://lore.kernel.org/r/20250820-ls1021a_dts_warning-v2-0=
=2D2e39648a32b7@nxp.com
>=20
> Changes in v2:
> - squash rename to flash patches
> - remove duplicate patches already post in
> https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexande=
r.stein@ew.tq-group.com/
> - Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0=
=2D7a79b6b4a0e2@nxp.com
>=20
> ---
> Frank Li (4):
>       ARM: dts: ls1021a: Rename node name nor to flash
>       ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
>       ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
>       ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet=
=2Dswitch@1
>=20
>  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 8 ++++----
>  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
>  arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi    | 2 +-
>  4 files changed, 6 insertions(+), 8 deletions(-)
> ---
> base-commit: 75ad5f47c58aee30248d294a58c8ee52e079a8e3
> change-id: 20250818-ls1021a_dts_warning-fff933bd83da
>=20
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



