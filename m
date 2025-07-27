Return-Path: <linux-kernel+bounces-747189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A8B130D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9837A2614
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E0221D96;
	Sun, 27 Jul 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPeX5OmP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1A21FF24;
	Sun, 27 Jul 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635537; cv=none; b=tFIANy/mPiL52ntXizxDrXA7ept1+mcwXrT/g5JzfDV4hvSRVh/ZyW3+k4iXWjyYLWUvQjiygtXVT+9WYHyy7bB6TOYWso4llGnv9CWpGxZE/7jK99mjSMCDU3U40c6VrQGyKaQJSf56MnfIW4PJ/eIg+TJwjQ1usmJbaY1k+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635537; c=relaxed/simple;
	bh=xaIfMyoNbRF5NRFYE39P0X2AyUjoGgarwnnpBy9mcYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLXs/IBqCRMmUSq3svRwTo8iIHf5yX5eIMSWAQgy6sr6N1KkVTIKh9VzzuY3NXVE6eQ+GVgcdUFoCyx9DMKNmb2tAg4E3x3Ts3xkJ+GYMgcKhCrZG46gz4TKavO+BBpFiDpx5X5BipEswuRgg0e0Ufulpc58mF5KKQOcfWypPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPeX5OmP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4563a57f947so18843275e9.1;
        Sun, 27 Jul 2025 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753635534; x=1754240334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF78n2GJo9Ljh6+9I+QrDrhKqgr6XnFmnArJPBP8sdQ=;
        b=bPeX5OmPOvOePf9rLuWcH7mwHw1gBRlVOmGTMBiq/9zuKT57U/LjgDHnynAVlE15Ss
         jt33l4v5ZXxaje1R4Ql8xvgGjuJnppZOidRra+loXn4RJIVvfTBaWlt5zAkm6W1YXV5w
         aUVVYRaoAzJPTc96ghAePlOox3FeUeDvKwDQ13WwCd6UyQXD/70gRITgnDJRwjIoNPJi
         ik28bLr2J85mY1G+tblBq2PkDxgTth+MjGziHrLbMmPWE0cQtjgb3Q2FqsLeQmGY40oR
         +pgHfZj7PGEE0pRlbvUOQQA82ejhvoe60XgfcAIlvaUlw4Vf1aAV0T02RM9iHjuRyDDC
         XuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753635534; x=1754240334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF78n2GJo9Ljh6+9I+QrDrhKqgr6XnFmnArJPBP8sdQ=;
        b=doVHcqPqrghb7+PqSbb9SIfJr2HGMkb9kfERNKeNrdCSzXlCpIsHDY7NjkN5Skz37J
         pjmzidIbGYwlFG2mW1WryhQ7CW7T5AuHYU1gXMN/l6idtaaPmw/vaWveTKYcTNN3zpkG
         lOKzjmCiCee8xJjWD7TLc8OC/EEHhsicOR+6jyyWQjIWAydFvsRnckPQaIWZnkDjjtf1
         hK5y6uvNVdDw08CiPoRFbDhM+osV/FgT3oyBG3ETxMyrR4uGmJvMNl1CJ5x1K9ftiYU4
         ZTitGm8YSQ5Am6V8/KqRUW9zWS/CVnUd25ArBebNh/XXyS6pWPmVANvKNYfbt348lQ8k
         CCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU43QxuGTpsYfrgJ9aTkKRVRcgq2BABuXZqPKGjEZ475EI7LM9dVFeyYOMb+W85AOPAUOAYXKpleSpC@vger.kernel.org, AJvYcCUPQHEkPAPJJE+g+zXEll0Ntv8OsEtquU4pN8NCj2R5tIAyLVcOlJf+RE7BzMUlQcCOpIu8v5t0MZXZsR39@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnS6iEf0lOL7roLImc1pzphdAd6vQ8QHSldV2SyQdlX36Yxot
	a6kdxAxRTxYYmATOm2+q0OuBy32ZETK4OiDiitJR2OqA0QKZNhW0KXE=
X-Gm-Gg: ASbGncuN7LlNjDr1PPFWJKB3AcML/EQBZ1VDFH7lOIfZ7RYzbat1nLRFhU37ejpG6zC
	V7vB8QKluj3KT14gjmSScgEJn2cv7VSYPjIBjEKfQ38aAGaA7MLAxRJNiYgdyHg2iU9she3hg4l
	nxmImYT5If1TWZv/cV9RDl2u/xXKmp0uUAJGJthiLHflhJIOg4n2S/M+04lUQQBzilZQggNAI4O
	+fdQ+/36AxU4hr5tUyN7TuQOn3qDQ9sXF8jvxYsInX6rWrifDQsqbl2OdR1lJkXPnSDXnQ+QcPm
	hO5XL6BBZ5zNriTPvRSCcDyDjZWGDgHXceDkDXG1IuqmJvCzff+yd9/3OaM8yTVFJ+5qURieJC0
	yTCtnG47FFG+q5M0UEsqpIqsAf6DkX4UI58uN/f7EQR8gDrFAgfE=
X-Google-Smtp-Source: AGHT+IGsriUGTQtFk3WMLf3zlohLZapyUEGO2OTMkwMcic2kFu7BspA2oGNvKvQ6RBaXAmNsq62AXg==
X-Received: by 2002:a05:600c:a405:b0:455:efd7:17dc with SMTP id 5b1f17b1804b1-4587c8283c1mr36053445e9.11.1753635534149;
        Sun, 27 Jul 2025 09:58:54 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704aaf20sm128545745e9.0.2025.07.27.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:58:53 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 3/3] drm/panel-edp: Add BOE NV140WUM-N64
Date: Sun, 27 Jul 2025 18:50:26 +0200
Message-ID: <20250727165846.38186-4-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250727165846.38186-1-alex.vinarskis@gmail.com>
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
eg. Asus Zenbook A14 UX3407QA.

The raw edid of the panel is:
00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8

70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9a56e208cbdd..b334926e96ed 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e50_p2e80, "NV140WUM-N64"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
 
-- 
2.48.1


