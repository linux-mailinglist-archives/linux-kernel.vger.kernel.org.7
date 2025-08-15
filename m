Return-Path: <linux-kernel+bounces-771362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2210B2860D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F416EB82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574FF304BB5;
	Fri, 15 Aug 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TXBMeQsT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4E31771D;
	Fri, 15 Aug 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283906; cv=none; b=eIL6ak6YQ/Z5JXxYWtuvKUiHBXG5OvIVlXQ0WzsRLRKDILshXRtrc8MOkwTXEJU9KdVXLjhm53i48hHPnT0wnnEttYfsUhiMA3oAaCYlJ5nrngPwEfG2P9DKcd6jYoJppO2Uq0HCnhe745n0gBTaON7N4bnjJSEdxVX5Moy+20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283906; c=relaxed/simple;
	bh=PBilgiVXrdV4MzLv9w5J7CKp9AeXHBnY27gof0m7Rqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwCn27KeQjX8FE83DgihswrhQRN3XyUTS5VBHV8dxXMxB/JrKm8Dcp976CNcmqv1PeTlOa3oF7wDdeROMluX8w8u019wqTZja1DamCr1QUL11Ga+T5nRp6a71+jrzw6pbNIu1cfh4G3UPQmd14jl7mM8ZRAz62LAHwAlQIqJiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TXBMeQsT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EE+i1kQVFTRPh8ZX2+zLB6KfxNCAy0eLJzE6/OqBYBA=; b=TXBMeQsTXMh3Xy0uL/bFBEJrU2
	8lX/lkbU2CCOyS8umztNUSTXTCbALLCnbAfNHxAspUcOdXOvx3WQDF451KS/HsximX809nHDpQUUl
	o1WMRvi0WT532vusRozr68q94td5KeMoq0ueXoIuvzLhzr48WgC2hOBLhYtkz0HtOsD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzWh-004r1v-85; Fri, 15 Aug 2025 20:51:43 +0200
Date: Fri, 15 Aug 2025 20:51:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 4/5] arm64: dts: rp1: Add ethernet DT node
Message-ID: <550d9ba6-6a4e-42dc-be7d-c9e6493d42a3@lunn.ch>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-5-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135911.1383385-5-svarbanov@suse.de>

On Fri, Aug 15, 2025 at 04:59:10PM +0300, Stanimir Varbanov wrote:
> Add macb GEM ethernet DT node.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

