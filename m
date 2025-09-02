Return-Path: <linux-kernel+bounces-795831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1ABB3F873
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E093B17EDD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3FD218EA8;
	Tue,  2 Sep 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XZqHh0CA"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428A26AA93;
	Tue,  2 Sep 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801983; cv=none; b=ZwhOZ2ZQT1y76IrPtpzGh4EDY+fkPpFWmoC9sQ5Hi07mRSrbs71AqqZ6zRwQqvlnUQFgckNFPUe240Nl0eI7BjfjnVxLAmvvucmAdVATJXR28ce0c2ZDLY4KaxYrBhqeq/jAtUCfjpkeCsdB5ogHfD4R/2wNSR5AOZGL9yCH2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801983; c=relaxed/simple;
	bh=UY+3EuO5iSP6Ca8veCG94rttJhjLl+bTbCg9SslgRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHjsm+obZsK68zPVrAgqixZVF+48x+g+e3Fvqmizrj6vLuDYG+GCqEzs15/M8kaJykuSb8TKkEo3aTWzLGWJJ5fW5tmmAxrtP545vxDF2thM+TM3CkJEn3F6gNfJUGRwLGYtIo95d3dsa2tuYbG1sIVh+ZfR8f3FllAv8vgDyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XZqHh0CA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 13EE525B6B;
	Tue,  2 Sep 2025 10:32:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDc4tFKH60vK; Tue,  2 Sep 2025 10:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756801978; bh=UY+3EuO5iSP6Ca8veCG94rttJhjLl+bTbCg9SslgRmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZqHh0CAcSFwGFJzV86GjKww5fya1VvJ72UFJkuIXUci3t/IpYQZEDm1lq1ZxHAbh
	 9wmcE5ahvhUbyov07ceEIfJxqSPBr3T2GBXpzJN1dS1tWEbu5c5tRe9ovZM+O0iIRm
	 vnIol0xag8wL+fYc9uwX4NB/jjGJHOpZcUoZjIyC9lkJq3pTw0z7QVCiN7d2QrhhcZ
	 wafoZEGkgE5a5Btl6Hx3jafiNBjm2JyYmotIE/d3OBEDJ/lG3FXSIPn3rTaJ7DNXrh
	 89HJeXtF4c5OgBZ91OX0rciJW/9ucdsf2j1aHzMOuAsfCkej7wshKO9G9pfHV6cBev
	 eiMC0+LDlrFFQ==
Date: Tue, 2 Sep 2025 08:32:36 +0000
From: Yao Zi <ziyao@disroot.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	<conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Message-ID: <aLarlSG9tDA-1YiL@pie>
References: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
 <20250902075548.1967613-6-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902075548.1967613-6-valentina.fernandezalanis@microchip.com>

On Tue, Sep 02, 2025 at 08:55:48AM +0100, Valentina Fernandez wrote:
> Add a minimal device tree for the Microchip PolarFire SoC Discovery Kit.
> The Discovery Kit is a cost-optimized board based on PolarFire SoC
> MPFS095T and features:
> 
> - 1 GB DDR4x16
> - 1x Gigabit Ethernet
> - 3x UARTs
> - Raspberry Pi connector
> - mikroBus connector
> - microSD card connector
> 
> Link: https://www.microchip.com/en-us/development-tool/mpfs-disco-kit
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile        |   1 +
>  .../dts/microchip/mpfs-disco-kit-fabric.dtsi  |  58 ++++++
>  .../boot/dts/microchip/mpfs-disco-kit.dts     | 190 ++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts

...

> diff --git a/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
> new file mode 100644
> index 000000000000..c068b9bb5bfd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts

...

> +&mbox {
> +	status = "okay";
> +};
> +
> +&mmc {
> +	bus-width = <4>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;

I think sd-uhs-sdr104 implies sd-uhs-sdr{12,25,50}, thus the latter
three properties could be dropped.

> +	no-1-8-v;
> +	status = "okay";
> +};

Best regards,
Yao Zi

