Return-Path: <linux-kernel+bounces-780366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B39B300E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4E23B1F72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79333311C3E;
	Thu, 21 Aug 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlLnFvpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF0308F02;
	Thu, 21 Aug 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796786; cv=none; b=hAfJKYu52rce76YhhTCM3gyeamsxuhTbz/L7Sj6n0ScHBRmH+efpwTkC6ZqVZebeQaXXq1vuz7j+gtGe/644q5Wvutsh91PsY6KlE16VzAs2nPdEaS4TMZd9rFs3IPtgzWZ69PeJ3Jq36ulJfwA5JLbTWkkzaobSwLbLdgVsYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796786; c=relaxed/simple;
	bh=IkEM90j9AB9fEVUaubBHggr7J8lF+yeDnZnqMajK8Pc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=O+SA8dYAb3kEv8h4IcuEjI+re+qOymXHwA8vJ6EBzTegG+Oe1Ab5WGcvAvvR4mBJTEy7NY168TBygx6Co68z+bu+lkAPPC9Ys4nofQNTmDJje9hVNYvuyNISvVck3aWj/QvPYDa9+ZKJDfLtzc4TsDh+nWPLe3rS1cLYTuD+o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlLnFvpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE3C4CEF4;
	Thu, 21 Aug 2025 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796786;
	bh=IkEM90j9AB9fEVUaubBHggr7J8lF+yeDnZnqMajK8Pc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XlLnFvpguszjxbVQMQmmvQr18rAXlaCwrmPQn1BBthnaf0Nii2oICZx8GgMZoyu7W
	 R0IPqBkYfHW5JpotaqQ7fLDwbei2ttpwVs0fYw2pVoKfCV+PtUeXTyKEk6W+w1ydcn
	 1MJXg7djUXA7jlGcIlRY0VNEoyP3bdPw+GLzaI7qGgqJKhtYdzU8N6JwFAJoLHKG9B
	 +xq0M2ZhC2DypCTCExctIizJyiol05dA+8wzxrd4ShgWCtYb5InkldWB40j/4gBCws
	 06G+PJcgTbD8TPYrBul2rWtYDNolXOQm8jAott4kr8FYeioXsNJqu3wI0TY6T10IGw
	 3xmysks9SZIGw==
Date: Thu, 21 Aug 2025 12:19:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, Shawn Guo <shawnguo@kernel.org>, 
 imx@lists.linux.dev, David Airlie <airlied@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Fabio Estevam <festevam@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
Message-Id: <175579643516.37357.10852050615304641702.robh@kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: imx8mp-skov: add new 10" variant


On Thu, 21 Aug 2025 09:55:27 +0200, Steffen Trumtrar wrote:
> Add a new board variant for the Skov i.MX8MP based family of boards.
> 
> This variant uses a different 10" panel than the existing ones.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Steffen Trumtrar (5):
>       dt-bindings: vendor-prefixes: Add JuTouch Technology Co, Ltd
>       dt-bindings: display: simple: Add JuTouch JT101TM023 panel
>       drm/panel: simple: add JuTouch JT101TM023
>       dt-bindings: arm: fsl: add compatible for Skov i.MX8MP variant
>       arm64: dts: imx8mp-skov: support new 10" panel board
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml     |  1 +
>  .../bindings/display/panel/panel-simple.yaml       |  2 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  arch/arm64/boot/dts/freescale/Makefile             |  1 +
>  .../imx8mp-skov-revc-jutouch-jt101tm023.dts        | 79 ++++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 35 ++++++++++
>  6 files changed, 120 insertions(+)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-9ef9faa75514
> 
> Best regards,
> --
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de:

arch/arm64/boot/dts/freescale/imx8mp-skov-revc-jutouch-jt101tm023.dtb: touchscreen@2a (eeti,exc81w32): compatible: 'oneOf' conditional failed, one must be fixed:
	['eeti,exc81w32'] is too short
	'eeti,exc3000' was expected
	'eeti,exc80h60' was expected
	'eeti,exc80h84' was expected
	from schema $id: http://devicetree.org/schemas/input/touchscreen/eeti,exc3000.yaml#






