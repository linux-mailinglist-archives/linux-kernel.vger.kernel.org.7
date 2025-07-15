Return-Path: <linux-kernel+bounces-732192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C986B06340
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09041AA398C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F8261574;
	Tue, 15 Jul 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7rdeNla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3702AD2D;
	Tue, 15 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594092; cv=none; b=FMBLJOodNCluZiDf5us1znGXbghod8/PAWhsFu4AFd6hovJ9uUwK1Iru0TpeUGy6cdfW9Z56fLXbFqSYoKQV/qCaJHQx4uVxV5HMfMfN7IbFJEmymOQC3JYI3VeX/4nry27A4baFa0ErmBPRFwU+V2nlLxXVGWeN6Lc/UZOr1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594092; c=relaxed/simple;
	bh=9R74i+8xUMSEjjizVKVHIpxeVkW6Fk9LHFlO/Fzc1DY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=T6jp/2j+tcb2sm4Nq0WfKWdwokIhAnicqcm/82vZNgcB0+1LOJjsu5NPvoFr5use/GlfvdnrRUitcACzgNCAjfEsM+uHefteIJndNJRZqRe2c4TIx6dbBlOkmwjC8ThePxm6sAb3/jAYWRO8i9unY4miFzNECQEikF+KXik20C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7rdeNla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99037C4CEE3;
	Tue, 15 Jul 2025 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594090;
	bh=9R74i+8xUMSEjjizVKVHIpxeVkW6Fk9LHFlO/Fzc1DY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=h7rdeNla7v//kuHuFZuZhCmbfC/JlVwD+QRkzlHdBkTDWMj2yVx997+Iqtc+vH4V4
	 Vp55eUcGakznG/gRTl+odHHGcaK9hczJ+L0dqovQ+oD+R3MfbetTzKJZhsFmsULETg
	 uRhCzF1AO4YJfHdmL3dBGPflX2H+Q3CtMwguq3QPTGccZx1lgDB1YMQPZcXQIb/O/L
	 vju4rf+deiWvMNnFj8u6E33srhh7IVjZAKnRLJz3Jxc+ncleX1BSrh1V1I1mNHjaPV
	 obJ/ycRijwV1+JDhktcu49H3B/4IQLP2dlEfo4aVkJMq9whUOrfe4+Ts/v/W+s2Y6q
	 QysaB9nVdbUGw==
Date: Tue, 15 Jul 2025 10:41:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, lee@kernel.org, 
 kernel@collabora.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 wenst@chromium.org, lgirdwood@gmail.com, broonie@kernel.org, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250715140224.206329-8-angelogioacchino.delregno@collabora.com>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
 <20250715140224.206329-8-angelogioacchino.delregno@collabora.com>
Message-Id: <175259408775.1380012.11849397051967783374.robh@kernel.org>
Subject: Re: [PATCH v5 7/8] dt-bindings: mfd: Add binding for MediaTek
 MT6363 series SPMI PMIC


On Tue, 15 Jul 2025 16:02:23 +0200, AngeloGioacchino Del Regno wrote:
> Add a binding for the MediaTek MT6363/6373 (and similar) multi
> function PMICs connected over SPMI.
> 
> These PMICs are found on board designs using newer MediaTek SoCs,
> such as the Dimensity 9400 Smartphone chip, or the Chromebook
> MT8196 chip.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6363.yaml         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250715140224.206329-8-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


