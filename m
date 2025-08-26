Return-Path: <linux-kernel+bounces-787353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD3B3751B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26051BA0F91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692422D323E;
	Tue, 26 Aug 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzqEImEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC985199FAB;
	Tue, 26 Aug 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248821; cv=none; b=Si83SbpP6TguGjNK3MRKSN3UrMGotzlKvpa26Ju8IaxOeE5MldjVox5/NRLrup6QaGQ1n27vEPpuBE+mEqeggXw5fmntELJ31RGJekJLm/fptFXjCXnArWeE7+wh6sEWlK8iHGevJjmYgkFuA3GtrHEovzxDAyDfX0XTHhjeh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248821; c=relaxed/simple;
	bh=HFz4lWMhublzt2u+So74Nn/ex2HhHH9QGaDvdeT52C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqg/PimWiUPBg/ALBB7n6gsNlNC75VBAVxhcACCWpR20xB1lKYJcBgEoXkVOfmEK+LP6O9jGNP2WWVd4lnyOhtK5YsLK4jvwhe/mBU4w1TLICWrg3zh4Yj4Ns8GVFiXVXCJ+3Lg4xbhI9RL4Qg+Y1o2Q4Q/2pZ6hQ3TPtueG/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzqEImEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB2DC4CEF1;
	Tue, 26 Aug 2025 22:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756248821;
	bh=HFz4lWMhublzt2u+So74Nn/ex2HhHH9QGaDvdeT52C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzqEImEd/wn+wMr3RXHc4YnqD9MqtoakG5cFDI0b3cq7YAWYOcroywG9cJ5lMJhRU
	 y332TOx71EFetZf1Xr/4sbGaZMXzWTXn5FvMGNo5gX3VGEcO2/z95LVTGIMAPcTr78
	 pxXmD46WtOt5dmV44Tb7O4yr6DS/gHN/+3tefkBbE/asejRq6A23bWJXgVCNYX/2Fr
	 zfBuaxF5TvPSVgZbCXSUxPb3ulXvE6ssc65KmDhv6O/oRW3YJWsV9UipTsk4T5O/RZ
	 KL2Bgj9zA8PeBG/Bsggw+YlCAKjqh6ELavtp2mDGy3+77DEijThMTvX3npVKgKqjjx
	 Va0Yg6/lBmGhg==
Date: Tue, 26 Aug 2025 17:53:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: apple: Add t8112 j415 compatible
Message-ID: <175624882021.642528.5469480421650316999.robh@kernel.org>
References: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
 <20250823-apple-dt-sync-6-17-v2-4-6dc0daeb4786@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823-apple-dt-sync-6-17-v2-4-6dc0daeb4786@jannau.net>


On Sat, 23 Aug 2025 11:49:47 +0200, Janne Grunau wrote:
> This adds the "apple,j415" (MacBook Air (15-inch, M2, 2023) to the
> apple,t8112 platform.
> 
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


