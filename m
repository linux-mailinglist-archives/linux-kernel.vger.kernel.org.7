Return-Path: <linux-kernel+bounces-782184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8510B31C57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740C0B40906
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FB307AD4;
	Fri, 22 Aug 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NBX7P9w7"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF16214232;
	Fri, 22 Aug 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873512; cv=none; b=UcZuKPVMsnSZyTPWYgQsxEnZoq6n0eKqdOc0YVo8vgzreEMx1muAh9PaCETpr28wpN+2rZmejkMl8Jo21UFZohdrh5QeJJpTDCMo47JgfmyCFhVdBFvn4IQBn3RkD3Cn5uKMPtA5VW4Lh4Cl0EPilFjOIlC7BORZRvvikU8sZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873512; c=relaxed/simple;
	bh=n/k/WObRNToFQoq9VExTjDLeZD94Hdt85ZrGjCeDPxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hJBkXtj9orMuneVJ84/8qOW+IJdQryLZnDGeyHKCjNuB+kvkcm1fcLtnwBLPTEXqAiX0azuwyQ4O2B52qGRe686zE7XLu1944P7ut5I8dCVDPtEk7j6leBJyOX3oBTP2YlRTBgISlcFnVToDiZubeqZwxC1rUjX+Jxos8juV1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NBX7P9w7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCNlUw018576;
	Fri, 22 Aug 2025 16:38:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Xwng4tLCmXcfutoUgEnbXk+sPZQAQDCb+EfzGCxzZ1M=; b=NBX7P9w77+qHcvpt
	jA1Rh3kmQHeoCbUFdNElDR5gamQQPpP1JlBIA/AiQcd/dtjjTsZR8pwGCCpNkC7i
	4Z+6OwRjuZb2FmmdXbFIyONRbsiDyFv8R8oA6BryxIpT5vi3quE8gUsOqgUtgXHZ
	DulNlJwuQRu6V+sICTuGzUi/+kYVB6e+34cuWIUNsSp0EoPnVATTyAaoybe9BLhU
	ZrDJqwiI60Q0sPJmifttyCplZ3hlfSTtK5VxYTUKf3zmC9Rwhm03RIsBVySK67BP
	XYptmVIGkyyY1xOMvK/vypvFYiojD6/2IYr9UYrbkmFPEgBKVINCbnVsj7AkCbBv
	aR0Srg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48np7n7hp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 16:38:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B25FD40049;
	Fri, 22 Aug 2025 16:36:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3A98726CAC;
	Fri, 22 Aug 2025 16:35:50 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 16:35:50 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 22 Aug 2025 16:34:12 +0200
Subject: [PATCH v5 03/13] dt-bindings: display: st: add new compatible to
 LVDS device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250822-drm-misc-next-v5-3-9c825e28f733@foss.st.com>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
In-Reply-To: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Update the compatible to accept both "st,stm32mp255-lvds" and
st,stm32mp25-lvds" respectively.  Default will fall back to
"st,stm32mp25-lvds".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
index 6736f93256b5cebb558cda5250369ec4b1b3033c..74e61d95370c299130410cdaae833514324c3e8f 100644
--- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
@@ -31,7 +31,12 @@ description: |
 
 properties:
   compatible:
-    const: st,stm32mp25-lvds
+    oneOf:
+      - items:
+          - enum:
+              - st,stm32mp255-lvds
+          - const: st,stm32mp25-lvds
+      - const: st,stm32mp25-lvds
 
   "#clock-cells":
     const: 0

-- 
2.25.1


