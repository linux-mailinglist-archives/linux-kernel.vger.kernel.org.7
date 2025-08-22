Return-Path: <linux-kernel+bounces-782070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B1B31A85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B285A3C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2982331280A;
	Fri, 22 Aug 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fAnZj+FR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oQE/4amK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A0309DCC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870924; cv=none; b=ahMF68Rj8LPfoFOpSh5ZG/DMP54RP3t1VSkzc0wjNXai2ALiEq5/EcuK2Om7Ra6wZ6e3KONSS0LZE2oqr8npfVF1hTNtCpx7FlVEza3eo5Ql5jTBMxpWgBqEWkf6+X5o2Ygqj9/pO2FWu7B2ZXLpvuio9XfIGcneM3eqdorMgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870924; c=relaxed/simple;
	bh=aVbQGKZ/qV/gsg5wWkv91wtPiAL4Se6701adBGjivFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4VK7DoJ8ZCTYaHS3X9fsFCof1rSmjCSPBhwzhp47RIeCxEr9y3OHgVBWJ5s1P5FAWg+GQbtI9P2L65aP1tWJtoHCALNsuH4SX5AgAuLMZwTwWhumEaA5FgcAsfjYvF/ZWUs9gUVcQQn9lifglhM26Zvqm9Xu++wsfMcTCLNOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fAnZj+FR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oQE/4amK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755870920; x=1787406920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSGxJSn/2n3PyNBHNAnkcPXaTGaJNX+JxFYp3H3S7XI=;
  b=fAnZj+FR3eve65Izg0E5vDeF/t89BdIDB2sE1BovCnP+YC5mzCJIIqrl
   FxsAYuLj6n4P2fgUupWsDYbyqR6BdMv53qELEHsqOJ1coDSW9gr0sXf+h
   YAIcoHvSCuZlMXel5TkuJzJ8mpOZmpVXd+fWfnoIdur7LRSvn8Zk6nqWx
   2Tl1zWSnyJlvLiuc37SYXvH9YBhJY93qc3mNh6I+NZtWgXVGrc6yBUNP7
   /ebSxefF820l0aGeHxZJw8hiIzZnVMzO1ZfhHraRyXIwaNorgUifFbX57
   MUL5hRWrw7oxcryu8z2OC8N5KEuWCZZxDM1zBUI4rg5T9zgfRsmyUSDX5
   Q==;
X-CSE-ConnectionGUID: uQtDp9sDQGi4/XdVsoW79w==
X-CSE-MsgGUID: /5l/3tQYTh25k2Gidfn4gA==
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="45868412"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2025 15:55:17 +0200
X-CheckPoint: {68A876C5-15-20CAA7DA-EC9DC758}
X-MAIL-CPID: 746B3D6C51CF356B3828B6C881666656_0
X-Control-Analysis: str=0001.0A002104.68A876C6.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42C46164C6D;
	Fri, 22 Aug 2025 15:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755870913;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BSGxJSn/2n3PyNBHNAnkcPXaTGaJNX+JxFYp3H3S7XI=;
	b=oQE/4amKYk1f4dIXaH4ppDQxEuZVG9H6tw8bkFXTJ1q+6ejRGw3lvLlvf8SfiJo9aryi+3
	+qWcitNsyVbVqZFc2zco+JaTZ3UhQoabQwFX6iexJVWch+VWwXvUS9w4zN8eBqjuPzbecR
	v+45c63JacoNm7/IDXwzMU3CcxvTX/D7cSrkevDM/+S/eQzsGdF7uRautKQ+9zWvrQJJ3E
	PCUnw6TBn85MUjZKKLe9gfyHRnllM4sVQJs0DaHBt1pSI4D1iUXjQqA/BVwgPcYhtcwwM/
	EjQLvcU/kHyOY/jfYRSZ7UFzBClKTIygh/nZ79p9UDNsuf5K9zZ0VsKLHMdUzw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: defconfig: enable backlight device class
Date: Fri, 22 Aug 2025 15:55:12 +0200
Message-ID: <2385138.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250408134249.1131127-1-alexander.stein@ew.tq-group.com>
References: <20250408134249.1131127-1-alexander.stein@ew.tq-group.com>
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

Am Dienstag, 8. April 2025, 15:42:48 CEST schrieb Alexander Stein:
> CONFIG_DRM_PANEL_SIMPLE is enabled in this config. But it depends on
> CONFIG_BACKLIGHT_CLASS_DEVICE which is only transitively enabled by
> DRM_NOUVEAU, iff DRM_NOUVEAU_BACKLIGHT is enabled as well.
> As simple-panel depends on backlight, enable this in defconfig as well.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 65ec5a5be407d..b70257878812e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -963,6 +963,7 @@ CONFIG_DRM_POWERVR=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_FB_EFI=3Dy
>  CONFIG_FB_MODE_HELPERS=3Dy
> +CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
>  CONFIG_BACKLIGHT_PWM=3Dm
>  CONFIG_BACKLIGHT_LP855X=3Dm
>  CONFIG_LOGO=3Dy
>=20

gentle ping. Any feedback?

Thanks and best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



