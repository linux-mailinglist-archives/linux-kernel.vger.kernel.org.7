Return-Path: <linux-kernel+bounces-722384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491CEAFD94B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D971C26692
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA9245006;
	Tue,  8 Jul 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0RJaJJTS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA15464F;
	Tue,  8 Jul 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008978; cv=none; b=AGmxMy6lr1GWL95NRiJLuh2GTapqC+jax2V9kdG+miMEh8pnBY2PUyqht7RSRw2CsRrZLO69QMT3ZJv1I5JJFARXzk0Vtf3HeTUcCo4Lav3V6+is4SttYS85OoICkZQcZm0eD36Qqmk6vZBslNHXbfMuyUEw9Pe1GkuCNK9OeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008978; c=relaxed/simple;
	bh=w57jJT/c7Bx2HqMmRGh1DQB5JEIE0/GCeP2SGVLf8+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsKfS/oTwR286lrt6kltvBxmFH8XRc3P30Zbmv6/lZeFsKHLdmVvwMM+qhaMOfb2cPWKp01O6/LjJiKzc4cDE3w6PEGuT2130v40Kpitk5m1HR9EyyHXT6FImlfWLKlfFegeVwn9mBdpQHTh53+PIFToszKgeV0ftDeuOqMpxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0RJaJJTS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VsLW2VzgMCUj6tmxfjMOyabFOD0NjHpDqJA5TXtujnw=; b=0RJaJJTSuaDwdKA/7OJZdR//0b
	OB0wFqPuioPxB+0w6tyz89RbTNZpvRu2MH2eUYWrvTRg2QZ4LQSEMg26drXN2OVHKteyupOoBFWAL
	wn/rSJuOYDIxq/2gIV6KWrMTjbCEw53Yh21m4SaJ1kg86c70+9iKhedoO0uQHwQanWl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZFZD-000rte-K2; Tue, 08 Jul 2025 23:09:31 +0200
Date: Tue, 8 Jul 2025 23:09:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P
Message-ID: <91131efd-e047-425a-9817-412fa1a6f857@lunn.ch>
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
 <20250708184841.72933-3-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708184841.72933-3-stefano.radaelli21@gmail.com>

> +&cpsw_port1 {
> +	/*
> +	 * The required RGMII TX and RX 2ns delays are implemented directly
> +	 * in hardware via passive delay elements on the SOM PCB.
> +	 * No delay configuration is needed in software via PHY driver.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&cpsw3g_phy0>;
> +	status = "okay";
> +};

Thanks for adding the comment. For this bit:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>


    Andrew

