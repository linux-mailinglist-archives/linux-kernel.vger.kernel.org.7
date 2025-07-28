Return-Path: <linux-kernel+bounces-747894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94582B139D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B270416F39B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473B25BF1B;
	Mon, 28 Jul 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShqSADWY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB8241664
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702026; cv=none; b=JDpDGDa/FVLqdaOrHksCI18SiXrM+f4AUoPujKiBMxHUkLF/37V56XNb27B/GwQ9ZSEDAobbRkiA1Ber1LC24ThW0HnE3hc9xuraLnubTurKU1dpgdq8a82E044xDRmZGOLfh3I/rNDh4X1lt3iIrBddxyxJpLNs7RW5mcUjo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702026; c=relaxed/simple;
	bh=ziOTa5YPs8HW2PRR9nFsy52v/8yS0R8cUFHTbK4w9aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFmrj3Zg2p9svLx5S1EoKetrBtQKRM2JxDVu493VHK2R1we+RqMpKAFPzbxMGZ9SiFcEDr8YC8fcSAKeWnu926iMpd9iZ6npXxgKZJRgf41oPmG4ZF2gCkHo7mWa4siCqlPEmxnnZYiBAqWxe3lEaMowdlAaABYJHS5y1B2pA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShqSADWY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23fc5aedaf0so12575785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753702024; x=1754306824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnq0HeTj4iQCJ6vFIeZFzMP1bpvU5SCN2MHWpO/U8cw=;
        b=ShqSADWYaRCJ+RBMblQfFvR+9Rd267JhWBL8kPGg+M42HfUmZc88KIboP6e/YvDHlR
         lVjr5Mx3nL2n509/jcmbGKtIkPVAKC+TKdAUtToDVGb2XJyF2iSc3RGCQWSzg7if3UIO
         o26Jf0M/J835YNsUENJIAZ242lOfdd0nltoIpUUJ9/sn22riMnzNdgvw1FA0aSgNmt4K
         7laWe0bSUcQUo8flmcg556HNnM0IEWOrSwVlrk5kh5ndVPsqHd/UsGfI/ihWABvX+xio
         uEWie/yT5FyC5gkqWbuxGmGovMZ3NcaL9dOlGADWnqtWWDJ6HW115IO1Av43lquA6fYC
         PwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753702024; x=1754306824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gnq0HeTj4iQCJ6vFIeZFzMP1bpvU5SCN2MHWpO/U8cw=;
        b=gJZSCDNS24U8QzMEtPeFygwyV/qGeaTzwlcpSARvTDg4MRlWJLy2qyEvA5Thyh6qRt
         7M2xQQhR881jW3Ju53FDBIQOnOc1aCybIWpyWtOK1rV1hNpFRdOtO3GAWZAS2SQiiFll
         w6ucNaKOdAOWQDJGrLHAIIalCffm78b6vE9a+hElZjIRLV1rlDQhL0nBPf/UX/N/DNyZ
         zNqQkbzCJuxjfrHHGsZvqjcqhWWuAC7dBfRXHtf15fs+Orxj1D2qxkfxa+4Ivzab9lfb
         sj0+LSBMJFPuXB7155yGAPwaOvbLf/KRM7kVyFQXQWTUZLBAC4vn8VC3thv7qxx7P1qh
         UPOQ==
X-Gm-Message-State: AOJu0YxsKWJs0UZ/1Z6WhWaRWfHQMTwtOHiJMzFVIjQ9H2Mcf5gOXGzX
	LnVJltZDkMn0+Ay9/jdA5raZ/kGw5TykVxNXr6NQPWSkgCZF38m3AD8IQKBY3Gi9
X-Gm-Gg: ASbGncujGk+TKuk6FRzTyxg87UjuEZLNAibpKW7UGL1JiRS6ImjPMqavBhl8k9XFqZV
	FrVyHBmhbS1iZv8RyDDI+8ohYDPUgNu8F4l38I1cd57Oz2auFe0/a626zfp6mSXpWVKVEPlpVrp
	mTRAimMU2gStm8NooAqLr+OvhBKAhb4nQWCPQ0bm+BcTY05Ob2Fkghp62twxRwGKMcECSJKfJhR
	4uWpyylZeaAsDEy/9hQLy0EszveeUA2pB6lMysRdD9Ipbm9u8DNGAw5PmK02HB6i+tMi2xaxU+D
	TsiKgTuqzfxuZ4MtCTwa5oE0+o2GdzOPqtV5MqD3TcRZUHj1lnkbj7W2Q6y86qewZK20cemY47r
	a3bw5PuA3ABPi7ypJWP+FNBJbC0igy146jak=
X-Google-Smtp-Source: AGHT+IHfpci7G2278Vsdv2Xh22iVLTzypdkFRHBiVtAxyKJR3o4rC1Q8WOecRzbZIVzbqvpOE4e5YA==
X-Received: by 2002:a17:903:4407:b0:23e:2340:7698 with SMTP id d9443c01a7336-23fb2ff9719mr162694815ad.1.1753702023856;
        Mon, 28 Jul 2025 04:27:03 -0700 (PDT)
Received: from imran-device.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24014fa6d8esm25667195ad.78.2025.07.28.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:27:03 -0700 (PDT)
From: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
To: pkshih@realtek.com,
	kevin_yang@realtek.com,
	rtl8821cerfe2@gmail.com,
	phhuang@realtek.com,
	damon.chen@realtek.com
Cc: linux-kernel@vger.kernel.org,
	Mande Imran Ahmed <immu.ahmed1905@gmail.com>
Subject: [PATCH v2] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Date: Mon, 28 Jul 2025 16:56:38 +0530
Message-ID: <20250728112638.39412-1-immu.ahmed1905@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a28456f5b8d2477785493c6081f24401@realtek.com>
References: <a28456f5b8d2477785493c6081f24401@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Realtek rtw89 wireless driver to replace scnprintf() with
sysfs_emit() for formatting sysfs attribute output, in line with the
recommendations from Documentation/filesystems/sysfs.rst.

This change enhances the safety and correctness of sysfs handling,
promotes consistency throughout the kernel, and aids long-term
maintainability.

Functionality verified using ping, iperf, and connection tests to ensure
stability after the changes.

Changes since v1:
- Replaced sysfs_emit() with sysfs_emit_at()
- Removed unused function parameters.

Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c |  4 +-
 drivers/net/wireless/realtek/rtw89/phy.c   | 12 ++---
 drivers/net/wireless/realtek/rtw89/phy.h   |  2 +-
 drivers/net/wireless/realtek/rtw89/sar.c   | 58 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/sar.h   |  2 +-
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d6016fa107fb..74a8e0976715 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -941,13 +941,13 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 	p += rtw89_debug_priv_txpwr_table_get_regd(rtwdev, p, end - p, chan);
 
 	p += scnprintf(p, end - p, "[SAR]\n");
-	p += rtw89_print_sar(rtwdev, p, end - p, &sar_parm);
+	p += rtw89_print_sar(rtwdev, p, &sar_parm);
 
 	p += scnprintf(p, end - p, "[TAS]\n");
 	p += rtw89_print_tas(rtwdev, p, end - p);
 
 	p += scnprintf(p, end - p, "[DAG]\n");
-	p += rtw89_print_ant_gain(rtwdev, p, end - p, chan);
+	p += rtw89_print_ant_gain(rtwdev, p, chan);
 
 	tbl = dbgfs_txpwr_tables[chip_gen];
 	if (!tbl)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a58aefb51fb5..1fa2c7a04bd7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2084,25 +2084,25 @@ s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
 
-int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf,
 			 const struct rtw89_chan *chan)
 {
-	char *p = buf;
+	int len;
 	s8 offset_patha, offset_pathb;
 
 	if (!rtw89_can_apply_ant_gain(rtwdev, chan->band_type)) {
-		p += sysfs_emit(p, "no DAG is applied\n");
+		len = sysfs_emit(buf, "no DAG is applied\n");
 		goto out;
 	}
 
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
 
-	p += sysfs_emit(p, "ChainA offset: %d dBm\n", offset_patha);
-	p += sysfs_emit(p, "ChainB offset: %d dBm\n", offset_pathb);
+	len = sysfs_emit(buf, "ChainA offset: %d dBm\n", offset_patha);
+	len += sysfs_emit_at(buf, len, "ChainB offset: %d dBm\n", offset_pathb);
 
 out:
-	return p - buf;
+	return len;
 }
 
 static const u8 rtw89_rs_idx_num_ax[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5b451f1cfaac..f5518f5bc668 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -836,7 +836,7 @@ s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 void rtw89_phy_ant_gain_init(struct rtw89_dev *rtwdev);
 s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan);
-int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf,
 			 const struct rtw89_chan *chan);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 80eacada6911..14cefbe64124 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -311,14 +311,14 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, const struct rtw89_sar_parm *sar_pa
 }
 EXPORT_SYMBOL(rtw89_query_sar);
 
-int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf,
 		    const struct rtw89_sar_parm *sar_parm)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
 	const u8 fct_mac = rtwdev->chip->txpwr_factor_mac;
-	char *p = buf;
+	int len;
 	int ret;
 	s32 cfg;
 	u8 fct;
@@ -326,58 +326,58 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (src == RTW89_SAR_SOURCE_NONE) {
-		p += sysfs_emit(p, "no SAR is applied\n");
+		len = sysfs_emit(buf, "no SAR is applied\n");
 		goto out;
 	}
 
-	p += sysfs_emit(p, "source: %d (%s)\n", src,
-		       sar_hdl->descr_sar_source);
+	len = sysfs_emit(buf, "source: %d (%s)\n", src,
+			 sar_hdl->descr_sar_source);
 
 	ret = sar_hdl->query_sar_config(rtwdev, sar_parm, &cfg);
 	if (ret) {
-		p += sysfs_emit(p, "config: return code: %d\n", ret);
-		p += sysfs_emit(p,
-			       "assign: max setting: %d (unit: 1/%lu dBm)\n",
-			       RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
+		len += sysfs_emit_at(buf, len, "config: return code: %d\n", ret);
+		len += sysfs_emit_at(buf, len,
+				"assign: max setting: %d (unit: 1/%lu dBm)\n",
+				RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
 		goto out;
 	}
 
 	fct = sar_hdl->txpwr_factor_sar;
 
-	p += sysfs_emit(p, "config: %d (unit: 1/%lu dBm)\n", cfg,
-		       BIT(fct));
+	len += sysfs_emit_at(buf, len, "config: %d (unit: 1/%lu dBm)\n", cfg,
+			BIT(fct));
 
-	p += sysfs_emit(p, "support different configs by antenna: %s\n",
-		       str_yes_no(rtwdev->chip->support_sar_by_ant));
+	len += sysfs_emit_at(buf, len, "support different configs by antenna: %s\n",
+			str_yes_no(rtwdev->chip->support_sar_by_ant));
 out:
-	return p - buf;
+	return len;
 }
 
 int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
-	char *p = buf;
+	int len;
 
 	if (!rtw89_tas_is_active(rtwdev)) {
-		p += sysfs_emit(p, "no TAS is applied\n");
+		len = sysfs_emit(buf, "no TAS is applied\n");
 		goto out;
 	}
 
-	p += sysfs_emit(p, "State: %s\n",
-		       rtw89_tas_state_str(tas->state));
-	p += sysfs_emit(p, "Average time: %d\n",
-		       tas->window_size * 2);
-	p += sysfs_emit(p, "SAR gap: %d dBm\n",
-		       RTW89_TAS_SAR_GAP >> RTW89_TAS_FACTOR);
-	p += sysfs_emit(p, "DPR gap: %d dBm\n",
-		       RTW89_TAS_DPR_GAP >> RTW89_TAS_FACTOR);
-	p += sysfs_emit(p, "DPR ON offset: %d dBm\n",
-		       RTW89_TAS_DPR_ON_OFFSET >> RTW89_TAS_FACTOR);
-	p += sysfs_emit(p, "DPR OFF offset: %d dBm\n",
-		       RTW89_TAS_DPR_OFF_OFFSET >> RTW89_TAS_FACTOR);
+	len = sysfs_emit(buf, "State: %s\n",
+			 rtw89_tas_state_str(tas->state));
+	len += sysfs_emit_at(buf, len, "Average time: %d\n",
+			tas->window_size * 2);
+	len += sysfs_emit_at(buf, len, "SAR gap: %d dBm\n",
+			RTW89_TAS_SAR_GAP >> RTW89_TAS_FACTOR);
+	len += sysfs_emit_at(buf, len, "DPR gap: %d dBm\n",
+			RTW89_TAS_DPR_GAP >> RTW89_TAS_FACTOR);
+	len += sysfs_emit_at(buf, len, "DPR ON offset: %d dBm\n",
+			RTW89_TAS_DPR_ON_OFFSET >> RTW89_TAS_FACTOR);
+	len += sysfs_emit_at(buf, len, "DPR OFF offset: %d dBm\n",
+			RTW89_TAS_DPR_OFF_OFFSET >> RTW89_TAS_FACTOR);
 
 out:
-	return p - buf;
+	return len;
 }
 
 static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 4b7f3d44f57b..b84277a3ea38 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -28,7 +28,7 @@ struct rtw89_sar_handler {
 extern const struct cfg80211_sar_capa rtw89_sar_capa;
 
 s8 rtw89_query_sar(struct rtw89_dev *rtwdev, const struct rtw89_sar_parm *sar_parm);
-int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf,
 		    const struct rtw89_sar_parm *sar_parm);
 int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
-- 
2.43.0


