Return-Path: <linux-kernel+bounces-761850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1BFB1FF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B847A858C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738A285078;
	Mon, 11 Aug 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN2iHUkM"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B1264A86
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893371; cv=none; b=kUCKYSbHHVb1Pt2bGQ6NPBwzbXNHGo7n36EjyolGUoXsvsNMn4XPQO5hOI+kQKSvH+3maBVbk+BhrEy/+gymavhfSBJ0mAoucdiAXJsRKmE6/UUhtLb8lueAJfF4gZE+qZocXi0y6IO9tlx1ywU02obsmX4e/vC6cMW6qp2DgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893371; c=relaxed/simple;
	bh=mO9RHZxA6D7v5L+OXylV3Ns1pwmEiGxfsUjWM40Fj9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2SNlA326T7QGuRIbmz6IcHp9gSSTt6Nvth+wGWY9bBd9QZeUUxmmvAGboupdKhmE87VHJW+9uhuakuRiAVTcxhMiUxqTOQAmb3oUwatUSdWw5TfP4YPY1o6vL2jrLv6nQ1P4pJ/cxwQw5PKP4lg+syLzTMk0oVjeElFs1JMK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN2iHUkM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76c18568e5eso4343264b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893368; x=1755498168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9Uiei19tep+fgYAiceKSS7yR/y4HYdteuFH5zT5AEQ=;
        b=jN2iHUkMkx5hR0Np2L20828AVQYROF4BAu0C0rnC7cYZfXmsEvcSvVEUH/ERcaZ+Kg
         2h6awKtFQACbun+9Kb8Zfa+DJr/sE3h8MY6308JiSwxXGpcWTRHumE5pQCir1G6vydHp
         Ov5Yr8hTZeNV/xPJaIXiouenVXaBzFfgbakia4WSZIErAPHiqO+4s8XwOopEmM92BfCi
         /CZ17+PM+i7jtCJvxnePjwyyBqgwlJwENs284K5EBXR3SNAsIWnIKeRqjgVymh8ggo7Q
         c2Okdn9nA3ROLJXbkvim0l+w8OI6nqtlika1c1VTRfeqCjkexsP5nLfuFO8kFhsEBR/A
         azLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893368; x=1755498168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9Uiei19tep+fgYAiceKSS7yR/y4HYdteuFH5zT5AEQ=;
        b=oUVx4W4qxKT+lIGrUB4Fd/QKR/48gnjS2c7PsHkWJmFUc/1gt64Cl6rvd0WjiDLEKO
         cdY/m5XGTtza35WBKt+NbFlF6fDX+bdeJVwKqbrettA6D5S4bfyMKCOjJ3h3ZYZ38wNx
         bMd3hdt5Snkf+ARjTjk1ZtC1mocxWAajrbnOMK/Nzz3uFSYDQl02DGc8LEP8ZzWOxFSm
         8yiy+VzYEXL8VGEs4/0ZjtuzhbhqYMD1wUpoF1Iw/bLA74qkLzuY118tmc4ksNjQqqu0
         cJ/Nb9+Fdt8ysJ0MFa0LeMqF0n8Nkvx4FFG6qHavWHAsQEkYvuM89C9ciNXJC23JWjfJ
         sfjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3rs/NlCVx+3RWsFtdIHIv8ToOlw+S4aRF+++Yxf0LemtHm158Or/k/UdIk1vorPWCUoykxGeeV23k/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFvSqlNcIuPUxVbxVnuQ1HahxQBdbDiU3DBUXnWOJjO91xVXo
	8eWjR9X1yA4uxMdKk/mBTY66LkRH/sbq8/9GtmX83AU5Qbrapbc/7XHq
X-Gm-Gg: ASbGnctxX2FZ4tVKepy77HMspzTSEMjij3BAgflMNYKRU+t2hacf0NxXlxkn2BDvtTo
	jqGStt0+6OAXO2B5i6+C3ESo9bsJ83e/BRLHEat3cLyAvaBHjuOR625PwW3bJN76G/VTAtE2a7o
	/wPvu4rcHwKdxx75rBPz8zhz1y06vqFbR5EDBxbD+TOsn14ytgDJA4cRz8hw4N6HhQQP/jA2HMB
	5S/INK+9vF617pib9KDIpz52KjLgGx8FGV/mNZwBr32Q24OWa8Ll6+k6EMvlFOCMzvsWVyL27Um
	xlHIFH5c4zACF61hUnzBoptsmcmJX0GFV+ElKYN4VhFhdlnE3tADDaTpbBabdFeGBHPbaTTOsw9
	YDRvpZip0AjbJJsK8VOVfQvq5Dbw2287+O62XJjTVLfaqoFfv/buFZi9QzBe8KbKhEeATR5Dtc9
	wFht18p5hmT0IpzCrJ1NnSB5Pa69pjszYsq8HC/Q7+3pGx1bV0QyQ=
X-Google-Smtp-Source: AGHT+IGE9x6xMEFPwsroLQvOg4wmhRrv1KF9xTN0BDkJeRv6sVk3tItifeN1P20JVNGu6023RqHGBA==
X-Received: by 2002:a05:6a00:3e1a:b0:76b:e144:1d91 with SMTP id d2e1a72fcca58-76c46184a6emr14259564b3a.16.1754893368269;
        Sun, 10 Aug 2025 23:22:48 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:22:47 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 02/11] staging: rtl8723bs: Reformat code to respect 100-column line limit
Date: Mon, 11 Aug 2025 14:21:25 +0800
Message-ID: <20250811062132.102525-2-changyaowen19980629@gmail.com>
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

This commit breaks several long lines of code to ensure they do not exceed
the 100-character limit.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c  |  12 ++-
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 106 ++++++++++++++++-------
 2 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 47c63177b2a6..2e59a26e6318 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
+		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
+		 * //!!! remove it, because it has been set before this.
+		 */
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
@@ -841,7 +843,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	p = rtw_get_beacon_interval_from_ie(ie); /* ie + 8; 8:
+						  *TimeStamp, 2: Beacon Interval 2:Capability
+						  */
 	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
 	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
@@ -1147,7 +1151,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  update AP's sta info */
 	update_ap_info(padapter, psta);
 
-	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
+	psta->state |= WIFI_AP_STATE; /* Aries, add, fix bug of flush_cam_entry
+				       * at STOP AP mode , 0724
+				       */
 	rtw_indicate_connect(padapter);
 
 	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index ef2d92b5588a..cc2ba213d07e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -175,7 +175,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 	if (!pcmdpriv->cmd_allocated_buf)
 		return -ENOMEM;
 
-	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((SIZE_PTR)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ-1));
+	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ -
+		((SIZE_PTR)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
 
 	pcmdpriv->rsp_allocated_buf = rtw_zmalloc(MAX_RSPSZ + 4);
 
@@ -184,7 +185,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 		return -ENOMEM;
 	}
 
-	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
+	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 -
+			((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
 
 	pcmdpriv->cmd_issued_cnt = 0;
 	pcmdpriv->cmd_done_cnt = 0;
@@ -392,8 +394,8 @@ int rtw_cmd_thread(void *context)
 
 	while (1) {
 		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
-			netdev_dbg(padapter->pnetdev,
-				   FUNC_ADPT_FMT " wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n",
+			netdev_dbg(padapter->pnetdev, FUNC_ADPT_FMT
+				" wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n",
 				   FUNC_ADPT_ARG(padapter));
 			break;
 		}
@@ -484,7 +486,9 @@ int rtw_cmd_thread(void *context)
 				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
-				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
+				pcmd_callback(pcmd->padapter, pcmd); /* need consider that free
+								      * cmd_obj in rtw_cmd_callback
+								      */
 			}
 		} else {
 			rtw_free_cmd_obj(pcmd);
@@ -557,7 +561,8 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
 			if (ssid[i].ssid_length) {
-				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
+				memcpy(&psurveyPara->ssid[i], &ssid[i],
+				       sizeof(struct ndis_802_11_ssid));
 				psurveyPara->ssid_num++;
 			}
 		}
@@ -569,7 +574,8 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
-				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&psurveyPara->ch[i], &ch[i],
+				       sizeof(struct rtw_ieee80211_channel));
 				psurveyPara->ch_num++;
 			}
 		}
@@ -681,7 +687,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
-	enum ndis_802_11_network_infrastructure ndis_network_mode = pnetwork->network.infrastructure_mode;
+	enum ndis_802_11_network_infrastructure ndis_network_mode =
+		pnetwork->network.infrastructure_mode;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 tmp_len;
@@ -735,12 +742,19 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	if (!pmlmepriv->assoc_by_bssid)
 		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
 
-	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length);
+	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter,
+						     &pnetwork->network.ies[0],
+						     &psecnetwork->ies[0],
+						     pnetwork->network.ie_length);
 
 	pqospriv->qos_option = 0;
 
 	if (pregistrypriv->wmm_enable) {
-		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length, psecnetwork->ie_length);
+		tmp_len = rtw_restruct_wmm_ie(padapter,
+					      &pnetwork->network.ies[0],
+					      &psecnetwork->ies[0],
+					      pnetwork->network.ie_length,
+					      psecnetwork->ie_length);
 
 		if (psecnetwork->ie_length != tmp_len) {
 			psecnetwork->ie_length = tmp_len;
@@ -751,28 +765,39 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	phtpriv->ht_option = false;
-	ptmp = rtw_get_ie(&pnetwork->network.ies[12], WLAN_EID_HT_CAPABILITY, &tmp_len, pnetwork->network.ie_length-12);
+	ptmp = rtw_get_ie(&pnetwork->network.ies[12],
+			  WLAN_EID_HT_CAPABILITY,
+			  &tmp_len,
+			  pnetwork->network.ie_length - 12);
 	if (pregistrypriv->ht_enable && ptmp && tmp_len > 0) {
-		/* Added by Albert 2010/06/23 */
-		/* For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
-		/* Especially for Realtek 8192u SoftAP. */
+		/* Added by Albert 2010/06/23
+		 * For the WEP mode, we will use the bg mode to
+		 * do the connection to avoid some IOT issue.
+		 * Especially for Realtek 8192u SoftAP.
+		 */
 		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
 			(padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
 			(padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
 			rtw_ht_use_default_setting(padapter);
 
-			rtw_build_wmm_ie_ht(padapter, &psecnetwork->ies[12], &psecnetwork->ie_length);
+			rtw_build_wmm_ie_ht(padapter,
+					    &psecnetwork->ies[12],
+					    &psecnetwork->ie_length);
 
 			/* rtw_restructure_ht_ie */
-			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[12], &psecnetwork->ies[0],
-									pnetwork->network.ie_length-12, &psecnetwork->ie_length,
-									pnetwork->network.configuration.ds_config);
+			rtw_restructure_ht_ie(padapter,
+					      &pnetwork->network.ies[12],
+					      &psecnetwork->ies[0],
+					      pnetwork->network.ie_length - 12,
+					      &psecnetwork->ie_length,
+					      pnetwork->network.configuration.ds_config);
 		}
 	}
 
 	rtw_append_exented_cap(padapter, &psecnetwork->ies[0], &psecnetwork->ie_length);
 
-	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies, pnetwork->network.ie_length);
+	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies,
+						    pnetwork->network.ie_length);
 
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
@@ -788,7 +813,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	return res;
 }
 
-u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue) /* for sta_mode */
+u8 rtw_disassoc_cmd(struct adapter *padapter,
+		    u32 deauth_timeout_ms,
+		    bool enqueue) /* for sta_mode */
 {
 	struct cmd_obj *cmdobj = NULL;
 	struct disconnect_parm *param = NULL;
@@ -824,7 +851,9 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	return res;
 }
 
-u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infrastructure networktype, bool enqueue)
+u8 rtw_setopmode_cmd(struct adapter  *padapter,
+		     enum ndis_802_11_network_infrastructure networktype,
+		     bool enqueue)
 {
 	struct	cmd_obj *ph2c;
 	struct	setopmode_parm *psetop;
@@ -884,7 +913,9 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	if (unicast_key)
 		memcpy(&psetstakey_para->key, &sta->dot118021x_UncstKey, 16);
 	else
-		memcpy(&psetstakey_para->key, &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey, 16);
+		memcpy(&psetstakey_para->key,
+		       &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey,
+		       16);
 
 	/* jeff: set this because at least sw key is ready */
 	padapter->securitypriv.busetkipkey = true;
@@ -1117,8 +1148,10 @@ static void collect_traffic_statistics(struct adapter *padapter)
 	pdvobjpriv->traffic_stat.rx_drop = padapter->recvpriv.rx_drop;
 
 	/*  Calculate throughput in last interval */
-	pdvobjpriv->traffic_stat.cur_tx_bytes = pdvobjpriv->traffic_stat.tx_bytes - pdvobjpriv->traffic_stat.last_tx_bytes;
-	pdvobjpriv->traffic_stat.cur_rx_bytes = pdvobjpriv->traffic_stat.rx_bytes - pdvobjpriv->traffic_stat.last_rx_bytes;
+	pdvobjpriv->traffic_stat.cur_tx_bytes = pdvobjpriv->traffic_stat.tx_bytes -
+						pdvobjpriv->traffic_stat.last_tx_bytes;
+	pdvobjpriv->traffic_stat.cur_rx_bytes = pdvobjpriv->traffic_stat.rx_bytes -
+						pdvobjpriv->traffic_stat.last_rx_bytes;
 	pdvobjpriv->traffic_stat.last_tx_bytes = pdvobjpriv->traffic_stat.tx_bytes;
 	pdvobjpriv->traffic_stat.last_rx_bytes = pdvobjpriv->traffic_stat.rx_bytes;
 
@@ -1151,7 +1184,8 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
 			bBusyTraffic = true;
 
-			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > pmlmepriv->LinkDetectInfo.NumTxOkInPeriod)
+			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod >
+			    pmlmepriv->LinkDetectInfo.NumTxOkInPeriod)
 				bRxBusyTraffic = true;
 			else
 				bTxBusyTraffic = true;
@@ -1162,15 +1196,17 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > 4000) {
 			bHigherBusyTraffic = true;
 
-			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > pmlmepriv->LinkDetectInfo.NumTxOkInPeriod)
+			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod >
+			    pmlmepriv->LinkDetectInfo.NumTxOkInPeriod)
 				bHigherBusyRxTraffic = true;
 			else
 				bHigherBusyTxTraffic = true;
 		}
 
 		/*  check traffic for  powersaving. */
-		if (((pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod + pmlmepriv->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
-			(pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
+		if (((pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod +
+		      pmlmepriv->LinkDetectInfo.NumTxOkInPeriod) > 8) ||
+		     (pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
 			bEnterPS = false;
 
 			if (bBusyTraffic) {
@@ -1739,7 +1775,9 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 	pdrvextra_cmd = (struct drvextra_cmd_parm *)pbuf;
 
 	switch (pdrvextra_cmd->ec_id) {
-	case DYNAMIC_CHK_WK_CID:/* only  primary padapter go to this cmd, but execute dynamic_chk_wk_hdl() for two interfaces */
+	case DYNAMIC_CHK_WK_CID: /* only  primary padapter go to this cmd,
+				  * but execute dynamic_chk_wk_hdl() for two interfaces
+				  */
 		dynamic_chk_wk_hdl(padapter);
 		break;
 	case POWER_SAVING_CTRL_WK_CID:
@@ -1765,7 +1803,10 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 		rtw_free_assoc_resources(padapter, 1);
 		break;
 	case C2H_WK_CID:
-		rtw_hal_set_hwreg_with_buf(padapter, HW_VAR_C2H_HANDLE, pdrvextra_cmd->pbuf, pdrvextra_cmd->size);
+		rtw_hal_set_hwreg_with_buf(padapter,
+					   HW_VAR_C2H_HANDLE,
+					   pdrvextra_cmd->pbuf,
+					   pdrvextra_cmd->size);
 		break;
 	case DM_RA_MSK_WK_CID:
 		rtw_dm_ra_mask_hdl(padapter, (struct sta_info *)pdrvextra_cmd->pbuf);
@@ -1876,8 +1917,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
-		/*  we will set _FW_LINKED when there is one more sat to join us (rtw_stassoc_event_callback) */
-
+		/* we will set _FW_LINKED when there is one more
+		 * sat to join us (rtw_stassoc_event_callback)
+		 */
 	}
 
 createbss_cmd_fail:
-- 
2.43.0


