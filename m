Return-Path: <linux-kernel+bounces-801415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA147B444CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79636A60077
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49451320CB3;
	Thu,  4 Sep 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QqA3kHn2"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B831A558
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008242; cv=none; b=GSF8em2wsBkED/Fq+qQjuRj0R0TedETr/tQplSbQnmTVz3JjZ9eUUqUkimexLy72rStXR+WMKmxrgucrM6lt4vCk+jtOZZd5tO6ZxfMs6aQhGhnPeX434t3iJ4LPyaSTQ5hsWziSxAG8RKY+gz8oXo0h2j5OXVLBrHj1BSbFI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008242; c=relaxed/simple;
	bh=QgM71Vx9GPruJZ1GQARsMLEdNuE7CzFhk7e3orUiEyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paQOdYwisHBF+E+I1l+Vygbowc0t1VmVaDM73MJT0Sy0Q1rIzv6/DMFTdAaR5o5VzJl/V3VKXrFNW791qN+ZZdLaPDHGsDnRtR4rYdQl4qLPvCZdpo0pMIL9fMM2BBXVgZcdYPG86lWLlluhEG75YsFTxilEpV+/A/WevjjESlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QqA3kHn2; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 84A1AC83C4;
	Thu,  4 Sep 2025 20:50:38 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 252A6C83BC;
	Thu,  4 Sep 2025 20:50:38 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B8DB31FD14D;
	Thu,  4 Sep 2025 20:50:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008237;
	bh=+ecMEM4xOwQfNGFueMdh3PKM9vrNglGfesSLHZZtaFs=; h=From:To:Subject;
	b=QqA3kHn2HD27vf36GILkSaFsDQxkhNIiDKyXC+YuHtDKFx5CbSmnoTGoSmTNhIg9a
	 r6D8Sll9SzS6geJbBROh6+8QAYq034avAUZkZ695IWrPyPb+uUhSFzF2wkolHWekfE
	 Er7M7ZcoWKUYeZFN3PTo7fsYog4DD2gADCz9mCH1FJmhE9aRLTIcie8KLwGlAiL3/M
	 90nYC4vsAYD/ZV0voeab8ULqWnYjoF+lHjS2cD7DkhKnk+j86BsEQMDbWRgQC8XwJE
	 h+XlhfKzK563Q0yqKiEBcfYrxcZImqK8I1KL7OkpoSiyiYmzHdrF5uv50vJFIpkCiB
	 fXG6e+prMQXUQ==
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
Subject: [PATCH v1 05/10] drm: panel-orientation-quirks: Add OneXPlayer X1
 Mini variants
Date: Thu,  4 Sep 2025 19:50:20 +0200
Message-ID: <20250904175025.3249650-6-lkml@antheas.dev>
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
 <175700823784.2009311.5126683241193834955@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The OneXPlayer X1 mini features a 2k 8.8 display with a portrait
orientation. The Pro is a CPU refresh. Add quirks to set the panel
orientation to portrait mode. There is no Intel variant.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 378a3f692952..0c0fe66e94ad 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -516,6 +516,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 i"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer X1 mini (AMD) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 mini"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer X1 mini pro (AMD Strix Point) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Mini Pro"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* OneXPlayer X1 AMD Strix Point */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
-- 
2.51.0



