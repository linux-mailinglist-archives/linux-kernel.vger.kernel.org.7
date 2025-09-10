Return-Path: <linux-kernel+bounces-809286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F20B50B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE717B3530
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7D24291E;
	Wed, 10 Sep 2025 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L325wlde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115018E1F;
	Wed, 10 Sep 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471770; cv=none; b=FYb2mzKQouMkwiUxy0mTJHhuGssEUpekZu84dq5SnD4P0CiVgB2PKm4Ivuajy+OYOtCL7MnTD+47FvXfvrqLIO6PXfP7s4s9ckBVav+5ZItXC94oJR0QC8y1wfpWMGU1PpCFctnDgoV/8mZ63oITLyCaz+FADveoW7Z7x8wykcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471770; c=relaxed/simple;
	bh=0H7itlJ0+/GdkQTyOfCGv/vZ5r2kkd58PNJCMOwIJPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAj4Y7Z66ratgwDaUo+GZgixvEPYAYtritUTUZYK+iTFNaeEqqZZT97LcQKfxiaQxZr6dVDEDU1hQBqqOFheWLm4qhfh6+KfFir0Pzd1O4nAexVBC2ddQCjUa1ADNB3gUrGXdSx3OsA0YwwZRjJ6cAJc9ZXuK5PISrex006PhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L325wlde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE81C4CEF4;
	Wed, 10 Sep 2025 02:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471769;
	bh=0H7itlJ0+/GdkQTyOfCGv/vZ5r2kkd58PNJCMOwIJPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L325wlde+o9ZmWvmWairncEVADIUea2Ju4p99hajBelDi4xgT8RXcWrQ18nHr605C
	 neIKMSh6yiUwpoa7wXFDhWs+hSrRsgTOtn+CMgE2f1IvdZUxg2phyOJ1Etep3TDC/N
	 8oq4iepC9MpB13hUVhyoewHxAENJ3VAKOWtZSXRHXvEGNWcZxQfGU13yno1lFhpM+7
	 iZWNmoroilSgZblXLW0sjd8ri5tgw1k6eUDzTeG+DS71qYKkmb34Ye22AuAZKgjrvr
	 n8J3YJDEnBg2JmeChRY97rnOQW1PBOr8C8Mp9Z0YfCXDRNdup40K58GCxidGOH87lt
	 0yYLSMmwuX4qA==
Date: Tue, 9 Sep 2025 21:36:08 -0500
From: Rob Herring <robh@kernel.org>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	sjakhade@cadence.com, yamonkar@cadence.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
	s-jain1@ti.com
Subject: Re: [PATCH v4] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
Message-ID: <20250910023608.GA3662482-robh@kernel.org>
References: <20250909054622.1439487-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909054622.1439487-1-h-shenoy@ti.com>

On Tue, Sep 09, 2025 at 11:16:22AM +0530, Harikrishna Shenoy wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
> DPI/DP bridge.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
> Changelog v3 -> v4:
> -Remove maxItems as item list is mentioned for reg-names, resolves 
> dt_bindings_check warning.
> Log link- <https://gist.github.com/h-shenoy/5391ea514bb58a6cba3f39248d20916b>
> Link to v3- https://lore.kernel.org/all/20250908054609.1113360-1-h-shenoy@ti.com/
> 
>  .../bindings/display/bridge/cdns,mhdp8546.yaml | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index c2b369456e4e..b40630de6d89 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -27,6 +27,8 @@ properties:
>            Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
>        - description:
>            Register block of mhdptx sapb registers.
> +      - description:
> +          Register block for mhdptx DSC encoder registers.
>  
>    reg-names:
>      minItems: 1
> @@ -34,6 +36,7 @@ properties:
>        - const: mhdptx
>        - const: j721e-intg
>        - const: mhdptx-sapb
> +      - const: dsc
>  
>    clocks:
>      maxItems: 1
> @@ -100,18 +103,25 @@ allOf:
>        properties:
>          reg:
>            minItems: 2
> -          maxItems: 3
> +          maxItems: 4
>          reg-names:
>            minItems: 2
> -          maxItems: 3
> +          items:
> +            - const: mhdptx
> +            - const: j721e-intg
> +            - const: mhdptx-sapb
> +            - const: dsc
>      else:
>        properties:
>          reg:
>            minItems: 1
> -          maxItems: 2
> +          maxItems: 3
>          reg-names:
>            minItems: 1
> -          maxItems: 2
> +          items:
> +            - const: mhdptx
> +            - const: mhdptx-sapb
> +            - const: dsc

Still obviously not tested with a DT having this. Because this 
contradicts the top-level schema. Both cannot be true.

Rob

