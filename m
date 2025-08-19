Return-Path: <linux-kernel+bounces-775485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A9B2BFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC1258043A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8E32BF4E;
	Tue, 19 Aug 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZvyTfZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593132BF2C;
	Tue, 19 Aug 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601281; cv=none; b=mvLQPx8wjgiBwHfxpZtPYoqoRlUrPG5t5yy3plBihOPJ/A059KdVAKgNS7p8y7SvzbP6ozHeTABUQussh01rNKcIL126TgvfsSl7csxtpHRsdzUYZs+WmcdKxRd3i/SmE+UBMWyqGgd3avOK2O5vHDOyJ6AIwVDpEK0FvWWTp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601281; c=relaxed/simple;
	bh=LLuG8UUhpyncc1Ow4ZHRPwCCdhOwxCqGMAhjDj7ySoI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jP/pBYudx8xKI9QSvJ2j8fxRatOXWCuGFMiVTdHkq6ACYPyuqCNUBmmSvBZ/w3T9rinolNKfetI/HK4sOqEDs9HN3w2AKMssrM7T5ocjCOwOJRzcP6zuvQ1vt6Rrb1ZX4VtmkPQQ2XzbxhsbOGCk5dSvjMQe5F9jRv3zW7z0xR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZvyTfZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3EC4AF0D;
	Tue, 19 Aug 2025 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601280;
	bh=LLuG8UUhpyncc1Ow4ZHRPwCCdhOwxCqGMAhjDj7ySoI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZZvyTfZmerde8pNhMfOL3u+TomyGc1qsh/jorWa49JCyGoe4OWFVjjKr7f5oXBfG4
	 QMLiauXOd7UIw8Wzsd2SqefGzmrUdDuciqVYKUtLp7CCznE+tX/chq99np5nuWhBbf
	 K4CdcvMXIUL5/h8C2TGbu4N8Lk4MgO+HmWIuFZtr4GINE5SiD9i6WSq5MydMn7A2jG
	 5YRuO1DfX5y7jWvHtv6wLPDKE4N4g4HdRsymWuAPXqNU7T8uR0ZZlYwTGQ1Zl9zR7s
	 CT04yyJajSDE+u0oiFNut8uQ2H1K5JF40w99h9HWpX9y16x4PJO7YoOZDWSPEgbqdb
	 n4LCyT3l6tOAA==
Date: Tue, 19 Aug 2025 06:01:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-6-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-6-04153978ebdb@foss.st.com>
Message-Id: <175560127329.3969258.11704849224286577096.robh@kernel.org>
Subject: Re: [PATCH v3 06/13] dt-bindings: arm: stm32: add required
 #clock-cells property


On Tue, 19 Aug 2025 11:15:59 +0200, Raphael Gallais-Pou wrote:
> On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
> subsystem through a multiplexer.  Since it only provides a single clock,
> the cell value is 0.
> 
> Doing so allows the clock consumers to reach the peripheral and gate the
> clock accordingly.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-6-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


