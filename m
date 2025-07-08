Return-Path: <linux-kernel+bounces-720929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F0AFC238
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F001AA69D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41321771A;
	Tue,  8 Jul 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Clixd4F/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PdeKKxyz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554C214801
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953383; cv=none; b=hyjlSKymLdfNTFbvnGtvwkCBD3ZN2oESnEmJB+ioGStBfJoVJ8kSigi3TuOhttJGR3O85YyXfmguZHlar1wLcK+XVqrfO8gjMFVtoVIvhBaiAkyPM+Wj1ZoijLP5Pbk/TjVVqgu1pb1C4ZhbZFtgIZrxfCOwahwERw1Hsdn+2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953383; c=relaxed/simple;
	bh=kfU/55M+KUFuIfPfzBQQ1B7qVL+5rvh+e/I5ccJJVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHnELqXHKg7h2T3la7CRf4VJYHcczJki4coCmBQp/KPLXmXFZRI8P0G4+FF9n/0YuJE/AC12UzOgnV/dY/rVKm5skw11c3jUVJ75Ol3t2UWp10k3kmlnyOgOKBJ2n+6yjQ7vvUQjlk/pPVkkMiZASMBnXtXaOxwXUIl03Ry2DR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Clixd4F/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PdeKKxyz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1751953381; x=1783489381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNLGdtGiLP2sQdD/DngbmuGIM/jxvNClAvOYArQMTFM=;
  b=Clixd4F/Pt7ZO8W3mmA/i2mOG6Azjmt06qXSRIgrsEHNR4OOrcbM8I03
   SCKBS7ajRWAG5qQMsCSnGx6v6VRNL7MKwa3Ja/hHe3SJm+H1VxWd9XQrz
   CgdbgGf0nHbacKTEfJupSrXtn/cGx5/Eqm52S94Ej/wJ9YLTHHp88xJrW
   H6e+nqCMzrLl0XTePqEbGlRX8FSvQTbfCzdfellRt8Q0QOKXR8FIs1UEj
   rbShwET9L+TXP4+lzrjLdK1M6hEN6i43Bv8zQJ6Xc/hBB+fi51Fo0N9Qa
   As0X+V7mlc9zjNk0jE2OaIkFOJdBUti7BIJbnbIAnnN4ncnbRw4TJ6VrE
   g==;
X-CSE-ConnectionGUID: EFPn/MLrSC29i8zZr4Wdjg==
X-CSE-MsgGUID: P/MUXaiqS2ioqgneM/5qYQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744063200"; 
   d="scan'208";a="45074471"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Jul 2025 07:42:59 +0200
X-CheckPoint: {686CAFE3-13-B791C630-E7A1546C}
X-MAIL-CPID: 8D2021FD5B7F91B62BA81C32DE8B9514_2
X-Control-Analysis: str=0001.0A006375.686CAFF3.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5F1016492D;
	Tue,  8 Jul 2025 07:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1751953375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNLGdtGiLP2sQdD/DngbmuGIM/jxvNClAvOYArQMTFM=;
	b=PdeKKxyzIDI83ozs0H8VrOSRqTM6/9Rm8cRvMy+DTfUAZw1QstnaeOHNsGVjz7jW0xgtET
	wz+FXeV/uYCriQijzkMRSTnQuaol82jrevqKYF0XU5u0FfpKb01uHibu3DT2x8lY5zjyw+
	r7I1HKyeShl5x/FlTYmLf86oq4nMWZ44gggDMfHueBZtQzUcGR7uW9awczYlGaeQ2UCzZf
	nTFgY/iuUT9QYdgVPjKjhjGEn1+ZJscAMGxKxvNKYz1R0xzhmbV+YCzRRAmjTkX8VGgVdP
	k4y25Zsi3HE3bJj1eE7p8nbMtyFBeePLvl/lJEavhWNPNnJErIvz1XCXTMo+iw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: defconfig: enable i.MX AIPSTZ driver
Date: Tue, 08 Jul 2025 07:42:54 +0200
Message-ID: <3894475.kQq0lBPeGt@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
References:
 <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
 <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
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

Am Dienstag, 8. Juli 2025, 01:46:28 CEST schrieb Laurentiu Mihalcea:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> Enable the config (CONFIG_IMX_AIPSTZ) for the i.MX AIPSTZ driver, which
> is required for platforms using the AIPSTZ bridge (e.g. i.MX8MP).
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 739b19302865..4d7a60444bf5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -262,6 +262,7 @@ CONFIG_GOOGLE_FIRMWARE=3Dy
>  CONFIG_GOOGLE_CBMEM=3Dm
>  CONFIG_GOOGLE_COREBOOT_TABLE=3Dm
>  CONFIG_EFI_CAPSULE_LOADER=3Dy
> +CONFIG_IMX_AIPSTZ=3Dy

Why not =3Dm?

Best regards
Alexander

>  CONFIG_IMX_SCU=3Dy
>  CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=3Dy
>  CONFIG_QCOM_QSEECOM=3Dy
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



