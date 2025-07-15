Return-Path: <linux-kernel+bounces-732637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8FB069E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B554E66F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5D2D6406;
	Tue, 15 Jul 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAIkGsPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27523E320;
	Tue, 15 Jul 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622120; cv=none; b=SEBA5taD65VCRIzuzJUsT0lHWQPMPG0zI+qoE9gk1WOZBGXDZX/X/Voulnq+wdOxJJZyXsxpDQCNiGAQNduK1vQIsG2hyCbIXl0Xp1zmjgo9YMd00OMEeJWrhTrzOz/Au46i/FH7VMg8H2VmwU2PtGAttI1Cyn2s0TJqCer4Q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622120; c=relaxed/simple;
	bh=KyPnLxCQanvEcVHmi+5itxw/D0+fsHEbld35/w59fLQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NEJM4ou/VRElPFfqL/vv+nWnAhHIAeppzSloYDefeni/KT8ZmrUMT9Zuc4DuyrVI0a5xINh9t3PU7EPvGWPwrDStRz1nX52rVOxzyEKP+kFxKoB9TUd5e7tftSQppdKppW3zbwkK0iFuCTvPwkmuq6aecZ4gx8qW8xIpk/LnWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAIkGsPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFDCC4CEE3;
	Tue, 15 Jul 2025 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622120;
	bh=KyPnLxCQanvEcVHmi+5itxw/D0+fsHEbld35/w59fLQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XAIkGsPyjcQ6Pvc5PUhmeJ21NBrlX7JTvq1l+YEI5nV0/V+8Y6bBzobpBZlmp/LN0
	 WH/xQsRKt8+JcEO3pSK3kCrtRfqf0HAe9cKKm3HFw29I2QeqpyFbSUeY4fVkRgALA+
	 v8GxKL9hZku9yzon7676VRTQ8Evq5BWSxmn7dxBS1o4pa5CcW+gpAu43XCLa9AbHw4
	 P6X9SCvL7xIIQixJL6wbxJVjBSmeCPBkTb0i2GRYcYctOV187F2hi5foR4xSjB9Vy3
	 AMw95fsEfpwKrT+DgtAlz1BnzsPUIDUPwbCIz8iwZoLOPvJQYaHGKHY5rak9ce3dv1
	 oAxsG8WCPKBtQ==
Date: Tue, 15 Jul 2025 18:28:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Arseniy Velikanov <me@adomerle.pw>
In-Reply-To: <20250715222221.29406-1-me@adomerle.pw>
References: <20250715222221.29406-1-me@adomerle.pw>
Message-Id: <175262211911.2439655.2970589940654906363.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: mediatek: Describe MT6789
 clock controllers


On Wed, 16 Jul 2025 02:22:20 +0400, Arseniy Velikanov wrote:
> Add new bindings for system clocks and functional clocks on
> MediaTek MT6789.
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  .../bindings/clock/mediatek,mt6789-clock.yaml | 142 +++++++
>  .../clock/mediatek,mt6789-sys-clock.yaml      |  68 +++
>  .../dt-bindings/clock/mediatek,mt6789-clk.h   | 390 ++++++++++++++++++
>  .../reset/mediatek,mt6789-resets.h            |  15 +
>  4 files changed, 615 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6789-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6789-clk.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6789-resets.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.example.dtb: /example-2/syscon@10001000: failed to match any schema with compatible: ['mt6789-infracfg-ao', 'syscon']
Documentation/devicetree/bindings/clock/mediatek,mt6789-clock.example.dtb: /example-4/clock-controller@11f01000: failed to match any schema with compatible: ['mediatek,mt6789-imp-iic-wrap-n']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250715222221.29406-1-me@adomerle.pw

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


