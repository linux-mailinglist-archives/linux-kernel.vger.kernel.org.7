Return-Path: <linux-kernel+bounces-891653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E278C432A4
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CF53AEABC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A3265623;
	Sat,  8 Nov 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E/8+gc3y"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D534D38E;
	Sat,  8 Nov 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624260; cv=none; b=ndPDkOv1AFbQMfzX5KSiw/bkzjlG4QDoWrM2HakGzAk6NVsUS1fniQNG8j7Xbk6Kg1Dh994U3XvarL6yxHLOucaUh++BOxOKy/ydbpFmV2JKr4L2dKq9hRNdvYYSqW06zvgOSwYYv/hil7K6QaXk+WCbaU8ibPK9tod8oFCcHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624260; c=relaxed/simple;
	bh=6kJ1XEyPi5l40uZJrHIimWl13+rBBDLVG6ZU3CImsOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlwzzvjAI3zJGaWNv9guaZVvCzOQVe2HwGZ7FPmyjX993BcRvlqiZPS2JKAS7MhRq9zyoDHVA6BJ7mDBFS7x0aM9ls2Bhi4G9x6SG0GsXc9dVWchLqNsqkNHsBWmfXi621bGq1TAcL2a1/TD6kc0lLoukmflSZXqq8zG2P0+Qz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E/8+gc3y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5F5crbl5PXGRN0zWCBy1QeKvlywUYTj3rLQO8PeMZ4=; b=E/8+gc3yS2jjfM0yGN//wqd4Vo
	PzfTOGt41E1l80JdPzTOxWi1zLCYFAlGK7oyy6ly4WlhemKdvNxLhDEu2u78id1YVT4ZesuIEtbKn
	dmxlFxLBSyEpDaoXePzGt3nj1QFcF7nOSpU/VxmU1ZSCcmb6Sh0zaK3Ln+Nvj1y1nDtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHn5H-00DOZW-2W; Sat, 08 Nov 2025 18:50:43 +0100
Date: Sat, 8 Nov 2025 18:50:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Message-ID: <21b57a52-040b-4376-8ac0-6abdbc8d43c6@lunn.ch>
References: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
 <20251107-msx1_devicetree-v2-2-6e36eb878db2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-msx1_devicetree-v2-2-6e36eb878db2@nvidia.com>

> +&mac0 {
> +	// bootloader takes care of proper mac delays for now.
> +	// set the phy mode to rgmii, and if/when the driver is
> +	// fixed, we can make the switchover to rgmii-id
> +	// and have the phy handle the delays.
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy3>;
> +	status = "okay";
> +};

There is some progress being made on this at the moment. So please
just drop this node for the moment. You can add the correct node once
the MAC driver is fixed.

	Andrew

