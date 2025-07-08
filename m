Return-Path: <linux-kernel+bounces-721929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B959DAFCF97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DCF175D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0C2E2656;
	Tue,  8 Jul 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpHqpEe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACF2E040C;
	Tue,  8 Jul 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989650; cv=none; b=Z1OkQckhVNVfIPC1uJn9v9/h8NUI2D1eA8U0WQOYW6LGDiu4JZ7WtnzxfqWffHYy2z3Xp+BuereoWp8w9ul0zamOPUfmwn0xIMEPa8rrKFxsf1IadKD2wtAOQS9nBcum9NjxYv0IrB7PDxDTGyYGbyqZHsDdT3spz8ZAfVc/z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989650; c=relaxed/simple;
	bh=9FILRncBVkMcWlg7bphOJ6WLT1i1sMQ9/aj0fvNpAZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6vihYCez+Dg/LBI3mVPhPx6AJDYvvd1sZwVc+6eLVCmC1/iIXcl3n4T2RJknJDM1BMmWQAFeJy7Ty76hWx7bUY69o038rp72cEg0rrhEYlTNJrQmksDN43D+02UP9bmoQVatyHEZAJonxKVXKB4jZJjVuaEoJVUJWuV62T/UU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpHqpEe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1F2C4CEF6;
	Tue,  8 Jul 2025 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989649;
	bh=9FILRncBVkMcWlg7bphOJ6WLT1i1sMQ9/aj0fvNpAZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpHqpEe4OJt3bSjV0GUV+OV+vE84DzupQmimawIBkC7W8Q3987d9H0T+FmyqDObRl
	 qaJk7QZyhb7Qrh10gnyUhjRCAnJ5asunOFgJdKK0ypjqL7oi65ly6g4FYaRRWFIpBS
	 NuPGe4Kc0IAJzpoIRoIkmAHTxZJ3BcTJMQz2mqNhr7BjtaNGWICFOghXQA3Togbjj0
	 1IsYpFiaeTjTiLA3LXY3hRwJCzXt7BIK8YyRG8/ja13u7CJWQYCxgzzG+DCDUxurFL
	 2kKot4Hd5hJRA1+p745XmCkLo4s7X4KvupJiK6AZz9ZMD9aNP+Y/X5t0p83WdFfYIG
	 NWS+0uhXE9iog==
Date: Tue, 8 Jul 2025 10:47:28 -0500
From: Rob Herring <robh@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: display: rockchip,dw-mipi-dsi:
 Drop address/size cells
Message-ID: <20250708154728.GA401802-robh@kernel.org>
References: <20250629123840.34948-1-didi.debian@cknow.org>
 <20250629123840.34948-4-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629123840.34948-4-didi.debian@cknow.org>

On Sun, Jun 29, 2025 at 02:34:44PM +0200, Diederik de Haas wrote:
> When the dw-mipi-dsi binding was initially added in commit
> a20d86e7f964 ("Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver")
> the #address-cells and #size-cells were added as required properties.
> 
> When the binding was converted to yaml format in commit
> 0dac2102cf6b ("dt-bindings: display: rockchip: convert dw_mipi_dsi_rockchip.txt to yaml")
> those properties were demoted to optional and removed from the binding
> example.
> 
> As for the compatibles:
> - rockchip,px30-mipi-dsi      removed in this patch set
> - rockchip,rk3128-mipi-dsi    never used
> - rockchip,rk3288-mipi-dsi    added (invalid); later removed [1]
> - rockchip,rk3399-mipi-dsi    removed in this patch set
> - rockchip,rk3568-mipi-dsi    never used
> - rockchip,rv1126-mipi-dsi    proposed (invalid); never accepted [2]
> 
> [1] 282e2e078ba5 ("ARM: dts: rockchip: Remove #address/#size-cells from rk3288 mipi_dsi")
> [2] https://lore.kernel.org/all/20230731110012.2913742-12-jagan@edgeble.ai/
> 
> The #address-cells and #size-cells are useful (and required) in the
> ports node and for panel(s), but those properties are declared in their
> schemas already. Now that there are no remaining users, remove these
> properties from the Rockchip specific extensions of the Synopsys
> DesignWare MIPI DSI host controller.

The change is fine, but your reasoning is flawed. These properties are 
used if you define DSI devices on the "DSI bus" where the address of the 
child devices are the DSI virtual channel. Often though that's just 0 
and not really used, so you don't need it. 

The change is fine because these properties are defined in 
dsi-controller.yaml, so specifying them here is redundant.

> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  .../bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml     | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> index ccd71c5324af..0881e82deb11 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-mipi-dsi.yaml
> @@ -58,12 +58,6 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> -  "#address-cells":
> -    const: 1
> -
> -  "#size-cells":
> -    const: 0
> -
>  required:
>    - compatible
>    - clocks
> -- 
> 2.50.0
> 

