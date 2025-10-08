Return-Path: <linux-kernel+bounces-845191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2FBC3D46
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4543AB67C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151A2F3632;
	Wed,  8 Oct 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9LzUjXL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3682F39A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912121; cv=none; b=NzkrKolvJQ9fqurjkqTgK2SBjlIKuIemvTCCykphI2iUYOcpVzkqYyitcvH1XMAs2Jjz51TfZtSGEiLlG5BkxcyHxxQkpcit/GSicbWMiJIppIeLP4RIKd5EINRTtOphq0EkzhNlkKe/rX4dVnGBYpuQEeQICv6zJ8m+DfXOfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912121; c=relaxed/simple;
	bh=OKK/sJXtOy2H/hU/K2/b5lACA7f2zIZiTfFC5Kd2Tc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGpFYDI+J+CGvAbJ8H3exC1A38z0NF+7U7a9f7rRJWR1sp4Ai1yd1St/tCpmaqF65ZqlM7c3nutEe/jeC05o7AKBTEROWWXZkuTdhra0OlTvCzy850qVE6BJl+rcPc80u9t2dvcDyIfzIOSBzXnSs3ES+eZXe8l4kuKoXH9N92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9LzUjXL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-363f137bbf8so68025431fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912117; x=1760516917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDL2+5qpXYINNhwEmiyG4VFEg02NXEqwf5yd4xv3H20=;
        b=i9LzUjXL1gpkHUEQ26xLyQoy2OafwgKN1YCpqh/WCgTziktTfNQwGuHaEvv/2jgUGW
         DCkJ9Ohvz7OjaPqUzzyqsJB1vS61hkBOs7zu4/VY5ScB3GiMdBkj6D80u2ZWnvqpYFSl
         K/hEYTW5Jrnrnl+f8U3d8eHqbuaeVovTCG54UAUBFJbftY5bGnJGnNIHMExQDkme7epg
         MpRN8Y+nAhGf2E3Lh33TGIOJRks9XUnLlrMRNUBoyw3l1VeV1myDR6G/DEziQJuSO8bf
         wR2Oz0uwTn/8AInYk3rmk6oTnt501blIIP0BsgDAbmo709JaM4WB//sT2CFmp8afGtLK
         EA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912117; x=1760516917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDL2+5qpXYINNhwEmiyG4VFEg02NXEqwf5yd4xv3H20=;
        b=lKlTeaTxZyVX5/m/WTi2pPriPtsQXGtSAhPZ6JpphMqBnti361L4Uek1p/CxipT4Uv
         l3KpN7yHYjLF/3DmzPqwtfKLZZfJ8PbsEeQEDP05a07ApBmTW/cxrnhMzlGtKuz9Ckrf
         I45c83xZWKgW0l5WFsvWLO8Uze1ar6BxDZLv1gIjWec/OsPFu7VPgO+5SZWxLuIGn73J
         C0kuoIMAXFGtXYfsaJLBbU3OTjhtRZ54PJcrjHQt/6tDjQpTg5WCzeUAb6PZoAX6qBco
         xAtZbKLgYMnWR4Fxmj/+E3TVAxrgUqkBD7pGKR93wqnAn+r7qFbd0zlL4IfrsCjjCn2t
         FClA==
X-Forwarded-Encrypted: i=1; AJvYcCVo8HZgS/hCDWRm0MaHQhOqh7BI9X2dbi0qwSl+OSo54LRbbVRV8Whfas+Rhe6b2nUR68i52B+vKsRoyAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLKu3S9+7I85VXmvnZlsMbcrHJwNwzHkBRe4nDW7ilWHRnfGu
	FYTU2EDmZy4jtSCFtrh+QyZ7Xve7WLyivrkgvSZJGd6OLcP0JP8fjXEh
X-Gm-Gg: ASbGnctoiVTJtor0bcidDUvlS6uwg2QDx/2rVntyGfjC4uHX9RE3BgTzuBqMf69frQ0
	TmoAmfYCdUeiWa//rpY93zqns6pBppCDjvu73MwQ7Mpm2Iu5gRPIQLiWX20ZImsExgHCzPMGp08
	8d7epCgdVxAI2QQBzehGob4+l7zH2VuKW3TQ1Ip8F+1Res2xJgyB/wHmMvk9EluqRkSzrumCZuM
	WsKlP24uRZjjsXm6rlO2/qGyCUcgfITfkOM4UQO/lCQr/2J8ccG0Xb1HzKJ3tch+aSfjBGj7Qog
	ojroB5wnYSAONJ9YlFm/3m4kz4WA9DPJ6JWRnG43XeRCqZax0eNH9wue4hg0HuRqr3V20l5VL9V
	5nAzntKckQatg2lyCqUIjDWiIMqZ7R4hVFx0fFA==
X-Google-Smtp-Source: AGHT+IFQxyHSbODYuzrHx4CLDnLSfhATzRQS4eJZQ4bwmDnpLeGrbfUB1YUBpZ6Ww46Qx9cA5lS5uQ==
X-Received: by 2002:a05:651c:2210:b0:35f:246:a751 with SMTP id 38308e7fff4ca-37609cf7d65mr6119911fa.5.1759912117289;
        Wed, 08 Oct 2025 01:28:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124649sm6968733e87.15.2025.10.08.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:28:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
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
Subject: [PATCH v2 0/7] Add support for panels found in various Tegra devices
Date: Wed,  8 Oct 2025 11:27:52 +0300
Message-ID: <20251008082800.67718-1-clamor95@gmail.com>
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

 .../bindings/display/panel/lg,ld070wx3.yaml   |  60 ++++++
 .../display/panel/panel-simple-dsi.yaml       |   4 +-
 .../bindings/display/panel/panel-simple.yaml  |   2 +
 arch/arm/boot/dts/nvidia/tegra114-tn7.dts     |  13 +-
 drivers/gpu/drm/panel/Kconfig                 |  26 +++
 drivers/gpu/drm/panel/Makefile                |   2 +
 drivers/gpu/drm/panel/panel-lg-ld070wx3.c     | 184 ++++++++++++++++++
 .../gpu/drm/panel/panel-samsung-ltl106hl02.c  | 179 +++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  65 ++++---
 9 files changed, 496 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-lg-ld070wx3.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c

-- 
2.48.1


