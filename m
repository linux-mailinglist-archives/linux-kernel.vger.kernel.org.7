Return-Path: <linux-kernel+bounces-893335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1CBC471A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68714EAC55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8E311C10;
	Mon, 10 Nov 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w7PVHp5d"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957E3112DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783689; cv=none; b=cm6ZTVTnu6fMc2RKs0ToVHtpW/s0wHiuG9WGCKMtvP8oBRzmZ3ozZqjEFPj+tOm739ATc0CPgyKS3BlklDaY3ZunQfzpIcbRoUIaFlhT2hQWqRII8xQa0O1vGIytA1yWCgY6kfosG9BFBXuP2NhVpcrAz+IhHygi4A+vPYoQNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783689; c=relaxed/simple;
	bh=EklmnwA4PgB0eGl02mnMLShP4RYcrVszj7lCywjBvEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lu4A4C4XEX7xKXO/q8ymy+590TM7VxWTOayx8jzdweTnMbIetzxm+RmhUrMXAUnHjcwlVlESjLJ4bmnOxnFPVzLMzPFTtaIF2d3V59CqexL4IDf7xmaM3kcAViLEbCAjSwiyrv0WyekncGTLfxd4f3p3NAWXLw4ETG5Zgxwb9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w7PVHp5d; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84F8F1A19AB;
	Mon, 10 Nov 2025 14:08:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57207606F6;
	Mon, 10 Nov 2025 14:08:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBFEC10371915;
	Mon, 10 Nov 2025 15:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762783684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZwlciqkJDJ8+3wdEKOLMDdM6H1SzddqaokbU7lqnBxE=;
	b=w7PVHp5dP8q9BdUvrlCkiHTeIQk9lAiNjbMquf/CV1IF+mrfrCt4MmDl9CMloJneK3UJwJ
	XbNDJEpZlq+v99oIpiXr+gq5NoHIoPIpdb/WMPZTKyWiHRzJtxKaF1/7rJPzZl8t/P75Rb
	+lJowsKOa23VnPOWJAaxpjuvZhxehJt0/Vbt2Zxt2OH26aJDYB0Z58cwkSZf4dQPQs/0HS
	+ukBj5kDM4v4fGpfny7On5l59EsOvcou4tJjwpuMWJOfmCf7PGz04Eepcog8+lXvJEuy3h
	JvkZ2lGmJe5GqIqVeLuublM3GwYxIdGYHdsQS4fKKXxb+fbwB4+4vlHmHYUaHw==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Mon, 10 Nov 2025 15:07:57 +0100
Subject: [PATCH] phy: cadence-torrent: restore parent clock for refclk
 during resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-phy-cadence-torrent-resume-restore-refclk-parent-v1-1-1be87af7d19e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALzxEWkC/x2NwQrCQAxEf6XkbKBbWKH+inhY08QGdbtkW1FK/
 920p+HNg5kVKptyhUuzgvFHq07ZIZwaoDHlB6MOztC1XQwhtFjGH1IaOBPjPJlxntG4Lm/ew5s
 9hV5PLOmQEnu5R6FzLwl8trjW73F5vW3bH8so/D2CAAAA
X-Change-ID: 20251110-phy-cadence-torrent-resume-restore-refclk-parent-f59fb5fc69fa
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

While suspend and resume, parent clock config for refclk was getting lost.
So save and restore it in suspend and resume operations.

Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 37fa4bad6bd7..17d09e7d866d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -384,6 +384,7 @@ struct cdns_torrent_phy {
 	struct regmap_field *phy_reset_ctrl;
 	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
 	struct clk_hw_onecell_data *clk_hw_data;
+	int refclk_parent;
 };
 
 enum phy_powerstate {
@@ -3329,8 +3330,13 @@ static const struct cdns_torrent_vals sgmii_qsgmii_xcvr_diag_ln_vals = {
 static int cdns_torrent_phy_suspend_noirq(struct device *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
+	struct clk_hw *refclk_hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(refclk_hw);
 	int i;
 
+	regmap_field_read(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4],
+			  &cdns_phy->refclk_parent);
+
 	reset_control_assert(cdns_phy->phy_rst);
 	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++)
@@ -3349,9 +3355,14 @@ static int cdns_torrent_phy_suspend_noirq(struct device *dev)
 static int cdns_torrent_phy_resume_noirq(struct device *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
+	struct clk_hw *refclk_hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(refclk_hw);
 	int node = cdns_phy->nsubnodes;
 	int ret, i;
 
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4],
+			   cdns_phy->refclk_parent);
+
 	ret = cdns_torrent_clk(cdns_phy);
 	if (ret)
 		return ret;

---
base-commit: 415559c31bd4f19fde440f759d529a448743fc8c
change-id: 20251110-phy-cadence-torrent-resume-restore-refclk-parent-f59fb5fc69fa

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


