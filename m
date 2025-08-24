Return-Path: <linux-kernel+bounces-783463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6978B32DE4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D633482314
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B612472AD;
	Sun, 24 Aug 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="21bRjTzD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE9242D80;
	Sun, 24 Aug 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019285; cv=none; b=Xc+Iq8JiRlZGsN4o5ktYnl17sTFvg0/29j387YrTbFnz6nuf4ixUfC1zA27+s3yPrgSV1nifM+6FtPMCOmnSHAYCl0p7sp+jFil/NZq7PhhSpgsJWiMRAF7Mabg+2zmUx2pmttru+gJd3jHGjgAtmicwxo1IFPQiC6bajxG5ARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019285; c=relaxed/simple;
	bh=Ha8SEn5J8xgwQUGeoOUUXagjETEAEBMnR9DNJZlO7BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw/GbVaPbvbUev+GFfySr6xUoswF9rHEc9W1bRc4/3SbHyv2NTm/JjpH9SK/OTZ4J1DIjuaTlrTV4/PV2nRGZhC+FHuvOl37RfmmP/Q250+PFKhDGXMlueen1nHM2XmbFbVmStkG1+tC6/UYOz1bxXKffPzM0ssaZ5yvzlZ5QG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=21bRjTzD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=P2HYgAFk+fXNwDssXlkE87hVakpkUk3GgjBSxwPzjyY=; b=21bRjTzDJ3J/NurIG6QVqhkUnn
	hMibzK+pWe9y5cJZQZS1fXqKG6hMFNmXzpS5nRdX0N3aaVF3EZtrgiNliuamytoE19q3zzjgvbqc1
	l4D95Ko71GI5nXKmMLepElUcT+T0w+sTVS7nuhYGehc4N7vw24J4dCIWdIA/ksFYwQh/OVZu4Axf2
	vVPS8uY/4nQ7kezTsEOC68SBJAB1vDzozCHxLfQhVR2KXSDcFfa0HHabeexjHDPkyAqDEpt7A8bTf
	ocYlxxPr81OfqUucV7wxqQ+HuOBKd6SKUORmGbAEPPnSFxaWbXlcVhPc/ont+ZuhT44LOglnN51b/
	eeX74Njw==;
Received: from [212.111.254.164] (helo=phil.aerolan.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4pb-0002Oo-GN; Sun, 24 Aug 2025 09:07:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v4] arm64: dts: rockchip: add USB-C support for ROCK 5B/5B+/5T
Date: Sun, 24 Aug 2025 09:07:53 +0200
Message-ID: <175601920182.3425909.1200060972264006288.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819-rock5bp-for-upstream-v4-1-7a2365ce7176@kernel.org>
References: <20250819-rock5bp-for-upstream-v4-1-7a2365ce7176@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Aug 2025 16:50:13 +0200, Sebastian Reichel wrote:
> Add hardware description for the USB-C port in the Radxa ROCK 5 Model B
> family. This describes the OHCI, EHCI and XHCI USB parts. The DisplayPort
> AltMode is only partially described, as bindings for the necessary
> DisplayPort controller are still being reviewed.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add USB-C support for ROCK 5B/5B+/5T
      commit: 67b2c15d8fb3c1447a23358075e4f336d40d9797

dropped the unnecessary #adress-cells, #size-cells from
&usb_host0_xhci -> port node to prevent dtc warnings:

  DTC     arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dtb
../arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi:1028.7-1035.4: Warning (avoid_unnecessary_addr_size): /usb@fc000000/port: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
../arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi:1028.7-1035.4: Warning (graph_child_address): /usb@fc000000/port: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

