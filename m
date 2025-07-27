Return-Path: <linux-kernel+bounces-747279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221DB131C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447701897AC4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C8239E7A;
	Sun, 27 Jul 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6FO4yQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0A238C0D;
	Sun, 27 Jul 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648063; cv=none; b=eGCanKSCRTQpVhuIZ+Omt0/GKBl3iNxttRy6z7EwvhaZWCDrFyhtswwjjLOtpJyVxhcoGOqvj7+uTfB0aCYgDf7/PF8RfDdbEzJdSGjqtHHtQivdoQOXCbN45gHoN/CWNryQWSh0eRxLXtIaFQAHK/3i1F1mkH9kDyPyhWdnHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648063; c=relaxed/simple;
	bh=xcyCCQzerNA14uLlW6X/eFydzN3xJH2S9fgLzi5zBs4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=EoJvkfCfyKQFhqmc+O9Iq/qhguz7kWX//OJI+xtO6ppFscoIa/j/rDo62CPjleTOtKfZwisWElzWp6Yw/R2jZ+3NMm8DpU1pUWe+YlhZJ+LYiduGOExIXSKp/tgPH+uoN7OLvvlzdFQzlG4x4EywOLxlIBVNRmDsWaCRe3aKIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6FO4yQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFFCC4CEEF;
	Sun, 27 Jul 2025 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648063;
	bh=xcyCCQzerNA14uLlW6X/eFydzN3xJH2S9fgLzi5zBs4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=n6FO4yQgcR3IGIV5K6DYGzoed2HmMLk78SfvyMkTM5UVHxzeHdy5S0fiIeoCfTWUD
	 8qf/Ow/E4PbCk/FKBsRfX+w31JMb2t5JpUTrdJoYrBlNZUew3G7XQjEPvR24A/HnPU
	 J7v9iktZ6xy39qzPZv287DLpYRCxmgeny0T72QX/xUSDh/W2mujOFfzwpi6AizwSDf
	 sh+ivvAJvrnXwUWTsZfooYW56X3Jfq0YKNiOgegLSE4GJv1xljfG+JAcpKS80c5/hq
	 71Odhy1jMellQpX5VVsUGbgf9aYwqlhYAp2oghUsius0VA/mje+B8dQAU/+LrAA8ja
	 NrXJv3u68WnXw==
Date: Sun, 27 Jul 2025 15:27:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 CK Hu <ck.hu@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yongqiang Niu <yongqiang.niu@mediatek.com>, devicetree@vger.kernel.org, 
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-kernel@vger.kernel.org
To: Jay Liu <jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-6-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-6-jay.liu@mediatek.com>
Message-Id: <175364805752.3183.16770186959720392810.robh@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: display: mediatek: ccorr: Add
 support for MT8196


On Sun, 27 Jul 2025 15:15:55 +0800, Jay Liu wrote:
> Add a compatible string for the CCORR IP found in the MT8196 SoC.
> Each CCORR IP of this SoC is fully compatible with the ones found
> in MT8192.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250727071609.26037-6-jay.liu@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


