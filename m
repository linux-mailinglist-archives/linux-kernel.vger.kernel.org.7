Return-Path: <linux-kernel+bounces-833327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1358BA1ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F10623314
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11FF31353D;
	Thu, 25 Sep 2025 21:49:20 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D321DBB13;
	Thu, 25 Sep 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836960; cv=none; b=cZ/kaO7Z1og7Wo2+1PIH9vy8CoPn10ofZksaJ/kAY3GUZ1WorgFEQ7NnR0Rnz8cweKDlQDUrWnAabyvCHUk+yk5niqizXwKh59GJ27KmIcImXqn4l0TYPPtfbrP438XXxbhNqx2fbq/h1H7awHmM91ioQkU5m9aezWjk0zcOvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836960; c=relaxed/simple;
	bh=+j8go8PSeVaCixIQHcFuknV4nOFx3ByAqaV1AdWdg2s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cXaigIr/QHC/lotENOAQkBgc4xamEgLi/yy4FfeqZBUCo927EfvlzpOyMVdd62G73AzV/NKU6K0oFq4w2QktVPtcFpdJWNusrSuDMjk4SRvyttqYE8RcKKsbWnIVbUxWbLjhqEBjw8XuTziYUdztu1gL/VB8RLppqnHxeOLC25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v1tpp-000000000qK-1fL9;
	Thu, 25 Sep 2025 21:49:05 +0000
Date: Thu, 25 Sep 2025 22:48:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] clk: mediatek: mt7988-infracfg: SPI0 clocks are not
 critical
Message-ID: <a801e8fed69ab8f9e61970bc8ed2e2c0b634e8bb.1758836835.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

SPI0 clocks have wrongly been marked as critical while, probably due
to the SPI driver not requesting them. This can (and should) be addressed
in device tree instead.
Remove CLK_IS_CRITICAL flag from clocks related to SPI0.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2: drop Fixes:-tag

 drivers/clk/mediatek/clk-mt7988-infracfg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index ef8267319d91..c40e18c27f12 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -196,12 +196,10 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA2(CLK_INFRA_SPINFI, "infra_f_fspinfi", "spinfi_sel", 10),
 	GATE_INFRA2_FLAGS(CLK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck", "sysaxi_sel", 11,
 			  CLK_IS_CRITICAL),
-	GATE_INFRA2_FLAGS(CLK_INFRA_104M_SPI0, "infra_hf_104m_spi0", "infra_mux_spi0_sel", 12,
-			  CLK_IS_CRITICAL),
+	GATE_INFRA2(CLK_INFRA_104M_SPI0, "infra_hf_104m_spi0", "infra_mux_spi0_sel", 12),
 	GATE_INFRA2(CLK_INFRA_104M_SPI1, "infra_hf_104m_spi1", "infra_mux_spi1_sel", 13),
 	GATE_INFRA2(CLK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck", "infra_mux_spi2_sel", 14),
-	GATE_INFRA2_FLAGS(CLK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck", "sysaxi_sel", 15,
-			  CLK_IS_CRITICAL),
+	GATE_INFRA2(CLK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck", "sysaxi_sel", 15),
 	GATE_INFRA2(CLK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck", "sysaxi_sel", 16),
 	GATE_INFRA2(CLK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck", "sysaxi_sel", 17),
 	GATE_INFRA2(CLK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi", "sysaxi_sel", 18),
-- 
2.51.0

