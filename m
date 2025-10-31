Return-Path: <linux-kernel+bounces-880802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A42C26990
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F831894ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86412EA176;
	Fri, 31 Oct 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9kCMXcW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11E1A0BD6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935723; cv=none; b=i8COgkbyMNjGUzQyErwSczKL5n+xvFhv0l0VOr6XLdgWcxEtdx8PG8qOdq43zSF0w6juV/ePnK0g1ryomNtHO6IppfgRghc/Tg0kipGQuenDQgt8Q/LkX1vg0ZHjRopDwyM+KsyEp1Os438GFD+zwX60e3Uq1QzN++nmsdiiWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935723; c=relaxed/simple;
	bh=c/8/+M653DTwkbqwhYjF1shgjzt0LxyKcM/hKbSTXvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6v7jTUyhMT9IvHFhiagCs99d+msdKIIQ7CrFmGYIQuE1bFJ1uHi/ogQLiBxupdSQDbvyNal+2NiO/umkoK5SQfsADeDuEKu0vgl0ZIWPkjnHt3xN9rGDjnY8sjFe6SpJhPBMWIGL2uZSJ9biWBq4LG4zSexYw9RS5ioCd3Bq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9kCMXcW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4270491e9easo2217031f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761935719; x=1762540519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iT0A4z5+5/yx9fDx0U3h5AA6nOCS4tUDygSaOHDUAWo=;
        b=P9kCMXcW0hHS8Wta23iW1z0HVYDa7H4WGe5dxypdsZigT1YiNzX1lb1aoevcngox0Q
         JAJqaygCL0h2jr0B7v3D6sbCtu6kyEV1nkNttUf1tEryobLwvPuwM3h/aT8ouPQfnOWV
         8k+FDvXs3uaSDzmRFh05S0AfBeRnurDl2HByrwELS1V3LME3GjleEXFq6EcqtVNzjCBK
         TOcAj4ZhVOu2r5NMZ5yf37U+KIAtn5JrNL7YQZZ8/F8MEs29H3HqeVBSkR1EE3jGsSfl
         T9iiqQ8Pp5BE6jCrCCwhoxmmF5wANU/wXotv/yU8vqlYjSPgIpWYrB24MMoXs5tp/b5v
         eNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935719; x=1762540519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT0A4z5+5/yx9fDx0U3h5AA6nOCS4tUDygSaOHDUAWo=;
        b=L+Lu38EB4gqhqUu3LYLxY23dlCa+O5UWlRuE7GhTtzY2VnOjtcbCD1lennDBCdlugX
         gd1WdABo+Mf7s/kqDPdoDHBmHNY539FzwG1BxpgnrjXVPdzZJcYAG8dCbCiGxwSFfMNA
         9L6UuYDBBDN7MaOqlRYMv2pCUBXfnQNGvxtCYalMP872PZKdHHPlYsLZfMfzv3IH43rM
         2bAVBVh+wMufgj1vjfsYhuk86QIL+0KpUCxUgSXQN/W4Q9WRdc2SWzegpkf9S6LeCjJD
         71LEnIViq7jCErRbtwjYk5IFKM2C1vy+urFygFEp+BEUwopzqIuOb1k0Kb95nl8o4xrz
         RGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZiAfe2bx970aZF4SrdnZQmIe0MFHnv0iCsf5822Lm3E1p5kliMBgWXUtlAq2uJtFVXUVCwqF7edhaG6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpUkOApnNqYb1oS+igjo2OCnYjYT4GTLyeUFbIvpOcZmsD4Cc
	NQnNaTTKRAzfwHtG9ysizo1U/RHsqSFiimEQxaaDen6ojImHETgpKnCG
X-Gm-Gg: ASbGnctEUiLZ85B1NaxI0DNESIvrtyAlVh3XP0D2fS5CUsA39sy8ERfGe8b378uXFB8
	VJbtzpQTBMYf+wQ+9+0vpfHyxv+4U8Bdp2oE2o1YhdqguGAzj4pv91WgoD+4Cif2GFQw3zwV0qO
	EWRyQ+lnoTVE8Anbe2FsKQvtWHUf5Blsav5e3GJ0LpJVO2WyN+BMTnHZAFJZeVGgiIQeIVP7CvH
	gwgL9mgO9BpqjcV8HDZd/YufhfbFrNYTrYyFnPIzk7jI0KBBK+SWXUoL1r5huk+57qIz0q5cJnM
	8h8u+3IEGChDdF4dchwsVIkGvXAz1XCKeG2JjsW6eskotX442iuLimyby6Ts3smcLsE1eTQut7b
	52RbWkqF17Qr+REWIBuBGOM52p/VZXtZUpHMlpy3GX0ErWqXpoo6PGCf9/X8oI0ioH+zNp/hUka
	jQ57qyQs06R8Zqja4m8eKWOX8D0GGI4JUWz8Vu
X-Google-Smtp-Source: AGHT+IGR/czOBAwcuGk1imiVf5VtUQXEd72fFzraprg+CV+Rs7Bpkn9+8+cZs/cHVjNqRJkrMp4OXA==
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429bd6ece4bmr4950485f8f.61.1761935719136;
        Fri, 31 Oct 2025 11:35:19 -0700 (PDT)
Received: from pluto.ws.lan (linux.karinthy.hu. [195.199.149.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1125ad0sm4886991f8f.13.2025.10.31.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 11:35:18 -0700 (PDT)
From: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
Subject: [PATCH] ALSA: line6: add support for POD HD Pro X
Date: Fri, 31 Oct 2025 19:35:14 +0100
Message-ID: <20251031183514.40926-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It uses the same protocol as other POD HD models so it just needed
proper config.

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---
 sound/usb/line6/podhd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 70de08635f54..ea1324c22f46 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -26,7 +26,8 @@ enum {
 	LINE6_PODX3,
 	LINE6_PODX3LIVE,
 	LINE6_PODHD500X,
-	LINE6_PODHDDESKTOP
+	LINE6_PODHDDESKTOP,
+	LINE6_PODHDPROX,
 };
 
 struct usb_line6_podhd {
@@ -440,6 +441,7 @@ static const struct usb_device_id podhd_id_table[] = {
 	{ LINE6_IF_NUM(0x414B, 0), .driver_info = LINE6_PODX3LIVE },
 	{ LINE6_IF_NUM(0x4159, 0), .driver_info = LINE6_PODHD500X },
 	{ LINE6_IF_NUM(0x4156, 0), .driver_info = LINE6_PODHDDESKTOP },
+	{ LINE6_IF_NUM(0x415A, 0), .driver_info = LINE6_PODHDPROX },
 	{}
 };
 
@@ -528,6 +530,18 @@ static const struct line6_properties podhd_properties_table[] = {
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
+	[LINE6_PODHDPROX] = {
+		.id = "PODHDPROX",
+		.name = "POD HD Pro X",
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_CONTROL_INFO
+				| LINE6_CAP_PCM | LINE6_CAP_HWMON | LINE6_CAP_IN_NEEDS_OUT,
+		.altsetting = 1,
+		.ctrl_if = 1,
+		.ep_ctrl_r = 0x81,
+		.ep_ctrl_w = 0x01,
+		.ep_audio_r = 0x86,
+		.ep_audio_w = 0x02,
+	},
 };
 
 /*
-- 
2.51.2


