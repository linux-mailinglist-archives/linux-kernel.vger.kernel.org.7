Return-Path: <linux-kernel+bounces-801429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC5B444E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7091A1733FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1D3148C9;
	Thu,  4 Sep 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="I5+I+mkN"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415231DD9A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008560; cv=none; b=Uvf+tudH0OH3u8JzQTLHhuT0WXmFQxSapJassirFaqKn0W2XV+bIkm6qjWN2o65G+8KP1ZNMXDtqhlx0e9Wn0v3nB9g0sbc8RFVtEx/QFXDvv6r6vrp16Wp0s8CFSWPtTYFS53NTYQrlOqR9gnzfE0bzHFGbR8kdBnFAX12rq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008560; c=relaxed/simple;
	bh=BLcqIQwUWUat4FBqxwDI6eenZi/TmMF8PEFR3CyxZd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNCtYXGjoXHaK8+NwLpyBjdWpyKiRy5PkWb6o1I2Wh4kkDvd1ttwt8Aw4zDfxUIPytd7O5HVwxWPqqcGFd7/poqN6gFprDhU9kIzEmJ5MHkdS7UoABQ45Wb8mPxPUzhPoJw/1zhMF9eeHNtFrT2Yw+t0nMEZRiiUHLxST+Tzsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=I5+I+mkN; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 9DD3B5E581;
	Thu,  4 Sep 2025 20:50:37 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 3B7775E4D7;
	Thu,  4 Sep 2025 20:50:37 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 834711FD140;
	Thu,  4 Sep 2025 20:50:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008236;
	bh=qPQnMDZ8/2LaQgoTpTGkOIQa6bG8kpuB4zydwLjC/os=; h=From:To:Subject;
	b=I5+I+mkNDal3kPVGKn5DjG6IFS9OvCfUfJ2IPSxn19jlQXqjkiTzffTN7vu2eaPO1
	 UpUWoi6fRLxukvpRbQlMvV+pXbkV6N+yXYgkp7q8eYUqKdbEa2m7nfObKGBrEq6TSR
	 FpUWeT2iTWM4tFaNZ1CgGa1wwdpPXIzAhnTthmohssmfZASfiXgSXXc7mHmtMbTVwp
	 w6/lY/vYfgDuLIWrXgZLqW1wCBbs1MRFlkwxskj9b068GjZ5MNAR9R9A6SLtl//P3t
	 IX0yriSFCYV5amLHvkfH+dm8IBfnhOIaBf7y8lcgUSE1DQr822u+d4/ZFhH0TGmRno
	 WQNw3Dr9lnLRQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 37.96.55.21) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	philm@manjaro.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 04/10] drm: panel-orientation-quirks: Add OneXPlayer X1
 variants
Date: Thu,  4 Sep 2025 19:50:19 +0200
Message-ID: <20250904175025.3249650-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175025.3249650-1-lkml@antheas.dev>
References: <20250904175025.3249650-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175700823641.2009264.1983696045287569757@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The OneXPlayer X1 series features a 2k 10.95 display with a portrait
orientation. Add quirks to set the panel orientation to portrait mode
to the Intel, AMD, and EVA-02 variants.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../gpu/drm/drm_panel_orientation_quirks.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 0ea06f928f79..378a3f692952 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -504,6 +504,30 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1200x1920_leftside_up,
+	}, {	/* OneXPlayer X1 AMD */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 A"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer X1 Intel */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 i"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer X1 AMD Strix Point */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer X1Pro EVA variant with Intel */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro EVA-02"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
-- 
2.51.0



