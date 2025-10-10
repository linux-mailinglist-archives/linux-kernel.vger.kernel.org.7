Return-Path: <linux-kernel+bounces-848778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5EBCE8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60493355197
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74B279917;
	Fri, 10 Oct 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gm67Tmfk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0B301473;
	Fri, 10 Oct 2025 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129289; cv=pass; b=pZYK0JPOFDCVwJPi2MpP7EhcdPpcojsp+dxIGwQseHtYvsV4ZQHYeOZdpPSW8JaATRDbsTSyVIupB300T718g6HWoWYHyG9xaRiwfqvUH3rvWkGOpUmPcl6pPlsl702Zxp8nmMOHfH+HZps3sPdOEha4vxLP8vY3XYIHr26COV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129289; c=relaxed/simple;
	bh=cLuLu5AbyJVxiyt0gNcL6gvKI2KXKXOQe4f3O/dFThU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omNxE4gsmXcdUOgEk6VOleDWGEBuxLgGbtiJkp3zxJrxK5F9vEQIP1rO+C9QmGuRvQMIoqLpMCo2Yi41IlvEdYKAyO3DVyvMizjX5GYNwHuupMfEDNVyPf/DFNTMXIbMM9jVfacplrtDujUpiS2p1BvfCdL8TVYmzexCAw663Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gm67Tmfk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760129263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cOk65gf0X1V9g6/zByQrw6wOYqnTtYytkS1mjAHQcQmJVpBYZNBgVPoaslSvXFCYdsr2K1UsJAoCz+LNUYbcXS4OGwf+I+4Ot69ZP1/TBEgTyX9cKo89OOy/SRalT68nFFE8Ui6TWE+TAuyQjnCl1sjp7S5l4wOaQn99eLQo2bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760129263; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zsTyD71EnFRPFV+ca+1K7KOHMBUKKghpyvfAY6H5pw4=; 
	b=Y+G3b/pebbrph/GRYDEoqeQGL3CtNpqq31KM3kgNfm4AH4RVnwoHz6eujXEeuN00y6mgm+gnah4sGeop8hj+uOl/ZyUkggMwjFOH73WcZDFYYaDPdecp3oWvOJxCP5U8n8exXjC035DRU6GL0d0BNJ5TvvbC0q4vRXOX1Xwvj24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760129263;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=zsTyD71EnFRPFV+ca+1K7KOHMBUKKghpyvfAY6H5pw4=;
	b=gm67TmfknvarYMNvjIQqwMXpqoNT5KADTQOhCKHPvjmXkuffqX0KMihMiJtiz+xR
	jjHDGK7c6regGDveHehmVM39oPHFwDW9caUZInRCnd6YCvwUazmWtSnWGuzUjX4cqFO
	9njs/D7ss27HK5dtPYlRtrpIAnXlahPi829cMf0U=
Received: by mx.zohomail.com with SMTPS id 1760129261611721.6914981601944;
	Fri, 10 Oct 2025 13:47:41 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 10 Oct 2025 22:47:09 +0200
Subject: [PATCH v3 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-mtk-pll-rpm-v3-1-fb1bd15d734a@collabora.com>
References: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
In-Reply-To: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
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
 linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
operations, such as setting the rate or switching parents. However,
another operation that can and often does touch actual hardware state is
recalc_rate, which may also be affected by such a dependency.

Add parent enables/disables where the recalc_rate op is called directly.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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


