Return-Path: <linux-kernel+bounces-743561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD7B10041
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D83D4E00E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F45207A2A;
	Thu, 24 Jul 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6mzR4u0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECF207A27
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336281; cv=none; b=HqeLCrhAjFrzB4RALmydAhvwpjfXVJh26MzsUFjNy4uiurtxG41kLGxppshSB19CQ24eP+mf4OO2mU4EwWe+lGrDIt9timVMiHu4C1+dipdqIsScVy8vJXZOk18XF4yoVu4f4dztzhws+5z45uAilbbxuzm2stoC70WGgVrEoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336281; c=relaxed/simple;
	bh=QfIN2VJlZFmnJIE0R01/0M2S1pIHyVHFieThVVU9jqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7axA0+3onJPsB9E4uXgLNZlyK5OzBNe88Me4lfiurPVsNS00smkZlIjd05upHZFLHjHqxjq4OEpb6VcX/ep7A3dVFpKQUA9kV41rxw4pYiFUU0twJJUQ08SOSe35R/RMfwRFxQIHa0yS+q1ZW2YvU2+cn5BwTKxBVpeKm1L6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6mzR4u0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso597850a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753336277; x=1753941077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5ZkyeZ8stL+8iJNjVz/qRVYgE+h61bRVG1pL/fdi78=;
        b=R6mzR4u01PMwTj44wf6v0VwvKJOGvNnp4Us5PYuRDcsoDjfPfetG1vT2L2CDhDodEW
         +LLT2Jsg4+Vp1p2YxiqVXVvOqa0GlSU7JW1y0RHL1KlNBLfasK/mkOE7vRQIijhCCTcC
         Uk5KbRjE0nWsAGpERrk7FrFnI+G7ciNGUVanVbXWfYP9PXOTfgKCfBL0Jtew/a/v0plp
         6PQtD9v5KFocgBJArEAvd8nEdngyU7k7+T46Wg93p7YDJ1ji0H9GgTg8aMo/wYSzm3ej
         Gllp03eqPh1bVCz3ZEaUwcpf98b7gIgaXpgVc2sds+hU8XJqOdfR2AJk7cUZl899lzY6
         H69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753336277; x=1753941077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5ZkyeZ8stL+8iJNjVz/qRVYgE+h61bRVG1pL/fdi78=;
        b=w6cyYIdkg3wAOe+vTOR4x7nWMLaZXPTDuNyA7on9cwJxw/OkOnpRahlhCDeSdDPMvK
         18RCVyVlQcd13s2y8tqocuu9QehupBVuhD6mjUJ68xR3ow6PoIW60tMrCplTZayQRvkI
         n55/68KNSEMxeeHkMcEcbxTRgSBfahGoi7K/eNQwRFAgDkUmzhNVspSNDXcjriqhLWbr
         GXp6wihgEUbknj+DOl2pkbMbSLF7gXatI2WwRXlaN0vJXITJbrAgz7QG0YBIeiWzetK6
         /8v0w8yv96GE5LQy2FPvOnMmU/J04s630hrHORLVaEwNTa7L61YWTeaOG6UKXLdrZmUQ
         0VRA==
X-Gm-Message-State: AOJu0YzmgF8ecvdXatwCWOPOHxp8Qt9ple8dMlHQef/Y8txjNGlQNlSc
	bp7g4tIfBK518pyeGDrL7HQhtHaq3B3G0dFs3b4llB6oGTTVLh0d7ihFpu3t+gKn
X-Gm-Gg: ASbGnctMvCMfIy/auoLEkwvQiAmWVYH2qPljMb3Lal9ars7hXKKmI4cdC+YVX2lBKsI
	sACnJX+SPFw9+sNJME9JD02yV2JR5gMQcSYD+wjG5qVCIBP/8Muijxij7FGFmCEVgX9Cuag0oVJ
	sUomCcW7VxlzOtUFcR4teCGyIxgOxdIM9wYGKzGy2IqwHzIc+/EhXDuJMzSWRLalGHn1lZMVWNY
	Tfn3sh7QF0t6r0uAvToYGBBjsFToR+7fYC9MuSDrBiUEnXUSoIw3gg7M4b5NRYOVFERv/50wPyK
	2QX+Wl6FgNJeXalpYpfyXtU6lE71aDOIlw0I4fPV1e7vVRHwTAX2I+fUNJeu750qZeSrYw4c60O
	AU3rClFWADsLcvo+x5jGKys+hFWJsO/JvQOQ=
X-Google-Smtp-Source: AGHT+IHDl1evI2pbV1CVaa2jR1CyuhJdTzVv1ZacKlLgjPi9khteNnINKx8VPMtR0nKTE6ppqqof1w==
X-Received: by 2002:a17:903:ac8:b0:235:ef67:b5a0 with SMTP id d9443c01a7336-23f981cc1a3mr85928925ad.36.1753336276624;
        Wed, 23 Jul 2025 22:51:16 -0700 (PDT)
Received: from imran-device.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476eac0sm6655645ad.60.2025.07.23.22.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 22:51:16 -0700 (PDT)
From: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
To: pkshih@realtek.com,
	kevin_yang@realtek.com,
	rtl8821cerfe2@gmail.com,
	phhuang@realtek.com,
	damon.chen@realtek.com
Cc: linux-kernel@vger.kernel.org,
	Mande Imran Ahmed <immu.ahmed1905@gmail.com>
Subject: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Date: Thu, 24 Jul 2025 11:20:18 +0530
Message-ID: <20250724055018.15878-1-immu.ahmed1905@gmail.com>
X-Mailer: git-send-email 2.43.0
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
stability after the change.

Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c |  8 +++----
 drivers/net/wireless/realtek/rtw89/sar.c | 30 ++++++++++++------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 76a2e26d4a10..a58aefb51fb5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2087,19 +2087,19 @@ EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
 int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 			 const struct rtw89_chan *chan)
 {
-	char *p = buf, *end = buf + bufsz;
+	char *p = buf;
 	s8 offset_patha, offset_pathb;
 
 	if (!rtw89_can_apply_ant_gain(rtwdev, chan->band_type)) {
-		p += scnprintf(p, end - p, "no DAG is applied\n");
+		p += sysfs_emit(p, "no DAG is applied\n");
 		goto out;
 	}
 
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
 
-	p += scnprintf(p, end - p, "ChainA offset: %d dBm\n", offset_patha);
-	p += scnprintf(p, end - p, "ChainB offset: %d dBm\n", offset_pathb);
+	p += sysfs_emit(p, "ChainA offset: %d dBm\n", offset_patha);
+	p += sysfs_emit(p, "ChainB offset: %d dBm\n", offset_pathb);
 
 out:
 	return p - buf;
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 517b66022f18..80eacada6911 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -318,7 +318,7 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
 	const u8 fct_mac = rtwdev->chip->txpwr_factor_mac;
-	char *p = buf, *end = buf + bufsz;
+	char *p = buf;
 	int ret;
 	s32 cfg;
 	u8 fct;
@@ -326,17 +326,17 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (src == RTW89_SAR_SOURCE_NONE) {
-		p += scnprintf(p, end - p, "no SAR is applied\n");
+		p += sysfs_emit(p, "no SAR is applied\n");
 		goto out;
 	}
 
-	p += scnprintf(p, end - p, "source: %d (%s)\n", src,
+	p += sysfs_emit(p, "source: %d (%s)\n", src,
 		       sar_hdl->descr_sar_source);
 
 	ret = sar_hdl->query_sar_config(rtwdev, sar_parm, &cfg);
 	if (ret) {
-		p += scnprintf(p, end - p, "config: return code: %d\n", ret);
-		p += scnprintf(p, end - p,
+		p += sysfs_emit(p, "config: return code: %d\n", ret);
+		p += sysfs_emit(p,
 			       "assign: max setting: %d (unit: 1/%lu dBm)\n",
 			       RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
 		goto out;
@@ -344,10 +344,10 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 
 	fct = sar_hdl->txpwr_factor_sar;
 
-	p += scnprintf(p, end - p, "config: %d (unit: 1/%lu dBm)\n", cfg,
+	p += sysfs_emit(p, "config: %d (unit: 1/%lu dBm)\n", cfg,
 		       BIT(fct));
 
-	p += scnprintf(p, end - p, "support different configs by antenna: %s\n",
+	p += sysfs_emit(p, "support different configs by antenna: %s\n",
 		       str_yes_no(rtwdev->chip->support_sar_by_ant));
 out:
 	return p - buf;
@@ -356,24 +356,24 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
-	char *p = buf, *end = buf + bufsz;
+	char *p = buf;
 
 	if (!rtw89_tas_is_active(rtwdev)) {
-		p += scnprintf(p, end - p, "no TAS is applied\n");
+		p += sysfs_emit(p, "no TAS is applied\n");
 		goto out;
 	}
 
-	p += scnprintf(p, end - p, "State: %s\n",
+	p += sysfs_emit(p, "State: %s\n",
 		       rtw89_tas_state_str(tas->state));
-	p += scnprintf(p, end - p, "Average time: %d\n",
+	p += sysfs_emit(p, "Average time: %d\n",
 		       tas->window_size * 2);
-	p += scnprintf(p, end - p, "SAR gap: %d dBm\n",
+	p += sysfs_emit(p, "SAR gap: %d dBm\n",
 		       RTW89_TAS_SAR_GAP >> RTW89_TAS_FACTOR);
-	p += scnprintf(p, end - p, "DPR gap: %d dBm\n",
+	p += sysfs_emit(p, "DPR gap: %d dBm\n",
 		       RTW89_TAS_DPR_GAP >> RTW89_TAS_FACTOR);
-	p += scnprintf(p, end - p, "DPR ON offset: %d dBm\n",
+	p += sysfs_emit(p, "DPR ON offset: %d dBm\n",
 		       RTW89_TAS_DPR_ON_OFFSET >> RTW89_TAS_FACTOR);
-	p += scnprintf(p, end - p, "DPR OFF offset: %d dBm\n",
+	p += sysfs_emit(p, "DPR OFF offset: %d dBm\n",
 		       RTW89_TAS_DPR_OFF_OFFSET >> RTW89_TAS_FACTOR);
 
 out:
-- 
2.43.0


