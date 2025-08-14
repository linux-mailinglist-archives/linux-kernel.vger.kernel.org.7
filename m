Return-Path: <linux-kernel+bounces-768352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1574B2603E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EA31889E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C92F659A;
	Thu, 14 Aug 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlyaO6Zn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA52E9EC1;
	Thu, 14 Aug 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161941; cv=none; b=Po5wD0xMQVB3yhZQFjtNuawD5cR0rnJwTxUeHFDmMCu3CevepN03186EQ1rf7dtzea1bXfzKOJZOz2U0eNszw0ZPA2k6W0l/kQgq9Xyi6VrWE5hE3QKXYISR0KgAMXoVfwKq+X5PV41JE5zOcK4g/T2v2lLOsuPJc+sjoKFQrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161941; c=relaxed/simple;
	bh=UqiOEQj4i7jq9yn+tRZlkfQENRqT5RSvuuePfqVAfHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCADOkjrn1+p/8WM32h+L6S0MYTmAIgGlVUfbGHy9d3aHtYq7YOu+iSLVqvy1yvb9h0beEkXCy4LeSLUc4cETw+4rS7eHbF3M+6rjfP3ZabBXvyXdJ/vtO4R8PZhLfuQCzgYri9L5Q8XpY0xMYHPEaPs9oA4IRWJqLlkOO3Q1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlyaO6Zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371CC4CEF6;
	Thu, 14 Aug 2025 08:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161940;
	bh=UqiOEQj4i7jq9yn+tRZlkfQENRqT5RSvuuePfqVAfHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlyaO6ZnyoFv5m2v+JvsKLu9jmln9w8fn0/ZeuMm9bjuEJ9t9v83UMBa+nsfIzP49
	 2wbVfS6OCrUi4p2lx0b36JyDfuqHX9pHAbGzm+F3oTFAuD8iZ4VVbIBKN2QO1HAS6Q
	 iebEJGom3+H/UQNbwPKNPAGmBF+/cXdzeTn0jm9smawZ2nNduSr+Z8JGAucPoYh5sw
	 Ea4ZyNkyyCwVT8Wz/GWGPhlMk9Wd67+sDP55nvJGcHDUZNB4TxyReslf3CNGrWR3V1
	 V2PkcCsSZ1t3us4Ov1SOTQK2511dHCuI3zegeBBQpr+Lqg2jxQpBOhfgnhWFA7Hxda
	 76yQhhVheEktQ==
Date: Thu, 14 Aug 2025 10:58:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
	Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: spacemit: introduce i2s
 pre-clock to fix i2s clock
Message-ID: <20250814-whispering-kickass-sunfish-be49ae@kuoka>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
 <20250811-k1-clk-i2s-generation-v2-1-e4d3ec268b7a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-1-e4d3ec268b7a@linux.spacemit.com>

On Mon, Aug 11, 2025 at 10:04:27PM +0800, Troy Mitchell wrote:
> Previously, the K1 clock driver did not include the parent clocks of
> the I2S sysclk.
> 
> Otherwise, the I2S clock may not work as expected.
> 
> This patch adds their definitions to allow proper registration
> in the driver and usage in the device tree.
> 
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


