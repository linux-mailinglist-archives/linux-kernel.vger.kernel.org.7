Return-Path: <linux-kernel+bounces-798222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F32B41AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BCB7B7ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A212F6587;
	Wed,  3 Sep 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0aB6pQrO"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5862E8B8F;
	Wed,  3 Sep 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893283; cv=none; b=ISoQrK7/+HGZPizEbgPee6wC+k4pQNf3oHFiNiDfmstSDSiHU/8yGenee1c/rMZ0KMOgTra7NwQFzuCscjBjNPLSaIOIg0XZO92h7mRU8OM2lpbm8pK1lCpH6NhxPvEZUohfBGDyGwETKzYDOT2Txu7F62ogab+VpYp8i0SJo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893283; c=relaxed/simple;
	bh=kF6Argx9w5nzPf+4SlGfZyIdGcheV8jZifsKP/T5d8g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m0ElO8n/5gCNUrLDpdsyaOQXcJhnABHKWX6d10qkFio+m4gPtAxST0JHBWYqUW0UApK4iwufF/iZ9dGl82KDCZ1uTEhoFphfz6IdmVxlHrt7yYttLYlIGkj0URN+686pweMg2movclNVpvfBIfrCl9aDjtC6LJV1IDza8OB/Iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0aB6pQrO; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839hvmm022675;
	Wed, 3 Sep 2025 11:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=VtDIXnB6jguTha2nuJ2+4g
	YyBFOqAKGNF3LBQOKc0iI=; b=0aB6pQrODfKgQg6egCwF3PoX/a/6K4garsVZB+
	k7P/j+/z4fdmr4SfAEXy5hV0/exkc6+WdQh/LutqxPlsQD5KWbMihgoY7ycxbMuV
	goVfv2JAtnzw9lYMODuRH+PXn8ceSROTkgVqyVj+jKsrg1YXsTvfMJRGCNE5qKeZ
	dFClyT1QRgJ68AZyTysttTlJE+WpXGoC8k5PniDRkfxYn/8eeEQNBKDYkPXyOx4W
	Yt9B3Uw8fcjOpZdq0PgBHoQFS2Nzh8VVTRlPr8sw54WT04UmO2oWkKjczLbeN0iV
	6xplLEswwJnpAxI7uIeEd6d/9ARG7/3dZKK9AO+KqYHiOYRw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7g1n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 11:54:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1ECFB40048;
	Wed,  3 Sep 2025 11:53:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 417292BBC04;
	Wed,  3 Sep 2025 11:53:12 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 11:53:12 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH 0/4] arm64: dts: st: add ethernet1 controller support on
 stm32mp23/25 boards
Date: Wed, 3 Sep 2025 11:53:01 +0200
Message-ID: <20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0PuGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMj3dwCo/jUkozUorzUEl1L85SUlFQDizRLA2MloJaCotS0zAqwcdG
 xtbUA8Lec4F4AAAA=
X-Change-ID: 20250902-mp2_ethernet-97ddde08f903
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01

All of the current stm32mp2x boards embed an ethernet1 SNPS GMAC5.x
controller.

Add the support for it on stm32mp235f-dk, stm32mp257f-dk and
stm32mp257f-ev1 boards and default enable it.

On the stm32mp257f-ev1 board, we choose to keep the ethernet1
controller as a standalone ethernet controller instead of using
the TSN capable switch.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Gatien Chevallier (4):
      arm64: dts: st: add eth1 pins for stm32mp2x platforms
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-dk
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-ev1
      arm64: dts: st: enable ethernet1 controller on stm32mp235f-dk

 arch/arm64/boot/dts/st/stm32mp235f-dk.dts     |  24 +++++
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 126 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  24 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  25 +++++
 4 files changed, 199 insertions(+)
---
base-commit: 4952fb7f53d4c9f007147ffb250c04ed40c959f7
change-id: 20250902-mp2_ethernet-97ddde08f903

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


