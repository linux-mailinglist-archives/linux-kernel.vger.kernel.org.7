Return-Path: <linux-kernel+bounces-774310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D510CB2B10F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4614584337
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE91274653;
	Mon, 18 Aug 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hh4drvqM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4467273809
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543563; cv=none; b=pSZNJ4wOpOCdJ15f8Eoq/Y4ocqbQ3ZkJyRGU2Yv3KFhZevOQrfVEVEnMyVierG24pvLg5Qwz6DwhKhMudKSxtcKITY03LtBil+pHm7VFcxeSlW9gFboLAUN1myw3dpZL5KRq80gF6Xad7WAAqHAKdA1OhC1J3KAKFA9+bdlf3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543563; c=relaxed/simple;
	bh=dA6CmxAjeubePqXgKHgNtxM4uimRCuHxo6FmeeBJggo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSIeolDGhRNdviJ26HliG2IDrxtnn2K1zmQkUCkPuTgax7gPNGp8jFvcLAYneDh74wRJ2Rw2Lh7TJHfs2G9AfXsSzJEMtKEX9BRWy7d31Q3caGEDYyWEZ7KNAYKMCm3VB3fX9ylmAUPERKrgB9jDr/QyBXV0GEQtcbszTcoCcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hh4drvqM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543560;
	bh=dA6CmxAjeubePqXgKHgNtxM4uimRCuHxo6FmeeBJggo=;
	h=From:Subject:Date:To:Cc:From;
	b=Hh4drvqMVlQ3osL+Iq2QEN2dRP6J4Wlpa1R2jAhbvzaj4PzUQPi6ezdckGMiIhaBr
	 NLkv3VsKiotjsCXsW/7SmkB4UGZXl01uHaNS0jf1ps+A/hNEDmsiZsEFtsyPTKY2Hz
	 I7fRm88oVgrEGJbEayMMQKWkV4gCcbDgjnHgE8hYxmZH39NpSR62eyt3CxsRfkFC1x
	 gkrEFWSj0OdmgRar73ydgqQgdtmo7ur2FTkwSFNeumRVmyiZUaXpWjGVy7ZNMXyKt6
	 xMR6XLp7tdjUWpLBWAN3msQMteFHZn1621jwf9mf/wRXA6UvQWqGEGX418/UP75RKM
	 5zQJ5rC6+Exig==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id C183C17E0154;
	Mon, 18 Aug 2025 20:59:19 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 00/14] Add HDMI 2.1 FRL support to
 phy-rockchip-samsung-hdptx
Date: Mon, 18 Aug 2025 21:59:00 +0300
Message-Id: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPR3o2gC/3XMSwrDIBSF4a0Ex7XozTuj7qN0EPVahTQGDZIQs
 veaTAqBDv8D59tIQG8xkC7biMdog3VjivyWEWn68Y3UqtQEGJSsZg2dzEqNmuaFaj9QLfO8rpV
 oNSBJn8mjtsvpPV+pjQ2z8+vJR36s/6TIKaNSI2srBCh08ZBuGHrhfH+X7kMOLcJPaFh5FSAJi
 vNGqEJUyMRV2Pf9C33tKHDwAAAA
X-Change-ID: 20250708-phy-hdptx-frl-fc3377db9f2e
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.2

The Samsung HDMI/eDP Transmitter Combo PHY is capable of handling four
HDMI 2.1 Fixed Rate Link (FRL) lanes, while each lane can operate at
3Gbps, 6Gbps, 8Gbps, 10Gbps or 12Gbps.

This patchset extends the HDMI PHY configuration API to manage the FRL
mode and provides all the required HDMI driver changes to enable FRL in
addition to the already supported TMDS mode.

The series also contains a few driver fixes/improvements that are not
directly related, but are not deemed critical enough to warrant separate
submission.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Reworked patch "phy: hdmi: Add HDMI 2.1 FRL configuration options"
  according to Dmitry's feedback
  * Updated commit message providing a brief description of FRL mode
  * Kept PHY_MODE_HDMI in enum phy_mode and introduced enum
    phy_mode_hdmi defining the TMDS and FRL submodes
- Updated "phy: rockchip: samsung-hdptx: Add HDMI 2.1 FRL support"
  * Implemented .set_mode() callback in rk_hdptx_phy_ops
  * Introduced .mode member in struct rk_hdptx_hdmi_cfg and used it
    instead of phy_get_mode() to verify PHY_MODE_HDMI_FRL
- Rebased series onto next-20250818
- Link to v2: https://lore.kernel.org/r/20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com

Changes in v2:
- Added a couple of new patches:
  * Fix reported clock rate in high bpc mode
  * Drop hw_rate driver data
- Applied several tweaks to the following patches:
  * Compute clk rate from PLL config
  * Switch to driver specific HDMI config
  * Add HDMI 2.1 FRL support
- Rebased series onto next-20250804
- Link to v1: https://lore.kernel.org/r/20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com

---
Cristian Ciocaltea (14):
      phy: hdmi: Add HDMI 2.1 FRL configuration options
      phy: rockchip: samsung-hdptx: Fix reported clock rate in high bpc mode
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits
      phy: rockchip: samsung-hdptx: Use usleep_range() instead of udelay()
      phy: rockchip: samsung-hdptx: Fix coding style alignment
      phy: rockchip: samsung-hdptx: Consistently use [rk_]hdptx_[tmds_] prefixes
      phy: rockchip: samsung-hdptx: Enable lane output in common helper
      phy: rockchip: samsung-hdptx: Cleanup *_cmn_init_seq lists
      phy: rockchip: samsung-hdptx: Compute clk rate from PLL config
      phy: rockchip: samsung-hdptx: Drop hw_rate driver data
      phy: rockchip: samsung-hdptx: Switch to driver specific HDMI config
      phy: rockchip: samsung-hdptx: Extend rk_hdptx_phy_verify_hdmi_config() helper
      phy: rockchip: samsung-hdptx: Add HDMI 2.1 FRL support

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 697 ++++++++++++++++++----
 include/linux/phy/phy-hdmi.h                      |  19 +-
 2 files changed, 611 insertions(+), 105 deletions(-)
---
base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
change-id: 20250708-phy-hdptx-frl-fc3377db9f2e


