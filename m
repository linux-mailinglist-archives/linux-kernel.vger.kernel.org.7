Return-Path: <linux-kernel+bounces-757150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6492B1BE58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE197624A97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9841A23A0;
	Wed,  6 Aug 2025 01:34:25 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627E185B48;
	Wed,  6 Aug 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444065; cv=none; b=P0A/NtIiM7OO8uwIcOMHk69gxYxbnGktwwN42YzdSDr2Cu2E7j5dduhyIn+pnkfUJipKoJlEOLqlLdR0eMRIW4jIC245+XgKCXE3BAfSVq5MTHMwJ4nXfMUvElKADCaOCa0aSA0u+PdSgFhOUJAGvDPFZ9JT3lyY0LZlxRsvLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444065; c=relaxed/simple;
	bh=ohY4NDWOBXGUn5xQk9bIjBVH5sXz7LJ9Z22E3eacocc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiaOWKQDP52q1IB5DyI6mUwHUCEocDI3jAWPhuiERHFBLJ5yluv5YWDbKjfY+VhyPv4Lvz5r7BmHk51Dpgv0s61M24vH5FoVy1htqg3YFsfgoeBP9QGNwdKqpcVAnf3dGA0oUsiw9qCtr4/zjQY4iPE2ppbaVBCd52WXlEiEFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2E751A0E0C;
	Wed,  6 Aug 2025 03:34:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9591D1A0DEB;
	Wed,  6 Aug 2025 03:34:15 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9E4718000A4;
	Wed,  6 Aug 2025 09:34:12 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Wed, 06 Aug 2025 10:33:33 +0900
Subject: [PATCH v3 2/3] dt-bindings: display: panel: Add waveshare DPI
 panel support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-waveshare-v3-2-fd28e01f064f@nxp.com>
References: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
In-Reply-To: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, victor.liu@nxp.com, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754444048; l=1209;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=ohY4NDWOBXGUn5xQk9bIjBVH5sXz7LJ9Z22E3eacocc=;
 b=xLr5Zv8E05xuU8R93BdmPTzLg7eEWdeje9uQ6m1JVELURWQnyynlM0vxqKZrOF1UhyvZE6n7r
 ih6z6RUlzDXBWoEmv1Rq+h5yEjwxW9aCJjghaaxDzItsiiz06hwgL7w
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

Add dt-binding documentation for waveshare DPI panel

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
Suggested-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b89e3979057911ab9e669e97e71c16578d9e0150..16465fe3333948909c5d1fdc2a4ddf231bfbce70 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -301,6 +301,10 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # Waveshare 13.3" FHD (1920x1080) LCD panel
+      - waveshare,13.3inch-panel
+        # Waveshare 7.0" WSVGA (1024x600) LCD panel
+      - waveshare,7.0inch-c-panel
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
       - winstar,wf35ltiacd
         # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel

-- 
2.34.1


