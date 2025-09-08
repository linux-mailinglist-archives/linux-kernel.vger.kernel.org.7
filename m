Return-Path: <linux-kernel+bounces-806067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50835B4917B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB57B3F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CB30DD13;
	Mon,  8 Sep 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qI+0s4RM"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46A30FC1D;
	Mon,  8 Sep 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341790; cv=none; b=FytoYG55sCjBOVuhmdBvq3s2iYGFiJrd2ZmSnu0T4s8k8+aqtQbNGyP9evUNfE+uKg6vLCVp3GzXOOn34yiF+UGDcPEpNh12/rd0AachIXCuHe7HU/cPJ1UnSLMInd/3vOCL8jntTcsRVJqUsM3bKeyi594PYDsmTJu5gWHunv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341790; c=relaxed/simple;
	bh=kvwEM2WnUN70/qjKoxvi0X6jZBAuqe5bkb4/l8GQGa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbvdn8pw7zosDyqAruFfv1pZblUl3CfL4cAbFsk6VVr6qb5nolkf3vPgooLnfFKnxaQL5R7qlfP40hj/X9GnKUQ2NCTscVt36byoQcEHBbrCW9oKzZal8ZqLjWGtJ/sF/gQXw71WOeA7TU6QFnQjJWFJYcJipOujjV1+8P1725E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qI+0s4RM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588ETiOk3883291;
	Mon, 8 Sep 2025 09:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341784;
	bh=+s3FaZtrazxBlzwD4Mp9yW6mkQECu5VVR+RLREo5XX8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qI+0s4RMx1ts2oeiMxrvCWy5oE9bvp86FxCBcS+Jd7j3r6gt4wtRbv3FqbtKdRJhE
	 P23+Uz2bcFn6cC//0jywSEmMSMfM41dRFpoXLukBWPcq6/3gr5ggUUz3A7s1B5ru0C
	 zhq9Y+w6tTYdDSKR2ARiOdfarakoi5DCaCCqvLQU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588ETieC3063709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:29:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:29:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:29:43 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecn1037553;
	Mon, 8 Sep 2025 09:29:39 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 11/34] arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
Date: Mon, 8 Sep 2025 19:58:03 +0530
Message-ID: <20250908142826.1828676-12-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908142826.1828676-1-b-padhi@ti.com>
References: <20250908142826.1828676-1-b-padhi@ti.com>
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
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-12-b-padhi@ti.com/

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


