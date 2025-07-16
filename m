Return-Path: <linux-kernel+bounces-733113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9159B07050
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22467A2866
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB82E9EDD;
	Wed, 16 Jul 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDcIb0sR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BB291C3B;
	Wed, 16 Jul 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654106; cv=none; b=R3KG+4pzXY6EFQRY2i5nhLxzEMDj8rMTHWnnvMu9SYLVcx9ylOALbyvLyklp1hxtnLekiKo02byLxPIjDRhCwfFGpfLNgciLYKGRqCfIbqVR12+xwC82xfTE3031/+munxYarUGpIwiCsaz3fPEAot/0/0Uay6XN0n0izjmVJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654106; c=relaxed/simple;
	bh=WFDobUiu1Nd43r6dikjiTbbFv38dHAAytYCHWG5v6TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFVm2K6MHbLhAvxMOb2+DquV5JzEhKJnbLETZ2AGrHDzEpeZGHg04OdUg1nwLU4RmFYmkWop1LiC86PjbptPc9mImAE3XEfBNiuWCnSYqtyRnnrOMX+3TtcbcQ+Tl0qNYTkaToGCVkCcZ7ZPV2F7ujNFCWYSgNiQiDu33eZmPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDcIb0sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0254BC4CEF0;
	Wed, 16 Jul 2025 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654105;
	bh=WFDobUiu1Nd43r6dikjiTbbFv38dHAAytYCHWG5v6TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDcIb0sR0K8DHNBwuF3l6zfjuhEd+srpTrUcNN5vM26ynlP8Rapji7XnX3ituaxfv
	 yhHLARSCd4vO8do4/x/xokvvPcPsagYw8XC8YZMWS86u/kZzf0uL+lS0ldVPJI9pGs
	 BcdTW0baB8Y7WwPzvSqC39dhwz6XGPDWwtwPat0/ZA2I7F6qnDMi6YLXwNp4ENPiGa
	 hzuDBsZLIr2l4AdyYD8CrCiGXzPiUI+M1r/nxsfSpG88+LwyYqN3qrn7J7b2bvBJeH
	 mfMjVJOFMAQlyeMGOHnSb9T/9y2gdK1pLfJ+CI4mc8FQ+zKbaDAdY9CfN+IWEiCBDE
	 HNp8KE63b6YwQ==
Date: Wed, 16 Jul 2025 10:21:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: aspeed: Add parent
 node compatibles and refine documentation
Message-ID: <20250716-spotted-spirited-axolotl-c94e0b@krzk-bin>
References: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>

On Tue, Jul 15, 2025 at 10:42:58AM +0800, Ryan Chen wrote:
> - Add 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
> strings for parent interrupt controller nodes, in addition to the
> existing 'aspeed,ast2700-intc-ic' for child nodes.
> - Clarify the relationship and function of INTC0, INTC1, and the GIC.
> - Update and clarify documentation, block diagram, and examples
> to reflect the hierarchy and compatible usage.
> - Documentation and example refine.

So 7 lines describing obvious - what you did and three lines below
describing non-obvious, why you did it. It should be reversed.

> 
> This change allows the device tree and driver to distinguish between

Why driver needs would matter here?

> parent (top-level) and child (group) interrupt controller nodes,
> enabling more precise driver matching SOC register space allocation.

This just does not make sense. You do not change "precise driver
matching" via bindings. You fix driver. Especially that there is no
driver patch here at all and aspeed,ast2700-intc0 are totally unused!
Don't add ABI which has no users.

Again, you need to start describing the hardware and the REASONS BEHIND
from the hardware point of view. Not drivers.

This change alone based on above explanation makes no sense at all.

Best regards,
Krzysztof


