Return-Path: <linux-kernel+bounces-775481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE72B2BFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07BF1BC4F33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D732A3C4;
	Tue, 19 Aug 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp5P3C4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04D322DB1;
	Tue, 19 Aug 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601279; cv=none; b=gLtXAdYRx9sOMeXnPqeBVpxZ/FBJij0SEk3Y2tr7/0Hip3YjqdOTngXz5YvHtntaQX905zRAFyoNvQIx9ERjtspUnjrkEAT1Rqat6lBVJMojimJ6IF0b5H3xQDS7WlnlaWDMmigjOCuS+Z2j30/v1v7MRhzTdrgdZiduxzASci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601279; c=relaxed/simple;
	bh=RSjFfaJWxUYQblpzPRCwMN+MZXg/TH5y7U62UV8jFM8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZXxnjH69iDds9Og6zlim4cw1YAG69/SuSthImfDBe6z+gbwNfkfT/TIG7ax1rB+r8D7qOdBmYPt5UvkdWnfqG6WeVQKwyjqRkPTzJ84b5wUXJ1ZJ6eMqI2ZPM2wAZLL9EpfjC9YqD6TML2RNWUOuNnYwsSSgAb0SDf3ggbZqAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp5P3C4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42EC19423;
	Tue, 19 Aug 2025 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601278;
	bh=RSjFfaJWxUYQblpzPRCwMN+MZXg/TH5y7U62UV8jFM8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cp5P3C4IVS6iImCXa6xcb0aPNk5MNB5mhhBh10d62W9vpZ3DmjcPwhOt5bGtPU1H+
	 BNVWxQMnikIbNxmGUlor/Amk9Q02NvfgtdSv4gR2otc8I0dUD/qv6wPBG2FafHzbkF
	 DqJ36yLq5vqz8ev9x8//SIt/8yknzeJOdYFZ/TvTxpUSMnoxGy6y5elLzShe2Bl7j+
	 3Kx5JFTSjJ89Kmau6tYlg2TC081JeLmkmI7XuhgHspo/JqseGEpWtiJzvixKrhNpQv
	 fRlDv0wXKLpN2OtT18gOESyulrv/YKsr1H12SrdmI5qW4MBNXQ+P30s6nQU3REeTFl
	 9NMUlIKWhPTcg==
Date: Tue, 19 Aug 2025 06:01:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, devicetree@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-4-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-4-04153978ebdb@foss.st.com>
Message-Id: <175560127211.3969200.8967459930007695197.robh@kernel.org>
Subject: Re: [PATCH v3 04/13] dt-bindings: display: st,stm32mp25-lvds: add
 access-controllers property


On Tue, 19 Aug 2025 11:15:57 +0200, Raphael Gallais-Pou wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then
> check the peripheral accesses before allowing its device to probe.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-4-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


