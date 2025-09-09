Return-Path: <linux-kernel+bounces-807783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AACB4A926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FC33B3B86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58F2D480F;
	Tue,  9 Sep 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYEL1OZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F72D3EEE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411888; cv=none; b=YuUaF7c4AtofsWNxmBtFChuFBvCFWh9l8SKKMQExg+PC5YIyh7SMkleyvIWpMZ3TuH5F1m2H4FZxk+1mjkRpiyBVNQ7MigAnApP710elZtsOoli52kiFEXqclIG8UPfdcwWzBBjeKCOHv2mYcF1DPe8il6oGSYmjIu3VHr92FJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411888; c=relaxed/simple;
	bh=kDtTh6feFeUUls9s9EeYPr0volqLeNaDI/7jY9MX8bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hezl1OBRoMtHyNCycM4XJ9NDG8FYTqDY9rE4WgmEnA7UAUaRU5ZUEHmCj8mOiNCDJwrcC3AdKdzutMgBqvOrW9HcUBKyEbs27MpzSKeb0ll5Gq2iaXLrxqBy5GrB72lsmG9V50HJtgH4Il0ykvjNftrhtgM5XjS1yfvxkC7FLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYEL1OZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED6CC4CEF7;
	Tue,  9 Sep 2025 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411887;
	bh=kDtTh6feFeUUls9s9EeYPr0volqLeNaDI/7jY9MX8bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYEL1OZ+a5rE0c9nhkupob9mMjTtrtrOZdz3AmEmVELnfnRzrptQLwlV0Uyc1EkFH
	 xcmoEVK5Fzavzo7IohD5PBKGdMfBwPUAcGK6KlJixzyzhHM1Ka/V6AU/d7zH0dzkTU
	 VIHiOQbHujPNpgHABpRzZ+3E9Q2COAKReh5A3u+a5bcGj2eEajuK+9FK6ITuLI62Rs
	 t67t1No2B91M8nFeKnw3HY4HmjuEK9yaGqXb6bNmjLO6WNHTsoUe35dHWQQlIxuPI+
	 sZ/c14EWbCpxg2lWKOzdVustr2EyS1XCBDA5d2PIJqeKja4u5/5iXyn2ZmI3M82bc0
	 2oBmItzano5xQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvv6z-000000001Sw-3vY8;
	Tue, 09 Sep 2025 11:58:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roger Lu <roger.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
Date: Tue,  9 Sep 2025 11:56:50 +0200
Message-ID: <20250909095651.5530-2-johan@kernel.org>
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

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Cc: Roger Lu <roger.lu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/mediatek/mtk-svs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 7c349a94b45c..48804e1e5a6c 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2165,6 +2165,13 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	return dev;
 }
 
+static void svs_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
@@ -2216,11 +2223,13 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
 	u32 idx;
+	int ret;
 
 	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get thermal device\n");
+	put_device(dev);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		struct svs_bank *svsb = &svsp->banks[idx];
@@ -2230,6 +2239,7 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 		case SVSB_SWID_CPU_LITTLE:
 		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(bdata->cpu_id);
+			get_device(svsb->opp_dev);
 			break;
 		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
@@ -2246,6 +2256,11 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
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


