Return-Path: <linux-kernel+bounces-722266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E17AFD728
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F2A1BC843F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B8221265;
	Tue,  8 Jul 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AdRtsNSo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727021CA0E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003416; cv=none; b=m1TtJ+pkrnLoY8er8/mP6Wmqpg8fZ7yh7AktZFRxmeeXDV2rAqoLaPKnOAgRQ7RinbPuzuhKLxWEUlILnstur1T4QHGDudnu2aUQ3oFJnJ08c5EoG9l/tSWYQYQ8sZw8TOoVwDZetqx1F4mII6zEbjF+npucB17ABMKao675DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003416; c=relaxed/simple;
	bh=WxZx8t1eh4Wa0/HuXw8eTnTZeEIt+tpqIk0E/1C2NB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PiU2LgTRH7HTsxtc5yf0kW8CUXRXeuiqwRaAdBgocnUk/xt8uSe5sKPkBfIQSGUsHun0HfVBZnMeGyNgJGkVGtxCUWQLEZpBr6dPH1Ncc9ausp6iprotEthcArb3DJqV0v2XCxw1oYjO4oFd4TaIXMqniPEQt4myzHWrmuhpfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AdRtsNSo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003412;
	bh=WxZx8t1eh4Wa0/HuXw8eTnTZeEIt+tpqIk0E/1C2NB0=;
	h=From:Subject:Date:To:Cc:From;
	b=AdRtsNSooZH3D7QtkCyl7sMbR1pJf2yfdhxJ2nWyzyXyscHNZIJJ5CFaW0ipHX1G5
	 2emEQFFsrahH5ms/dRUXzPX/m4hYmeqPNHFAvC0MqXoeWRhCslg6M76+WUIwG1tOvV
	 RHdERYXRwTVpTcdsIruoSITwnbfAf6AuMVz/qt1oPqJCXQ6SMkvXSsRJmeAFNJNv2q
	 et5q+lEo/MQHEcX/I+jWIBsLbd5e/xlTMcamDim+39e5I9cnS1dNqvb7kw462dyMIx
	 XegpoGCWfOUz85y40UTe8biEFvFmbWEPg3R3THyNSKvgZQiZ+gJnjH+8gSJotX7Oi3
	 jOjR8lB7W+zlQ==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 834D817E0CF8;
	Tue,  8 Jul 2025 21:36:52 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 00/12] Add HDMI 2.1 FRL support to
 phy-rockchip-samsung-hdptx
Date: Tue, 08 Jul 2025 22:35:41 +0300
Message-Id: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1zbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3YKMSt2MlIKSCt20ohzdtGRjY3PzlCTLNKNUJaCegqLUtMwKsHn
 RsbW1AKDeYUFfAAAA
X-Change-ID: 20250708-phy-hdptx-frl-fc3377db9f2e
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
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

The series also contains a few driver fixes/improvements that are not
directly related, but are not deemed critical enough to warrant separate
submission.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (12):
      phy: hdmi: Add HDMI 2.1 FRL configuration options
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits
      phy: rockchip: samsung-hdptx: Use usleep_range() instead of udelay()
      phy: rockchip: samsung-hdptx: Fix coding style alignment
      phy: rockchip: samsung-hdptx: Consistently use [rk_]hdptx_[tmds_] prefixes
      phy: rockchip: samsung-hdptx: Enable lane output in common helper
      phy: rockchip: samsung-hdptx: Cleanup *_cmn_init_seq lists
      phy: rockchip: samsung-hdptx: Compute clk rate from PLL config
      phy: rockchip: samsung-hdptx: Switch to driver specific HDMI config
      phy: rockchip: samsung-hdptx: Extend rk_hdptx_phy_verify_hdmi_config() helper
      phy: rockchip: samsung-hdptx: Add HDMI 2.1 FRL support

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 652 ++++++++++++++++++----
 include/linux/phy/phy-hdmi.h                      |  14 +-
 include/linux/phy/phy.h                           |   3 +-
 3 files changed, 570 insertions(+), 99 deletions(-)
---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250708-phy-hdptx-frl-fc3377db9f2e


