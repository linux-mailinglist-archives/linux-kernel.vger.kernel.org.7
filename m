Return-Path: <linux-kernel+bounces-781301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42FB310B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAF7604AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB642E9EB8;
	Fri, 22 Aug 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6bqkKnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9042E229D;
	Fri, 22 Aug 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848654; cv=none; b=IWQg6WZtkcvIrik9uqT74xkRQ+ipO8RJYN1KQJydbsUrtBzCSz1jsD4I1YBnl0QrVyhEkJvHwVQ7fi7fbyfN05NSy3Ub11Kzyu6x9+KNSsUC11c6lAIVhuQoFDtLB6hycAAlDNfjmsRaXNRaZb2JGKCmxQmruWWR9a53RWOCiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848654; c=relaxed/simple;
	bh=r2Pfl5nt6sdysHXXpL7eYWKTHAGJiVdYcKYqAZD4g8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csTN4OboF2IiIuqs5wdXOf3q1sx09wwt3vWBn8LIk1a3M8jLXULMC9l5CY2V+Y6HfEwdTIQlZyWV93M+uTYk+5gvVvpcpiYuHU8UN8FvKZeMaH1XUfb7cg5chVMvg5/eje7DvZiuZLlhn7TX+GISnjqtvMGNcmDRc1Fxf9gY/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6bqkKnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137DC4CEF1;
	Fri, 22 Aug 2025 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755848653;
	bh=r2Pfl5nt6sdysHXXpL7eYWKTHAGJiVdYcKYqAZD4g8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6bqkKnnzj0cveORmGv6va44wNp63V0sDMipCbgl6kf+WuR3FQBP8f74LJTgDybbW
	 dbUhspyi9wKpzGbDgomBukxOrrl3ckY+rgY2nj2cs/zvCVzHN9g4XIh5NJ0KfPGaRu
	 tx9Z0iFhOYxmZR361b2wdfVw3NXrNruBbnrwlbJl+EuI8SP93ztUtKmOV1DyBqqsMO
	 SQ29wbvnJtQ5+0lNbew/pX7aIxBJY/QOZp6zSp/G34n2PY39rtscLCXbHsE1uaqMGp
	 lFvEUIV6YhcLkJLPH7zjaHVDtkqZRemNpsR/n5S7NQJL4VoxdZZ++h6ivDE4t4sECj
	 3N5jwACuA8oWg==
Date: Fri, 22 Aug 2025 09:44:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5 1/2] usb: dt-bindings: ti,twl4030-usb: convert to DT
 schema
Message-ID: <20250822-wealthy-oyster-of-upgrade-fdb4e2@kuoka>
References: <20250821212824.70569-1-jihed.chaibi.dev@gmail.com>
 <20250821212824.70569-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821212824.70569-2-jihed.chaibi.dev@gmail.com>

On Thu, Aug 21, 2025 at 11:28:23PM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL4030 USB module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation using a conditional schema.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v5:
> 
>  - Split combined twlxxxx-usb binding into a dedicated file for
>    twl4030-usb per maintainer feedback.
>  - Used more accurate header for interrupt macros.
>  - Improved formatting in the examples.
> 
> Changes in v4:
>  - This patch is split from larger series per maintainer feedback.
>  - v3 link:
>     https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
>  - Removed i2c node as it wasn't required by the old binding file.
>  - Updated node names to 'usb' and 'usb-phy' in the examples to follow
>    generic naming conventions per the Device Tree specification.
>  - Replaced raw interrupt values with standard defines for clarity.
>  - Improved formatting in the examples for clarity and consistency.
> 
> Changes in v3:
>  - No changes.
> 
> Changes in v2:
>  - Added '#phy-cells' property to support PHY framework integration.
> ---
>  .../bindings/usb/ti,twl4030-usb.yaml          | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
> new file mode 100644
> index 000000000..a2d3c5f60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,twl4030-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL4030 USB PHY and Comparator
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description:
> +  Bindings for the USB PHY and comparator module found within the
> +  TWL4030 family of companion chips. If a sibling node is compatible with
> +  "ti,twl4030-bci", the driver for that node will query this device for
> +  USB power status.
> +
> +properties:
> +  compatible:
> +    const: ti,twl4030-usb
> +
> +  interrupts:
> +    description:
> +      Interrupt numbers to the CPU for ID and VBUS events. The first interrupt

Confusing. So first is CPU?

> +      is the OTG interrupt for both ID and VBUS events. The second interrupt

But furst is OTG?

> +      is optional.

After splitting the binding this should be rewritten. Drop description,
no need for free form text.

minItems: 1
items:
  - description: OTG for ...
  - description: foo bar and do not say it is optional because it is obvious from schema


Missing also removal of this device from the TXT binding.

Best regards,
Krzysztof


