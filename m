Return-Path: <linux-kernel+bounces-775478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88AB2BFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0084E4027
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A4322DA6;
	Tue, 19 Aug 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6WTmdxO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295732255F;
	Tue, 19 Aug 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601274; cv=none; b=ZbV899JnKq0KeONNt0lRX7kPzvcVM0pXtP8uxXhty4QFexar3Ui+LYz+pkkp8YfbSnbiEViRiucqvbq37mW7D3e2msJie4tdYdop/w4kDGdOv8vlnfIJQ8gHLNi+Jb4QVabgTRPhOdH5oA3+XjQ8ZS4M5zVBJ1W+/oyhvXdXE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601274; c=relaxed/simple;
	bh=UGEMRjTBsqlULw3vbm/co9eRDP9gi0S0uyPX0lvQ2dA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pKJCHrJJtsX90xYayJdu6oE4zc3kpb286VsaCqUjdpgFa79cTR2vIQjD9JSwt52G36x3Zcm9rMRXJNwJ86KxP3DO9BWoxDYrkGHciF4KJ+Er8JJR918BTMgkoiDekwRZZvQ15ckbbIDUbwIpnFoqhz6OR0fh54RtA60We6DfxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6WTmdxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133B4C113D0;
	Tue, 19 Aug 2025 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601274;
	bh=UGEMRjTBsqlULw3vbm/co9eRDP9gi0S0uyPX0lvQ2dA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=I6WTmdxO2ti6c+P6AFRq0hFKJeuNl1wFUwj0NCunRFIAIcpiYhbCXl39rX1uzzk8p
	 oB5gYz/yLkDitbzhq+hzzS/ov6i4f6lfXYm8gfYf78Yj8YQctSATdeDNwnjk+P4Bgh
	 TXZ6h0UT0zxfLzwhySiolmUo5sHRgZhl61Ty5XusA0xmFH/L8mxqO3Nh3h4lT/x+gj
	 PPjGvvzqEB8eh57UahoNtdT05LPmExIqkehWo5qmkQK/wwF3EVtLCVQr50SHozv6L0
	 ZLRYekP4w/pHX34fIfDMtoNHVeDAfe+c3JPOJQjACZGhjU/2TJoUNe6c1afwx2+c3o
	 pRqIiEKcfDqPQ==
Date: Tue, 19 Aug 2025 06:01:13 -0500
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
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 devicetree@vger.kernel.org, Philippe Cornu <philippe.cornu@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>
Message-Id: <175560127037.3969097.6130940505156039734.robh@kernel.org>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: st: add new compatible
 to LTDC device


On Tue, 19 Aug 2025 11:15:54 +0200, Raphael Gallais-Pou wrote:
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> it is incompatible with existing IPs.
> 
> Add the new name to the list of compatible string.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 30 ++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


