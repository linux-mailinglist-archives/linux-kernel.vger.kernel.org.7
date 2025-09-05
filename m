Return-Path: <linux-kernel+bounces-802063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB55B44D48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD0E7BB4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FC29AAE3;
	Fri,  5 Sep 2025 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W32AFFFA"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3022727F9;
	Fri,  5 Sep 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049592; cv=none; b=fl2b1404B0pE/S21QUdUxNLqKWHHT8PCK4dan71ErIcIIOZHdUmvGkOAN/bXqJVYyGCBP+lmWwOQwz58oLarB6TZSvEvW1xxXkq9AehnAwb/wvSvzngx197xOgo5wL6QzE5RphDU2o2tToETPQB4pjjNVtG3bkFb40lTAv9IZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049592; c=relaxed/simple;
	bh=IsGIzHD5PWL7VsmiKj8dji39HTY+pVin73eaWqWqgL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNDkF2y+0g/gWGo2oNGS1q/S0TuMhrFjvakBwhJMF3vOd2hGOgjgXcP839FEPulbNhBG1SPdh7rW0E52ghpB2MRrxPnfdXz4Y3FbAH30NoUWBsZ7rc6ZWu452Kud41iyB79BsWaxl4ZvvlqJzEhMiti7wEov2efXJSF+/+TF9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W32AFFFA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855JkfG3678902;
	Fri, 5 Sep 2025 00:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049586;
	bh=i5PPJwen9T/ohLDnoaqZRyHxcc+0PM7Tk8XcjREbXZk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=W32AFFFAikeBZaLHAE1xdKyqp5C5t66PU0/Qom6g2mrU98k8VuvYaOSB3HtwUt7DB
	 zxm2GUxhSJqBjvsQ8zEFAEx/C1GprvUMkziwLtkJLqUBnAOKl7tW4BSAaO7foqyPKA
	 kkbr6HFlFOcKXJOQaagQzcO8XGgW6+AQqyyLYW4o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855Jket136257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:19:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:19:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:19:45 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioie220581;
	Fri, 5 Sep 2025 00:19:41 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 11/33] arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
Date: Fri, 5 Sep 2025 10:48:24 +0530
Message-ID: <20250905051846.1189612-12-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905051846.1189612-1-b-padhi@ti.com>
References: <20250905051846.1189612-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Mailbox nodes defined in the top-level AM62A SoC dtsi files are
incomplete and may not be functional unless they are extended with a
chosen interrupt and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones
that are actually used on a given board.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Tested-by: Judith Mendez <jm@ti.com>
---
v3: Changelog:
1. Carried A/B, T/B tag.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-12-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 23/33] to [PATCH v2 11/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-24-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 9cad79d7bbc1..d5f018768981 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -804,6 +804,7 @@ mailbox0_cluster0: mailbox@29000000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster1: mailbox@29010000 {
@@ -813,6 +814,7 @@ mailbox0_cluster1: mailbox@29010000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster2: mailbox@29020000 {
@@ -822,6 +824,7 @@ mailbox0_cluster2: mailbox@29020000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster3: mailbox@29030000 {
@@ -831,6 +834,7 @@ mailbox0_cluster3: mailbox@29030000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	main_mcan0: can@20701000 {
-- 
2.34.1


