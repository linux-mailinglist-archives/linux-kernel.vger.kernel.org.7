Return-Path: <linux-kernel+bounces-849983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF310BD1892
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FE49347AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0B2DE703;
	Mon, 13 Oct 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6MQksTg"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782D2DEA6F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334976; cv=none; b=qUIKrJyJoeAZPg1TPJQOlCbWuQniXL8alYAFDGIielp7Zdhtupn1fEHE4aong1x1ZMIzRJ89JFfl4T8gjD/9hzQzVnHP4mUxw50ea69dktg9nCY6J+VKiuk5a+4/omjfc4KSL69BWFOVETkITmzHLWWMazJcllCwgAVM0R7B/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334976; c=relaxed/simple;
	bh=AAy4P8dvMHeneV0IgwHSPlPKzVlb7cPq1pIPErAgdos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JxIYtWIMXljRi5NfjDkVaHWDcx2J40y44g2gDknH5sqdGqACyqaGcQ19m1fff9vt0Ivp1jgAHNUZGIbh+iTrwSs/6owU+jQBFA9bkt2MYvnUA8o4R7uSZdG3jZ9SHgtYSdtOOunB91QZUBNDnkY/uSj9jhSMXoNAg0uhszx5yKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6MQksTg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so709549366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334973; x=1760939773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ9/LjENMEgkqGr3qDNK6DAWAvXersuPBKAH6ygTJP0=;
        b=H6MQksTgLYoYoyDZ7H5vM/njmNIzqe+6uIfT9WFQL/pI0kWfzOi3+YoYm6E/IkhW2N
         MDqcdOKZTkG4Co+ALOv2g83Fg3SyywNXcGsTubuC7LA8lkcdQlhB92cxpDnJIc98g9rU
         faR7HbHDZvYmrs0JGeCtctxMyRAKJ17JQxxSEGtGIuNIFtYRoXGy4m75w+zakycaVlGF
         49lT3Ztb6nZtc33UeKwjEEIkni9ly4wR+BvI+Y4/oy8E8J74OEZQ/jp5NJMZb7rg/UyB
         6jkbmyaCgXb7AXGYNvfViWxk3zUt57omBh6mGVOLX1Lpqd08t88IM5zi8xvLmxGlGnAW
         LOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334973; x=1760939773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZ9/LjENMEgkqGr3qDNK6DAWAvXersuPBKAH6ygTJP0=;
        b=gEkejobwb7yivr1OtF5bIVlfvrOCRIUA7TmCxY9fgYka2RaK1rgWkQHhU+Iku/I20P
         6atI86riNXt3fqh1iqJUx2n49RG0E6H/cePivUgSDbVlgUJVG8y9RTP3QLwF+OhaBmoc
         6iBw8JVyoFYdt55lBGM1H8800yfQUHZ/r51GpyslvTFvGIRTDBCHbYypJ79SL7B484lQ
         ec4KpwvNqgb/6BUXpgUk9/vXMgaRoNBOQHEP+sQyYiutmJTMoWi5COu8SC0xocuzQff8
         YIZZWwt1ekGXpUGqQVdYxFv/CgTiuIHmd+ocsjRupLMew7IUcykpdLeVFX3S61EpSA76
         A3HA==
X-Forwarded-Encrypted: i=1; AJvYcCXADUKhbugfoSuXjOVTRRD+gjq0Wh3Tcv2Ym3gZaeCtQ8dcPkBMp1VNiVqU1uch2Zsv+paiQjl+J+B7yxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNb1d/MRAv7QF07FvdW1O9XVq7moUPwq2YcJZn2uYZ8EuSzlX
	04/0vsHJZKD0H76RLYUjAOlVUZ8o5nVKymxOoeg+4N+JMxwsE2wklSJ9
X-Gm-Gg: ASbGncvputImGCmqp3bGXuAOyHEoMBUXNG/FYsXc2q631RfIzGYhS9Q7r64jThmGTpm
	XziIbjvFPDYa4DP2dwi74vr6q8D87gsmixWAoA29+GXWYAZgF2Bf2oXY1yAkUu5B3DrZ8JcowWk
	u7S9xonxCJHCXti0on0P8ihR2c/m8keHHYQxf+Ugx4QQML5WQLw11Lip/uJ5ElgNdRxmEky3QXi
	4TPAA3oScfISu1HCBVwCgSrgQq8vvkvlDGDltUyuZtSTOusSGUgdOBfXiets9awpKNheBspDEA9
	XTedTnrtudX8Qr3sccnvr+82UjrSTqS+72ueya//7CcfrKCqOsAxSZ8tgvBDeSliLy5/XG2JkKV
	C3Xg6YPCgJFUNo/P+POIZoLtvUyj7IOgF
X-Google-Smtp-Source: AGHT+IEoPPn3y805fRrMXlesV3g+CUW+Q9IgTH2jMMITzvjih1OKeTWGE2CbYjx7Ff9blH+VqEhVUQ==
X-Received: by 2002:a17:907:db15:b0:b3d:b251:cded with SMTP id a640c23a62f3a-b50aa393ba1mr2306986866b.16.1760334972693;
        Sun, 12 Oct 2025 22:56:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:12 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add support for panels found in various Tegra devices
Date: Mon, 13 Oct 2025 08:55:35 +0300
Message-ID: <20251013055543.43185-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for panels found in various Tegra30 and Tegra114 devices,
including panels in Tegra Note 7, Surface RT, Surface 2 and Ideapad
Yoga 11 T30.

---
Changes in v2:
- dropped gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry (picked into drm-misc-next)
- expanded commit descriptions
- return accum_err on prepare
- switched to devm_regulator_bulk_get_const

Changes in v3:
- lg,ld070wx3.yaml > lg,ld070wx3-sl01.yaml
---

Anton Bambura (1):
  gpu/drm: panel: add Samsung LTL106HL02 MIPI DSI panel driver

Svyatoslav Ryhel (6):
  dt-bindings: display: panel: properly document LG LD070WX3 panel
  gpu/drm: panel: add support for LG LD070WX3-SL01 MIPI DSI panel
  ARM: tn7: adjust panel node
  dt-bindings: display: panel: document Samsung LTL106AL01 simple panel
  gpu/drm: panel: simple-panel: add Samsung LTL106AL01 LVDS panel
    support
  dt-bindings: display: panel: document Samsung LTL106HL02 MIPI DSI
    panel

 .../display/panel/lg,ld070wx3-sl01.yaml       |  60 ++++++
 .../display/panel/panel-simple-dsi.yaml       |   4 +-
 .../bindings/display/panel/panel-simple.yaml  |   2 +
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts     |  13 +-
 drivers/gpu/drm/panel/Kconfig                 |  26 +++
 drivers/gpu/drm/panel/Makefile                |   2 +
 drivers/gpu/drm/panel/panel-lg-ld070wx3.c     | 184 ++++++++++++++++++
 .../gpu/drm/panel/panel-samsung-ltl106hl02.c  | 179 +++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  65 ++++---
 9 files changed, 496 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-lg-ld070wx3.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c

-- 
2.48.1


