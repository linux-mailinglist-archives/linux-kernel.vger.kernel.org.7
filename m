Return-Path: <linux-kernel+bounces-845732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E723DBC5FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4802427698
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45A2EB862;
	Wed,  8 Oct 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kbbkGIue"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B0261B70;
	Wed,  8 Oct 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939666; cv=pass; b=PvPtxOMqYTHpE7jVDsc7EMHOKjIjqDIPyK06LhxrIQW0sik5k160oCjYJ+P1P0BYzX6tvuXn/ug+H6VQEFQukzMbspNv89yOrHeq9SckZtWCLTZOKoypmUYLIKKdPgqwjBKnAWzm9R9UzMMQ6mXUSZz5Qm/4wQfff4xykiOAL0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939666; c=relaxed/simple;
	bh=9EJLA3QVNK6rhqUVyyWSK785s4u1phkatcbT5430j18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STvEZwXd563Nym5TK20RJ3aUSMAmjgsX4DRWke4Vo7/Tzj2YCReuxE1it5hLtsGjBvpsO05DodKztiFN0Jc5aQWtIgMgJlxtLLjuLL6GOUYrZxPwphw7J7CXb1lLdW88HdDsIZPyNwJ80H80dZVUxQQtcvv45eEBLJKDCSibqq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kbbkGIue; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759939551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SsVJW/jBc4xhU88WK+icPeqXFzWpsp52Jss2hT3mrMRvyfqPIZdGCDgIaPCDsKtb8wVB42s1uxmrSlybQesWz8DxfJP9dMZMZF6jQvJ9m9f/QMf/m5fQ2oZ0ASN63ZmtXvlcYfLmPxQYSpj6W5VpVMoLyrD+YDpjq6gfRkN0/xU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759939551; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KAEUNIM+MOwI31HF4BnvUSBiOCBHcJPGV+SFXgxbBtA=; 
	b=b4QTnt5WL73ZpuyrD/VZstO0xD36HCXAxX/432g2I868gDuYbtpyuzOcw1oFn9w/QME7Zz8Ak2IVCxdmBSVGvaGQ/+f8Q/huSMTnLgZ/ojL+XeAJhsEdP1bw8eQxguKAmlO0+Ij1XnmHbViMyCKMg9qVEYLzKA5WqrMMfnGqe2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759939551;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=KAEUNIM+MOwI31HF4BnvUSBiOCBHcJPGV+SFXgxbBtA=;
	b=kbbkGIuevmaBPxoclGVxsw99bBxLxRLlISpktfgXZ6AAfk6KQxUA4vYk4kUf/ncc
	VWrTIsycvbtNSgW6zGgLEzfHlo9zShBNPW4hP1VJdN/uG6+u/nHGx5OIzGahKLjMocK
	Smz4WC+EDxgdTPDrVkVPB6bqLChrHoE91HjttaZk=
Received: by mx.zohomail.com with SMTPS id 1759939548907265.7349199019691;
	Wed, 8 Oct 2025 09:05:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Oct 2025 18:05:35 +0200
Subject: [PATCH v2 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-mtk-pll-rpm-v2-1-170ed0698560@collabora.com>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
operations, such as setting the rate or switching parents. However,
another operation that can and often does touch actual hardware state is
recalc_rate, which may also be affected by such a dependency.

Add parent enables/disables where the recalc_rate op is called directly.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/clk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85d2f2481acf360f0618a4a382fb51250e9c2fc4..1b0f9d567f48e003497afc98df0c0d2ad244eb90 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1921,7 +1921,14 @@ static unsigned long clk_recalc(struct clk_core *core,
 	unsigned long rate = parent_rate;
 
 	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_prepare_enable(core->parent);
+
 		rate = core->ops->recalc_rate(core->hw, parent_rate);
+
+		if (core->flags & CLK_OPS_PARENT_ENABLE)
+			clk_core_disable_unprepare(core->parent);
+
 		clk_pm_runtime_put(core);
 	}
 	return rate;
@@ -4031,6 +4038,9 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	clk_core_update_duty_cycle_nolock(core);
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_prepare_enable(core->parent);
+
 	/*
 	 * Set clk's rate.  The preferred method is to use .recalc_rate.  For
 	 * simple clocks and lazy developers the default fallback is to use the
@@ -4046,6 +4056,9 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = core->req_rate = rate;
 
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_unprepare(core->parent);
+
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
 	 * don't get accidentally disabled when walking the orphan tree and

-- 
2.51.0


