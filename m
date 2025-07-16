Return-Path: <linux-kernel+bounces-733279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D1B07299
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C83189C391
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAC2F3C3F;
	Wed, 16 Jul 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gLxfdPGt"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7282F1FF3;
	Wed, 16 Jul 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660352; cv=none; b=DtIBgaD3Cpam34BePN7631d5EME9tiES7ywC7wNkOh/JiWWY5hDcUsKybbOECmqyI4aXj4XU0KlRcsXrJA/mhex0a7OkQzUQ8xiac69u4S8mKPwOMIo1aXHsoBmOz8S+brOmN9xVCtEJcOMvsBk7Wadv7g9zxCwTijlDmPftzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660352; c=relaxed/simple;
	bh=Sny+R9oiFYTt+6ouSeIzPklzeP5hOVMHnLwOwkAQwQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1Aiz/aE/IsacUdswY1GaVpmhroNPpVNlhdRaOii2251ycEQILKH4w1UlGZngqwm27fKjLvbSQeT30zbJRnHyZB3qz1hcfJZaXYT/sVgwzZ+20J/49pGVt+mT3sNde3n+z8kFqG8o/v4sTowGGNN0tHH2EYPUo+hVcSBVJHn/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gLxfdPGt; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KQ
	lDAciNH/akhUfWSpPc2Tt6dyMOL6MZi6d97cEjPrA=; b=gLxfdPGtjj30TmRgD2
	TGAFOYl8IcadIk8vos81oIZ0np5PI/itvwnJA/2H4FKNL05rw9OI0S0r61fS9OLQ
	g+FD5vtOHoh23vv0muh0ikRjVmDPmZKC9zuOA3lPYRjvYSOGzhJc+ADReGVNSCm1
	ZN9jwA11ggF68GD97ND3gcNfQ=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH0s46eXdoG0BuFQ--.1985S6;
	Wed, 16 Jul 2025 18:05:00 +0800 (CST)
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
Subject: [PATCH v5 04/10] MAINTAINERS: Add entry for DW DPTX Controller bridge
Date: Wed, 16 Jul 2025 18:04:31 +0800
Message-ID: <20250716100440.816351-5-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716100440.816351-1-andyshrk@163.com>
References: <20250716100440.816351-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH0s46eXdoG0BuFQ--.1985S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8uFy5CFy7JrW5Xw4kCrg_yoWDurc_C3
	WxZ34xXr48GFn0krZ7Aan3Ga4ava1xuFsxu3Wkt397C3s5AryDta92yr17Gw15Cr4UGrZr
	ua4fXa4Ykr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU82ZX7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkA6MXmh3dCSN7AAAsi

From: Andy Yan <andy.yan@rock-chips.com>

Add an entry for the DW DPTX Controller bridge driver.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v5:
- First included in this version.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee2ef9d9db2ab..f0552f7075c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7880,6 +7880,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
 F:	drivers/gpu/drm/panel/panel-synaptics-r63353.c
 
+DRM DRIVER FOR SYNOPSYS DESIGNWARE DISPLAYPORT BRIDGE
+M:	Andy Yan <andy.yan@rock-chips.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
+F:	drivers/gpu/drm/bridge/synopsys/dw-dp.c
+F:	include/drm/bridge/dw_dp.h
+
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.43.0


