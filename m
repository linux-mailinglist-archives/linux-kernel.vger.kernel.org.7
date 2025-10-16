Return-Path: <linux-kernel+bounces-855845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D876BE2735
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25091A62646
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1E31B105;
	Thu, 16 Oct 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qFL1hklk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167231A059;
	Thu, 16 Oct 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607607; cv=none; b=RhCI6PNr+vd79GgPCO/HEswpqk0Td7529bJvthv+z7FK1k0KZnNvDwJIy9FXhV+YMXyHqUWH/bsd1n+aFakKq8PkTXal28nSKXzYOdvDCI1PYrNSAeRXYfWmhmcmZAvs5JLj93F275OlLiaCUSoFjWyCpUAgdBp1uJ2M5sJbaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607607; c=relaxed/simple;
	bh=RVbex/FLno2le4rsAHEctfKuvWs4AdkH2KC1lA9P7ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsocC+FSYiID2+e7zE3JiRbjYpiyX9dfAGEuTm96zX/OkdxFBQE9fLOhLZv8sb8WucxBnALydln4IW/B0wJ5fFgWSmZmVQqzU9FaW6MILNtLL8Jnm2foCWJSWfWDoUFADhfqmOGDteNXHgI1LVnO+eAoLTDw0a8t/CSNTvi1P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qFL1hklk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760607603;
	bh=RVbex/FLno2le4rsAHEctfKuvWs4AdkH2KC1lA9P7ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFL1hklk0IsKQI8JaIU+2cfm5M5jJYGk8aXq2s2zeRwf+mztfXQyggTFwIXEp0jf8
	 zAocx/D6+OpuBiP6sGf3g/oCSHpnBwXHrHZTDQgYmIgSRIpZCyAvy4cqDMmuveGE84
	 gFsuzyFz2JcRKV7/Fyaf0qZ3pttsU1T2KgnXk3tFnevnhjXFbPuhTzb9hxaYOapYPR
	 HhcvBOzbuUqQi7+LrCuG0/QTV3CN9zXAEcuF+ECT090yK+YCAKVXO2YVb1UwIcmKfJ
	 1mkNP0GNl/Djlx5kPBiGa0y2VgE/KR8WmCmMZCxfjk4POjjklbBYxkGjiZy1L1LMHQ
	 oqfnZIgZtTRgQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD05B17E1407;
	Thu, 16 Oct 2025 11:40:02 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	hsin-hsiung.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 5/5] spmi: mtk-pmif: Add support for MT8196 SPMI Controller
Date: Thu, 16 Oct 2025 11:39:49 +0200
Message-ID: <20251016093949.127326-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
References: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the SPMI controller found in the MT8196 SoC:
this supports SPMI 2.0 and features two SPMI buses.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index ad7b0cc9cdaa..719753651234 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -636,6 +636,14 @@ static const struct pmif_data mt8195_pmif_arb = {
 	.soc_chan = 2,
 };
 
+static const struct pmif_data mt8196_pmif_arb = {
+	.regs = mt8195_regs,
+	.spmimst_regs = mt8195_spmi_regs,
+	.soc_chan = 2,
+	.spmi_ver = 2,
+	.num_spmi_buses = 2,
+};
+
 static int mtk_spmi_irq_init(struct device_node *node,
 			     const struct pmif_data *pdata,
 			     struct pmif_bus *pbus)
@@ -834,6 +842,9 @@ static const struct of_device_id mtk_spmi_match_table[] = {
 	}, {
 		.compatible = "mediatek,mt8195-spmi",
 		.data = &mt8195_pmif_arb,
+	}, {
+		.compatible = "mediatek,mt8196-spmi",
+		.data = &mt8196_pmif_arb,
 	}, {
 		/* sentinel */
 	},
-- 
2.51.0


