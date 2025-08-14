Return-Path: <linux-kernel+bounces-769697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450BB271EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBA4E0F99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6C29D29D;
	Thu, 14 Aug 2025 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GDVKK2CR"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10C29D28A;
	Thu, 14 Aug 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211298; cv=none; b=NhH3moCSymHXiUlFv8+HyxZckLHG2tMs6oGcdgDNqXOjTqzClOreIkmASFcb+rZj/NIPfpTS8N+n6g8B6JyQaPwefV9BWSKwRiLm7UJ/VkhL1YbVwLE621EBESFpCIHcEpJZR849htS+hO+R6vM9fY9pZ3Ja0+v60jdn2R9JK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211298; c=relaxed/simple;
	bh=ejaQnOKwUAQlC92tOLLuqLlkWaPM9KYXEKFnnYZ+dYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2iJrn4Lc1AUNXmDvNjlyIBIjQC/wMoHLIjYRU6tAOFWd1gF+7yPegs5EhbRyXPxctDvOv3sA1g6vtx6w0EOs3uwI34BFW2Nvto6Gtb9hXqpPY3rCJxUMGR2zZLi0HW7ySj0H9rl5EfkuPn4xGvixjtC5svngE341/4nX8Iwm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GDVKK2CR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMfVgn1973684;
	Thu, 14 Aug 2025 17:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211291;
	bh=wLHxUFjfLmqm/i4YDPATjTVBn9dA+0sj+cclW38Fa4I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GDVKK2CRinJzwXhGWC6S+/FVen7oC3LTXhY7sJN3357b6G0vXvlASWUK4Ea4moUu/
	 p37MMCmr9OJjlMh48cE2IPHV3QOL4iwlTKTqDzJqFprqKPjh0vPRXS7X7eD6Ft4KY3
	 SgAgD3h6r2cOTFbH/+ErTfdIx7ssqxsYj31LejWs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMfVaN2150859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:41:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:41:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:41:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw58096792;
	Thu, 14 Aug 2025 17:41:27 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 33/33] arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU R5F cluster to Split-mode
Date: Fri, 15 Aug 2025 04:08:39 +0530
Message-ID: <20250814223839.3256046-34-b-padhi@ti.com>
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

Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
R5F cluster in the MCU domain which is configured for LockStep mode at
the moment. The necessary support to use MCU R5F cluster in split mode
was added in the bootloader. And the TI IPC firmware for the split
processors is already available public.

Therefore, Switch this R5F cluster to Split mode by default in all the
boards using TI IPC Firmware config (k3-j7*-ti-ipc-firmware). This
gives out an extra general purpose R5F core free to run any applications
as required. Lockstep mode remains default in the SoC level dtsi, so
downstream board dts which do not use TI IPC Firmware config should not
be impacted by this switch.

Users who prefer to use the fault-tolerant lockstep mode with TI IPC
firmware config, can do that by setting `ti,cluster-mode` property to 1.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi             | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi             | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi            | 1 +
 .../boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
index 8eff7bd2e771..ddf3cd899d0e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
@@ -94,6 +94,7 @@ &main_timer2 {
 
 &mcu_r5fss0 {
 	status = "okay";
+	ti,cluster-mode = <0>;
 };
 
 &mcu_r5fss0_core0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
index 5b3fa95aed76..57890a3b38a2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
@@ -211,6 +211,7 @@ &main_timer15 {
 };
 
 &mcu_r5fss0 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
index 40c9f2b64e7e..7ee8a8615246 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
@@ -179,6 +179,7 @@ &main_timer5 {
 };
 
 &mcu_r5fss0 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
index b5a4496a05bf..e12fa55a4df0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
@@ -254,6 +254,7 @@ &main_timer9 {
 };
 
 &mcu_r5fss0 {
+	ti,cluster-mode = <0>;
 	status = "okay";
 };
 
-- 
2.34.1


