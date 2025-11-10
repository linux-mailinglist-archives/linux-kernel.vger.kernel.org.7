Return-Path: <linux-kernel+bounces-892667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82753C45949
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25CFA4E9DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C730215F;
	Mon, 10 Nov 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9PhwnKG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD81301031
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766135; cv=none; b=QXJ6rlCS/JwtDc3KTMbJ5VrsZNzDlzQFn2fVwn5P0VxSZeUSnhVRQJc9KoQea/1GuT3HaJwTPL5IRVOi7htuKx+fE8EI2i7M2eapwanLu9+VEtekJDuwfmwc7wwh7f/w/yoMwY7y6tfCZH9HfkZIhyNVSdYD6dEC3oqZW5H9hRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766135; c=relaxed/simple;
	bh=459dlBPh3LInR8NOH/R4UDIusnkt1kveYPqleYn7ivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSrd3GxDeE3xtcq4SyjMKkDNNFej0QN0+q30FE8VZHdfB1JM3iDiqPqUqUhbRRfYty4SAA91H29he2ojI6Q90zC7tTnjVvlLj8/n5RhiMVLT7IpgipRUu/urlVXkAQmD4PNnVrIuhTXq/7Pqs3h3Rv6VWoMzXdl96abdUbGKLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9PhwnKG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59457f79859so3036198e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762766131; x=1763370931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+a5/f/Fx6IMBMc0auLZUB4h0ES81R10KOuZfrxfUU8=;
        b=h9PhwnKGqK8eooZcjVt/bP7w6Cn6tMOMKltrRTOCBsqSMihDpCO7i+p5CmMJEKwIEo
         GMRuBjNes1OTTMqzCKHrTzvpPGMQV6pM7iqHSz+OFVGM69ofKmN8X3en7h3yylfP8aZA
         q+xSihJy2i6+3o8Ka9Um1HYQc34ZG5a74HAnRccoZjrzyBH/M19GuSTzvrkbAQCdJMPP
         diZ04qk4v67Rrumj5qLL4tgyGaSy8WnHHVJji7pVkM0oRwCYvchPYya0UaejVuXznWmY
         8SLKML3xlQdqqq35f2RtrUx81qmSnd4bd5+aMWrqVR8MGOPWSzwayDfsXep3YUokYGfx
         Fm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766131; x=1763370931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+a5/f/Fx6IMBMc0auLZUB4h0ES81R10KOuZfrxfUU8=;
        b=oAb/ZOQ0W4SmfC8Cm84bl8Jg8w4ey0NOIH7HF0j8oTm1mBCr6vKKu+AWDp+rrhilFN
         dOwhGvpWUCdl6TfSar8LK+yImtIRhwSqlDFKXdhFSfd7K0cp6+g2+/pSYCfqXLnFdZzy
         z8qt549TvIWT6MQ2NczQK+xVXdSnKgEpF9LQ5vJPGMbJlh5lUe9roJ3vMORk8r3KIETm
         Sjf8Up4RuC4zxXTtx9v2NDOV58wmIED7uL7fMlm6c/09z0DLkqqy5seUgxd+9ud54w4g
         JTQwWeEq9oU0XAnwp9XGkJwB/Ti0eo+yT7XLBN7P9enkAqw0bOtTLjk3S+AXFZjMZx5F
         9V1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxe2S/UL2T2juR8dwZjg+FEepxW5e/X1ir8xW22Voe18TTvM9scbVrS2H8dFqXB7eYuZ4nSf7+vTeaqfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpoHiyu1n/x0O7wh2aTOLWMGsHxnmPRz4FXNZOV2k1xdOJRKm
	qzDEtiT/WwhX9LEF/VUSZlLu43AffDojR9TNU/0aVgpuxIEBvLveThdy
X-Gm-Gg: ASbGncthNhHYOqiogfZUmNs1TaA/XdGtU23eL+2wzHpuGiWJWBCkZPVkou++K/KpzOe
	Xmeu8kkdrFCZDu9jZbIFqIqvFSDa1YUymsr/yBJujS3J3GYCrotMbEMs0aN9XyagHuqygfomWWl
	RJEha+q/2UmjMciq+rqqstIdkizMSOS8rlrYEZAhdJlAB+ZYYKUiXNDToQRP5CaF4QDB9An7z5R
	BXkDsgAYk7r3kj3IrgGkvaWVCK/cecE7Q0vEd41uOZ66VdFWUF/MFPjkIX12V7j20Ew7RKWbfw3
	I0SjN3fI8sMi3IPNFiclieAfwt3KYHlXyJ7mUZYBgkn7clRtpKvjCJ1kuDFD6wKOd4/T3jcTQDC
	SiaGB6+THTGT0vOqL/I62v+Mfdkiv38zfFb03oabqPmV05GEMeNp4yOjc197IPOZR
X-Google-Smtp-Source: AGHT+IGz/i0ncWwddIJ+2HVNMQhgm/XQg8Srr9UXcEYDpRdQ63zZfLAICmPWS4NS9Y2VhpYWQE8GAw==
X-Received: by 2002:a05:6512:158c:b0:594:341a:ab1e with SMTP id 2adb3069b0e04-5945f1b74afmr2232518e87.31.1762766130847;
        Mon, 10 Nov 2025 01:15:30 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76f4sm3852006e87.73.2025.11.10.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:15:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 6/7 RESEND] dt-bindings: display: panel: document Samsung LTL106HL02 MIPI DSI panel
Date: Mon, 10 Nov 2025 11:14:36 +0200
Message-ID: <20251110091440.5251-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110091440.5251-1-clamor95@gmail.com>
References: <20251110091440.5251-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samsung LTL106HL02 is a simple DSI which requires only a power supply and
an optional reset gpio.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9f1e76a810c..01ac0af0e299 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -52,6 +52,8 @@ properties:
       - panasonic,vvx10f004b00
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
+        # Samsung ltl106hl02 10.6" Full HD TFT LCD panel
+      - samsung,ltl106hl02-001
         # Samsung s6e3fa7 1080x2220 based AMS559NK06 AMOLED panel
       - samsung,s6e3fa7-ams559nk06
         # Samsung s6e3fc2x01 1080x2340 AMOLED panel
-- 
2.48.1


