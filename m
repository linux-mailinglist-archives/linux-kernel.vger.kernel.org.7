Return-Path: <linux-kernel+bounces-761855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DFB1FF50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76791749E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F52D8785;
	Mon, 11 Aug 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHllayRV"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BF2D8766
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893387; cv=none; b=MDZTIl7551Io/JPt0Bi3hC8Q0q3OMjJBjuv14yJeZ2quQwX124Zn1yejUI8mm+N7Bpkx6p2Pwfr9CZ4oe1isgX3l3fdc8TmisFMrTYXIG9nzTrnkLNArf77KOZd0FpCSHrRhSakiBnhIWNUm9N0aSxDjqLT7R69CDRd2U/TKgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893387; c=relaxed/simple;
	bh=kI6NGT5ys/lkwU0/cazQcIvAWvZrXTgR347xrE4KlI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKFF34uPdr3uMD855e+zsuz1u5knAAAjgVlqX4hTyJ6lLH155AoTYftPtmuIDuUu3fqYV8+on5PBbe70Vf6bLC5K0bV8S8JxougwxuePrpGngcAYoFNhY+Y1IFwt5KGdJRTLNmc6D/Do5fxYLbCGpnigjAL2nnJcCiajhAqEXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHllayRV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so3127445b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893385; x=1755498185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWgeB20TJQPEfQNsZXJ7cK+JOvHWRfbLOmbpKuiAvmo=;
        b=MHllayRVT0MAb0JhuvKVZU/c5zQyCtZlzLD4SLy7q7U5L1hBYb+KrejmcoWduTIHge
         nOwyym3NDHQ8Wb41ysocUdixV1XuO2P8TuBhHOtahdC7gYAiJng/KFzmCnIS5jx+ieIb
         mxgcgrTVeaY4Q3BAMJ0tHjhYyGs0AQDBYkmUW5/UA7yzmCv9W0AFAW9DPkGAOsLcDrq0
         z5gOiHoBGh51l997EWSeSsoxSHKYx94xYCooioMz/sxPsiZ6IAdvptVzFQrGh656v8zJ
         NyGvJsMYXsfuyp/H7wvTDlvUHbljImfmNg//YKLkyhLpI+CuE8oyUIACcOCfZDhszRSb
         O8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893385; x=1755498185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWgeB20TJQPEfQNsZXJ7cK+JOvHWRfbLOmbpKuiAvmo=;
        b=axk/Sd3qpQJ9/dyp8p1hb6LbY9YbEELttTMO5ZoTQZWAl8H50RKA85vagkFqDQ4zlv
         8uLe4ML5ck9AXgvJQ8O48q76okewkHS3uAgDrpk2gyWr8u3ugwixxTfJHPmnYhqj4vbx
         eMuUTOHe8Gp26MvB0eDDxg/Nvaw/UuiDqLHglxcocKAJ/WKdPH4tfAmIEMnWqCG7eN9r
         1mHjai47rRcyoE4R/hc8CxSqlaQIdSwPEvMY9ViqMCWBYIxsQcG/5XWay0tjdHvshSVi
         f8ZM+CkX6q9TliknYiQc+3iJWTZcMPBA4noky5DA9ODPRCXApCPN0lrKG7JDCXDSYFbG
         J4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGx6BcIEhEgdI7jo7y9Zo2OA0YzSb8S6Kfa/Pb9XO1xbFHUit1XWk70XwvZeBZMZxHlp1g2odaiQ1WlGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BLlrv3KbjqD8xSSLTHVoTKGdJR+IKp8eDzl/JgK0OllYpbBB
	NtI5DIS8zCAGvrLNaSz6SrMTuuvTnhLx/P4RZQzQToJmk2xxwqQOcc7b
X-Gm-Gg: ASbGncs62CidvVafXwCH7/pG7s6+FXq1T5XV76ys7BCkQlZdrswii0nPtqm+gwIO6av
	uuCnc2WlE4+Hm0cbKS4L6GdqXLVmbjdsFyIq+T9uzi28IXmMVEKCwb1n8av/I3wJN+6W0cJSngT
	Dk6tGfFXLXtYaLDt69qlmuLqF+50AD1TFsqKoAKwathYGteE5Dd9NH5Y2mY/jCmW2833N9MSQdV
	VuivqJa3TIyanHc9BohNLw7OwRXQzfgSCvyTzVJn0SwntkSyBHTDE2o1dWiMWwF6HO8hW6Ytrux
	dHnAwRIkJcrCn5hszkwmql1VLh1M+jJ/k+Ue3UGa77IbPE6qFw5Y7ISK3wEV4fgC2nqUiT9RFtl
	WZGcdUNIRa91sRIy34FYNKFyqB3CFFXe1bZ+kkAsPgu2oSp1mAUx0vf09eHs3NKIZKhOQJhxJ2f
	z/iTGFHr0cKIFtyKYVdR6KQxA2Taut+al7zVUu9lOK
X-Google-Smtp-Source: AGHT+IG1libwMWCUmFR8pcGGzrrEWkdMDUATuQ0PVRPbyrDD8NeUpYxsxKKWlAOs7LoFdelWwWbpmA==
X-Received: by 2002:a05:6a00:238b:b0:76b:92ac:27cc with SMTP id d2e1a72fcca58-76c45f8d0c1mr14763705b3a.0.1754893384615;
        Sun, 10 Aug 2025 23:23:04 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:23:04 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 07/11] staging: rtl8723bs: Add spaces around binary operators
Date: Mon, 11 Aug 2025 14:21:30 +0800
Message-ID: <20250811062132.102525-7-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds spaces around binary operators to conform to the kernel
coding style.
The change improves readability by making expressions like 'a+b' easier
to read as 'a + b', aligning the code with project guidelines.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c  |  2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 25 +++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 09032131e35e..1f9a3af84c7c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1453,7 +1453,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen+2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index c4ead692928b..a11afebc8b9e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -206,7 +206,7 @@ int rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 	_init_workitem(&pevtpriv->c2h_wk, c2h_wk_callback, NULL);
 	pevtpriv->c2h_wk_alive = false;
-	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN+1);
+	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
 	if (!pevtpriv->c2h_queue)
 		return -ENOMEM;
 
@@ -703,7 +703,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	t_len = sizeof(struct wlan_bssid_ex);
 
 	/* for hidden ap to set fw_state here */
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) != true) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE) != true) {
 		switch (ndis_network_mode) {
 		case Ndis802_11IBSS:
 			set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
@@ -728,10 +728,11 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->ie_length;
 
-	if ((psecnetwork->ie_length-12) < (256-1))
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->ie_length-12);
+	if ((psecnetwork->ie_length - 12) < (256 - 1))
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12],
+		       psecnetwork->ie_length - 12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256-1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], (256 - 1));
 
 	psecnetwork->ie_length = 0;
 	/*  Added by Albert 2009/02/18 */
@@ -1155,8 +1156,10 @@ static void collect_traffic_statistics(struct adapter *padapter)
 	pdvobjpriv->traffic_stat.last_tx_bytes = pdvobjpriv->traffic_stat.tx_bytes;
 	pdvobjpriv->traffic_stat.last_rx_bytes = pdvobjpriv->traffic_stat.rx_bytes;
 
-	pdvobjpriv->traffic_stat.cur_tx_tp = (u32)(pdvobjpriv->traffic_stat.cur_tx_bytes * 8/2/1024/1024);
-	pdvobjpriv->traffic_stat.cur_rx_tp = (u32)(pdvobjpriv->traffic_stat.cur_rx_bytes * 8/2/1024/1024);
+	pdvobjpriv->traffic_stat.cur_tx_tp = (u32)(pdvobjpriv->traffic_stat.cur_tx_bytes *
+						   8 / 2 / 1024 / 1024);
+	pdvobjpriv->traffic_stat.cur_rx_tp = (u32)(pdvobjpriv->traffic_stat.cur_rx_bytes *
+						   8 / 2 / 1024 / 1024);
 }
 
 u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
@@ -1629,9 +1632,9 @@ static void rtw_btinfo_hdl(struct adapter *adapter, u8 *buf, u16 buf_len)
 
 	cmd_idx = info->cid;
 
-	if (info->len > buf_len-2) {
+	if (info->len > buf_len - 2) {
 		rtw_warn_on(1);
-		len = buf_len-2;
+		len = buf_len - 2;
 	} else {
 		len = info->len;
 	}
@@ -1641,7 +1644,7 @@ static void rtw_btinfo_hdl(struct adapter *adapter, u8 *buf, u16 buf_len)
 		buf[1] = 0;
 	else if (cmd_idx == BTINFO_BT_AUTO_RPT)
 		buf[1] = 2;
-	hal_btcoex_BtInfoNotify(adapter, len+1, &buf[1]);
+	hal_btcoex_BtInfoNotify(adapter, len + 1, &buf[1]);
 }
 
 u8 rtw_c2h_packet_wk_cmd(struct adapter *padapter, u8 *pbuf, u16 length)
@@ -1701,7 +1704,7 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 
 	pdrvextra_cmd_parm->ec_id = C2H_WK_CID;
 	pdrvextra_cmd_parm->type = 0;
-	pdrvextra_cmd_parm->size =  c2h_evt?16:0;
+	pdrvextra_cmd_parm->size =  c2h_evt ? 16 : 0;
 	pdrvextra_cmd_parm->pbuf = c2h_evt;
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
-- 
2.43.0


