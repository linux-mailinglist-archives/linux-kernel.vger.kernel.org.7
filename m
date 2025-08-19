Return-Path: <linux-kernel+bounces-776141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B39B2C907
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA49E1C27134
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2D2C3276;
	Tue, 19 Aug 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kGPqj6NC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79632BE634;
	Tue, 19 Aug 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619446; cv=none; b=JstfVktj3zNeVm2xzbWxwpg1jsTpBnao+FApG0claON6jPFYCuM+PTFPIzjHM5M8ShXcCfp/gPekVKmbJKNUUGbJWRNNT+B9M2c08RZfo3KVSZ5mHgilc6DT7RGsBFVG68A/+i+N087lQEg2D1gQyuJt5qtvTwn3iWRj4eIbmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619446; c=relaxed/simple;
	bh=wLvfu74oK9PGxpv8iFgmi36eU1aC/XOa2NPyXzmd7YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEsNpKPz0WCoueOllhINl9rmtH5uepzFNAFMtfEG0quSGPjwuQnQrMgitKGAT84vhp+Ekj1oZglZafi285+6B5+cOdj3QrlvvLHvLyQP8PmzWWxB8z2LOFWe5LfLyO1teoaBtShZrO9Ne4y3outgJJvA7S9Lrbolca2pXZbmp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kGPqj6NC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N+7flFK2RUnxDqXCVUqXaa0V2OFkhUFUQMezuL5yE6g=; b=kGPqj6NClAqPHS8M/uA71K3oTt
	5MMCYBEUXDle2yjsuFbQEh7VjoHgYOYDaXwJePFOVYZZXqpTboYge93ACdlVVY491QRd5gB5rXo+M
	z+BLiNLxqgQmBq81fCsuRTOKUnm3EgA0wJQidIcDFfGfc/zg5NzLewgbUfN28Dv94Dsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoOoN-005D7L-1y; Tue, 19 Aug 2025 18:03:47 +0200
Date: Tue, 19 Aug 2025 18:03:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dongjin Kim <tobetter@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay
 value
Message-ID: <4d25c642-d457-4cb7-8bc1-587edd4f1d75@lunn.ch>
References: <20250819045018.2094282-1-tobetter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819045018.2094282-1-tobetter@gmail.com>

On Tue, Aug 19, 2025 at 01:50:17PM +0900, Dongjin Kim wrote:
> Very poor network performance is observed on the ODROID-M1 Board
> (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> this problem can be resolved after changing the value of TXD
> timing to 0x35 from 0x4f.

How did you decide on 0x35?

~/linux/arch/arm64$ grep -hr "tx_delay = " | sort | uniq -c
      4 	tx_delay = <0x10>;
      1 	tx_delay = <0x1a>;
      1 	tx_delay = <0x21>;
      2 	tx_delay = <0x22>;
      4 	tx_delay = <0x24>;
      2 	tx_delay = <0x26>;
     14 	tx_delay = <0x28>;
      1 	tx_delay = <0x2a>;
      6 	tx_delay = <0x30>;
      1 	tx_delay = <0x3a>;
      3 	tx_delay = <0x3c>;
      2 	tx_delay = <0x42>;
      5 	tx_delay = <0x43>;
      2 	tx_delay = <0x44>;
      1 	tx_delay = <0x46>;
      6 	tx_delay = <0x4f>;

The numbers are all over the place, but it is clear that 0x28 is the
most popular for some reason. But since this delay values are magic,
i've no idea why.

     Andrew

