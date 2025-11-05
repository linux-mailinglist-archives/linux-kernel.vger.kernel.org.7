Return-Path: <linux-kernel+bounces-887031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B9C370CC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3126188AC62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A633C535;
	Wed,  5 Nov 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFRkpsTH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNuC2B7y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154C338F26
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363357; cv=none; b=RbFKpGXkJHpDXXEttsdm1tdfyCaTOxNeVK1fsGYBIgPw72Xl+nsXtvmmHp8MY7XKiP2hroLk/gEyBbIuHx+WEfGRDKkMMJB08Fuh3FndV43uNo7nPLNHYBCJbr8s6csX+qcD8BdibuME7bIANPZiNK4ef6xGi1jafGVWpOu4CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363357; c=relaxed/simple;
	bh=4RVJZpkDmGjO+msxIE19nXLYcV6yuaVmFY24Hl9aYxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYT2yOfY0k0uQCWDAz4QIXu9xiaCSQQ0eOW1IezxNZg6oYtxEITihcRqbPj1B1KZU3qee1+R8Fh7KYIB7jwEAdLzm5v8pTTvrmPOBEKvJgK5sGXivH/BkqNrTPV/0MUEbXV4Nw07xpAUM3A7OwiOrchpt7DTrUvjIDCmyyemP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFRkpsTH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNuC2B7y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5E8CQr876658
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+34BFVYwe9cWjXpD4W2ZZm1y1yXgMO3SO03SfHDt+M=; b=TFRkpsTHodp6hGM6
	WsPaPmLOGVIftKTTERtg5MXAPlHCI7Nt67VgRHsLNnWfy7iaegeEIEa6SqfSv9Z8
	I6ga3r6bazQpuJwlWlYdiAy4VoeaRSH4cuXSe1ACXWq2Mk/IVsbGHuEEYkkj9RSQ
	DnNtkReOxDKwR3TVZbrd7C0EV5ua5vBfrNmNM1iX2U21BFwhV9VheJORjUTpU6aK
	4DzDWBfsNnK7E3MD8drjhypKWlBejd45HFhdXSafPD11caznbOPsRzrTjOF0QOxM
	JV0zQ1s83YGgqBjZY2PHHcSWbx3qC59PXu9NaB7YJUlA1bUkBN6iFuz2hLGNc/d9
	awGf8Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88318mps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:22:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a43210187cso89912b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762363353; x=1762968153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+34BFVYwe9cWjXpD4W2ZZm1y1yXgMO3SO03SfHDt+M=;
        b=WNuC2B7y4ZD1/vzgkskKDGc4qvVl72aB00/981S5E7YSftQUd2JEj/k5GwdC7z7ueG
         2Iw5BUTc4x+rXMH2EuXhZR2GY3xMfz1CGZ6XLcXmYADTrGu6UX6hkIO2tMDSEc5jVvpT
         WsmlDRv1LsL/nzg+YLnyzFLq9fQpYxbKJEbITGiFU6IRPIG49uatlh2+AkNBtvuQ2+Xu
         k/yi835mxsWyHk9rRTLBN/SoYOxOrTT0r3Te4g7lnHE6GJ4tiw27y/qN380sf+TGjiLn
         FGLxge+/xzKfm57MkUqAhd67MZRFWGsmkXbQbvYnhDmtOT3OrVbEdDRMQUEgL63Kcdme
         w88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363353; x=1762968153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+34BFVYwe9cWjXpD4W2ZZm1y1yXgMO3SO03SfHDt+M=;
        b=wHeDUIfvFdxw8Ux5dwZR+6mjX61it+pWkTss3XhEXkyXrAicQk85B1B20Emsfu6J5c
         +5UC+/xoVsLlKdI039GH/21v8DOjwCn8mg8bOmC4yOFTqWGnVWqpxZ26RR6dVZ7eRiAO
         o+U9vkHQo5L2LxtM/9vrWvJNIAgBPaLD0WowmfN2s13rWLFaDJanbu2SfIcvm7tI5VOs
         tHJAKnY09+tv7LSn2dOzUWB1hCCjvRSL5uJYEbqV/3TYAL9V3D3rOE4FgXLQocjj3kXu
         zVU+hJu01mQWRrUuHdsoA6THvEL8/MuVtRjK0WOUoHblnr6cCCtE5N6NPjXQD+l7iNhc
         6WvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU/odtquLM6DREkNZPls/wjjGpPPgc+u0amBpVgelcoIAZMzxZHOUJqjnf8oF0Co3oMy9OIB2wE29A1Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdD2gMXSViNWl4kwRJqk/D0Cgop6/MOopXZFPFMdTaBdYJysu5
	VQRwQxMej14qdd2OSdYMdhH+Rw8kJ15/4fjW1+I7eAx5jvbCwujx/76pBfRmJvfLZX9d3VtHor3
	AuPt2FGd2RWH2T1MeMa0tAU+tipYMy36du03zewrVdqwUHcytFBvYrSuREaiLw6KWFhs=
X-Gm-Gg: ASbGncvDlwO+zjc3MICx4n4QBu9+gkToY8sEdjaUjsdH4QqtVYftzGLeZiuexg2CZE7
	K87AvdUdMyDTB7ZKmZHoQzS95Q9QNoZEmXzJ2Y+Bix2Ebq4LZzpGiyqCN1LJ2PIlss7b3BOU/5U
	gK9a8pG3R6DtqkQo6a3CQun3kX+rX+Z6ck9GGItXE2ixFBQgvgdBoyI+zjSfRm+s7ZJgJOoHxXR
	taJ3VQHgahmoJPjTYOsopQq/Iggr6MfrOb9gec4qAE8zJHjvWiAxwEvUp7rYGMPuSj3ofBDcuQG
	baxrgsmdAskoz6u1A4I+Z5Zbodkl3F1SJ+yG6AHvnR/gj7HPc4nSi8tNjgEiSAeHVXkRtO2UmVb
	PQmiUivO8OyGj7q0ILBz22hvXaxD3oaD+vJvW7G56PkKY
X-Received: by 2002:a05:6a00:b43:b0:7a9:c21a:5599 with SMTP id d2e1a72fcca58-7ae1cc60453mr4473807b3a.4.1762363353144;
        Wed, 05 Nov 2025 09:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXsnqq8V0HlcCFpvBUNFm3lbgoprJDL3freZkPBlpJH94la+YsFi/UYiNee4CxhF+1f+ypHA==
X-Received: by 2002:a05:6a00:b43:b0:7a9:c21a:5599 with SMTP id d2e1a72fcca58-7ae1cc60453mr4473764b3a.4.1762363352544;
        Wed, 05 Nov 2025 09:22:32 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af48d83c20sm518014b3a.62.2025.11.05.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:22:31 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v3 3/6] wifi: ath11k: Add support unassociated client CFR
Date: Wed,  5 Nov 2025 09:22:23 -0800
Message-Id: <20251105172226.3182968-4-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
References: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KDP_edu4sKYat_3E5PnFa5YOozo6fM70
X-Proofpoint-GUID: KDP_edu4sKYat_3E5PnFa5YOozo6fM70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNSBTYWx0ZWRfX2XYMP2cgG1tc
 yYmCyt5oZZM78VLaUM13Ly2Dtce+T2ZqhXDtnSqnQ+RbXLWBPtM/4vHI+oaeqHdqOQ4PgY8a5KR
 dW6YPmJ0ZDxpYyTzWU9+OatBcUOJfA8t7ymTTpLS70EiT6VwC3zBIxzTG1l1oWfjjgRQmEL9q8p
 dsOw6nAQjJ4irg2JFUrlRKnxvvwWDJF3VXPMdTnxgW64ZMgGaUUytys3t4EfM+fxQ1Q82AwOf8X
 TrU1Ox/JVtcJDHTT7n+Jt8amA45mpAv/ZQNbMWml4/ccTP85hSTsg9Rj4UkLT9SkgUPd7mFeGSe
 SfRtC/AhgfveDvmARgnwUNujCDxHUDlT4M0vWcY7xyvL/jxDqifQHFYnwGYxJK9Yvp3I6uoIMqU
 LBqBKXVIN5J102uoLzqj3RXAOjhZUw==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690b87da cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=J6nKnfFvHuu1lZMax6MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050135

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Provide debugfs interfaces support to config unassociated client CFR
from the user space.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expected to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value must be multiple of 10 ms)

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 228 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  33 ++++
 drivers/net/wireless/ath/ath11k/mac.c |  15 +-
 drivers/net/wireless/ath/ath11k/wmi.c |  16 +-
 drivers/net/wireless/ath/ath11k/wmi.h |   2 +-
 5 files changed, 290 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index bf0b880e8746..e22b0151833c 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -14,6 +14,60 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return 0;
 }
 
+/* Helper function to check whether the given peer mac address
+ * is in unassociated peer pool or not.
+ */
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	if (!ar->cfr_enabled)
+		return false;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			spin_unlock_bh(&cfr->lock);
+			return true;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+
+	return false;
+}
+
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac) &&
+		    entry->period == 0) {
+			memset(entry->peer_mac, 0, ETH_ALEN);
+			entry->is_valid = false;
+			cfr->cfr_enabled_peer_cnt--;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+}
+
 void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 				     struct ath11k_sta *arsta)
 {
@@ -130,6 +184,59 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 	return ret;
 }
 
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int available_idx = -1;
+	int i;
+
+	guard(spinlock_bh)(&cfr->lock);
+
+	if (!params->cfr_enable) {
+		for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+			entry = &cfr->unassoc_pool[i];
+			if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+				memset(entry->peer_mac, 0, ETH_ALEN);
+				entry->is_valid = false;
+				cfr->cfr_enabled_peer_cnt--;
+				break;
+			}
+		}
+		return;
+	}
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS) {
+		ath11k_info(ar->ab, "Max cfr peer threshold reached\n");
+		return;
+	}
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			ath11k_info(ar->ab,
+				    "peer entry already present updating params\n");
+			entry->period = params->cfr_period;
+			available_idx = -1;
+			break;
+		}
+
+		if (available_idx < 0 && !entry->is_valid)
+			available_idx = i;
+	}
+
+	if (available_idx >= 0) {
+		entry = &cfr->unassoc_pool[available_idx];
+		ether_addr_copy(entry->peer_mac, peer_mac);
+		entry->period = params->cfr_period;
+		entry->is_valid = true;
+		cfr->cfr_enabled_peer_cnt++;
+	}
+}
+
 static ssize_t ath11k_read_file_enable_cfr(struct file *file,
 					   char __user *user_buf,
 					   size_t count, loff_t *ppos)
@@ -188,10 +295,127 @@ static const struct file_operations fops_enable_cfr = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_write_file_cfr_unassoc(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	char buf[64] = {};
+	u8 peer_mac[6];
+	u32 cfr_capture_enable;
+	u32 cfr_capture_period;
+	int available_idx = -1;
+	int ret, i;
+
+	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+
+	guard(mutex)(&ar->conf_mutex);
+	guard(spinlock_bh)(&cfr->lock);
+
+	if (ar->state != ATH11K_STATE_ON)
+		return -ENETDOWN;
+
+	if (!ar->cfr_enabled) {
+		ath11k_err(ar->ab, "CFR is not enabled on this pdev %d\n",
+			   ar->pdev_idx);
+		return -EINVAL;
+	}
+
+	ret = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %u %u",
+		     &peer_mac[0], &peer_mac[1], &peer_mac[2], &peer_mac[3],
+		     &peer_mac[4], &peer_mac[5], &cfr_capture_enable,
+		     &cfr_capture_period);
+
+	if (ret < 1)
+		return -EINVAL;
+
+	if (cfr_capture_enable && ret != 8)
+		return -EINVAL;
+
+	if (!cfr_capture_enable) {
+		for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+			entry = &cfr->unassoc_pool[i];
+			if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+				memset(entry->peer_mac, 0, ETH_ALEN);
+				entry->is_valid = false;
+				cfr->cfr_enabled_peer_cnt--;
+			}
+		}
+
+		return count;
+	}
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS) {
+		ath11k_info(ar->ab, "Max cfr peer threshold reached\n");
+		return count;
+	}
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+
+		if (available_idx < 0 && !entry->is_valid)
+			available_idx = i;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			ath11k_info(ar->ab,
+				    "peer entry already present updating params\n");
+			entry->period = cfr_capture_period;
+			return count;
+		}
+	}
+
+	if (available_idx >= 0) {
+		entry = &cfr->unassoc_pool[available_idx];
+		ether_addr_copy(entry->peer_mac, peer_mac);
+		entry->period = cfr_capture_period;
+		entry->is_valid = true;
+		cfr->cfr_enabled_peer_cnt++;
+	}
+
+	return count;
+}
+
+static ssize_t ath11k_read_file_cfr_unassoc(struct file *file,
+					    char __user *ubuf,
+					    size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	char buf[512] = {};
+	int len = 0, i;
+
+	spin_lock_bh(&cfr->lock);
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (entry->is_valid)
+			len += scnprintf(buf + len, sizeof(buf) - len,
+					 "peer: %pM period: %u\n",
+					 entry->peer_mac, entry->period);
+	}
+
+	spin_unlock_bh(&cfr->lock);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_configure_cfr_unassoc = {
+	.write = ath11k_write_file_cfr_unassoc,
+	.read = ath11k_read_file_cfr_unassoc,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static void ath11k_cfr_debug_unregister(struct ath11k *ar)
 {
 	debugfs_remove(ar->cfr.enable_cfr);
 	ar->cfr.enable_cfr = NULL;
+	debugfs_remove(ar->cfr.cfr_unassoc);
+	ar->cfr.cfr_unassoc = NULL;
 }
 
 static void ath11k_cfr_debug_register(struct ath11k *ar)
@@ -199,6 +423,10 @@ static void ath11k_cfr_debug_register(struct ath11k *ar)
 	ar->cfr.enable_cfr = debugfs_create_file("enable_cfr", 0600,
 						 ar->debug.debugfs_pdev, ar,
 						 &fops_enable_cfr);
+
+	ar->cfr.cfr_unassoc = debugfs_create_file("cfr_unassoc", 0600,
+						  ar->debug.debugfs_pdev, ar,
+						  &fops_configure_cfr_unassoc);
 }
 
 void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index 7d161f7f7be8..e7b69e98cbf5 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -45,6 +45,12 @@ struct ath11k_look_up_table {
 	struct ath11k_dbring_element *buff;
 };
 
+struct cfr_unassoc_pool_entry {
+	u8 peer_mac[ETH_ALEN];
+	u32 period;
+	bool is_valid;
+};
+
 struct ath11k_cfr {
 	struct ath11k_dbring rx_ring;
 	/* Protects cfr data */
@@ -53,6 +59,7 @@ struct ath11k_cfr {
 	spinlock_t lut_lock;
 	struct ath11k_look_up_table *lut;
 	struct dentry *enable_cfr;
+	struct dentry *cfr_unassoc;
 	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u64 tx_evt_cnt;
@@ -66,6 +73,7 @@ struct ath11k_cfr {
 	u64 clear_txrx_event;
 	u64 cfr_dma_aborts;
 	bool enabled;
+	struct cfr_unassoc_pool_entry unassoc_pool[ATH11K_MAX_CFR_ENABLED_CLIENTS];
 };
 
 enum ath11k_cfr_capture_method {
@@ -89,6 +97,13 @@ void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
 				 u32 buf_id);
 void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 				     struct ath11k_sta *arsta);
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac);
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar,
+					    const u8 *peer_mac);
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac);
 int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 struct ath11k_sta *arsta,
 					 struct ath11k_per_peer_cfr_capture *params,
@@ -114,6 +129,24 @@ static inline void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 {
 }
 
+static inline void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+							const u8 *peer_mac)
+{
+}
+
+static inline bool
+ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	return false;
+}
+
+static inline void
+ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+			       struct ath11k_per_peer_cfr_capture *params,
+			       u8 *peer_mac)
+{
+}
+
 static inline int
 ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 				     struct ath11k_sta *arsta,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 965c377cd8dc..2fbd64d78338 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6186,6 +6186,8 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
+	bool tx_params_valid = false;
+	bool peer_in_unassoc_pool;
 
 	ATH11K_SKB_CB(skb)->ar = ar;
 
@@ -6224,7 +6226,18 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	ATH11K_SKB_CB(skb)->paddr = paddr;
 
-	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
+	peer_in_unassoc_pool = ath11k_cfr_peer_is_in_cfr_unassoc_pool(ar, hdr->addr1);
+
+	if (ar->cfr_enabled &&
+	    ieee80211_is_probe_resp(hdr->frame_control) &&
+	    peer_in_unassoc_pool)
+		tx_params_valid = true;
+
+	if (peer_in_unassoc_pool)
+		ath11k_cfr_update_unassoc_pool_entry(ar, hdr->addr1);
+
+	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb,
+				   tx_params_valid);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to send mgmt frame: %d\n", ret);
 		goto err_unmap_buf;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 846c9946a084..0b4cc943c290 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -651,11 +651,12 @@ static u32 ath11k_wmi_mgmt_get_freq(struct ath11k *ar,
 }
 
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame)
+			 struct sk_buff *frame, bool tx_params_valid)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(frame);
 	struct wmi_mgmt_send_cmd *cmd;
+	struct wmi_mgmt_send_params *params;
 	struct wmi_tlv *frame_tlv;
 	struct sk_buff *skb;
 	u32 buf_len;
@@ -665,6 +666,8 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 		  frame->len : WMI_MGMT_SEND_DOWNLD_LEN;
 
 	len = sizeof(*cmd) + sizeof(*frame_tlv) + roundup(buf_len, 4);
+	if (tx_params_valid)
+		len += sizeof(*params);
 
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -680,7 +683,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 	cmd->paddr_hi = upper_32_bits(ATH11K_SKB_CB(frame)->paddr);
 	cmd->frame_len = frame->len;
 	cmd->buf_len = buf_len;
-	cmd->tx_params_valid = 0;
+	cmd->tx_params_valid = !!tx_params_valid;
 
 	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
 	frame_tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
@@ -690,6 +693,15 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 
 	ath11k_ce_byte_swap(frame_tlv->value, buf_len);
 
+	if (tx_params_valid) {
+		params =
+		(struct wmi_mgmt_send_params *)(skb->data + (len - sizeof(*params)));
+		params->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TX_SEND_PARAMS) |
+				     FIELD_PREP(WMI_TLV_LEN,
+						sizeof(*params) - TLV_HDR_SIZE);
+		params->tx_params_dword1 |= WMI_TX_PARAMS_DWORD1_CFR_CAPTURE;
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_MGMT_TX_SEND_CMDID);
 	if (ret) {
 		ath11k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 1562d169ba9a..afc78fa4389b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6391,7 +6391,7 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame);
+			 struct sk_buff *frame, bool tx_params_valid);
 int ath11k_wmi_p2p_go_bcn_ie(struct ath11k *ar, u32 vdev_id,
 			     const u8 *p2p_ie);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
-- 
2.34.1


