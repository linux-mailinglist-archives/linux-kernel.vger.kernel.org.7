Return-Path: <linux-kernel+bounces-608425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8ACA9134B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 07:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B82174974
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00A1F4720;
	Thu, 17 Apr 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzBYpxgZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8521E521A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868976; cv=none; b=DeNtWyptFXgT2E+WwKkxMI8u/FrtltGV7Zhwwk20KDaeNmymb1CuhDQnoJOawYDx/eiDRDx00QJ/aUxk/ClNOoxipP5kN3Sk/w0YfAidJxMFo1Bk4Ov93UWyAzBAd4yw5BMIpBL1j8yU5B/wbBP/wb3IxSrVK1PZva4tb4SzpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868976; c=relaxed/simple;
	bh=KPVZESR1YwL7Gu1wcBkJxBXCYSlDcgPHM4VX8hoFCbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfwy9Y43DZn1P94xoDINW5GYd0/IUvFiGBZhNZ4pApDdeuan2UIWJRFwnzPEGY9ld7uil+/RaxL8AagMWlda3s+N7znvWcJUZf/uI9/hmi0x2jas0rU6qCk/9zNevKHyAW4bciNChWmbZYB1doeHf5hQi6k5EP7r/qs+WVIyHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzBYpxgZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lCbA007047
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 05:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KY4DrBghMwtTahQM4d6UO66pLjRLPs99V5LIXxHJ/Mk=; b=RzBYpxgZ6A6zCPW1
	g9u2KchZIN9KHVRbJeboCC5g3UTaRRIClGaWIbGH45f2PV1xX3IzTWHX8ddMCdEL
	X7qhX1pEeOhGFUG3AOYMnO8VQSDaYwq0bFt/UFB4+EjN23qHOZSi0cB6xD7wHMtq
	X0xJzEQ7uNm5A0S4fQclue9N6Ykuw/dHU80emQ74qIOjYxQoKex9RKg7FswpPPB9
	nO6NakEBWWb63jVMe7XgCx8PWVKWupoEewL21hgMUeo3vaz29lUDtjrsuLGYyegx
	aJ/7G6l+PHDkJlXUalg5P6wF+cmZclC+FFE31aq8YTZUrfj4PLEeVNeXpkAfU7xJ
	B6qKeg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1dq3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 05:49:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2265a09dbfcso8187585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 22:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868971; x=1745473771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY4DrBghMwtTahQM4d6UO66pLjRLPs99V5LIXxHJ/Mk=;
        b=s0ZzZH9djkzo84xTZVM4ev1+a0VWvYJ/5hliEjjDfoTOHwgmpY7TBZdcPNrD0Lx2Xc
         OxtkQ9Vg449JjUb2sBa6UfLzcRqQ/y7ei0I+56KMk7LhEnes3Nj38PbgIc6wiKE5H58N
         F7JljVYEAXDg9fFHyVNZxfgzn6N75JunsOwc2qx02uAzxR7ziqphrZwTq8A2oP3XMrj7
         ONJxX8YFYU51BK5z2gR+sNSFfXyBpOgt5oNZeDtDAygZmXq63i/bBfokb9NO5nEJ7T50
         1J8vYTUQZdDa3fhRlCkn8Ea9NNyfnwomOPwQkQf/i6pVEd4vNJhx5Wi1ZTYlKtsqyL+2
         zoWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5LMY7OkOOwrwelWF1cQQ+IHacz3M138uVwqLjqxydPW/fGqhSEggMu1yXSLBPUW7umRDC8Bjvw06widA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGye92ECBRSndbFVxZCacZ3FDhzXcxhazTaLcOCprosrI2HXx
	C20o/cnKRPB8JdyZmmdCMzJTQmwxPUNB8KOIZoZ8CcXMJ+pDm1kYtjPkqcTskcX1mMAWUamoJWF
	xP9FE4Edz2V4sfXdY86cc874tOP52KJaG0G32kqnLoQ/n10SHhZeYA4qT3n7LJVw=
X-Gm-Gg: ASbGnctnt7zA1e3y9uHtellxaF/5hBqf2lhsVIPqbQQsl+VxtZj0XvAz/ERO3x9gBNX
	wWmEBhrFAM/XgBlYLqTkMKsbPw++U5+fzeY6ZlIyfmiqcSTMkbjvHaov6FzIFpcK+S8ALZkKYjT
	iejfq8fli0mUAfWqgsb0wi+HW2IcK4Ze+6ANV1NpW65njUIdMqNmI/eWLCVy0Q1n4VZU7XSY6Ep
	mA4n5HhhjIX8GIyya9gaXBNU1KYnh4B97bFHgXT2v01MA8PeGGXGU7tRv5Tt2LVHolW9npYK6o5
	lVIRH81CV2mshdMT7c7lswR6jhg8cyGamReGTQGlNRl5F4M4vx+kWvOx+tNajTiMG37HYcVxptv
	gGRgr4UU1x2voThJSorWpJluRsaWGkQDmznc5
X-Received: by 2002:a17:902:e5c3:b0:224:f12:3734 with SMTP id d9443c01a7336-22c359194d0mr63687095ad.30.1744868971458;
        Wed, 16 Apr 2025 22:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgUIRYQK9CQySZDLp9fCj9zmVxHD4QcP7G3RLpCYsbt/OVETw+o1p5ug4k3wOR1o29Qii2YQ==
X-Received: by 2002:a17:902:e5c3:b0:224:f12:3734 with SMTP id d9443c01a7336-22c359194d0mr63686895ad.30.1744868971092;
        Wed, 16 Apr 2025 22:49:31 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc47e0sm24745715ad.167.2025.04.16.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:49:30 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 11:19:13 +0530
Subject: [PATCH ath-next v3 1/2] wifi: ath12k: handle scan link during vdev
 create
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-fix_scan_vdev_handling-v3-1-9ec42513d26b@oss.qualcomm.com>
References: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
In-Reply-To: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=6800966c cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=dhThNb0MqnHfOkfGsx8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GX9kjwkef-yAXn04IcJbfI9KrII77DxY
X-Proofpoint-ORIG-GUID: GX9kjwkef-yAXn04IcJbfI9KrII77DxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170043

For scanning purposes, the driver can use link ID 15 (scan link). A future
change will make non-ML interfaces to select the scan link. In this
scenario, arvif->link_id will be used to retrieve the link configuration in
ath12k_mac_vdev_create(). However, link ID 15 is not recognized as a valid
link ID in the upper kernel, which will result in a failure to fetch
link_conf and subsequently cause the scan to fail.

To avoid this issue, ensure link_conf is fetched only when the link ID is
within the valid range. Since link_conf cannot be retrieved using the scan
link, use vif->addr as the Ethernet address for creating the scan vdev.
This address will serve as the source address (address 2) in the probe
request frames during scanning. Additionally, use the automatic Tx power
value for the vdev. As this is a scan vdev, these values do not affect the
scan functionality.

Note that vif->addr will only be taken when a valid link_conf can not be
fetched. Otherwise, link_conf's address will be taken as address 2.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfc803879028deaa0bb02ced892238086b2687c9..d219c5b07a79c9829a1de12183e298d24eb5336a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8310,7 +8310,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param = {0};
-	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_bss_conf *link_conf = NULL;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
@@ -8325,22 +8325,21 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
 		return -EINVAL;
 
-	/* If no link is active and scan vdev is requested
-	 * use a default link conf for scan address purpose.
-	 */
-	if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
-		link_id = ffs(vif->valid_links) - 1;
-	else
-		link_id = arvif->link_id;
+	link_id = arvif->link_id;
 
-	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
-	if (!link_conf) {
-		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
-			    vif->addr, arvif->link_id);
-		return -ENOLINK;
+	if (link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
+		if (!link_conf) {
+			ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
+				    vif->addr, arvif->link_id);
+			return -ENOLINK;
+		}
 	}
 
-	memcpy(arvif->bssid, link_conf->addr, ETH_ALEN);
+	if (link_conf)
+		memcpy(arvif->bssid, link_conf->addr, ETH_ALEN);
+	else
+		memcpy(arvif->bssid, vif->addr, ETH_ALEN);
 
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
@@ -8495,7 +8494,11 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		break;
 	}
 
-	arvif->txpower = link_conf->txpower;
+	if (link_conf)
+		arvif->txpower = link_conf->txpower;
+	else
+		arvif->txpower = NL80211_TX_POWER_AUTOMATIC;
+
 	ret = ath12k_mac_txpower_recalc(ar);
 	if (ret)
 		goto err_peer_del;

-- 
2.34.1


