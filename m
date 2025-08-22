Return-Path: <linux-kernel+bounces-780864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85694B30A31
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A8BAE0237
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377F27450;
	Fri, 22 Aug 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hE9vcDcv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491314A3C;
	Fri, 22 Aug 2025 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821546; cv=none; b=ORJY76gF15a5gqP/YCddCAXAs+gxWh1oppU+86BlV2+kLyHxynth+Dm3DYsQT3CGGPVs5NOjskaCFLOvZVdsyyTQBQAA5g6NT41zVweI4iZh8YA2r3C+a3Nj+3xZaqsKL9wHadzY2Yj2aWUBg4Cxxd5VS+PUmr2PyTtvUsqExW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821546; c=relaxed/simple;
	bh=p1dGIjTvkNnpxKCOB7RchEpvReZY90qlUytsq4gDFus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdr8fOBqld9r0eaVCZ53a6d871SJ0MfNHykJSexMy9pEfA3Qju4PUGIkiKtKZN/WukXhp6jheXHMNSMMYM/zr8NCYW3aEacfpQR7fxl8p9IUH885UTf1A/LtgcaeZKJSvuCNJ/6FEdfcxR2f4BJt3IvPgQDOvlwTK7dcJGcaZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hE9vcDcv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0V9vnhvl7kfzNO/a9uciBu9rFyDt7meyaj/wnJfH86E=; b=hE9vcDcvu8i7v5Uh6vAfLCZ32i
	GZ7mT1gdrfNFREwtqr88Ijj/ipJHSsfGjhcO4A/ygORSA94FThY1eRtgRDRs+TwVM7ZECF6tkQiYK
	ynhgDpw8MDLJIG2eN0nJmK6tDak86IkvU19ggl9pv62PQBr1tAgtNSHTvObueR06Nt3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upFNr-005W4E-6y; Fri, 22 Aug 2025 02:11:55 +0200
Date: Fri, 22 Aug 2025 02:11:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	howard_chiu@aspeedtech.com, arnd@arndb.de, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net] ARM: dts: aspeed: ast2600-evb: Correct phy-mode to rgmii-id
Message-ID: <6a3d7eb4-c091-437f-98f8-2b8577e539a7@lunn.ch>
References: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821052555.298860-1-jacky_chou@aspeedtech.com>

On Thu, Aug 21, 2025 at 01:25:55PM +0800, Jacky Chou wrote:
> According to the latest ethernet-controller.yaml.
> Since there is no RGMII delay on AST2600 EVB, the phy-mode property of all
> MACs change to "rgmii-id" mode.

> @@ -123,7 +123,7 @@ ethphy3: ethernet-phy@0 {
>  &mac0 {
>  	status = "okay";
>  
> -	phy-mode = "rgmii-rxid";
> +	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;

How does this change actually work?

I could imaging such a change as part of a patchset which changes the
MAC driver, and how it handles RGMII delays. But on its own, how does
this not break the board?

	Andrew

