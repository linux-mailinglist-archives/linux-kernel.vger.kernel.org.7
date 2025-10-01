Return-Path: <linux-kernel+bounces-838975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC1BB08D1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CBF4A79C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79F2F0671;
	Wed,  1 Oct 2025 13:44:48 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1B29D270
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326287; cv=none; b=fGUHSz+14qISCn+EbZ/AgIiZETCeMfw2BM3y8nJVl68EyQf/kJJj+KP5ACvuisVhPKNEcdTkbQoZBGs8s7xnnxH47SghPCHseUE+j69SNLB8OuvBrwq+/ZaBot7gSbfxM+o6K7bRSE+aixLFld5WvfrHpO4T9krXUcCgWbb7fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326287; c=relaxed/simple;
	bh=ltq/mJj2q33Np4Y/fNkZB1CUEZ+TUrCUeYd3aqHRLko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lisD1klf+3RYfPbiCtvwtAH8ZF1576Iccn0r0wFBfad8zX+8q7Q5IHpEYXH62zTdGRhu9pKIJrD78YHj9wwpCCImEoMUbW88pDfE7tGL+FdhjbUtGfKXL5u5E1LYSFl+/tVcjyD8ZuUJmUCw+9GkEXOtPMRdnPIONOJMfQu7MME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so1155634b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326284; x=1759931084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2t7onTp0eUitHsc1ao/TO2r8jK0/pbqVgfSSmMMwDs=;
        b=G0l6cXzFKAJ70DyUpqKPBuxQaQWg0DDnp/ccKPcLw76N9dYI4KNOB0tBZY97GXgsVR
         7qie/BrEF99Bg266/xe1k4F0OkQWMkRojvFi4+FCaWkiXAb9fq03kRvxGFbNyCbr+shq
         TRweoGe7eHstzNBTEy1mbN3Zd/enc5vpbAOBgE6if49ik0CxkHi0ZJkU3L62nnU0ecmv
         thbSmhAiBp/iKTXxGspdCy5zWnJHffS90n7halfRoijQpkJohosDUMHsM/yn8o70ZQEM
         gaZzur/kxIAHpNPYPGelRgQ7rjOi0K+tYh9PhHxQqXab+DgXW8vQ5W33bgJP2AgmIXGa
         rTKg==
X-Forwarded-Encrypted: i=1; AJvYcCXPsfIRDJDGvvEWIXcDk/2t5zQbRL9jhyD6PeOa34Wn+t7vB/ZrYe8vWqZz9R94yVippX3mLyeKYze5biU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdjdb/AdmGESdd1ffIkTv6WXWRzgjnIkHJUgoTIRBrDDWLA7DU
	NdZ4TqPHVmOukqu8OEP4LVsRsGozPnlC7/xXr9/91EZplPabsEmAICG1
X-Gm-Gg: ASbGncs+kVBTZoAduzrJeu1UZDzhPChw2xDvCYbQc4xHJVz8sSbyc4TcwZUS4IH+4xQ
	oidD6+GAlSNRMAUvXs4U9CSX/3JwzSsefZNeAfdD2NK87p2n0zGw14hRIvoG96CM09ZNTLiM3W7
	AXh5kKJMKQ32IqZ0lYMHaqNhqDPuiltSnLBGZ4nA9GOiovaF58jSrD92m5c78jBq7qBks+UTHev
	qKue+O5rt82UpkTAcczXO8cqUnC6G2qghoXKcOrGTsNBZwCNfbY1JsBHpIHJ3DryHJJSZfIMVqA
	8r/Z48S+9nljLxwBoGW/BFIJWuucrVTNw+qDeJLjMW8CAh3Cz7Zj4+wCRqNhoZ9rjwcMefTuVXh
	SsBIDssB/HwMzSLPoeCfToPV3+NRzqF1X8w==
X-Google-Smtp-Source: AGHT+IF8oxwvGnJmdX//1C2nMMAf4sD2XSeL+azrp3c0CA0Vrkobm/UfXPoSy8H0T1mcLezuXqGVbg==
X-Received: by 2002:a05:6a00:4303:b0:77f:5cbb:16a3 with SMTP id d2e1a72fcca58-787c76db16emr8716029b3a.5.1759326284009;
        Wed, 01 Oct 2025 06:44:44 -0700 (PDT)
Received: from ankit-lapy.. ([2401:4900:8fca:69bd:75b:5049:291:c56e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06e67sm16180730b3a.91.2025.10.01.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:44:43 -0700 (PDT)
From: Ankit@web.codeaurora.org, Bhalani@web.codeaurora.org,
	er.ankitbhalani@gmail.com
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	abrahamadekunle50@gmail.com,
	julia.lawall@inria.fr,
	viro@zeniv.linux.org.uk,
	dan.carpenter@linaro.org,
	zhaochenguang@kylinos.cn,
	straube.linux@gmail.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	philipp.g.hortmann@gmail.com,
	vivek.balachandhar@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	hansg@kernel.org,
	nathan@kernel.org,
	Ankit Bhalani <er.ankitbhalani@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix block comment style to match kernel coding guidline
Date: Wed,  1 Oct 2025 19:14:33 +0530
Message-ID: <20251001134433.16513-1-er.ankitbhalani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankit Bhalani <er.ankitbhalani@gmail.com>

Update block comments to follow the Linux kernel coding style
recommendations. This include:

 - Ensuring proper formatting and alignment for multi-line
   comments.

Signed-off-by: Ankit Bhalani <er.ankitbhalani@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  26 +++--
 drivers/staging/rtl8723bs/core/rtw_io.c       |  48 ++++-----
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  75 ++++++-------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 102 ++++++++++--------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  10 +-
 drivers/staging/rtl8723bs/core/rtw_security.c |  87 +++++++--------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |   6 +-
 7 files changed, 186 insertions(+), 168 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 53d4c113b19c..c31e64600c0a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -132,9 +132,11 @@ u8 *rtw_set_ie(u8 *pbuf,
 	return pbuf + len + 2;
 }
 
-/*----------------------------------------------------------------------------
-index: the information element id index, limit is the limit for search
------------------------------------------------------------------------------*/
+/*
+ * ----------------------------------------------------------------------------
+ * index: the information element id index, limit is the limit for search
+ * ----------------------------------------------------------------------------
+ */
 u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)
 {
 	signed int tmp, i;
@@ -769,21 +771,27 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 {
 	unsigned int oui;
 
-	/* first 3 bytes in vendor specific information element are the IEEE
+	/*
+	 * first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
-	 * sub-type. */
+	 * sub-type.
+	 */
 	if (elen < 4)
 		return -1;
 
 	oui = get_unaligned_be24(pos);
 	switch (oui) {
 	case OUI_MICROSOFT:
-		/* Microsoft/Wi-Fi information elements are further typed and
-		 * subtyped */
+		/*
+		 * Microsoft/Wi-Fi information elements are further typed and
+		 * subtyped
+		 */
 		switch (pos[3]) {
 		case 1:
-			/* Microsoft OUI (00:50:F2) with OUI Type 1:
-			 * real WPA information element */
+			/*
+			 * Microsoft OUI (00:50:F2) with OUI Type 1:
+			 * real WPA information element
+			 */
 			elems->wpa_ie = pos;
 			elems->wpa_ie_len = elen;
 			break;
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 79d543d88278..80653768d5a5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -5,25 +5,23 @@
  *
  ******************************************************************************/
 /*
-
-The purpose of rtw_io.c
-
-a. provides the API
-
-b. provides the protocol engine
-
-c. provides the software interface between caller and the hardware interface
-
-
-Compiler Flag Option:
-
-1. CONFIG_SDIO_HCI:
-    a. USE_SYNC_IRP:  Only sync operations are provided.
-    b. USE_ASYNC_IRP:Both sync/async operations are provided.
-
-jackson@realtek.com.tw
-
-*/
+ * The purpose of rtw_io.c
+ *
+ * a. provides the API
+ *
+ * b. provides the protocol engine
+ *
+ * c. provides the software interface between caller and the hardware interface
+ *
+ *
+ * Compiler Flag Option:
+ *
+ * 1. CONFIG_SDIO_HCI:
+ *     a. USE_SYNC_IRP:  Only sync operations are provided.
+ *     b. USE_ASYNC_IRP:Both sync/async operations are provided.
+ *
+ * jackson@realtek.com.tw
+ */
 
 #include <drv_types.h>
 
@@ -135,10 +133,10 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
 }
 
 /*
-* Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
-* @return true:
-* @return false:
-*/
+ * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
+ * @return true:
+ * @return false:
+ */
 int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 {
 	int error_count = atomic_inc_return(&dvobj->continual_io_error);
@@ -150,8 +148,8 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 }
 
 /*
-* Set the continual_io_error of this @param dvobjprive to 0
-*/
+ * Set the continual_io_error of this @param dvobjprive to 0
+ */
 void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
 {
 	atomic_set(&dvobj->continual_io_error, 0);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..5cf52559ff1e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -185,10 +185,9 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head	*phead, *plist;
@@ -292,10 +291,9 @@ void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnet
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct	wlan_network *pnetwork = _rtw_find_network(scanned_queue, addr);
@@ -455,8 +453,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head	*plist, *phead;
@@ -489,8 +487,10 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 	}
 
-	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	/*
+	 * If we didn't find a match, then get a new network slot to initialize
+	 * with this beacon's information
+	 */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
@@ -823,8 +823,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -859,8 +859,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -880,8 +880,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1402,6 +1402,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
+
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
@@ -1453,9 +1454,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
-* @adapter: pointer to struct adapter structure
-*/
+ * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
+ * @adapter: pointer to struct adapter structure
+ */
 void _rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1497,9 +1498,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
-* @adapter: pointer to struct adapter structure
-*/
+ * rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
+ * @adapter: pointer to struct adapter structure
+ */
 void rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1616,10 +1617,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 }
 
 /*
-* Select a new roaming candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new roaming candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1699,10 +1700,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 }
 
 /*
-* Select a new join candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new join candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_join_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1743,11 +1744,11 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 }
 
 /*
-Calling context:
-The caller of the sub-routine will be in critical section...
-The caller must hold the following spinlock
-pmlmepriv->lock
-*/
+ * Calling context:
+ * The caller of the sub-routine will be in critical section...
+ * The caller must hold the following spinlock
+ * pmlmepriv->lock
+ */
 
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bc980d21d50e..306cd78163bf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -18,9 +18,11 @@ static struct mlme_handler mlme_sta_tbl[] = {
 	{WIFI_PROBEREQ,		"OnProbeReq",	&OnProbeReq},
 	{WIFI_PROBERSP,		"OnProbeRsp",		&OnProbeRsp},
 
-	/*----------------------------------------------------------
-					below 2 are reserved
-	-----------------------------------------------------------*/
+	/*
+	 *-----------------------------------------------------------
+	 * below 2 are reserved
+	 *-----------------------------------------------------------
+	 */
 	{0,					"DoReserved",		&DoReserved},
 	{0,					"DoReserved",		&DoReserved},
 	{WIFI_BEACON,		"OnBeacon",		&OnBeacon},
@@ -50,9 +52,11 @@ static struct action_handler OnAction_tbl[] = {
 
 static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
-/**************************************************
-OUI definitions for the vendor specific IE
-***************************************************/
+/*
+ ***************************************************
+ * OUI definitions for the vendor specific IE
+ ***************************************************
+ */
 unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
@@ -64,9 +68,11 @@ unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 static unsigned char REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 
-/********************************************************
-ChannelPlan definitions
-*********************************************************/
+/*
+ *********************************************************
+ * ChannelPlan definitions
+ *********************************************************
+ */
 static struct rt_channel_plan_2g	RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x00, RT_CHANNEL_DOMAIN_2G_WORLD , Passive scan CH 12, 13 */
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x01, RT_CHANNEL_DOMAIN_2G_ETSI1 */
@@ -187,11 +193,11 @@ int rtw_ch_set_search_ch(struct rt_channel_info *ch_set, const u32 ch)
 	return i;
 }
 
-/****************************************************************************
-
-Following are the initialization functions for WiFi MLME
-
-*****************************************************************************/
+/*
+ *****************************************************************************
+ * Following are the initialization functions for WiFi MLME
+ *****************************************************************************
+ */
 
 int init_hw_mlme_ext(struct adapter *padapter)
 {
@@ -498,11 +504,11 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 	}
 }
 
-/****************************************************************************
-
-Following are the callback functions for each subtype of the management frames
-
-*****************************************************************************/
+/*
+ ****************************************************************************
+ * Following are the callback functions for each subtype of the management frames
+ ****************************************************************************
+ */
 
 unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 {
@@ -1943,11 +1949,11 @@ inline struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	return _alloc_mgtxmitframe(pxmitpriv, false);
 }
 
-/****************************************************************************
-
-Following are some TX functions for WiFi MLME
-
-*****************************************************************************/
+/*
+ ****************************************************************************
+ * Following are some TX functions for WiFi MLME
+ ****************************************************************************
+ */
 
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 {
@@ -3790,11 +3796,11 @@ unsigned int send_beacon(struct adapter *padapter)
 		return _SUCCESS;
 }
 
-/****************************************************************************
-
-Following are some utility functions for WiFi MLME
-
-*****************************************************************************/
+/*
+ ****************************************************************************
+ * Following are some utility functions for WiFi MLME
+ ****************************************************************************
+ */
 
 void site_survey(struct adapter *padapter)
 {
@@ -4386,11 +4392,11 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	}
 }
 
-/****************************************************************************
-
-Following are the functions to report events
-
-*****************************************************************************/
+/*
+ ******************************************************************************
+ * Following are the functions to report events
+ ******************************************************************************
+ */
 
 void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame)
 {
@@ -4686,11 +4692,13 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
-/****************************************************************************
-
-Following are the event callback functions
-
-*****************************************************************************/
+/*
+ *****************************************************************************
+ *
+ * Following are the event callback functions
+ *
+ *****************************************************************************
+ */
 
 /* for sta/adhoc mode */
 void update_sta_info(struct adapter *padapter, struct sta_info *psta)
@@ -4857,8 +4865,10 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 		rtw_sta_media_status_rpt(padapter, psta, 1);
 
-		/* wakeup macid after join bss successfully to ensure
-			the subsequent data frames can be sent out normally */
+		/*
+		 * wakeup macid after join bss successfully to ensure
+		 * the subsequent data frames can be sent out normally
+		 */
 		rtw_hal_macid_wakeup(padapter, psta->mac_id);
 	}
 
@@ -4934,11 +4944,11 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 		rtw_mlmeext_disconnect(padapter);
 }
 
-/****************************************************************************
-
-Following are the functions for the timer handlers
-
-*****************************************************************************/
+/*
+ ****************************************************************************
+ * Following are the functions for the timer handlers
+ ****************************************************************************
+ */
 void _linked_info_dump(struct adapter *padapter)
 {
 	int i;
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 6a2583d0d3eb..8789a581d539 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -1005,11 +1005,11 @@ inline void rtw_set_ips_deny(struct adapter *padapter, u32 ms)
 }
 
 /*
-* rtw_pwr_wakeup - Wake the NIC up from: 1)IPS. 2)USB autosuspend
-* @adapter: pointer to struct adapter structure
-* @ips_deffer_ms: the ms will prevent from falling into IPS after wakeup
-* Return _SUCCESS or _FAIL
-*/
+ * rtw_pwr_wakeup - Wake the NIC up from: 1)IPS. 2)USB autosuspend
+ * @adapter: pointer to struct adapter structure
+ * @ips_deffer_ms: the ms will prevent from falling into IPS after wakeup
+ * Return _SUCCESS or _FAIL
+ */
 
 int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *caller)
 {
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e9f382c280d9..6357365cb63a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -30,8 +30,8 @@ const char *security_type_str(u8 value)
 /* WEP related ===== */
 
 /*
-	Need to consider the fragment  situation
-*/
+ * Need to consider the fragment  situation
+ */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
 	union {
@@ -342,23 +342,23 @@ static const unsigned short Sbox1[2][256] = {      /* Sbox for hash (can be in R
 	}
 };
 
- /*
-**********************************************************************
-* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
-*
-* Inputs:
-*     tk[]      = temporal key                         [128 bits]
-*     ta[]      = transmitter's MAC address            [ 48 bits]
-*     iv32      = upper 32 bits of IV                  [ 32 bits]
-* Output:
-*     p1k[]     = Phase 1 key                          [ 80 bits]
-*
-* Note:
-*     This function only needs to be called every 2**16 packets,
-*     although in theory it could be called every packet.
-*
-**********************************************************************
-*/
+/*
+ **********************************************************************
+ * Routine: Phase 1 -- generate P1K, given TA, TK, IV32
+ *
+ * Inputs:
+ *     tk[]      = temporal key                         [128 bits]
+ *     ta[]      = transmitter's MAC address            [ 48 bits]
+ *     iv32      = upper 32 bits of IV                  [ 32 bits]
+ * Output:
+ *     p1k[]     = Phase 1 key                          [ 80 bits]
+ *
+ * Note:
+ *     This function only needs to be called every 2**16 packets,
+ *     although in theory it could be called every packet.
+ *
+ **********************************************************************
+ */
 static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 {
 	signed int  i;
@@ -385,28 +385,28 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 
 
 /*
-**********************************************************************
-* Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
-*
-* Inputs:
-*     tk[]      = Temporal key                         [128 bits]
-*     p1k[]     = Phase 1 output key                   [ 80 bits]
-*     iv16      = low 16 bits of IV counter            [ 16 bits]
-* Output:
-*     rc4key[]  = the key used to encrypt the packet   [128 bits]
-*
-* Note:
-*     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
-*     across all packets using the same key TK value. Then, for a
-*     given value of TK[], this TKIP48 construction guarantees that
-*     the final RC4KEY value is unique across all packets.
-*
-* Suggested implementation optimization: if PPK[] is "overlaid"
-*     appropriately on RC4KEY[], there is no need for the final
-*     for loop below that copies the PPK[] result into RC4KEY[].
-*
-**********************************************************************
-*/
+ **********************************************************************
+ * Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
+ *
+ * Inputs:
+ *     tk[]      = Temporal key                         [128 bits]
+ *     p1k[]     = Phase 1 output key                   [ 80 bits]
+ *     iv16      = low 16 bits of IV counter            [ 16 bits]
+ * Output:
+ *     rc4key[]  = the key used to encrypt the packet   [128 bits]
+ *
+ * Note:
+ *     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
+ *     across all packets using the same key TK value. Then, for a
+ *     given value of TK[], this TKIP48 construction guarantees that
+ *     the final RC4KEY value is unique across all packets.
+ *
+ * Suggested implementation optimization: if PPK[] is "overlaid"
+ *     appropriately on RC4KEY[], there is no need for the final
+ *     for loop below that copies the PPK[] result into RC4KEY[].
+ *
+ **********************************************************************
+ */
 static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 {
 	signed int  i;
@@ -1514,7 +1514,7 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
 	return 0;
 }
 
-/**
+/*
  * omac1_aes_128 - One-Key CBC MAC (OMAC1) hash with AES-128 (aka AES-CMAC)
  * @key: 128-bit key for the hash operation
  * @data: Data buffer for which a MAC is determined
@@ -1525,7 +1525,8 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
  * This is a mode for using block cipher (AES in this case) for authentication.
  * OMAC1 was standardized with the name CMAC by NIST in a Special Publication
  * (SP) 800-38B.
- * modify for CONFIG_IEEE80211W */
+ * modify for CONFIG_IEEE80211W
+ */
 int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac)
 {
 	return omac1_aes_128_vector(key, 1, &data, &data_len, mac);
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 0c6072d08661..064050a0821b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1021,9 +1021,9 @@ void HTOnAssocRsp(struct adapter *padapter)
 
 	/* handle A-MPDU parameter field */
 	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
+	 * AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
+	 * AMPDU_para [4:2]:Min MPDU Start Spacing
+	 */
 	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
 
 	min_MPDU_spacing = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c) >> 2;
-- 
2.43.0


