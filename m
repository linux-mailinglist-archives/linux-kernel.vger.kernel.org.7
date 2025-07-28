Return-Path: <linux-kernel+bounces-747675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34678B136B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EEB17A9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F7255F28;
	Mon, 28 Jul 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lyvXZ+V/"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1E22756A;
	Mon, 28 Jul 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691412; cv=none; b=aL59qgKOtIgLA2R4T2Ga6eb83+25vn2Z+vQbuDk3XUwgHthVeX52vHoxOqVM8CqvJIsJHQT+AtvurBowLQPUf0hzKmtkAAvu+95+gDWAdXKquF0cF/r4dOKeH5zo3mm+MhPGrFtBCNvy4ac6LfV3gevAZJhM4JgcCVf9CQkEzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691412; c=relaxed/simple;
	bh=BR44zh+SJhNF0RoG+eWxZ9vBGrtj7Fe+Ah9m0mJzODU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJOAjG5Ixo9jjnqU3ggsTQbkvgLW1jXfabemSB8hQOj5HFSypB0kJAkDizWwj5aBQcNl63gr/LJYgFsCvrAGQQeUqEpPW65f3RXdXzKwvKxL/NR6ciYvYBObNpp0c++2eQ7+1woJ1f3lNroeQscidCk45vofioM4xpUVejcA/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lyvXZ+V/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c8
	TbWEVDRePQ3AnKdtwVwl22ZdGy/aRprexuwiKErqQ=; b=lyvXZ+V/sPfHYSNTdh
	SDDBlvMk2sBbWPh/jY5YGTc4zGxcOw9p9LnY9mou4arHoI35j+t3EHEMD4DhwIX4
	JPQ1dreJcYz0zdltTMvQ7eHAyf00AY5E1YXfXCYQn0AkF+0/CTL+QI2dTwlmB4IJ
	VTz3YGP2C0u78j2nL/sw2uFt4=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn0Oy_NIdoxboRIA--.27423S8;
	Mon, 28 Jul 2025 16:29:03 +0800 (CST)
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
Subject: [PATCH v6 06/10] drm/birdge: simple-bridge: Add support for radxa ra620
Date: Mon, 28 Jul 2025 16:28:31 +0800
Message-ID: <20250728082846.3811429-7-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728082846.3811429-1-andyshrk@163.com>
References: <20250728082846.3811429-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn0Oy_NIdoxboRIA--.27423S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw47tr48Jr4ftr4xKrWUtwb_yoWkZrg_uF
	nayryUJr45XF9YgF43Zw43A34Iv3W8urZ7Wr1vgrZxAws3Zw47W39rur9xZ34fAF10yF9F
	y3W3JFW7Ar17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn0zuJUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMw2YXmiHLt29IAAAs5

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


