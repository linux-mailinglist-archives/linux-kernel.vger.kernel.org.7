Return-Path: <linux-kernel+bounces-779396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E8B2F3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C12A682366
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721F2ED14B;
	Thu, 21 Aug 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fNjIcH9H"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C982773D9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767734; cv=none; b=LiHv8nXll2QdZRnrRcJxeHkJIamL3B6s9qZVyncsYWJEN87zX4cHvYPweeFSbAC0rMlMMlkiGu8T9jrJ6MgZFLS40eBIzSIy1YMHpBcrmwhCxP6UTEXl3Hd9Kt0YGin6vFsnGqn1+MGz7reeFMoLTOS/WHJxUWFVX7w+2YMPA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767734; c=relaxed/simple;
	bh=x5mVyWO1uo1YFHT56G2gjS6ir4GZWf1jc0j/Z4S6Qsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JjD4S0cxBB0uTvBEyTFkDm0TZE+gJWtbEua6wcH3YhTlBbCWbby+nbwCWT5DXVblXmaJab0K9P+a3lmnQDQtVanI90QvR8NhPcP1objJgBYHfUipk113Bp9wG9aoXRQIAm2P3jBIWmQqlt0RNrcOdcGPOrYLCfqNakxrsgjmLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fNjIcH9H; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L90E15004160;
	Thu, 21 Aug 2025 11:15:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=eXSSb7hau3lLxL822Dash4
	tjRXgn93V51VZQeX8MsTE=; b=fNjIcH9Hmk72pMu7f1tlbcksLZaFHNHkh1SdVV
	tgj4ljvki2fdQmUMBdqCvX3iqCQjIYheSH4uBwU4i4BEw067gmtu3Wn9IRA8Q6L2
	3pu+EmCDbQMfeKuGGrvKjzF4oFd2PJFaJYITJu5O73s50I5o+idJ32ABbM2AMrF+
	EFrI2fM555PSmkFHnnsuE/GG+7KI1Iuf/JpTBFbxtns7OnWc79aM4qy0g/+amELF
	xgYPLauk9wH4LUzhbMhcYE4Rmu+b8MjeaqGojKA2+ox3K2/wsLWtqRxXm1avOpYX
	Mx3EwvEO2jrpwUVr1vIWoyDMJ+aKIQ4+Az4RQPI7wvGrGpnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n81wnvsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:15:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3B9BF40048;
	Thu, 21 Aug 2025 11:14:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF2DA73D3F4;
	Thu, 21 Aug 2025 11:14:04 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 11:14:04 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 21 Aug 2025 11:14:02 +0200
Subject: [PATCH] arm64: defconfig: Enable STMicroelectronics STM32 DMA3
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250821-upstream_defconfig_enable_stm32_dma3-v1-1-d9c1b71883d9@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAFnjpmgC/x3NWwrCMBBG4a2UeTaQCxZ1KyIhJn/qgElLphWhd
 O8GH7+Xc3YSNIbQbdip4cPCc+0wp4HiK9QJilM3WW3P+mK12hZZG0LxCTnONfPkUcPzDS9rcda
 nEpyKJl5dNmbEaKmnlobM3//m/jiOHy2UqVh2AAAA
X-Change-ID: 20250820-upstream_defconfig_enable_stm32_dma3-c1c93f116e62
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01

Enable STMicroelectronics STM32 DMA3 support as module.
STM32 DMA3 is used among others by STM32 Octo SPI driver on
STM32MP257F-EV1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 667c4859ecc3cda9b0a3dae7abdd8587fc4f8dbe..d0a9d2a5b140aabe40927981ee710b0eb3b729cf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1302,6 +1302,7 @@ CONFIG_RENESAS_USB_DMAC=m
 CONFIG_RZ_DMAC=y
 CONFIG_TI_K3_UDMA=y
 CONFIG_TI_K3_UDMA_GLUE_LAYER=y
+CONFIG_STM32_DMA3=m
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y

---
base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
change-id: 20250820-upstream_defconfig_enable_stm32_dma3-c1c93f116e62

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


