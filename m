Return-Path: <linux-kernel+bounces-894870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289CC4C536
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6384F4E83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A722F0C5B;
	Tue, 11 Nov 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjS5ATKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C1231A30;
	Tue, 11 Nov 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848724; cv=none; b=hk/ScuaI67Gv7TP/zwFx+GwqAcddjHe50ak2tVDQFsSHXh4lnDEqnlksffyOLMR9QNa57d/8SyQMuUFgZE33mpCyQbZC3hTAK6C/q6FX/ScewL1HoO2/+sqkur/KeYCv99KT0i/u/x9tvWPhxjQmzG6ITVC5F1SuChzmIGrI08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848724; c=relaxed/simple;
	bh=4ZXwNEdFPGw7GT9HjFLGQbQOpg79yaQP7NEbItrxbUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0sIse7GFwtJ5p/3ybW/0UglNdfICOyBlj2CnVVctsCgYe1386xf4SPCyBQmjG0tInOBO4jkZSsn1xUnhRUTpbb1NouuPD23tbunRaZ/3XFv2nJdi8+Am92KRQpNQOaUaBL7jh9nV2SweY1/M/cnSmpGeyBLkNPPNvOHwb0lluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjS5ATKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71204C116B1;
	Tue, 11 Nov 2025 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762848722;
	bh=4ZXwNEdFPGw7GT9HjFLGQbQOpg79yaQP7NEbItrxbUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjS5ATKYv15086zaWRU1IJZZxMePDSv63QCvJdbsIHKKXg0ZnyOX3yWze54eD+VtX
	 Hg6EABbTS107eOnk6okFHIO8PGT2fEDUu+8bZCc0JIueK+mvvzCKCTdCFGTzl+zUef
	 ixEXkRxPw3HKdmx6oFWyODYRPmg6Kf4YTbWVXqbH+4m7Djw4IUcG5IvYnNWbleoDHr
	 I2npKp7xROwO89PYmgO4fAJvErqheFqF2wOeAoaMJJgbNO8sxV7+V4qt/A6yJoks0t
	 ORJzBdwgmaylVoB+euWbf8xKKIFZyCYjZO6z8811fmR3mQWt/+LkoPrnLCrw2JaJT/
	 nptYUCl7C94xg==
Date: Tue, 11 Nov 2025 09:12:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dinguyen@kernel.org, Thinh.Nguyen@synopsys.com, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: dwc3-altera: Add binding for
 Altera DWC3 wrapper
Message-ID: <20251111-amiable-chicken-of-music-efe7dd@kuoka>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
 <607dec2fdb41cba0220b7b9947e04651f51ff56e.1762839776.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <607dec2fdb41cba0220b7b9947e04651f51ff56e.1762839776.git.adrianhoyin.ng@altera.com>

On Tue, Nov 11, 2025 at 02:18:45PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>=20
> Add a device tree binding document for the Altera wrapper around the
> Synopsys DesignWare USB3 (DWC3) controller. The wrapper manages
> SoC-specific integration such as clock and reset control for the USB
> subsystem.
>=20
> A parent=E2=80=93child node structure is used to comply with the generic =
DWC3

No, that's long time legacy. Use single node.

> binding, which restricts the core node to a single clock and reset.
> The wrapper node provides the additional clocks, resets, and address
> translation required for the Agilex5 integration.
>=20
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  .../devicetree/bindings/usb/dwc3-altera.yaml  | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-altera.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-altera.yaml b/Doc=
umentation/devicetree/bindings/usb/dwc3-altera.yaml
> new file mode 100644
> index 000000000000..c998d587723d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3-altera.yaml

Filename matching compatible.

> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/dwc3-altera.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera DWC3 USB Controller Wrapper
> +
> +maintainers:
> +  - Adrian Ng <adrianhoyin.ng@altera.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Altera SoCFPGA wrapper around the Synopsys DesignWare USB3 (DWC3) =
core.
> +  The wrapper provides SoC-specific integration such as reset and clock =
control.
> +
> +properties:
> +  compatible:
> +    const: altr,agilex5-dwc3
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

No, this cannot be flexible. Please do not write bindings completely
different than everything else.

List the items, fix size/length of the array.

> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2

Same problem,

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1

No. Use single node.

> +
> +  ranges: true

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - clocks
> +  - resets
> +
> +patternProperties:
> +  "^usb(@[0-9a-f]+)?$":
> +    type: object
> +    $ref: /schemas/usb/snps,dwc3.yaml#

Drop

> +
> +unevaluatedProperties: false

That's wrong in this context. Please read example-schema or writing
schema.

> +
> +examples:
> +  - |
> +    usb@11000000 {
> +        compatible =3D "altr,agilex5-dwc3";
> +        reg =3D <0x11000000 0x100000>;
> +        ranges =3D <0x0 0x11000000 0x100000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        clocks =3D <&clkmgr 54>, <&clkmgr 55>;
> +        resets =3D <&rst 36>, <&rst 44>;
> +
> +        dwc3: usb@0 {
> +            compatible =3D "snps,dwc3";
> +            reg =3D <0x0 0x100000>;
> +            interrupts =3D <0 94 4>;

We don't use such code... Look at any decent DTS.

> +            iommus =3D <&smmu 7>;
> +            phys =3D <&usbphy0>, <&usbphy0>;
> +            phy-names =3D "usb2-phy", "usb3-phy";
> +            dr_mode =3D "host";
> +            maximum-speed =3D "super-speed";
> +            snps,dis_u2_susphy_quirk;
> +            snps,dis_u3_susphy_quirk;
> +            status =3D "okay";

Drop

This is a pretty poor binding. You just repeat basic mistakes, fixed in
other NEW bindings. Last time few-line patch, with obvious issues, had
two reviewed-by from Altera. This one - bigger patch - no one cared to
review?

Best regards,
Krzysztof


