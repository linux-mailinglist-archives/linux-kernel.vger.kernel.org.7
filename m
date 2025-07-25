Return-Path: <linux-kernel+bounces-745766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1CB11E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5691958290D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE49246776;
	Fri, 25 Jul 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tok2lSwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21D2459DC;
	Fri, 25 Jul 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445546; cv=none; b=AXEPRuyj7Bzcm0eBQOXb/2UlsIBn+ZmSA/kuX8rHMT221KhCiFxBaN+BkYPsk4SXh0wrwwn5t1xijYx6wEf0IzBQXUVoo8UBZegfonjZXK0bxzE2xwwoDa3jawgguW8Hw5ba2h89WFXVyZYCUpsdhu4mfDYh18fofgdxhkKh+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445546; c=relaxed/simple;
	bh=1KrjuWTj/BAGpJTBOQ4VNJ8knTL5uEp25bM6bJplq4M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KafE88hOtW3dZc3tbLMpGyJs3BJDGSgNcMu2bNqzWNeLbz3PCHNfgFmAN2S7/RHxoLnTvdHEEljEAIMPrRlhNiPoupfmyYVIJlpaO9Yim1MlmX75oBaehrgH4NQd8bOlwDurq5dlKdy05RpZke8B4WCk0R0Lt6o2RN33yzXUMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tok2lSwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B7AC4CEE7;
	Fri, 25 Jul 2025 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753445545;
	bh=1KrjuWTj/BAGpJTBOQ4VNJ8knTL5uEp25bM6bJplq4M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tok2lSwBDH1X8yR9/Jc4IVbBIYqpjB0vyEjB+bEiKaiiebGkT7FP9crn6eZ4iBPRe
	 kdOuy8MUsvnb5CGblr7NIZtTChxBOgisYpXP/PjMTDPbaUTCuOLWNwjWbbti5GORCT
	 DPJ9xpHnsUYIHIzzfmpzF0IeRK6hRvfT7IuYW35pl5Nh3QR2nNF87TjPA3iNhg0y58
	 SNsRGnzVtikyWO212cXdPOFGc1acTFvcXLSlRD0c12YK65dXK/PsYUVSIXEaVoUcWC
	 4GWZLyem7jzBUIAOi93jQD1SCc0j6m5h0mm1QrwpumtXI7BuFnLcV5u80+uL+Aq2KC
	 PLmab2yoKcjMg==
Date: Fri, 25 Jul 2025 07:12:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Will Deacon <will@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-2-a59848e62cf9@foss.st.com>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-2-a59848e62cf9@foss.st.com>
Message-Id: <175344554361.803254.9739669006063034292.robh@kernel.org>
Subject: Re: [PATCH 02/12] dt-bindings: display: st,stm32-ltdc: add
 access-controllers property


On Fri, 25 Jul 2025 12:03:54 +0200, Raphael Gallais-Pou wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then check
> the peripheral accesses before allowing its device to probe.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml:81:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250725-drm-misc-next-v1-2-a59848e62cf9@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


