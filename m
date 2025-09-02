Return-Path: <linux-kernel+bounces-797307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB6B40EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF3207D46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B822E8B66;
	Tue,  2 Sep 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WiX8xbMS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A72E7F03
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845896; cv=none; b=QYqYGkD9lvMSr8LfmCA8UEUuXuNnkLqnK89Kc6GLNcgQYkreFRGn2A+tdOJiqEOR9br9ionq/JXOGO2sFVhYraBWbeKTdkZN5ilDnlp2QS7rk6CVxxdE0Mx0eY8+F0MBz0gmdvb6wuoHpMHm1WhEs+dvqW0dmav3mDheOe6B6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845896; c=relaxed/simple;
	bh=ZypK9sMAZJbpWzGN+Hx+ArMc+6LRYinYdlHAozWT/T0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Un90DzmxoDLhUpIUbBWAWXFS+WYPjebwwhlrLfKhYaqW3V77fhaYiSjM1F4aW4Jxchb4MPmucRkhao6KSpSC2+WOp81MWN2uWh0k12WtbicI/Gsb9wfAnDeYKq5y92M5JKBHfIk+xXf/3i9HSzQUZLXeEJFhynlonY7xtfJmzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WiX8xbMS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845892;
	bh=ZypK9sMAZJbpWzGN+Hx+ArMc+6LRYinYdlHAozWT/T0=;
	h=From:Subject:Date:To:Cc:From;
	b=WiX8xbMS5sifpaf0AnuCiedgBGH7eFIJvGN9COeD5kgHEkmLZHobzCH0hTTAq3VhC
	 Po3u7Qy5JcPDNq3jIvIVzc4WswryWZ+ashU6JFXuBpNDybQhnXp/v9KR70X/tF8Is4
	 i9+99KHCN+bwy9EBBjpV8OdbLenvPuKJtYG0aqf8SlPxw6kniVf0GDdDm2S7rE7DZ3
	 iFYmrvQs6r0yLN8Q4xF24kOL/t6nbAzTYn1oO/5Cppu5Z4y9Ji3zHC+fEFF6TvrDB4
	 R4HPjp3RHpvGCZ+WixnLKc541fvy9DoyqDanXLUbOfkivTLgfaEgZLRofjnUXL7vS9
	 qmnBTWHbSwuDA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 430F817E0456;
	Tue,  2 Sep 2025 22:44:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 00/11] Add HDMI 2.1 FRL support to
 phy-rockchip-samsung-hdptx
Date: Tue, 02 Sep 2025 23:44:35 +0300
Message-Id: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNXt2gC/3XQy27DIBAF0F+xWJeKV4zxqv9RdcFjqJEc4wC1H
 EX592KnUqKmXV6kOczcC8qQAmTUNxeUYAk5xKkG8dIgO+jpE3BwNSNG2IFI0uF5OOPBzWXFPo3
 YW86ldEZ5BqjOzAl8WHfv/aPmIeQS03nnF7q9/ictFBNsPRDVAmPCizcbx1GbmPSrjUe0aQu7C
 x05/BZYFRylnXHCtEDMXwJ/EOjTDnzbQSqlpOuMYU/C9XZigtNXbarc7rwX1Tc7rAh7hLc+sOS
 k8x60sK3uaxMVMjoDruwxlL6ZYC34Z5rWj67fiMLVuJoBAAA=
X-Change-ID: 20250708-phy-hdptx-frl-fc3377db9f2e
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The Samsung HDMI/eDP Transmitter Combo PHY is capable of handling four
HDMI 2.1 Fixed Rate Link (FRL) lanes, while each lane can operate at
3Gbps, 6Gbps, 8Gbps, 10Gbps or 12Gbps.

This patchset extends the HDMI PHY configuration API to manage the FRL
mode and provides all the required HDMI driver changes to enable FRL in
addition to the already supported TMDS mode.

Also note that since v4 the series depends on the fixes provided by [1].
Please see the changelog below for more details.

[1] https://lore.kernel.org/r/20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v4:
- Moved the following fixup patches into a separate series [1]:
  * Fix reported clock rate in high bpc mode
  * Reduce ROPLL loop bandwidth
  * Prevent Inter-Pair Skew from exceeding the limits
- Renamed enum phy_mode_hdmi to phy_hdmi_mode and
  PHY_MODE_HDMI_{TMDS|FRL} to PHY_HDMI_MODE_{TMDS|FRL} (Dmitry)
- Rebased remaining patches onto next-20250901
- Link to v3: https://lore.kernel.org/r/20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com

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
Cristian Ciocaltea (11):
      phy: hdmi: Add HDMI 2.1 FRL configuration options
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

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 684 ++++++++++++++++++----
 include/linux/phy/phy-hdmi.h                      |  19 +-
 2 files changed, 603 insertions(+), 100 deletions(-)
---
base-commit: 58f59f0f890f0a80b28743261bd8800f5a1ed7fb
change-id: 20250708-phy-hdptx-frl-fc3377db9f2e
prerequisite-change-id: 20250902-phy-hdptx-fixes-7308ffea4c6a:v1
prerequisite-patch-id: 777b4d364feed432f604f87d58a6474cf8457431
prerequisite-patch-id: 7dafe85f5c9ac1291fd1b141a0e0fe68a4a837a9
prerequisite-patch-id: f4446206cbc7ceb41315085322fec45c72ec734c


