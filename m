Return-Path: <linux-kernel+bounces-775484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB4B2BFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3791BC535A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70232A3F7;
	Tue, 19 Aug 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxezlpTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607432A3D9;
	Tue, 19 Aug 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601280; cv=none; b=RBmt5LIQF8qplzd/7+GhJyVibbv2TLrFsA26IOBmkNjW9htFXsOWhdtkJdvzQBaneob/mpP5w8lSrYtNn4n/24dTQGQrJSc2hj1m0DOG+EC01jK3hwwjGSiAG0xVmnkWME4DcdEYoCkN2AoLcxqHb6Qpn1Pp5M7mimP85jQmkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601280; c=relaxed/simple;
	bh=3om6RlJ1FrtuQO9/XxQ8KBEG17jf3kejVcBwwMOA+mM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ugn90ezjEB1VjFozIcJEAo675mcR48ysqGBnNDdFDNILG0Mht5nppsCEJQHHavmnjEviYQYBYrd1+mJHH9vAsJtYBlXzoj3/ZTrKqM8hV5+XI1sKU47NaTy/Iftb2/hPQvjTpopQLiXWbJAdjehZ03SeNOzpw+Z/FY9gNOaf1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxezlpTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F9BC19423;
	Tue, 19 Aug 2025 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601279;
	bh=3om6RlJ1FrtuQO9/XxQ8KBEG17jf3kejVcBwwMOA+mM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lxezlpTQ1VJxdf0sF3n0/rnCC5CGmWaOdQERGWLOLzdxQ0gwflpmXEjxaoGoiJNaq
	 LRMvTWMmc7D1V7y9qdS+Qui5fhozl713FNJQAFfUZtJLLO/husIrdEc8BHU8nnwNk1
	 5H/Ux+E9/4IO43soMLS6pxKTNHeZdO1J7OfpSWV/uzDrSeDEw2/SW7jR+0PwUiBP9R
	 oENsFr/qSfrkwcWjvtFas+aQeYLpyr+/GSj4NNbXEsj8K8O5EHpYQGz54DY1Gu+RBU
	 XAM6yMaMK9KJ2/0QK2MFHgHM7HyRSO0R0DobKAnTonjmydQqwnmSXRVbt6c58NKc6V
	 fuv+SzbfqA9eg==
Date: Tue, 19 Aug 2025 06:01:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
 David Airlie <airlied@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-5-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-5-04153978ebdb@foss.st.com>
Message-Id: <175560127275.3969236.2787022865949537210.robh@kernel.org>
Subject: Re: [PATCH v3 05/13] dt-bindings: display: st,stm32mp25-lvds: add
 power-domains property


On Tue, 19 Aug 2025 11:15:58 +0200, Raphael Gallais-Pou wrote:
> STM32 LVDS peripheral may be in a power domain.  Allow an optional
> single 'power-domains' entry for STM32 LVDS devices.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-5-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


