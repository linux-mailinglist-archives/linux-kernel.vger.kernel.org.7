Return-Path: <linux-kernel+bounces-770024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164DB27602
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7876B188AA09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130F2BDC0C;
	Fri, 15 Aug 2025 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmoYewln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B82BDC02;
	Fri, 15 Aug 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225025; cv=none; b=r02h3m4F5vrV/Jo5ajKBdhPnVOFJ6a6W4zy83uk+HIGeNT9pMZ1eBF9oP02XZIFaNi7dr75EiJX7nxEVhmg6ip9eSlB1fHcTkT5G51/dWinv/3F7dCTdKjxuq4UxNwrzbHRUQMXRfmtGzSk9rBqk6Ve9BMvF1OZlPXlwD1jvjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225025; c=relaxed/simple;
	bh=9o/PwWHLbtBHKua80XVpSesiBY2zS2akYvQYX2b65+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTSrKZYVls976b75iDqtNJ/rJnWRLip6IQpCaYbgCJl7XHuCrosH1anx/amp+77fcau67smd9qzt1pzZ67MD9g+UtXgD+75k1DnLyTQVjRM+3W6Ve0DaOMCae7HjjEO3BpTOqmid8hq37gbMUOtnVxaAY4o5fxil0fuQIyKfBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmoYewln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8657C4CEF1;
	Fri, 15 Aug 2025 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755225024;
	bh=9o/PwWHLbtBHKua80XVpSesiBY2zS2akYvQYX2b65+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmoYewlnfx/vvwW7Mri7XrToC43bkIhNGdgrA45PGJYANHfDg1Fm/TtPV/FaTlgnp
	 EWejj4IEHJGQvPhG9ZdjH7a5IDK7X6iXkQQ7ZcWIhqiXU0+cBYWpFNCQPweymRlBaF
	 A7yncuVkX/m+iGHIXFG03k5MDxgdjf/rZySIvVsXsTaxA2+36xyNJhHpq0GYKevzLQ
	 Do+q5lop1eXQOeaFDvYg4zfUOc7MLseWV6uVHcsU8c6C9hfOFKW9NsQohIwFxLreS+
	 0jjMOtnoyZMG+aacmf4Fzv19kFAsCjVgDTsg4Ii9o2pPqYKtbNTNwPFJdLPkQOI6v0
	 uWLMUgN0p0ewg==
Date: Fri, 15 Aug 2025 10:13:13 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Convert marvell,berlin to DT schema
Message-ID: <aJ6XuVZbJo8uUbIw@xhacker>
References: <20250806212733.1633662-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806212733.1633662-1-robh@kernel.org>

On Wed, Aug 06, 2025 at 04:27:32PM -0500, Rob Herring (Arm) wrote:
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

BTW: can you please directly take this patch in dt pr? It's likely no other
patches for next window.

Thanks
> ---
>  .../bindings/arm/marvell,berlin.yaml          | 45 ++++++++++
>  .../devicetree/bindings/arm/syna.txt          | 89 -------------------
>  2 files changed, 45 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/syna.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.yaml b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
> new file mode 100644
> index 000000000000..4e8442980dcb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell,berlin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics/Marvell Berlin SoC
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  According to https://www.synaptics.com/company/news/conexant-marvell
> +  Synaptics has acquired the Multimedia Solutions Business of Marvell, so
> +  Berlin SoCs are now Synaptics' SoCs.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sony,nsz-gs7
> +          - const: marvell,berlin2
> +          - const: marvell,berlin
> +      - items:
> +          - enum:
> +              - google,chromecast
> +              - valve,steamlink
> +          - const: marvell,berlin2cd
> +          - const: marvell,berlin
> +      - items:
> +          - enum:
> +              - marvell,berlin2q-dmp
> +          - const: marvell,berlin2q
> +          - const: marvell,berlin
> +      - items:
> +          - enum:
> +              - marvell,berlin4ct-dmp
> +              - marvell,berlin4ct-stb
> +          - const: marvell,berlin4ct
> +          - const: marvell,berlin
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
> deleted file mode 100644
> index f53c430f648c..000000000000
> --- a/Documentation/devicetree/bindings/arm/syna.txt
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -Synaptics SoC Device Tree Bindings
> -
> -According to https://www.synaptics.com/company/news/conexant-marvell
> -Synaptics has acquired the Multimedia Solutions Business of Marvell, so
> -berlin SoCs are now Synaptics' SoCs now.
> -
> ----------------------------------------------------------------
> -
> -Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
> -shall have the following properties:
> -
> -* Required root node properties:
> -compatible: must contain "marvell,berlin"
> -
> -In addition, the above compatible shall be extended with the specific
> -SoC and board used. Currently known SoC compatibles are:
> -    "marvell,berlin2"      for Marvell Armada 1500 (BG2, 88DE3100),
> -    "marvell,berlin2cd"    for Marvell Armada 1500-mini (BG2CD, 88DE3005)
> -    "marvell,berlin2ct"    for Marvell Armada ? (BG2CT, 88DE????)
> -    "marvell,berlin2q"     for Marvell Armada 1500-pro (BG2Q, 88DE3114)
> -    "marvell,berlin3"      for Marvell Armada ? (BG3, 88DE????)
> -
> -* Example:
> -
> -/ {
> -	model = "Sony NSZ-GS7";
> -	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
> -
> -	...
> -}
> -
> -* Marvell Berlin CPU control bindings
> -
> -CPU control register allows various operations on CPUs, like resetting them
> -independently.
> -
> -Required properties:
> -- compatible: should be "marvell,berlin-cpu-ctrl"
> -- reg: address and length of the register set
> -
> -Example:
> -
> -cpu-ctrl@f7dd0000 {
> -	compatible = "marvell,berlin-cpu-ctrl";
> -	reg = <0xf7dd0000 0x10000>;
> -};
> -
> -* Marvell Berlin2 chip control binding
> -
> -Marvell Berlin SoCs have a chip control register set providing several
> -individual registers dealing with pinmux, padmux, clock, reset, and secondary
> -CPU boot address. Unfortunately, the individual registers are spread among the
> -chip control registers, so there should be a single DT node only providing the
> -different functions which are described below.
> -
> -Required properties:
> -- compatible:
> -	* the first and second values must be:
> -		"simple-mfd", "syscon"
> -- reg: address and length of following register sets for
> -  BG2/BG2CD: chip control register set
> -  BG2Q: chip control register set and cpu pll registers
> -
> -* Marvell Berlin2 system control binding
> -
> -Marvell Berlin SoCs have a system control register set providing several
> -individual registers dealing with pinmux, padmux, and reset.
> -
> -Required properties:
> -- compatible:
> -	* the first and second values must be:
> -		"simple-mfd", "syscon"
> -- reg: address and length of the system control register set
> -
> -Example:
> -
> -chip: chip-control@ea0000 {
> -	compatible = "simple-mfd", "syscon";
> -	reg = <0xea0000 0x400>;
> -
> -	/* sub-device nodes */
> -};
> -
> -sysctrl: system-controller@d000 {
> -	compatible = "simple-mfd", "syscon";
> -	reg = <0xd000 0x100>;
> -
> -	/* sub-device nodes */
> -};
> -- 
> 2.47.2
> 

