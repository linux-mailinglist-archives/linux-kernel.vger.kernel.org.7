Return-Path: <linux-kernel+bounces-754611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D299B19A14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E0B7AB73D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA46202C26;
	Mon,  4 Aug 2025 02:08:14 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79A1FF1A1;
	Mon,  4 Aug 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273293; cv=none; b=aGTKSDATr5XOGuQlLCm8Vf9gvIuF2KdCtFuMAVJwQ4SOojGnxNWE8Xq9ExQczrqjuVJot/mkQ5w7yRfmRd2pH5ih/hpBXAgK7iYWBBVyKGNNEESUK1Yg5gEe/cZ34NLpgBsM9mOFARQvr7rA8dBWmjM3DyOyxJYzM2lS54IURg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273293; c=relaxed/simple;
	bh=JvNftUbVywuCROa4W9f3XjLB1ul03oPw5xAFTLQb8kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0U8Ce3/tufURf5TBr7g/0wJN4DYzgLyTmbDfGXA18YmbI0iCJr+lV/o0IjH2Y0dS6bxcozB+Af4ElFb6TRQQQNK/84trpFg/GA5xi5RYB+yqBg/3j7brJhPFlMiOeJklQ7qMe0n9I2J+fyaTpldE2yQ3655c7x+KIAUFNqHjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 052241A0332;
	Mon,  4 Aug 2025 04:08:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB8DC1A035A;
	Mon,  4 Aug 2025 04:08:04 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EB1D41800082;
	Mon,  4 Aug 2025 10:08:01 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Mon, 04 Aug 2025 11:07:41 +0900
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Add waveshare DPI
 panel support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-waveshare-v2-2-0a1b3ce92a95@nxp.com>
References: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
In-Reply-To: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754273277; l=1167;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=JvNftUbVywuCROa4W9f3XjLB1ul03oPw5xAFTLQb8kA=;
 b=by4VNKWToFwbASGJXObuqAYVuCalLpXI6kByXfbpkn3b3IJqp5SCjtMZFhD+0CiPgrmVkxD8g
 IpknGdrNQa9CgMK0O4DnbX5CuioHOb6646WlHyYwhq+VShmpC+GiiSQ
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

Add dt-binding documentation for waveshare DPI panel

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


