Return-Path: <linux-kernel+bounces-826210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822BB8DD83
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD93BF9D3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A02153D4;
	Sun, 21 Sep 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfHiiIh6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC891FCCF8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469475; cv=none; b=V7gEisTwIuWd5aMfq1P6OgqROLtyWZodCTUTK99pdxS+Hvv+jUy+fXqwHS7wae8UlnVDZC0q7+C3+5GeSGwNPwVBMCPOkenwihHZfm7fQQC4SIR2FUgfmVA0ba/4tykknxTvjPnHhGn5USd1xdwtU6bqsHn+H8P/mtR+2aueLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469475; c=relaxed/simple;
	bh=TorXlnzo2MWNlQrV3lMZEG55rlMmiosJc6k61neyAcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gmzdg2ORh4lqtBf3knWNH7dRX71WsMKQCCpIYFikh6qjuMYc42j9B8WzZr9GhwTyAwDKLsPyD+rHvXHRGyqRuTDS+KyVBkt1Tr3Ntd9cRVuf5/ZX2G0LVlJr88PKU+uUhv8HR8IsSKT6Mk77WJyhiTFo6F15bVIRD6AewBEp2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfHiiIh6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698d47e776so25036295ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758469473; x=1759074273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+EG28P0iOsg16EFPGe9CXi+kR66aQLbg4RmAzKPuYI0=;
        b=jfHiiIh605aU30Y2Y8nVy/QuIiEZcfXbAmRr3PPC1hp5UcU4DpXKhYnC3QzYUPzVRo
         e3MAOPe4mJi/8eL8aDEnS0OK+YFTs81k8+soRb8JgwuLtXVKSzbnCJ1HCE56YIMPS5Hv
         zEhNPT9bDeQu7ym97Ak7RC7V3KKVa7IoMDFLWREUVQ7uf2dgKtnU9UA4OctM0y7IzOL1
         PjtVAajUeEY6KpSQY/aXRHLbUkYmTXwL8r+ao5dfPEg1HTzHejQW61SHRr9FvFncfiiz
         kUqChY+kZYHuoF+UufaXTOKrGVa6ZtvtKNZP0M3iHzsuL6z6Tr1u1A8YnUM0FJIW/Iv5
         YLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758469473; x=1759074273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EG28P0iOsg16EFPGe9CXi+kR66aQLbg4RmAzKPuYI0=;
        b=aV8FuNGFWb+rmYhqPs87almG4fjSgIsEFcdHi+m0HZOxwlQd7jhDFQfrERtU6ng0zC
         ZbgnMyp6ZVUL6OC1r83OFn6YOK/0tR4aJNWt7PDQTG6ugkrqZH7hD115hy3gxZ6PGdt7
         22GCAvyEq7V4Sy82D5hLuxpZxf+182c917JIJ2VrEYv1swtbtISamUfGz2vO761A73Ng
         xxLb0Xf4o4GvRiWbt/2wyVhfwL1OJjoI4n636Rzj7PCWJKC99UkqD0ULwVPDR81QuDtX
         FDIz7DG3VncZBBsVL4au6Q+dAkpvP4PKzx2Bkv3efi78UG0Fhe3+duzXuQo1V/aFkXA8
         3OxA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcV7bMjxAcleV4xguWdLJy0wgaNgFvSJZFiZL9pDQjxM65SL/1rn4vzrpkovdRhGraLQwC611jseze+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRfGv1+bLEaakx+YaQEB2CfaOh47/l6BsLjbSlItArbJJ4bRD
	uCWEQLQSynPVxDb9vV284zBY6HEU57npHnpI9t/Ddy1MwL/1UGkXyn1N
X-Gm-Gg: ASbGnct9L+wrssVQmyUojwfUdwWQRdHIXoPfXtYevF8SGTd1+dCiPUoA3zBRgCdYAPc
	4zstOyqyL1U3Z0KWShgrJWbXFoErw3pR1PFpHP9u8Mh0wrBamnLYm3KY2Ou9OnOkCyPaFISmdYU
	d71BOsEednGF5sx8uDhjiR0nkKPL2S9N3wfbH7QYCsoJgYwKUKAD4EJEt/qh3J9hrVmpRY37nqu
	ruP2IVOF0VzJknQ0szev4h1OTyi3JxbcszVQ/fFLayRdXQPkBl/09NMlvtHEBWUvcUDyVFfVwQ/
	zJzuLRxdqxxYvjex0dGQ6iZEaTE5ah5XrgujJkb2lw4g4ys4fb5+W7LkPgfV8TnuuieJjFJmoSa
	pEFbw9SsWQReRH2mBN8eZQTQ8bhGo8+oD3SSsumwAwI8kilq9oPKuyIwqO52uHp0=
X-Google-Smtp-Source: AGHT+IElssErqvSrdGuhyH0vVhCmFkqiSxBKWh3bqR5whmCN8++24mRRt9yp/basgQHIC2bBl/4ILw==
X-Received: by 2002:a17:902:f645:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-269ba52e56emr145153705ad.52.1758469472698;
        Sun, 21 Sep 2025 08:44:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm89692205ad.100.2025.09.21.08.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 08:44:32 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cy.huang@realtek.com,
	stanley_chang@realtek.com,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with helper functions
Date: Sun, 21 Sep 2025 23:44:10 +0800
Message-Id: <20250921154410.1202074-1-eleanor15x@gmail.com>
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

The change improves readability and enables potential string deduplication
by the linker, which may slightly reduce binary size.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c |  8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 11 ++++++-----
 drivers/net/wireless/realtek/rtw89/usb.c          |  3 ++-
 drivers/net/wireless/realtek/rtw89/wow.c          |  5 ++++-
 6 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 84c46d2f4d85..000753061e38 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2022-2023  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "coex.h"
 #include "debug.h"
 #include "mac.h"
@@ -1626,7 +1628,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	iqk_info->iqk_table_idx[path] = idx;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n",
-		    path, phy, rtwdev->dbcc_en ? "on" : "off",
+		    path, phy, str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1901,8 +1903,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
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
@@ -2016,7 +2018,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_pwr_clk_onoff(struct rtw89_dev *rtwdev, bool turn_on)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 9db8713ac99b..9ffde0894d8a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "coex.h"
 #include "debug.h"
 #include "mac.h"
@@ -1403,7 +1405,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1881,8 +1883,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
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
@@ -2736,7 +2738,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       MASKBYTE3, 0x6 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 4796588c0256..c156c64f4d5e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "chan.h"
 #include "coex.h"
 #include "debug.h"
@@ -1696,7 +1698,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 			       MASKBYTE3, _dpk_order_convert(rtwdev) << 1 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -1763,8 +1765,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
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
index b92e2ce4f4ad..3d3de3641edd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
+#include <linux/string_choices.h>
 
 #include "chan.h"
 #include "coex.h"
@@ -1344,7 +1345,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1920,8 +1921,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
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
@@ -2000,7 +2001,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev, u8 path, bool force)
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,  "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -2828,7 +2829,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       B_DPD_MEN, val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..c7c90ddea409 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2025  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
 #include <linux/usb.h>
 #include "debug.h"
 #include "mac.h"
@@ -55,7 +56,7 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
 		else if (ret < 0)
 			rtw89_warn(rtwdev,
 				   "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
-				   reqtype == RTW89_USB_VENQT_READ ? "read" : "write",
+				   str_read_write(reqtype == RTW89_USB_VENQT_READ),
 				   len * 8, addr, ret,
 				   le32_to_cpup(rtwusb->vendor_req_buf),
 				   attempt);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5faa51ad896a..6e4156ef898c 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
+
+#include <linux/string_choices.h>
+
 #include "cam.h"
 #include "core.h"
 #include "debug.h"
@@ -1248,7 +1251,7 @@ static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 				       mac->wow_ctrl.addr, mac->wow_ctrl.mask);
 	if (ret)
 		rtw89_err(rtwdev, "failed to check wow status %s\n",
-			  wow_enable ? "enabled" : "disabled");
+			  str_enabled_disabled(wow_enable));
 	return ret;
 }
 
-- 
2.34.1


