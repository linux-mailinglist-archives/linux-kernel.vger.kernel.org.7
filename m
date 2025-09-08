Return-Path: <linux-kernel+bounces-804948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB1B48248
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D62D7AC85C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEAC1D54FE;
	Mon,  8 Sep 2025 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niZo6xw0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55118D65C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296251; cv=none; b=ZTsjHT8Vb2jnQtHsNDuKVwoWUl1RkuI7+gl9i/tLaQNLuPj7/jhp9dl9q/1BSEM/KW0svZH3LyVqKK2zA/HrG2xpxor9LAS8P5LLSsDq+mRm5qID1Bm+TNhEjwgy1KDqHmCWodZVbFVjY6M4hxgwu9FG4cRp/Jf5XNand/6zihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296251; c=relaxed/simple;
	bh=Oor7BlvjUAlk/PY2KVf4xP3BW6CINKyVy3+/76T/Ygo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7mZ250c0J3VVDcPsPqgfdeR/rXCheX/yg5RUqIZMXKzlfG6X3YKxkHGuDwZp/bdpTprzUI8RoZvFIRhn8V71JoecDn863nuLjB7oPdoCiuTVkuD+fMPFI0MYvWb/UXkIFJWG98YaRlRM4eg0O6eaKN8cpzb3Sp8x2SXXWumahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niZo6xw0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MlhhS030846
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 01:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tuSiT6IHKC8eyHl1HYGERUP1bY+x7+xWSlh
	+LrRLgK4=; b=niZo6xw0r3VTz3xU4co+n4AKQ8v8ypE+hhtXlSbtess9LT0yvof
	tWubFj4w6dUZ7xXIYAQwyN28VTuYxsP4x1a5uvG6ADY0g2lH5BmUahYEsjp3CIQ/
	pN3I7VwmC/Q5o9SnioXYcZ9uBL9D0eU9u20BnSTjM31skMIwzre0PqUVP+cMsIeB
	pt/Ra6acb676xPc4wH3jnObwm2FXVTr5MurHJ9lgkbWItiH07gF3GQIYAp2HGKfq
	JueX1BmCEfZhum6D7z6sHx/rxs74NtF4g6KWD1JXV+X2ZPSpNgHyC46kFa53dhq2
	lKikHAuF5KGtJLq3FZz/S394K+sM+xQg0qg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapb4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:50:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47156acca5so3235695a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296246; x=1757901046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuSiT6IHKC8eyHl1HYGERUP1bY+x7+xWSlh+LrRLgK4=;
        b=SJS/KwFQ+Cs3lNrmqzucFE4VHlIAkmwRoQhK7p5OkhBTB2TMeV6K4Af70rTkjdPBSc
         OwBGTSMtyWv/rx3gG2zKSPCld0ZCnu5ILU8HWL72hXU7vVFKkXqiYgVQ5jol14BIg4f/
         Wi/Oo5OUb/b+pe1W8+8v/CJwU9BSXRlPrL95aFhSdPoAusdlEY5sgcW33eoLS3olU9KI
         CVELb9d9RDSMmNv9eyoAl7r9su7GI2FXxUt5XTSl4aWBJN9/i0TQvAvGXSsYFVnLditQ
         74Zi983LjrpvTiobNdfHbmuvRrY8JEFTU5rxs2aTF4wWDzwSt7sJMHhEhSVOmtxRY9vs
         3+xw==
X-Forwarded-Encrypted: i=1; AJvYcCX5zOcNzAiFiXa/3kVhXK90aBqgMvn2dYOq2GAJk3R/K4EycvOKMKVb46OyIvDTu3dQ/EzqRgRK5XXDyo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaK/b0wg2l0zB6bNYCpIRPg4lmO/g/BzvIv0drCpmmAiWqqcy/
	PUKbEYb2LJBVIX8mMP8IfXw0GzpRlCTrtO5UBM52CfQY5WTZ2XjbQZf4RMQz9WkGydsv2sgftrE
	NYOJEpCwS3KanFqlm+K5cDM9pzEAcqpcrHGjqVwpCe+KF6du8IyA/C0I1jwcLd4X4gxw=
X-Gm-Gg: ASbGnctIqRpwOLixkhUeukAO2/aFADFTDJTrENLlBP6115vjr2FaP9YmjrSwOaI9uwd
	/eRDQ/9DUHOy8YEjdhBqTeR+xG6Bb4WpFgW40nxf6vIcT3tZHEMClBjPHCzaQS7L9m7kYu4SzKu
	cag7uPrMaUimcLd2dRTQXeWS2ptqUn4f37m0nY8embBX+rUkXcXzKgrDRm9OXW/ZJbEPDVAjCkh
	pyAU0i8NQRToJzgW5INVNbpw0jHl3pX1g7LLwZZo0IJ+MUMe6aycWjjA+mc20Mc9bPffAu1F2wK
	U9/6jwKeTUFGNdooT0TCQgboulP9W+aB05AutV0DKfloj4bT7OELF7ifqp+r/4j3KdreIwV8j3s
	QNo/gxSosdpvgv3mB56FeXjo=
X-Received: by 2002:a17:902:d4ce:b0:246:571:4b51 with SMTP id d9443c01a7336-2517a7dc8d1mr88578885ad.29.1757296246213;
        Sun, 07 Sep 2025 18:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/66tg8rllQbakUBONUB+tBZD9yFBmoJbh2aMvQlKw0BACgvAH43//KwIRgdKS5/R/InyMbg==
X-Received: by 2002:a17:902:d4ce:b0:246:571:4b51 with SMTP id d9443c01a7336-2517a7dc8d1mr88578715ad.29.1757296245655;
        Sun, 07 Sep 2025 18:50:45 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2527e7a49a2sm41861815ad.14.2025.09.07.18.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:50:45 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: Fix missing station power save configuration
Date: Mon,  8 Sep 2025 09:50:25 +0800
Message-Id: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68be3678 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=L_1LzjPufVM5mkcSVOQA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: CuVeWN8JxMvKWeXbA24odczeEV3Qwurm
X-Proofpoint-ORIG-GUID: CuVeWN8JxMvKWeXbA24odczeEV3Qwurm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX7AsFWpuxcrEe
 I8jTiFMl44thMl25cGcm77q/i+UleAcHf6eaFEDqTFYeDncVXurYwaejExT5adSuZxl1ntlaO9r
 xx91h+3mjAnh5cM1s/M0ETAfoOPZ1Pam//75JS4L+0Vi7EFoGnhp+FJ6AgoZmKtZ2p3ETYPgdki
 KU46r1F5BAIbEzxP1nP5mCkRMm35BZdUkeXMLz0sgt4NvHy6nNNfwf7pscFChpX4xQiMgKwrC16
 vD5j7oeMtI7dby3WNxeumjDVcyk92x3c7T4yWCfBbt+BrOIC+4I1lerk7BwRB7nnOH41vtfsTPm
 3PD7Xy2KCCSNEVEXzfk44GdH62H5TbGTYqRtbI2oULCr0ekgSHZjMn2IYqbIntDhr4NLMlJWRDO
 umda1sTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

Commit afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed()
for MLO") replaced the bss_info_changed() callback with vif_cfg_changed()
and link_info_changed() to support Multi-Link Operation (MLO). As a result,
the station power save configuration is no longer correctly applied in
ath12k_mac_bss_info_changed().

Move the handling of 'BSS_CHANGED_PS' into ath12k_mac_op_vif_cfg_changed()
to align with the updated callback structure introduced for MLO, ensuring
proper power-save behavior for station interfaces.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++++------------
 1 file changed, 67 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084..3a3965b79942 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4078,12 +4078,68 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
+static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
+	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
+	enum wmi_sta_powersave_param param;
+	struct ieee80211_bss_conf *info;
+	enum wmi_sta_ps_mode psmode;
+	int ret;
+	int timeout;
+	bool enable_ps;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	enable_ps = arvif->ahvif->ps;
+	if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			if (!info) {
+				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
+					    vif->addr, arvif->link_id);
+				return;
+			}
+
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
+		}
+
+		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
+						  timeout);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
+				    arvif->vdev_id, ret);
+			return;
+		}
+	} else {
+		psmode = WMI_STA_PS_MODE_DISABLED;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
+}
+
 static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  u64 changed)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
+	struct ieee80211_vif_cfg *vif_cfg;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -4147,61 +4203,24 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 			}
 		}
 	}
-}
-
-static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
-{
-	struct ath12k *ar = arvif->ar;
-	struct ieee80211_vif *vif = arvif->ahvif->vif;
-	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
-	enum wmi_sta_powersave_param param;
-	struct ieee80211_bss_conf *info;
-	enum wmi_sta_ps_mode psmode;
-	int ret;
-	int timeout;
-	bool enable_ps;
 
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+	if (changed & BSS_CHANGED_PS) {
+		links = ahvif->links_map;
+		vif_cfg = &vif->cfg;
 
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
+		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+			if (!arvif || !arvif->ar)
+				continue;
 
-	enable_ps = arvif->ahvif->ps;
-	if (enable_ps) {
-		psmode = WMI_STA_PS_MODE_ENABLED;
-		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+			ar = arvif->ar;
 
-		timeout = conf->dynamic_ps_timeout;
-		if (timeout == 0) {
-			info = ath12k_mac_get_link_bss_conf(arvif);
-			if (!info) {
-				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
-					    vif->addr, arvif->link_id);
-				return;
+			if (ar->ab->hw_params->supports_sta_ps) {
+				ahvif->ps = vif_cfg->ps;
+				ath12k_mac_vif_setup_ps(arvif);
 			}
-
-			/* firmware doesn't like 0 */
-			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
 		}
-
-		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
-						  timeout);
-		if (ret) {
-			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
-				    arvif->vdev_id, ret);
-			return;
-		}
-	} else {
-		psmode = WMI_STA_PS_MODE_DISABLED;
 	}
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
-		   arvif->vdev_id, psmode ? "enable" : "disable");
-
-	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
-			    psmode, arvif->vdev_id, ret);
 }
 
 static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
@@ -4223,7 +4242,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
-	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -4510,12 +4528,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	ath12k_mac_fils_discovery(arvif, info);
-
-	if (changed & BSS_CHANGED_PS &&
-	    ar->ab->hw_params->supports_sta_ps) {
-		ahvif->ps = vif_cfg->ps;
-		ath12k_mac_vif_setup_ps(arvif);
-	}
 }
 
 static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,

base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd
-- 
2.34.1


