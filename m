Return-Path: <linux-kernel+bounces-778993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2DB2ED92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C10178DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774128D83D;
	Thu, 21 Aug 2025 05:26:06 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC4194124;
	Thu, 21 Aug 2025 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753965; cv=none; b=ZIeJi3Int37WGPyHKi/np3jdxw1z7r++4UW04uwuLMNhDSE7vtwwvdEiLZ1nMNA+EQngm7Ydj+1siZc96udrOTp5ydOPqjQ6zoCJMCVIOg6G15UM7bxyGPrRywQimDaBi9TBvbaUbMlqS+dG3j0UNdthNDe0tCTn72pebtwWrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753965; c=relaxed/simple;
	bh=BBjuocd36IL331BfJAqrwiQ+NxPhOc6aFX0QzeGDpWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EChcRKZEQUe9npZxLLXu3OpiBwCREXXeOq/BPx0VEKp9Ncc2zb/zIFMG9WhwIrScmNiEj5BU0idTJ9Ya1dkU6cZMuMEf500JNY2gz2g/ZsK+GfAu0AC7BGIqxR+hfGE90rB3TGOU2FSYPi+sRYXQFlkstqlEUmEM05ES+13INhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 Aug
 2025 13:25:55 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 21 Aug 2025 13:25:55 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<howard_chiu@aspeedtech.com>, <arnd@arndb.de>, <andrew+netdev@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<jacky_chou@aspeedtech.com>
Subject: [net] ARM: dts: aspeed: ast2600-evb: Correct phy-mode to rgmii-id
Date: Thu, 21 Aug 2025 13:25:55 +0800
Message-ID: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to the latest ethernet-controller.yaml.
Since there is no RGMII delay on AST2600 EVB, the phy-mode property of all
MACs change to "rgmii-id" mode.

Fixes: 4d338ee40ba8 ("ARM: dts: aspeed: ast2600-evb: Enable RX delay for MAC0/MAC1")
Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..c4964e536ed7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -123,7 +123,7 @@ ethphy3: ethernet-phy@0 {
 &mac0 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
@@ -134,7 +134,7 @@ &mac0 {
 &mac1 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
@@ -144,7 +144,7 @@ &mac1 {
 &mac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 
 	pinctrl-names = "default";
@@ -154,7 +154,7 @@ &mac2 {
 &mac3 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 
 	pinctrl-names = "default";
-- 
2.34.1


