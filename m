Return-Path: <linux-kernel+bounces-738257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9478B0B66C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98D316FE47
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A720C48A;
	Sun, 20 Jul 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJoms7f3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A42AE6D;
	Sun, 20 Jul 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021941; cv=none; b=XtsyWJn9L0ADeWlPeJ45QmcvTsxSUwLzE+Xp2TrlbBMh8BhtXVafGh24pLur6H2+uaHHJWiUKknYBbkYF65UAxVCUnCZDoHxbdn6Djvgfd47ly8cC/SIOTyk7X0P+G7d59+R+OSCbQhEVHeQQkhQ6wadi8zkhpQ/WPjupPkl56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021941; c=relaxed/simple;
	bh=uSx96+KzW5uSVtm6QxLt0ynjUYHR1GTPKf5JRTP4qIw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GTbzf1cOqQHSYFtSz7Q3P9G9q9n0X7ghnR37Pw/nHSlnIU5DY/siZZRM9EnF++T4SJzk+gAww/M2cspnP1/hAVLJpGxio/QbCZjHX7tnW4PPZYDD+WGzX8ncaKF7sNG18j4eqd5QFBFuoGUfxDR5zhfFz65ZyIl5iTj8g1tJJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJoms7f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D9C4CEE7;
	Sun, 20 Jul 2025 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753021940;
	bh=uSx96+KzW5uSVtm6QxLt0ynjUYHR1GTPKf5JRTP4qIw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LJoms7f3GofnOd3wdsHXW7ThunP+oLJ9ETKMRaFxT9zXQjEdSLkVkL86VxXCVBcWX
	 AriodnEgDqkzd9nYqN3qE5DKAG3eJ/xp7MUZzBPeB5swEfAW3BCotvBJh3sDffWaIs
	 Uzjp8FeZX0C8fBYaP/dK0i5+55Tw2yTGl6hcgXDNzsY7abxzfsUi081kUaK2654Mg2
	 JLJR1pqeKxzFbnA9odBHDSgqyyF5O3eD3AM5F+Z8VgfKO5eAn44DIxEk3Iyd2kYdpR
	 yD0Xf4VNx4NE2cTI8JcJYerIIkr4I4/nzLMxSCbn9Ad6Qem5VXWZ0rdMBB4mSSxZug
	 R4xle/EKtGNsg==
Date: Sun, 20 Jul 2025 09:32:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
To: Kaustabh Chakraborty <kauschluss@disroot.org>
In-Reply-To: <20250720-panel-samsung-s6e8aa5x01-v4-1-7d9258fa3f4a@disroot.org>
References: <20250720-panel-samsung-s6e8aa5x01-v4-0-7d9258fa3f4a@disroot.org>
 <20250720-panel-samsung-s6e8aa5x01-v4-1-7d9258fa3f4a@disroot.org>
Message-Id: <175302193978.2019800.11858097552460826975.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: document Samsung
 AMS561RA01 panel with S6E8AA5X01 controller


On Sun, 20 Jul 2025 17:33:07 +0530, Kaustabh Chakraborty wrote:
> Samsung AMS561RA01 is an AMOLED panel, using the Samsung S6E8AA5X01 MIPI
> DSI panel controller. Document the compatible and devicetree properties
> of this hardware. It has a reset GPIO and two voltage regulators.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['samsung,s6e8aa5x01']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250720-panel-samsung-s6e8aa5x01-v4-1-7d9258fa3f4a@disroot.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


