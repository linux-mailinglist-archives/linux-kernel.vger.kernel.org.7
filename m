Return-Path: <linux-kernel+bounces-782900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA242B3269F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FCE1C256D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA09221F1F;
	Sat, 23 Aug 2025 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CnWB0Yl9"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9121CA04;
	Sat, 23 Aug 2025 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755919409; cv=none; b=NojqFc/8HwhsbWbJzYNGJ2YN2XRe0E2xLnp7+lj1ucL0+dHrt6j9SrepCQjKW9ZzclQGCHDTl0/F/lvLGkMaW9eTRVI0uam1KWP/1nPdFTh33mAUHLNmNAcBRBuVfdUFsXNvCkkIvEuJHA/QviMUVZhQ0F+wG0wbtVhK7Ruw2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755919409; c=relaxed/simple;
	bh=l1tHmrhXD9ENZZBzL50VErdJnswgHcvvIltuLs3zTV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYW8rgIO3/ncOLkdFvEW94SQSHIeAkgytKcdmo9nFfowLhLN2qQu2/3+vPNoW7uSA/5gZQrvldsSiwAGUHl9cxARGAvRBvwLwmuyg/jserJyPq48HSFqoC/fHcC6g9IWF1teO8INyjcYDNMGZ5OYJShN4bvjOEr+8rTBsx//KiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CnWB0Yl9; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N3NKCM377389;
	Fri, 22 Aug 2025 22:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755919401;
	bh=CLHMyuU2QMtexLz9vTgau5Hn0lQxz+KMr593iucHqcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CnWB0Yl95S+XZb5CoD4AwKv3E1djo/YOb3R4wmDDJP8xWBPFHPPkVuy1W4Z3ZteD9
	 uDKDtiofuHiGmArhnTq4Ky0AOo3EpEqXFobdxOJNWpaWZcbP8BLoOJtp06+Nx4bO8F
	 v66xmVujbnJfE21ddpCeWnzcUhv3gIoGwoYOReJs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N3NKWl3726665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 22:23:20 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 22:23:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 22:23:20 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N3NJmF575908;
	Fri, 22 Aug 2025 22:23:20 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62a-main: Fix pinctrl properties
Date: Sat, 23 Aug 2025 08:53:03 +0530
Message-ID: <20250823032304.1085775-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823032304.1085775-1-p-bhagat@ti.com>
References: <20250823032304.1085775-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vibhore Vardhan <vibhore@ti.com>

Correct reg length to match end address - start address for main
PADCFG registers. The last physical address for the main pad
configuration registers (MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG150) is
0x000f4258. Adding 4 bytes gives 0x000f425c, so the size in device
tree should be defined as 0x25c instead of 0x2ac.

Reference Docs
TRM (AM62A) - https://www.ti.com/lit/ug/spruj16b/spruj16b.pdf
TRM (AM62D) - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf

Fixes: 5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 9cad79d7bbc1..260279702c01 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -267,7 +267,7 @@ secure_proxy_sa3: mailbox@43600000 {
 
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
-		reg = <0x00 0xf4000 0x00 0x2ac>;
+		reg = <0x00 0xf4000 0x00 0x25c>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.34.1


