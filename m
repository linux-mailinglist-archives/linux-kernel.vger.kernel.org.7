Return-Path: <linux-kernel+bounces-794764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C33B3E6F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447CB444E54
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F3341AA4;
	Mon,  1 Sep 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="lHYqxptS";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="TvvRcH+8"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A85340D94;
	Mon,  1 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736578; cv=none; b=qlnKp3Ml6Rp9RIrHiTyX3kas+RloJ7tTOG8+8j6kKIDOBXaz1lMgp6c09UD8n47TcHH+ZFh90XQaHj8O8Ps5+107bDWa4vQFWeV8w7ChFqy0Y6VuNh5wo0SECcZ+VGihZRG3E4o5WyuMZyWGYi+GTVuaLLYgXmm2twJjUzOFnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736578; c=relaxed/simple;
	bh=XzP2oIYHCCNvXv897N+EIJB1bCuQBdP71SLZnhgZr94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goZmd+XTONmrOgT3xAmMyGTmwdtpe9SqRXppguiHYQB5Rr/XaLnqdVuWovwo+GKA4ol0lG0YwK/Ivkhjsoe5ET3mc30IijJ39hug/78eth8Tf0NHpNkSnu7uMeuZrUkeWUvhrRELMocVDa2fJ9YEYFo+dChmqjcvsmDPOzWXjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=lHYqxptS; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=TvvRcH+8; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736566; bh=XzP2oIYHCCNvXv897N+EIJB1bCuQBdP71SLZnhgZr94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHYqxptS6PBpb57vKPnnuhDE4Gfm9i8QelJuEAVg/3m9NILhievRTGRhhcb+gBOG4
	 u4cX2RXaonwmEh/rZMa2KF60uz1FotVIdoJ7nWbNvBH0EDh6cC/59+/qoftSSVMtlN
	 OVwTfsqmcI8n0n+BBdylAabgoM3CctGLc5WUkPT350PWgwR0/M1DIlmmsfqKHi6qAH
	 aYxXMPm6EMvsvEEAV5preNP60oS1l33pYs3e4T7x1VuVhL3KcOvAegXRtNrfa7GKiQ
	 OVIOl74dylBcVNby2ybzoZSbr2b8BTMFvx5ySnYahZ7VkSIcbl3kUfVIPF4fhdPQt6
	 jwdzp3aYxnlSw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id CB6EDFB03;
	Mon,  1 Sep 2025 16:22:46 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9AggP_bAkQe; Mon,  1 Sep 2025 16:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736561; bh=XzP2oIYHCCNvXv897N+EIJB1bCuQBdP71SLZnhgZr94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TvvRcH+8AEsFhIa5PXDIJy2kJP2r2kwcezC/P5QyeO0Ym5nmiFJZCkY7VHzF8NgYd
	 rd1I1Yn22zfi6xA+Ua+826Tv1oOrGw0m4/J005fXNe6M6GF+3iArxL90S10LugiwAd
	 XH/qqvoRawVxhYE4JSdrkTSw0IrslZ0ZUGB7gw941+VANoZ9I+dyaoaX/APHvYh9bU
	 1BZs9urtxrSsgTxor9l+aeFWQPt0HUlY8jgNkIO2uUTpyGYydnKpp9cYYjOugjIe2D
	 yP7WRnnIgrGJ48C9P3iGgdNUW35Qm/3doCswFOUZciRMC1gDWknuS6Uo/9AB3YYea4
	 WOYX1Cc19XBwA==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Mon, 01 Sep 2025 16:22:07 +0200
Subject: [PATCH 2/3] drm/panel: visionox-rm69299: Don't clear all mode
 flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250901-shift6mq-panel-v1-2-444b4abbfaea@sigxcpu.org>
References: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
In-Reply-To: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=XzP2oIYHCCNvXv897N+EIJB1bCuQBdP71SLZnhgZr94=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm90YXdsQUVOMXJSL0VzeXRxT3ZyQVZxdkJ1RkVKCkJjZUtZdHFUbUlSdXNkWXdG
 ckNKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUxXc0pRQUt
 DUkFsdjRaU1N2ekI0d2M2RC85d2ZCMWJhV2ZUYUEwbnl6YVREb3VTcEd6b1RqbElZaTF2RG05Tw
 pBYTFmcEZ3OTlrUFlhYnV4bXgxeXV0NVpYN2N3K01TQW9Dc05NdVpJY0JPNEN1UEQ2UzZ2bDdGZ
 ktQNnlmT3JkCnBFMjBkNFdPaVk5ZFY0ajNqYzcxeG01ZG9zZ0s0MDNydUhxRjdhVExOdUNjWGtO
 UHh0S2JmVkJBZ1RlaG93TDAKWHpTaUxnMU5UWE1uQURiU2JGSGVTVE05cUNkT1FNSHFVRmhtUmF
 EMy9XWnAzbVN6RGJWamR3STJCdjVvUXhaNApSc1BLWURZM09Ic0ZIMUdId0dOak9jOXBRY0k0bl
 UzY3NoNVMzY3NROUVRdHAveWl5SEMyQmx6Mjh3MEdpNjFOCkNjSkRFOFY1T0VpNUo2SzJLc2VJQ
 VA3THgrUEladVNJRmY2bDk3UGp0MEZDWE14ak05WWhma1BHTllDanRLQ2QKNGtsK3lmWGVROXJj
 bWJBS2Y4QmtwSjIvK0dPOVRKMm4rcnFmN2h6cFRFVnhhQjVZN1Vuc2ZuSXJNazl6ZGhabApsNXB
 DQkxmdUZ5elRoMEhWeVQvdkh4NThPNlR0NkVsRmM0SGY5cGJ6SE01QTJ1Y0FtWERzditQRllkUF
 VMYkoxCm15enpIb0ZzckZjOXBwUVV0dmx4eEI2R0h0T0dFR3YvUllFVjBzSmJkNjRCM3hmTWY5c
 zRCZHhKRnJxcVBpZGIKY3NRaUI2cFM1VUdHelBmNHZxdWhjNktmZG1RRkJpeU1DZ1RJWHNhZ0Ru
 S0piRXVvdlBNQ0xZRDJ3K3RkNnR6agpDbm5HNzFGd1FkNlhPS2ZJSFdrWCsra3FCK1FrZml3VlF
 4NmxOTHdmYXNTREpsYUh1K29lM2oyWnJuVCtEVmxKCmZaSUdIdz09Cj13MEhvCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

Don't clear all mode flags. We only want to maek sure we use HS mode
during unprepare.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index e65697ce6f51c7d64b786da18cf44b16de5d6919..2216d38366ea37368d15480f9d8a8ccbfe77ba3b 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -192,7 +192,7 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ctx->dsi->mode_flags = 0;
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 

-- 
2.51.0


