Return-Path: <linux-kernel+bounces-889901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC10C3ECB9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE634E9CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028130DD19;
	Fri,  7 Nov 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqxM4/I3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5D30CD94;
	Fri,  7 Nov 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501457; cv=none; b=hI5H+1z63HzlQKk56FngA+amSgkhpEguSdOWLhlc5mXEhhgHOViudCC+jaePuuHo+eyLJr6tB8Inm7Hy9WSx1MHuVhtiIgbETiAgGNEcTkS+gaMQxJoS6J6ACFPHU7XPT7yaCbC1lHZLldXrANJ8XYDUjLkS41SmeZnGAzzmx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501457; c=relaxed/simple;
	bh=xv1qBxVhmD0FZwRQLqEuOb6rjOT12ZE6uVVaxcXth6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFw+X2vdBC2b8tvcXxq1aAG6UeTnvRg1FmsI++kvBwN2NSn2p+K0CL1G+Jo777VBN/ihprWu7zS0+T3WS/sFcsEzFjPFA5DE/Bg0B8AfO301ZAS1XGuJF7j6iTC71GpMAwsTgtf0su5AF4NrccpSbDw5py8Cv+NSVt7S7ZO+yOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqxM4/I3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D8EC113D0;
	Fri,  7 Nov 2025 07:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762501457;
	bh=xv1qBxVhmD0FZwRQLqEuOb6rjOT12ZE6uVVaxcXth6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqxM4/I3Npxa9woU+uSxt6RePMdvi3em+ku1eKC8VFOSybOTQ7QNgqHj6Ws7sdXN3
	 M+kL9x7g+yn/6wTu4CIrSBXwpXUE4mQesIsna/IKgeX9kpGUNwEtblrCvC5UOQr4pn
	 GbTS1dilZA73tx6XtsSv2AN14aDOSfN10CsvTMy0j64wVNTlCn1b/cJcghGcZlq1es
	 KgXyWsqcuJdCRoS3nz98b2fZZfeosvcD1OCfh+qzmS8cZga2b0nN/sZphI7x6GEB8n
	 R6yxbbk2ehWqp5WS5zGFFcSXK+dAxBj9ro4NvokzKn498P8dA+GxAVs6QE3k/t0gPS
	 uF0jw+2TDeh7g==
Date: Fri, 7 Nov 2025 08:44:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] clk: en7523: add support for Airoha AN7583 clock
Message-ID: <20251107-dramatic-puzzling-cockle-cb9781@kuoka>
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106195935.1767696-6-ansuelsmth@gmail.com>

On Thu, Nov 06, 2025 at 08:59:32PM +0100, Christian Marangi wrote:
> +
> +static int an7583_clk_hw_init(struct platform_device *pdev,
> +			      const struct en_clk_soc_data *soc_data,
> +			      struct clk_hw_onecell_data *clk_data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *map, *clk_map;
> +	void __iomem *base;
> +	int err;
> +
> +	map = syscon_regmap_lookup_by_phandle(dev->of_node, "airoha,chip-scu");

NAK, undocumented ABI.

We talked about this last time and you just ignored entire discussion.
Nothing in the changelog explains why this stayed, why our discussion
was resolved like this.

I already complained about very poor changelog and lack of lore links
and this just adds on top of it.

Best regards,
Krzysztof


