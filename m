Return-Path: <linux-kernel+bounces-747280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA38B131C8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC652189845E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E16231855;
	Sun, 27 Jul 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP1Un8Ut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7423A98D;
	Sun, 27 Jul 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648064; cv=none; b=KCqaEDxBI0d9R565as3Ug205KlIyPl+mwuyEadQgfW6dD3ik7uuC4N/odbshi3zRQlvQa+WvYoglIP6FApJxy4dk8zdDaPG3dMGaW/XSFFfsoaI7cNALaoot+e5NgBk05Rv6R/kTCXS+ujagVHt5mv03JXODDXKcFpKGY4ZE06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648064; c=relaxed/simple;
	bh=5nZ81Q45zXBq38DZEfLN0BWGpMbT08thVZb065qc1X8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aaVqCf09hzSBcCphBBAXYho/naQmE2wqQdq6PGWRcS2F4rWWRwxWkpWqTRAbQ2orTCBFOFmhg8mpO9xe9fed/eraoeISu3yqj6Anuu0FR+TKmL2wzOCeSXp2oF75urOSj4dczPuA39CJmf5V8t1v4Uo65Z8H5W60AF1IyxPZ0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP1Un8Ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E84C4CEEB;
	Sun, 27 Jul 2025 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648064;
	bh=5nZ81Q45zXBq38DZEfLN0BWGpMbT08thVZb065qc1X8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YP1Un8UtCBFJ9dp5dotJeSuxHo5OFLd27K0ScDaM7nqp1oKN+MoQPRMjBPhDGxG+x
	 PAE0F6yuH8AoA9u8WC3RNs39MHUq70tVg8ra0Uv92OgVGz0zocRVrsEBIL7gr22HBZ
	 IRhCjCQfVR/BeP5nqZtaSUb5MEkF+6Srw+a4xLDc1gNzoPfMUuiSuSU3Qdo2HvXTQI
	 TMPBLGgB3gKP3D+S5Ra5LId4d+1Fxfq+x9v1/tVGNL/9WDR3y3OjjmjjZb95ZqN1QE
	 i3614ekCAQ/L9r0a6Zc7AI1Jz23koPmFfcEKvmpF6RkfIktLkp0u00qlAEdrQNjtJW
	 TES2XQFgaF00g==
Date: Sun, 27 Jul 2025 15:27:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Yongqiang Niu <yongqiang.niu@mediatek.com>, devicetree@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-7-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-7-jay.liu@mediatek.com>
Message-Id: <175364805847.3206.14487659451507375281.robh@kernel.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: display: mediatek: dither: Add
 support for MT8196


On Sun, 27 Jul 2025 15:15:56 +0800, Jay Liu wrote:
> Add a compatible string for the DITHER IP found in the MT8196 SoC.
> Each DITHER IP of this SoC is fully compatible with the ones found
> in MT8183.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dither.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250727071609.26037-7-jay.liu@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


