Return-Path: <linux-kernel+bounces-745563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6841BB11BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB31CE2DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4152E2F03;
	Fri, 25 Jul 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="udZY+Iv2"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC62DFF33;
	Fri, 25 Jul 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438041; cv=none; b=D+FL62zrtOzNzgYOIYMxWEZYnbzmTR6PUny9+Dv061JR11NNx2tozub2nmF1yhKVm/LjbiuOdeXYIO3JTY1ChH1/q8HVUrI0Nmu75p4gdVQBpeDEJ9oK1un2iEncShcphCDl/dgu+gXclCNj+eFoU0mN468Rp8Fb6Z4fe4JQCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438041; c=relaxed/simple;
	bh=3vJ6a0m9YlolNiQJPlXI8prk8W0Qn0bLOFUDfJcd2Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EsUU7zLHypLOB+Vn7bENtbj3ZVhXTxlp5MHXS9EEFKUosHLxB+ESMHaQuFQodPjaTyBnszwuknqmlmMqMAFuxDkaxpV9wyPjoQx4YXNZTC2cDwvaLnvqo4E7aguzwFwXCoE6ELz1DIXgPiEBisUeCxOHCJ0PafVytv48wz+8Vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=udZY+Iv2; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8fPi4001331;
	Fri, 25 Jul 2025 12:06:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	EX6rxtdAs/to6XTiWeXFKYzusiCnxWSZcT/XtlJzybk=; b=udZY+Iv2Cvjzd8et
	d4nRw5vI2Xa8F4oHabOI/wAuowvq/5lVlc+FsEs2YxfcoYsrrNrf0EPP+ZSx5Vj6
	7YPXWzSZYlPYmbKeFYbtSQtfjUu1zZu21FOXLVZHJiq+ZMiaSU1PWK9E+eV2XY5H
	m50jalfoHib2wvA80cuHG448Fiet8JouLaX5FYsQi1x7zrR+2n1xCVSllf6EJPSV
	M8KwT2uEBMF1XJ4IlnZVJbZcc/Xfpn+ZLpcfgxBZRWDKBfSPvTLac5ZeiXW9WyXU
	W22W0MpKDh9Qjqc+0XZNFfsq3KpKdK/DuRWA3vfL8kn3h+QDG8vs5pJUgpybNGuU
	1JaxRw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3m2hcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 12:06:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8299640052;
	Fri, 25 Jul 2025 12:05:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF6A57A19C4;
	Fri, 25 Jul 2025 12:04:28 +0200 (CEST)
Received: from localhost (10.252.19.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 12:04:28 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 25 Jul 2025 12:03:55 +0200
Subject: [PATCH 03/12] dt-bindings: display: st,stm32mp25-lvds: add
 access-controllers property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-drm-misc-next-v1-3-a59848e62cf9@foss.st.com>
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

access-controllers is an optional property that allows a peripheral to
refer to one or more domain access controller(s).

This property is added when the peripheral is under the STM32 firewall
controller.  It allows an accurate representation of the hardware, where
the peripheral is connected to a firewall bus.  The firewall can then
check the peripheral accesses before allowing its device to probe.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
index 6736f93256b5cebb558cda5250369ec4b1b3033c..e046c0a4fdb7f13ca5a31b14ae0ab19f2bc486fa 100644
--- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
@@ -54,6 +54,9 @@ properties:
   resets:
     maxItems: 1
 
+  access-controllers:
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 

-- 
2.25.1


