Return-Path: <linux-kernel+bounces-891420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DCC429FA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CD874E3134
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD012DF3D1;
	Sat,  8 Nov 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="vYnMheWx"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C201D61B7;
	Sat,  8 Nov 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592868; cv=none; b=q2jR29DsfL+a9jSKCrWAVKCFTVXfieEuFQvJs2m8mcbA6nF9R7kbqmhEf+vgxH6MqSwZ30P5d88HvNW6dHhtgw/EQI51N5SCAn0oUVAFqJ+50dsprS7Pnw8Mh/h/0kRa5KSaa468kzwM2NJofvVH2OQAXBp15HN1oeHxqlSaxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592868; c=relaxed/simple;
	bh=yGnBbrMMINnmH9GttPyMTSVm2IgfOZLXzrUAP9sQ24w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKshNayLrQ/eqWfDHuLYX1QzoLzByKhgONwOsgIjc9L19+W5BJAaPweO4385aKJkkD103CL/5FAXWXzGWzUYmwq5PorviMQNMZK3ZLKqgpH4dsmc8UpE7OM7imJ1PpEj9GslacpRy2RXV7FjYUE8VsIKB10Hru3H3vcL9GVJfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=vYnMheWx; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 61B22100823;
	Sat,  8 Nov 2025 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1762592856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1CyknkAme4elZV84/7MK05eFN3kQAntRvNuaIK/zCqc=;
	b=vYnMheWxSMz8itfJI9sBWPH1o2+/WDByDnUay0zuG7rM5ziF+ocP284TttKHXLGhCUTqYl
	tXeI2VMgOWgAT61e7yLUa9fecAiCa8ufoPzVqdCVW66jgJA8Q45bVlmp8K41rNANbiz9Jr
	LnaiMtpPdTzQl+b4t1pu6ghhuuQJN1Q=
Received: from frank-u24.. (fttx-pool-217.61.148.22.bambit.de [217.61.148.22])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 331521226CD;
	Sat,  8 Nov 2025 09:07:36 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt7988-infracfg: fix USB port0 function for U2 only
Date: Sat,  8 Nov 2025 10:07:25 +0100
Message-ID: <20251108090726.7787-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sam Shih <sam.shih@mediatek.com>

Fix the functionality of USB port0 U2 when U2 is enabled without U3.
This change addresses the issue where port0 U3 is shared with PCIE2,
ensuring that the port0 U2 function operates correctly without U3 support.

Additionally, add support to enable the U2 function instead of disabling
the entire USB port0 in the configuration for the 4 PCIe case. This
change ensures that U2 functionality is properly activated.

Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/clk/mediatek/clk-mt7988-infracfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index ef8267319d91..da4ad365e30f 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -229,8 +229,9 @@ static const struct mtk_gate infra_clks[] = {
 			  CLK_IS_CRITICAL),
 	GATE_INFRA3_FLAGS(CLK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1", "usb_frmcnt_p1_sel",
 			  9, CLK_IS_CRITICAL),
-	GATE_INFRA3(CLK_INFRA_USB_PIPE, "infra_usb_pipe", "sspxtp_sel", 10),
-	GATE_INFRA3(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1", "usb_phy_sel", 11),
+	GATE_INFRA3_FLAGS(CLK_INFRA_USB_PIPE, "infra_usb_pipe", "sspxtp_sel", 10, CLK_IS_CRITICAL),
+	GATE_INFRA3_FLAGS(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1", "usb_phy_sel", 11,
+			  CLK_IS_CRITICAL),
 	GATE_INFRA3(CLK_INFRA_USB_UTMI, "infra_usb_utmi", "top_xtal", 12),
 	GATE_INFRA3(CLK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1", "top_xtal", 13),
 	GATE_INFRA3(CLK_INFRA_USB_XHCI, "infra_usb_xhci", "usb_xhci_sel", 14),
-- 
2.43.0


