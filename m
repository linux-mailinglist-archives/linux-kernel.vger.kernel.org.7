Return-Path: <linux-kernel+bounces-827569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA04B921C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD80442132
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9F310621;
	Mon, 22 Sep 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLzft7lF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB3215198;
	Mon, 22 Sep 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556939; cv=none; b=JjYvftIcjqpgQeoWXZxMl1F1AdOU+48UHZjEU3G2tIczT54KFTQmnGIj9pP9bNkoIqmxg/33pn4NK/he7pvADE8+1kc5IF6+O/RRU/KM451fmSjC2imWBupBhm1NlAZFCB7sX5458PC8KDbKv6zU2ZH3dwUWKP6VcR4HECvIM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556939; c=relaxed/simple;
	bh=2/LizJClL1wBMVE5bMlfqc3v7W3h2uppscfEVfjjaKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8I4uy0sHNBia3fiFZTIJyKWwHIZh5WMFoSvYQRFKr3W1+kuaGuDNt0IL7yyvoYGSHlXu412F4VHxmywIiEVkMO6GMl+arKgwRmaW+VgqLwBwFZXz1Uga6zGFa5szDfNIjSvNLsZXBYqLysCP1zR7KGaTYQPU8zf9r3jrQsOZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLzft7lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B668FC4CEF0;
	Mon, 22 Sep 2025 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556937;
	bh=2/LizJClL1wBMVE5bMlfqc3v7W3h2uppscfEVfjjaKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLzft7lF6rvhOI4icdGvNJkM9UQviI0U8bEF7gne7g+Bvp3NY6JOzPpfSVrFmKB/g
	 aM7FWa1VE9oXcgJv2H1NrN5XhgfoyEEVGf0fiqK6szQf93VDiWO261HpnUjCquQ3oT
	 SieqwDC7RuoMOWm0AjYdLujrUr9yqdymL4/pccPNctf0vo7kbEp4Mj3RPfd2P8ZcEt
	 b9/3e3+TsWX9sv4lQFjLOlgYTkoMjeDW/KgAsQkt8Ix2DFCEbnUXLfpQhljn5KO2i0
	 sccL/cofSQX4GfDfvz5eYWVuWgp8xHAQ36dkxtE6nUDgGXJyI8QIQRbRPSs0mnCwUW
	 Bl1uSZjfoX/vA==
Date: Mon, 22 Sep 2025 11:02:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-clk@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Brian Masney <bmasney@redhat.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] dt-bindings: clock: Add spread spectrum definition
Message-ID: <175855693542.119673.169928379758722249.robh@kernel.org>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-1-5a2cee2f0351@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-clk-ssc-version1-v4-1-5a2cee2f0351@nxp.com>


On Mon, 15 Sep 2025 16:29:35 +0800, Peng Fan wrote:
> Per dt-schema, the modulation methods are: down-spread(3), up-spread(2),
> center-spread(1), no-spread(0). So define them in dt-bindings to avoid
> write the magic number in device tree.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/clock/clock.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


