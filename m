Return-Path: <linux-kernel+bounces-820115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60EB7F62E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F87525478
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31B2E7F0E;
	Wed, 17 Sep 2025 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB3yTlpr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7531BCBA;
	Wed, 17 Sep 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093294; cv=none; b=Ly6TdJzWEJhM9ZHnpGzR814uzrq5uwlytJJoW58NWwEjb15EdNZ8KHMTj7iLaQ+NSxEzHHo4DfN95hizNA33TbTQDrclQF1nPxU4ztmkLw8ZDSQUo2Yj78SOJKG5UdWYTVqO5/7t+mKlw/a5K6bdrIk8RZsug5Tp/DiSR4gAxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093294; c=relaxed/simple;
	bh=+SEj6xYX/EWfxD7ME+D5evkEJEd+ldO13clpGMiIubE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OynvgVhSY+s5Ai4+cr6Dh7Q4V9KNxfILzEzef4NfUgcPtQ1MPzBz2udZjrcTxRgvqdca561HmMNv9kWIjT0QfwGIemNGOtp0X5i7at9V51BsrzDW+rODpQyIRLWHrgr8/ZVO9f8OLi3Yla51Ka+zPYXumQSNF/XdxJEzJmEf03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB3yTlpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAEAC4CEF0;
	Wed, 17 Sep 2025 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758093293;
	bh=+SEj6xYX/EWfxD7ME+D5evkEJEd+ldO13clpGMiIubE=;
	h=From:Subject:Date:To:Cc:From;
	b=eB3yTlprGYoL95eR8DwgCRLPTWIb0VclyCs3Z/rrBg2ahxJKL1In23VY5ydz+mfUF
	 yTfE4vnd6kd95goSx08kaz+CNwg2FEE9xTxx9wfelzQDt95rNasUnaOgGr2KZdPTl3
	 NSrKuu5nOiecUMyHyBOJeJ/3VbrsN0PvyQZwNlcB5LJZ9jSt112H8n/10TL94w1c9L
	 2MyP655KenpSWSd6a8NaJAb+s4migGmh6gjkZwAiArwopL3+ud12NnDUr2jYwYBuyG
	 AuBW1NiBCU4jjfW4R78/LN+LauMhduxR+L11JrT/Yp98ZgGB8Ym9z6N+CVanTNDu4a
	 R5etlgOR1Xr6Q==
From: Andreas Kemnade <akemnade@kernel.org>
Subject: [PATCH v3 0/3] regulator: sy7636a: define and init all resources
 needed
Date: Wed, 17 Sep 2025 09:14:28 +0200
Message-Id: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRfymgC/22MQQ6CMBAAv0L2bE1ZoFBP/sN4qGULjQbI1jQSw
 t8tnCTxOJPMLBCIPQW4ZAswRR/8OCQoThnY3gwdCd8mBpRYSS2VCHOtCiU4sBUWpTHqYQzaElI
 xMTn/2W+3e+Leh/fI8z6P+Wb/f2IupCBsGmV0sqa+PokHep1H7mAbRfyN9THGFFvXaleWrsVKH
 +J1Xb9XMLYn5AAAAA==
X-Change-ID: 20250906-sy7636-rsrc-c20aa6baa2c4
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=+SEj6xYX/EWfxD7ME+D5evkEJEd+ldO13clpGMiIubE=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmn4l9a31Y8Odk5cG7r/iix43+v9OTwF/mc742cvCte+
 7DiueBHHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEyETZThv+vUL6V1VouVt3NJ
 bIyQYLGpsvQ7JZgqoyG9yViq8MG+vYwMs0rn3IuWj1rPHXv8OkvghaYTjezzPZLm3bz0zEEus8u
 TAQA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The SY7636A has some pins which can be hardwired or used to have more
more advanced power management available. As several devices containing
this regulator have these pins not hardwired, but instead connected to some
GPIO, enhance the driver to have them defined and initialized.
Also add the ability to power off the chip completely by defining some
input power supply.

Actually implementing better power management is planned to be
implemented as a second step. The regulators in the SY7636A should only
be on for a short time during display refresh, but currently they are
unconditionally forcefully enabled by the hwmon part of this chip.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
Changes in v3:
- shorten descriptions in binding
- Link to v2: https://lore.kernel.org/r/20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org

Changes in v2:
- en[-gpios] -> enable[-gpios] in yaml/dts/driver
- fix en vs vcom_en in error handling
- comment delay
- drop applied commit (rebased to regulator/for-linus)
- Link to v1: https://lore.kernel.org/r/20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org

---
Andreas Kemnade (3):
      dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
      regulator: sy7636a: add gpios and input regulator
      ARM: dts: imx: e70k02: add sy7636

 .../devicetree/bindings/mfd/silergy,sy7636a.yaml   | 11 +++++++++
 arch/arm/boot/dts/nxp/imx/e70k02.dtsi              | 25 +++++++++++++++++++-
 .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts | 24 +++++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts | 24 +++++++++++++++++++
 drivers/regulator/sy7636a-regulator.c              | 27 ++++++++++++++++++++++
 5 files changed, 110 insertions(+), 1 deletion(-)
---
base-commit: c05d0b32eebadc8be6e53196e99c64cf2bed1d99
change-id: 20250906-sy7636-rsrc-c20aa6baa2c4

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>


