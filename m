Return-Path: <linux-kernel+bounces-731221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40475B05136
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB883A60E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3E2D0C6C;
	Tue, 15 Jul 2025 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eptu6Ys4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4B1A275
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558546; cv=none; b=eoYhh8MExBqos18AU7+OBnIo/xI99yO4zrO6lu1trttsskVukxJiZ6065GjjO/aJme6kZoNHg3/w12X3VRUcwUsVHg4m3bY+S+9bRKvBAz2SU55ktiRN70/gSAjq8DY+Fs0W2vSZuRBz9QatemuZ2WydJr1WRTxM5zGyY0eCPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558546; c=relaxed/simple;
	bh=4ibJsuuzzMOF1rGeMgi5qdlEtjctQAtKQJ6FUGmK8KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBAeESpJxnHivaMi3uAjiPmSEcsc20LlnWZeLqhVfaLqY3inb/scGm73f+jBpoCDc8EFwOSmz/9xiBlou69Nr+RCG+KV2TIZrWaVMkjyZ6hjuEDrb4V/fvUz2eM65Hnaz4P/SOPg4MlUZNfMXXoGeg+fmu7QhrNI8z7S6e3nLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eptu6Ys4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rm
	P52XZydMaJnEINWARLUUCcm7vMaBebaXr3L+WXnCY=; b=eptu6Ys4Xqt2RXkbf2
	7+InG8AvpiAnWNK2858j5a/08IDZhY5JBWgJo/fHm+3OTttYzPTqpxBQlyDBuqwQ
	Y5/PXP/xAPEzps0pVrle65cBcmHostlgW0/GuGnc3/3IlVm9v7VSqDrZgVCcVeRz
	btZx35hJj5A9/19bM3o/yv1uI=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXiRyO63VoLNw5Ew--.13369S2;
	Tue, 15 Jul 2025 13:48:02 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: simona@ffwll.ch,
	andrzej.hajda@intel.com,
	airlied@gmail.com,
	ian.ray@ge.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	martyn.welch@collabora.co.uk,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	peter.senna@gmail.com,
	rfoss@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andyshrk@163.com>,
	Dixit Ashutosh <ashutosh.dixit@intel.com>
Subject: [PATCH] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix a compile error due to bridge->detect parameter changes
Date: Tue, 15 Jul 2025 13:47:52 +0800
Message-ID: <20250715054754.800765-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXiRyO63VoLNw5Ew--.13369S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykXFW5Xry5KF4rCF18Grg_yoW8XryrpF
	W2gwsIkFy7Wa15Ka1UAFnrXrn0y3WvqFWfKrWIqw1Sva40gan8AFs8Jr9rXF1Uu3sxCFn8
	ZrnrXrs3GF18ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRfb1nUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgGLXmh15WKgRgABs7

Fix the compile error due to bridge->detect parameter changes.

Reported-by: Dixit Ashutosh <ashutosh.dixit@intel.com>
Closes: https://lore.kernel.org/dri-devel/175250667117.3567548.8371527247937906463.b4-ty@oss.qualcomm.com/T/#m8ecd00a05a330bc9c76f11c981daafcb30a7c2e0
Fixes: 5d156a9c3d5e ("drm/bridge: Pass down connector to drm bridge detect hook")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index de57f8a9e98c..c9e6505cbd88 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -142,7 +142,7 @@ ge_b850v3_lvds_bridge_detect(struct drm_bridge *bridge, struct drm_connector *co
 static enum drm_connector_status ge_b850v3_lvds_detect(struct drm_connector *connector,
 						       bool force)
 {
-	return ge_b850v3_lvds_bridge_detect(&ge_b850v3_lvds_ptr->bridge);
+	return ge_b850v3_lvds_bridge_detect(&ge_b850v3_lvds_ptr->bridge, connector);
 }
 
 static const struct drm_connector_funcs ge_b850v3_lvds_connector_funcs = {
-- 
2.43.0

base-commit: 9a2533ba5055b4c23f4bf1c4d87154f26a2c7a94
branch: drm-misc-next


