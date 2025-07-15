Return-Path: <linux-kernel+bounces-732191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC8B0633D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E1058074F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9924A069;
	Tue, 15 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4a+n1qJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56E246BBE;
	Tue, 15 Jul 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594090; cv=none; b=QF15jl5bqlt8NkueK7tDNtIJQtfE2sfawuQlFGiTtUb/Aud42VNMdBeFalh0vmbkKeeiyGAL59yPttfha5UtM3NLiLBsIh4gpcKNTr85NdGNUSRGnkkOx2M8VhK9KfhtN45SovtRyaCrhI9Rdufp2BUxTUD5UY7WbfcdlXG0Doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594090; c=relaxed/simple;
	bh=R8XLWjxO7fHl69Hs/rVWyMH3nTI1Ns7HGV/NkxCeO28=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Si1y+sUdodC6ji2GvcF64eDTpfvLniohC/TNILGFlhzmfRDFTGPBqDFHkAcE6FLJ42o6lt/c5ZdY1L0i2s3kc3ucXVYWATdBmX72t+1MkPtMPv65dnOtIxSLBT/QxH6I1GbAOhHL4xJUaUrOlcMKdTIceUnLDbO2YpNI5m/o+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4a+n1qJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97554C4CEF7;
	Tue, 15 Jul 2025 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594089;
	bh=R8XLWjxO7fHl69Hs/rVWyMH3nTI1Ns7HGV/NkxCeO28=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=A4a+n1qJd1RCESFWzOIErYHAyrk9sWqkEKMvrmiLTYqnZ6YqrRySamxZamxGAT1IK
	 oXyj1fMTE+FmZX++Nh1ffZg5BqjEWM9Pd719lKyZP2S9PHC0rqt9/bSgTEbO61I5mN
	 p1F/Da9p1CbSVohQzJ7LhOU8wJf/dbd7AI05aPuk6/yFitniYNHVG8syNqpv/OmJer
	 STsZBBB05SZtujS8EBi5t7SBJ3Q5Y3O1X722O/AAy/DxvBP2b9uLMdTaKnAUcdQRdt
	 QSUFrY5aKwWPLiJjavORjypumuVVkLSkYPqBm65hAxJNHstlqsDP7CcDrsmOZ9HuIh
	 2nlzlaKq5CLfQ==
Date: Tue, 15 Jul 2025 10:41:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lgirdwood@gmail.com, krzk+dt@kernel.org, broonie@kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 lee@kernel.org, devicetree@vger.kernel.org, wenst@chromium.org, 
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, matthias.bgg@gmail.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250715140224.206329-6-angelogioacchino.delregno@collabora.com>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
 <20250715140224.206329-6-angelogioacchino.delregno@collabora.com>
Message-Id: <175259408681.1379973.6795919680744045079.robh@kernel.org>
Subject: Re: [PATCH v5 5/8] dt-bindings: regulator: Document MediaTek
 MT6373 PMIC Regulators


On Tue, 15 Jul 2025 16:02:21 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6363 PMICs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6373-regulator.yaml  | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250715140224.206329-6-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


