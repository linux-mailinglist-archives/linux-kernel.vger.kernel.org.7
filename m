Return-Path: <linux-kernel+bounces-806080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F6B49192
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53B118937EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A5311950;
	Mon,  8 Sep 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VgJDWexs"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF31311949;
	Mon,  8 Sep 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341859; cv=none; b=WtKzvWVWLz9SUepfPT3lQs7gPHYro+z8BSzQMHdo2vRMPiqXFIXwAgbAwZDijnkqx9fvjppx959kG0CAggkD6UwKg5r22AzU1q48o8gcKnil38rGuF6raXmHpro0w6gKEogZy7IVdNdg0dM3qrnvvJ6P+edDS7SIKIFsW7T/g/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341859; c=relaxed/simple;
	bh=oY80pW/was+AuqcFIjz6WHSDDqv4vJpDRwAIiKqsj5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjMHJceBjvMLVqSHblsXeQlBL6HR/NP5kMsrNq9obp3rCjW4BnjR+HGuZ2tYfOtKOzJgp8L5mfjVOuC1A7LJ4xO/YGm2t4WzO6YMswJJ/qiQkew6q7XoLEx0d/QdssKVyQ6wpeQW658CK3RdD1Sts+GJtUQHEIp/G+tSSjCpwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VgJDWexs; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EUrSv3883569;
	Mon, 8 Sep 2025 09:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341853;
	bh=6yfW6NnAc+YqJbw3pkggnHrxvyuQfI1HfG4W55w/utU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VgJDWexs5TCSi2xCi78BGSbNc16DPKsxFy+95pNuqhN1EBVi/LExntNW5DUhv8Ga1
	 pQLi+nIZRtNCca2154n85EdY6HcpJ8zjA2c/P6RY5MtmGpVmv2fGneFVMJ3sVTNOBZ
	 PJTNZRRL/ON7r3BaR6n9yxfk0Sro7/NXgOHtLZYg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EUrOR3065013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:52 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESed11037553;
	Mon, 8 Sep 2025 09:30:48 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v4 23/34] arm64: dts: ti: k3-j721e-beagleboneai64: Switch MAIN R5F clusters to Split-mode
Date: Mon, 8 Sep 2025 19:58:15 +0530
Message-ID: <20250908142826.1828676-24-b-padhi@ti.com>
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

Switch the MAIN domain R5F clusters into split mode to maximize the
number of R5F processors. The TI IPC firmware for the split processors
is already available public. This config aligns with other J721E boards
and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Robert Nelson <robertcnelson@gmail.com>
Requesting for review/test of this patch.

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-23-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-23-b-padhi@ti.com/

v2: Changelog:
1. Split patch from [PATCH 06/33] to [PATCH v2 13/33] and [PATCH v2 22/33].
This patch switches the Main domain R5Fs into split mode.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-7-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 92f5e4a14a49..3a7813c8770f 100644
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


