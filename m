Return-Path: <linux-kernel+bounces-750612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4FB15EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADFA5A55D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED20629ACD8;
	Wed, 30 Jul 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aSbSt/eK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58A296161;
	Wed, 30 Jul 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873101; cv=none; b=UVcyWp9u/lRWlptGCTsSup/Y8NJCv2V6k7uQmaOQ/4uud3mdW4VQUGLaQ3V5ImUi8/TJlkpMqJdUn/+s8xUowzrmMbQYRplvdq/mwzABxWgOgyYTgCGWl+//681g/KOhVC7aoNiEdSdjTNTwuuTGcM0dg0nAmEJOvSg7uhOlDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873101; c=relaxed/simple;
	bh=f6ZCFYCyhXVE4t1Jq2qeu/UDwYm0M4GvQNSvvsr39lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0KuLcUozdBiPT8pwoMm1mmnDkuXyPPVthKmzI0SD/l79SIda5BaC0N3MKqovTMRspoEaCJkgiNTfuZz7PV4W23SIS0hIRXTVm1PIi3sIQiLba/7Rtr1X7mHnQAdwbdQA013wQ4wbbpC24WlXyCowSm1k2jrQsAhIq3xVadxEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aSbSt/eK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873097;
	bh=f6ZCFYCyhXVE4t1Jq2qeu/UDwYm0M4GvQNSvvsr39lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSbSt/eKfxF2kiKjvh85D22A4s655uSbLS8qijhkMCDhmE1/d3MwD6nJ/5OORIpPG
	 caFaAtnVrUHGk9dTm+uLfKI3wnxxyjV4us9MJq+LvjNSLvLG2A06iOGSJ/qj5u7rxi
	 w2zqlWJ2+YswwVvcTkwosuRcyGuF+6jiV69nldTcfAIkSEB/qGFklbtuX1w8rvJOUc
	 s47LNOGnsweYyeRSOIb9vZWPQXtDcnZPjl+aBtKDOUXiAMgyhbefivrTRluto/gs5D
	 mqKIBfIlkhyyn+TmoFim3EVeyTCozAvkKT+a5ny1u6bCNPzTNFNmvbsIHUQfqSUKV+
	 GvDYaUsV8zScg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A705B17E1319;
	Wed, 30 Jul 2025 12:58:16 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 08/27] clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
Date: Wed, 30 Jul 2025 12:56:34 +0200
Message-Id: <20250730105653.64910-9-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730105653.64910-1-laura.nao@collabora.com>
References: <20250730105653.64910-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MT8196, some clocks use one register for parent selection and
gating, and a separate register for frequency division. Since composite
clocks can combine a mux, divider, and gate in a single entity, add a
macro to simplify registration of such clocks by combining parent
selection, frequency scaling, and enable control into one definition.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index e2cefd9bc5b8..3498505b616e 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -176,6 +176,25 @@ struct mtk_composite {
 		.flags = 0,						\
 	}
 
+#define MUX_DIV_GATE(_id, _name, _parents,		\
+		_mux_reg, _mux_shift, _mux_width,	\
+		_div_reg, _div_shift, _div_width,	\
+		_gate_reg, _gate_shift) {		\
+		.id            = _id,			\
+		.name          = _name,			\
+		.parent_names  = _parents,		\
+		.num_parents   = ARRAY_SIZE(_parents),	\
+		.mux_reg       = _mux_reg,		\
+		.mux_shift     = _mux_shift,		\
+		.mux_width     = _mux_width,		\
+		.divider_reg   = _div_reg,		\
+		.divider_shift = _div_shift,		\
+		.divider_width = _div_width,		\
+		.gate_reg      = _gate_reg,		\
+		.gate_shift    = _gate_shift,		\
+		.flags         = CLK_SET_RATE_PARENT,	\
+	}
+
 int mtk_clk_register_composites(struct device *dev,
 				const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-- 
2.39.5


