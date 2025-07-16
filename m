Return-Path: <linux-kernel+bounces-733572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DFB0767A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B9B188D0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8D2F5323;
	Wed, 16 Jul 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XoEVx3gX"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6128C2CA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670630; cv=none; b=PW3LQtiysH0LkwRTQctDaALvLlUZzvug3LU45xuiRNvSR4XkvsEx6sAWFxS1oNFoiQ4bHE7VzBHkAkBZanrirZKXrkFeC1SVv2Aj2W6Jh3Zod3fDz7zCKId6qrbEs4sj5WpcGXljwIU9OhwkiYBeUUZ2YpFaYsDGqJUMg+PUiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670630; c=relaxed/simple;
	bh=AN62lcBWY69uwEkPF1uDE2Au3sGNpTVZStdoirzCP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRCJy1zUu7L6TdnQhY0ZrkPxmWhFFIumJ2Ifv4r6mGrbg4B1Vz2br7a78vdYiD0W2ED0tigsjlUnPJCrLn+YP5DNT30NU8wp4WV7W6kBVh42eM39ZdnEJKKgUWHs+0XoSSc8zjN6B+okl2LrcB7s3CNDkVjNQmSPSixfobFF3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XoEVx3gX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qp
	Y2tXiGnHNxTZTvdSzkjoCg54zO4OlGJ2IYtvRcdfk=; b=XoEVx3gXhw40Dt9AgC
	HfIIgDMIC4T+UWsiFoWhH7I1TTF6vdKFNV/hDc8m3z0p2K3GIz0gxm1dYkF5ze+/
	390RXrGTS72qSty98fNYhZ4qzniqMMtMK1rhl10bB4PJF6GR1lqqYDfXK1DOeVB+
	VtDxJHNaqvRb7LIEyKkv2sk1k=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnz4VkoXdox0oSFQ--.65528S2;
	Wed, 16 Jul 2025 20:56:09 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: simona@ffwll.ch,
	sfr@canb.auug.org.au,
	airlied@gmail.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] drm/bridge: Describe the newly introduced drm_connector parameter for drm_bridge_detect
Date: Wed, 16 Jul 2025 20:55:55 +0800
Message-ID: <20250716125602.3166573-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz4VkoXdox0oSFQ--.65528S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Ww4UJFW8GFW3AFW3GFg_yoWDuwc_uF
	nYq34UJws0kr98Kr17AFWfZ342kw18uFZayr1kK39xtrsxAr18Ja42qry3Xr1xAFy8AFy7
	J3WUGF47Ar1IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKAwIDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAWMXmh3ljHbzwABsq

This fix the make htmldocs warnings:
drivers/gpu/drm/drm_bridge.c:1242: warning: Function parameter or struct
member 'connector' not described in 'drm_bridge_detect'

Fixes: 5d156a9c3d5e ("drm/bridge: Pass down connector to drm bridge detect hook")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 drivers/gpu/drm/drm_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index dd45d9b504d8..4bde00083047 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
 /**
  * drm_bridge_detect - check if anything is attached to the bridge output
  * @bridge: bridge control structure
+ * @connector: attached connector
  *
  * If the bridge supports output detection, as reported by the
  * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect for the
-- 
2.43.0

base-commit: b5e5ea72502e635ae10c33dd877c918c880f7bf0
branch: drm-misc-next


