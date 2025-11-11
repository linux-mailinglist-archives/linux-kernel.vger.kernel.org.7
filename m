Return-Path: <linux-kernel+bounces-894807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1EEC4C225
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4ED04ECF78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DA32C326;
	Tue, 11 Nov 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PWqLNck9"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C3281341;
	Tue, 11 Nov 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846665; cv=none; b=DquNHm/qhBuqdEkG+YdLgJeXNkirXMuSsMy0I0iqbj0hAq29FfkdwFw7uQtHFmcqxQaj1mcWp6IacRx4R9uicuJvfO4GmsVlhWoAxalSxk4xmL+9FerLDGtXKyaQDSvsqZPlSfitLwPa9dH3dNZzTTF67Ru3mKFLjb+RKfTNSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846665; c=relaxed/simple;
	bh=TMfjCCp9Vl1C+w/PH2HESmcjrVpVqcg2gmYMGqanOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjYjHZrr9aASl5IBLtW1CM4sZFTCXej0+ilrkNpzdiU2uNVbiJUEswKeOT+NZRbZvP8wmtcoh6BC6LL4cvL+zRRmsiriVveDi4wSWkOSiWdsEw0iJqHAsgvnmfdSrHz33H/mzLyYH531r+0ptosdkiD04MHxAlHh46D6vBJIUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PWqLNck9; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jSCFmAGYJ/6nn3X8y2BV2I473qQwTQBsOPiyb3X/GTY=;
	b=PWqLNck9KGbRwkR/sES7ueZrnA5LZNT3OVPkUI2EVxEc86cKHKBRnIx0UPASlk
	9MW/rnmblg29iXEi5+dXOGvlkhWhYNW2H1SiGaWvEKBcWbQGD2zCHdJXOhInI5r8
	3LGLOWVtKwJIxovzNMFo6iSjfjrenzjP8NeQPbQYeJ9z8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAn_s2h5xJpBSnNAQ--.5214S3;
	Tue, 11 Nov 2025 15:37:07 +0800 (CST)
Date: Tue, 11 Nov 2025 15:37:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, frank.li@nxp.com, s.hauer@pengutronix.de,
	festevam@gmail.com, kernel@pengutronix.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux
 regulator for PCIe M.2 connector
Message-ID: <aRLnoXX54oG6erhW@dragon>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
 <20251024073152.902735-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024073152.902735-2-hongxing.zhu@nxp.com>
X-CM-TRANSID:Ms8vCgAn_s2h5xJpBSnNAQ--.5214S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1DXw47Cr1ftrWUJF47Arb_yoWkKrgEya
	s7Ka45tFZ5Ar92qas8Ga1kX342939rKrWfXr18Xr4kGF9rZayvkrykGa4rWr13CrWIkrZx
	CrsrJ3ZxXr9xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU2jg7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiOAMBZmkS56Mm3gAA3b

On Fri, Oct 24, 2025 at 03:31:46PM +0800, Richard Zhu wrote:
> Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
> Grounds.
> 
> PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> source, 3.3 V, is expected to be available during the system’s
> stand-by/suspend state to support wake event processing on the
> communications card.
> 
> Add vpcie3v3aux regulator to let this 3.3 V power source always on for
> PCIe M.2 Key E connector on i.MX8DXL EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 25a77cac6f0b5..7704dba9e37c0 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -649,6 +649,7 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcieb>;
> +	vpcie3v3aux-supply = <&reg_pcieb>;

Is it a documented binding?

Shawn

>  	status = "okay";
>  };
>  
> -- 
> 2.37.1
> 


