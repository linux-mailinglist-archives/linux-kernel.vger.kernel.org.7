Return-Path: <linux-kernel+bounces-736330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B000B09B97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE0D172C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0581FDA7B;
	Fri, 18 Jul 2025 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ki+en/rF"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFAC188596
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820908; cv=none; b=gAWVNvlLDGeizePCZUAlgZW8GiqO+8aU1xUwAxggZOq+uETr6O4dOgaGjJ3FptKDJHdidbjDL0u2DjXpHhT7JxLafNlUXlLDqGJeTbdJGLLS1ih2Simz3JfDeG8UNhAwVI5gKGTZ8CMATnlS5d01ye63JcdFICV7Dglpiko1bM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820908; c=relaxed/simple;
	bh=H28zy/8HnFxrQugKOxWgLu6ZSQ2GHfIUhXCoaWmM6XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbSrYm2Rn63Q9MLVJqyBf71pibxsABMsD2/miwIClN6jhF/fvt5HsyPEfHWLIY4z4droy3E8Ak+9axI85q+WmxBF/SOX7J/V6gy75lBNJ5EobevzkCr0Hug+JR5izz6lvCF4UcE9jayicxNAMrsBe2wQ9mSpfKqbKkT1CfbWH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ki+en/rF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I5
	N1yFgSMKSP+yKcbwHy28RLjBgi4tDP/QpC0dPcGt8=; b=ki+en/rFRoCuGDoc9o
	jj5icWfNYuhgFscJfdlQOsyh8LJDuKh1mdo4qsx2swDaz57tsHTSz+EMB/vi9Xk5
	b+5LFHS9zy3gESIYW+wTyyA8JJzF/Cr290qDCSm/S+UY+k5LEbNTex2E+mykwF1k
	SdO6u4W1zZqhqeFcV2eBfL8Bo=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHvgSR7HloFskiFg--.22270S2;
	Fri, 18 Jul 2025 14:41:26 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/2] drm/rockchip: vop2: Add delay between poll registers
Date: Fri, 18 Jul 2025 14:41:13 +0800
Message-ID: <20250718064120.8811-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHvgSR7HloFskiFg--.22270S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4UWrW3KFW5tF48AF1rXrb_yoW8Zr17pw
	4jgF12gF97Ga1jvr1xtr4DZw4Yyan7Aay7Gws7t3s7Gr98Kw1DJ3sI93ZYyFyUJ3Z7ArWj
	vw47J39rAF4q9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jweOJUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgSOXmh56BWTowAAsa

From: Andy Yan <andy.yan@rock-chips.com>

According to the implementation of read_poll_timeout_atomic, if the
delay time is 0, it will only use a simple loop based on timeout_us to
decrement the count. Therefore, the final timeout time will differ
significantly from the setted timteout time. So, here we set a specific
delay time to ensure that the calculation of the timeout duration is accurate.

Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 45c5e39878133..d712c5b6b50e3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2066,7 +2066,7 @@ static void rk3568_vop2_wait_for_port_mux_done(struct vop2 *vop2)
 	 * Spin until the previous port_mux figuration is done.
 	 */
 	ret = readx_poll_timeout_atomic(rk3568_vop2_read_port_mux, vop2, port_mux_sel,
-					port_mux_sel == vop2->old_port_sel, 0, 50 * 1000);
+					port_mux_sel == vop2->old_port_sel, 10, 50 * 1000);
 	if (ret)
 		DRM_DEV_ERROR(vop2->dev, "wait port_mux done timeout: 0x%x--0x%x\n",
 			      port_mux_sel, vop2->old_port_sel);
@@ -2086,7 +2086,7 @@ static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2, u32 cfg)
 	 * Spin until the previous layer configuration is done.
 	 */
 	ret = readx_poll_timeout_atomic(rk3568_vop2_read_layer_cfg, vop2, atv_layer_cfg,
-					atv_layer_cfg == cfg, 0, 50 * 1000);
+					atv_layer_cfg == cfg, 10, 50 * 1000);
 	if (ret)
 		DRM_DEV_ERROR(vop2->dev, "wait layer cfg done timeout: 0x%x--0x%x\n",
 			      atv_layer_cfg, cfg);
-- 
2.43.0


