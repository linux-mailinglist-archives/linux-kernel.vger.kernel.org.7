Return-Path: <linux-kernel+bounces-830987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D18B9B152
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE66F170C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A3315D4E;
	Wed, 24 Sep 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrkMdWsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13318BC3B;
	Wed, 24 Sep 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735526; cv=none; b=qiHIGMS/jY04J3emdYgnm6F/ZVH4Re29YOjfyVVa7B1CjWrGa79Vb5HVq7Xs1jvCQIP+6COg8jL2qp8MLyLGpwYB+cuUjrJ7//BaWixgMjT6Gb6/u2HpY9hBk9m/loLwh1v+AmWoJCCBVp6Zp+ngW5NkqPlClnilMU6UPQBIq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735526; c=relaxed/simple;
	bh=1MVE//E1DYLEL5jhgb+nbns0tdTRgS5W4QKqihFcG2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi/GgAo8BUnERLciuwpdatTSKTIAjgxh3qYQRxGHj0G+6n+ht56d7YymkeDynM7vscXN3lYuzXYRu5Ct+6UI750SMZWuUaMfnvnqJUtH/0n3WhT7PrYR+bUpMKSxHsjskOfM1ICCl7gHMTYJJMij34YOIzHutA1HJk4OOzLTQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrkMdWsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCF1C4CEF4;
	Wed, 24 Sep 2025 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735526;
	bh=1MVE//E1DYLEL5jhgb+nbns0tdTRgS5W4QKqihFcG2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrkMdWsEw8ipZ0XAIFqSKEsGb7LNBO1vxNGUw0UcWlqei0Sp1BdpkBb9xrSodkH0O
	 LcMmwiVyJdJEwynkUuHKMHuvodHIkaDpXq7BNYDB8tN3Ruz0NJrrQs3Z7x2PX8k0AR
	 yn6ZVdydTzuH+CD6iJOT4pBLyLx4/zjr4zCnS99yBprhaP0ek8jy+ajoVc4Xh5kLaz
	 HW5S2OL+cZ6XRYZpOd+HsJTA1y7LxKdcKfwP2bb41oEy0KUMdxyFKUeAlnwjhYvJbW
	 vPbyoySV0fhxQuMiMPj1qc/mHjGG7fw7wiJnOpHbFnruIhkoBwVGNZ7nF7ony4vc3Z
	 xwcu0mVPPygJw==
Date: Wed, 24 Sep 2025 12:38:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	dri-devel@lists.freedesktop.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <175873552189.2235936.3746736501239939808.robh@kernel.org>
References: <20250922121902.88664-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0c2f242e-bdcc-4862-a215-2a988591f8cc@emailsignatures365.codetwo.com>
 <20250922121902.88664-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922121902.88664-2-mike.looijmans@topic.nl>


On Mon, 22 Sep 2025 14:18:44 +0200, Mike Looijmans wrote:
> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
> 
> The two chips have similar register maps, but different applications
> (source vs. sink).
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v6:
> Rename ti,mode to ti,retimer-mode
> 
> Changes in v5:
> ti,equalizer and ti,mode changed to enum
> Rename ti,slew-rate to slew-rate
> Make properties conditional for DP159/TMDS181
> Remove ti,dvi-mode (always set to avoid conflict)
> 
> Changes in v4:
> Use fallback compatible
> 
> Changes in v3:
> Fix duplicate links
> Add vcc-supply and vdd-supply
> Fix missing type for ti,slew-rate
> 
> Changes in v2:
> Document driver specific bindings like slew-rate and threshold
> 
>  .../bindings/display/bridge/ti,tmds181.yaml   | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


