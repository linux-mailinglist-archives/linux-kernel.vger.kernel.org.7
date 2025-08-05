Return-Path: <linux-kernel+bounces-755848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DDB1AC76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3159518A1C45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371B1C8604;
	Tue,  5 Aug 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nc1K0Yke"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CE4594A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361546; cv=none; b=AtkDi2fnlqHAp2o62YBHHNMPoy8ePptKpl9sl04jU7FM3Y+2cjUUB5ZUEfxmXOabs7PbGhXSnpOM1FHLsWf/k3AUYYJzFCq5mOzqeX/0uOjhGKAq0cB5ny2pROwK46t9eiTffTtHpKgW/MAnRqHYMgP8IFN9+7mVED1rZyB7BQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361546; c=relaxed/simple;
	bh=OQ5rvNiNStnFKtNizuznac/sD0Qij3BEyjm9cQadpfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z11b3q629Fzyx1y8HEnmmUd8YRzslqQSRP9c7c41sgU1wkCFaNOp5xfj+ikNkA+GSSMxcAwNKX6A0UapHkwCSYJeJOincR5zYyRPyvaOXvFyO9wCloe/2OR0r9ZO86cp064cU7FqVMFYRa9g9WB9vhyirPmo1hvR0+Mqxy9HdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nc1K0Yke; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=v7
	ZmkNH2E1VP1CNlpUsBu6Z/29/JauBp65Ufzj4uuqI=; b=Nc1K0YkePO2hvJz+/F
	3w358mU1bzUc4zbtp2kWEa7X9N2bmcc04H/b4xFhKX66kpU3qrAtlK04buO8iyrI
	UG70ZKNKTasRKwA+YGArjgkODDB+ZmzLTPq9bWO+hJ9TiVWj/vTaFUHyvR86OjgS
	BYbb2UZu0vKqPfE5S4Lv0MZoE=
Received: from lizhuoheng-virtual-machine.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnlauobpFoOP_RDA--.30466S2;
	Tue, 05 Aug 2025 10:38:33 +0800 (CST)
From: 15620332615@163.com
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lizhuoheng@kylinos.cn
Subject: [PATCH] staging: rtl8723bs: fix space-before-tab warnings
Date: Tue,  5 Aug 2025 10:38:16 +0800
Message-Id: <20250805023816.3741-1-15620332615@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnlauobpFoOP_RDA--.30466S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfWF4UXr1fWw4xZF4rWrWfZrb_yoW8trW7Wo
	WI9Fs8Jr4xG342y397Kr18GF109w48Ww1rGw4aywnIqay7C3WUWr43Xw4UJ3W8XFsFkFZ0
	v3Wjqw1Dtr9ayFs8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4F1vUUUUU
X-CM-SenderInfo: 5o2kikywsqjjiswrkqqrwthudrp/1tbiJwegLmiRYeJtIwABsb

From: Zhuoheng Li <lizhuoheng@kylinos.cn>

Fixes multiple coding style issues reported by checkpatch.pl:
"WARNING: please, no space before tabs". This patch only adjusts
whitespace indentation without changing functionality.

Signed-off-by: Zhuoheng Li <lizhuoheng@kylinos.cn>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  51 ++++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 121 +++++++++---------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  10 +-
 3 files changed, 85 insertions(+), 97 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..28154b6a64c2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -567,12 +567,14 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 	rtw_update_scanned_network(adapter, pnetwork);
 }
 
-/* select the desired network based on the capability of the (i)bss. */
-/*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/* select the desired network based on the capability of the (i)bss.
+ * check items:
+ * (1) security
+ * (2) network_type
+ * (3) WMM
+ * (4) HT
+ * (5) others
+ */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -1841,9 +1843,9 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, signed int keyid, u8 set_tx, bool enqueue)
 {
 	u8 keylen;
-	struct cmd_obj		*pcmd;
+	struct cmd_obj *pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &adapter->cmdpriv;
+	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	signed int	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
@@ -1942,17 +1944,16 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 
 }
 
-/*  */
-/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
-/*  Added by Annie, 2006-05-07. */
-/*  */
-/*  Search by BSSID, */
-/*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
-/*  */
-/*  */
-
+/* Ported from 8185: IsInPreAuthKeyList(). 
+ * (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.)
+ * Added by Annie, 2006-05-07.
+ *
+ * Search by BSSID,
+ *
+ * Return Value:
+ * -1: if there is no pre-auth key in the  table
+ * >=0: if there is pre-auth key, and return the entry id
+ */
 static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 {
 	struct security_priv *p = &Adapter->securitypriv;
@@ -2099,7 +2100,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2125,8 +2126,8 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 void rtw_ht_use_default_setting(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	bool		bHwLDPCSupport = false, bHwSTBCSupport = false;
 	bool		bHwSupportBeamformer = false, bHwSupportBeamformee = false;
@@ -2200,7 +2201,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2321,7 +2322,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	int len;
 	struct ieee80211_ht_cap *pht_capie;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
@@ -2443,7 +2444,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bc980d21d50e..a830646fbcb1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -937,10 +937,10 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
 	struct sta_info *pstat;
-	unsigned char 	*p, *pos, *wpa_ie;
+	unsigned char *p, *pos, *wpa_ie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 	int		i, ie_len, wpa_ie_len, left;
-	unsigned char 	supportRate[16];
+	unsigned char supportRate[16];
 	int					supportRateNum;
 	unsigned short		status = WLAN_STATUS_SUCCESS;
 	unsigned short		frame_type, ie_offset = 0;
@@ -1122,9 +1122,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	if (!wpa_ie) {
 		if (elems.wps_ie) {
 			pstat->flags |= WLAN_STA_WPS;
-			/* wpabuf_free(sta->wps_ie); */
-			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
-			/* 				elems.wps_ie_len - 4); */
 		} else {
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
 		}
@@ -1502,11 +1499,12 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		return _SUCCESS;
 	}
 
-	/* 	Commented by Albert 20130604 */
-	/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
-	/* 	we will send the deauth first. */
-	/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
-	/* 	Added the following code to avoid this case. */
+	/* Commented by Albert 20130604
+	 * Before sending the auth frame to start the STA/GC mode connection with AP/GO,
+	 * we will send the deauth first.
+	 * However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth.
+	 * Added the following code to avoid this case.
+	 */
 	if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
 	    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
 		if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
@@ -1626,8 +1624,8 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	u8 *addr;
 	struct sta_info *psta = NULL;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	unsigned char 	*frame_body;
-	unsigned char 	category, action;
+	unsigned char *frame_body;
+	unsigned char category, action;
 	unsigned short	tid, status;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -2259,10 +2257,10 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 {
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	unsigned char 				*mac, *bssid;
+	unsigned char *mac, *bssid;
 	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 
 	u8 *pwps_ie;
@@ -2456,12 +2454,12 @@ static int _issue_probereq(struct adapter *padapter,
 	int ret = _FAIL;
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
-	unsigned char 		*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	unsigned char 		*mac;
-	unsigned char 		bssrate[NumRates];
-	struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv);
+	unsigned char *mac;
+	unsigned char bssrate[NumRates];
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	int	bssrate_len = 0;
@@ -2486,11 +2484,11 @@ static int _issue_probereq(struct adapter *padapter,
 	*(fctrl) = 0;
 
 	if (da) {
-		/* 	unicast probe request frame */
+		/* unicast probe request frame */
 		memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
 	} else {
-		/* 	broadcast probe request frame */
+		/* broadcast probe request frame */
 		eth_broadcast_addr(pwlanhdr->addr1);
 		eth_broadcast_addr(pwlanhdr->addr3);
 	}
@@ -2584,13 +2582,13 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 {
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	unsigned int					val32;
 	unsigned short				val16;
 	int use_shared_key = 0;
-	struct xmit_priv 		*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	__le16 le_tmp;
@@ -2841,14 +2839,14 @@ void issue_assocreq(struct adapter *padapter)
 	int ret = _FAIL;
 	struct xmit_frame				*pmgntframe;
 	struct pkt_attrib				*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr			*pwlanhdr;
 	__le16 *fctrl;
 	__le16 val16;
 	unsigned int					i, j, index = 0;
 	unsigned char bssrate[NumRates], sta_bssrate[NumRates];
 	struct ndis_80211_var_ie *pIE;
-	struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -3018,7 +3016,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret = _FAIL;
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv *pxmitpriv;
@@ -3163,11 +3161,11 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret = _FAIL;
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	u16 *qc;
-	struct xmit_priv 		*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
@@ -3272,10 +3270,10 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 {
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 				*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv 		*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	int ret = _FAIL;
@@ -3366,10 +3364,10 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 	u8 category = RTW_WLAN_CATEGORY_SA_QUERY;
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
-	u8 			*pframe;
+	u8 *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	__le16 le_tmp;
@@ -3439,15 +3437,15 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
-	u8 			*pframe;
+	u8 *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct sta_info 	*psta;
-	struct sta_priv 	*pstapriv = &padapter->stapriv;
-	struct registry_priv 	*pregpriv = &padapter->registrypriv;
+	struct sta_info *psta;
+	struct sta_priv *pstapriv = &padapter->stapriv;
+	struct registry_priv *pregpriv = &padapter->registrypriv;
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -3585,11 +3583,11 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	unsigned char category, action;
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
-	unsigned char 			*pframe;
+	unsigned char *pframe;
 	struct ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	struct	wlan_network	*pnetwork = NULL;
-	struct xmit_priv 		*pxmitpriv = &(padapter->xmitpriv);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -3798,7 +3796,7 @@ Following are some utility functions for WiFi MLME
 
 void site_survey(struct adapter *padapter)
 {
-	unsigned char 	survey_channel = 0, val8;
+	unsigned char survey_channel = 0, val8;
 	enum rt_scan_type	ScanType = SCAN_PASSIVE;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -3867,7 +3865,7 @@ void site_survey(struct adapter *padapter)
 		set_survey_timer(pmlmeext, channel_scan_time_ms);
 	} else {
 
-		/* 	channel number is 0 or this channel is not valid. */
+		/* channel number is 0 or this channel is not valid. */
 
 		{
 			pmlmeext->sitesurvey_res.state = SCAN_COMPLETE;
@@ -4144,12 +4142,13 @@ void start_clnt_join(struct adapter *padapter)
 
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
-		/*  Because of AP's not receiving deauth before */
-		/*  AP may: 1)not response auth or 2)deauth us after link is complete */
-		/*  issue deauth before issuing auth to deal with the situation */
-
-		/* 	Commented by Albert 2012/07/21 */
-		/* 	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
+		/* Because of AP's not receiving deauth before
+		 * AP may: 1)not response auth or 2)deauth us after link is complete
+		 * issue deauth before issuing auth to deal with the situation
+		 *
+		 * Commented by Albert 2012/07/21
+		 * For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it.
+		 */
 		{
 				/* To avoid connecting to AP fail during resume process, change retry count from 5 to 1 */
 				issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, 1, 100);
@@ -4322,7 +4321,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 					k++;
 				} else if (chplan_sta[i].ChannelNum < chplan_ap.Channel[j]) {
 					chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
-/* 					chplan_new[k].ScanType = chplan_sta[i].ScanType; */
 					chplan_new[k].ScanType = SCAN_PASSIVE;
 					i++;
 					k++;
@@ -4340,7 +4338,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 				(chplan_sta[i].ChannelNum <= 14)) {
 
 				chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
-/* 				chplan_new[k].ScanType = chplan_sta[i].ScanType; */
 				chplan_new[k].ScanType = SCAN_PASSIVE;
 				i++;
 				k++;
@@ -4460,7 +4457,7 @@ void report_surveydone_event(struct adapter *padapter)
 	u32 cmdsz;
 	struct surveydone_event *psurveydone_evt;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -4504,7 +4501,7 @@ void report_join_res(struct adapter *padapter, int res)
 	u32 cmdsz;
 	struct joinbss_event		*pjoinbss_evt;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
@@ -4554,7 +4551,7 @@ void report_wmm_edca_update(struct adapter *padapter)
 	u32 cmdsz;
 	struct wmm_event		*pwmm_event;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -4600,7 +4597,7 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	int	mac_id;
 	struct stadel_event			*pdel_sta_evt;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -4651,7 +4648,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	u32 cmdsz;
 	struct stassoc_event		*padd_sta_evt;
 	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -4755,7 +4752,7 @@ void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 
 static void rtw_mlmeext_disconnect(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
@@ -4805,7 +4802,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	struct sta_priv 	*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 join_type;
 	struct sta_info *psta;
 
@@ -4983,11 +4980,11 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 void linked_status_chk(struct adapter *padapter)
 {
 	u32 i;
-	struct sta_info 	*psta;
-	struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv);
+	struct sta_info *psta;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct sta_priv 	*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 
 	if (is_client_associated_to_ap(padapter)) {
@@ -5091,8 +5088,8 @@ void survey_timer_hdl(struct timer_list *t)
 		timer_container_of(padapter, t, mlmeextpriv.survey_timer);
 	struct cmd_obj	*ph2c;
 	struct sitesurvey_parm	*psurveyPara;
-	struct cmd_priv 				*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_ext_priv 	*pmlmeext = &padapter->mlmeextpriv;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	/* issue rtw_sitesurvey_cmd */
 	if (pmlmeext->sitesurvey_res.state > SCAN_START) {
@@ -5124,12 +5121,8 @@ void link_timer_hdl(struct timer_list *t)
 {
 	struct adapter *padapter =
 		timer_container_of(padapter, t, mlmeextpriv.link_timer);
-	/* static unsigned int		rx_pkt = 0; */
-	/* static u64				tx_cnt = 0; */
-	/* struct xmit_priv 	*pxmitpriv = &(padapter->xmitpriv); */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	/* struct sta_priv 	*pstapriv = &padapter->stapriv; */
 
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 6a2583d0d3eb..7b643ac320f0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -430,10 +430,7 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 	return err;
 }
 
-/*  */
-/* 	Description: */
-/* 		Enter the leisure power save mode. */
-/*  */
+/* Description: Enter the leisure power save mode. */
 void LPS_Enter(struct adapter *padapter, const char *msg)
 {
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
@@ -466,10 +463,7 @@ void LPS_Enter(struct adapter *padapter, const char *msg)
 	}
 }
 
-/*  */
-/* 	Description: */
-/* 		Leave the leisure power save mode. */
-/*  */
+/* Description: Leave the leisure power save mode. */
 void LPS_Leave(struct adapter *padapter, const char *msg)
 {
 #define LPS_LEAVE_TIMEOUT_MS 100
-- 
2.34.1


