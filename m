Return-Path: <linux-kernel+bounces-748201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF62B13DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2295C3AB733
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB191F8AC5;
	Mon, 28 Jul 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYQLUoyc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91B1F4C85
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714918; cv=none; b=o/pOPx2hZWevJuN3RFRs6grsIcYHfrRmSli0k4dvWMvoioLLy47/9HeQqvhK1UpBJxWDPNJ9EQVqHh0A+m8sv5KIi2ve2tVaXPaPgrmUMTUQpu3b1ZJBdwLb/oCZa4hC7DNTpZT52Siv9jBRWFvglyYEJXVkHPBLMP92wGIK5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714918; c=relaxed/simple;
	bh=E6X7LXwyJGeUl3qih4crtXIf2NRN3mVvrmZ8QTSHvLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igPIcybPM12Fli+EEH+GIoc7qqkkOU6yyHJsWjFVWQ/vruNKaN8PuVijyPOHtzH/CfEWJbC0b6vvSqT2NnJ5sYGNn7NPlkJiYQHdULvLg+4qLdP920tU0VQC4wHggJ6jUpsYCIQfdUwKsrFu5T9v9UuHbs6wkN4SCRjnDTRIAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYQLUoyc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so51229435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714915; x=1754319715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flhQz+oKLnZT94KLuCojRHNjvO6btRHcQ6GrLs4QzHk=;
        b=AYQLUoycEa9ZLSs1TOwcPx/wBhCxLE3mO7NhsVsK/gyPIMB7r0swuvFSpQuK5Qh2ec
         ppUh2ZWjuOSFEPbQnV7tOLpcFN/L/bE1R2iEwOZv7UKtXZwL3uKhymqSM03NP5mS79rE
         GP0xF9m7+jAQI8jXtrd/HNkeByVwPeQv3w9NLmDohtAOBo5u9kie3QotVN+9QsBsef/d
         us0bb/jYcLE6O4mkxMwGzUZflHyl4l1pcWmu+7zLeFT2pF4Ekbc5Pn8JO1afPkG0tMxH
         1fJSdll2Kkn5oUf07HPdrku32KqjCiwlPXcKrrpwl0b9A3WU28elFuWYq2wAx7wBlTkZ
         dp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714915; x=1754319715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flhQz+oKLnZT94KLuCojRHNjvO6btRHcQ6GrLs4QzHk=;
        b=c8jcL3rOQNQeFkFQdga35UmqY5PfxhHGYKZqYUWmewaUrQG935ZYaQDzwL8PkkYyFt
         SJ5/Qs9Blk1IbOO4Qw13Ik2M9wkEFj5TyZJE678fyBLjBsz1EO0eJp0Vry1JRZQr1vZ6
         1Xqgj6zbJS2UZUdC1JKpN0+/nlcf0LJxmZGkmFgye4R6EquCRjG9T7xtjQ2WvhNXrKid
         jp+RkAvXLo3mRo+Q6c8XVZG5ScLbZ6CfLwNyd0RiZB+/7gK3/Ca0v0ovElOi3aUI2G/r
         WMwg3CVSDoHj3//ndZb9a1cpGvo88L7v/rPgdXjN3X54FsTBJYci+nddq205drhEaybr
         38zw==
X-Forwarded-Encrypted: i=1; AJvYcCXpM9wdy1dE/X+MlZihxBDYGE9TtS8JBa5Kgxv26W712HIkd/2XCWiPeGFB8/D478mRSm/CDzeZ3CqzXe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKcLTXlYQ5LdrKsaJ7634a/u9Gd8ecb1k0PMVSf0tVc5ZBmQZ
	4ebHMu9WfQ0X/R3mWMxLH03C/XNhEK2uNtipZ/gHtllXkPR15tAwQY8/
X-Gm-Gg: ASbGnctWmlRUVIBhZ/77EcOXQq+/0JZpKRAtlIHYYJ6OKmShoflPOp/FTmiX4OFyK58
	Lstmm6EQzqmtu04LZg3mlK5AWyo0SWHgUNZhuPvO5KvMLo0YoPkGh6gfaEaYTJSonbbUgAfzYwZ
	8v9Sw0uu1lYlvaZZhpKr3NYOLVjPwU3i81ba0TALm9xF3ssYwnjx5p7XYqUT9r17snY9XeFiYjk
	zmMal8YtofRr1Z/Y+o38p0Fl4PHFf0pnbQ51yUOoW37exoiJNK8eYchwzwduEMPiCcCL93efnY0
	X/asSta7gQZdk2jV70ULyKdCa6EqXuY8GceTZHkEhFTeEebMSbAqmqkkaXThqVd5fszfZ0dwmKE
	g3QYOnOXvESDo3Qhyw2pMHuaoD3K9A3xkbpKgydbPtjWCcWmOgpinNcoeypk2B8GM74WXjKa1fY
	jBohMgTbv/krJokPsoKuWs1/vq
X-Google-Smtp-Source: AGHT+IGZdP8e3c/rD63Cm6B4McS6Zx6BBew5GRV14fuATFodAREoxJWCcZE+w7O/EVkJ+OGcfwpBZw==
X-Received: by 2002:a05:600c:3ace:b0:456:1611:ce85 with SMTP id 5b1f17b1804b1-45876549d0dmr93503725e9.21.1753714914738;
        Mon, 28 Jul 2025 08:01:54 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc2798sm102590355e9.7.2025.07.28.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:01:54 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Adrien Grassein <adrien.grassein@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Date: Mon, 28 Jul 2025 17:00:50 +0200
Message-ID: <20250728150059.2642055-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

The datasheet of lontium-lt8912b doesn't require blanking during
the HFP period. Thus use LP during HFP.

Tested with a samsung-dsim (i.MX8 MM) and a tc358768 DPI to DSI bridge
as the DSI host.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 3e49d855b364..760d89493276 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -494,6 +494,7 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
 			  MIPI_DSI_MODE_LPM |
+			  MIPI_DSI_MODE_VIDEO_NO_HFP |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-- 
2.42.0


