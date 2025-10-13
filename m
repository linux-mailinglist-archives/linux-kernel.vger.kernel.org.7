Return-Path: <linux-kernel+bounces-850453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D129BD2DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44BAD4E828C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E512652B6;
	Mon, 13 Oct 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OEU6fTew"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145426056A;
	Mon, 13 Oct 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356373; cv=none; b=gGINHxZzGsW4oLzMV9oVfVLDxSXujeFqN5kmN3rL+ta9LhWMRtOisSsOXO+FwmNS2GexPBSrr8wT1VBqnhRLroAPkmxIY7meVrS7042D9/GN/lBi2KKDL0sNzBTg2Y9fD2wIJ7oj8IbpOQF+k8QZbatBiv9ZJfQx8V9qDZ12WzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356373; c=relaxed/simple;
	bh=6K9CgUrOuseZjzIwdmVR7JuCIt1g4fknM+We2b3Dog8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZCOMO3++QqXEfwHHbye9tBh9v2E4h3aenzIP0LoF1kjrWD6uH+T3ZPUE9f2tBcZcyKb5n8fwYDijwA390F8LHiBothir4wOJpO/VmlWLL4DXiajeK3R6cue5dQZ1NaRj1Ew1qWnFmq80UjfkSq6IkE7PAxgki+cDjdlBmIyjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OEU6fTew; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59DBqi3l813850;
	Mon, 13 Oct 2025 06:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760356364;
	bh=4aLM17aUH7GWbLr4Ba8AhRL9yXc7ouny2cE8vrnnVfQ=;
	h=From:To:CC:Subject:Date;
	b=OEU6fTeweMMaCQu+ND4oUiFvtbHebEQjazHFOhn4sXPotcwRdbltf8u0B6C+daE2G
	 8HfWkWpJ8c4x5Fl2cdRK/7KsczZAACScQBy0AHH1/eJVQAi/dLJU/YZ60bBGMzGPKH
	 LrGB+nbDtkieu9FHwg8y8mSLGfkDTOtuvC4CU/dU=
Received: from DFLE210.ent.ti.com (dfle210.ent.ti.com [10.64.6.68])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59DBqi4e3157528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 06:52:44 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 06:52:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 06:52:44 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59DBqeYe1998445;
	Mon, 13 Oct 2025 06:52:41 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <s-adivi@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm: Add DMA support for tscadc
Date: Mon, 13 Oct 2025 17:22:25 +0530
Message-ID: <20251013115225.3668641-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add dma support for tscadc0

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 85dcff1049360..52bdf7102192c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -608,6 +608,9 @@ &tscadc0 {
 	/* ADC is reserved for R5 usage */
 	status = "reserved";
 
+	dmas = <&main_bcdma 0 0x440f 0>, <&main_bcdma 0 0x4410 0>;
+	dma-names = "fifo0", "fifo1";
+
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
-- 
2.34.1


