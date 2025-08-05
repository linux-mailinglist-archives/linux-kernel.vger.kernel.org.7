Return-Path: <linux-kernel+bounces-756043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E959AB1AF17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2093616B80F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E8224B1F;
	Tue,  5 Aug 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLZgX9wS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11842A82;
	Tue,  5 Aug 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377424; cv=none; b=EpmLAqRVAE9LBDewgNmjl+TpwNE70E5AW6dK2tG179aa8rgUuf7c1sO2VAV7sh04myWONOpZRTrOTlglUVZzrZDTfZni9m4PFilYcXYkkkSPhPv9/IVYKjFqcOvdVYOuvfO0/WQyXYM6Z9ufc0azGhY++cvVPG9mx3XElgrfQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377424; c=relaxed/simple;
	bh=yXD8h9EgHiHTH4CdVRohSkHvzdSIIfetCc8/xZomUnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVkC9vlmboOKfM3ag/GcYGIsYpqs1hm5VzX0jF/u7XJ7l4PZ8ouCLdC1p+Q9yt2+NPi9MEBXrEGp8v3AMKLYfjZwEOzGS6g8zrmEvyifOZuPaD4clRU8guC4DJTrzmTGOiOBQwerUMHjGYhmLiSs22BJ1+vy6sSricnF9RcW8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLZgX9wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C0C4CEF6;
	Tue,  5 Aug 2025 07:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377423;
	bh=yXD8h9EgHiHTH4CdVRohSkHvzdSIIfetCc8/xZomUnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLZgX9wSoU3mzbpD35QgvO/nbft/KXCcOOBwcItVpEgiNKmsu0tMBCnTBThyOcmQY
	 SAcLH1FpcB/x/hucxJRD9W8j0tMQQvMrKUIsgNgKCc25sMEnIU/i90EcSA069ZQEiY
	 T1oohSzDMmYoK+D8qnuccfHDBOaIj7ZTobX8tQ2U6jndSnp+SbxEnvxh/nwz5JqcSc
	 SK9N6dLnROh1I4BY6o0CIBS45FEEOaO8jNndXRGi5Q9y5C16bxUBNbI3szKvSLQVzF
	 7q11K9L3JHihrF7IDCHyrXCOuVcw90RMhHbjwRWqfuBKQx3fkzRCmYlaW6c8EjNN+x
	 +8vacZuT3nMIA==
Date: Tue, 5 Aug 2025 09:03:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/7] dt-bindings: clock: document 8ULP's SIM LPAV
Message-ID: <20250805-stereotyped-precise-vicugna-1c78ff@kuoka>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
 <20250804155407.285353-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804155407.285353-4-laurentiumihalcea111@gmail.com>

On Mon, Aug 04, 2025 at 11:54:03AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add documentation for i.MX8ULP's SIM LPAV module.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> new file mode 100644
> index 000000000000..ef44f50921f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
> +
> +maintainers:
> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> +
> +description:
> +  The i.MX8ULP LPAV subsystem contains a block control module known as
> +  SIM LPAV, which offers functionalities such as clock gating or reset
> +  line assertion/de-assertion.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8ulp-sim-lpav
> +      - const: syscon

Why is this syscon?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: lpav_bus
> +      - const: hifi_core
> +      - const: hifi_plat
> +
> +  '#clock-cells':
> +    const: 1
> +    description: clock ID

Drop description, redundant. Look how other bindings write this.

> +
> +  '#reset-cells':
> +    const: 1
> +    description: reset ID

Ditto

> +
> +  mux-controller:
> +    $ref: /schemas/mux/reg-mux.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'

reset cells and mux controller.



> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +
> +    clock-controller@2da50000 {
> +        compatible = "fsl,imx8ulp-sim-lpav", "syscon";
> +        reg = <0x2da50000 0x10000>;
> +        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
> +        clock-names = "lpav_bus", "hifi_core", "hifi_plat";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;

Incomplete node - missing properties/child. Post complete binding and
complete example.

Best regards,
Krzysztof


