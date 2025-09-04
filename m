Return-Path: <linux-kernel+bounces-801413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E1B444C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0FDA065DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9133126DB;
	Thu,  4 Sep 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hGSykUIc"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343332F99B5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008240; cv=none; b=BP69ulWWVGnJGDqpebaw6KH7ot+YZ2Gkc/XRCkCcZoDWDzuN+JndaBWWy5v/2mkbaDYNovHlkwUCH5FJ3LOn6jMlP0AgPAbRrzSdtgNNJO3hxox5kl7qbgxljcfLvCG36B3SyMNHOICOhqQp0aDECodvxvyyQNKW8tdNy4vLOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008240; c=relaxed/simple;
	bh=nU1rWDdcnvbEGqB2XQZFVq7WejPm39ptFmnSm2fi4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaBR7QmcficwHYWYCBc2OqrXzzDTej1I33zt15laaoqbSpfXIc5LuwQosEOREAUes5mHxiOEjEw/w2VCrL/iQjwc5qkgWwUd+o0yMK6fkC4wTfWe6o20d1Ct+FSv17+KGAxDdghHLomW84RtzHLFmMW9mEzDk5fpPUcN1s9QNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hGSykUIc; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 20BBAC83D6;
	Thu,  4 Sep 2025 20:50:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 31873C83DF;
	Thu,  4 Sep 2025 20:50:32 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id BDCC61FD16C;
	Thu,  4 Sep 2025 20:50:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008231;
	bh=FAwQlwPQUFjjBDmWFYI8RWhKWg0GgiJpejj4F2AcJk4=; h=From:To:Subject;
	b=hGSykUIcCZZacyZuJJkY0+40/wYGVHcaqyeSQl62p5iEM8/wDBBxO/kNbA5JNxPLa
	 ZTtmiZmdk1caOSNknqVPpTVqyeWA/0IRn1r5EeeYcC2OeXgrueB+cUuYreUexSC+sK
	 uIlwj5fZS/AMjNZ5InYlMW4Soibq+gKX5qUWc0+G3uWJJL120rVXNhyxjxQfjFStEc
	 W0nnmgbJ3NeEEczTZxSSLPNN2KuEJljfbGzrjMhXtCYZ54YlBN/rcNQ5BRYCFQBA/G
	 3kObjzJ7e0d1Xuyolf7OWb2F4TBaJSym7VEhJyiibhSb2eoYh4XceOy/uwM5LR73TO
	 D0QBFSSLi644w==
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
Subject: [PATCH v1 01/10] drm: panel-orientation-quirks: Add AOKZOE A1 Pro
Date: Thu,  4 Sep 2025 19:50:16 +0200
Message-ID: <20250904175025.3249650-2-lkml@antheas.dev>
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
 <175700823183.2009087.916605427090942928@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The AOKZOE A1 Pro has a portrait 16:10 panel, add a quirk for it.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..f5c7275cf026 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -179,6 +179,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* AOKZOE A1 Pro */
+		.matches = {
+		 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AOKZOE"),
+		 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AOKZOE A1 Pro"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
 	}, {	/* Asus T100HA */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.51.0



