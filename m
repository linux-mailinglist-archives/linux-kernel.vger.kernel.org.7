Return-Path: <linux-kernel+bounces-769667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DAB271C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CDF1CC818F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2112857F8;
	Thu, 14 Aug 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E+mm8Xo9"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296328506F;
	Thu, 14 Aug 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211179; cv=none; b=HTJJekOfsE37GfeA0zgUCeBTrnzBtO+iY6yyeHaGSRAqxmxAAIClRX0jMBQJh0I6W/BVoLt25DrJ+qxqfHXcPJngGDGoa5kUSPUT+GeMIgq6pblCr4Y3hSlHyf4/UZlt3doGpOxz+LUUi71d9uFSS/Jk5We3+ccvuBJ4iPBMru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211179; c=relaxed/simple;
	bh=Nd6J7m5IQHJO6csTlooRlakAJaoziLbttgs6Q8rkixo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi7Sp4EiDd0kZfpo63h8SNMfM/chKH7K43fvjtn84pNuFZwjFJMuQY43ekmg37Y35c8NfpNOWmJJSyHI/UVVhQLIRqMIqo5IrTsiksg5W/2Y6PPMdcKFLTxL8h8uQKhRys8XflFGhYrV6J2FD1n+dKTetoG20H1oufoUHuNnoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E+mm8Xo9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMdWdZ2027448;
	Thu, 14 Aug 2025 17:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211172;
	bh=z86arGkd6r6jlVLwjUvCRxxzBxvKNamCGHK9f/qQVic=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E+mm8Xo9SXGE47MIgXusZq/zmKaHK9e0JyI9Y2D8CDebYJaojFh8paa4AMRRjKCQy
	 7DzEdCbioUcx02FrW7WNMKAulZ2UardaW0UdfELZkgRpiAdzMWW2BiFRCpNJPDiiZN
	 N9rA2x2dLw5BYkFqKZUlmeNrreKj7B81Z1KREDFE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMdWsM1461672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:32 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:32 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4f096792;
	Thu, 14 Aug 2025 17:39:28 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 06/33] arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
Date: Fri, 15 Aug 2025 04:08:12 +0530
Message-ID: <20250814223839.3256046-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814223839.3256046-1-b-padhi@ti.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The TI IPC Firmwares running on J721E SoCs use certain MAIN domain
timers as tick. Reserve those at board level DT to avoid remote
processor crashes.

While at it, switch the MAIN domain R5F cluster into split mode to
maximize the number of R5F processors. The TI IPC firmware for the split
processors is already available public. This config aligns with other
J721E boards and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Robert Nelson <robertcnelson@gmail.com>
Requesting for review/test of this patch.

 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index fdfd46b5b30a..c7ac2b66ee0d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -937,6 +937,35 @@ mbox_c71_0: mbox-c71-0 {
 	};
 };
 
+/* Timers are used by Remoteproc firmware */
+&main_timer0 {
+	status = "reserved";
+};
+
+&main_timer1 {
+	status = "reserved";
+};
+
+&main_timer2 {
+	status = "reserved";
+};
+
+&main_timer12 {
+	status = "reserved";
+};
+
+&main_timer13 {
+	status = "reserved";
+};
+
+&main_timer14 {
+	status = "reserved";
+};
+
+&main_timer15 {
+	status = "reserved";
+};
+
 &mcu_r5fss0 {
 	status = "okay";
 };
@@ -956,6 +985,7 @@ &mcu_r5fss0_core1 {
 };
 
 &main_r5fss0 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
@@ -974,6 +1004,7 @@ &main_r5fss0_core1 {
 };
 
 &main_r5fss1 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
-- 
2.34.1


