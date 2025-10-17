Return-Path: <linux-kernel+bounces-857230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D298BE643C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A231F622B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94E2AD11;
	Fri, 17 Oct 2025 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1ZXj4Gr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1330C37E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674096; cv=none; b=mzJIpB26yv8jp7fGsO62tZvOOpHEm/aUh+GvvQgakj7O0ntJWcZ4FnvzNxumf9hCyzimlOhsX9qv7NePoSMGQx3nZtFu+TgC/nbZ79pWW7cDHBtOpwvFFQsNfiO9zAuy4iWdsZo3hhndXNUxMzEPobYEclR2YBpc2+igO5ohEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674096; c=relaxed/simple;
	bh=3PCgNAWoDGSnLHmbTyI/u/LdOj2mopBhYs1h1lRSsw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3c5GVT545s7UXQHUgHG0WWLmru8+ki5Ldy2DXPk1tnc/oi02OI4fUFZud2QXb0mrhJKN8Q8eH4QmWFb8BF2pxJPTrETqI4M9c/XhMeBf6Ras0FzdpBL9eiB2qTX2fPmyHTRWN/lg2q9qIixJ6gry/RzfJFNg8EjViQkvHuJ/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1ZXj4Gr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLcqZ009689
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWolfLazVFYT84mp58WCfAKVs/5R8s1zPglUdTg+gis=; b=F1ZXj4GrM3fQPJjk
	7g331XXg15LcXc21lt/oKyWMFI3ecoFwHEWcIYJdR8Um0Mav7jhvX8Vox/PnqxxM
	ItfTIquI/zS464lt2wFloU3nAKdOTssQwIv2bP5PIgAV/E4P+gYZxP17yeo5f36x
	gHOhet6a4g//2be958W8eqqnGNl0cnm/XWRgObW3YbhMEph5xK7ubI0L3O+eJJ6K
	AXhaarQguSlLQT3ImgXPw0qhpDSyRkLZlYd/ILb9f3A9x2R0T3y909cGg0hM7meh
	uJ5AgzMLzXcX+R77X193YPDCAB6xe3KB1SkasGmP/1St6waPCWgC1xLJMKq6pmXR
	hUPxgA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0canw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27ee41e062cso21376905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674093; x=1761278893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWolfLazVFYT84mp58WCfAKVs/5R8s1zPglUdTg+gis=;
        b=pPj8lZOu3cCzoVMmgnjjSXiEchu3c0+WmJb59gtWV+UZ3s1eOqkHFEBjiwMok/tL+n
         9NrA3iIiKoywLuCfVwZNmKlJZzhvkOerAdKFmliAM9ZDxCLipf6O+2ejv1+CAiRlQubV
         aH3CL4g63SwE+UYPhbi3jZYxgqQF0N2NHTOvuWxUHD1EOjzoPOAwCepyWg/XSgMcUXBA
         dKw+lU6EtrMRhsvKuPPtst1z7o6NXvsUJd5CWfyuB1LW7rAtdMIYADJio9+rzjjinjkL
         YbPjivrwjW6M/gJkTVilo7r9ztkRfX6ZQKM+WJADc5wCjoNLIg3X1PTG9v6jCBGCr/zB
         RSjw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cT/Or1d6syf2YSu0id2wO5JjQlFhsfyCTfA28ldJ2jnHwRPoomWx6NOeMQaB7dHVbK6YomrdWKodpgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenskFdz1rTvnmTY2nQb3SMpkSksJWGiPrdzJ0j1H3wKY6xvl3
	y5BpXxP7kI6Nj/XpfZ2xwcCAgMFcItTg19qjxX7Yb+Wp/em0apT7/afQHo7THd/fZ3uORay1Mf8
	xoZx6i9vkSL9x+ODBRoe41N7GaiJ4ZsJOi5AaDFOqn8xKtrfNdjc9BxL+2v6Dv+FPE4M=
X-Gm-Gg: ASbGncu2TYBzIk+vwHKg13pf55zNewdLTn6EtdpltakWevZWxA/6UdaQk/p4bJTwieU
	CnNToUwJmE5Tz+cfFnsOxPZFvggiPFvKPAukIYvfLDjuLpprdcXNNTDzkW8D6wDgwRLoi0uPpBp
	oiIEJxLReZ0EMujFRgVeD0pyeFZ6Ov1fEYhruLF23gJNvr5CI9+x3b6go7SwO+5YYBGkY3UWuLw
	DG+M3LfG2Aqdw2EUwVFOXH1PkDB+z7pwigpJVAlzkkYBbTa0S9irvyM4qK2QvhBr7QFeGJd+qTG
	jqqb3ftuQ4Ho9J+fXNzQ7ZkucGJGuk5eaH2/1RWRYYlQ4uv9vMi3Pf1L493+iIbfRP9bQxIy1CP
	WJV+Yt1Lh6hw6OaiSQyQBg38aBigjZgAOVZVpb3ggDM4CZLWRcToiOt35AgTSu2hkYLbRqMwJoW
	4pZX8dWmjhOsJMviRcG0IZ/f4=
X-Received: by 2002:a17:902:ec87:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-290cba481bemr29330355ad.56.1760674092883;
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQc/rF6+4aCLOlalhTrIqG/9+ZR208dHO2zKfTlxMoTdojrxoUaPi3LlK1PsMdL9w63V5vA==
X-Received: by 2002:a17:902:ec87:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-290cba481bemr29330005ad.56.1760674092376;
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:37:58 +0530
Subject: [PATCH ath-next 2/4] wifi: ath11k: wrap
 ath11k_mac_op_get_txpower() with lock-aware internal helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-2-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: YhzXBADkdv9mCbarC-g9Oo8xxKeM2rOA
X-Proofpoint-ORIG-GUID: YhzXBADkdv9mCbarC-g9Oo8xxKeM2rOA
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f1c12e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=HHL2EbrfMguBWQQB2GUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX5wn9+bqHve98
 oXcA/5evydQcFwqB+hGhuBIKfSPfjapiBzWZwWUthu6P0oID157MHeLUe6cUYA0GgHVfwzy272k
 bj/AS21WO8TfBdn2rFNy02Dmeaa0hOj5biWwptsLxoeV/KUrOKmh3D6J6PxddoQE7cwXdW1yuaw
 ru+o8e9CLr0livnVsHQPBoAMRj2GMkZphOaq9/RfiXp+e9SVg1xMkidCsa8Sh9S9od7Vb8RDli1
 vdFfCW4kP2ljWHfm87hh56CCGkNnho2bUdikczfyRtBr0Bf4XfzlRO0jsNX5zorHzfy826gGeOS
 gioQpSEV5emVC+bH3m735ldkNsMwPli1FAm1/mPZ+Dyb8vHBxWqYsFQQwyUPE86v3QFM2676ZeD
 fd032NNYXVeDb8+HBgYfV3i4sB7NBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Refactor ath11k_mac_op_get_txpower() by introducing a new internal function
ath11k_mac_handle_get_txpower(), which assumes the caller holds the
appropriate lock. This prepares the codebase for future change where the
internal function may be invoked directly with the lock already acquired,
improving modularity and lock handling consistency.

No functional change intended.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a7bd0ddf5fdf..cd6e98ee1232 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4103,12 +4103,10 @@ static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
 	return ret;
 }
 
-static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
-				     int *dbm)
+static int ath11k_mac_handle_get_txpower(struct ath11k *ar,
+					 struct ieee80211_vif *vif,
+					 int *dbm)
 {
-	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_fw_stats_pdev *pdev;
 	int ret;
@@ -4119,15 +4117,13 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	 * of these. Hence, we request the FW pdev stats in which FW reports
 	 * the minimum of all vdev's channel Tx power.
 	 */
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
 	 * the stats.
 	 */
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-		mutex_unlock(&ar->conf_mutex);
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags))
 		return -EAGAIN;
-	}
 
 	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
 				      WMI_REQUEST_PDEV_STAT);
@@ -4148,14 +4144,12 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	*dbm = pdev->chan_tx_power / 2;
 
 	spin_unlock_bh(&ar->data_lock);
-	mutex_unlock(&ar->conf_mutex);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
 		   pdev->chan_tx_power, *dbm);
 	return 0;
 
 err_fallback:
-	mutex_unlock(&ar->conf_mutex);
 	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
 	*dbm = vif->bss_conf.txpower;
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
@@ -4163,6 +4157,21 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
+				     int *dbm)
+{
+	struct ath11k *ar = hw->priv;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath11k_mac_handle_get_txpower(ar, vif, dbm);
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)

-- 
2.34.1


