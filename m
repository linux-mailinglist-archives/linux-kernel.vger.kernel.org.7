Return-Path: <linux-kernel+bounces-779604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C396B2F62D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C43A16A8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A83115B1;
	Thu, 21 Aug 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZtCEfDe3"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6630C357;
	Thu, 21 Aug 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774760; cv=none; b=Ng0bQnBIu9IZfcOSC7r135ELHs93TwI86IeWM49r9rs0amQ6AwTUXphYymJbJx766EHp2fUlnFnBf+E+Xxmm+6Hm3HheZtRofN5hxELlJZg5mAEJZmUv3Ts4gXxYE5buwzlooJZpR8KS/gD++L11nEJ9TSMc+6bUKlNSgrPfU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774760; c=relaxed/simple;
	bh=qo4J7XJgK6kl9qMa+cgF0AhbYD1LR0bdNNW7PKVk418=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jMLHn9UFUQlU6Tq1pB7+U1pIfRLpY9okUeL44jfxFXgXG1bqbnPZQp42GJC0qauobVFB3sa+7d8xLwyG/C6cm/HR3XNbTkG4DQ+Q+tFXSlHU1yeEth7nuF7umnMGZ0LJeFopKaY74TMRLLtaRtXNzDzoHMhDWlUk7EfFZn57CoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZtCEfDe3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAXMTs019049;
	Thu, 21 Aug 2025 13:12:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	P2T7BIysSM4Y8vk6YV25Wl1L4tMEC9reFcGRGZZ14rU=; b=ZtCEfDe3gH/hsNGj
	/QHKuk8PyCwBTceIsgYilP/lxDH+pxIUaZs8RhbBfapQy9It0tVAyUNJsfbR1jCq
	2ckRkAElhXYF6XlGlxmQkEJAQqWeAa/pYjYnm3IjUbuj+/ijfMDXKZe8QbT38UgG
	ajtJAuzUgN+rlz/XwlxuzMUpyBtSdyN9ysZt3ABHe3vYNNokm4/Nj+kGbt7fFlAZ
	JXFS2BBgZxRUvVjTi6DrLGc2neHXTnl5rA2RBeXSDIGwzRPVuURTKUUmBs+oU0rl
	cQMnoGapBR4yQeW/BrJl2/BeWWPNL+sx4oKxJLGzZp68D2Z1QXDoFP0fqzWWSfWP
	iCVYSA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n754ehjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 13:12:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 15A5C40052;
	Thu, 21 Aug 2025 13:10:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63EF174EF05;
	Thu, 21 Aug 2025 13:09:53 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 13:09:53 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Thu, 21 Aug 2025 13:08:53 +0200
Subject: [PATCH v4 03/13] dt-bindings: display: st: add new compatible to
 LVDS device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250821-drm-misc-next-v4-3-7060500f8fd3@foss.st.com>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01

Update the compatible to accept both "st,stm32mp255-lvds" and
st,stm32mp25-lvds" respectively.  Default will fall back to
"st,stm32mp25-lvds".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


