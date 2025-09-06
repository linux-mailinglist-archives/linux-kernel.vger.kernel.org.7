Return-Path: <linux-kernel+bounces-804314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15019B471D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFDA3AB224
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDE0220F5D;
	Sat,  6 Sep 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="Y30exjbV";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="pDTdLOli"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997712AE97;
	Sat,  6 Sep 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171914; cv=none; b=qm0MggiaCZHAZ9n4vIj5rCcn31rbY7ebBzwPT/fCThzYVDwrm9WsEXHe+yc0Z/OkP4yzL0sjyoIunVOaXzN/mklqnvyUoJWpgBUSnpCLjaLIHKfWG0UlAzrIFlYvBcd+sV5/unYaaHyrLm+pxCuA/HMv4GYzG+fz/FnOaLH0JWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171914; c=relaxed/simple;
	bh=+o4VJeQXoA+m5LVrfsjx1orWvDjrM8Lzhu3UCZXmXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWFvKYwQA62K32yWFdKS3GXN23zAUb+Plhqaqy6XjsyQS4raBy2e/F9sesUQsY+v6FN6ImHl2pYJUyk3doO1kLGf3k9ook34L1q0VoLCiu73Ev+6wUY6tDgyKgT29hMcKZ16MlL45rq35ittzmRsd5ZCXkEzsBljOlVOo02fggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=Y30exjbV; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=pDTdLOli; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171903; bh=+o4VJeQXoA+m5LVrfsjx1orWvDjrM8Lzhu3UCZXmXv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y30exjbV9JC/6kT+0HrNt7w0e/Ba0Pq5g9gGZ3GE1GWEZwixdkNMCaIQzrrj6LSkO
	 hl6HZ7v9MPWKSGLRwTZIwfosjQVgHXIqDcxSa1UMZnRZKycIvDSKzJQozZvaJUl9J4
	 L7x2TxK8mB1/a1e5GE3G5SSpNKdsB+Vcu+/PmS53EfPwe/xWwSQ4IhP0RkFv4aTmTv
	 cHXvfhQGQMmrchdYi884bOb2fUB2cc4vSTI2+AToRJ7jJe0Rnia0/6IAeReq4/R1wZ
	 Hu4NWmTMJjPduih1Mu30jZEoAGj5t60BdZd0FaNNDup5IfgB0NndI3G2tzFUH52mr5
	 OGgsZdMA2U/Og==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 2F9FAFB02;
	Sat,  6 Sep 2025 17:18:23 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ch4jWnnOtYz; Sat,  6 Sep 2025 17:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171899; bh=+o4VJeQXoA+m5LVrfsjx1orWvDjrM8Lzhu3UCZXmXv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pDTdLOlimc2+zE8wFjyL+5k/apGOYGI+bQyEVqmPi5uk9wO3136LOyauP+/kVttcS
	 pqHWB1/PGk+20fWXoAw5ieLjazc6/Nor2rPU62JMmKRUin/3MMh5GPjcAbe3kkfxjI
	 bZFjJTl+Ss8gqLSx108D2AweDfxeXs/B6Q0B1Pd1I6/QQXdVGGuwc/3KIOB6UtT337
	 vV7ywfj/7H8GfRdRXHRPLZWGGj34LtTBLCdu+a1lY4oKy3Pg6F9mjmHcI/N5fGFVvA
	 BLpGmCmeWZVhDTKfVYAeu6EK8PDluV65sTTCagAkW/g+4l2TPWPIRLTuVTDfZ77HB0
	 KKjslZyl6LUdw==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Sat, 06 Sep 2025 17:17:25 +0200
Subject: [PATCH v2 1/3] drm/panel: visionox-rm69299: Fix clock frequency
 for SHIFT6mq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250906-shift6mq-panel-v2-1-aa5e585d8717@sigxcpu.org>
References: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
In-Reply-To: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=+o4VJeQXoA+m5LVrfsjx1orWvDjrM8Lzhu3UCZXmXv8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm92RkNvUHhELzIySTUzdGtlOWdOUDU3M3Q2eHJRCmIrOXNmeGtENER4dStyRmI4
 RmlKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUx4UXFBQUt
 DUkFsdjRaU1N2ekI0NEhxRC85NlVIV0gxZUYwZnA5R0NNdjJQaVo1ZkV5blRoTlpIZlNRcTh0TA
 piVG9SdG9QVExMRGdaM0I1OFRYbkd5ZG5SVkJNeHcxZml4M1Q3L3pLcEhnZGxDSXUrSFlFSlkyN
 XRaL25NUlg4Ck9Db3JPS0J1OTlobThqM3hlRklOU0F6VlM5Umx5NTJ4ME9UUWJCWGFza0dmUFYz
 UmVsRUdKaXBXMzFtMmtUS3cKUS91MUZ3bjJGbUpQRld5ZGJJQ2J6aE9TNFFnaUNJVURacUh0Ym5
 oVXlaRFA3QjVuWjlBRmJuM3Z2OFlqbXk2NgpjeTJVK0NoTnVBSG1lNkl4Y2dRNG9scjViR2RiQ2
 lGekxOYjhtREdiREtSOE53QkNhOHBEUWgyUmU5b3VGTXhjCkJDeTYxLzVrOWUyT2dsQTJDMlI5M
 klFMml2L29uMEl3MnlrNVhlQ1pBeFZnMXhwTU9QSVREUW5OanhjZEVSOFYKeXF2QW5YVmo3RFFZ
 S0czK3Z2bWdLT3dtRXJPdThxVFRwOVF4eDZVSWtVTHlPc2dxWmdWNld0Q2laR2kwR1lnLwp2TnZ
 JN2lFbE5RNW1waXl0am1naW5XcXViV0dJbWE5SDFnRUpucE8zalB0aXZnMEYwRTFTNkxnL2ZQS1
 Y1WjZTCk05cDV5TFBYV0tWcklIdUpyUVNub0tvekYrUzNpSlI4RlVWYnQ1NVUrZUkybjg0YUprT
 TU4QmdqQkc1VUpzbEUKTjE0VTdiaHZwMUU5djJjMXlOMzRQRGI1WTJjNnJTQThjTGxmRHlVSUJx
 SkVLVVUwclJ4UU00aDQ5b0s2eFFrSwpRTzU0amJ5ZHh0QzkyZVdCcG9KWXYyWmk5UUZxNnQ1a1h
 1YkRrRDdhTmsvYzNkNEp1bXJhY3J4VGwzNkV4akt3CmhXdytRQT09Cj1xeE9YCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

Make the clock frequency match what the sdm845 downstream kernel
uses. Otherwise the panel stays black.

Fixes: 783334f366b18 ("drm/panel: visionox-rm69299: support the variant found in the SHIFT6mq")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 909c280eab1fb408a713d84051a1afbb252c45e8..e65697ce6f51c7d64b786da18cf44b16de5d6919 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -247,7 +247,7 @@ static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
 };
 
 static const struct drm_display_mode visionox_rm69299_1080x2160_60hz = {
-	.clock = 158695,
+	.clock = 149360,
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 26,
 	.hsync_end = 1080 + 26 + 2,

-- 
2.51.0


