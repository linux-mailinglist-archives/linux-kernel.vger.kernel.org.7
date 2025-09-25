Return-Path: <linux-kernel+bounces-832747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5ABBA03FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DE016CF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7A2C21E7;
	Thu, 25 Sep 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhVbf6sv"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E981D61A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813435; cv=none; b=Wwcv1U/yGraE1/D/gG5ZMOyals4w+pi+wci1UgADdd3W/clY2dzTMk7k+82pCWixdqFWtiZXmEajcINQXJIlwVh3tfRQ6Yt31VqOg3iVDwMQOIIfW/1YI0y0vJEVI/42VLX+nVtBO2x00L+5SEKLgz+j4ycRkDUqrf2V9KQV/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813435; c=relaxed/simple;
	bh=EPmeZ+AxYQt1ZQC0Ek7FvFMD0viWXbKOiFp56gi1mFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvDiZZ/vS1VAbI22fKbq4I4ktTYJaRwETTAuGvVOvxHFXkBgNrCFoitT6y2JnE495x78NDbWUd2T1qBpyHNPKtb5LsDWJzHgn0FhcEwl9kgLFeDtNPBNwxTOI6YaNklny70tPfhwj3ier8L1gQIDrHJY58v1X+DskSE0eahvcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhVbf6sv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1447929e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813432; x=1759418232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v32IEPJq83+rFpTKepQApZcwbjn1LGuorJ9QJ5gMjI=;
        b=nhVbf6svSPK93SBpCUsW1QtYeCNo/XMUyoqZONzdN3kn2s2P1SghA8S/UtxjXYZ1gJ
         sJ3+XPEBIXTVpGXF+sPe3SJPKUBJ4h7z2QVFf6NeH6oibE+XDdJBQUFuEpgGDX16L3+G
         KwJFF2FRLqn/zo6VcUsgP9oO47C0JqBp55BndpGYDc0ccXsfx6PhKBOTyKuIWJbwjzvf
         8ifunal0v8LMcUMupXrAvCBQtzw2Y3fktWbydKmj25hj9ijx3PtrVhDPwVZp0COAeLx4
         txp6cfAnxs+J4ePWSUlr4JyBdC4z7CLBuMG/qnhoux+XjX6cXdYOywSMOn2DlABpS+eq
         JZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813432; x=1759418232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v32IEPJq83+rFpTKepQApZcwbjn1LGuorJ9QJ5gMjI=;
        b=VXuiBuFhrOBiFnWP5oJoOzXybJuPTx6xqd4l8KMGfRisP2tGITS980dgAcTANsSsHz
         zZbE1en5lL/uSSmujigd9BNo/y2Zi58qwUXPMFi2BTZh/QVY/AhHCwEzJBrKgp8OvP40
         VG5hqOOLjee0B6ja+B2LaV6BNXoADcm5ovNglKHvJjl9TuUNy4Dag19nMgmqBlDXyeBv
         Lv7P+F4V3jz28Uc49SULKt8VPk25ApkgZOZyr0SahuuFY4oJESX4BuyFkKPggdR4j/UD
         PMJaUL8RFf2Av7kDkmU27Npayjkex50EWKPifIqzK/lhsrwIILpt3NvY8Cah523xWPNG
         misg==
X-Forwarded-Encrypted: i=1; AJvYcCXkO3trsJS6LZHh85lyDQAdNrW5Fd5o+4TBo+2wAY6cIeJ00GadV+Hb/yRRM4ajgzTBYcLLM0mOh2Xkviw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXP0Ida+J8aa7N24CLxWsc2olh2LHHnzk2YSN3o7x6fiSy2kB
	Gimht5bbZdb7RpAIVq9Mx6qaeB57K2DYa7csghyl79G3rebt0AcIcEp/
X-Gm-Gg: ASbGnctkfzy5IgYBTRk1AO+EB0J0gKDPOcGzerKJ78+4JZdof8v4WPgkcgdSnrcmK2z
	034eGIXP27kLoWaQfTaFqoOubgVKCWUZOpUt6Srl2u5jQWVfyMqVnPzRzb1nLnDOQQNWCIKhK49
	9A8NX75sfw/p6+QmVgDPEAfRwfvPR6fU95lQt5UL7cwDO75xIH5f28+E9ouiLq7BZ7sTS6aGdQZ
	PtfqJBsW+vJAUoy7sbGXtq8tC4xQMccDJaIeaAaW4YwjVYK9toYpTkveW7mKLq+axapqQIT6KA2
	77xavtJF23CeSmNvgDj+rIsy0QhNjrDavIOrpv0+luw7GEhJegYA0BSLTbHCySOW8m9O4sY7k5j
	Hsx8sDh8aA+eNWA==
X-Google-Smtp-Source: AGHT+IE3EnxRGgkHHyis8Weimvr/QO/NiYq/0dZgZmiN2yuGCI3D2oO1tpnAY+bLbNeA0ytCv5wrfw==
X-Received: by 2002:a05:6512:3a93:b0:55f:3ae4:fe57 with SMTP id 2adb3069b0e04-58306abf6a1mr938344e87.20.1758813431368;
        Thu, 25 Sep 2025 08:17:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 00/22] tegra-video: add CSI support for Tegra20 and Tegra30
Date: Thu, 25 Sep 2025 18:16:26 +0300
Message-ID: <20250925151648.79510-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for MIPI CSI device found in Tegra20 and Tegra30 SoC along
with a set of changes required for that.

---
Changes in v2:
- vi_sensor gated through csus
- TEGRA30_CLK_CLK_MAX moved to clk-tegra30
- adjusted commit titles and messages
- clk_register_clkdev dropped from pad clock registration
- removed tegra30-vi/vip and used tegra20 fallback
- added separate csi schema for tegra20-csi and tegra30-csi
- fixet number of VI channels
- adjusted tegra_vi_out naming
- fixed yuv_input_format to main_input_format
- MIPI calibration refsctored for Tegra114+ and added support for
  pre-Tegra114 to use CSI as a MIPI calibration device
- switched ENOMEM to EBUSY
- added check into tegra_channel_get_remote_csi_subdev
- moved avdd-dsi-csi-supply into CSI
- next_fs_sp_idx > next_fs_sp_value
- removed host1x_syncpt_incr from framecounted syncpoint
- csi subdev request moved before frame cycle

Changes in v3:
- tegra20 and tegra30 csi schema merged
- removed unneeded properties and requirements from schema
- improved vendor specific properties description
- added tegra20 csus parent mux
- improved commit descriptions
- redesigned MIPI-calibration to expose less SoC related data into header
- commit "staging: media: tegra-video: csi: add support for SoCs with integrated
  MIPI calibration" dropped as unneeded
- improved tegra_channel_get_remote_device_subdev logic
- avdd-dsi-csi-supply moved from vi to csi for p2597 and p3450-0000
- software syncpoint counters switched to direct reading
- adjusted planar formats offset calculation
---

Svyatoslav Ryhel (22):
  clk: tegra: set CSUS as vi_sensor's gate for Tegra20, Tegra30 and
    Tegra114
  dt-bindings: clock: tegra30: Add IDs for CSI pad clocks
  clk: tegra30: add CSI pad clock gates
  dt-bindings: display: tegra: document Tegra30 VI and VIP
  staging: media: tegra-video: expand VI and VIP support to Tegra30
  staging: media: tegra-video: vi: adjust get_selection op check
  staging: media: tegra-video: vi: add flip controls only if no source
    controls are provided
  staging: media: tegra-video: csi: move CSI helpers to header
  gpu: host1x: convert MIPI to use operation function pointers
  staging: media: tegra-video: vi: improve logic of source requesting
  staging: media: tegra-video: csi: move avdd-dsi-csi-supply from VI to
    CSI
  arm64: tegra: move avdd-dsi-csi-supply into CSI node
  staging: media: tegra-video: tegra20: set correct maximum width and
    height
  staging: media: tegra-video: tegra20: add support for second output of
    VI
  staging: media: tegra-video: tegra20: simplify format align
    calculations
  staging: media: tegra-video: tegra20: set VI HW revision
  staging: media: tegra-video: tegra20: increase maximum VI clock
    frequency
  staging: media: tegra-video: tegra20: expand format support with
    RAW8/10 and YUV422 1X16
  staging: media: tegra-video: tegra20: adjust luma buffer stride
  dt-bindings: display: tegra: document Tegra20 and Tegra30 CSI
  ARM: tegra: add CSI nodes for Tegra20 and Tegra30
  staging: media: tegra-video: add CSI support for Tegra20 and Tegra30

 .../display/tegra/nvidia,tegra20-csi.yaml     | 135 +++
 .../display/tegra/nvidia,tegra20-vi.yaml      |  19 +-
 .../display/tegra/nvidia,tegra20-vip.yaml     |   9 +-
 arch/arm/boot/dts/nvidia/tegra20.dtsi         |  19 +-
 arch/arm/boot/dts/nvidia/tegra30.dtsi         |  24 +-
 .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi |   4 +-
 .../boot/dts/nvidia/tegra210-p3450-0000.dts   |   4 +-
 drivers/clk/tegra/clk-tegra114.c              |   7 +-
 drivers/clk/tegra/clk-tegra20.c               |  20 +-
 drivers/clk/tegra/clk-tegra30.c               |  21 +-
 drivers/gpu/drm/tegra/dsi.c                   |   1 +
 drivers/gpu/host1x/Makefile                   |   1 +
 drivers/gpu/host1x/dev.c                      |   2 +
 drivers/gpu/host1x/dev.h                      |   2 +
 drivers/gpu/host1x/mipi.c                     | 501 +----------
 drivers/gpu/host1x/tegra114-mipi.c            | 483 ++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra20.c       |   7 +
 drivers/staging/media/tegra-video/Makefile    |   1 +
 drivers/staging/media/tegra-video/csi.c       |  66 +-
 drivers/staging/media/tegra-video/csi.h       |  16 +
 drivers/staging/media/tegra-video/tegra20.c   | 828 +++++++++++++++---
 drivers/staging/media/tegra-video/vi.c        |  56 +-
 drivers/staging/media/tegra-video/vi.h        |   9 +-
 drivers/staging/media/tegra-video/video.c     |   8 +-
 drivers/staging/media/tegra-video/vip.c       |   4 +-
 include/dt-bindings/clock/tegra30-car.h       |   3 +-
 include/linux/host1x.h                        |  10 -
 include/linux/tegra-mipi-cal.h                |  56 ++
 28 files changed, 1648 insertions(+), 668 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.yaml
 create mode 100644 drivers/gpu/host1x/tegra114-mipi.c
 create mode 100644 include/linux/tegra-mipi-cal.h

-- 
2.48.1


