Return-Path: <linux-kernel+bounces-744178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E3B1091D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6705828FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AE27144B;
	Thu, 24 Jul 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg6MhERP"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D7270EAA;
	Thu, 24 Jul 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356274; cv=none; b=LHEEHvi6h/TWxL9dhh8tSl5MaPibRpJSBqt+CLNiz8z9KmV5PmRrfxZoDU/zWacoFK7mlyfNX6Hd/Lf2+422NmTf7tufX7M+1bmfmIWjYTl/5B7yiI4L9zhHqNHnRZoWiFvJlJwRuXexXeKeVHNc79gHVwnZbbIAaZYRqH5wTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356274; c=relaxed/simple;
	bh=nGT4jidtjk1a8V1xMpQRH51rg2i/WWZ3a0k2WsyOw3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sg9k8avM1x/7RmGjkeucYPqReHCDXiPyvH1ehf9czJnsw04+zW8aTdOgNSVG7yhm28HQoQEvk8isDC7pRlLmgzK2GY3sLPpa79F0jIfG3nRmLJ/HtwU3sffeRHdWmwJaDKMtGst2he0OkHEbMLySxCdGKSoqTj1+XI9qHfIeU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg6MhERP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a53359dea5so442272f8f.0;
        Thu, 24 Jul 2025 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753356271; x=1753961071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/chaQOtrwAc8iUspacpGx3XlnJkksuOlQUkOi3ydoks=;
        b=lg6MhERPRZOiSfkIVkPJ12vCWrICT4pj10CgRvIwqQfGuYelL1wz4s2oCFmXLT8xBh
         kLxDhHWOMy1G+EfZngXA1lDXcCQk/onLKyfcbTx8UvJXMeE7Nkj06ohNQdYgPFpnwrge
         TZiyr0pX86TAzyV15HreTgmk5Zi8dqGCN2mfbyEEb7M3Ay0WB+Z67vNU0h7Cg1njAG/s
         fIkfE1OKoulNdjdaM3O3y9qkcgPE1SdPqMLkHKWb9/5FPn3xXXmXVvA4vkj1z828sdEC
         jDQl5OD/7uXkN9YS84V3BfU+fQc4lwpoSyLBb60ENz9O5L+VtC+zK62xiAlB/JUB4r7i
         bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356271; x=1753961071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/chaQOtrwAc8iUspacpGx3XlnJkksuOlQUkOi3ydoks=;
        b=o5o6Ply0vEgRlFVAU56Ush3LubiPjVODrPOVBJX+Wze6SQaeXVNOhjtC2amJuqCMgT
         lzbak3Zr4GBBW/hGdbn+xG/GgDn2BbgTUYlKmWJKX51jy1c0aUSyZngX00zDrhKok6De
         ZvMHdJrJSNtTI+Wi/umhFc89kqfUlQVqkUvH3hnQBcoBN4bMZbYJ/CTe4daag9ta7mu8
         I5IxmCorrj9YXd6cQHF5/uwpf63NNgp0Xw2Z3opyTqpjyYJ+pkQ/6XjgvluxVA3AWJPq
         EOyZ2CUN/dpPkRqlMOjC7uQiFPpkQ8v8My0Xsg4Dz8t+t83VUkBpfHCpxLI2gPcxOySa
         WdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp7z9QSpQYBlULH7VP6OYT1q5YNGL7kSuPGdyJvBPTwxOIi6a5uA46HbrwpYLKWE6ZFXIlhbmllr7tU1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlHU9FueHVKF2gZNqGggvnHm8WYZU8eUyJ1nXwpVRec49sEb9
	siytyo74OoYlSiXVXOjPCdwSQ5wWTcVxjZDPfzaiLU729Fb3VTaxvMZi
X-Gm-Gg: ASbGncsxRisHPNhKewgzWBpAxTMy6FYRl+zi9TSL/Vc3F+EsH90xNJ79Bce0Xg8k2FG
	qfuKpDUqxCbEwTnVOaHphqL1cOqEWpNjwBE/Htmqccvaf9shC7ER9HAL7tn0N0RFSFt0iufR3D4
	X64bRjVfIOKemc7K7hAMZZ1ddp3kgMBzgRXWlq9vXiq+oMpu5I/09Ubjg8FL54ildeEr3Zmkdz7
	da9ofDosZjHAKClca2kx92avKXyynVid3NPA/BwJo9S8oMaKnNoDVljZMVNRThhj/YUegthc1z2
	Wi72j3010Tgx4Qf3h64O99OcoahsmS193YHb2UAgqZVU38MtpmQiZcdbJeEgjl+5WhOIiCinfGB
	BiUU9f6lcEJUv6lt+uNjT
X-Google-Smtp-Source: AGHT+IGx6vY4OBDv0GI0qirOCTTfwNlLAd70BQpOL4ASVZfSa5T1qQYZyS8mCneRMwPLhBgww6T32g==
X-Received: by 2002:a05:6000:240c:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b768f12c24mr5451850f8f.53.1753356271195;
        Thu, 24 Jul 2025 04:24:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fcad22asm1904963f8f.53.2025.07.24.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:24:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/panel: Kconfig: Fix spelling mistake "pannel" -> "panel"
Date: Thu, 24 Jul 2025 12:23:58 +0100
Message-ID: <20250724112358.142351-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the LEDS_BD2606MVV config. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 09b9f7ff9340..af90ca62e57d 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -971,7 +971,7 @@ config DRM_PANEL_STARTEK_KD070FHFID015
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for STARTEK KD070FHFID015 DSI panel
-	  based on RENESAS-R69429 controller. The pannel is a 7-inch TFT LCD display
+	  based on RENESAS-R69429 controller. The panel is a 7-inch TFT LCD display
 	  with a resolution of 1024 x 600 pixels. It provides a MIPI DSI interface to
 	  the host, a built-in LED backlight and touch controller.
 
-- 
2.50.0


