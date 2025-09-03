Return-Path: <linux-kernel+bounces-799484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C95B42C78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA720685E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4E2ECD1A;
	Wed,  3 Sep 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHY5IunM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749E22F77E;
	Wed,  3 Sep 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936996; cv=none; b=bnlAMnyygBHIQW2pmEY3Dl4/wA8p3+E20nXyR8xMyK8lBeBuCF/5RVXXQ8e0wClgv700e54EBQuuitqkUd1LPssyok5OTND7dijXyrDzbqVCeMvmzFzO4W3LR6Nf40lNmxt80Whg4BLbfcNL0qiWBOUeLJnmBZ4j5gMwvhN9QWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936996; c=relaxed/simple;
	bh=p/Vtnd9ExQcigtXvkp2n8XfYOV0CyJI9pZ18oK00OI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs2LvGHyRFWczFTwcoeKnQGY90E5bqvfQFlCs3xvgRpNNoWi8BTuNQAjvucOCwYgvCUoc7fhlVbheYaGIgFCc5rFBp012lQTMEh8mUYYQzRRVemlkRs5g+OwbvjXpNkUtTXhFWep6Kxp9fdYOvoV9m15iDoZR3vk9q5xaLzt/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHY5IunM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7DBC4CEF5;
	Wed,  3 Sep 2025 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936994;
	bh=p/Vtnd9ExQcigtXvkp2n8XfYOV0CyJI9pZ18oK00OI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHY5IunMb9W5aL4RZhex31VnQbVSXjrttHqnVv5/FUuIG53MvtQGYW687uggHUP36
	 zeQtz45hZGXgk0zUFHFGFU0tg3AeB/BUIeJrEllB+c1JVdjT4vIeGyab3I8GgWnGXp
	 yQYXjBVEWXFjaZTq8cVxfvG8+StPttUoQztLdwy0FsIu5wMexNy+FtAbDCuXGRL3q2
	 MdX7AkITz2ADPA0m6AiM/RQKFeTJF7tmoLCN88razpECpNPZjIckTY8pV8h5RMwEPb
	 kkjJXIKPXciUhzsZw56MjSq1gHaBwcUnzWYZ3UiR71UdVbMWh25YZlltfpyO+cYtlF
	 IDf+aBcDX0CMg==
Date: Wed, 3 Sep 2025 17:03:12 -0500
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
Subject: Re: [PATCH v2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
Message-ID: <20250903220312.GA2903503-robh@kernel.org>
References: <20250903111357.2605199-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903111357.2605199-1-h-shenoy@ti.com>

On Wed, Sep 03, 2025 at 04:43:57PM +0530, Harikrishna Shenoy wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
> DPI/DP bridge.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index c2b369456e4e..6e749c002669 100644
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
> +      - const: mhdptx-dsc

'mhdptx' is redundant. Don't continue that pattern. Just 'dsc'.

>  
>    clocks:
>      maxItems: 1
> @@ -100,18 +103,18 @@ allOf:
>        properties:
>          reg:
>            minItems: 2
> -          maxItems: 3
> +          maxItems: 4
>          reg-names:
>            minItems: 2
> -          maxItems: 3
> +          maxItems: 4
>      else:
>        properties:
>          reg:
>            minItems: 1
> -          maxItems: 2
> +          maxItems: 3
>          reg-names:
>            minItems: 1
> -          maxItems: 2
> +          maxItems: 3

Have you tested this works? While it might work for TI with the 
j721e-intg registers in the middle, it won't work for platforms without 
them. You're going to have to have 2 lists of reg-names.

Rob


