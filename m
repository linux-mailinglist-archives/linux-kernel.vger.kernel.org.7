Return-Path: <linux-kernel+bounces-741500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF0B0E50C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A0A60EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C86285055;
	Tue, 22 Jul 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqUNi78L"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5D4C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216880; cv=none; b=D6TrE/6YEUoiZA/v7K+95WYoCugyeT8Lz0qotLKpULEmyVZhs8eHLoR7dzQZr2eap5f0L2vLZduAeyl3PgqYhks0KNvYmSZWtSyMRmPrl/uZ0zsx7GAqmVA9qfamaHSsrlxQ0QLlScUIK9DroVW6AFASVCJt6u7BubbbMx5TzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216880; c=relaxed/simple;
	bh=DegX5qJOv41QFi3cp+Rs2Sr8JQKqdwpLZKVW0Gff8xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+IxfxOkI4wd2aN0Km2XL/IXJM4etaMX0SD6dkx6LciXTJh95rqWT7u065MoQqjNIsyH47k48tQauKf3QopN1g3yAspNQ1rptAafN2rmQImnAKWpB5jLEbq3tFsVrLxHhHUnV7ItxOP/W5OZUlWbv0VJphVFQ7lLW9rxXxfiPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqUNi78L; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab1abfe312so5554591cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216878; x=1753821678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXq9JEdSpTNYsbXVDMrXQnV1WYKVqKwb2I/usPEuLyw=;
        b=TqUNi78LTyhGw3lw+zo23XMFRZ8kFMooOGcHTu/MEbtFc+NPGScJyhSVOa69l495dN
         CAtJvZ2oavuUnCmYiD0AO+KA591X/EUO88DrcjiqH0ytZGrirYaOTUdYJW58m0HIF3Xh
         Kg/cPxiSOjcAU2nvPiNRJy2gBFYKb5wYL/+yJdRINF0YhskAkwCXUdjdzz3FR5ATlGje
         hjj5/q5e/sakNH9R0K2W6TY81rMiSvYI3JitI6paGsQER6CT44IJZkTEA38ff1p9IJNt
         CXoMtX2eITG2B/VV7QlBKjBC2hsy99kSm1v5kHGHE6lwWZE7cM4hmfNKzwwOikL7chJc
         mHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216878; x=1753821678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXq9JEdSpTNYsbXVDMrXQnV1WYKVqKwb2I/usPEuLyw=;
        b=k8jlEsVt+z2IeEyVKa/okX9efj1e3JHKOgxhEEqOIRKunDqlobm9oTaq3Hz6L7mBwD
         1NsxbvdmuPIGlVgJ8Ncqa9nRhsrvr7jHtkdYYpWJLe65cyPdbguSMLd+UUamVZhgB8m3
         k9hJ1eimVo/5jClxVX2QKs1dJALg0v/CJ3fRXg9GuIO9jAiMXn3RrT2dnZ+XCvoecYEA
         VWEz0b9PalQNTgywQLyUPUAz6BTHhmXg2iVqWZ7C/PidjDbBGW0odXK0hXpTll/3xgHv
         FZ95ee2VZKWQymackrutipPwlQWGC24RPngfznNNLm9VObRPwNQy27e1y3BNIAuBIzqs
         ibEA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0rU3UcZy9/kgJ3ZbAhnSg47rf9pYGGzAqESkFbRbnNUDUZlYtvtYmdZ7fILVvCf/KdLZEQBTrJRVGQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GB5DzT05y6B1wDHx1mvPGUPdkUoV13H63vrEUJd9GyLZgD4z
	uesS/XK1cTPp1NdgJmHcMrFA1LMx4Y2WmG5fA5TUaV9HxAomEeOcPsA=
X-Gm-Gg: ASbGncvAu7FtT7x6xo0Gc1DNf+x9kD8y1rXAapgu0guj8E/hhMbixkd/9nBtXZkGXA3
	dhXNmCwxGTNLPM1H5hoAIdGp4G5Fk0NN3SmV5KThSwp3q/TE/eTLDKhTgN7RonjzLDMHw/WOhKE
	c/RC8vx+PY/OSLhSChppMT6FmrPFRgLF4olI2qoNhp4CyzIWY//ixpFdliRBXZHMYY7g39t8RW1
	rbgDfciQCyxKhNSagkRXyB/InkG63CPeuFfhYkiHuctQjRdcWg/kY5s6e6w0c7AlXA8NK6YhMyI
	OpUxWx6VcGrPUApB+jW8zICT9kJ240GI2oV5tJStg8lmof1seo1IptIjMJhE3v7v6at4asMFLLy
	k/oMsi5QBvv+XrEm2NGs=
X-Google-Smtp-Source: AGHT+IHtZaKvEyIurde8xJ3eQSeb2I48u/E6ukWHBWmaIivtcdRbkJOIi/7FYe5C8jeqXQD86GncJg==
X-Received: by 2002:a05:620a:d82:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7e62a175e06mr43641185a.13.1753216878034;
        Tue, 22 Jul 2025 13:41:18 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6236d24dcsm101072285a.30.2025.07.22.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:41:17 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: victor.liu@nxp.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] drm/bridge: Add null pointer check for ITE IT6263
Date: Tue, 22 Jul 2025 15:41:14 -0500
Message-Id: <20250722204114.3340516-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_atomic_get_new_connector_for_encoder and
drm_atomic_get_new_connector_state could return Null.
Thus, add the null pointer check for them with a similar format with
it6505_bridge_atomic_enable in ITE IT6505.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 049723628716 ("drm/bridge: Add ITE IT6263 LVDS to HDMI converter")
---
 drivers/gpu/drm/bridge/ite-it6263.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index a3a63a977b0a..3a20b2088bf9 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -590,15 +590,28 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector *connector;
 	bool is_stable = false;
 	struct drm_crtc *crtc;
+	struct drm_connector_state *conn_state;
 	unsigned int val;
 	bool pclk_high;
 	int i, ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
-	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	if (WARN_ON(!connector))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc = conn_state->crtc;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
 	mode = &crtc_state->adjusted_mode;
+	if (WARN_ON(!mode))
+		return;
 
 	regmap_write(regmap, HDMI_REG_HDMI_MODE, TX_HDMI_MODE);
 
-- 
2.34.1


