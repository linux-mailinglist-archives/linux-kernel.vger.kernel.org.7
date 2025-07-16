Return-Path: <linux-kernel+bounces-732987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14560B06E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF5E7A6DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E646289E04;
	Wed, 16 Jul 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFG6zI2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D02857CD;
	Wed, 16 Jul 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649496; cv=none; b=EFkTqZVIS69IZnlRb6DU5ARZ4jThdOxiLeIUCIXnayMD8GSPdC6NMOTVvRhS/aamp8P4Kxfjh5Wb3fkEWyhejp0zDj/CwKNApmrKOorPicJwvKjUEkzt5KK9NF6Nw3OKX/tJXppHrZCQcceUf+DuYypzM6M8nVXSNyseVnzGjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649496; c=relaxed/simple;
	bh=n5jDS6P6Z09q/E7TBP2aC3Jqc7A6owgR1MsLzr1mN+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNRJaMLisH5LmXrQU2V9RbzmsCOWZf/G5QEVYquSM+ZxWCeXb1ZkoqdCl7kWnUg9Ls+6+nKalwF6/1RBYcBUrg6qaTtQnBVQLRnzpPrIPqzMzk78j640vJuHAUduNM9bBjU3vctid9gI0vhNa2feCem2lwXoR9owjqHYO9WEfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFG6zI2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9143C4CEF0;
	Wed, 16 Jul 2025 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752649494;
	bh=n5jDS6P6Z09q/E7TBP2aC3Jqc7A6owgR1MsLzr1mN+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFG6zI2u3XoXatQkR4SlZo52it/lESL/DyhxEF0NS77I3sT4leBM8M05KCYXtTesu
	 BorGIFj7gurVfgONyWkOcyO1uw81eoyit106tHI6NsrirMjR3jB7QaItKM8FpP5IU6
	 zGkh4I9oq4dE+2M3sXxfyxJ9RwSBH01O36TTvMawiFRFPZnNr4TPEDpeLA5KYweCCy
	 qPY8RlIRorDHmHMLwKQK5eWp4XKMFSdHnAz8lC4YXzX39fVTMiqblPaX00Jkh8/U9L
	 A30BmTkcku0hSCFi7Bk+dtU9eJl2slthDeh1Gz7tZQt+ADY2YV2mTtuESR+O86LVkL
	 /1kJ73qVsWHlg==
Date: Wed, 16 Jul 2025 09:04:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: mediatek: Describe MT6789
 clock controllers
Message-ID: <20250716-manipulative-dormouse-of-current-9af4e6@krzk-bin>
References: <20250715222221.29406-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715222221.29406-1-me@adomerle.pw>

On Wed, Jul 16, 2025 at 02:22:20AM +0400, Arseniy Velikanov wrote:
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt6789-afe
> +          - mediatek,mt6789-camsys
> +          - mediatek,mt6789-camsys-rawa
> +          - mediatek,mt6789-camsys-rawb
> +          - mediatek,mt6789-imgsys
> +          - mediatek,mt6789-imp-iic-wrap-c
> +          - mediatek,mt6789-imp-iic-wrap-en
> +          - mediatek,mt6789-imp-iic-wrap-w
> +          - mediatek,mt6789-ipesys
> +          - mediatek,mt6789-mdpsys
> +          - mediatek,mt6789-mfgcfg
> +          - mediatek,mt6789-vdecsys
> +          - mediatek,mt6789-vencsys
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    afe: clock-controller@11210000 {
> +        compatible = "mediatek,mt6789-afe";
> +        reg = <0x11210000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +

Drop the rest of nodes. One example is enough. They are ALL THE SAME.

...

> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml
> new file mode 100644
> index 000000000000..d6f70ee918ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt6789-sys-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Clock Controller for MT6789
> +
> +maintainers:
> +  - Arseniy Velikanov <me@adomerle.pw>
> +
> +description:
> +  The Mediatek system clock controller provides various clocks and system configuration
> +  like reset and bus protection on MT6789.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt6789-apmixedsys

Why this does not fit existing binding file? Or Mediatek maintainers
preference was to switch to one-binding-per-SoC?


> +          - mediatek,mt6789-topckgen
> +          - mediatek,mt6789-infracfg-ao
> +          - mediatek,mt6789-mcusys
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mcusys: syscon@c530000 {

Drop unused labels, everywhere.

Also, node name is supposed to be clock or reset controller, not syscon.

> +      compatible = "mediatek,mt6789-mcusys", "syscon";
> +      reg = <0xc530000 0x1000>;
> +      #clock-cells = <1>;
> +    };
> +

Drop the rest

Best regards,
Krzysztof


