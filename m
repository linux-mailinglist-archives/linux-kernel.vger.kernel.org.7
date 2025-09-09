Return-Path: <linux-kernel+bounces-807152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE0B4A0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5401B27B30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75F2FD1D8;
	Tue,  9 Sep 2025 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uYeuTOav"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A42F90C9;
	Tue,  9 Sep 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392910; cv=none; b=p6B9iJPv+Gb5zlJukzBr5RSBWnByyBAxc1cqpgV2eUo6zvN2zJiONlUQkDu3iq3zMfV0wA+BpnFftfeEPxXotJCc00+wTgb+gnsOtpVKQ7bu2K1QI/WymDrBs2HvMQSqY4ENFkUUiWL2mY3gouiJCUCO5KeHeVt4XfngAvpBQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392910; c=relaxed/simple;
	bh=wd4PDV85M9oq0bnTJKB8HYSIFenTg9qPut3BZcgZiTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrCr7Ov3lu+m5H1G17aUNd5W1T1JzEgIziplm9PaLB/4Dny9bF43UTEbh30rrE1zNcTvzZaxy5YeVSVDjEnFnBJqqC+Icmn10InAFcJ+sQXtZjecSPFxf9tbsgPyGxaGeOYOAMgylhZC5DVz3oXPFcd8xeUenSK+nh/LndDtA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uYeuTOav; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5894fiSV256664;
	Mon, 8 Sep 2025 23:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757392904;
	bh=miK6UxLdZfTtLSDYf8EyocEMRLQp5DEigZYlJKLzNHg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uYeuTOav/56A37mhUr/3ZUdxgL1xfQ5pQw9crD4t2lJ2uhQTzZw6cN41WKKKRwVPi
	 Dam7cKwYQEL32twh4PKUiCotjJk8Q3VAx04dCItBstkraDE2aaC8IzjfFYJYArnbqe
	 YBrSbizu5gzhjQIaK7pw0J8fgKGcwiPDGFgMcbqk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5894fisP3511819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 23:41:44 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 23:41:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 23:41:43 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5894fAkG2012008;
	Mon, 8 Sep 2025 23:41:39 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <k-willis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <a-kaur@ti.com>
Subject: [PATCH v6 4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros
Date: Tue, 9 Sep 2025 10:11:08 +0530
Message-ID: <20250909044108.2541534-5-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909044108.2541534-1-a-kaur@ti.com>
References: <20250909044108.2541534-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Currently, DS_IO_OVERRIDE_EN_SHIFT macro is not defined anywhere but
used for defining other macro.
Replace this undefined macro with valid macro. Rename the existing macro
to reflect the actual behavior.

Fixes: 325aa0f6b36e ("arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros")

Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 8ce37ace94c9..e46f7bf52701 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -88,8 +88,8 @@
 
 #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
 #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
-#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
-#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_ISO_OVERRIDE_DISABLE     (0 << ISO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_ISO_OVERRIDE_ENABLE      (1 << ISO_OVERRIDE_EN_SHIFT)
 #define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
 #define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
 #define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
-- 
2.34.1


