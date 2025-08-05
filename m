Return-Path: <linux-kernel+bounces-756336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDBB1B2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3314C3A421F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835125B2E7;
	Tue,  5 Aug 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F5GEecRf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E61D416C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395010; cv=none; b=gXl0h37lHsR9vRchSoMcAcIEHmgqzSodLw/8ZCYVAto+W6QWzqCjApl9CMYfH8YPngG58BBxaXd+pzMIuqgXjYCkrScoVdq1DKDGdWKeYh417uTLcWeywFOX2jTbJfJLXayGGzWwjrUtc4M+UUAc/87YJt0jRnCuBqUdGMriZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395010; c=relaxed/simple;
	bh=k1SsbcEubPLdbrG03mOUs1Bmt3XqU87WofwUgso3Gtc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aDqf9HyruE7+z0kAiYQlizhgNihZju/IOZMIU68bRp/enyfuc32lK0Zd2DEG1GBjhW3LT6aOOi4gHMAH8xejXJIPlG9VktcRSqL2Dh+oj1UsvKcocQwLszxVJlDvvlwdNtNtMClytVmx+EwSPJ0cbxnB956H96ZvDjrDdLbaPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F5GEecRf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395006;
	bh=k1SsbcEubPLdbrG03mOUs1Bmt3XqU87WofwUgso3Gtc=;
	h=From:Subject:Date:To:Cc:From;
	b=F5GEecRf6Mfk4fSlMzpjcS80VspDpmMbvMLI9o5RmQTwNQyAndZgIjb7wQ+KHfDDR
	 qyGZb6oBmdMkenMmAFmS85WaGC/AzZawf+eIpJTYGjnyMSHX2gIG3tvTZuj2jLitvf
	 ybVVZsbLJO4cJvUgmSPB4zGXqQJcA4LCNujaYv0UYXDYw5zQbyTH97C+aDfii9YS+n
	 pJh5I03XNEEuOAaS3BkrL7Jk38QS6pu6l88dPXSPdKYkPDidWBdLi/hPWbtUkFeKsM
	 06HyzT3EYRJB3ArnKEQtum1Ius1gGRqmsiBSQSS4sk9y5Tv3PRJlwQLQz+GpM6qpWx
	 SzTai64H5Av4Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 824E417E0202;
	Tue,  5 Aug 2025 13:56:46 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 00/14] Add HDMI 2.1 FRL support to
 phy-rockchip-samsung-hdptx
Date: Tue, 05 Aug 2025 14:56:42 +0300
Message-Id: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrxkWgC/3XMQQ6CMBCF4auQWTumFLTCynsYFlCmdpJKm5YQC
 OHuVvYu/5e8b4dEkSlBW+wQaeHEfsohLwVo209vQh5zgxTyJpR4YLAb2jHMK5ro0OiqUmocGiM
 J8idEMrye3qvLbTnNPm4nv5S/9Z+0lChQGxLNnaSsTf3U3rl+8LG/av+B7jiOL2++RQiuAAAA
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

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 670 ++++++++++++++++++----
 include/linux/phy/phy-hdmi.h                      |  14 +-
 include/linux/phy/phy.h                           |   3 +-
 3 files changed, 581 insertions(+), 106 deletions(-)
---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250708-phy-hdptx-frl-fc3377db9f2e


