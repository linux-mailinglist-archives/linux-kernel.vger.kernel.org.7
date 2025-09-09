Return-Path: <linux-kernel+bounces-807784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C68BB4A936
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FB01885D67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DD2D4B68;
	Tue,  9 Sep 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhHz5MJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAE2D46A9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411888; cv=none; b=gqSuGSRV+H5VIlfGqIWV5gGS9LDkrVQPXfyui65VafVsb34xn+E3GasPpAN6N1RU3zLl9j6/F8rkkxN5GamBf6HMSYk5paYPwJb4ADEguqG4pOo6vDfcjdDWcojbZeLKjBo11eOGXdPA1T5zUERTfOi7wvGhbbLj2LEo4iooiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411888; c=relaxed/simple;
	bh=3okEo1Cju8Ss53Gs44RL0YJvO36IzhAVTGSex/5UecU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRWN2Jdud3tmpmJwIzBNKfJUPKWsJSvhft0bDXCziE5jnMMfQ5RpSYurh7aY13jaeHpGpBltbzKu+NIUjoXiNIhANcS9ADr1w2EpNwXAd9VLgDn0ZyRAT+l3gqWLwQiSrkE47kRZJcBLlHw/nhQ5cRW7u55lKCo1M80Wx60G7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhHz5MJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15189C4CEFB;
	Tue,  9 Sep 2025 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411888;
	bh=3okEo1Cju8Ss53Gs44RL0YJvO36IzhAVTGSex/5UecU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhHz5MJhCTw0gJNKx5By+cAl3hNw3O0jf1qRXjXWNpSGm1W3E6Agtn3Vzh0x+I16+
	 DnwdLsC1UJ385LSZ1nJP/f66+GZ1y/4dOM4+TCIXLfcy1rR2BuOVXrgnL3QbcaCI3W
	 h2JmOegWVjPOFT4kzTiXxlY84fb687vahI1wKKu9vbxqK/DKE93A1HjS05YK1uK08w
	 9OMGQGSZ1ML9QGGU/udWdP91cebY7s4TWb0s29TQ9nFcPvbfo27fB3024/PHMaSJZ4
	 sulacZjjNz9wAYAuljNw4IpIoaEDuJJqZ8YOjgoXXrLR0WzRWh38sNC0Zt8LhE4kjx
	 06L5bPKKAEo3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvv70-000000001Sy-03c4;
	Tue, 09 Sep 2025 11:58:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roger Lu <roger.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] soc: mediatek: mtk-svs: fix device leaks on mt8192 probe failure
Date: Tue,  9 Sep 2025 11:56:51 +0200
Message-ID: <20250909095651.5530-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909095651.5530-1-johan@kernel.org>
References: <20250909095651.5530-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references taken by of_find_device_by_node() when
looking up the thermal sensor and opp devices during probe on probe
failure (e.g. probe deferral) and on driver unbind.

Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
Cc: Roger Lu <roger.lu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/mediatek/mtk-svs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 48804e1e5a6c..f45537546553 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2176,6 +2176,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
 	u32 idx;
+	int ret;
 
 	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
 	if (IS_ERR(svsp->rst))
@@ -2186,6 +2187,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get lvts device\n");
+	put_device(dev);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		struct svs_bank *svsb = &svsp->banks[idx];
@@ -2195,6 +2197,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 		case SVSB_SWID_CPU_LITTLE:
 		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(bdata->cpu_id);
+			get_device(svsb->opp_dev);
 			break;
 		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
@@ -2214,6 +2217,11 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
 					     "failed to get OPP device for bank %d\n",
 					     idx);
+
+		ret = devm_add_action_or_reset(svsp->dev, svs_put_device,
+					       svsb->opp_dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.49.1


