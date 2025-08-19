Return-Path: <linux-kernel+bounces-776143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3CB2C919
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC27E1C2266A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F029ACFC;
	Tue, 19 Aug 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d9QvesH0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834961D5146;
	Tue, 19 Aug 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619735; cv=none; b=raZXfgB2htBZbxEUsTt2hvbvfl0cbF2VP1pBmgJseFBajxUxSyuIALI1paJX6ASe20HpR4p3n3/s6CjD8WuqZXwwrSfauz74pKDpSsHNkYi7IIXcCMSB4O7lDUPNn7dWmEcdrEy4rcnObJne0l5LjM8kWD/gpnTGUyHGEm1LArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619735; c=relaxed/simple;
	bh=6GefT8zTh09YEJRTFqrnpDoOMWXbve1Bzht21kegV4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFrX6u/eF3Mv7Xnbvm9J9+FSMqoysYTs0mJBBmvWyDsB8KeydthI1P4vzSseX9Xeqy9b/OSAIeB7UXa2KjcM2goPX+L7k+mfh45SOA4AfpHJlr6WDQ1ZRDxIxb5PCB9Qpcw8snP9+Uuh2yp3vGeYxQP6zYRwVp39mHFYB8Yr4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d9QvesH0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ybc4a5zVNR2n4RONlCYCS49NxANnn9uP57Jdk+jOlDY=; b=d9QvesH04zlFpjUZ2zRbNsJtME
	uSnMz3e3gbt8KUCCTclrt+0NDJ+xblcwIx5ke8tVTAxT/L9V2P6WkCsGxOCTYcfCzCmiEcUgscpfW
	W7vfoHdSwrvw4NfoUKwSEhB2nb0Z4Q5ZB4s7UB4hhdDnAI6MWnugqDl6xBSZiQBfRRT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoOtC-005D9T-Q0; Tue, 19 Aug 2025 18:08:46 +0200
Date: Tue, 19 Aug 2025 18:08:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: angelogioacchino.delregno@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 Grinn GenioSBC-700
Message-ID: <350133ab-a116-4555-8d5e-90b718c7b0e1@lunn.ch>
References: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
 <20250819130231.181571-2-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819130231.181571-2-mateusz.koza@grinn-global.com>

> +&eth {
> +	phy-mode = "rgmii-rxid";

Does the PCB have an extra long TX clock line?

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

> +	phy-handle = <&ethernet_phy0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 11000 200000>;
> +	mediatek,tx-delay-ps = <2030>;

Please try setting this to 30, and use 'rgmii-id'

	Andrew

