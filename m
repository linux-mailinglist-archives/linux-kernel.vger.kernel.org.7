Return-Path: <linux-kernel+bounces-738220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432CFB0B607
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E518900CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741122154B;
	Sun, 20 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VfXObT7P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69C21FF54
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013864; cv=none; b=WOIJ1vdiVztMDOz+lqpwPJFaBHS5+oC0ozG5N2aYzoQY0ris3vzU2+x2ZfqnmZKqopx9eHeBp9zTspOk4wZ2pLELpIjg2l8piDR+eHUu6sDdEKCSaZZCGmUkSnr0FlygpaSAbgn1ph044sH/KxhorIwmrZUwvXD+AHEozewjsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013864; c=relaxed/simple;
	bh=L5HKQ79fHDKRoQCUJUYZBcmAzURDg5BUnlMom8bx9wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+PH1t4ZqC3RCQnlFjGAaOPlS8R4uT/7348EYWdylYiI9mCk702tCz79P8EicNCoLZuVoiujmh4ZGBaLjqRkyRhOShWETJmkYUcTB0anTAKaKqxe3TXwuIVyuKUnv6xr+BIM/BUheYfFvfahfcLnQDi9mcOewcnA/v85Ia5NDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VfXObT7P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K5bbkU001846
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eC4SNqgtxVB3YxPxYsJignz0kXw+qtoKkLkGllcnSfQ=; b=VfXObT7PiQXZ0SJR
	yUHAKVSic+9Bw2cMaGXhOz3lX9Ml9DLizaE+Ezc9qVGxBvk/hRot9siIzQuCHWo1
	jOFGNZkynr+/mzPy2K3xv94NedMwK34c0Zmj/7KGzLCDKKCzoy8IrWAo12uQTVNZ
	6+lC/wP27KFCERyilE6fjXJ2DwN4tor6Bsn1swnMbtiwrOvDWHvBF96KKJikTSLh
	ZFIlQcavrShj2qZu11h1iW2jmrawFiR42n1CzNdJirH7jT0kxk7boNnSXxKb77dv
	l3c2GAelRrKTj2of+Q9I7gpVlsIoSt+etwM+tC53zJLeGi2D1XeTV8BEzu145ERI
	j99Ujw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmj41m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so2977514b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013855; x=1753618655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC4SNqgtxVB3YxPxYsJignz0kXw+qtoKkLkGllcnSfQ=;
        b=dAPZehhg3wsCPAxmmx9bMlYa+5fvVlCHL/Sdj/qhEFH1918rPKlNvECpmbpHssrGxc
         FMhe6Qrauh7a4jN4TOMqczMdXHSBIlzNcIfULCyIxiy8+zRKCYodj6cHxm2rGbNiH0/y
         lIqAzMvatXCejaY4ZGoi8Cal2eWa4bVeOparM7r/wWhbFqhJ38mQD1pMSploQTulGVyr
         pI2p7QwKRuHF8bUfVS2FWxz+uYnGJ38U3NmVvl6or584pDjS5nerfL3GFdVLR6XJXFK+
         4KM0f9KbxyfIcnyLDG3omRJzzk8mgKOXNxkRgy/fgWU/Ksm/bhYvCXx21eiqUw4+qz5r
         exeA==
X-Forwarded-Encrypted: i=1; AJvYcCWgkwejEeoz3TA98Jh7aodX3Iw1Jj6p711TB5WxCvMcM7FP/nOe0RpcOeVUWqA0qnOCIHk//6a6DrUL2q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CF1++GK+AuMx1Itk1QGdMPyY91LuwOjhGB9qo5O98kVJDSJF
	uptpaVg0Uxiiaxz73FeNzNDrQxydPIU02N3fFPiIx5sFalAyP//vZPMeeIRPthLi3+xfJnTwbmX
	H2+Exdg5jPsYg8qrN375w2lZKD8bGg7XALZH7BD5jrRbKlRJfHoUXTNkH/lDZJuvVWfQ=
X-Gm-Gg: ASbGncvo9n4IldJ3l50aBQhefArUG5hh4U2mWWtGeJ3l4pDnPIQ66kH5ku7JlUk1Spz
	8adROjcrlZRHGXO8m/RFnZqMXI9z49Y+SfPI3/R1S+kEgtOkRA9Dv7neSToj5IRlF/wJ6s5FTTl
	vnoVsPtvoPbQL4pjxOgxN+A/G5XnrH2qbKc3AtSIZDU9vfhEE9+GWw8obSEKBbd6YWPDPO3mU2z
	5TN3ChG5Pl3GiTcJHpiaXxoEcKIQfHNlicIABBcFe/cEVhH2/7L6+vAf8pRTPl2N7iUk6iMS/1a
	Ij2lur9UrTBwzNtNqfriWd2kMO/JJuYlDYXuHLEp7gjcDMK0I3jHKkkohOijjDC0
X-Received: by 2002:a05:6a00:4fc3:b0:748:6a1f:6d3b with SMTP id d2e1a72fcca58-75724671bffmr24169904b3a.19.1753013854910;
        Sun, 20 Jul 2025 05:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9xGem0/glAJK06SACRoeTUX974pMhVeE1PsAYwyNLoNelCYqDBNKkq+MohsUr5PYvUcG6Hg==
X-Received: by 2002:a05:6a00:4fc3:b0:748:6a1f:6d3b with SMTP id d2e1a72fcca58-75724671bffmr24169866b3a.19.1753013854478;
        Sun, 20 Jul 2025 05:17:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:12 +0530
Subject: [PATCH 11/17] drm/msm: Add support for IFPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=3903;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=L5HKQ79fHDKRoQCUJUYZBcmAzURDg5BUnlMom8bx9wY=;
 b=lT47NC5/k72Scks0xL8xes0trI36x01TctCWagCHGtEPai14c0mFIAKP+LcZoFMuPh1X9d2aH
 a2NsWDBcn97Dj4Gfimo6RuGMnBnIoMgiDimCQlk13duHAE8Hc9Z2SKj
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: hRCHSK3F-hvjI9ferMeCejrOx30Qa9bi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExOCBTYWx0ZWRfX72R71MSoPZZ7
 8ImIen1wPvzBVY4WAoahAWS1Kt6Zh9IzHZUHNUuXWZNnx0ErEz8d3cHMsQ1U3ZIfptH8GGsYoxY
 f5Qc2KESbkP2o7yVt9A8G8F77RY5I9VB/gayx/kumrOF8eJCQsCaTtS5t1d85U3Z9ZSwAEyCbka
 uAinjCySd2euYIvEQkkcOGmKusjsZ7NmC4mH4U69j4sp9ZRXVaY4eAnW3qzdriphNjSaMI2q/WY
 fTlsqKgqNoSfXvP1kkAC8BgyicsYqEwH2s2xotq47PyV79feXBtGJs0icw6bObhLNY6BhyYKqJ9
 TASBELdo4ScRiZbQelN0/TymfodMmTogRkPrR0Se9eNSHX/xVK2KroFt1JCAw98+2MgwNlQWtMf
 4KLGCvKp2rSGLQAk+aZvoBiglozHq0qx8dXvrdn0ppU3N69Tr5qqe51AUISlirApMFOONTOi
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687cde65 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=P3MwbOLga73G8009EeoA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: hRCHSK3F-hvjI9ferMeCejrOx30Qa9bi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200118

Add a new quirk to denote IFPC (Inter-Frame Power Collapse) support
for a gpu. Based on this flag send the feature ctrl hfi message to
GMU to enable IFPC support.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |  5 +++--
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 33 +++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 4d6c70735e0892ed87d6a68d64f24bda844e5e16..3bbcc78179c1cf1bfa21ff097e9350eb2f554011 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1961,8 +1961,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (ret)
 		return ret;
 
-	/* Fow now, don't do anything fancy until we get our feet under us */
-	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
+	/* Set GMU idle level */
+	gmu->idle_level = (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC) ?
+		GMU_IDLE_STATE_IFPC : GMU_IDLE_STATE_ACTIVE;
 
 	pm_runtime_enable(gmu->dev);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 8e69b1e8465711837151725c8f70e7b4b16a368e..20ade6b0558b016b581078f5cf7377e7e7c57f8e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -21,6 +21,7 @@ static const char * const a6xx_hfi_msg_id[] = {
 	HFI_MSG_ID(HFI_H2F_MSG_PERF_TABLE),
 	HFI_MSG_ID(HFI_H2F_MSG_TEST),
 	HFI_MSG_ID(HFI_H2F_MSG_START),
+	HFI_MSG_ID(HFI_H2F_FEATURE_CTRL),
 	HFI_MSG_ID(HFI_H2F_MSG_CORE_FW_START),
 	HFI_MSG_ID(HFI_H2F_MSG_GX_BW_PERF_VOTE),
 	HFI_MSG_ID(HFI_H2F_MSG_PREPARE_SLUMBER),
@@ -765,23 +766,39 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		NULL, 0);
 }
 
+static int a6xx_hfi_feature_ctrl_msg(struct a6xx_gmu *gmu, u32 feature, u32 enable, u32 data)
+{
+	struct a6xx_hfi_msg_feature_ctrl msg = {
+		.feature = feature,
+		.enable = enable,
+		.data = data,
+	};
+
+	return a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
+}
+
+#define HFI_FEATURE_IFPC 9
+
+static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
+{
+	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
+		return 0;
+
+	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, 0x1680);
+}
+
 #define HFI_FEATURE_ACD 12
 
 static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
 {
 	struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
-	struct a6xx_hfi_msg_feature_ctrl msg = {
-		.feature = HFI_FEATURE_ACD,
-		.enable = 1,
-		.data = 0,
-	};
 	int ret;
 
 	if (!acd_table->enable_by_level)
 		return 0;
 
 	/* Enable ACD feature at GMU */
-	ret = a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
+	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_ACD, 1, 0);
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev, "Unable to enable ACD (%d)\n", ret);
 		return ret;
@@ -898,6 +915,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 	if (ret)
 		return ret;
 
+	ret = a6xx_hfi_enable_ifpc(gmu);
+	if (ret)
+		return ret;
+
 	ret = a6xx_hfi_send_core_fw_start(gmu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index bc063594a359ee6b796381c5fd2c30e2aa12a26d..1135beafac464f3162a3a61938a7de0c7920455a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -58,6 +58,7 @@ enum adreno_family {
 #define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
 #define ADRENO_QUIRK_PREEMPTION			BIT(5)
 #define ADRENO_QUIRK_4GB_VA			BIT(6)
+#define ADRENO_QUIRK_IFPC			BIT(7)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.

-- 
2.50.1


