Return-Path: <linux-kernel+bounces-764132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A4B21E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808961A22BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC93248880;
	Tue, 12 Aug 2025 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="t46mUl2b"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B322F77E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980543; cv=none; b=rlK6QEQECxK/szdH2KIs6uPm79SvhyA8gkKFPQUKOFwhsmAnqVjOKw2GsTyUKNiyX5yxD2FqZt5oiVqoquGI7xMyt3GH2BM+7Chl4fqKcZcneMlyRyy9b5yrEuONiMS/o8nTTolnMPmPrUriolgQgETZKRaoCYe5Dy990bCp5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980543; c=relaxed/simple;
	bh=8IGcH37krJMcd6ju4P5mxL5uQpiGfD5DCRH3oE5mjxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TezIguo2d2NYnU1KKzk02oUELaJ3KnuxEnECpDeaB6K/Hs2pxLtsZwV8l1+2JrEqcZpSL4nin/EDFHrwpX3h+DzBECkv9GACoHfIrYXRDw77YVFvRbG4CTcZai8zctW0hD8eXtytCwlYyymtBJllsEBK4rHvQ97yAFicz0wmO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=t46mUl2b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C6ZQvM42002758, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754980526; bh=Em9LpjkLJ86Th6qejHYnNPAJAtPlLrN0zZ9pza8JlhM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=t46mUl2bCRuKo6WPZgkM8hF5re24oBeLwHNy+AYw0rvPiMgo9oME5vx7cJwXus1R/
	 gSUwuYDmSe1Arx0syddN3ykfd0DpxMS3BhF0X+jVwPJU7dQbKM8mHrBgQSsqGxXola
	 qE6vdyKW5DRyf6zockEPvz4xgp8x901deF9qY80W/7SYUnyEkczlA0grIA4vmYQD3C
	 L+EpEO62VE+PsDCtlMDb81OntHHKeCJOOKUWaF5JLHOLLXdZ3JwzCIyhhTwoCMwOPW
	 AejxWlxx3Mfd4EdT/kp5y+yQgVZ69GHkANA5zqQ6l4A3kIF9Mm6/XWBDeAAdH138O8
	 qCVsx7In0kKXA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C6ZQvM42002758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 14:35:26 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 14:35:24 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 14:35:23 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 14:35:23 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx_pci: Add separate CD/WP pin polarity reversal support
Date: Tue, 12 Aug 2025 14:35:21 +0800
Message-ID: <20250812063521.2427696-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Previously, the Card Detect (CD) and Write Protect (WP) pins shared the
same reverse polarity setting in the configuration space. This meant both
signals were reversed together, without the ability to configure them
individually.

This patch introduces two new parameters:
sd_cd_reverse_en – enable reverse polarity for the CD pin.
sd_wp_reverse_en – enable reverse polarity for the WP pin.

With this change, the controller can now support:
1.Reversing both CD and WP pins together (original behavior).
2.Reversing CD and WP pins separately (newly added behavior), if
supported by the configuration space.

This provides greater flexibility when dealing with devices that have
independent polarity requirements for CD and WP pins.

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5227.c  | 13 ++++++++++---
 drivers/misc/cardreader/rts5228.c  | 12 ++++++++++--
 drivers/misc/cardreader/rts5249.c  | 16 +++++++++++++---
 drivers/misc/cardreader/rts5264.c  | 20 ++++++++++++++++----
 drivers/misc/cardreader/rts5264.h  |  1 +
 drivers/misc/cardreader/rtsx_pcr.h |  2 ++
 include/linux/rtsx_pci.h           |  2 ++
 7 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index cd512284bfb3..46444bb47f65 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -79,6 +79,10 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
+	if (rtsx_reg_check_cd_reverse(reg))
+		pcr->option.sd_cd_reverse_en = 1;
+	if (rtsx_reg_check_wp_reverse(reg))
+		pcr->option.sd_wp_reverse_en = 1;
 }
 
 static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
@@ -127,8 +131,10 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	/* Configure force_clock_req */
 	if (pcr->flags & PCR_REVERSE_SOCKET)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x30);
-	else
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
+	else {
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x20, option->sd_cd_reverse_en << 5);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x10, option->sd_wp_reverse_en << 4);
+	}
 
 	if (CHK_PCI_PID(pcr, 0x522A))
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_AUTOLOAD_CFG1,
@@ -350,6 +356,8 @@ void rts5227_init_params(struct rtsx_pcr *pcr)
 	pcr->ms_pull_ctl_disable_tbl = rts5227_ms_pull_ctl_disable_tbl;
 
 	pcr->reg_pm_ctrl3 = PM_CTRL3;
+	pcr->option.sd_cd_reverse_en = 0;
+	pcr->option.sd_wp_reverse_en = 0;
 }
 
 static int rts522a_optimize_phy(struct rtsx_pcr *pcr)
@@ -508,5 +516,4 @@ void rts522a_init_params(struct rtsx_pcr *pcr)
 		pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
 	pcr->hw_param.ocp_glitch = SD_OCP_GLITCH_10M;
 	pcr->option.sd_800mA_ocp_thd = RTS522A_OCP_THD_800;
-
 }
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index 0c7f10bcf6f1..db7e735ac24f 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -84,6 +84,10 @@ static void rtsx5228_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
+	if (rtsx_reg_check_cd_reverse(reg))
+		pcr->option.sd_cd_reverse_en = 1;
+	if (rtsx_reg_check_wp_reverse(reg))
+		pcr->option.sd_wp_reverse_en = 1;
 }
 
 static int rts5228_optimize_phy(struct rtsx_pcr *pcr)
@@ -432,8 +436,10 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 
 	if (pcr->flags & PCR_REVERSE_SOCKET)
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x30);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
+	else {
+		rtsx_pci_write_register(pcr, PETXCFG, 0x20, option->sd_cd_reverse_en << 5);
+		rtsx_pci_write_register(pcr, PETXCFG, 0x10, option->sd_wp_reverse_en << 4);
+	}
 
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
@@ -720,4 +726,6 @@ void rts5228_init_params(struct rtsx_pcr *pcr)
 	hw_param->interrupt_en |= SD_OC_INT_EN;
 	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U;
 	option->sd_800mA_ocp_thd =  RTS5228_LDO1_OCP_THD_930;
+	option->sd_cd_reverse_en = 0;
+	option->sd_wp_reverse_en = 0;
 }
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6c81040e18be..38aefd8db452 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -60,6 +60,7 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, PCR_SETTING_REG1, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
+	pci_write_config_dword(pdev, 0x718, 0x0007C000);
 
 	if (!rtsx_vendor_setting_valid(reg)) {
 		pcr_dbg(pcr, "skip fetch vendor setting\n");
@@ -82,6 +83,10 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
 	if (rtsx_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
+	if (rtsx_reg_check_cd_reverse(reg))
+		pcr->option.sd_cd_reverse_en = 1;
+	if (rtsx_reg_check_wp_reverse(reg))
+		pcr->option.sd_wp_reverse_en = 1;
 }
 
 static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
@@ -254,9 +259,11 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 	/* Configure driving */
 	rts5249_fill_driving(pcr, OUTPUT_3V3);
 	if (pcr->flags & PCR_REVERSE_SOCKET)
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB0, 0xB0);
-	else
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB0, 0x80);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x30);
+	else {
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x20, option->sd_cd_reverse_en << 5);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x10, option->sd_wp_reverse_en << 4);
+	}
 
 	rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
 
@@ -572,6 +579,9 @@ void rts5249_init_params(struct rtsx_pcr *pcr)
 	option->ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5249_DEF;
 	option->ltr_l1off_snooze_sspwrgate =
 		LTR_L1OFF_SNOOZE_SSPWRGATE_5249_DEF;
+
+	option->sd_cd_reverse_en = 0;
+	option->sd_wp_reverse_en = 0;
 }
 
 static int rts524a_write_phy(struct rtsx_pcr *pcr, u8 addr, u16 val)
diff --git a/drivers/misc/cardreader/rts5264.c b/drivers/misc/cardreader/rts5264.c
index d050c9fff7ac..99a2d5ea6421 100644
--- a/drivers/misc/cardreader/rts5264.c
+++ b/drivers/misc/cardreader/rts5264.c
@@ -527,8 +527,16 @@ static void rts5264_init_from_hw(struct rtsx_pcr *pcr)
 
 	pcr->rtd3_en = rts5264_reg_to_rtd3(lval2);
 
-	if (rts5264_reg_check_reverse_socket(lval2))
-		pcr->flags |= PCR_REVERSE_SOCKET;
+	if (rts5264_reg_check_reverse_socket(lval2)) {
+		if (is_version_higher_than(pcr, PID_5264, RTS5264_IC_VER_B))
+			pcr->option.sd_cd_reverse_en = 1;
+		else
+			pcr->flags |= PCR_REVERSE_SOCKET;
+	}
+
+	if (rts5264_reg_check_wp_reverse(lval2) &&
+		is_version_higher_than(pcr, PID_5264, RTS5264_IC_VER_B))
+		pcr->option.sd_wp_reverse_en = 1;
 
 	pci_read_config_dword(pdev, setting_reg1, &lval1);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", setting_reg1, lval1);
@@ -622,8 +630,10 @@ static int rts5264_extra_init_hw(struct rtsx_pcr *pcr)
 
 	if (pcr->flags & PCR_REVERSE_SOCKET)
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x30);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
+	else {
+		rtsx_pci_write_register(pcr, PETXCFG, 0x20, option->sd_cd_reverse_en << 5);
+		rtsx_pci_write_register(pcr, PETXCFG, 0x10, option->sd_wp_reverse_en << 4);
+	}
 
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
@@ -957,4 +967,6 @@ void rts5264_init_params(struct rtsx_pcr *pcr)
 	hw_param->interrupt_en |= (SD_OC_INT_EN | SD_OVP_INT_EN);
 	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U | SDVIO_OCP_GLITCH_800U;
 	option->sd_800mA_ocp_thd =  RTS5264_LDO1_OCP_THD_1150;
+	option->sd_cd_reverse_en = 0;
+	option->sd_wp_reverse_en = 0;
 }
diff --git a/drivers/misc/cardreader/rts5264.h b/drivers/misc/cardreader/rts5264.h
index f3e81daa708d..611ee253367c 100644
--- a/drivers/misc/cardreader/rts5264.h
+++ b/drivers/misc/cardreader/rts5264.h
@@ -14,6 +14,7 @@
 #define rts5264_reg_to_aspm(reg) \
 	(((~(reg) >> 28) & 0x02) | (((reg) >> 28) & 0x01))
 #define rts5264_reg_check_reverse_socket(reg)	((reg) & 0x04)
+#define rts5264_reg_check_wp_reverse(reg)		((reg) & 0x8000)
 #define rts5264_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) & 0x03)
 #define rts5264_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) & 0x03)
 #define rts5264_reg_to_rtd3(reg)		((reg) & 0x08)
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index 8e5951b61143..40562ff2be13 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -100,6 +100,8 @@ static inline u8 map_sd_drive(int idx)
 #define rtsx_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 5) & 0x03)
 #define rtsx_reg_to_card_drive_sel(reg)		((((reg) >> 25) & 0x01) << 6)
 #define rtsx_reg_check_reverse_socket(reg)	((reg) & 0x4000)
+#define rtsx_reg_check_cd_reverse(reg)		((reg) & 0x800000)
+#define rtsx_reg_check_wp_reverse(reg)		((reg) & 0x400000)
 #define rts5209_reg_to_aspm(reg)		(((reg) >> 5) & 0x03)
 #define rts5209_reg_check_ms_pmos(reg)		(!((reg) & 0x08))
 #define rts5209_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 3) & 0x07)
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 3b4c36705a9b..3c5689356004 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1160,6 +1160,8 @@ struct rtsx_cr_option {
 	bool ocp_en;
 	u8 sd_400mA_ocp_thd;
 	u8 sd_800mA_ocp_thd;
+	u8 sd_cd_reverse_en;
+	u8 sd_wp_reverse_en;
 };
 
 /*
-- 
2.25.1


