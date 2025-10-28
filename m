Return-Path: <linux-kernel+bounces-873225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C30C136ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73964EFFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392C26E6F0;
	Tue, 28 Oct 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qxFBeKT1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCF824BD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638527; cv=none; b=WUpkklfwhbbr1jmQJhhSlKlnvol8ilbB31mhPrl7q34Y2e/n4Gm4Zc+lx6s1C+oIEkdYxBbftx3YwcvgYayA36PNd2dgb+fzo5eg8HAmwWZIXzaDea9INGK4/7C9hANyPHPA5BYpA1/TmgQqRMxFdIQBrNKvGGm1W0BZ66sY9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638527; c=relaxed/simple;
	bh=w0hVbt0p8X5uVDG3kntIZUMpWvl4mJzdXMzRwu8Mtys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BXYU45wWfCD0xjwJ0Rl2AszKbRy3h+iFxwXo582EyD8Zd0PauvHmSveyPKRZ+d9qpNAq9cWJPD+k30BDPWgMClUHxLKWPnFo3dNn2aYeJX0Yzaopot7O/G//ogij6PCNglOHS3lzLVHqec62b79bElKSsNYGzcQOITQfs0UTaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qxFBeKT1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761638524;
	bh=w0hVbt0p8X5uVDG3kntIZUMpWvl4mJzdXMzRwu8Mtys=;
	h=From:Subject:Date:To:Cc:From;
	b=qxFBeKT1dUgT/LlBYTUYbJTMz57nWxhv6fGkB6yT9D3gkdCNLpPOLQrluXu2gAijV
	 U9Lxjp+UrbuxDGO4nE2YHX24L2h1fwvG/tAJBIUdCzyeSwk+w4EjKCsRaMPqaXXYxE
	 Ffs972t/IRjbof0BhdXGsNJSTMmkdn8tk95domcYJbexhCD2gNXSWySC3+ZDL2YbqA
	 TM8cGV5AO7HRLL4MREEVPX/h2M6uz/p/N8ALwDZ5WhQCrkDbmVHIofTCvW2NHwadsS
	 Xvv8OYD4uhbt4pwdyCMjJGxSP2wjhRz5cfx+vbNPBHYX+yIhE3lUEqd/1kV970RC0u
	 bI0Xju0TiOWrA==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BCBDC17E1278;
	Tue, 28 Oct 2025 09:02:03 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH RESEND 0/3] Fixes for phy-rockchip-samsung-hdptx
Date: Tue, 28 Oct 2025 10:00:53 +0200
Message-Id: <20251028-phy-hdptx-fixes-v1-0-ecc642a59d94@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.3

These patches were initially part of the HDMI 2.1 FRL support series [1]
aiming to provide a few fixes for the Samsung HDMI/eDP Transmitter Combo
PHY.

I'm sending this as a distinct series right now, since the FRL part
might require additional time for review.

[1] https://lore.kernel.org/r/20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (3):
      phy: rockchip: samsung-hdptx: Fix reported clock rate in high bpc mode
      phy: rockchip: samsung-hdptx: Reduce ROPLL loop bandwidth
      phy: rockchip: samsung-hdptx: Prevent Inter-Pair Skew from exceeding the limits

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)
---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250902-phy-hdptx-fixes-7308ffea4c6a
-- 
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


