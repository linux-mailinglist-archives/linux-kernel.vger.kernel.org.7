Return-Path: <linux-kernel+bounces-759413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C27B1DD3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164B118C05BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978B2222BA;
	Thu,  7 Aug 2025 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrehkemper.de header.i=@jrehkemper.de header.b="XwqXkt2x";
	dkim=permerror (0-bit key) header.d=jrehkemper.de header.i=@jrehkemper.de header.b="yTYBaQon"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3C2206A6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593000; cv=pass; b=PNFCw4XUHn142SxA8dtPkLsSzSfVKX8+IuJMd2A5okcRXbNAVW9DW4rIAP3CmMp4uMaX+ByVmpVNVOW6lMuHg3eUPXD/0F/IG6uitsVwy0hSyzFEFlZc4Xjh7B7q41j54YLw9NPL+weayspJiLHJ0OyzxR5C9RZhd/5M+xU+Ze0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593000; c=relaxed/simple;
	bh=NnDtTwFvLQ0Rr2HPPVNQHfOWHto9wSQDfYXWq60KuXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ET8qebvGH/fd0aPkHKX1f9yBNiBo/Qkx2TT/zkpSOspuGfiQgJ6QjYejPyPDLWbgBcFV+u/z3yDk+4cVbC2pi+4q1PoaH5N+9yps+ZhVAVj3kMZpsTJ112XGwGF6vrmbuDqaB+Rvq9wc2fNb1SFPrYgOJqofrBHvQufgTW5J2Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jrehkemper.de; spf=none smtp.mailfrom=jrehkemper.de; dkim=pass (2048-bit key) header.d=jrehkemper.de header.i=@jrehkemper.de header.b=XwqXkt2x; dkim=permerror (0-bit key) header.d=jrehkemper.de header.i=@jrehkemper.de header.b=yTYBaQon; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jrehkemper.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrehkemper.de
ARC-Seal: i=1; a=rsa-sha256; t=1754592989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LMq1OD3q5MaWC1TM6LuUTTyvjpB+GYARlQfZexQF93o/Q8tZwS0iAybqBiSfKiqu8L
    sNXNxc4oIBmIb6+jBOsO2cVLpFeRFXDREYjRIyNQE64f54ibM19QD+PV1hoxzMpUn4gq
    Z286WAdxNnfdNLM4zgEWYViJx8qLGfC0YT/Einqrb2eCsZq1Edi8rYEZ6inSUANZ7vKn
    a0yzI8DtiKPiUDvwzSdktMSafNN1SY9m7zVej71SclciA+wvXPZVztfr9tD2SvEWqAD8
    KBuTlnpyWcLeKUdkxoAiYNR+cgPb9wTiZAuZ1xndnn/SfgP3FhF9ogO3lKf2x8LlN/r0
    RBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1754592989;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YzDBe2sAGz/FOk8/LhAxz0Yhd2qb63gxZFWAqhaO1/c=;
    b=gbcHsLvYCk1LgbWSDRc5jDuFgo3FEKf1BJnpoktotxYqo6H754sZSh9BZhuZPbwOS+
    qGG24w0W2H1dTJH6maNpMTRO/SjhsFYX6wEob4Mv8VqTraVxk06b9gzO/gWvXqaT8f5i
    +8999MOKOB98pEM33KBPS+bp0dvtIys0bo/s0rZNjRSZZDiUUHc8yRRTCHzEfoUS9wOD
    KHAPkK1VSt7TSXepNdtjaPXwDfq6VGuiFeZkafeAwmxsKtSRCSqWFJgP89tQkmgxf678
    vzQS8Ld8oTxYmfqKoe3Em1vSEnBwsaXHRbNwP+5A+OXxSNq+tV7HcYQuFpMLoKNmKkmU
    swzg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754592989;
    s=strato-dkim-0002; d=jrehkemper.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YzDBe2sAGz/FOk8/LhAxz0Yhd2qb63gxZFWAqhaO1/c=;
    b=XwqXkt2xmo6i0n686iOj+HzxbhD0JMG+HlKt5+pJozLDb+c+e6Jlj1kS63Q2L9Xk7/
    ODuwNiHjrz4OlTAaFEWFa2MZedPHaJYhKv4JKQI0owPA2Hf5hnVlmhVpl/4UAnA5dz5l
    ZDLQaUdeN+YzND7EyEHEivk3M2BLvCInjzIIO88BdtMgA/pqfjY9C+igBuWtSQ87NYxW
    FSeqbbbef7BlBDG/E8cGHJLRwtcZxwvH9PKn9qt8fSpDaLxdM0NNXL26hbS3QhOGfDiC
    5mFhKcwyxWtWFV5Lv02dzB+lld0Hm2CGdbSx7huvPAnB63vIJi3FSrMM72szxf2hyJ7B
    dbJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754592989;
    s=strato-dkim-0003; d=jrehkemper.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=YzDBe2sAGz/FOk8/LhAxz0Yhd2qb63gxZFWAqhaO1/c=;
    b=yTYBaQonpKAl5cDqrrwFMGDyxt56LMjPhbgSgDpN9qr+MXhJglu1W/l7+gVp2AnIOR
    K7Q1ihgsSobky5SC9GDg==
X-RZG-AUTH: ":P3UXYUWlW/UH7OuSEKkxZGZB7CoZcv/KhgufPjlnnfm8Lzx4y5P5Ne1ZkYm0mIrMdSfG"
Received: from localhost
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id y4e242177IuTSru
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 7 Aug 2025 20:56:29 +0200 (CEST)
From: Jannik Rehkemper <jannik@jrehkemper.de>
To: gregkh@linuxfoundation.org,
	vivek6429.ts@gmail.com
Cc: philipp.g.hortmann@gmail.com,
	dan.carpenter@linaro.org,
	hansg@kernel.org,
	straube.linux@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jannik Rehkemper <jannik@jrehkemper.de>
Subject: [PATCH] staging: rtl8723bs: fix checkpatch spaces preferred around that
Date: Thu,  7 Aug 2025 20:54:37 +0200
Message-ID: <20250807185436.853318-2-jannik@jrehkemper.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Added spaces where prefered or required by the checkpatch.pl script to
adhere codestyle.

Signed-off-by: Jannik Rehkemper <jannik@jrehkemper.de>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 0c6072d08661..1def9758852c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -170,10 +170,10 @@ void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *bssrat
 
 void set_mcs_rate_by_mask(u8 *mcs_set, u32 mask)
 {
-	u8 mcs_rate_1r = (u8)(mask&0xff);
-	u8 mcs_rate_2r = (u8)((mask>>8)&0xff);
-	u8 mcs_rate_3r = (u8)((mask>>16)&0xff);
-	u8 mcs_rate_4r = (u8)((mask>>24)&0xff);
+	u8 mcs_rate_1r = (u8)(mask & 0xff);
+	u8 mcs_rate_2r = (u8)((mask >> 8) & 0xff);
+	u8 mcs_rate_3r = (u8)((mask >> 16) & 0xff);
+	u8 mcs_rate_4r = (u8)((mask >> 24) & 0xff);
 
 	mcs_set[0] &= mcs_rate_1r;
 	mcs_set[1] &= mcs_rate_2r;
@@ -267,21 +267,21 @@ inline void rtw_set_oper_ch(struct adapter *adapter, u8 ch)
 		dvobj->on_oper_ch_time = jiffies;
 
 #ifdef DBG_CH_SWITCH
-		cnt += scnprintf(msg+cnt, len-cnt, "switch to ch %3u", ch);
+		cnt += scnprintf(msg + cnt, len - cnt, "switch to ch %3u", ch);
 
 		for (i = 0; i < dvobj->iface_nums; i++) {
 			struct adapter *iface = dvobj->padapters[i];
 
-			cnt += scnprintf(msg+cnt, len-cnt, " [%s:", ADPT_ARG(iface));
+			cnt += scnprintf(msg + cnt, len - cnt, " [%s:", ADPT_ARG(iface));
 			if (iface->mlmeextpriv.cur_channel == ch)
-				cnt += scnprintf(msg+cnt, len-cnt, "C");
+				cnt += scnprintf(msg + cnt, len - cnt, "C");
 			else
-				cnt += scnprintf(msg+cnt, len-cnt, "_");
+				cnt += scnprintf(msg + cnt, len - cnt, "_");
 			if (iface->wdinfo.listen_channel == ch && !rtw_p2p_chk_state(&iface->wdinfo, P2P_STATE_NONE))
-				cnt += scnprintf(msg+cnt, len-cnt, "L");
+				cnt += scnprintf(msg + cnt, len - cnt, "L");
 			else
-				cnt += scnprintf(msg+cnt, len-cnt, "_");
-			cnt += scnprintf(msg+cnt, len-cnt, "]");
+				cnt += scnprintf(msg + cnt, len - cnt, "_");
+			cnt += scnprintf(msg + cnt, len - cnt, "]");
 		}
 
 #endif /* DBG_CH_SWITCH */
@@ -381,7 +381,7 @@ int is_client_associated_to_ap(struct adapter *padapter)
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE))
+	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE))
 		return true;
 	else
 		return _FAIL;
@@ -392,7 +392,7 @@ int is_client_associated_to_ibss(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE))
+	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
 		return true;
 	else
 		return _FAIL;
@@ -431,7 +431,7 @@ void invalidate_cam_all(struct adapter *padapter)
 
 	spin_lock_bh(&cam_ctl->lock);
 	cam_ctl->bitmap = 0;
-	memset(dvobj->cam_cache, 0, sizeof(struct cam_entry_cache)*TOTAL_CAM_ENTRY);
+	memset(dvobj->cam_cache, 0, sizeof(struct cam_entry_cache) * TOTAL_CAM_ENTRY);
 	spin_unlock_bh(&cam_ctl->lock);
 }
 
@@ -453,7 +453,7 @@ void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 			break;
 		default:
 			i = (j - 2) << 2;
-			val = (key[i] | (key[i+1] << 8) | (key[i+2] << 16) | (key[i+3] << 24));
+			val = (key[i] | (key[i + 1] << 8) | (key[i + 2] << 16) | (key[i + 3] << 24));
 			break;
 		}
 
@@ -522,7 +522,7 @@ static bool _rtw_camid_is_gk(struct adapter *adapter, u8 cam_id)
 	if (!(cam_ctl->bitmap & BIT(cam_id)))
 		goto exit;
 
-	ret = (dvobj->cam_cache[cam_id].ctrl&BIT6)?true:false;
+	ret = (dvobj->cam_cache[cam_id].ctrl & BIT6) ? true : false;
 
 exit:
 	return ret;
@@ -537,7 +537,7 @@ static s16 _rtw_camid_search(struct adapter *adapter, u8 *addr, s16 kid)
 	for (i = 0; i < TOTAL_CAM_ENTRY; i++) {
 		if (addr && memcmp(dvobj->cam_cache[i].mac, addr, ETH_ALEN))
 			continue;
-		if (kid >= 0 && kid != (dvobj->cam_cache[i].ctrl&0x03))
+		if (kid >= 0 && kid != (dvobj->cam_cache[i].ctrl & 0x03))
 			continue;
 
 		cam_id = i;
@@ -571,7 +571,7 @@ s16 rtw_camid_alloc(struct adapter *adapter, struct sta_info *sta, u8 kid)
 
 	mlmeinfo = &adapter->mlmeextpriv.mlmext_info;
 
-	if ((((mlmeinfo->state&0x03) == WIFI_FW_AP_STATE) || ((mlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE))
+	if ((((mlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) || ((mlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
 		&& !sta) {
 		/* AP/Ad-hoc mode group key: static alloction to default key by key ID */
 		if (kid > 3) {
@@ -585,7 +585,7 @@ s16 rtw_camid_alloc(struct adapter *adapter, struct sta_info *sta, u8 kid)
 		cam_id = kid;
 	} else {
 		int i;
-		u8 *addr = sta?sta->hwaddr:NULL;
+		u8 *addr = sta ? sta->hwaddr : NULL;
 
 		if (!sta) {
 			if (!(mlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
@@ -792,7 +792,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			switch (ACI) {
 			case 0x0:
 				rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BE, (u8 *)(&acParm));
-				acm_mask |= (ACM ? BIT(1):0);
+				acm_mask |= (ACM ? BIT(1) : 0);
 				edca[XMIT_BE_QUEUE] = acParm;
 				break;
 
@@ -804,13 +804,13 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 			case 0x2:
 				rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VI, (u8 *)(&acParm));
-				acm_mask |= (ACM ? BIT(2):0);
+				acm_mask |= (ACM ? BIT(2) : 0);
 				edca[XMIT_VI_QUEUE] = acParm;
 				break;
 
 			case 0x3:
 				rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_VO, (u8 *)(&acParm));
-				acm_mask |= (ACM ? BIT(3):0);
+				acm_mask |= (ACM ? BIT(3) : 0);
 				edca[XMIT_VO_QUEUE] = acParm;
 				break;
 			}
@@ -1170,7 +1170,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		ht_info_infos_0 = 0;
 	}
 	if (ht_cap_info != cur_network->bcn_info.ht_cap_info ||
-	    ((ht_info_infos_0&0x03) != (cur_network->bcn_info.ht_info_infos_0&0x03))) {
+	    ((ht_info_infos_0 & 0x03) != (cur_network->bcn_info.ht_info_infos_0 & 0x03))) {
 		{
 			/* bcn_info_update */
 			cur_network->bcn_info.ht_cap_info = ht_cap_info;
@@ -1238,12 +1238,12 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		goto _mismatch;
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
-		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
+		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length - 12);
 		if (pbuf && (wpa_ielen > 0)) {
 			rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
 					 &pairwise_cipher, &is_8021x);
 		} else {
-			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length-12);
+			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->ie_length - 12);
 
 			if (pbuf && (wpa_ielen > 0))
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
@@ -1630,7 +1630,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 
 	if (psta) {
 		param = le16_to_cpu(preq->BA_para_set);
-		tid = (param>>2)&0x0f;
+		tid = (param >> 2) & 0x0f;
 
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 
@@ -1648,7 +1648,7 @@ void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
 	pbuf = (__le32 *)pIE;
 
-	pmlmeext->TSFValue = le32_to_cpu(*(pbuf+1));
+	pmlmeext->TSFValue = le32_to_cpu(*(pbuf + 1));
 
 	pmlmeext->TSFValue = pmlmeext->TSFValue << 32;
 
@@ -1674,14 +1674,14 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
 	pbuf = (__le32 *)pIE;
 
-	tsf = le32_to_cpu(*(pbuf+1));
+	tsf = le32_to_cpu(*(pbuf + 1));
 	tsf = tsf << 32;
 	tsf |= le32_to_cpu(*pbuf);
 
 	/* delay = (timestamp mod 1024*100)/1000 (unit: ms) */
 	/* delay_ms = do_div(tsf, (pmlmeinfo->bcn_interval*1024))/1000; */
-	delay_ms = do_div(tsf, (pmlmeinfo->bcn_interval*1024));
-	delay_ms = delay_ms/1000;
+	delay_ms = do_div(tsf, (pmlmeinfo->bcn_interval * 1024));
+	delay_ms = delay_ms / 1000;
 
 	if (delay_ms >= 8)
 		pmlmeext->bcn_delay_cnt[8]++;
-- 
2.50.1


