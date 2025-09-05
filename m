Return-Path: <linux-kernel+bounces-803512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD29B4619A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586D95A2A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743E36CDF5;
	Fri,  5 Sep 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKnc1VSQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990E2F7AC1;
	Fri,  5 Sep 2025 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095241; cv=none; b=eSHgOtDzbo5MpxslxHkEgO8bP12W9bHAy2PsIX9aFLDl/bwHDvcf2CV4dhBKFZY6PPqLY7mO/B8zGiVgH1tUDPJtDK9oHsBpCoq4tEKRjcNI740U8Gpl4BrUkIwSH2eHeds0/HuRK418akDdj6A2JpG74wk1AoPwLuzTwWGreCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095241; c=relaxed/simple;
	bh=pgmvmFb/8kCCNlf55iLem9HEzp6mMHv7i0NyicdLw3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCv/y/DWpWIwFFVcFjouC2sFcLRLGIrcl0vXD+kdVBEcxX7aRZK92CddAgy07YZ1Lhpk8tniNuYJr/F/wJKVlAqHB4UBQ+vVJ0vpBxPZEc5o/86+RlitvAdcCsVNYyEGsRZTeA8/knuH5NPRLXCNwZu/66ibQ1euQNYblFf4JXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKnc1VSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9860C4CEF1;
	Fri,  5 Sep 2025 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757095240;
	bh=pgmvmFb/8kCCNlf55iLem9HEzp6mMHv7i0NyicdLw3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKnc1VSQDVaKcv7LYjjc1Ax66S7zi9xjI8eoRSSKLtpWLpad1IwKwL139iPbJqw8d
	 /nw9jsxo++HfXkc05NrCuh8O4ih+0u3T9MBJprmNBQavnpW94hXOXlnwOH0ZbjizZh
	 /0qrQK6UiwlrIq90H5Wlo7TrhMfhNYSurii0sxqgcB+TayNk8pNtLefUFR7fynA6l4
	 IaOg+V19WQig0hjz8wtWOVdX2Oxv27tm2/zPsP1z6moVQOAUfs5vfVWxZ32cEsn8t9
	 P2/ehrXLbgkj7lGWD01R6w9twLiQbR29b8bEQOGgwXWwjJp8o4zeDoOhDZoYEIvguh
	 IX/FMnpfZzOtg==
Date: Fri, 5 Sep 2025 13:00:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Liu Ying <victor.liu@nxp.com>,
	Maxime Ripard <mripard@kernel.org>, Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Phong LE <ple@baylibre.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: Reference DAI common schema
Message-ID: <175709523857.1011984.7960625628072770929.robh@kernel.org>
References: <20250904083816.48076-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904083816.48076-2-krzysztof.kozlowski@linaro.org>


On Thu, 04 Sep 2025 10:38:17 +0200, Krzysztof Kozlowski wrote:
> Several display bridges (e.g. LVDS to HDMI converters) are used as sound
> Digital Audio Interface (DAI) and have '#sound-dai-cells', thus they
> should reference dai-common.yaml schema to allow common properties, like
> DAI name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/bridge/ite,it6263.yaml       | 1 +
>  .../devicetree/bindings/display/bridge/ite,it66121.yaml      | 5 ++++-
>  .../devicetree/bindings/display/bridge/lontium,lt9611.yaml   | 5 ++++-
>  .../devicetree/bindings/display/bridge/nxp,tda998x.yaml      | 5 ++++-
>  .../devicetree/bindings/display/bridge/sil,sii9022.yaml      | 5 ++++-
>  5 files changed, 17 insertions(+), 4 deletions(-)
> 

Applied, thanks!


