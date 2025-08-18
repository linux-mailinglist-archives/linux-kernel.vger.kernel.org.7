Return-Path: <linux-kernel+bounces-773699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4BFB2A662
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359D4189DA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527233473B;
	Mon, 18 Aug 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzKL51+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8927B334;
	Mon, 18 Aug 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523733; cv=none; b=gbWdhQIXDzdKYrHjyUn10Ew/mnokHIgHGPTUXJyXLGVKXtrv86HtHHonRiIq7bF0XLVchFo7ghNUiOnGHZ9hkmneQnJcfaFm7VjauDRtZwdgOx3LsAixd09A/OoJnF0t0GXRMejdjt9CQZHn0pQssLO4LoyFBnJyt1pQ08eiJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523733; c=relaxed/simple;
	bh=RBe2h9lREBKMOmk9gFLPEM/Gqn8YS4oH4RhZ7ngYXOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AstJAK+v0aBJjG+GCzL+imEaG1l/CK53OCwAwXJ0EOe8q8VjZst4naxtbeIdWYdlQ/J7zKilzRZmlKNKrt2T0j8GtO+qfC3XGop7noRK6Irpapf/hVqTcnTz0ZfsogQ0d+D7zSEJJixaaKFTYvd2/4qCMNRz/UwMEK6gHazhDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzKL51+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F16C4CEEB;
	Mon, 18 Aug 2025 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755523733;
	bh=RBe2h9lREBKMOmk9gFLPEM/Gqn8YS4oH4RhZ7ngYXOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzKL51+l7SeFj7U7Tu6qmnCM0DnKHgZbXB2R5bG+feymwxfsZPoEhbY3NNAOrd+j5
	 rYTnggDp0uvf+rEIvs5bDyBqFi5zSlBUX6Ul41V6VH5v3anL8D29xazLs7nnVS7yWx
	 XnuU3+glg5x90JJsU3smQvLEmWLhfGj/RFpcZ+HaDw0zf58CjP/aey0OETt4jPGXpD
	 GIuxyxGJeWcbnjFzi4N5NmjKzUaDG6Vud2R6Kbiwqd9CWHMUmymLc0B6pevLjVLc1v
	 fPqGLWBLn6NkdHFX1/GM7PL+Rkd75t+AT9GqYGqjHABQYavWpIIlvgPlcgCTior7FU
	 M+i6djJxKbmgA==
Date: Mon, 18 Aug 2025 08:28:52 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 0/3] Adding device tree and binding for Nvidia mgx cx8
 switchboard
Message-ID: <20250818132852.GA882651-robh@kernel.org>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
 <175530106151.3523036.5305359646677111575.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175530106151.3523036.5305359646677111575.robh@kernel.org>

On Fri, Aug 15, 2025 at 06:38:54PM -0500, Rob Herring (Arm) wrote:
> 
> On Fri, 15 Aug 2025 12:45:54 -0700, Marc Olberding wrote:
> > Patch 1 Adds the binding for the Nvidia mgx cx8 switchboard
> > Patch 2 Adds dtsi's for the mgx cx8 switchboard itself
> > Patch 3 Adds the dts for the mgx cx8 switchboard motherboard reference implementation.
> > 
> > This is an Aspeed AST2600 based reference implementation for a BMC
> > managing an Nvidia mgx cx8 switchboard. Dtsi files are broken out for
> > managing the mgx cx8 switchboard over i2c, so that others may reuse these
> > if they choose to implement their own board. There are two dtsi files
> > since the i2c topology is not symmetric between busses going to the mgx cx8
> > switchboard.
> > 
> > Reference to Ast2600 SoC [1].
> > 
> > Link: https://www.aspeedtech.com/server_ast2600/ [1]
> > 
> > 
> > Signed-off-by: Marc Olberding <molberding@nvidia.com>
> > ---
> > Marc Olberding (3):
> >       dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
> >       ARM: dts: aspeed: Add device tree includes for the cx8 switchboard
> >       ARM: dts: aspeed: Add device tree for mgx4u BMC
> > 
> >  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1078 ++++++++++++++++++++
> >  .../dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi    |   80 ++
> >  .../dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi    |   80 ++
> >  5 files changed, 1240 insertions(+)
> > ---
> > base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718

next-20250521!? Why are you using linux-next from 3 months ago?

Base your patches on the latest rc1 unless you have some dependency on 
post rc1 changes. Usually that means you need to base your tree on the 
maintainer's tree the series applies to (ASpeed in this case). 
The *current* linux-next is a shortcut for that.

Rob

