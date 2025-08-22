Return-Path: <linux-kernel+bounces-781214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F218B30F36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E111189C44E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B422EA140;
	Fri, 22 Aug 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WjDEA3g8"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67F2E7BCA;
	Fri, 22 Aug 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844865; cv=none; b=POvDJsi9UK8qOpCmy1KwVgbNuzg2rn9EaLxsXoYo2GHvG3+E0AemkhbNeZ94J/1nugiBAtQscNu30pppCLCBJ6vvIZxEwu4SusrDJVobvATHwlobwLDf5Pe/Qvk2GwL73fwxHYjidOVE0KCgz2rvORf3aUqAxvZZmvkqn+JsTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844865; c=relaxed/simple;
	bh=wWoqutgUY4DKQgvme6Hr0hgvoN0JdPHti/PmkndM7Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2Xx8tWXHJVVWH9eNYXNLOJ4olsZT0MPGwW+BG6Z6UXy1TRxOgjJKm4elPsS0ZnICstDfxhNoUOCi7lt41pxett7bGRLAO4P1n+p2tH9Ew/BHXmiSH5DmXVnYCMqCH8UYklH1QPOWwPaB2uYhmmIIRkpAyd40FyMK7RdKph+8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WjDEA3g8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wR
	gLxWrPc104M1DlAk588ARdsB7OQyUqAiiW8tcp7I4=; b=WjDEA3g8KVlrOcE7Hj
	k57boNbTn1wbqEMWINqqJcvMmBLa58GKZ01yIIERtXCMbSi7T/tt4/bASAEQpAWI
	LnBQg5jxfxTrSPiIIKIJA47TSfuwG+pRLHId1mQ3tPbDqQtXTzN1b6VWMjGaqwoF
	aN2B8ivkuIi4+zbmDsn5Hz0qw=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn9_zCEKhoYtibAA--.23257S2;
	Fri, 22 Aug 2025 14:40:08 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	naoki@radxa.com,
	stephen@radxa.com,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Date: Fri, 22 Aug 2025 14:39:44 +0800
Message-ID: <20250822063959.692098-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn9_zCEKhoYtibAA--.23257S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUZrWxJr1fJF1xJFy8Grg_yoWrtw15pa
	1UAry5JrWUWFW2qrs2k3Z7ursav3ZrA3yFgwn7J342vF12kF1UAwnI9FsxXr9rXF17AFW2
	krnxXr1xKrWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4wZcUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhexXmioCP3NwgAAsQ

From: Andy Yan <andy.yan@rock-chips.com>


There are two DW DPTX based DisplayPort Controller on rk3588 which
are compliant with the DisplayPort Specification Version 1.4 with
the following features:

* DisplayPort 1.4a
* Main Link: 1/2/4 lanes
* Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
* AUX channel 1Mbps
* Single Stream Transport(SST)
* Multistream Transport (MST)
* Type-C support (alternate mode)
* HDCP 2.2, HDCP 1.3
* Supports up to 8/10 bits per color component
* Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
* Pixel clock up to 594MHz
* I2S, SPDIF audio interface

The current version of this patch series only supports basic display outputs.
I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C
mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen and Piotr.
HDCP and audio features remain unimplemented.
For RK3588, it's only support SST, while in the upcoming RK3576, it can support
MST output.


Changes in v7:
- Fix checkpatch warnings
- Fix a typo in subject: s/birdge/bridge/
- Collect Reviewed-by tags
- Link to V6:https://lore.kernel.org/linux-rockchip/20250728082846.3811429-1-andyshrk@163.com/

Changes in v6:
- Use drm_dp_vsc_sdp_supported
- Store bpc/bpp/color format in dw_dp_bridge_state
- Link to V5: https://lore.kernel.org/linux-rockchip/20250716100440.816351-1-andyshrk@163.com/

Changes in v5:
- Use drm_dp_read_sink_count_cap instead of the private implementation.
- First included in this version.
- Link to V4: https://lore.kernel.org/linux-rockchip/20250619063900.700491-1-andyshrk@163.com/

Changes in v4:
- Drop unnecessary header files
- Switch to devm_drm_bridge_alloc
- Drop unused function
- Add platform_set_drvdata
- Link to V3: https://lore.kernel.org/linux-rockchip/20250403033748.245007-1-andyshrk@163.com/

Changes in v3:
- Rebase on drm-misc-next
- Switch to common helpers to power up/down dp link
- Only pass parameters to phy that should be set
- First introduced in this version.
- First introduced in this version.
- Add RA620 into bridge chain.
- Link to V2: https://lore.kernel.org/linux-rockchip/20250312104214.525242-1-andyshrk@163.com/

Changes in v2:
- Link to V1: https://lore.kernel.org/linux-rockchip/20250223113036.74252-1-andyshrk@163.com/
- Fix a character encoding issue
- Fix compile error when build as module
- Add phy init
- Only use one dw_dp_link_train_set
- inline dw_dp_phy_update_vs_emph
- Use dp_sdp
- Check return value of drm_modeset_lock
- Merge code in atomic_pre_enable/mode_fixup to atomic_check
- Return NULL if can't find a supported output format
- Fix max_link_rate from plat_data
- no include uapi path
- switch to drmm_encoder_init
- Sort in alphabetical order

Andy Yan (10):
  dt-bindings: display: rockchip: Add schema for RK3588 DPTX Controller
  drm/bridge: synopsys: Add DW DPTX Controller support library
  drm/rockchip: Add RK3588 DPTX output support
  MAINTAINERS: Add entry for DW DPTX Controller bridge
  dt-bindings: display: simple-bridge: Add ra620 compatible
  drm/bridge: simple-bridge: Add support for radxa ra620
  arm64: dts: rockchip: Add DP0 for rk3588
  arm64: dts: rockchip: Add DP1 for rk3588
  arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
  arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX

 .../display/bridge/simple-bridge.yaml         |    1 +
 .../display/rockchip/rockchip,dw-dp.yaml      |  150 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   30 +
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |   30 +
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   59 +
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   37 +
 drivers/gpu/drm/bridge/simple-bridge.c        |    5 +
 drivers/gpu/drm/bridge/synopsys/Kconfig       |    7 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
 drivers/gpu/drm/bridge/synopsys/dw-dp.c       | 2095 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |    9 +
 drivers/gpu/drm/rockchip/Makefile             |    1 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  150 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
 include/drm/bridge/dw_dp.h                    |   20 +
 17 files changed, 2605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
 create mode 100644 drivers/gpu/drm/rockchip/dw_dp-rockchip.c
 create mode 100644 include/drm/bridge/dw_dp.h

-- 
2.43.0

base-commit: 18b8261b84ad5462d7261617fbfa49d85d396fd9
branch: rk3588-dp-upstream-v7


