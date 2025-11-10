Return-Path: <linux-kernel+bounces-892849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B11AC45F07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C531A3A4FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC623081AB;
	Mon, 10 Nov 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B624bR9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885B3074AA;
	Mon, 10 Nov 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770569; cv=none; b=CEj2bvSjA+VxAHRDmNfxmfBXL0Iblihbth3It8WkP3482f8j1e59g4IJW9h56t+QN/L6oOOxiz+j1BHWRoMcu9DaG+vcwOirPFIL7eif2M6lipdf+X73QJAwbZBqKrEmgIFyOSps/1qZF/zhRv+o4loWnH9NK1qHUvrmkYj0tFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770569; c=relaxed/simple;
	bh=ABWKO42uPzueqRpSjxTHFQd8ikHBkZ2+3doEw+bX6bc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Iil7k6VOe5s+1dHLHcpSE+TUhCnlShT81JPcVpk8u3KlGsB9C8kcDKQKyhzibCmNpu+7PyjjDaYV8ZFfHZRUEbJV5bAd/1QEXH5j2Zs7IVfv1pt8HzMR4kqAyrEYpVX/+rYqryWqeMBOV3q17+lcSYp9Ks15YsAsMqACQSDUzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B624bR9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BD2C16AAE;
	Mon, 10 Nov 2025 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762770568;
	bh=ABWKO42uPzueqRpSjxTHFQd8ikHBkZ2+3doEw+bX6bc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=B624bR9RdQgG/7X9fWVGi7Qunb/nIc7kWQb4hqVEmJvBF4pVhSfv9ca6O2u7FJEgS
	 a+6Luwep2t+DtOEtqFHUfOuC1PbjKJeofZD1pK38w46lyQakT9Dl+jDGHwdpDlE0Dy
	 Ms0lCxD0jtWqbkbTPZZror2jTapIExule+Eqo0HoY1CcMa17qrk6xTDFkj+CFKDY6s
	 twnAS8tfmH3R6zNu6EiLSyxxoAkFoAfuoVVxljs1d5TaCnQ+WO9FV4q1VdrOOb100h
	 sT9gE6YHj3T7+nzcnVp0vBQp7ZF/ZI2ZqceID1TZysfqsCB+CLiQVdSk21A+dbZ+1j
	 rUGdCIIcwMsMQ==
Date: Mon, 10 Nov 2025 04:29:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
To: Vladimir Oltean <vladimir.oltean@nxp.com>
In-Reply-To: <20251110092241.1306838-16-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-16-vladimir.oltean@nxp.com>
Message-Id: <176277056708.3414333.5403009680990856810.robh@kernel.org>
Subject: Re: [PATCH v4 phy 15/16] dt-bindings: phy: lynx-28g: add
 compatible strings per SerDes and instantiation


On Mon, 10 Nov 2025 11:22:40 +0200, Vladimir Oltean wrote:
> The 28G Lynx SerDes is instantiated 3 times in the NXP LX2160A SoC and
> twice in the NXP LX2162A. All these instances share the same register
> map, but the number of lanes and the protocols supported by each lane
> differs in a way that isn't detectable by the programming model.
> 
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations to use it was a mistake that needs to be fixed.
> 
> The two major options considered are
> (a) encode the SoC and the SerDes instance in the compatible string,
>     everything else is the responsibility of the driver to derive based
>     on this sufficient information
> (b) add sufficient device tree properties to describe the per-lane
>     differences, as well as the different lane count
> 
> Another important consideration is that any decision made here should
> be consistent with the decisions taken for the yet-to-be-introduced
> 10G Lynx SerDes (older generation for older SoCs), because of how
> similar they are.
> 
> I've seen option (b) at play in this unmerged patch set for the 10G Lynx
> here, and I didn't like it:
> https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> 
> This is because there, we have a higher degree of variability in the
> PCCR register values that need to be written per protocol. This makes
> that approach more drawn-out and more prone to errors, compared to (a)
> which is more succinct and obviously correct.
> 
> So I've chosen option (a) through elimination, and this also reflects
> how the SoC reference manual provides different tables with protocol
> combinations for each SerDes. NXP clearly documents these as not
> identical, and refers to them as such (SerDes 1, 2, etc).
> 
> The per-SoC compatible string is prepended to the "fsl,lynx-28g" generic
> compatible, which is left there for compatibility with old kernels. An
> exception would be LX2160A SerDes #3, which at the time of writing is
> not described in fsl-lx2160a.dtsi, and is a non-networking SerDes, so
> the existing Linux driver is useless for it. So there is no practical
> reason to put the "fsl,lynx-28g" fallback for "fsl,lx2160a-serdes3".
> 
> The specific compatible strings give us the opportunity to express more
> constraints in the schema that we weren't able to express before:
> - We allow #phy-cells in the top-level SerDes node only for
>   compatibility with old kernels that don't know how to translate
>   "phys = <&serdes_1_lane_a>" to a PHY. We don't need that feature for
>   the not-yet-introduced LX2160A SerDes #3, so make the presence of
>   #phy-cells at the top level be dependent on the presence of the
>   "fsl,lynx-28g" fallback compatible.
> - The modernization of the compatible string should come together with
>   per-lane OF nodes.
> - LX2162A SerDes 1 has fewer lanes than the others, and trying to use
>   lanes 0-3 would be a mistake that could be caught by the schema.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v3->v4:
> - OF nodes per lane broken out as a separate "[PATCH v4 phy 01/16]
>   dt-bindings: phy: lynx-28g: permit lane OF PHY providers"
> - rewritten commit message
> - s|"^phy@[0-9a-f]+$"|"^phy@[0-7]$"|g in patternProperties
> - define "#address-cells" and "#size-cells" as part of common
>   properties, only leave the part which marks them required in the allOf
>   constraints area
> v2->v3:
> - re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
>   top-level "serdes" node
> - drop useless description texts
> - fix text formatting
> - schema is more lax to allow overlaying old and new required properties
> v1->v2:
> - drop the usage of "fsl,lynx-28g" as a fallback compatible
> - mark "fsl,lynx-28g" as deprecated
> - implement Josua's request for per-lane OF nodes for the new compatible
>   strings
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 86 +++++++++++++++++--
>  1 file changed, 79 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/fsl,lynx-28g.example.dtb: serdes@1ea0000 (fsl,lx2160a-serdes1): '#phy-cells' does not match any of the regexes: '^phy@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/phy/fsl,lynx-28g.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251110092241.1306838-16-vladimir.oltean@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


