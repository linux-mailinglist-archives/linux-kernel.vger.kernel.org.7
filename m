Return-Path: <linux-kernel+bounces-792208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B881DB3C176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B0AA22EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D9335BC1;
	Fri, 29 Aug 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTLItRsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838A30ACE0;
	Fri, 29 Aug 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486994; cv=none; b=hlCHqQsVaFZi4ST+aTWy8vQUJ2tLosicBcUEW07cSz3A6gH4pJ8c4NORQNhEFxQXBXVdIXc27v4sv+pZ+qRjR8EQyaZIVUdF8jrko2gIQo6UjAGc59qUivd5eI2AyZjjD9rYiK5qlZX7dIqd6+08NElgZ5hIwg3dZKIQAYA47Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486994; c=relaxed/simple;
	bh=mg00hAcdTEKrZbDjJvlMNVxsmu4kekuMMAOA3bFgL+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVWrQgxRQW446LD7KtlTajAp0jNNPgRHmrAWIO87KnqgDxWgDmXYwO3ZGFJeAz+3xLW5KSOZZOVO8UAdZVK1kRnr1caL6tPQAwKu1p2dRdXeZZ+4+JwaJfO7jFePNNBww5XCL+gKmxn9S8VrKNi0Z55SUM9y8k+oDqzJ/DylCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTLItRsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58EAC4CEF0;
	Fri, 29 Aug 2025 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486993;
	bh=mg00hAcdTEKrZbDjJvlMNVxsmu4kekuMMAOA3bFgL+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTLItRslDoL24OhCDEqAdoRxD2ix+zqQ7YEiFTOKmfu6YZT8f0P4X2bkM80DnA2U5
	 egq7/J0XFJhqNegZH+GBlCa39LTyegzI22SA+cJSJpRc7reYQmgmM1CXAyCZwh3W4s
	 WRs+K9sL4ub/kWZSRjZfAefUvbHgW14v6G9duzjKL2YEbX8++spoaifZuPb6FvvKgo
	 PgXvM8C4paWUf8Wa5P7gO7ZnTelCsoJixU+yRu72Cq3SPGqkPYfRhkP0QgpGwSFPEg
	 uAy3Wg0KHn+iW9mrNsYZ6X8V3QABHKovLLrW2eFdJTYHd8xgEleZwt9aXTkwoYJO5X
	 plDIVPWjpoPRA==
Date: Fri, 29 Aug 2025 12:03:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	"A.s. Dong" <aisheng.dong@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: fsl: fsl,imx7ulp-smc1: Allow clocks and
 clock-names
Message-ID: <175648699220.1015931.794754455912475003.robh@kernel.org>
References: <20250827212446.94571-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827212446.94571-1-Frank.Li@nxp.com>


On Wed, 27 Aug 2025 17:24:45 -0400, Frank Li wrote:
> Allow clocks and clock-names to match existed dts file.
> 
> 'hsrun_divcore' should be 'hsrun-divcore'. But use '_' to keep old dts back
> compatible.
> 
> Fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx7ulp-com.dtb: clock-controller@40410000 (fsl,imx7ulp-smc1): '#clock-cells', 'clock-names', 'clocks' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/arm/freescale/fsl,imx7ulp-pm.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


