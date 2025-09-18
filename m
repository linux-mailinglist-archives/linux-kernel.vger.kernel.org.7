Return-Path: <linux-kernel+bounces-823187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C67B85C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D821C247D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B313D4E;
	Thu, 18 Sep 2025 15:45:07 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AB313276;
	Thu, 18 Sep 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210307; cv=none; b=bv341gJGLSzU1L/K8v/+qVhBmQCVFRMXS8LX0w5YWnj2NuCUUx8YiDz3CPQiN4T/pqUob7m3ofI2l6Vp6LHZnMfoxhIs5nikzWbQXfouzDiDm7mL0ci0aSJkHDRFkmUoxjrva/wXjxGqwXnQ59hwf7upxC9z7nQRZdSoGcNOn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210307; c=relaxed/simple;
	bh=ZZbwCNlCDRbxxzUuukJLcLpJLbc7KSTrPFgOFAVCEJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KB+UU1lARCeTVvqdzgjW1f/5PbPoBruCUwWD+TOcMp8XF14WgNNs+nz1Lo5ova+nWYbwwf9v6daJ9NfIh/VPIc3OPEmixYfIWKchRwpLVPmO/P9M732os6JxUof9Z0Z/BWOm0vJfmsQ+o+lhEkAUt9R9iAK8zht9MMo1RCxHqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uzGoY-00B1eF-67;
	Thu, 18 Sep 2025 15:44:54 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 1/7] arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate usdhc1 props
Date: Thu, 18 Sep 2025 08:44:45 -0700
Message-Id: <20250918154451.2531802-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918154451.2531802-1-tharvey@gateworks.com>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the un-intended duplicate properties from usdhc1.

Fixes: 0d5b288c2110e ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
v2:
 - add tags
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index cbf0c9a740fa..303995a8adce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -423,9 +423,6 @@ &usdhc1 {
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
 };
 
 /* eMMC */
-- 
2.25.1


