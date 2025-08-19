Return-Path: <linux-kernel+bounces-775480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05D1B2BFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8147F1BC4F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3D322C71;
	Tue, 19 Aug 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxI4Cm12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CA326D6D;
	Tue, 19 Aug 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601279; cv=none; b=foE6zHhzark9rtA1H2lcIZLiXSOb6l+BgkXKYE7N5ewOCLvUWRQiTxtNLV5PYy70y0JflzMe8P0XLfeSsB6fOnMjpicUkQ++iMzFOtwMPVnrKBRG0I6+loD0aXFtYLoxuvKaW98GKoHoKwZfowb+UrwFinsK8EL2YSkBRRGUNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601279; c=relaxed/simple;
	bh=aMp+SGnYO85K6FjMx+CQJAXcKtAWqNORTzvGcYqTZv0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pTN0/4HY9oa6AeHDgchLK56bDaBWTJ7eN1eUXPK6pFKPxWC9skdpP/fu0qIKFlOMKS40busXfORDrjlIBTpEICB8asAQZxtusJJzeAQn/595MfI0a+K7hPeBE/4Ywxi2MAMrexN/iBi0PBTzd8lddSztXUVbWzT9Q++tONqwoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxI4Cm12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A46EC4CEF1;
	Tue, 19 Aug 2025 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601277;
	bh=aMp+SGnYO85K6FjMx+CQJAXcKtAWqNORTzvGcYqTZv0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TxI4Cm12r6LHZn1X7XIONjiP0+HkBOSQaHIHeYMTLIHVe1/O+pu24I0gP8W5cMF30
	 4hHIQo3amR+gOHAvy+uuYdYtQ7y6akc8AU8imjjOKhXKv1x66qzwP1s7qefiQRlHMt
	 zxe7x6qjOU3EbBEIGuz5BRiIw0d9KwteFDFIkLTBTIH7re+eZiEpYA14rA0msm2gzW
	 XwX1ipERphXZ2UgTYEZVLuGFJsb+/kJn5UM2wiNI6fOMYBIgEopoZ5flBNYHfcy3GQ
	 sAzbgXKzy4r0SWnAMNhTR/UKorelZLeadipr/UYNjaosZ6GNjyeg11L98kJLWdxSDN
	 1NQxvuZPwyXsA==
Date: Tue, 19 Aug 2025 06:01:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-3-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-3-04153978ebdb@foss.st.com>
Message-Id: <175560127150.3969165.11609028288443229720.robh@kernel.org>
Subject: Re: [PATCH v3 03/13] dt-bindings: display: st: add new compatible
 to LVDS device


On Tue, 19 Aug 2025 11:15:56 +0200, Raphael Gallais-Pou wrote:
> Update the compatible to accept both "st,stm32mp255-lvds" and
> st,stm32mp25-lvds" respectively.  Default will fall back to
> "st,stm32mp25-lvds".
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-3-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


