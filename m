Return-Path: <linux-kernel+bounces-761849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019DB1FF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC683ADB80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B56285043;
	Mon, 11 Aug 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSll4r5W"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CF264A86
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893360; cv=none; b=XQW3NOYJsla7TKUiGL0Rlz3bwfzSYsR5X+/CpZSgy80IxZ1sU5Xjg7BE0jJPRT0kSDPteMyaJIZ848K6alLZBFGZHrGIEpIb3ZGmtNs2tNScG9+ZVC2Ul7Ev2MXlnatFU/s7A2HpgeU+p9yuW1OQmtSO1o7whALOSItNJ3Sji10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893360; c=relaxed/simple;
	bh=jON790ZWlgN6ZbnHI1AExklBkaMuJdp0/+MdC91//bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ+n5ql7TuEM1Mj7utwxpnwWa1ZPja5zXcZeKeZ2AXmawCA6otB5ztaHxG2tjQInMhZ4p37afi1R0pfpkwUdpQGxMrhvlXJCTKAvspw/bM/7b+wTtaPq1rfobLdF24e2zJEsMlGO4RY6DeVpVuq39tuzdXDy8GsDaPaCnY6KFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSll4r5W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc55f6612so3506146b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893358; x=1755498158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV8UeJcS+Lb84093TwDV4zLCHy2ZU5ZDahAnF6NK8YE=;
        b=eSll4r5WMawAUVADI1BLfc8OOLR/G+gWcmDT9UQcvucG6mqpl7GdifFYCqQ3dVfW1O
         Eb/365OBeksiTt0gTbJBB1x8p9WYDdUk0Qyd+RSNGgGfbeGnyo38dtM7KKgamn8pl2aH
         qgVPD8SAxWaC8vSHm4AMLN75Jm8eAD2z8DbKA+JlzGfgEmaWSCjy/n5DG0MUORBIkbzc
         +F1LQoEj2EySlgXil7J5S3dTnwD5BbbakicMecTHeC/5534D6jXH+P9h8o2Ym11izieB
         gUBrpOKwOXrP+eJuuTFOqNWIp4FUZkU897iAmfJ2kjMun1K58bOsuFETFwLboQt/o7hr
         wkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893358; x=1755498158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV8UeJcS+Lb84093TwDV4zLCHy2ZU5ZDahAnF6NK8YE=;
        b=PKTBmtNeaQrQ491td8NUEjUvTYITkROOaHn5CSciEmNZ5KEgnsGQtz7vG1VVgLO4+j
         xJfhisS3DrHeRyXDQBTTQ6EieU8F8lSayg9T6t4c3AWqSYSeSwQL32bCxHp/bWgfL69f
         zajaB0WqRj2YVhUq7UDtb+ZO49fEGuk12UlqcZzr8QzklUfKS/qZ69wcj1bpvlCMxL7u
         Tmm2raaVG0ttk+9fLhISrEdbNJCzm99SoQ61jdIC59I2bu64RnTHvsOLG38KedXhm5n0
         euHw7pIif+IK10iU3hoj4JkXg2SY6VN0N7hX/cc37GkP1g/9iwnAsVR1wqi/uJ02yX5K
         mi7w==
X-Forwarded-Encrypted: i=1; AJvYcCWNS29oTvJdTf8gHxyVeQLbUsc4mWUI3XoJLea1ycbVbZRyxZG8MFVHfVFHS457pgWavGBriUe2QjdvkFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6snYeiWI2o6nxPlDV86qy5qXq6exziIsgo4K2bLqmCR+yEPIi
	6JwFJ1ge8OB6xRrpt6f3Kyrv2HmPa9z/ZOk1GF9kb506/1DIGwBqle8W
X-Gm-Gg: ASbGncswbRFJIHKz/skvweGN5ROGRuNqDRHra+CJ5QlxFDx4syVQVDJMKcK15c7fuE4
	C4Xpx0ssI0SE4NmZaaN67aFcDNHfG2/LuBAn6Dtm82GyBz+hGL7GusKsEDQMhy3S1fkulIjp+cn
	COrQ+F/E5gyZdXns3DxqbeQqGUylr232Hffmb4TH4l2FblZgl7vA+GhpeBwpPsz4rcVd8Yw3jdn
	97dGsh/zXT0VovCJ3U6rca19l41sZ9TOEoEJxQQn0CWAw1zLLKGcO6WmMog7+nRiGAnD1j0da8t
	3KfqcHSlf2O9Ed1sZCR2YICRKk3JpLmDRGsI3ciPvQuolVVsCUAKd4NfjbzldtusYe6J29nW8cS
	3Ke8emjh68F+ZoqQQhdRsxVjL3xQrAm3NZJ0SGadUNREuCBLYu8U+gJwOIz8nngsdVd+7d0i4qw
	t4tTLpQ/RjCwyNrELwjK2kstXa2tigSJyo+tPTyK8k
X-Google-Smtp-Source: AGHT+IFoWNQtK9CeFUWctqSs1ekUWpcKamPLewF4nOaDOyYbmSoDFs4wahOaDSi+3p9759+s2HcHhw==
X-Received: by 2002:a05:6a00:8503:b0:76c:5781:2c01 with SMTP id d2e1a72fcca58-76c57812d1fmr8535082b3a.0.1754893358306;
        Sun, 10 Aug 2025 23:22:38 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:22:37 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 01/11] staging: rtl8723bs: Rename camelCase variables to snake_case
Date: Mon, 11 Aug 2025 14:21:24 +0800
Message-ID: <20250811062132.102525-1-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit renames variables that were incorrectly using a camelCase
naming convention.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index fe97bbea548c..47c63177b2a6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -320,7 +320,7 @@ void expire_timeout_chk(struct adapter *padapter)
 
 void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 {
-	unsigned char sta_band = 0, shortGIrate = false;
+	unsigned char sta_band = 0, short_GI_rate = false;
 	unsigned int tx_ra_bitmap = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
@@ -335,7 +335,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	rtw_hal_update_sta_rate_mask(padapter, psta);
 	tx_ra_bitmap = psta->ra_mask;
 
-	shortGIrate = query_ra_short_GI(psta);
+	short_GI_rate = query_ra_short_GI(psta);
 
 	if (pcur_network->configuration.ds_config > 14) {
 		sta_band |= WIRELESS_INVALID;
@@ -358,7 +358,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		arg[0] = psta->mac_id;
 		arg[1] = psta->raid;
-		arg[2] = shortGIrate;
+		arg[2] = short_GI_rate;
 		arg[3] = psta->init_rate;
 
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
@@ -368,7 +368,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 void update_bmc_sta(struct adapter *padapter)
 {
 	unsigned char network_type;
-	int supportRateNum = 0;
+	int support_rate_num = 0;
 	unsigned int tx_ra_bitmap = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -804,14 +804,14 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 {
 	int ret = _SUCCESS;
 	u8 *p;
-	u8 *pHT_caps_ie = NULL;
-	u8 *pHT_info_ie = NULL;
+	u8 *p_HT_caps_ie = NULL;
+	u8 *p_HT_info_ie = NULL;
 	struct sta_info *psta = NULL;
 	u16 cap, ht_cap = false;
 	uint ie_len = 0;
 	int group_cipher, pairwise_cipher;
-	u8 channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
-	int supportRateNum = 0;
+	u8 channel, network_type, support_rate[NDIS_802_11_LENGTH_RATES_EX];
+	int support_rate_num = 0;
 	u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
 	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
@@ -1030,7 +1030,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		u8 max_rx_ampdu_factor = 0;
 		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 
-		pHT_caps_ie = p;
+		p_HT_caps_ie = p;
 
 		ht_cap = true;
 		network_type |= WIRELESS_11_24N;
@@ -1088,7 +1088,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
-		pHT_info_ie = p;
+		p_HT_info_ie = p;
 
 	switch (network_type) {
 	case WIRELESS_11B:
@@ -1123,9 +1123,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (pregistrypriv->ampdu_enable == 1)
 			pmlmepriv->htpriv.ampdu_enable = true;
 
-		HT_caps_handler(padapter, (struct ndis_80211_var_ie *)pHT_caps_ie);
+		HT_caps_handler(padapter, (struct ndis_80211_var_ie *)p_HT_caps_ie);
 
-		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
+		HT_info_handler(padapter, (struct ndis_80211_var_ie *)p_HT_info_ie);
 	}
 
 	pbss_network->length = get_wlan_bssid_ex_sz(
-- 
2.43.0


