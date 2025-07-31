Return-Path: <linux-kernel+bounces-752354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1056B17490
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76025865CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247E238C35;
	Thu, 31 Jul 2025 16:02:57 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13022425E;
	Thu, 31 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977777; cv=none; b=Yfzx39eX/TxI4GZmLxlesafb7jVV4KvDRIpPrOD0wD4DUAVONoyjxBokaFsPf6CDXzteiyY6A1ivBygFPnzLn6Y4enPF9ZXS3gDF2/kaRLJ7oenFD4pgXKQrEppgqHfZVR7ZXDh9aGr0d+gsbpblcGMuvkXYgWqF0RC4fOqmNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977777; c=relaxed/simple;
	bh=uKSxvnNfrY7KR4qCrsDJ4BK6Q4UM8mA7pD5swc+umnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkuEz7plsD+ZowHw/Y4CSMb9siyNwFbiLC0snc5VMi65RvRjYtam2AhYGAoFlM8xz2gYeUdwxkGMMkSOBKlKkJwuQ7LQlYdx/tyQ9YviQ72DYrZsoJet3MY6Q4ZfuQhXZPxRp0wlOQz93vJVU+pFQx9SdOvm2QK8/3nwyMEQNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 967D01C270F;
	Thu, 31 Jul 2025 17:52:51 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id AE9F51C270C;
	Thu, 31 Jul 2025 17:52:50 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:14 +0200
Subject: [PATCH v3 01/16] dt-bindings: display: sprd: adapt for UMS9230
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-1-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Add new compatible strings for the DPU and DSI controller found in the
UMS9230 SoC.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 7 ++++++-
 .../devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index 8c52fa0ea5f8ee2149ebf1d4b0d5b052832e3d97..cfa162178fe11df149f2f8dcb03383dafc44868e 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -16,7 +16,12 @@ description: |
 
 properties:
   compatible:
-    const: sprd,sharkl3-dpu
+    oneOf:
+      - items:
+          - enum:
+              - sprd,ums9230-dpu
+          - const: sprd,sharkl3-dpu
+      - const: sprd,sharkl3-dpu
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index 300bf2252c3e8e589dc74927520e24aa4a59f81b..9177ae6aa7a33f7f797b48cfe06cf8a5391b34a9 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: sprd,sharkl3-dsi-host
+    enum:
+      - sprd,sharkl3-dsi-host
+      - sprd,ums9230-dsi-host
 
   reg:
     maxItems: 1

-- 
2.50.0

