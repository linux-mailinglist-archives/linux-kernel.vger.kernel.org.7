Return-Path: <linux-kernel+bounces-795357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4FB3F084
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61D47AC7D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D227BF84;
	Mon,  1 Sep 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7+IhNQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8927AC43;
	Mon,  1 Sep 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762286; cv=none; b=G+w6BKUQsAzcOWWI5N/7CnN1FPo+Kp4QIJmnzLGQkFr4eRaajNosYitBNzYm380xjMk/9qLE8kvUf3AwnUaX2pqXjboe49amXlWGs2AHU6ZP3Dr3rYAQhjzuZnTVMmD7en7Bm4vm6Zx2u4W0j8zPE69KCI5Kxfs4JOQSQ2aNqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762286; c=relaxed/simple;
	bh=pYGx4Z5PyQy+FBk43EbI6DGF/1qa7cKPoVZH27D9KxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/Vqs85Mdl7lj5wjuyW5626lbT1Rb8ZxnvUJM4NEfgdnFEzVAO+e0L0ykwVlS5zIXPucSNSG+WT6x/SmXMmRd3IGZWda6J2X1KmbdO9KadHF0Ke0644Qn+LalkkNrgHv11kZ2TRPkKWa1IfOkFiKrNIYXy/G6UUdqxaTFh4QlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7+IhNQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB72C4CEF0;
	Mon,  1 Sep 2025 21:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756762285;
	bh=pYGx4Z5PyQy+FBk43EbI6DGF/1qa7cKPoVZH27D9KxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7+IhNQks9WAXZh5dRfApNnaOoV8N2Yw80HEtMQu/g4rLqCguPt8jS0WTUYBTj5/Y
	 KDeyInm5+0uybxPJZd+FrYZJt70C3XHEPUJEVMkZfU4zbbuuKlpKZLizqloRa8HFen
	 4BtqPhknnurexE1dUVYnsS6rlhXdEAghpZY/DaNbyFK6320VHLpK+fLzA3If/k3QRi
	 M5i2b/ZcLyJ/8X955S1jvqfjiiRqpJ8Q19++YxlKcCrT14384N7lHMdp0JvmagHAPA
	 UMvy8VF5Jz8uj7uwuBfBcHMtv+cE+/GRVIaTIFKzgr+m2TJSbUT6fzksm+3pGLfIuk
	 XNCaMiH81IKnQ==
Date: Mon, 1 Sep 2025 16:31:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/8] dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU
 CCU clock controller
Message-ID: <175676228396.377947.13021468225327496814.robh@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
 <20250830170901.1996227-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830170901.1996227-3-wens@kernel.org>


On Sun, 31 Aug 2025 01:08:55 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> There are four clock controllers in the A523 SoC. The existing binding
> already covers two of them that are critical for basic operation. The
> remaining ones are the MCU clock controller and CPU PLL clock
> controller.
> 
> Add a description for the MCU CCU. This unit controls and provides
> clocks to the MCU (RISC-V) subsystem and peripherals meant to operate
> under low power conditions.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../clock/allwinner,sun55i-a523-ccu.yaml      | 35 +++++++++++-
>  .../dt-bindings/clock/sun55i-a523-mcu-ccu.h   | 54 +++++++++++++++++++
>  .../dt-bindings/reset/sun55i-a523-mcu-ccu.h   | 30 +++++++++++
>  3 files changed, 117 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


