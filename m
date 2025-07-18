Return-Path: <linux-kernel+bounces-736332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F95B09B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C2216F110
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DE213E66;
	Fri, 18 Jul 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nU/FIJyI"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DD20B80E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820915; cv=none; b=dDsJMp0ZTm5dklWeTPJEu2WYMwr2Ai1+kuqYq2YnJSef2jv7NEUtWkP6Un1+JBAfI93zJdFhuLiMfgdx9N8ZlroSLKU9gnGfKDiNNARGGTz9mzqAUOtzlo2c1nokUhvURqbiOFmDUbw9ls8UKzw97W2OlY1EzsQHNDUieA78I1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820915; c=relaxed/simple;
	bh=yQlwlLIPsTnFXlr23HS3pbunsW7Wzicxq3JImvbIBDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coLHypi7OhsvqHddUp9D76sEAZ/v1uMGp9anmfZDeQSu0Jb96flJiUc6P1L4xEpIHG3UHcG11bFLbe8SxgXGl8trcu3olC1jFnhJj+9FjW0Njs+c3DOTqQhS86ERTDoXKMWPNuNNdgBYr0uFaP3xNfvYdkPDsc0VmhenaamyI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nU/FIJyI; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rS
	FFPUD/qWfzfiLjVHrEGF4oSBguPRgle0bRPJlq2Zk=; b=nU/FIJyISJGBOgiBCr
	hdd1/XC1VbKGG5SN561BzEKy5s8ppxS3JzDPgbNKxkyM1Z9Xo5KHIK3Cp4ao6ci+
	iJJdeulgXFTdliEEG+Sv/0h+VGrE4Z8k3ZjNdW1jjlbChfKU9bopOSU8WRRtI8VV
	fBHbWI7cvmr+Z/37pRPC6F8LA=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHvgSR7HloFskiFg--.22270S3;
	Fri, 18 Jul 2025 14:41:27 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 2/2] drm/rockchip: vop2: Only wait for changed layer cfg done when there is pending cfgdone bits
Date: Fri, 18 Jul 2025 14:41:14 +0800
Message-ID: <20250718064120.8811-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718064120.8811-1-andyshrk@163.com>
References: <20250718064120.8811-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHvgSR7HloFskiFg--.22270S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw15Zr15Ar4UXr13Aw47urg_yoW8Zw4Upa
	15CF42gas7GrWYv34vyF4kZrWay3ZrAF4xXws7Kw1xArWrtr1DG39xurn5Ar15JFn7uFWY
	yrWDXF98uFWjqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jc189UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgSOXmh56BWTowABsb

From: Andy Yan <andy.yan@rock-chips.com>

The write of cfgdone bits always done at .atomic_flush.
When userspace makes plane zpos changes of two crtc within one commit,
at the .atomic_begin stage, crtcN will never receive the "layer change
cfg done" event of crtcM because crtcM has not yet written "cfgdone".
So only wait when there is pending cfgdone bits to avoid long timeout.

Fixes: 3e89a8c68354 ("drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index d712c5b6b50e3..02d93190e9850 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2106,6 +2106,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	u8 layer_sel_id;
 	unsigned int ofs;
 	u32 ovl_ctrl;
+	u32 cfg_done;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
 	struct vop2_video_port *vp1 = &vop2->vps[1];
@@ -2260,8 +2261,16 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		rk3568_vop2_wait_for_port_mux_done(vop2);
 	}
 
-	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel)
-		rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel) {
+		cfg_done = vop2_readl(vop2, RK3568_REG_CFG_DONE);
+		cfg_done &= (BIT(vop2->data->nr_vps) - 1);
+		cfg_done &= ~BIT(vp->id);
+		/*
+		 * Changes of other VPs' overlays have not taken effect
+		 */
+		if (cfg_done)
+			rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+	}
 
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
 	mutex_unlock(&vop2->ovl_lock);
-- 
2.43.0


