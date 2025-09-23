Return-Path: <linux-kernel+bounces-829635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3CB97823
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12458321330
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541930AD00;
	Tue, 23 Sep 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAp0hiTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2822F1FE3;
	Tue, 23 Sep 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659853; cv=none; b=mtdjBkkP0+IP4+/cTC7xpAcd6cirQLgVn+j0bBrenGHSDtNaR4AkF8GReX1o84KMW28zGnaznyMp2AYyFTpgcVXMqp5gUU5luBlSUg5ZRKGf2GVtU7cDrMl3skK9eseBJiZPtN4CpRxGlzPZBbDc7saJ3Prj5l55chsGr9EqHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659853; c=relaxed/simple;
	bh=YVPW5Ye5cNxlVyFYg/ZSnJCoFg8irtMONWQvci2e5sM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pMaBKWT6DXfFW1yVUzZ8iE24H1a5ZRsaC7JLHkuMDsy/8BRv+XhsA1+tCx+jPnnAmaKdPp24RmXR1lDHLF2CPI0tqHsswzpbOd2xQqbaWyjXEIJAxy3emgHTVgWxd4psYKWqnuAZZZI2j7AiPncfneP8WO2adbxKBzlcNtw10Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAp0hiTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C4CC4CEF5;
	Tue, 23 Sep 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758659853;
	bh=YVPW5Ye5cNxlVyFYg/ZSnJCoFg8irtMONWQvci2e5sM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=BAp0hiTTP1m4ZZ9hKJWEJ5gQ04L+ADC0D/6vFA2Onwj5hlTLx83u3QEEav1rJK6r6
	 sWRg+K0w6L4yeaPlZ2Gdf+OttkHWJLRWL0Hx/HXa45ucqPBvVfHQXidgjN9a/YB0NU
	 Pq8HOFo7IpvNTSW6ZIUla1kvt6/patYUASlMoDvfqDshotOOHr8Ty1d1muNZfGggK0
	 DCs/4WMx5K1UKvsZAafK2PkDvNJW1zkqYYU+m78ZqyamTuAAkg2MLrRn/DbPvjOST9
	 2/n4OfdKEzFCY2KgsrqbG4NolBBTIU0ARW3qw/AZV5COeZqaI1cbS5O0L87Y2R1xAE
	 eFTbwIHvO8iOQ==
Date: Tue, 23 Sep 2025 15:37:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
In-Reply-To: <20250923194445.454442-13-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-13-vladimir.oltean@nxp.com>
Message-Id: <175865985168.25580.11987486707034552652.robh@kernel.org>
Subject: Re: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add
 compatible strings per SerDes and instantiation


On Tue, 23 Sep 2025 22:44:41 +0300, Vladimir Oltean wrote:
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations on all SoCs to use it was a mistake.
> 
> They all share the same register map, sure, but the number of protocol
> converters and lanes which are instantiated differs in a way that isn't
> detectable by the programming interface.
> 
> Using a separate compatible string per SerDes instantiation is
> sufficient for any device driver to distinguish these features and/or
> any instance-specific quirk. It also reflects how the SoC reference
> manual provides different tables with protocol combinations for each
> SerDes. NXP clearly documents these as not identical, and refers to them
> as such (SerDes 1, 2, etc).
> 
> The other sufficient approach would be to list in the device tree all
> protocols supported by each lane. That was attempted in this unmerged
> patch set for the older Lynx 10G family:
> https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> 
> but IMO that approach is more drawn-out and more prone to errors,
> whereas this one is more succinct and obviously correct.
> 
> Since this compatible string change breaks forward compatibility of old
> kernels with new device trees (which is OK with the known users), this
> is a good time to fulfill another user request, which is that individual
> SerDes lanes should have had their own OF nodes, so that we can
> customize electrical parameters:
> https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
> 
> This request requires #phy-cells = <0>, and because "fsl,lynx-28g"
> requires #phy-cells = <1>, we obviously cannot have both at the same
> time.
> 
> Change the expected name of the top-level node to "serdes", and update
> the example too.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2:
> - drop the usage of "fsl,lynx-28g" as a fallback compatible
> - mark "fsl,lynx-28g" as deprecated
> - implement Josua's request for per-lane OF nodes for the new compatible
>   strings
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 146 +++++++++++++++++-
>  1 file changed, 140 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml:42:18: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml:46:18: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml:49:18: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250923194445.454442-13-vladimir.oltean@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


