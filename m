Return-Path: <linux-kernel+bounces-745765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD6B11E45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DB3BB46A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0112459C6;
	Fri, 25 Jul 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDwUZrR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB423CEF9;
	Fri, 25 Jul 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445545; cv=none; b=WkYOy8xfV2yR4cXc23F6bgj5coeh+G1zMQ2yZVr4AdX9BZvKXju5ULr9ITWdkbqojPRAguznvhiwRhFJ1WjXWE68sNAZ1m83dPuoQEqTtHDw87smm0s9xLyqOCsTAk+JBWlnRBPpAg06cQtkVa6OakziLyLjCjyMI6z8f4EUHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445545; c=relaxed/simple;
	bh=oWhXpWvXJKtar0BRT9MkmY1ZrHGWmX4khazLG8viu9s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GMpuCixSU6v/iq8HNTdA6Z14aA5ppNJN315dRUKEHuFbtO4FP2RbOFZQKgfSGN2t5q4P+5vYR+hnm9uNMHpQi/+oZBNIeCZlmOxTo+cTtwUpED02dOMDngkxiJ966SVG8ln2/zcn8yO/8K5ckSTIlG+lrfQE7VpoN0SeDJxmTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDwUZrR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FD8C4CEE7;
	Fri, 25 Jul 2025 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753445544;
	bh=oWhXpWvXJKtar0BRT9MkmY1ZrHGWmX4khazLG8viu9s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vDwUZrR50knB/uu9wIwecuE/n6L2Zq8Eq2Poc2AHPydHKd5WLGm0Gp07a9e7X3uLQ
	 Fut/UhFiGRvUCU0E/rsd0vlo/nrGVBsO5O/IqqcSf6CVIFx61+FElWaG9kc//6fen9
	 7l+7ntGqSM09lHzhZM/Vabt6iGdmq+XPctxioEdgv/RmIz59ScNwcivx5YNntqcuHY
	 S8JBtvACl9UR41kk6tbFvBByEtt9hiF9O94k/G6ZgXyGyYG98oKiPMgEO4hmmsAqyQ
	 nF4WLP9+12dOi2qIotPwr06LJX6MeFFVAA8jMgDrN1F+nMw6FuzbDZxzoLsSFsJ9jh
	 9VOsL/klZ4Wng==
Date: Fri, 25 Jul 2025 07:12:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, Simona Vetter <simona@ffwll.ch>, 
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com>
Message-Id: <175344554296.803203.4450272226884409035.robh@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: display: st: add new compatible to
 LTDC device


On Fri, 25 Jul 2025 12:03:53 +0200, Raphael Gallais-Pou wrote:
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> it is incompatible with existing IPs.
> 
> Add the new name to the list of compatible string.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 37 +++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml:78:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml: else:properties:clock-names: {'maxItems': 4, 'items': [{'const': 'bus'}, {'const': 'lcd'}, {'const': 'ref'}, {'const': 'lvds'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml: then:properties:clock-names: {'maxItems': 1, 'items': [{'const': 'lcd'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


