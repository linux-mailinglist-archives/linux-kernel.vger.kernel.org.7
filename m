Return-Path: <linux-kernel+bounces-873094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89054C13134
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07EFE351982
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C778277819;
	Tue, 28 Oct 2025 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHGNaB9p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80B284693
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631696; cv=none; b=ViopwVqLTUhMJm2gLMhsAmJEvTvus3+qUUDdZNs3gK9JWx9Nm0PvGTflAo509JJSzMneLbgHgZQ6ZxaL2S81RXLFPQtEvRtaT2QWl4MMn4mg+09hKiekJ/p0cPU/+I/s3XG9sljrZgYv3UGEfSNEmGfGKIzXg6aUlg9PMuhi+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631696; c=relaxed/simple;
	bh=W0c8R10SoHWGGlerj/TVivFgOQeuC3ZQvjeAXshqRTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krKR7lDVxNaaujALmmfkR3o2qZds3ZP5NsRJ0+amR+tFgweqbst8rvsM4C9qs5BItJxngr0DV/I9UXH+7r180XAVvqshvhDzEM3M5PDBT/7ZJ1yNWzixh8fEtsxH73oWU8GWx/gbz5/HqRrRQcZxM74eeSXShBGqvodShfQEC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AHGNaB9p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4p7f3591592
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YFQernyphzUokXIV/+I70uHICPm/RP+xKMy
	m6taPSU8=; b=AHGNaB9pEUoM29BMQpWF6/trsZW1rS5KDocyjzV8W/vz2j4q31H
	ESPuVsfd68gX/V4mkTkOL9wgY4lCXzbJ0aV4Ub810hB/4P7nsPLk+KjdVdgQFkE8
	0KTFCwyUCwd6ZwLWs14EZTyorviFMDvmzOMFjz7lfpwqJ82AxbC54C9mW2wl9Zxp
	o99XC+/nZ1KwF6BKoFFEvRwx++MypnucKh/XX9q/eikQwcFuSQn0J93lkXsWD6zB
	S8lTfhGAGLW73wU91vZ94ai/Ol8RCs21NeMA4+umq7WTZLv60aALwT374kLQqAyj
	BcZNbgVasZGCp886nqiBa2Xtc//dyLT+Zyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u85nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:08:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78117b8e49fso11918085b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631693; x=1762236493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFQernyphzUokXIV/+I70uHICPm/RP+xKMym6taPSU8=;
        b=iemUeo7TP4T0RwWfPYWjAy3nsJryESXVzpu9tolzkkn22mKHC6f2UXftCh3IvQpGoQ
         G7RWDE9rT9hK9Cq/nMEoGyDdZnR1n4w5chMV47jiJnJjMP3cT1IHAnDtcbsdMetGkJEJ
         gGg5MwzyGk2XYSYHvwj9bFDyv7tCbcUgzSYvq10WThlJxz+7+GuMCZj7zL0eOZ7fuZwZ
         XWG/sX893SZNmGBdbDe25f+HhqJUfQZg5KJfG1MyncxpIikLvK5K8efpjgE0Pbg7b1EG
         rU7TBhY7LXWS/NyKL18WEjAcM8rTzSPuDixnLniMYNODxP243tyuD+7BXLYSHvfflpjI
         6l+g==
X-Forwarded-Encrypted: i=1; AJvYcCXXzLYPTE7DfgSCdp6rJPHLinl8cGXsAdu6An2k8CDk1mw8HWIAgm/9TN3poLMQzm8gUbbXZp7PeVJF+Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywv2UU7ahAC5XT5K4FZ8KwaH9cxjaCdIpDZFkJDsRWF87TGoU7
	XbR7AyxiX+nmb88fUu8ZRQIjcng+Z+CYK6ZDObJTMBeyNGDaeStK1KMViM6kgsd1W4OYc28/Udj
	OD4h6I/9QdIjLBylviOEkpAWKnDp6MqgR6QkaM/fLzPCfJcBUYkQDYpTrK47Rza7z6xU=
X-Gm-Gg: ASbGncs2wUEnFjmthPO0r9bbYTZ1tV/tCrXfKUiLwm/XTO6Iyd6Q7jAAR1F2qG41+tv
	gvX118FKBzOdq03RAAfFslOPR6FL6/6j/rZBykW44pbD9sVe1dEm44FP88M2ASHKa/Dwxc+rav0
	itYhIkeULrvuYBk1IFasA92hswUxGCYQU3suz7JjOUOE/rxYGZNM49remf7t5F7rV0jOjDmBKet
	7DJLu/8wU6kqRIW3MSor8F0Vj8/sCMEH81K7t3jtCzFcsWE6uIOAGCEynbNKXeEgRKrLGsQ6G4P
	BPih4pu6RqfkQKI8uJGLLUNXKE/WbHH7ZiMnT/f1PJLY6zntb7ixJ0q7kznHw+icMySzNqpvro6
	jszfSDG/uxKUt02A0JpQMBKGw4xqlT62IoDfMw+FWrfP8U+ZQ+QPvKfZTYA==
X-Received: by 2002:a05:6a00:9281:b0:7a2:721b:adb6 with SMTP id d2e1a72fcca58-7a441c47627mr3120284b3a.28.1761631692846;
        Mon, 27 Oct 2025 23:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5IdZmG+yfCiDsulIMrTHpgRc/xNK0DVqnVio5NHUD8R1SXXmWIe+eXbbrig1qqDs8Z+/EJA==
X-Received: by 2002:a05:6a00:9281:b0:7a2:721b:adb6 with SMTP id d2e1a72fcca58-7a441c47627mr3120253b3a.28.1761631692335;
        Mon, 27 Oct 2025 23:08:12 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414011acdsm10204566b3a.13.2025.10.27.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:08:11 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Ross Brown <true.robot.ross@gmail.com>
Subject: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station power save configuration"
Date: Tue, 28 Oct 2025 14:07:44 +0800
Message-Id: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1MSBTYWx0ZWRfX9/V/9IQUCYhZ
 66euY7pXTYxAVL7pjiK2C1oPq3EJSd6XQn9z/m85Gd0usTKsLtaQRQbqbIc7v8Jnmcuown4jMUN
 HXQwRM+V4wo6JseaClaifnOhs/n1/nEruiPMM9B9TT/x9jcmGB13f5BFrW5C7pG6GlR9BJVZ5lT
 FIwYh/skcX8WD8Ea8diIM9GdZmW5O4QU5xR3HtQyMBLmLeiyuojt9oqWBjY5SU7aOT6mA/7AqJw
 7zsSDXuXlDGRQS7oexKscRReYoNqp2YbRUzVnp5MMRw5Or2V7pITMn9q64FKzRhPL8NW92DjDEf
 FXbOXN0moXWQ5lcTh/mNi5tsUDXRu9PzqzKPsGkZM5mcRC+NQiRof36aFvqFhCVPQ7RbCudKwWm
 HMqZnGKRgW84zWaaIo1Yy1Gk4TerrQ==
X-Proofpoint-ORIG-GUID: -X_Hv6U7x7JvoGhtMXp-Q36bwJvKUnBp
X-Proofpoint-GUID: -X_Hv6U7x7JvoGhtMXp-Q36bwJvKUnBp
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=69005dcd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=rFrEXt6fRIhDJ_V8PpwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280051

This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.

In [1], Ross Brown reports poor performance of WCN7850 after enabling
power save. Temporarily revert the fix; it will be re-enabled once
the issue is resolved.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: 4b66d18918f8 ("wifi: ath12k: Fix missing station power save configuration")
Reported-by: Ross Brown <true.robot.ross@gmail.com>
Closes: https://lore.kernel.org/all/CAMn66qZENLhDOcVJuwUZ3ir89PVtVnQRq9DkV5xjJn1p6BKB9w@mail.gmail.com/ # [1]
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++--------------
 1 file changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index eacab798630a..db351c922018 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4064,68 +4064,12 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
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
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
-
-	enable_ps = arvif->ahvif->ps;
-	if (enable_ps) {
-		psmode = WMI_STA_PS_MODE_ENABLED;
-		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
-
-		timeout = conf->dynamic_ps_timeout;
-		if (timeout == 0) {
-			info = ath12k_mac_get_link_bss_conf(arvif);
-			if (!info) {
-				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
-					    vif->addr, arvif->link_id);
-				return;
-			}
-
-			/* firmware doesn't like 0 */
-			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
-		}
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
-	}
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
-		   arvif->vdev_id, psmode ? "enable" : "disable");
-
-	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
-			    psmode, arvif->vdev_id, ret);
-}
-
 static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  u64 changed)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
-	struct ieee80211_vif_cfg *vif_cfg;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -4189,24 +4133,61 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 			}
 		}
 	}
+}
 
-	if (changed & BSS_CHANGED_PS) {
-		links = ahvif->links_map;
-		vif_cfg = &vif->cfg;
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
 
-		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
-			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-			if (!arvif || !arvif->ar)
-				continue;
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-			ar = arvif->ar;
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	enable_ps = arvif->ahvif->ps;
+	if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 
-			if (ar->ab->hw_params->supports_sta_ps) {
-				ahvif->ps = vif_cfg->ps;
-				ath12k_mac_vif_setup_ps(arvif);
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			if (!info) {
+				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
+					    vif->addr, arvif->link_id);
+				return;
 			}
+
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
 		}
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
 	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
 }
 
 static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
@@ -4228,6 +4209,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -4514,6 +4496,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	ath12k_mac_fils_discovery(arvif, info);
+
+	if (changed & BSS_CHANGED_PS &&
+	    ar->ab->hw_params->supports_sta_ps) {
+		ahvif->ps = vif_cfg->ps;
+		ath12k_mac_vif_setup_ps(arvif);
+	}
 }
 
 static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,

base-commit: 2469bb6a6af944755a7d7daf66be90f3b8decbf9
-- 
2.34.1


