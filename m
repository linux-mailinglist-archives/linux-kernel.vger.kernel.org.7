Return-Path: <linux-kernel+bounces-846634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ABBC89BD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F8619E8247
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365F2DFA46;
	Thu,  9 Oct 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAsm0dUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50642DE200;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007261; cv=none; b=KuAVrQsZzZaudqN2SEW8wfY8VSusCjqejDLX0rDvCdc6YlY1T+pjW34ZW2asiQCfWNFDNwDQNBtrHVjdZ5RmzPWGOLXP6Vl9m2E8wJRtayljWdYGET0u4wT6HqWPC/qZYlxCi3VUZ5NBYG0PSWrjTs+x460k3R6hL+6oEJTkCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007261; c=relaxed/simple;
	bh=AH1YWT1PmOpsxR4ljF1m4JmyHPJPRdfWYF5LAjqppjw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EKkPnNNTCxW5OiJKnme71yWfv6SkWX/Zm2u7eEXrK6ZuVniK+M7O6vNexkpUhu+zXtFIt4D4t3kWtydVvXDPEyrZdO1l165X0KxyCZq+heyfinBirNqjUiWg+NO6bvb0dZJFRsJi05xiQD6h0YJfx3wVfo3mVj+tILQuDhfs5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAsm0dUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 814D8C4CEE7;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760007260;
	bh=AH1YWT1PmOpsxR4ljF1m4JmyHPJPRdfWYF5LAjqppjw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VAsm0dUSNHW40Z/IpV8gBFAUZiPhVDvQdry5/iL2Oqcij++VpcnbL8hMjX2Hoh54r
	 T/oNTHWzERv3bHNiUNtie7g2JHBHv+HjJ7BHjUB213QvJ4ZIW+4JMQj0LnDvYwQxyf
	 QDzeYvRUwE1QF5drm+g8MC0LZe0ezKQeLDNtUXRG6w5jEUPOpAs35RMMUZgZrQonip
	 NvXKng0CyvgbUH4OeresLk71/wPEXQ+pqETrpVuDbSgcP/Z9ZulPM9Tk5goMt3pEvM
	 iR7VqO8Vfi1BZ2COOzRWFdUZgKsYCVyPYYexz2p8h6VdMzPhcUAaIwNvBthl4k4NrI
	 Un7GJuUX+coEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76FCCD183;
	Thu,  9 Oct 2025 10:54:20 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH 0/5] arm64: dts: freescale: add support for the GOcontroll
 Moduline IV/Mini
Date: Thu, 09 Oct 2025 12:54:16 +0200
Message-Id: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFiU52gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNL3dzMvMz4zDLdRAPTVNNko2RDIyNjJaDqgqLUtMwKsEnRsbW1AA1
 gqCRZAAAA
X-Change-ID: 20251009-mini_iv-a05e5c2c1223
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760007259; l=1210;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=AH1YWT1PmOpsxR4ljF1m4JmyHPJPRdfWYF5LAjqppjw=;
 b=cBmGj7Wqbc/xkjDIXBHq1BeswMYmO+gRfkT82CTX4YzTxUswkiR/3SzGkj0EaLLjOEdiluSQS
 oIPsQDCYFNfAcq4xre8PD+0SBdcfQDubafa3oXaTWbr6FRGhUXT026R
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Add initial support for the Moduline IV and Moduline Mini embedded
controllers.

These systems are powered by the Ka-Ro Electronics tx8m-1610 COM, which
features an imx8mm SoC.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Maud Spierings (5):
      dt-bindings: arm: fsl: Add GOcontroll Moduline IV/Mini
      arm64: dts: imx8mm: Add pinctrl config definitions
      arm64: dts: freescale: add Ka-Ro Electronics tx8m-1610 COM
      arm64: dts: freescale: Add the GOcontroll Moduline IV
      arm64: dts: freescale: Add the GOcontroll Moduline Mini

 Documentation/devicetree/bindings/arm/fsl.yaml     |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h     |  33 +
 .../imx8mm-tx8m-1610-moduline-iv-306-d.dts         | 801 +++++++++++++++++++++
 .../imx8mm-tx8m-1610-moduline-mini-111.dts         | 691 ++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 562 +++++++++++++++
 6 files changed, 2092 insertions(+)
---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20251009-mini_iv-a05e5c2c1223

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



