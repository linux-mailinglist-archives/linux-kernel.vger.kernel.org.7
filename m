Return-Path: <linux-kernel+bounces-733280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1EB0729D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2EF3AAB45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CC2F4318;
	Wed, 16 Jul 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qNTcbync"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB792F3C19;
	Wed, 16 Jul 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660353; cv=none; b=Hl6Wg42LTF3TDKNgOW6oeEEhJy6jDToGLzIAxYPdWa+FP4Fy7n9YV6zzLO4Ldfpail8MIjsGW+5A4mox6yHOqkcKuCC5qLrfKBV2Gj3lzwEwe76WuVrlgTJx/x7fTJQNLf6jcygc6khISa5mHQg8MvDp1O9yI3QIYp8qEOjhcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660353; c=relaxed/simple;
	bh=BR44zh+SJhNF0RoG+eWxZ9vBGrtj7Fe+Ah9m0mJzODU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Owb8XpOsOYex7winY1KePJVAfCutoXR+QG3jk7RaOEvwG5RXNeOytJw+XHcc7YltrnzrBi/9/47KrVS2fj5wgAlTTfx8slmsvQWDe+efE/giRFjC2yxm54w8rdIHMc7denTEp8GMxQayr1Yr26Be5Kv0zE1Y/6jnVxQNIN85JLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qNTcbync; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c8
	TbWEVDRePQ3AnKdtwVwl22ZdGy/aRprexuwiKErqQ=; b=qNTcbyncVhnc5zX2H2
	m0rvzcLyPrJbqtODyCQZ+eqPaWkslzeqhT+PXyrKnijRQkZqvjAPtH7/eCGY5Xb1
	v6tzzIfJB7X9VVVRUg+4QonLNJ6VPJB3RhHbjqYMn68KQJOUCCxjdRRW6fY0xT/B
	oJQldsox0xRmblKZHArKqDOFw=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH0s46eXdoG0BuFQ--.1985S8;
	Wed, 16 Jul 2025 18:05:05 +0800 (CST)
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
Subject: [PATCH v5 06/10] drm/birdge: simple-bridge: Add support for radxa ra620
Date: Wed, 16 Jul 2025 18:04:33 +0800
Message-ID: <20250716100440.816351-7-andyshrk@163.com>
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
X-CM-TRANSID:_____wAH0s46eXdoG0BuFQ--.1985S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw47tr48Jr4ftr4xKrWUtwb_yoWkZrg_uF
	nayryUJr45XF9YgF43Zw43A34Iv3W8urZ7Wr1vgrZxAws3Zw47W39rur9xZ34fAF10yF9F
	y3W3JFW7Ar17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-18DUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgWMXmh3cPPqbgAAsd

From: Andy Yan <andy.yan@rock-chips.com>

The RA620 is an active DP to HDMI converter chip, basically
no software is involved to drive it.

Add it to simple bridge to make it can be find by the drm bridge chain.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---

(no changes since v3)

Changes in v3:
- First introduced in this version.

 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3d15ddd394703..1f16d568bcc4e 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -261,6 +261,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &default_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "radxa,ra620",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "ti,opa362",
 		.data = &(const struct simple_bridge_info) {
-- 
2.43.0


