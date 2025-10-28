Return-Path: <linux-kernel+bounces-873212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E40C1362E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9024FA8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795642641C6;
	Tue, 28 Oct 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeZ0Tj72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71B7494;
	Tue, 28 Oct 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637930; cv=none; b=OR8NJ1pMmtmxJB9AqI4CFcMvLjIaQ6PJvO2K8lz3pEQJwvo+Ss9PYbTCqdGyknNvOlTGDvkiLY4/nFJ+smD7E03slsus9tsGfTMRSWDx6sl/RtQTiHQU9NGd9YlGSliqWHYZiHmfJ/sNqciPpGhm621CQUbIwiSiNuMJAsedLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637930; c=relaxed/simple;
	bh=lgCu1/5LkJDVUKGcQ1LJt6hU1F8MpL35/q8ICEa7ZPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSCG6foGYtxgE1uL2xO9aHVsC9nhUVTojOQwus3lWWYAdaXvD0eMH157OFB9PFD+Jmq+i4LycV/tK4eR7fIwuG6qcZTyCLtjvuF28lzEdOVkVeJEtBFNLIJR6keV3J+gpkUEp2ArXq6m31tYe4XSzsCQ9VrKjHgV6vTpX2857Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeZ0Tj72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF514C4CEE7;
	Tue, 28 Oct 2025 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761637930;
	bh=lgCu1/5LkJDVUKGcQ1LJt6hU1F8MpL35/q8ICEa7ZPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeZ0Tj72+n38VyiBnwzBzv1JPxT5YjRmABluQrQbslUPzrY4kOjj2dZbDJn+VKxVX
	 QE4fZj6gTStX4n5HsGpMaSXgVAhZ+8sC6W3k2yfrzQi/FS5BfbFSmqjNtPow4aVUkg
	 5DdvTG6gAECtFsUFZwk25O92EL6Ytj9Sf/i8d5n5tAvZb9+b9HIpIO2qNo6AoI1zbc
	 uj3JznohxOTHbhva7pBZea7/H0kbzXJxVEhRbWpRCEKWiO5oxrTRcBgBQYjbVQsXEo
	 U2OLHi4bSp94ssMT2o94756zksQZG9E2cv82F00lUI88X6OPvu6fGDPhE0qiZ7i57x
	 tJY3u1FKZhsLA==
Date: Tue, 28 Oct 2025 08:52:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com, 
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	huangtao@rock-chips.com, finley.xiao@rock-chips.com
Subject: Re: [PATCH v5 4/7] dt-bindings: clock: Add support for rockchip
 pvtpll
Message-ID: <20251028-hasty-amusing-guan-e57f62@kuoka>
References: <20251027084147.4148739-1-zhangqing@rock-chips.com>
 <20251027084147.4148739-5-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027084147.4148739-5-zhangqing@rock-chips.com>

On Mon, Oct 27, 2025 at 04:41:44PM +0800, Elaine Zhang wrote:
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  rockchip,cru:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the main Clock and Reset Unit (CRU) controller.
> +      Required for PVTPLLs that need to interact with the main CRU
> +      for clock management operations.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"

Missing clocks.

> +  - clock-output-names

Missing rockchip,cru

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pvtpll@20480000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +      compatible = "rockchip,rv1126b-core-pvtpll";
> +      reg = <0x20480000 0x100>;
> +      #clock-cells = <0>;
> +      clock-output-names = "clk_core_pvtpll";

Incomplete example - missing clock.

> +    };
> +
> +  - |
> +    pvtpll@21c60000 {

Drop all other examples, no need to repeat the same.

They weren't even here before!

Best regards,
Krzysztof


