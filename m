Return-Path: <linux-kernel+bounces-741818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C668AB0E94E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30B93ADEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26024248F65;
	Wed, 23 Jul 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="ZTkwXmB2"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C02192EE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242382; cv=none; b=hIkBFL9Osvxsr4EpXgqC13CNl59yTozHkQ/CkG+D35efCgq+ETyMydS2NaVvcNc9AIGtGgfFTQdDikgKj85JtF06Cgp1oOTD9l/SOMtWdNWNe3x9TXHYMfevPKQA8cMgrX2ESqqbtUrwokPuLyVnlWJOJv7vdBvP+ZyZ7e1Pm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242382; c=relaxed/simple;
	bh=kxfAZ5oczkD+4j0eiUZUm5xzqJgl81dDPb70fllc69g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgLTkm7iYKNFU3JFXWhCpjI0K0jER2gT2uMMLFhuO+T6mg0UNtSQ8RSZhaF6sirVuXs4TdYhqbUvjwnCWHoeZQyUpGnLv3qm+zyRjR/GEZV/np7A2LW8VhRnIhDzaXwHcR1/iehzmu33y2APxF9CnSNJO9f2CTW1x2+RMLNtSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=ZTkwXmB2; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025072303461831a151a8915250e966
        for <linux-kernel@vger.kernel.org>;
        Wed, 23 Jul 2025 05:46:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QtN0VLE566TlGeRyALZ6z/tV9w0Xq9AqMnDzZ2gCzX0=;
 b=ZTkwXmB2iQBKPVsq3R7cQGpm83jWq/vqSIXkEMNuW6S/OlXtiDlEpR9CY8K3GiPCFikW5M
 LsbdPAsVYIcB4Pp5mx9W7lweMlnOLq9gRk+95l+UCcNcd4Nlwu/K6XLwB2xbco0JCB40Yc3r
 Fi4WZ80jO8iMPwuOCpfvCCggwWu25pApG09T1XSXSM3EyjC+e5uyIJ11owjb/3ukYanChe9p
 ICcjkUBOUHH/OErKmdn1OLJroNmvJMd1SHo9wOADMfpIdd/1r5HrrOqaerVXaTORrNEUSAZ+
 hOkKT5K5++/CIspsNjjSauu/Kz070uByi6jOXDL325NE3HNU0IsOPwOw==;
From: huaqian.li@siemens.com
To: christophe.jaillet@wanadoo.fr
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v11 6/7] arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
Date: Wed, 23 Jul 2025 11:45:20 +0800
Message-Id: <20250723034521.138695-7-huaqian.li@siemens.com>
In-Reply-To: <20250723034521.138695-1-huaqian.li@siemens.com>
References: <20250723034521.138695-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Rewrap the long lines at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index be65e6aa7b80..d0036b0aa818 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -897,8 +897,13 @@ main_gpio1: gpio@601000 {
 
 	pcie0_rc: pcie@5500000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5500000 0x0 0x1000>,
+		      <0x0 0x5501000 0x0 0x1000>,
+		      <0x0 0x10000000 0x0 0x2000>,
+		      <0x0 0x5506000 0x0 0x1000>,
+		      <0x0 0x2900000 0x0 0x1000>,
+		      <0x0 0x2908000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -918,8 +923,13 @@ pcie0_rc: pcie@5500000 {
 
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5600000 0x0 0x1000>,
+		      <0x0 0x5601000 0x0 0x1000>,
+		      <0x0 0x18000000 0x0 0x2000>,
+		      <0x0 0x5606000 0x0 0x1000>,
+		      <0x0 0x2910000 0x0 0x1000>,
+		      <0x0 0x2918000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.34.1


