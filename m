Return-Path: <linux-kernel+bounces-836871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7FBAAC65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E58192044F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3D1798F;
	Tue, 30 Sep 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcSwNsBh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F562A8C1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190757; cv=none; b=MCBWXXyb6GpZXKChDQG6mDV3iG0m5Gpdf5vDD7USYL1BHfTBp5HB9jyajCnKJsnUUtYST52frrMAFGjseRFxOhXbMqJUW5UgFRWhv9sWuZXf2S/9libJWdGBZbL4LO8lwKTZz95VMXdBaBMBSpVOo+skNVslfyKVxMK1IUShjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190757; c=relaxed/simple;
	bh=a154aIdBQtmZaCQ2OgoZBJaqPWbb1ESXLP3b5mhSmww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bBdMmAj7V0VWItUWfXbJ9z5tITCptcO46Zyg17UlSZ8az9zbePjEo6hlpDOfsxSiu0Cem4AUqAWv5fSaa8CejFgC5MrGvZLaxPUpzicRkxkCfwWpYV3N6+GIHxHdMd7ykZjiK9xRelD/wA9pZLlvTGq8V6aSHzvVVMOoHUsCDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcSwNsBh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-271067d66fbso54515765ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759190755; x=1759795555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bUrbTjyVbGQlT+Ufj8ik95yyvvCsvJU5vx0WHjNybE=;
        b=RcSwNsBhkYtUlgVRqOzrVEhNzl4ziY5NGCmtAiSAqr4z38Rg7fFXlYpQvNVyfnmo4d
         t118hOw1n1KR2boMRQNIi3LTZJ37KjeH0NSR9VDRvM9EzvL+c7DwLedOElGBDpOAaiRg
         sSwTr/QjJidHyEhIXwWCJz1tTlfQDfkf34eQRXWsdOoZy0qf8tyvWHrJTUTQgt8i2jo0
         +MgN3xSa72bSw2HLnqxYEnRPAmgLK2CsZuZv6E2vfAMQVUahUWxaUf7IRunVHuyGvIF+
         l8IxxBs8EgjJiO4oqf9cGgmbfISAhRMgM9ROFQMk7ogcn9siR/blzc10NeEMm1Wb5fHi
         4dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759190755; x=1759795555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bUrbTjyVbGQlT+Ufj8ik95yyvvCsvJU5vx0WHjNybE=;
        b=I9Cs3gpryXuUEOGtEHgIw6Y0AvMKzmfNQBUScHqpHuujk3cfliErBAnC+o8CHsnHNe
         dbVNP8ShXwEsYwZTwa4ZW4/Huftzi/umWaYfKdmg/amIUMVs5WF69MwFsWP3zonM8Gca
         Ft6p5R+GGNZ6mvVUxrIAiWRKv0rMYELq1yHAkuUWGW5fapzzXRPMI9dI/cKvcCOeQvZN
         1d5rjBuPUrj1sRP6b9LwS5ePKaUj20VfcEDorHEEGihxZxmvb6hoNjc+hnVDFW/zwcp4
         H8qcHYelUxatKomM4LI02i5XfKnkpVb1NaX0fTuNX5vPyOhotBrWX7gOiZ4yA/5gQ5ve
         2ktA==
X-Forwarded-Encrypted: i=1; AJvYcCVAs8cnEM/aKdv2BrPPwkhE8uS+XrCLqV7g8G7eYI2EYiTFj9rPePoUw+kqcUDpEbij3/W/8OzI67nh078=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yYZG+VXHAY0rmw6N4dUUd94aL7TWPZiwMpdDASpAGAaKqbOF
	duifBe/d2g/7otVxl7kurrAdP0m/xMr9k22tNvPQRNhT52JKmqRwk6G/
X-Gm-Gg: ASbGncvBU1PWdSY2M11l8pn1D5sfI9qyAJjK5wv7JNQ2S1XWLvr/fBJ/cmbfVcXAsUV
	MJIIYkGBGZDy9e1hJ2JbJzJXwMsd7tJaSLMfn4mi7WX64qPIO9MaQ6H30AQ6MjgoA302pgZ74NP
	6VmyUGmKCAhUULvb1kA4ZC0xqrRSltgS1uoZJzzZAMHgPx/c0gVJs/HpNHu4n7yiE/tCMEk0W2Y
	8JA2tM3mLH/Jz2TDFVOrWwwI56R1Dd5EUN69fS6lwcf2wKJTPd71axz3JnL0jQmYlEkJEFcSR2C
	TmLTNUyCCMOa+BsY5odCQzdL12lwb4cybeBe0iN63OXM8yPVIjRSUK9DFiMlu4Yyre3J4kELEpF
	CjYRnQ4OtH205CuuwUmBD4ZeI/FqJaxjdCR7KUIjaeV2PtV1PhbnY9YX0vVQgZKPJ6KVP4XW2bU
	gTTx0OjsMEGDqwXyb339Kt6A==
X-Google-Smtp-Source: AGHT+IFrBzNZCu2BRKgrIq9N42owNMMwxrRNQZJtahP6J+jz1S8/03SSBYxre9N2U9nV1UFhDTMKeQ==
X-Received: by 2002:a17:902:c950:b0:279:daa1:6780 with SMTP id d9443c01a7336-27ed4a86e0emr214819425ad.52.1759190754799;
        Mon, 29 Sep 2025 17:05:54 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm141988805ad.52.2025.09.29.17.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 17:05:52 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	stanley_chang@realtek.com,
	cy.huang@realtek.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtw89: Replace hardcoded strings with helper functions
Date: Tue, 30 Sep 2025 08:05:45 +0800
Message-Id: <20250930000545.2192692-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
and 'str_read_write()'.

The change improves readability.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
v1 -> v2
- Drop all #include <linux/string_choices.h>
- Remove mention of potential binary size reduction

v1 Link:
https://lore.kernel.org/lkml/20250921154410.1202074-1-eleanor15x@gmail.com/

 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c |  8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c |  8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c |  6 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/usb.c          |  2 +-
 drivers/net/wireless/realtek/rtw89/wow.c          |  3 ++-
 6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 84c46d2f4d85..e574a9950a3b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -1626,7 +1626,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	iqk_info->iqk_table_idx[path] = idx;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n",
-		    path, phy, rtwdev->dbcc_en ? "on" : "off",
+		    path, phy, str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1901,8 +1901,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2016,7 +2016,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_pwr_clk_onoff(struct rtw89_dev *rtwdev, bool turn_on)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 9db8713ac99b..e74257d19412 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -1403,7 +1403,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1881,8 +1881,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2736,7 +2736,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       MASKBYTE3, 0x6 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 4796588c0256..70b1515c00fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1696,7 +1696,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 			       MASKBYTE3, _dpk_order_convert(rtwdev) << 1 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -1763,8 +1763,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index b92e2ce4f4ad..e7fd028c5e82 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1344,7 +1344,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1920,8 +1920,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2000,7 +2000,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev, u8 path, bool force)
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,  "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -2828,7 +2828,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       B_DPD_MEN, val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..afbd1fb79021 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -55,7 +55,7 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
 		else if (ret < 0)
 			rtw89_warn(rtwdev,
 				   "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
-				   reqtype == RTW89_USB_VENQT_READ ? "read" : "write",
+				   str_read_write(reqtype == RTW89_USB_VENQT_READ),
 				   len * 8, addr, ret,
 				   le32_to_cpup(rtwusb->vendor_req_buf),
 				   attempt);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5faa51ad896a..6950fed96267 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
+
 #include "cam.h"
 #include "core.h"
 #include "debug.h"
@@ -1248,7 +1249,7 @@ static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 				       mac->wow_ctrl.addr, mac->wow_ctrl.mask);
 	if (ret)
 		rtw89_err(rtwdev, "failed to check wow status %s\n",
-			  wow_enable ? "enabled" : "disabled");
+			  str_enabled_disabled(wow_enable));
 	return ret;
 }
 
-- 
2.34.1


