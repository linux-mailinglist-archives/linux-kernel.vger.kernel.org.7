Return-Path: <linux-kernel+bounces-796631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC169B40492
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6921162330
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127B334710;
	Tue,  2 Sep 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYah2HEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5732A81D;
	Tue,  2 Sep 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820203; cv=none; b=k5+8eJsMlTC8jnFn/g71Y1mo97MHLFH6LoZCP5l6qlUSEv2m8rDB8r2KAV06tvtXcPLZoAUp0NCDJ5NQNkCG8dRqwkto2kDgVagdJa3qn2bahnfscFOVHymD2PYNJjKJHLPmYmR1Gzq4Rwyd9Eq93QwfgVWpdYl9U1n/VfHFLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820203; c=relaxed/simple;
	bh=Z7VRLkLIaiLIAa6wk9u2fF+pQfwD1XWt+K4SKpchlgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIpohNKytOGj2gIidYsq9uSiU9M8nw29i/a4Azfck40QUo+qCEPxh1i7HlDZwEvgvuh7EbeAwXuhGzd6AuM1tMQjGzDXe7vaC1cLx/QGR1R0hPLKiSpwVx0nvFSzUDUD4IMIwr+ERDeYTfGHv9vUB2zNtKGaRRdB7I/rQWJywSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYah2HEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C556FC4CEED;
	Tue,  2 Sep 2025 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820203;
	bh=Z7VRLkLIaiLIAa6wk9u2fF+pQfwD1XWt+K4SKpchlgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYah2HEMyor8pWpo2GMyFsi4vh2wZRtT6cruQJ2Gs1oevj6Hb/zM08qzMEwGlNyU4
	 MGKhgAyFacLfWBd8AgX9O1Y/OGhErCdzrIXKk1quu18LStSuRdaAfzWj+pRSrFKjjP
	 jaOS7SMTesZdAZklPYcxkyGRQOYNsLUCpy5WJYzsbykKSwhPFDYazJJDlQZcTHJ3CK
	 figXHRDxIApc/uHxlvqarzaJw7+v9qreTYUrb0YsDGRKrnAZ7731ORGPoIiGt6ZdOs
	 0XnHUbypoUL00Nlh0rm4rSHePDhwcVXnM2EwWU1lqVINTRPJGPCaGB+lAJv13eWxZQ
	 gJD78fh6wstVA==
Date: Tue, 2 Sep 2025 14:36:38 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mfd: axp20x: Add support for AXP318W PMIC
Message-ID: <20250902133638.GO2163762@google.com>
References: <20250813235330.24263-1-andre.przywara@arm.com>
 <20250813235330.24263-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813235330.24263-3-andre.przywara@arm.com>

On Thu, 14 Aug 2025, Andre Przywara wrote:

> The AXP318W is a PMIC chip produced by X-Powers, it can be connected to
> an I2C bus.
> 
> It has a large number of regulators: 9(!) DCDC buck converters, and 28
> LDOs, also some ADCs, interrupts, and a power key.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C only. This covers the regulator, interrupts and power key
> devices for now.
> Advertise the device using the new compatible string.
> 
> We use just "318" for the internal identifiers, for easier typing and
> less churn, but use "318W" for anything externally visible. If something
> else other than the "AXP318W" shows up, that's an easy change then.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 84 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 86 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)

Looks okay.  Let me know when you're !RFC.

-- 
Lee Jones [李琼斯]

