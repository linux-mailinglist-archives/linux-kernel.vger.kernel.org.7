Return-Path: <linux-kernel+bounces-862608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E8BF5BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 641F34E4E38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCB329C5B;
	Tue, 21 Oct 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YzdC9JNI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E26B652
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041978; cv=none; b=rJfxZ7y18/x9Nmh2+Ve6RFpFjV807SCq6VzhbVEDql9WPJoJGJ/8zr5q43v0o9rIULf+9dvaapnyO8e9rD+oEosXFImhL5GKOQd+oNMGPHKKNHGxRqkUz7m49R7rr0rXDaApNJeLcYoXk8FiTkTzTnE+qyAXnPzen3995shfpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041978; c=relaxed/simple;
	bh=WMHACjCgeCP7hXg1N7fliMXhe6mJU1JutnrJGt/SU24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YBPb/5RzdfEWvD896G/N8VNJG1hIWO+4jbxQmO4ZROsNSLrozDFi9nh9AX4OqCJf9zoxwsKAx/X/J6p9QFFGvXrGxygYZY75M9EX6o54FxTYt8fz4iX+MOyfIA74Bj73hEhMa7/87S4xAP+yKTMfYdNETugOe7v57c+TFADX5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YzdC9JNI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761041968;
	bh=WMHACjCgeCP7hXg1N7fliMXhe6mJU1JutnrJGt/SU24=;
	h=From:Subject:Date:To:Cc:From;
	b=YzdC9JNI3agIUERz01h/HciBT86ZR7IoKC0E3J7egjMeL5JCigqLa1cTSkt18aOkF
	 ZtldKxwqsKrWxAscs5sq7KD+ZHcxpvGk2bEJsSycjiIjuW3MOFC55e4vdG5uGmeBRF
	 cSYhdcpmV+ERiH4WdCEsrNjoGC8ysH1zLG23EUslmxuAwmA9o/zZYOVDmmX0tsRtIi
	 1ba0ICc3uK1mBCJ5hETxf6qVp9wkYsGdmsTCQuEJVAaKhfd732jtR6g+rPFwsnyV2u
	 g5h3kegHb53iz3Fr07IT1ZbQL3VMy92HzBeTZ+4kxafpzrme7bHrTEjcQDtiYBHZjL
	 cViIEiWpsbNMA==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 514EE17E129E;
	Tue, 21 Oct 2025 12:19:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/5] High color depth support for RK3576/RK3588 HDMI
 output
Date: Tue, 21 Oct 2025 13:19:13 +0300
Message-Id: <20251021-rk3588-10bpc-v3-0-3d3eed00a6db@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFe92gC/3XP0QqCMBQG4FeRXbfYjh6bXfUe0cWcW47K2WajE
 N+9aUEgdPn/cD7+M5KgvdWB7LOReB1tsK5LId9kRLWyO2tqm5QJMEC2A079JUchKGd1r6hAYwo
 FIHSZk3TSe23sc+GOp5RbGwbnX4se+dz+gSKnjOoKZSFrZQoBB+WuV1k7L7fK3ciMRfgBAnAFQ
 AIqxBKg4WUlcA1Mn3le3x/pyeG7cZreRnj0jQIBAAA=
X-Change-ID: 20250721-rk3588-10bpc-85ff4c228e63
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.3

Since both Rockchip RK3576 and RK3588 SoCs are capable of handling 10
bpc color depth HDMI output and we've already landed the required HDPTX
PHY driver changes to support the setup, let's add the missing bits and
pieces to VOP2, DW HDMI QP encoder and bridge library.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Rebased series onto latest drm-misc-next in order to:
  * Replace HIWORD_UPDATE with FIELD_PREP_WM16 macro
  * Remove dependency on HDMI CEC series
- Unconditionally used DIV_ROUND_CLOSEST_ULL(), as suggested by Daniel;
  also collected his R-b and A-b tags
- Link to v2: https://lore.kernel.org/r/20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com

Changes in v2:
- Replaced patch 'drm/rockchip: vop2: Add high color depth support' with
  'drm/rockchip: vop2: Check bpc before switching DCLK source'
- Rebased series onto next-20250825 while adding the HDMI CEC series as
  a dependency
- Link to v1: https://lore.kernel.org/r/20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com

---
Cristian Ciocaltea (5):
      drm/rockchip: vop2: Check bpc before switching DCLK source
      drm/bridge: dw-hdmi-qp: Handle platform supported formats and color depth
      drm/rockchip: dw_hdmi_qp: Switch to phy_configure()
      drm/rockchip: dw_hdmi_qp: Use bit macros for RK3576 regs
      drm/rockchip: dw_hdmi_qp: Add high color depth support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   |  11 ++-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 108 +++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c   |  58 +++++++------
 include/drm/bridge/dw_hdmi_qp.h                |   4 +
 4 files changed, 121 insertions(+), 60 deletions(-)
---
base-commit: 7ea0468380216c10b73633b976d33efa8c12d375
change-id: 20250721-rk3588-10bpc-85ff4c228e63


