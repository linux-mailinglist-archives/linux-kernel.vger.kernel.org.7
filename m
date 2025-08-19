Return-Path: <linux-kernel+bounces-774997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC10B2BA18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745D7526D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA226CE39;
	Tue, 19 Aug 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoKW1Wu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE6209682;
	Tue, 19 Aug 2025 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586997; cv=none; b=uupG1YahTjy4IWbs43TbqcABSlHrKzImo25vU4buJ7ADsdlKVS9OVutSilRrOBP6pnB91urghmzQgjiTrx0P2XdO8LCPA99ftnn8srbMHOehJJSDLcShqGNtx10Xva6T5p0B8a4HGGRBS70AyMbwgZ/gBWsoYImLW+6dij9rdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586997; c=relaxed/simple;
	bh=S4IyDFs7hEifzpd1r/UNQubC95KrtZm4g/kMrDKhJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDV+1PcTob5LCA9LFq1GeJazBzVz+9rE0A5eiCv/bTupnPniDlu0TPR+6H7RyZ4QsHtTCET8rIK2X9YDVTrv6wQUpo1i2BAfKhuh4pc7tME5SdylOM2kT+G/1hue9Kt852sWxBcArrE4opye5XTrs9T0L7gq+y52y4lh7tMuuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoKW1Wu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DAAC4CEF1;
	Tue, 19 Aug 2025 07:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586997;
	bh=S4IyDFs7hEifzpd1r/UNQubC95KrtZm4g/kMrDKhJog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RoKW1Wu3W6HRRvUn79l3AoXgAIiBS94KAHSVS+Pmg+G63Hmo8pd4sHf3kvoIU5/yI
	 yXLe8fDf8tG2zR7XUi61syAajNVWoi5podcBh2k5RfyX4IgwspzHQezgaiEeS8NLg8
	 JnjyLEz4MjoJGiwqp8K25knN8O6WJZaqdfLhr7lm9mSqRet20O+QeYTT4bfwOq0FPU
	 nBY6ysErioFskxvyafDOBLlrzgZ6LJwo+R7Xhuv1pVE1hmik1sU+QW8wRxDNYrrTrq
	 I9dcJ7GFqKK5OOp0zzti/oJDMMFVPki/lX9G9H9rWBDj+uRrpDz1LM6/DjHf2s83WV
	 TlGaV6QoAgqhg==
Date: Tue, 19 Aug 2025 09:03:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <20250819-mandrill-of-imminent-hurricane-a3c6d8@kuoka>
References: <20250819053205.9976-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f1878466-8551-4b5d-bf2e-1706e377d436@emailsignatures365.codetwo.com>
 <20250819053205.9976-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819053205.9976-2-mike.looijmans@topic.nl>

On Tue, Aug 19, 2025 at 07:31:14AM +0200, Mike Looijmans wrote:
> Add DT binding document for TI TMDS181 and SN65DP159 HDMI retimers.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v2:
> Document driver specific bindings like slew-rate and threshold
> 
>  .../bindings/display/bridge/ti,tmds181.yaml   | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> new file mode 100644
> index 000000000000..816bea54846f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ti,tmds181.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMDS181 and SN65DP159 HDMI retimer/redriver chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Texas Instruments TMDS181 and SN65DP159 retimer and redriver chips.
> +  https://www.ti.com/product/TMDS181
> +  https://www.ti.com/product/TMDS181
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmds181
> +      - ti,sn65dp159

Nothing improved, you did not respond to review, you did not say why it
is not implemented in changelog. You did not explain that choice in
commit msg, either.

Best regards,
Krzysztof


