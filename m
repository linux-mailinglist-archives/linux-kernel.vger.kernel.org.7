Return-Path: <linux-kernel+bounces-806029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03DB49102
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B183C002B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DD30C639;
	Mon,  8 Sep 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFSdKDSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C930C34F;
	Mon,  8 Sep 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340926; cv=none; b=GZ725jcdLKMqoLzGxMrwJ4OXgRqkwxFJylir/EGFvS21mRXj9Av8r4vWFEJmoj7mrDAXbAPt3UvGZ4P6L/pY8NNs6qMXJEujqenC5z0ey7t5D112L/HXcZ5r6EmKVSzETmowrqO4LHSrDoggUs9wSEu+nVU3m2nqUD4Kl3kLDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340926; c=relaxed/simple;
	bh=h6Qry5FC98QS7Us6GZ3WJl94irnInyNVErTrv3usnxA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aZyhtvqxQbKE1CufIRZgz5Wiqft2ErfORmP5UooZn9fSg6WKi6tdLWVhFbuU392h6e0kigNDq39hUld9+fuBbmYNjNLanHiOEZsP4/SX902OEN+OvtApiV2FpXl+qShWaoeLV3ZQUjGIZIZvvtJsE5UeJ3ONnAyDJd+yQRvrwoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFSdKDSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28C4C4CEF1;
	Mon,  8 Sep 2025 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757340925;
	bh=h6Qry5FC98QS7Us6GZ3WJl94irnInyNVErTrv3usnxA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KFSdKDSseC+nvewrqp6aRmdLOAqtxbu5vDa/ojMk7gz2w3RgBcOeq+Mi5ibIXw75c
	 B4jiwl/CjacSdJ71MywD3wUq9zdPXAz//JlKnG4ae/XIta6H4T+OcPp+gjHDgz03sf
	 EJUr38/jpBv+mScdnONUNyYcS9WbMgwf9zhUgaYfnJ0BisU0fl0wRGf9WTLJ5bFlPx
	 Fic4XoKLvzGMYgl5g+WmfvhflBKJ/ZRDt+O3RwB0wyTNj62F2F2/TZ0MqNSbNE0YOO
	 bN2oskl4Vq+1qpJMj6IOcVh19Nmd97i//lBvx6da2J+x0TIN1/Wyv9CeBGLZpexm0p
	 +iIxCh/mgF8LA==
Date: Mon, 08 Sep 2025 09:15:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrzej.hajda@intel.com, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, rfoss@kernel.org, u-kumar1@ti.com, 
 devarsht@ti.com, krzk+dt@kernel.org, sjakhade@cadence.com, jonas@kwiboo.se, 
 tzimmermann@suse.de, jernej.skrabec@gmail.com, simona@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, airlied@gmail.com, 
 dri-devel@lists.freedesktop.org, s-jain1@ti.com, yamonkar@cadence.com, 
 devicetree@vger.kernel.org, Laurent.pinchart@ideasonboard.com, 
 conor+dt@kernel.org, mripard@kernel.org
To: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <20250908054609.1113360-1-h-shenoy@ti.com>
References: <20250908054609.1113360-1-h-shenoy@ti.com>
Message-Id: <175734087919.1809101.10556288924860708163.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC


On Mon, 08 Sep 2025 11:16:09 +0530, Harikrishna Shenoy wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
> DPI/DP bridge.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
> Changelog v2 --> v3:
> -Update the name of dsc register block.
> -Add the reg-name list in conditional based on compatible.
> Link to v2- https://lore.kernel.org/all/20250903111357.2605199-1-h-shenoy@ti.com/
> 
>  .../display/bridge/cdns,mhdp8546.yaml         | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml: allOf:0:else:properties:reg-names: {'minItems': 1, 'maxItems': 3, 'items': [{'const': 'mhdptx'}, {'const': 'mhdptx-sapb'}, {'const': 'dsc'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml: allOf:0:then:properties:reg-names: {'minItems': 2, 'maxItems': 4, 'items': [{'const': 'mhdptx'}, {'const': 'j721e-intg'}, {'const': 'mhdptx-sapb'}, {'const': 'dsc'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250908054609.1113360-1-h-shenoy@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


