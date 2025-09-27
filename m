Return-Path: <linux-kernel+bounces-834986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FECBA5F80
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FF41B24A39
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9B2E11AB;
	Sat, 27 Sep 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn1+8nb9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFD2E06ED
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758978168; cv=none; b=Fan4E4OT2H3KEv/6qqjYXB3ubzmLE6kRj7CTv9BLCWtxgiuDhLH15nhuwLjEhJBvBaPvBmXtuh7avJ8384OUrkYzJD2q42Y5T4EgVtff/3/Lx3YlxT4avo411G/nUc+sM9qncFl9QOu77sSPlmawACrxOkPOvBSxA0mGQ3nEvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758978168; c=relaxed/simple;
	bh=BWcvkLYxCQRJV3QWC2hTgs9JKl/lNdwgo/gaMteuaFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=feVe+bSM/9Aub/6I8vWpwVDpx0dd3nDlWcKpQo5SGPvFyQ0IjLDuToWviH7vcorJ7ub0Q8kqTN1wX7Pd5JnKbw/Lcz8aqsfp5MULRZmqCYdHY1NOylZQukhsrZsRkEBj5Crf2K9mUOLKzh0teA12wKlprvpmXPaww28+fpb+1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn1+8nb9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so31427555e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758978164; x=1759582964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5S/zRBKTkSInAQ7R7zklKxxLF5akYgcZwi1P/3w8im8=;
        b=kn1+8nb9OA2gUVRhtgI+6F/iNMiuaiaSPghtVSV4bBzuUodwfLmMu1otmeGh5Ecm9t
         WlxZ20L940vGtQznFm7/FTe6J2momvjsYOj7xWXCmdqW3fW59jKK4EDfLeCZcLyIFXVd
         Ill/kRliF9hUll9VHNhsCrxO8NnFd0xAnMAuyMnfw/ZFvb86uj7O4EoK3ofLyLqZ7FoF
         VyrUBZloam0WzM03sTmPh8qGChrskAd2UZeeuOevM/RP7HAU54LnAF92ImeZawd1d39M
         j0bZVavsuMPhswGaZ5lgzkSldsxaKSNR1hIHdwsWW2UHgabsRsAfLZAaDHblauqsRaGi
         RAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758978164; x=1759582964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S/zRBKTkSInAQ7R7zklKxxLF5akYgcZwi1P/3w8im8=;
        b=e4qPGjwXYZxT25ItSgwRyk2mLGpJZNFzu89BvFdI3DwbrcSGgc8UGCn0f/1YeKRhky
         9djSNgzu+rSaX7pdLBbySn6F5QfRRkF/M0cBro0qgRqVskIywe4VSraYrDY37zs7/PDy
         5m1vD7RmLhzcY7IgmjDF6XsxiSA6rC61RH2UbZbIU4AWYBTxjUuQBwdVJXDQQjjhpq29
         iHSwZSPrtVfTN3dHp6DUiXdKlG2QJTFS8pK+St8TuZm4nqDDPEOBv18myQkq41ApMm1v
         GIdoj/TgMvsVwiflc30jLms0aq9P0uWqc18EqsRbtn2slxTb3Emyz4SSIpiVS1BrAGyr
         ixQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXIGD5t6MwdfcizQkcBVkLN1owXkhsYxAUQ5B+aa1hS4nEpKyF/jANabrySbukt16MMEPRRKxTEdkbTD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4b5ZJdFCTN+k/uJASOcuGS0gJjYoRBJ3d4gYZUaSn94fjL6b
	C71AQxgK0ocAqkv1DYrDvQ8nowBNC27tEQTluQ7t+zJbsUyG1PIbN0TD
X-Gm-Gg: ASbGncuGY9ytGC/flNZGSlgnMP+qirWlHNRdfDsYnec/0Pp22Pl38exI30CEuCKPLF8
	lMGfT4DSk3URXbio7UVuOhZzW+HOeK3tfCa0lPkpinVtBuQo4aaZtBPdqjWHHEKAm40SE2lsUnq
	Mtv5SqSVxkoj0Q2xbsCAchLf2sWFN0iVnooSwaH9e0Grp5kTlP9gtdh7xEm+loX3im4eqVAUWfr
	st7qQsfdI/H1Ip4XO5nDOSp6zGtfqNITf6/8DEDRn5eNlNL3PqNcieKLQixhIhFRNmaOWgUozfe
	2mkgn0lBUTpJkQAF3o60+FBf3ILQzUKHRZZbji+RKvCh3yj7vP9Crx/BVejFezkR6mb8XR20kDU
	QlsMstwV6uRkfiqiVyHNmweiUjTwFs8LkTXC+8A==
X-Google-Smtp-Source: AGHT+IEylPzuTSyMe4S/LKg6ZM9MgQ/hgdwD1nLSuiRnhYfLcu58MW722RoLbdkug9nm8AiwOWmzHg==
X-Received: by 2002:a05:600c:3105:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-46e329e4d87mr104992895e9.18.1758978163470;
        Sat, 27 Sep 2025 06:02:43 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm177274005e9.7.2025.09.27.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:02:43 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH] drm/meson: add support for 2560x1440 resolution output
Date: Sat, 27 Sep 2025 13:02:39 +0000
Message-Id: <20250927130239.825060-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dongjin Kim <tobetter@gmail.com>

Add support for Quad HD (QHD) 2560x1440 resolution output. Timings
have been adapted from the vendor kernel.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index dfe0c28a0f05..f5385b3e3796 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -357,6 +357,8 @@ enum {
 	MESON_VCLK_HDMI_594000,
 /* 2970 /1 /1 /1 /5 /1  => /1 /2 */
 	MESON_VCLK_HDMI_594000_YUV420,
+/* 4830 /2 /1 /2 /5 /1  => /1 /1 */
+	MESON_VCLK_HDMI_241500,
 };
 
 struct meson_vclk_params {
@@ -467,6 +469,18 @@ struct meson_vclk_params {
 		.vid_pll_div = VID_PLL_DIV_5,
 		.vclk_div = 1,
 	},
+	[MESON_VCLK_HDMI_241500] = {
+		.pll_freq = 4830000000,
+		.phy_freq = 2415000000,
+		.venc_freq = 241500000,
+		.vclk_freq = 241500000,
+		.pixel_freq = 241500000,
+		.pll_od1 = 2,
+		.pll_od2 = 1,
+		.pll_od3 = 2,
+		.vid_pll_div = VID_PLL_DIV_5,
+		.vclk_div = 1,
+	},
 	{ /* sentinel */ },
 };
 
@@ -894,6 +908,10 @@ static void meson_vclk_set(struct meson_drm *priv,
 			m = 0xf7;
 			frac = vic_alternate_clock ? 0x8148 : 0x10000;
 			break;
+		case 4830000:
+			m = 0xc9;
+			frac = 0xd560;
+			break;
 		}
 
 		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
-- 
2.34.1


