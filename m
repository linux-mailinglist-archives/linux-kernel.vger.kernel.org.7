Return-Path: <linux-kernel+bounces-738592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84598B0BAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B189C7A10AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88984223719;
	Mon, 21 Jul 2025 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8rmCEky"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCE1DF977
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064875; cv=none; b=qy+rx6Kiv3BuCQKOuTiuGDEHg//ir0Xcqd1E+0PqWehI6vlD+ETzfZVxm6SuR8JUtbXRkraMaBKxSTmtWMk7SuJNg5xDzXqIofjQ3vFfERScIDb3Ed6k9oMh6WRf/3nkFbU6uW/O1D36v9DAsaHFckjqMEkvqt22HEZCdWUifgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064875; c=relaxed/simple;
	bh=IXPGnQ9UfJ4suK+gSl3AFZDmkHK2DtvB44NifkKZUns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RgdO0kNdSxhx3v9Wz/v39f+xqquVA5W9h/+3yCnMgZAhGMPYDc4ZHZglcj2NsafSItiZgVlbBEIWMPjTi6s70sKLDXCwmXJjrRnKwrhUc7mG2fLOQCxReAuNZO6TrQS+KmmGzC22cBkq9CuFWVmqqBTArTyXQE7c9+wOh/to+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8rmCEky; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNo2RB022263
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PlESFODkg2/n6CKXRrQsrv
	crzkq/qeENX4SwJDn1k5I=; b=l8rmCEky0qziIw6wiRSH/cB8ooDGWljJGzSlJR
	codoLzGXOc3wsk/e2fr7KlFpdW9LZxiQthLCw2BNc47KsOdm9WufbZGT7vxzQzST
	tVQR4WC5pmEY9Sc6LcqQ4EORIqap5ve9m5Fs0U0j5uTdbQWV8lw8mAcmWFBv0be0
	vawCT/mgQbSYYTWzyCyJ+2TFvYHzkH0/+McRS6Zg7w5Aznrpin0ZPA2f0lwiJA0c
	aJh3S4mNnEeJw0ft6jU0yqv3P3CrN+96rYIInhiB1grhSH6JlKOON++2vWv7K9Fa
	VBJV+zgcw4Ju9JSGVLzB02AH7NYq503h5ZyYlvl+HnhDYv/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vu36x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:27:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369dd58602so30022095ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753064872; x=1753669672;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlESFODkg2/n6CKXRrQsrvcrzkq/qeENX4SwJDn1k5I=;
        b=Q+muo91BP4cC1LG3zJBDBz+Zt0urkwEAr9HcxwimxciOl4vbiiVYJ5DeJk4tW9c0fr
         my+uRm2Voi5UjmifgD8M+U9ruYakcEQsjsjNRlZ0JHGxRue1eOrEhFjjKGDIjp+zu+D7
         EeAx3VPwFJtr1kWR7hReJMBBE8jaMiS41Ghn3WaOlM5g+eaVMxbx6SxPngdBQeNookMh
         lq3XEYGOqMw3hzYilcHFDzICGpuIB9tL5JMyV6ZjB1YY4IhSyFMKg+CMJ480hxf340t+
         8g8KvsZT9NiLCcw5mfFzw8Zd6nN+eXu0BYZLhOdJYvljcWPUDFM9uuhKEEprhOnmEilP
         HLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpanWrYDn2J/iAujcZuRD19twGbpMadoxdIsePth4DTTEHvE58CNnifZ5V/ksj512HmZcbpu4s+0I4gGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOffeRUSZha3GAtaxC82v2y9CCCab0GuSEdAtCm5L5Rszhnvft
	A0NkdkLlKTtF94cq7sCyczQxVCrronE3ypn7O7eOXu9bRFFefQ3b14RpDaxyry5uudVWkK+NL96
	XuQk9d/aoIhVqTfy9Vmoq9onzQK9kqdm9AHOSrWbvxolmLtd85SPBfjH2etaN8o76Uzw=
X-Gm-Gg: ASbGncsLbV5I7It9gVX97dQlAurYsC+09qKWV3qTRQf8WBHq06PFdsSSOiPXe6okxwG
	xLpW/WUnpMNtVpP1xTwHXGFFBDEwK2Apop+gXncfAgBMiPoPe/QvtnblC+2PtnTmD6FAjoJGqwX
	IM5ydgRIj3C3VNDNVW35JZ4ipbFUSb+vEao76efM60LQv+X7Tux/iobEw4qlWuUMWbwr59dmItr
	7xAO4ZHFcdylWbNdXa6tM/vMF1dDnBZTioQiBn+m+DMu9Qq0pDyoOY5kH+LIqKK3bpBiK0KlGhm
	ZKeQDSMxM+y0IMNpZmkbJTqLvmkMzD1zmft4OZ47I/nlHmr4KKOOPMwMZCGgy3kl30IwQIYXk60
	JPJg7oETqlogGpnZYtQ==
X-Received: by 2002:a17:902:e751:b0:235:225d:3098 with SMTP id d9443c01a7336-23e257706f7mr297068735ad.46.1753064871996;
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdLbfWV0WIH6gdMWFXAbj48U52Qby9ezjzObx5YEv+xoAivqbUdo2qXTW8a4OuwKQNGg5T9g==
X-Received: by 2002:a17:902:e751:b0:235:225d:3098 with SMTP id d9443c01a7336-23e257706f7mr297068425ad.46.1753064871552;
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4cedsm47541335ad.120.2025.07.20.19.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 10:27:26 +0800
Subject: [PATCH ath-next] wifi: ath12k: bring DFS support back for WCN7850
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI2lfWgC/22NzQ6CMBCEX4Xs2SVsI3+efA/DobSLNArVLhIM6
 bvbcPYyyWRmvtlBODgWuGQ7BF6dOD8nQ6cMzKjnO6OzyYMqVFnU1KBeRlIPtINgo861MkPftpW
 FNHgFHtx2wG6QejjztkCXktHJ4sP3eFnpyP8BV0LCigtLpu6rsuerF8nfH/00fpryJNDFGH8Ci
 w+OtQAAAA==
X-Change-ID: 20250718-ath12k-dfs-82472cfb996d
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687da5a9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=La950oh4TLMd4KyFD9QA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Q0v8auGLORLf0lm0KAn6xUgis7u6QZpB
X-Proofpoint-ORIG-GUID: Q0v8auGLORLf0lm0KAn6xUgis7u6QZpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDAxOSBTYWx0ZWRfXwkAwUcjCAnpr
 X49UEPOJzOTT6MSPA9zvOMvUhL0yQPwlEVtP19jG0NDqxZ+K+cvNOcF9XqT7B2tXV3BNDr3DY/n
 W+a1aWG3vvgXmuHqC8F0keY62VFDNEgON2cOwYJTbU1QXVxdW6QAFTsKMK3y3ZrdL2OGZ8y6VpK
 Lhv2imtlVO3UQM1Zz9T3yGPLbrHh4kqSYozcTlYmCCkvo28Uv1TWMyZ/5glZstA2X2jT3TVMEj1
 DFUJ5y84LiQA1vgqKAwh4/2bGxFIpl2VsM5fsRgsqV9w3F0+G9D0ZfMzVVpFz3YhOUatFJHeYas
 eI0M6ozjxKzwOOoPM/SIAwCVpUrPxNBh9CIuCuRRSNIPMZlMrUXm0B6+gODGoc+nG8Ztr2NXPqV
 fCqPbzryorpuyursLiFhj2fFkHNz3hpOqMZ+Ufdc0WVrkk1vSzjP0R4JPb3BgGhClOIw6zzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210019

Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
support 2 channels for single pdev device") removes DFS support in order
to support 2 channels concurrently, making AP mode not working on DFS
channels [1].

Revert portions of that commit to bring DFS back, and add a new
combination to support 2-channels concurrency. This is valid because the
MAC80211 restrict works on each individual combination, but does not care
about them as a whole, as far as DFS is concerned.

This change applies to WCN7850 only, other chips are not affected.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 176f3009ae59 ("wifi: ath12k: support 2 channels for single pdev device")
Reported-by: Mihai Moldovan <ionic@ionic.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220346 # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 47 ++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bf612079b8bdae18a043913dbfe1ff7cbd9eaa34..97d8b4e287fc361516e93c7d32436f07e4728896 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13364,16 +13364,12 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
 	comb[0].beacon_int_infra_match = true;
 	comb[0].beacon_int_min_gcd = 100;
 
-	if (ar->ab->hw_params->single_pdev_only) {
-		comb[0].num_different_channels = 2;
-	} else {
-		comb[0].num_different_channels = 1;
-		comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-						BIT(NL80211_CHAN_WIDTH_20) |
-						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80) |
-						BIT(NL80211_CHAN_WIDTH_160);
-	}
+	comb[0].num_different_channels = 1;
+	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				      BIT(NL80211_CHAN_WIDTH_20) |
+				      BIT(NL80211_CHAN_WIDTH_40) |
+				      BIT(NL80211_CHAN_WIDTH_80) |
+				      BIT(NL80211_CHAN_WIDTH_160);
 
 	return 0;
 }
@@ -13456,25 +13452,42 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	struct ieee80211_iface_combination *combinations, *comb;
 	struct wiphy *wiphy = ah->hw->wiphy;
 	struct wiphy_radio *radio;
+	int n_combinations = 1;
 	struct ath12k *ar;
 	int i, ret;
 
-	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
-	if (!combinations)
-		return -ENOMEM;
-
 	if (ah->num_radio == 1) {
-		ret = ath12k_mac_setup_radio_iface_comb(&ah->radio[0],
-							combinations);
+		ar = &ah->radio[0];
+
+		if (ar->ab->hw_params->single_pdev_only)
+			n_combinations = 2;
+
+		combinations = kcalloc(n_combinations, sizeof(*combinations),
+				       GFP_KERNEL);
+		if (!combinations)
+			return -ENOMEM;
+
+		ret = ath12k_mac_setup_radio_iface_comb(ar, combinations);
 		if (ret) {
 			ath12k_hw_warn(ah, "failed to setup radio interface combinations for one radio: %d",
 				       ret);
 			goto err_free_combinations;
 		}
 
+		if (ar->ab->hw_params->single_pdev_only) {
+			comb = combinations + 1;
+			memcpy(comb, combinations, sizeof(*comb));
+			comb->num_different_channels = 2;
+			comb->radar_detect_widths = 0;
+		}
+
 		goto out;
 	}
 
+	combinations = kcalloc(n_combinations, sizeof(*combinations), GFP_KERNEL);
+	if (!combinations)
+		return -ENOMEM;
+
 	/* there are multiple radios */
 
 	radio = kcalloc(ah->num_radio, sizeof(*radio), GFP_KERNEL);
@@ -13517,7 +13530,7 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 
 out:
 	wiphy->iface_combinations = combinations;
-	wiphy->n_iface_combinations = 1;
+	wiphy->n_iface_combinations = n_combinations;
 
 	return 0;
 

---
base-commit: 5a1ad8faaa165028dfcce650e20868c8fb7148cb
change-id: 20250718-ath12k-dfs-82472cfb996d

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


