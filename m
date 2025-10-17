Return-Path: <linux-kernel+bounces-857229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C1BE642A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3DB1A64C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7630C615;
	Fri, 17 Oct 2025 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIrBQLWh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D471FE44B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674094; cv=none; b=oUoeVs/wZCx8D5qZPGL36HU0UEvvz/x9VzzCWdrLL0G8JgYddJJ3ZDpHNQ/5dG2vdfrR8x5CHi8OvNcdzaZVItLwwzS5+fCeCsjvff2F7OyJLkZkxCHE0iGwws1efUaPmpwtX9qo510386rlXYebjjfluwel+xGVijp84HJlq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674094; c=relaxed/simple;
	bh=lEsJnpzptU7Y1tjhh6qn3WuDbr4ZKrkKsd11LQZXKIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guiV3ZQR0hI/dLitBTslevRB/dUPHMo7vbb6DUVvUpnPA+Ep66eM9q0ZVxioaLEBAfJviS5XyRi1RCW8XdliihKKpk1GhvFFbU9mbGR49PHWiFCxsABN+c2jjqzWGxo8iPlILj/xyjhlwStCVqF28LN7IvtMjAlBwwNzqhnm6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hIrBQLWh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLN3d006539
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EF1qbmeFyQyWyqzjkXpojfq3u9UdcWSnsZnd7x6nRMQ=; b=hIrBQLWhlXI2+hFb
	Yfr++9gdu9hA3LLr9JBgB+obUI7iEK3+B5mIZCOSghrAq7Spm8MJmHVvunnygSAl
	dwjnrCkb7AVmD0gIqpJy6CDhQ8G1Oy2ujNmSGG+Rl5DfNMga2W3Cmo6mvCdYAssi
	Svsw6ltLLMUA7Tn5uElpaujOcIvlQcBBirB4GnJrZjsJ5+BeDWAF4rm8tDuCqBp6
	TuSFooFc1+xdjKBxQplTnDyeYLRJj2kAHUNkr7WxINB0f52E/YOmQSr43qN2yfs9
	ARL7h848ptaZsZ+I7AmnIUa42yEFYUcqoUT3Es/kox75juEC1ZKBHEC+KHCYlj5I
	tO3gUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff12rgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697410e7f9so39002645ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674091; x=1761278891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF1qbmeFyQyWyqzjkXpojfq3u9UdcWSnsZnd7x6nRMQ=;
        b=BPFoW2f2r+/SeEULwciSJ9rL9MnrVG1z6effoTCcYGXoAAeo25yTZrlchz9LgshmbB
         ENV6xfBJH+hcluLMYyDTdw86yFf4YAXkzh8ix1wZBlnT21KZ8hl4Dq8qC1kURxZku8Sd
         QTbA/f39wACHoKHKo8UOU/yd1dOcvToCJ+kmZGn2t3aVQRTGhMJcUTejniC1hcF4vJsJ
         GE71hwmSIqRxgwjFz3PE169sQMeOqc0asjaHC9FUaep0T6mwVxRMLuBNMx5U9ZTlm0Em
         4vekzaKOaSM7jPj4fW921vI4g4tNRvlnaBZG8bu/3GPBgiAG5K3drBp3givq1kLchwrx
         UI1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqPYy/A6fCunIAJ47YY6UlWfCijy/xwaQhwZkuXzl2po67hEvk5tQGn4zG4i6wtkeGaFyrtgISUoKX+MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZqUBRoDzgIYpmPnCqH9kiZUhQN2wj1l3SvlcvkmaCqJ1hgSC
	4Fnv1KyFzY1gSwBlhHS/F7pHUT36eINazCuRpksnZhUY8Et5MKhdxXDAvP6clQFvT0U6GEJf1Cx
	KiVDI3va3iPSdMDMBdkNz+F78mY1jyJaXoRiMmgq2ecP09KZ9ume+wVDkjEzTmnFFECo=
X-Gm-Gg: ASbGnct8bcwqBvxiSXslT8EUhM3g/l6o8eYJc5w4Zxhvs6SCRad1gM5WkkKj98rc76h
	uKxACPSPuwQ7hbs9zFiKUyJrhl2ejq5sim+lxsZEkfhuOU5SliCruesF04LAj67XMYK5GqJX7oz
	7+SPPNApLnPWld2uxH2h6hsyOikG7ios3rrVln5z1RW4Fm4myGazeA5M3qG/vYf0kV2CpKRTp4o
	Li0duRyUdj0N51jP0Y+JVHAlsnP4ZQlp29YKf3LFZQnrbcI3CCMI4QFvqY1ngJtH4GDyHZpT1pU
	mYX39eLVSs+lKG3yy1frmeXnGxo/TQNHXP+0qFqeAjmt7hmfoz0FiKkggsF1AGnTSZrqdHElL3H
	tXaEt7uPhoOAS+jU1sp6ugo/ViVWEsMR8NV8m0Tae794XWfWZS1Kc1uUcxRLTrncuG1bUV745zw
	9nie+VbxbiLyBxa8aTOQ9KxBY=
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-290cb65f861mr28662215ad.57.1760674090709;
        Thu, 16 Oct 2025 21:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYZ//wDhpZNdjOOqwxCLJUlSkjpBoq4u/LLVBhCq3t3hCocjGsXJZenz8XfT/xsP0zsVXQ/Q==
X-Received: by 2002:a17:903:46c7:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-290cb65f861mr28661925ad.57.1760674090279;
        Thu, 16 Oct 2025 21:08:10 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:09 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:37:57 +0530
Subject: [PATCH ath-next 1/4] wifi: ath11k: relocate some Tx power related
 functions in mac.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-1-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxYnrjrmQ0+e9
 2wf7ytmKhecZ1xBgWvDw1YCETErlDKfm3JcXYUqXWdHe7fq9J25zZkt5BNqAe+YTFBxvzv0N2eI
 6+Nj2C0XTTobTEhK3iwXF6vK73ZW3gqHxooiJZbUfij25QRq6Pl8yeRZ98UfeYheqmdwRor/OFb
 MdAXqbvbsb6vnQLylwaHrPvdr3FZhfdim2hTK/Blr+gnuNPX5VUxVjdRJhPUoAOd5lS7EMS2t5v
 pWyU+ux3wO7zOliTquNeDOkdRm/Nia/ENK5+erjzXa07FZ27p2yeoT/aRgilOBm427Ak5O+t8k4
 tINT/duIV/4lR0d4dXMtG2w9rj6kd+QSWrXnVslMw==
X-Proofpoint-GUID: VXmf2hsjbQClyRQVFRoBcIDIUtDXtag_
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f1c12b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xoC9ZPpSTKSxfhOel_IA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: VXmf2hsjbQClyRQVFRoBcIDIUtDXtag_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

A forthcoming change necessitates that these functions be defined prior to
their usage. Therefore, relocate them now as a preparatory step for the
upcoming modifications.

Compile tested only.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 270 +++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0e41b5a91d66..a7bd0ddf5fdf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4028,6 +4028,141 @@ static int ath11k_start_scan(struct ath11k *ar,
 	return 0;
 }
 
+static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+int ath11k_mac_fw_stats_request(struct ath11k *ar,
+				struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ath11k_mac_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				   u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON)
+		return -ENETDOWN;
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_mac_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+	return ret;
+}
+
+static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
+				     int *dbm)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_fw_stats_pdev *pdev;
+	int ret;
+
+	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
+	 * Power, PSD EIRP Power. We just know the Regulatory power from the
+	 * regulatory rules obtained. FW knows all these power and sets the min
+	 * of these. Hence, we request the FW pdev stats in which FW reports
+	 * the minimum of all vdev's channel Tx power.
+	 */
+	mutex_lock(&ar->conf_mutex);
+
+	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
+	 * the stats.
+	 */
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
+		mutex_unlock(&ar->conf_mutex);
+		return -EAGAIN;
+	}
+
+	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_PDEV_STAT);
+	if (ret) {
+		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		goto err_fallback;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
+					struct ath11k_fw_stats_pdev, list);
+	if (!pdev) {
+		spin_unlock_bh(&ar->data_lock);
+		goto err_fallback;
+	}
+
+	/* tx power is set as 2 units per dBm in FW. */
+	*dbm = pdev->chan_tx_power / 2;
+
+	spin_unlock_bh(&ar->data_lock);
+	mutex_unlock(&ar->conf_mutex);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
+		   pdev->chan_tx_power, *dbm);
+	return 0;
+
+err_fallback:
+	mutex_unlock(&ar->conf_mutex);
+	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
+	*dbm = vif->bss_conf.txpower;
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
+		   *dbm);
+	return 0;
+}
+
 static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
@@ -9079,81 +9214,6 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 	}
 }
 
-static void ath11k_mac_fw_stats_reset(struct ath11k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
-	spin_unlock_bh(&ar->data_lock);
-}
-
-int ath11k_mac_fw_stats_request(struct ath11k *ar,
-				struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	ath11k_mac_fw_stats_reset(ar);
-
-	reinit_completion(&ar->fw_stats_complete);
-	reinit_completion(&ar->fw_stats_done);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
-static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
-				   u32 vdev_id, u32 stats_id)
-{
-	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON)
-		return -ENETDOWN;
-
-	req_param.pdev_id = pdev_id;
-	req_param.vdev_id = vdev_id;
-	req_param.stats_id = stats_id;
-
-	ret = ath11k_mac_fw_stats_request(ar, &req_param);
-	if (ret)
-		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
-		   pdev_id, vdev_id, stats_id);
-
-	return ret;
-}
-
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -9539,66 +9599,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
-				     int *dbm)
-{
-	struct ath11k *ar = hw->priv;
-	struct ath11k_base *ab = ar->ab;
-	struct ath11k_fw_stats_pdev *pdev;
-	int ret;
-
-	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
-	 * Power, PSD EIRP Power. We just know the Regulatory power from the
-	 * regulatory rules obtained. FW knows all these power and sets the min
-	 * of these. Hence, we request the FW pdev stats in which FW reports
-	 * the minimum of all vdev's channel Tx power.
-	 */
-	mutex_lock(&ar->conf_mutex);
-
-	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
-	 * the stats.
-	 */
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-		mutex_unlock(&ar->conf_mutex);
-		return -EAGAIN;
-	}
-
-	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
-				      WMI_REQUEST_PDEV_STAT);
-	if (ret) {
-		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
-		goto err_fallback;
-	}
-
-	spin_lock_bh(&ar->data_lock);
-	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
-					struct ath11k_fw_stats_pdev, list);
-	if (!pdev) {
-		spin_unlock_bh(&ar->data_lock);
-		goto err_fallback;
-	}
-
-	/* tx power is set as 2 units per dBm in FW. */
-	*dbm = pdev->chan_tx_power / 2;
-
-	spin_unlock_bh(&ar->data_lock);
-	mutex_unlock(&ar->conf_mutex);
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
-		   pdev->chan_tx_power, *dbm);
-	return 0;
-
-err_fallback:
-	mutex_unlock(&ar->conf_mutex);
-	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
-	*dbm = vif->bss_conf.txpower;
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
-		   *dbm);
-	return 0;
-}
-
 static int ath11k_mac_station_add(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)

-- 
2.34.1


