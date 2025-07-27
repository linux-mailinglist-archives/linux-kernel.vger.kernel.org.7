Return-Path: <linux-kernel+bounces-747281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C655FB131CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B5E189845D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F323D2B6;
	Sun, 27 Jul 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq5JtLZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E323BCED;
	Sun, 27 Jul 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648065; cv=none; b=QEKoxd7MD5yEzEk7dFNXBJcSCGw+MsVgR97Io+t+1omg5DhEcZaxAQqVp1mumCpXkzmNPwVW3atpE2XBe2qhmRd3M81g/My+VhDsXFvO/boYIGk28SPZ1aUxczNDLS80Gt6/niOgNpOe6b+oTmLvtjKVlWXToiNWUjgmqE4hOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648065; c=relaxed/simple;
	bh=dRmKTiw1fab4d1US1qUGI0FYfA7qFL9ZBkYLrxz0Ggc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UCDVN0dP79ChBEGMm4aF0ClPqdknht3x2V5VoS+DBPMnsfbgDxpAUVjUM69dyqQ6M+kXHrRfVEvKYGM2cwyb8eLhVuo9Ne3P487t9yb1gfmPgdvK+Du+iNbxsibzH3LB1yEVb+9L9FjAyKnNdXF3xMIv7x+g+6qjMPCeKjiDUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq5JtLZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCCEC4CEEF;
	Sun, 27 Jul 2025 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648065;
	bh=dRmKTiw1fab4d1US1qUGI0FYfA7qFL9ZBkYLrxz0Ggc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jq5JtLZEZpLoCNWFTg+zyA6D89n/H1dyZw3w1qZbULqPLAxOSoJemrH0NHFYWcYR8
	 m2PbU+k6BVHaas8uwmq2yiUr1lLcSH67hMd2QB2PFFn8YgjzrDmXAGZBxo/0YCGUOj
	 nS8IC4yAr/u3V6dujSb4H4od8rJgzO280UBhct+GDvjLbSdqxjV0zNDkKYCJyhx3m+
	 19IknIcUtPOw0HhHcmRMArA3z/062HBkg43Py2FvAX83n1O9flKfEs2MSD7i0J2NKH
	 UoUrlfO/20L7950bYyElqd5459B7duUsjhjAODcWxHFWMSvSvjQMio/UsFRKL8LHy4
	 Bvnv50yD5h4LQ==
Date: Sun, 27 Jul 2025 15:27:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Yongqiang Niu <yongqiang.niu@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
To: Jay Liu <jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-8-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-8-jay.liu@mediatek.com>
Message-Id: <175364805939.3229.16063506192573561035.robh@kernel.org>
Subject: Re: [PATCH v2 7/7] dt-bindings: display: mediatek: gamma: Add
 support for MT8196


On Sun, 27 Jul 2025 15:15:57 +0800, Jay Liu wrote:
> Add a compatible string for the GAMMA IP found in the MT8196 SoC.
> Each GAMMA IP of this SoC is fully compatible with the ones found
> in MT8195.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250727071609.26037-8-jay.liu@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


