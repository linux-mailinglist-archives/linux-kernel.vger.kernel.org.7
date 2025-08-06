Return-Path: <linux-kernel+bounces-757394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A0B1C1B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BBD7ACD43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185D217654;
	Wed,  6 Aug 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSm2SjEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0319D092;
	Wed,  6 Aug 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467282; cv=none; b=WMpqBL272eFZpdznN6lVHDIPz0au/YoV4xwVkU+IFg7jYopzFmXTILcBt/Yl5XPPn3zHqrTPXlnHh2imUArvfE1iIl7IYa54M75hT8Rj/4WFXRycLF0b7dFQCu2EUaT6r5IdGt5/B8A+IL0Xe7wf005CIbnPpZbST1+zlSBWhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467282; c=relaxed/simple;
	bh=6UhUEqB5zUWrUJaIZUr6ZCMybHfzLK+onh28xTaTaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx6hxrWXzb4a7vqHwGPOdfOd2HLAfmLYpHRiLrD8CbPaCeMHtwBRSgiaWr7MU32nhiAQ0vTbHEN3vOLZsXAMljg1Q4226nbUXM5CedWyvXdk6flsRhsM9IDXdB9cGgafPrRMSegvc8Kp26/i5rxXQO2JseMavWvzP5L7V28z2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSm2SjEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C68C4CEE7;
	Wed,  6 Aug 2025 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754467279;
	bh=6UhUEqB5zUWrUJaIZUr6ZCMybHfzLK+onh28xTaTaPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSm2SjEyotdCuxepfN5zSHXLzO6tn2yWyH5fY4bIBuswIVop0zgl2rN1lt7tKC9Ls
	 jumzBit81toImP8A3a3wxsVBI3nJKPlJMgjgTWrhFTDYPfVxDvD0bNGHGJ64RLijqz
	 9dJmYIsOBy8gieZESNykSGvE6ffuF8wtnpQs8L7TBmYmq86gcG60zP7PA+n4Hpw4nf
	 MoglhlJ4gFpDJjz5Yp81ewi1DuIf+ALrbb5HXS6AQOn2dHxs8mvTay6mp3aHepIb2R
	 ktFbDGg/A6VeQ6Tl7f0fW2esJY4Lpss3MRrWv3qMR3hOPecIfGClGWL2OK3mdJKhA4
	 xxdE/+Xo38UaQ==
Date: Wed, 6 Aug 2025 10:01:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: loongson2: Add Loongson
 2K0300 compatible
Message-ID: <20250806-ruby-polecat-of-imagination-8b0a34@kuoka>
References: <20250805150147.25909-1-ziyao@disroot.org>
 <20250805150147.25909-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805150147.25909-2-ziyao@disroot.org>

On Tue, Aug 05, 2025 at 03:01:40PM +0000, Yao Zi wrote:
> Document the clock controller shipped in Loongson 2K0300 SoC, which
> generates various clock signals for SoC peripherals.
> 
> Differing from previous generations of SoCs, 2K0300 requires a 120MHz
> external clock input, and a separate dt-binding header is used for
> cleanness.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/clock/loongson,ls2k-clk.yaml     | 21 ++++++--

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


