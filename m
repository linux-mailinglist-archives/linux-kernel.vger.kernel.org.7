Return-Path: <linux-kernel+bounces-797454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB2B410A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FB57A213B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93127C84B;
	Tue,  2 Sep 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJqzuQpz"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E91E9905
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855130; cv=none; b=pQ8igi1jgdhLQlGwwoR93964zkFW0rWmq30Fh6OM5lIYUDkXxsZ+aXWNIOn6MaK78pTxGFuw+c2wHRXFzXFjSXUEgmqJPUx4cfDaTT2GHj8+QrrCYdRCfmG1lofAlwc8vTeHfP45tg9Wwe7WSK1HLaxGx1egc/N0dK4A22GZ1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855130; c=relaxed/simple;
	bh=fP54wN+Z33t7XodUCLKoljSKevxf2tpbesKp1WuSYGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6kO/7fzbhMl62Hcms03k6LkxDgvppjQK8RPFvs/tCYrohQotYa3mOvcjfpPMUnOw3einH1TG118sRf9dUpMO2AN4EH1huNwanmalKy5zlgFZnw4yzvqIQMhOn3MovshVaWBtT2AOYR7RMUnMCe/N/WtdpWWwmCnhkb0pfvqvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJqzuQpz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-56088927dcbso805341e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756855126; x=1757459926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57uob1tKUp9bRNlgzldDqsGEaBj3KVp0Z4MB+bZXeZA=;
        b=iJqzuQpzsRZhCbv/ZgNSA30Orhx8eFKAw9FJgkM2jg4k9dVtqKv8V9z7TwFzMulOK+
         oO+pxZrcnCYafyGwLJny4q7QLQUWXt6wHt/BWwqIGYj6xI+qiuaBd0TY26qHycciymdA
         ir1X1qk4YIjz6CCklzUeIhpIY5bK8c449rZO0tfpzZEKzJYhqf/ox8GEW5dpA/jCL/6/
         pFPK9IZVd6P4pjlzVa14ES0bT427S/9JRI3UxlRZmX8Tih6gGjbpf1H46RUkBY5mYgr9
         TpKg17Wf5LRx37b233cOM61oJG4EajBGhU6/uM7U3oBs1c0pQUIU+H8nUIHvCA98tU1n
         1M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756855126; x=1757459926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57uob1tKUp9bRNlgzldDqsGEaBj3KVp0Z4MB+bZXeZA=;
        b=pi21GnmWEGsG4rlUzxVuX3f6EeEGZj+gBLYU+hsQl9y5PF9einYKHDY9brNqMxGCNP
         saWoz1q3RcEuHUCKUeYpBvKZGyllcT/goQdUy2hhtSh8fV4QfbcBtLLuZXC1epl5GM8t
         SzoEo7ao2ERKz6GU/a9R3EYiStDwXZGkIyXjK4R+GEO5V03UiV+N5rdp3BNANzX4OFTa
         XoJdPVVVv6mz0xG3Px/G4I1ERzhryFytriQhaep/li4jT6J/lPCKfZrKWMZV4mqbweVW
         Qz3OOcFWl2iJuz6MpPgtsMwbM7oMWvxxDLo//ZrmLZUcM3s8fbwOAHLSqHmIvBvcxWht
         r6vg==
X-Forwarded-Encrypted: i=1; AJvYcCV499gHuZ6up0HKqjR6TEn/U1ZrEfjOAbuXlN/yGsxo4q+TyW5/t/x/8niKjoXZG/vzzlutvAdtmbB5Egk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HOOI6aGZR/TynT1cTbDS6ohD704NLg3OtCAyh4CfjGzVjYx3
	CPeu1+4Y/X52x/xTIxnHDU7I7U8fbUkWsD0j/kcGyVf010Vm3d2bzFH1
X-Gm-Gg: ASbGncvKIpi4nE7mHw/mQAStlWaBSIv5/wW3uzIi5648SWYmal87Srg/EMEExTmcofz
	EOflKPasYPtdrheswy9dnmIgt1/3uiM3kMV0iFubspP3zSChi7myyUnYTAyWHP/nCv2Kku+Zudn
	IbdBg0/Oi2LLBoIZb1ry5UBU/jZ3ExNiFQLmbYlpoaFCKsnKGMC/YSF33608qWG66XLOodRm1oI
	8N7xX4YJeAjK8VDGDEAyMWygrEyoEcdg3SGSioT/echysEOXyFCMf+6qEZ72bN8DfRaDlSSIMkY
	A8SuVW6bqhkT8rPOtDXE0TMzaz8+71dz19JyRl2mbEdjuIS6XnWH72/x0XPWE+Jy4lZD0KbOEtk
	Wim8GnCavyMgBs5GIhrKdh8LUTtb55t3nHwgfZZawUao=
X-Google-Smtp-Source: AGHT+IFbJzWKmetRFMXIkEH7qeGXDj5AWVLSRsL0DnbS0JU+NFcr2mAVAEpsT7CruW23S4r38RAN6A==
X-Received: by 2002:a05:6512:252a:b0:55f:6964:821d with SMTP id 2adb3069b0e04-55f708d312emr3844144e87.22.1756855126277;
        Tue, 02 Sep 2025 16:18:46 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab5e281sm105674e87.18.2025.09.02.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:18:45 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH] drm/bridge: lontium-lt9611uxc: start wake all thread when call detect()
Date: Wed,  3 Sep 2025 02:18:19 +0300
Message-Id: <20250902231821.2943-2-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902231821.2943-1-vovchkir@gmail.com>
References: <20250902231821.2943-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip does not receive an interrupt if the monitor was connected
before powering up.
Therefore, you need to wake up the task if the necessary bits are set
when calling bridge_detect() after DRM is started.

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 748bed8acd2d..5051cdfe2fee 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -358,17 +358,24 @@ static enum drm_connector_status lt9611uxc_bridge_detect(struct drm_bridge *brid
 	unsigned int reg_val = 0;
 	int ret;
 	bool connected = true;
+	bool edid_read = true;
 
 	lt9611uxc_lock(lt9611uxc);
 
 	if (lt9611uxc->hpd_supported) {
 		ret = regmap_read(lt9611uxc->regmap, 0xb023, &reg_val);
 
-		if (ret)
+		if (ret) {
 			dev_err(lt9611uxc->dev, "failed to read hpd status: %d\n", ret);
-		else
+		} else {
+			dev_dbg(lt9611uxc->dev, "detect() reg[0xb023]=0x%02X\n", reg_val);
 			connected  = reg_val & BIT(1);
+			edid_read = reg_val & BIT(0);
+			if (edid_read)
+				wake_up_all(&lt9611uxc->wq);
+		}
 	}
+	lt9611uxc->edid_read = edid_read;
 	lt9611uxc->hdmi_connected = connected;
 
 	lt9611uxc_unlock(lt9611uxc);
-- 
2.34.1


