Return-Path: <linux-kernel+bounces-724483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D8AFF37A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09B31C811DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284023AE87;
	Wed,  9 Jul 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ABA/dg9V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70199237163
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094905; cv=none; b=mcEeyBXrc3baoPryo7WZcXy2aqr+7/x1sGQyVEjMst8C0X3vPMR5A3cSJh/KQSgEsMKdQJIgyxV9I5T1pdZLj+zkuDs5Yb3aI/mekLXZhGl/vX/yElICKRyQC7LEG+d0pSXii8Iz6amNu0gVLPuTL7WgdOVLw3BjXZ1p67KK+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094905; c=relaxed/simple;
	bh=moiSfO2R7aLv0S+WQByIAYMB8s0lvHJIzcWP0Lxus3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5RclXV0jEnqWUNI6LAh1n5EjEQHjznDUoR8wLP+Oz7G/2p7coCcgLCtzg+8PLLhdhd0XO8pf5hrDeorDHfH/qDuC14Zdu3PLPp0bup1P9GKpQTPDBeoU5++kCpn0nS2cAPWmgTvBnxkNILAgwETTiJmbKe8QF0gq88ZRDY/u/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ABA/dg9V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752094901;
	bh=moiSfO2R7aLv0S+WQByIAYMB8s0lvHJIzcWP0Lxus3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ABA/dg9VpJOvW12L9+KIQ8Ir9OiZVlbT2Aehz3vd2UK0yQ9xRqyRc9ejpzDEXy/ny
	 mlp99jyv6MU4Dytlo1vggcHc662Cq9qMEkoe5h3nXnX+eSIIlpfPavjZkC6WmRizVs
	 aHhgXrwavlkW9NZ+VDa7BPfHK35wHusLwYJC/DFnMciWQVApxtgcf5Y7E5Op/H1mvN
	 8DBHPqTtXwXGaw4Odt/UiBx/RzmJlnmIV5353L9xub44WW6RSKb9AF0e8D+3nPzyTn
	 NacnPFEQTYdJyR1G6vNJMMhvVZ4zF78qV/YZgwS0QCVeIs9LW6D0jtvtkSM8uf06R0
	 zM9M64q7Xmjnw==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 6C5DA17E0456;
	Wed,  9 Jul 2025 23:01:41 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 10 Jul 2025 00:01:15 +0300
Subject: [PATCH v2 4/6] drm/rockchip: dw_hdmi_qp: Provide CEC IRQ in
 dw_hdmi_qp_plat_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rk3588-hdmi-cec-v2-4-f5884be34bc1@collabora.com>
References: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
In-Reply-To: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

In order to support the CEC interface of the DesignWare HDMI QP IP
block, setup platform data to include the required IRQ number.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 4e7794aa2dded4c124963eaa7f5158bde9bbbdb6..39b46327afd8e4753d96962fad66792d22b33402 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -527,6 +527,10 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (plat_data.main_irq < 0)
 		return plat_data.main_irq;
 
+	plat_data.cec_irq = platform_get_irq_byname(pdev, "cec");
+	if (plat_data.cec_irq < 0)
+		return plat_data.cec_irq;
+
 	irq = platform_get_irq_byname(pdev, "hpd");
 	if (irq < 0)
 		return irq;

-- 
2.50.0


