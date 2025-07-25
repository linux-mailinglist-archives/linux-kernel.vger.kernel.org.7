Return-Path: <linux-kernel+bounces-745566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA17CB11BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D557B35B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981062E542F;
	Fri, 25 Jul 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="w91d5h9j"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B82E5411;
	Fri, 25 Jul 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438047; cv=none; b=HDMlhRWEFD6x5v4tcgPeLjBtqiXs5H9x3u7ROLOmZsJnQ3Et5RN2iapzaUwijf+4hzsFrTvUzujmKsAw9vi7PkliSMRCurajbIhVqiTeKHvOn+QjY4ZTeyAfIYYoSxgk7BtiJTxGROcYXMmnI8+PG9DhSFcWzG5Pyt5zXzWYpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438047; c=relaxed/simple;
	bh=424wpOLSbFJZm5JAoAz2xhwX1pbC+41L34QgL5hbtCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T3NuN/Ppmzbo2ERYji1Pnfl6FF6afQi4OTdmBMOhp5fZyJguGCrdJOlgTVn7sbGk1qmJ36eoo5847i6LL39MMp9XWTr2n/gWScyXF7eLZ7vIz8K6XJcp7JnUINnQd5X4Gi6RbdQnPU5i97CMf1XegkORjNaWSJMvva55NhgVOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=w91d5h9j; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8Rxmd010432;
	Fri, 25 Jul 2025 12:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qHy0DuOKvNlciYNAVQbkhzxS9vOn9GF9O63x8jFU/C8=; b=w91d5h9jfS7WyRDb
	bu/3/JkV5WURUCvSqd8UaPlK95O/PWiOJ1n4d76nUoVj8pPRjp9Xm9pOjQRngVRU
	d6KW7stnp3Au8tZa84+9iWCHGUirKhhaL0iIJofUavot3eq7C85C8I9CqQsCUO/n
	jMgm76MS3tMPMtTd43I/M3R0TiKz1m0aHraCzhW7Eorth7XsUaUjSYw57+/WpH8n
	gCOGoa4I5IRl5iIdr3/d2rnuGmm/SBYWDA1rTr/s1RrKVgYL/ULYR3LMrhs6zHld
	I9qLmVfLB8khHiRJlEoUM2xsr0PWq5S99q91TQtnCLSUygl/IGyPHp+mjzpUrP5e
	30JZGQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3m2hdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 12:07:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AADE74005B;
	Fri, 25 Jul 2025 12:05:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF0757A19C9;
	Fri, 25 Jul 2025 12:04:34 +0200 (CEST)
Received: from localhost (10.252.19.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 12:04:34 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 25 Jul 2025 12:04:01 +0200
Subject: [PATCH 09/12] arm64: dts: st: add lvds support on stm32mp255
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-drm-misc-next-v1-9-a59848e62cf9@foss.st.com>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01

The LVDS is used on STM32MP2 as a display interface.

Add the LVDS node.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp255.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
index f689b47c5010033120146cf1954d6624c0270045..a4d965f785fa42c4597494010855aec7e1b9fdd1 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -6,6 +6,18 @@
 #include "stm32mp253.dtsi"
 
 &rifsc {
+	lvds: lvds@48060000 {
+		compatible = "st,stm32mp25-lvds";
+		#clock-cells = <0>;
+		reg = <0x48060000 0x2000>;
+		clocks = <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
+		clock-names = "pclk", "ref";
+		resets = <&rcc LVDS_R>;
+		access-controllers = <&rifsc 84>;
+		power-domains = <&CLUSTER_PD>;
+		status = "disabled";
+	};
+
 	vdec: vdec@480d0000 {
 		compatible = "st,stm32mp25-vdec";
 		reg = <0x480d0000 0x3c8>;

-- 
2.25.1


