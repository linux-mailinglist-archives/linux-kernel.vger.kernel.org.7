Return-Path: <linux-kernel+bounces-817767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73EB58645
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4203117D3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A6283CB8;
	Mon, 15 Sep 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJkfs+JI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54B2E63C;
	Mon, 15 Sep 2025 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970101; cv=none; b=KOcEEr0735e1pARz93IuzKTiFSnst6ZGZoXTsNnPvlU9JRweVdVOFh0UVt4wnvoP5nsaBNtMitP1XyRzUmhX2NqaK5DwDt6zVXHjEI1MIEmTeuwnfG8+meF6KusFD2KCnHO/ZaXkCqZhIdsA2T7R2QLRXFbdrTRWPvc+N8P4bZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970101; c=relaxed/simple;
	bh=xX1+Xzo/jnAGqPyi6iInTfds1bV2ZowlmfSy9qbmmH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5vJD3wNIgCNL3TxuOSS4Q8uwlpW+SkXQd5Vj2YvkiCqnHRamSdDM1zw2gjxlPWo3QCa3XeGw3vqIl5lxBwIyQ2tysx7vvPO/Hf1h+Zp2+kug26dQAwNPYhqcpFLYoaJHsi1TCSaHpcNCfKyFx4pMedZ7gPRuBIEvbF4VTCsxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJkfs+JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC465C4CEF1;
	Mon, 15 Sep 2025 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757970100;
	bh=xX1+Xzo/jnAGqPyi6iInTfds1bV2ZowlmfSy9qbmmH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJkfs+JIKfs5Jf8AGEvLxosKPDC29qQYBhJpbj/7gDmI0w1JtX6lFdxC+EqxUjiur
	 w4ConOZpT7DRJzawNlbc3+1s3G5WHKlGGp7v8MFu8uGlUFa+5BKydGw7uGCWqNuGgb
	 tXKpxDwfkKoyjICqOIdo3nyAcumGzXLDH/JKwAE0nOzo3We8LIHST/uCQe8nQhy7YJ
	 wXTj7Cye5eguUl8fUndI318DYAo0jjPL2GQMR3S7oAaB/psB/HgcKuJ/hfu7IOtRo8
	 4t5Rv9dj7yHIBRs8G2lK9VE93Sso1E1T/NitRsT5w0Pv6RfHMPRazZNP0hFSybkkZJ
	 7X33ctnoqRx0w==
Date: Mon, 15 Sep 2025 16:01:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add Amediatech X96Q
Message-ID: <175797009935.3384023.4009992725320048640.robh@kernel.org>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912-x96q-v1-1-8471daaf39db@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912-x96q-v1-1-8471daaf39db@posteo.net>


On Fri, 12 Sep 2025 01:52:09 +0200, J. Neuschäfer wrote:
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
> 
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


