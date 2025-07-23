Return-Path: <linux-kernel+bounces-742052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C06B0EC74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC113A91AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A75278146;
	Wed, 23 Jul 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSKxe20+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3F2777F2;
	Wed, 23 Jul 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257300; cv=none; b=AnyxgjBzyl2O6XrBmoGWKzzwgTmN0zZfGwCAj//79tzLd3sO/4ykKf4M3Baw7omyncl4RqRKjqJ+k26BElV/8aEcxl8Yqss96gRnrZKRqGBinZSUjQR8gHUqW3RA6gvIRk/PAI0Q7vc4mX/rbM6Iw9ic54P4wNFXn8JorQapQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257300; c=relaxed/simple;
	bh=ZDYcPCDUmn1VTBeGdo4epTjJXexbWNcEvLjw6WdeLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyrjQIIVNcQuUjpFR/d4f8ov5QkuYMg97ISp0fPFyKPoeyV2smVj+V9iItp1QfcsW5pnZphC2WuIEVLVZYQhG3qbpc1z2BonBe5NG3kZhS7TMObzK2bmrnzk/OIfW9g6bWM0lFrCVxtq1p2fdlzJDElEEjdNlVDG7tazpEVzh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSKxe20+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A6CC4CEE7;
	Wed, 23 Jul 2025 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257299;
	bh=ZDYcPCDUmn1VTBeGdo4epTjJXexbWNcEvLjw6WdeLHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSKxe20+g0A9UzE8VPgZt5ArBXuVTbs+X/NYjoqhp3MpcACaXHVjEYhVS/sDlPHPt
	 pCQ3Q5NWj+cOaAgXpAMd72NDwogrPG9dZdW5sRtKQI47NL483qwslHo2vD61bnEOnw
	 p2i9jqfnFBojlb+Lqidx33ObDNHkWERkgzd+w6gIVxhOr8yGoC1NwwSfcXUbXmh4lN
	 vDyXwPP+Hum13QzrvCN+O5pW3DYWlszXIxeWNR2pCNTIzzYw3aVt+mXaCaeqh7L+12
	 3XHLHBKFQypr53WR1kYriB+iTGAC4oSd7sJlqTfudrEUOKCaPcQFnn4OgRKSdAQMdf
	 dqw6r+qkftZhg==
Date: Wed, 23 Jul 2025 09:54:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: display: sprd: allow attaching a
 DSI panel
Message-ID: <20250723-dark-modest-mole-480bff@kuoka>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-3-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250722-ums9230-drm-v2-3-054276ec213d@abscue.de>

On Tue, Jul 22, 2025 at 04:41:05PM +0200, Otto Pfl=C3=BCger wrote:
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description: The output endpoint, usually connected to the p=
anel

I never remember if the output should be a "port" here or a panel@ child
(as described by dsi-controller.yaml). Various users do it differently.

Syntax looks fine to me, so happy to get second opinion on above point.

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


