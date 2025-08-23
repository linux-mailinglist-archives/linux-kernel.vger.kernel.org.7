Return-Path: <linux-kernel+bounces-783208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5D2B32AAC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D631C262D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7A2ECE8C;
	Sat, 23 Aug 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ouDYoAEI"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2411F099C;
	Sat, 23 Aug 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965469; cv=none; b=AKZkifjoGtRiV6hGvQMxNujVUaL6TXXDZQ1n85OlAATvNx/BdNrMhCCktR9jbwczx9s5Ci07TRgGzOq93Oigt6il2zvk2o+AeUOatQN2W7KFOP554EcNwnfdKBKfhl5Av+2FDcP9k1h5p0WNCL0maIy8NFIINNchx7NePVZpQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965469; c=relaxed/simple;
	bh=9iAAV6s9aJLJWbh9KLHCJ3u0ezfF/43FabRpSb5xJPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItQavBFYFOyVaywU8euMQvxrdHsMIZ2Hv7xsT7ujdgkQQvevEDtE0L+T9eNErxf8jVWxgqdodcxNab//5JOHG9j3qjZ8zg7r2mLtgNPRDTQAcPUqnsfIHvmMrO+36hsE633xsuHZwyOYrDpZZpTKxbUZJou7RjjP6QSSsmcYQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ouDYoAEI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGB3IR936217;
	Sat, 23 Aug 2025 11:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965463;
	bh=dTfpMBikvWO/NNRw+xwSX3icYaDH9zr3mFCLMDINJaw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ouDYoAEIaWffHbw/QGIqV+NCle68d+fyG7UfCBAWlAtPJHCKTdDQcFZAj9DifguJ1
	 DlQUAokceHLHE0G1olC9IGBciIslNlG5l2rlY5AXOSQ0CQsH4FehR925hdhIgD5O7W
	 JalDIVjORtpSdH9q5uSDrrkcJy5IHwHljQYTOVOw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGB30R3512272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:11:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:11:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:11:02 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9Exc1274978;
	Sat, 23 Aug 2025 11:10:58 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v2 22/33] arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters to Split-mode
Date: Sat, 23 Aug 2025 21:38:50 +0530
Message-ID: <20250823160901.2177841-23-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823160901.2177841-1-b-padhi@ti.com>
References: <20250823160901.2177841-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Switch the MAIN domain R5F clusters into split mode to maximize the
number of R5F processors. The TI IPC firmware for the split processors
is already available public. This config aligns with other J721E boards
and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Robert Nelson <robertcnelson@gmail.com>
Requesting for review/test of this patch.

v2: Changelog:
1. Split patch from [PATCH 06/33] to [PATCH v2 13/33] and [PATCH v2 22/33].
This patch switches the Main domain R5Fs into split mode.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-7-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index f82966072605..c7ac2b66ee0d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -985,6 +985,7 @@ &mcu_r5fss0_core1 {
 };
 
 &main_r5fss0 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
@@ -1003,6 +1004,7 @@ &main_r5fss0_core1 {
 };
 
 &main_r5fss1 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
-- 
2.34.1


