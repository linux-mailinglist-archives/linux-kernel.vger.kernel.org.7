Return-Path: <linux-kernel+bounces-722385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C4AFD950
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396C258687D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE03244685;
	Tue,  8 Jul 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zsHWz4PD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033012248AC;
	Tue,  8 Jul 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009022; cv=none; b=mc9BdLhBbuFbuw//Mum93rDlKUNAydNFLLNusLIIUrBooDydhll4Kv512TWEyoOgSglMwlQ0hw9YtDEgMApNO/lngPaYAU6AL2omXnzP4R4zfMX4oRAC6FCehj0tsm9gRZCYLSNPlRUn/nGF9v0Z4diN4jH/ZiCQvB2egXyOJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009022; c=relaxed/simple;
	bh=TjNSylqTfYBeI591eTCyriER3zOBm5C+1PQ0B3DTr0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy4V34iedE+0LNkNS6cqsOPD9o6PLg4TFaRxjY1ML+bN6kGJrnrzwAqNDnEZW/g7RylOvWhlgUj6rkViUwRx1iXaTNobhaMyTraACard0dJRghTRHsKtGcdXraaJrIUdKkDgk1RBksaDfjoWpbZWImtb5R18Y9Qqgldt1+j4suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zsHWz4PD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yyXS9M/fAZHQcRokoMR/G61/cwt9nzmHIW6p1L73nGU=; b=zsHWz4PDhBM7nWWUmeaUFSsXTw
	oidB8Sl/Ghp4W9JCXAunn+v+jyjg7TOI39kBBcLRhZShcTxR3N032jjPrshIVl2U8TQoSKUL3slWT
	d/v+V8riXUj5TFfc2rYtqTXYndpGsOP93jqMw7fHB+xE/2TDFgAsPRGq/d6y4e2q/Mp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZFZy-000ruN-NQ; Tue, 08 Jul 2025 23:10:18 +0200
Date: Tue, 8 Jul 2025 23:10:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P Symphony Board
Message-ID: <64ee1121-40af-4863-aece-381dd15fa678@lunn.ch>
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
 <20250708184841.72933-4-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708184841.72933-4-stefano.radaelli21@gmail.com>

> +&cpsw_port2 {
> +	/*
> +	 * The required RGMII TX and RX 2ns delays are implemented directly
> +	 * in hardware via passive delay elements on the Symphony PCB.
> +	 * No delay configuration is needed in software via PHY driver.
> +	 */
> +	phy-mode = "rgmii";
> +	phy-handle = <&cpsw3g_phy1>;
> +	status = "okay";
> +};

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

