Return-Path: <linux-kernel+bounces-830346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B28B9971A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB25A1B20A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118242DF71C;
	Wed, 24 Sep 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AFSWeblm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C682DF3E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710244; cv=none; b=qfkJXW8be7AWbofuPIEfA9sPSrksv61q0MoLkis0WunJNftbjLSrDQBDmxlTNxby6FQeR4fnaFImLE8YKcHO8SgSebb5qOX0iehRYy+5mrgJTCIABr0UoXc7Lc3e8+2tqRx0S8xOE9fLh/C8f4F0IVZ3reHfW/WN7om32Js1K7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710244; c=relaxed/simple;
	bh=VRbbyb2TqGZ2vmUel9UTJU8dUoPtOcrO+Q97F0QNAUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFIFQoU1V/TNm2CXefaxK8zSrwiAk5duhjT4Q/iWRj/VNLK/74vJ1dL6bzsi4TdNcTL/mrsjKkyFIgArMXfgax1FYXEfTrXlvdlJaEXg3c9r/6ggsCjDhATICnmw7DC9mZ5m+9QkP6ZTEjVAfJ55nLRwfM3m3mu+x71fcmjNbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AFSWeblm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758710237;
	bh=VRbbyb2TqGZ2vmUel9UTJU8dUoPtOcrO+Q97F0QNAUo=;
	h=From:To:Cc:Subject:Date:From;
	b=AFSWeblmyZTvXqZuH6q9hrkH5s0gfXBar4a01bue57y1fGC/DaGtkp/t/DXQ9oinq
	 unWnG4od1U54jaWI3EeirUBKNi+I4dUDE7u0niGG/l8I6CRA4A6mWKwSj3L9R5qap0
	 sD6RjFW+xn0yj0IiVFV4IcRpro3VIqSa2XHkXviZcQ66byosgCmREcICEqwSwoV2DB
	 EzaTUPnyY9yFhiZpLsq2FpKkU+kIXqwjrDpyVMAPZjQx0kMV5Yy4AiHYUu4DopJAEo
	 9b37lkEqfLiYRvF6AEcOicEISkQcZmgLpYSkTTHqvsxa8Rymty8bR0XVP+yEGD7naX
	 H4s655fSBrd8A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F0EA17E068C;
	Wed, 24 Sep 2025 12:37:16 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dmitry.osipenko@collabora.com,
	granquet@baylibre.com,
	rex-bc.chen@mediatek.com,
	ck.hu@mediatek.com,
	amergnat@baylibre.com,
	djkurtz@chromium.org,
	littlecvr@chromium.org,
	bibby.hsieh@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/3] drm/mediatek: Fixes: Stale pointer usage and device leak
Date: Wed, 24 Sep 2025 12:37:05 +0200
Message-ID: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A while ago I've found some issues in drm/mediatek and fixed those
but then forgot to send all of the fixes as I was progressing on more.

For whatever reason, I couldn't continue with more fixes and eventually
forgot to send what I had.
Recent series reminded me about those, which we're carrying in the
Collabora MediaTek integration kernel since .. forever, and are tested
on all of the MTK boards that we have in the lab, including MT8173,
MT8183, MT8192, MT8195, MT8188, MT8186 Chromebooks and Genio boards.

The mtk_dp fix was sent months ago, but got ignored - it's included
in this series again anyway.

AngeloGioacchino Del Regno (3):
  drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration
  drm/mediatek: mtk_disp_ovl: Enable/disable interrupt on bind/unbind
  drm/mediatek: mtk_disp_rdma: Enable/disable interrupt on bind/unbind

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 20 +++++++++-----
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 34 ++++++++++++++----------
 drivers/gpu/drm/mediatek/mtk_dp.c        | 30 ++++++++++++++++++---
 3 files changed, 59 insertions(+), 25 deletions(-)

-- 
2.51.0


