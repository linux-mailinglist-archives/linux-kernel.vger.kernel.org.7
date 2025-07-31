Return-Path: <linux-kernel+bounces-751869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C206EB16E95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235431671CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5EE2BDC01;
	Thu, 31 Jul 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qsOIAFQe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NmDuqKb9"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866262BDC25
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953914; cv=none; b=IW3WnvG+sIBVzOdE8MSN+6dnfhZBqA5sjmcffnb7n+8VYkwwIXqgIB7sZITCCXLimQbFPZ74B7s7tvr1hE8eQ3cPSABUmV8ZsbHQkDkiX79DlZaXSJGBMmViKZfZ2A+ufyx5wakaleW+MPrFGkZzFA1u5UatabA20aIh/bIy9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953914; c=relaxed/simple;
	bh=6vWoo3LfXY4uBTVXRCsX70RIjxKHMrgepXH3a3NlEfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ7fgAmaAAXjmcy3AAKV3JXhheCBiGpdPKPtvd0rYmP+Ah95KoCyhZ5+gRUIlpxcbQdU8AUCs6XHLS/D0fM4rZlvR8ep69SzidgOITSY9EcmdDgtI2xxKXhe0SEMzB437Z6OPXSOP+Mm+KkeeQJd+Ruaym8hxQ7oEXuse5e7Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qsOIAFQe; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NmDuqKb9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753953911; x=1785489911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fjlF0hDL+GcP1LxYuRMqQFAx3cvqnaJ2UPhI2yOXLvw=;
  b=qsOIAFQeHn1wlTPwP2CmkmxmBAnKn8XySTjPNgpHlSXLshUkL4U7YcOM
   UmhKYgBnWwD6ZH1pdXg2MXIQ9EbBaHjFLKIiFJ/bLCEUsAgMXjbDJ39Hw
   jisM7WnonW/fTaGrdO2JD36irYUOJCOHYIj5WjVB/D5P8kHusLskDf8Ec
   uLaybizYAheYDbuMfVxu15X6V+u14HlIHc2BXUGqi3l/ICA1W77Hh3/W+
   SqGf82bsQBbrAOobTorh7MyUkteJ/cwz8lqu9rIlB4tpdGN3dQaDD9vlN
   0cV2ctYpX3wsnaI+aGKzeEi3fyjyAX23EksFf6a8ikcCMrPWBysLXXogf
   g==;
X-CSE-ConnectionGUID: fsU95/NzSae495Z9CxCmKg==
X-CSE-MsgGUID: Ur4qndlhTGO+5Yq4s7Aopw==
X-IronPort-AV: E=Sophos;i="6.16,353,1744063200"; 
   d="scan'208";a="45516796"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2025 11:25:08 +0200
X-CheckPoint: {688B3674-49-8CC3CD70-C1DBF452}
X-MAIL-CPID: 7D8464778F9C483E0B2683681F104E7C_1
X-Control-Analysis: str=0001.0A002112.688B3671.0041,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 228D41656F9;
	Thu, 31 Jul 2025 11:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753953904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjlF0hDL+GcP1LxYuRMqQFAx3cvqnaJ2UPhI2yOXLvw=;
	b=NmDuqKb9KyIlFuhOuYHwBb8uOFn+iNVVUVCo7jopYuAhiI9f95nR0rhTJI8xb3sf8wP3pn
	SRlQVJkZZEaltXrBj22aBjZbs+W0nUh38iccCX94+7T86y2MXLIlf1YmOArYN1dQZebbzM
	DNesKAeygVb+o8IAQZGq8zOS9bKBWBBo4/Rq6cS1d0aHs+Xuzn+on6kK+wR5btdZMQaqeZ
	qoBnq2cAyY15XQRJmQw8lGfRFg2cnAA0ZAjZJ5rkql1NdGLKOqrH/flgb5HRXqKpjVDX4l
	ourkr3Y89MGFC1C4OX293DGbmiwt6gr8w4JipeLsVc5+97SDeokhD9+LsTJc/A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: defconfig: Enable Marvell WiFi-Ex USB driver
Date: Thu, 31 Jul 2025 11:25:03 +0200
Message-ID: <4669830.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250506130940.2621554-1-alexander.stein@ew.tq-group.com>
References: <20250506130940.2621554-1-alexander.stein@ew.tq-group.com>
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

Am Dienstag, 6. Mai 2025, 15:09:39 CEST schrieb Alexander Stein:
> This driver is used on imx93-tqma9352-mba91xxca.dts.

Gentle ping. Thanks
Alexander

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8691f0ee44e66..550b2505b5658 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -437,6 +437,7 @@ CONFIG_IWLMVM=3Dm
>  CONFIG_MWIFIEX=3Dm
>  CONFIG_MWIFIEX_SDIO=3Dm
>  CONFIG_MWIFIEX_PCIE=3Dm
> +CONFIG_MWIFIEX_USB=3Dm
>  CONFIG_MT7921E=3Dm
>  CONFIG_RSI_91X=3Dm
>  CONFIG_WL18XX=3Dm
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



