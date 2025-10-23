Return-Path: <linux-kernel+bounces-866731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C04C0085B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D804450332A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8F30CDAB;
	Thu, 23 Oct 2025 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e+UDP96w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65730ACF0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215571; cv=none; b=CxPI+afzozqsTWjVJEvhoCoZtXYlnQWKYfLJakrsUryjKlICZzunkymnQgaBVU6lSHhoKQkIWnQKhjCic29YB7ndMVvTj8BlpUVgoxn3luaB7dwYbBEWcDEqZShtIAXL15jiHP7ixwVzeCpo+gK++GWdS1mBFq4O8PTYVY7n6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215571; c=relaxed/simple;
	bh=pshY6UD8UkjtnkzdR6DQu8EZEgj8tUqCQiyiG5CEPC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5jNn/ZaY97+mNm2ka9LksgRHgWekzJjsJ7zdwov8nnAEDZJ48Vr02sid0fI4YfaGUKDYKvv+gjCSYXvm9BURMas3BWSjqSrOULTI31cim9nsa5LMgTT4LC3Enz8BBR+r/+EqHQBB905JmnJafiq444yOVe67Z2S4Ns83F4NOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e+UDP96w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761215566;
	bh=pshY6UD8UkjtnkzdR6DQu8EZEgj8tUqCQiyiG5CEPC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e+UDP96wsXrRefn9+r4v66E5EEWev8+78TXxxGBkWC91zFwEwMXoO46du0PRXrCtT
	 Z1KpnNE2SuzchyAmauc0wkW72SQIlDJGnYjBByOtfYZpIne+qjyqc/Hoy2ordEkX1m
	 DuEXoHBZcnd53nkNYB5+atAIccUZTFagsh8VGqkaMS0VxX873HgUiZPmi7lWwLXwg/
	 UQayhlv75ZQOQxsmCTsJZB5BHfhwdIgdDPBq80HrqMqnPDOlm4wGYHQQBBK9SS+4bG
	 ffm36TLa9J8BZu0LLyT6zgUU22y+gBO+Suqk1cqxOg+LReL0FYZQlGvXrRq8e0HkSu
	 OKMd61yuB5QSA==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06BD517E130E;
	Thu, 23 Oct 2025 12:32:45 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 23 Oct 2025 12:32:37 +0200
Subject: [PATCH v11 11/11] drm/mediatek: mtk_hdmi_common: Defer probe when
 ddc i2c bus isn't available yet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mediatek-drm-hdmi-v2-v11-11-7873ec4a1edf@collabora.com>
References: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
In-Reply-To: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Sjoerd Simons <sjoerd@collabora.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215558; l=1178;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=XsbE4tQJMGMBoAPaEfkaTGz6CyRspYxpULZRAhEc9HA=;
 b=jHM0DXftZ9YMARvOzCYpGBWDuH2Gl+WcZOe8zgOOBXZj0LbZwiNoPP8jG7o0e7V6ye5TA6qQj
 Wu0IGEORKtODCLQe9XLRzDcChlVB5986WcjTgjzDojSzICaeSxWYlmv
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

From: Sjoerd Simons <sjoerd@collabora.com>

The i2c adapter for ddc might not be available yet due to e.g. its
module not yet being loaded. To handle that defer probing rather then
returning a fatal error when probing.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index 9cd7add3dd949e2920c876f7bcf990350c42d215..73b1c012aaa8a27168867c515e1d006c88dfff54 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -319,7 +319,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device
 	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
 	of_node_put(i2c_np);
 	if (!hdmi->ddc_adpt)
-		return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c adapter by node\n");
+		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get ddc i2c adapter by node\n");
 
 	ret = mtk_hdmi_get_cec_dev(hdmi, dev, np);
 	if (ret == -ENOTSUPP)

-- 
2.51.0


