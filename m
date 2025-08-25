Return-Path: <linux-kernel+bounces-784331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC71B33A06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB1176609
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A502BE7A5;
	Mon, 25 Aug 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QsQPQlTW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAD2BDC02
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112235; cv=none; b=FiSzifVKa5osQxg10O9IYCxgFZjmfz3Xst3HK3tOj8DY4Rnu/Pow5TyRIDXlRouAgu+dj1Tboy24GFC0n5ulNYhXac84RdmKmq08IbdGNIJsoShKHiLIdgo5big/0lC5vpyj9051DMVBi4GfDpzHE9tXWboEkFmrlVPfBug9H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112235; c=relaxed/simple;
	bh=Dn79h63zUtROM5GLEyGgxHXxWqkWpVUrrxCb6cn+d5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2+NuDBaZ/nY1AXv2dgLtaX1r850XMIfoq4ryvhFEnVPSWY3Bj3Y5lB0IL5IOQ8Ic11e2c1J8g3Pal/CZj0tb/YyQDuNqrwBr8S0xVNJ2Q7uqY76loeoI3G1BpyuMBrCCZJUgbc29sr8ax3rN/pJ9OhPYIlNfPYnuyl1Vb6YzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QsQPQlTW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756112231;
	bh=Dn79h63zUtROM5GLEyGgxHXxWqkWpVUrrxCb6cn+d5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QsQPQlTWB1XrFKi2B3Oc7vbdrYQHWJ9UwkUTgDSdXi58n/Ne29T7Yk6j+/Kz9IwyT
	 kwVwgxueYk4AM2fHXB9DRVDx/ho1bw6KoDZaLTZHSXqUB+0Wi4Or6mqDQZLcC9+N8q
	 J9JLqQM4CltrPjemu1h/V292ihohJxiWexFFFCuJRbe2sNZXjD8S2u1fXsQpfGYupf
	 jjMVPLzewH9kAQSrhiEDBHGWH4F+OWD7P6zCqAK6RnDWjJ6x4WuA1r6L0TNRcEVSkm
	 qtZcXmDYngKjbgOGo3qcz/lcexSqZoTTgRbg5P/Pi626Q5E7TxKlwHJ5BVNh04CM1J
	 UM3hM8SV+g0VQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A8DEC17E0578;
	Mon, 25 Aug 2025 10:57:11 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 25 Aug 2025 11:56:44 +0300
Subject: [PATCH v3 4/6] drm/rockchip: dw_hdmi_qp: Provide CEC IRQ in
 dw_hdmi_qp_plat_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-rk3588-hdmi-cec-v3-4-95324fb22592@collabora.com>
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com>
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
2.50.1


