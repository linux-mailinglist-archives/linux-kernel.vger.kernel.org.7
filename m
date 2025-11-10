Return-Path: <linux-kernel+bounces-892659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD6C458F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A43189047C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D612FD1CE;
	Mon, 10 Nov 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8sZF/QX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E472FE563
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766127; cv=none; b=khxYXY7z9mO9LEx559IMi1k15zH1d8k3MI2bBJEohhKMHrqREg3neav1Jojr54OJh03ldWGcz9hF+RQxnKa65fwH5E/0eoghzOIESCt9RLod6pQ8wAJKCxYgSKvuxyHhlC/ks0pbfwQp6++HBp3w2q/2BlM7VC+bcJMgr8rDfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766127; c=relaxed/simple;
	bh=AAy4P8dvMHeneV0IgwHSPlPKzVlb7cPq1pIPErAgdos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVkFMAdqLmmIus0k56+AjLuuNILg4lpISNh1Yar6z/ptmguM8LifnPMQkqE0sRbRMFC5HVifIghiB36Hxjr0apP/mtSGUwrOJSbUldSrKXCufeMSKRgVMMxUCN6kuWJ49ePyWCG1b1DxIvBaSipv+EA9oAohnX2iQdwBm7Lfr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8sZF/QX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594330147efso2641495e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762766123; x=1763370923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ9/LjENMEgkqGr3qDNK6DAWAvXersuPBKAH6ygTJP0=;
        b=i8sZF/QXlQPY+qiEh4soUumRZDPKVA6eX07Uy9ERGiT2k4GHQu6azi160AeoxD8nl1
         NgWDaqt7IrKj+3lJbwDXhpyObq0cze/b1VD0DphTzj9oivxjlnbL68EwKerhiBICnqIN
         3dqZEafDhFBhkkH/r2x0oCGwO8w1rC72FM2mslAAN31rqz/NM0XkrfLXiOYjIuXQ8B1+
         Uurk2ch4uFgBWnXM2KoqKxCuVB2j2VGySJqo7FFhN3jxhSvSwLuEgEsa9ERSHWGaBwab
         +qCxNmBO6L6hpb0aVr42yiFW81nUzFGlYK4GHKBjETzFI8tGgIZdQ+U2YopEWLSmirER
         kn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766123; x=1763370923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ9/LjENMEgkqGr3qDNK6DAWAvXersuPBKAH6ygTJP0=;
        b=YoHhYsJE619gPo1kYogCMT2PxBMn3ArNd/B1SkdJC7XWVCtO9gM/3HO67l5SUdoUxO
         q1iz3PuRtc96Z07Db8lAAWfQ835hF6OZKPedMOo04FR7U1tThpaZ4y+/p8XwTV/MWSLb
         udYTb70v6divEEtHF7RrZJKdZLJ6WsdfSB7q3Mc4BmjDOv5I8xxGjpJTWRM79EazP+of
         H8u6rvZTWuUzB8rZGg0We8JpzIW54vdeisUZJHtWVAytp1cRHbV6l0hm62DEH/XFbgqi
         HSNCRatCmmledyU910w9Hc8TAP+ASC4j7c/QbG9nhO2GXdddJWgA9lsZmwJ0iD1JHAN/
         nwVA==
X-Forwarded-Encrypted: i=1; AJvYcCVVqWth7rHcIlxI6FSoaWxfBka0mqOJLjJYICPMLpI+uECuxGf9HZBVPPkpqoM/3qurI1j3ldBoS2us7+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YCN+pVEC34iAdlYJ4Tpxd+xsiEhO8l0G0+we84074x89kQJq
	LkuooWVMrkS/+FQ+JCoe2y12lZGFdceKhUF8TDrNavkxFTA5prNXE38t
X-Gm-Gg: ASbGnctFdCvd+yM7Z+hMo+CZlEzOBMuhZoPaZVKebCcv6Qv8uosgDR7BRSvyfusalzx
	QzbAwReQl8Vc0qu5J//hTavEprjTxO0zvnEHj6falGeCWQ/hnWIhGJvtsllAvMuZzlwFcE0xWvc
	mJ8u/Ml21xLzLuLxPplL78RnxfgkXzW0NAa+Ek3+bf3hWxDK9p051Q3quJX5NIyHFnt1BEuWEl/
	cV5F47I5MKE+H9U8bzwzXOTbMrzbVlzbuqhOluIuSaCH8WjAN+CIWqw3kqHVE8WK6vpa4CmYDDa
	5J1eMU3VTonHQoUwxAbBpiMLB0+RwD0UVM3Zy8kqKOha/mQ658qyjjbT5Pnm2xBTaqGmzEzljT3
	mOZ+r5qtv2NH1KOyxuQ2zjzqZhhmh4vSpI/0sdkPCwlP+hEcBkNADVpjH2x2kGC3/YTr6svMzbv
	Q=
X-Google-Smtp-Source: AGHT+IHKflfppJ9fE4B/jxYw4Ee0cwdoj93J+qONHoGq9+fPDTkw7v1R2iIj+5ReVkBMNZS93KUhOA==
X-Received: by 2002:a05:6512:308b:b0:591:c346:1106 with SMTP id 2adb3069b0e04-5945f1594a0mr2128941e87.9.1762766123168;
        Mon, 10 Nov 2025 01:15:23 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76f4sm3852006e87.73.2025.11.10.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:15:22 -0800 (PST)
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
Subject: [PATCH v3 0/7 RESEND] Add support for panels found in various Tegra devices
Date: Mon, 10 Nov 2025 11:14:30 +0200
Message-ID: <20251110091440.5251-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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


