Return-Path: <linux-kernel+bounces-793167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E06B3CF86
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405A1205906
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C62D878D;
	Sat, 30 Aug 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mw3VnBnE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D55205E25;
	Sat, 30 Aug 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589216; cv=none; b=k/MmCyEZ3Xn3r6o5MNpCrIE1S9rJ8wepQTeDlo/Hv7foIS9ClBGryGquZOMvBgvZFIo6Y+THJiCB48zX4n4qFBs41Cza3FkmTZDFJB8jLCLYR7DCFYWbYMs+fJHAzQR3BMrXJ3CMJHU2CFwrN88XmIPwUWvYq78m7WguHHvofYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589216; c=relaxed/simple;
	bh=APy3/XMlUtSihrbgScO7OXzSa2HgEDs2qV4eoOONL0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFW4OedbX8vEWlAED5Hh7tw8WXbMyBUscgVlUy5NBQP2qHfAjBWstS5LA/lnQbzwlAGq5XP7piXSPFcVbRRrjUQTA1iDG41kiay4To6lftCS++n782pavJfPreh13iSBU0SGlRIcd87wytKRlu7DH/g5+7UEufpRUcdlti9kWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mw3VnBnE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xAktbBFWSSQ3i5oAt07HETFA92KJ7TQG9se5OeSJvuA=; b=mw3VnBnEZXK79ZGzO0tjDhPFuj
	XhFxacZ2s/74ZWp8MikERNp8BEaAPwE2j1Jpvnu/JZTn1szlEsDrPg5YRbkIe311WHYvU8SdJMsTa
	i823A8W32+PxER2Lc1L97+bmcjJnfRnDJcJVKY2y5Y4GB2b+LMAiSpgUP5lVcXL/PU3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usT5n-006c4m-Nh; Sat, 30 Aug 2025 23:26:35 +0200
Date: Sat, 30 Aug 2025 23:26:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Message-ID: <2803b3d8-332e-4ada-a28f-eeba8285b7ec@lunn.ch>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
 <175603280227.3445205.12980590537074643035.b4-ty@sntech.de>
 <20250830171101.410bd954.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830171101.410bd954.xunil@tahomasoft.com>

> As I worked on my dts, I discovered that the 1Gb ethernet ports, using an
> RTL8211, don't support rgmii-id mode; only rgmii.
> (https://www.realtek.com/Product/Index?id=3976&cate_id=786). 

Which exact RTL8211 does the board use? You link to information for
the RTL8211FD(I)-CG, which i assume is supported in Linux as RTL8211F.

https://elixir.bootlin.com/linux/v6.16.3/source/drivers/net/phy/realtek/realtek_main.c#L519

This indicates it supports all four RGMII modes. And in general, all
PHY drivers in Linux for RGMII PHYs support all four RGMII modes.

> Changing this makes a huge difference in the ethernet throughput speed. With
> rgmii-id mode specified, throughput is about 6.5 Mbs. Changing this to rgmii
> mode increases throughput to about 960 Mbs. 

Here is some more information about that the four RGMII modes mean,
and how you should use them in Linux:

https://elixir.bootlin.com/linux/v6.16.3/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L264

	Andrew

