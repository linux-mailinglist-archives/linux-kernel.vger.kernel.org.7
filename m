Return-Path: <linux-kernel+bounces-819014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5FAB59A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86781177663
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C03081BB;
	Tue, 16 Sep 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLtdruPi"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2E28C84F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032532; cv=none; b=UJF/+MN9YVImoeVVwel23iLHwLh21vLc3E7gP/aGzF4y4VFjBRhLuaVrG861W9yDdM9mHq16Y5mqDPcVR0bl5xC5oWrPEbmmDO4w2qkXd4P9EsHQFwy6jlyFQp2UoZ4MmUB4qZ3k///eij5y+/BLY8s5mPjzXchwYDmqgPDB75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032532; c=relaxed/simple;
	bh=S16ECLvytyLmOv2TFGMROw+zdnonrMQxJZVeq+GI71U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvNxwxq/wKwTID5Xy3kog6QyTyAtDQ1TYCdvUXHoq8bZzvpu/j2e7VftSYjHyNNshCankBYSzlfAX+iX0iqcVi8Vq6nywr4sZ7VbPvVP3vPMyKyjFUCtDcfPqvc7W+ugw1v3WJvCD0MZcoIphu5NjtzUNiuwTztoYC2d0yAQuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLtdruPi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1517713f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032529; x=1758637329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pl1jcFzXvRWCuO/5MhdLryyBckGIL24XMYEjQYGJmG0=;
        b=XLtdruPi07bATKjGB7WBmahu9AXObkmiq8xWhkmB7qS1u1kL+Ksuynkxp/lnqrDf1U
         zokSqdx0e7PmItaWHJ3VFToab/B3JfV/tgDkG4NzX7Yd+09Frv8rrhLpK6MFxlTiJt9e
         kZJSi7oD5MmAHIVD485CnVhfPeySVMaiNtkPXw1quWBbCRgcX2FDDY5Bhq90I+1yKp2v
         pnn2UeXTbBRAzpiAl8ACW5c88OgyCLKN3jA8Gkxh0U9NNLOpJolgA13CLla/66wxtDJW
         CNIvw3Ez4/H+2rugt+mIrsscx/4yhw9Ltzv3200BStNZN7AzjLe4faEPam8rRCNGbt2M
         YqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032529; x=1758637329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pl1jcFzXvRWCuO/5MhdLryyBckGIL24XMYEjQYGJmG0=;
        b=TjhZica6g4A9n0pj/i6rC8VPs7s/LC+Vdyk8Ijd8FIEBioKWvXuVQVQDWuoXjuuc2c
         ymljt0AGbE/U3+D4yDvTiFPKwKbUEJeeVOE9HcQ1glRqz528L8rCVSQ3Q9kuZdjRYsFl
         a+PIeZdYUO/Dusv/94Q5x8Mp2HTFlT/Cz1W59qVYCAKsj26ts9CKL2/FOJHiPKq9YVt2
         RE64JDge+Q2JhS3z91tHgIDQ46jzzgwFBTKK/SVQfQ1yc3rSqoERhQPmEK9tpZ5TjsaE
         PC4Gg44N4NNgbrLRYytAkFFAsBJcPMwtGgXcgt+zalgVOnybChYjDmF/8rGruo6Lo8Qr
         vxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvRxz8aI/KMhYYdQ/KQGOnKVf9ALdCdQQomKkQMyIuZ9Isnin2fADWu2LgfIxFEdqlUNAW9xHy6TGCF9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GCvejAKr2XgoFa5fFMKaHiylrNO7e7Rggbwci4f3BTARSyhe
	DFODRxIn/IdPbIY4LkZ82HHKUH2gWzGnzxsJo+mT87nSQjB/e/pSyA1X
X-Gm-Gg: ASbGncuqvi8Pnj/UoqDFozlUw5owhbKOqLQMn3DCBSC8f5NEvDqO5lJuilPTstKAo1+
	QLhypfalsoGNmG3VHcWRcpUn8PWfxK7EsxAri4T3P23XVLzC1RHYvslNYPnO9CE6Mllq5NaAMtt
	sW6pAfYc9tFLMBTmgvU6kt0v8t5iXhbR4iDjPPoAxgYkBdE5fjaNGuztbXXZAITN7OHKBQrXC7P
	Lf8yv8a0Zzr8IxRp02pdN7YrGoa1pr5WXH512Y8JAowIu4w50UES5oZ65Pb6A1FM3JIr9dRo2mU
	x7J99nP75hlXELjwi1Cg3vi4CZTqB+vhOwN13O+fkrbbVQ/TMNI4v2qp0otCug7nIe0gzXaYQoY
	dRPBMFTfNiCHEaFYVaHnjTyp1C1cItG0UwXYwG6mfor+c4eeBGBbtd6MD8JVtn3aP2Gd0vee1GT
	PrXmtsoGhaOhzejgPAUKruvgTXwIuFcuAEtp909w==
X-Google-Smtp-Source: AGHT+IEfo6dIZQgb+2KQqBaq9k8zgeodNBoQBmoTlSmN4T18NxGs2JJXZCHspCns20/kog8GcmY8rQ==
X-Received: by 2002:a05:6000:3112:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-3eae0fd2e16mr6354578f8f.12.1758032528799;
        Tue, 16 Sep 2025 07:22:08 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm225090165e9.19.2025.09.16.07.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:22:07 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: 
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/bridge: ti-sn65dsi86: Transition to LP mode on every video line
Date: Tue, 16 Sep 2025 16:20:43 +0200
Message-ID: <20250916142047.3582018-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The component datasheet recommends, to reduce power consumption,
transitioning to LP mode on every video line.

Enable the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
flags so that the bridge can enter LP mode during the horizontal front
porch and back porch periods.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Jayesh Choudhary <j-choudhary@ti.com>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ae0d08e5e960..957e9abd46c3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -689,7 +689,8 @@ static int ti_sn_attach_host(struct auxiliary_device *adev, struct ti_sn65dsi86
 	/* TODO: setting to 4 MIPI lanes always for now */
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HFP |
+			  MIPI_DSI_MODE_VIDEO_NO_HBP;
 
 	/* check if continuous dsi clock is required or not */
 	pm_runtime_get_sync(dev);
-- 
2.43.0


