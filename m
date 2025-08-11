Return-Path: <linux-kernel+bounces-761990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D72B200D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963C57A8833
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A872D9781;
	Mon, 11 Aug 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y+lVt6Sm"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888EA1F428C;
	Mon, 11 Aug 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898739; cv=none; b=lZ4wWNprBShVVBGjO0EBH5A46AKfNd54FDkYQnJZdEMB3QFRna84Wwcux5+NC84LHrX7nKnUcd951s2CXfF3E43VDMW/jdM+ExvqO9mNI3Ijf4vuOoiEil2dwGrjTcKy4iSdTYlk4ONBBHEFz6JSh0T24NYR7pADhMmXmqblDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898739; c=relaxed/simple;
	bh=8/mI69Ui6+ZBnEP/vQjBOSQtMmG9jtdxZbjOxerYdhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=m7dMu903MCO9OwoQerR5KoKmf665ko5Kfsd2Kg+ymcw3k1GgZ509gjJ6GFc4DZqNdBG7B6yaQGm8n6eMXKO+jlMgFcnQ9DhBq3omOZR6VtTLvH42hmpv9Fl3daPp/pbdO/CkJeq+/CMJTgalNrW/TiErembI2LLHx2ZQssA8QQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y+lVt6Sm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B72MTN014088;
	Mon, 11 Aug 2025 09:03:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=rWyRdWfQDQutzaXJTzuq6F
	zLf4fGLCz19glPE0n0Xc4=; b=Y+lVt6SmUyF/yQu09cJNHaxF5ZXi24G8zs4Fqb
	0FdyVdyjTnTRsrDJHhpuIuGdkCNYqtPVOK7s/UTyjwlVkefRnSJ1+xWHq4Wa05uP
	xcgiTVrkQfAgK0LyWbgUhbZz4nzoAv5ssTTaau3KwqziDErAI56oju5Zy+hlXDJc
	gmiIDPlQ71xulvOybKkV6Lh3YPdihghcWgNrH/nTJRwV1+JH6je3sFsQs4LtjntB
	wMaCxaDOSeA6INqxbq61TJ4gGWOsXjF5mIZeDbXFi85MS4VdmmRnI9xXcvGL1iXv
	q7r1mxQwePh3ahKujfBmSLb2/ytHRZ0updoea+gYChfkqyWA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48eh9n2tmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:03:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 82CEE40049;
	Mon, 11 Aug 2025 09:02:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9943D71583F;
	Mon, 11 Aug 2025 09:01:48 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:01:48 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 11 Aug 2025 09:01:47 +0200
Subject: [PATCH v2] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250811-upstream_fix_dts_omm-v2-1-00ff55076bd5@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAFqVmWgC/4WNQQ6DIBREr2L+uhggSmxXvYcxxMK3skAMn5I2h
 ruXeoEu30zmzQGE0SHBrTkgYnbkwlZBXhow67w9kTlbGSSXPR+4Yq+dUsTZ68W9tU2kg/fMcK4
 e6so7uQio0z1irU/tOFVeHaUQP+dLFr/0jzALJhiqwYgebSelvS+BqKXUmuBhKqV8AYkH/fq6A
 AAA
X-Change-ID: 20250806-upstream_fix_dts_omm-c006b69042f1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01

In order to set the AMCR register, which configures the
memory-region split between ospi1 and ospi2, we need to
identify the ospi instance.

By using memory-region-names, it allows to identify the
ospi instance this memory-region belongs to.

Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Update commit message.
- Use correct memory-region-names value.
- Remove "Cc: <stable@vger.kernel.org>" tag as the fixed patch is not part of a LTS.
- Link to v1: https://lore.kernel.org/r/20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 2f561ad4066544445e93db78557bc4be1c27095a..7bd8433c1b4344bb5d58193a5e6314f9ae89e0a4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -197,6 +197,7 @@ &i2c8 {
 
 &ommanager {
 	memory-region = <&mm_ospi1>;
+	memory-region-names = "ospi1";
 	pinctrl-0 = <&ospi_port1_clk_pins_a
 		     &ospi_port1_io03_pins_a
 		     &ospi_port1_cs0_pins_a>;

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250806-upstream_fix_dts_omm-c006b69042f1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


