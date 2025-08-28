Return-Path: <linux-kernel+bounces-790070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661CB39EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092561C83B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24480313E3A;
	Thu, 28 Aug 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwweZqIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D4313552;
	Thu, 28 Aug 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387827; cv=none; b=t4jNRTwhJTFhMkqnauW+TU9nkH42UA/KLu1Ukv3JzYcEjziYclRB/nIfcMPZMFrx6kwFHfsHqLwq1d/qlyJVpSTSS8NOBO3WE6Ywk8jepsgvb+OUfziVv4GqjfOIrT8gvIZsn48zTEKsi0ZesJTFwlPWYn82qULOX17Za7hHlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387827; c=relaxed/simple;
	bh=Pp+mUIl9DaMYLcizWDp98QlTF7nc4qrOwFHsc6v7+TQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kObpU5shRVJkXOVR/cQPrxhu1XxDOZl2OsrSQOz/1LB/FDKiBHmFTM2RSzos09hyRejVHpKK97EkcJWA/pQ9IT8slYbOpKHEd86lVi8uBd1EtvDzotMpRn7zdz9C4X29+buOuVbarxFYpWsrTBxoKkjafBMUVbuN2Qucvf83Ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwweZqIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467BC4CEEB;
	Thu, 28 Aug 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387827;
	bh=Pp+mUIl9DaMYLcizWDp98QlTF7nc4qrOwFHsc6v7+TQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TwweZqITjVRYZRGj/vPSwPYU+UtXXfCd7962Xofky57MrVDYEefi6ytNHNM/1pMAr
	 gS91QN2ZgTy1WqjajoriR9lBkyVMZhy5B1qonweQHmhRxQJTCh4uINMC6WjdGy2h5G
	 yuQqN1G1TpGQwjg6Rj1krDl1hHHMBncEzOzu20RzOJJoQHvzZam5AERan/IwNloBsJ
	 DSORi/1S7rGER8QbPP7/KkrRLJ54G5t4n9iklDI9tLBfhW4nWkeMn0ShjrhvaIVM8t
	 ZWKB+pjIT2PBGMkhZ984seK9kn+1q8MfFSousLJm5EvZYwt2Te0Yy1hpX/aCn9V/l6
	 LSDmscGzpEqoA==
Date: Thu, 28 Aug 2025 08:30:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: xiandong.wang@mediatek.com, angelogioacchino.delregno@collabora.com, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 dri-devel@lists.freedesktop.org, p.zabel@pengutronix.de, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org, sunny.shen@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, singo.chang@mediatek.com, 
 linux-kernel@vger.kernel.org, chunkuang.hu@kernel.org, conor+dt@kernel.org, 
 linux-mediatek@lists.infradead.org, sirius.wang@mediatek.com, 
 jason-jh.lin@mediatek.com, matthias.bgg@gmail.com, nancy.lin@mediatek.com, 
 fshao@chromium.org, treapking@chromium.org
To: Paul Chen <paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-4-paul-pl.chen@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
 <20250828080855.3502514-4-paul-pl.chen@mediatek.com>
Message-Id: <175638709894.1370676.14730988453056252892.robh@kernel.org>
Subject: Re: [PATCH v4 03/19] dt-bindings: display: mediatek: add EXDMA
 yaml for MT8196


On Thu, 28 Aug 2025 16:06:58 +0800, Paul Chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> Add mediatek,exdma.yaml to support EXDMA for MT8196.
> The MediaTek display overlap extended DMA engine, namely
> OVL_EXDMA or EXDMA, primarily functions as a DMA engine
> for reading data from DRAM with various DRAM footprints
> and data formats.
> 
> Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
> ---
>  .../bindings/dma/mediatek,exdma.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mediatek,exdma.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/mediatek,exdma.example.dtb: dma-controller@32850000 (mediatek,mt8196-exdma): 'mediatek,larb' is a required property
	from schema $id: http://devicetree.org/schemas/dma/mediatek,exdma.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250828080855.3502514-4-paul-pl.chen@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


