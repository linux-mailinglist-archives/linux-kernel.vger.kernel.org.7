Return-Path: <linux-kernel+bounces-813164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA72B54169
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1831C82BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8E026B2CE;
	Fri, 12 Sep 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpRy7/pW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286F214A9B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650070; cv=none; b=Q2MDLatAS79kyQESgRCAWRO+1MyxT4MnLQIbB3+W+HV+jonK9PWyivhWfIsKPaRq7L6lwIfxrCe0h6hskzW+HzMKf24STfdc12O6FBJCM1HZJFl+17B33GkUN1sPL6hsvNUcaFvAE3y0EB+gy1CzLZ+hkpeTmspCvODyouxgPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650070; c=relaxed/simple;
	bh=lgp1LOhLLp/W5q+GFi1cI9hy6O6fqjuRWo/O+rRQgWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3LI1EeiQr8o2/hrSRTxtEVZQ1hpPdqrM5IInBJXqU1wOCwaSfbg/SSHNq9n0NfkJxyM7a26I6l34rDP3TJ5L2YKdjyKBDcfACOGwO0g5FnPmhnztv13fHpE39/h/oJoinkLHooPkyaR6s60Qvo2cv0uKvBNOQ9lHh4c+dRr6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpRy7/pW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJJ3rP032588
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=; b=fpRy7/pWGVZTP1Dz
	e1t34cDlD/ZTGfskyE/LL6vIYand7oenVD9yQVWch8rrYP+a3kdIqLPeBh6CQCw8
	wxTElaiRDoGt/Wogw+ZsQ09EWh8GVRb4p+b+PCp80AUzZxABlMhvc6poTwPfzHJ7
	ufkpi1TfRSxduaJmlqk6hvjvfvvNfa3KZMbz7J0wCXbd/WzT+4Jh7GySmAFqdX5F
	HcxJ7K58TVZsZKpjfs3uA6NbWFNrK9nICcp6PnKMf9g6/51FG26/kTpcOFR9WCTG
	FjjksPAbOki4XZZxkXvwxFoahWUkjzH19Hylj7H1QWWqCIAbW2P1TDKPtF+vQbHB
	r86uaA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg9x2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so2492458b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650067; x=1758254867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=;
        b=I97hnzsBTiH3MSutDM920/LQHEF54LIql94hW/KorsuB24Ge3TV919npLfa/uWt4cP
         mA86fRz4GUcJiHF8kA8Q2eTDocwNEtDH0PNHdFhqF914o4qoREasV5/Q9SeaT/m6G/sk
         ytkPsjwSbgVHZVda555eM+WXDkaCPs0fgnVNRM2K4VgDsRnAcB4SgUSbf2sRGly/WEtS
         WTiz22uM1HQqJLwX6tHbVmioiBJh1voKIyIwztnG1RKVCFHUUjWCgCd+H+D3j06Wd0f8
         cAjQVvuPvyx5/JIIMgH2H4Bs+n6BVwBn8kEd/hYVSZvkOprWRjeZdtT8UFTInquf8XP3
         /M/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9joYDH/td5uyDJCf9++FNDSh0MLBQo/HymcgbP2a3acT5KdG4Jb7zcCSbwau3wtkdN8SG95Kncp+P8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGunE6Y+gXUTG7VSziyS0eswVK95jLn2itVyoLQ6F8G5mwvVrF
	vGhCNuEDPeqvtpoCmVQEIuHEfuBKMEAABL3x8cTeZIhx3pswSKg4BFlwItctAf2Dqz2J2EmahnP
	RVeYxmbvEfu1yBL+0x5MLVO7nGD30UMQydlW/0si9ZYDrBNYOaVuLUmehGIl92wSHLg==
X-Gm-Gg: ASbGncsMNxwCEhjhK9bDFccQeAIthfGIhJvoqLS0HggncjVZeeoyErY8w1z5c25bodn
	qb20e/uETkpIkYcKlRfa2r+BPi+M8GrNdCK5exNqpdHJtvcGc9qgYR/LvgL4Mb+bG+ce60M2k1T
	Z3gLsEod4OvnZdhUE10cIHiOHEcliOTPf1CXc/rMAkEcu9Gqchj5VeToWQ5so9ay5otEvsBO2E8
	fZP2tbK+BGsZ18JpDu3GzchNWE45NjonCHbpXwxM/8uXFqsQcHjim+DYZiTDf679yjtE7S0ttWQ
	sgUOv6gyrPW5YTsTnMvP6dIzmOdCfgi0DTwXwDAMTgEjR2OLXDOpVBnWg4Wy4Gq4uIkKdN0sLrS
	no+mq6ZNufGcSJAIe4gLPff8=
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id adf61e73a8af0-2602c71d516mr1871819637.59.1757650067469;
        Thu, 11 Sep 2025 21:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHevztzKn6DXhvylSu0O6F+lXoEaD+zI7oVZzqteG9Gk7d9QFgPnS+w+PLRXJqMaYWSBzS4UA==
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id adf61e73a8af0-2602c71d516mr1871794637.59.1757650067008;
        Thu, 11 Sep 2025 21:07:47 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:46 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:40 -0700
Subject: [PATCH v12 01/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-1-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: uNVu6f554-OZRsE9bgSiSSgmCIm_dvXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX44Eev5wBy93Z
 /uz14OC9e7hCS1fr4HuMbq+MvF6sO6SsA9qUMnkRgTOJeSzwOm31ySr+8QAEz7UtGwYrMTdEW1A
 QalHEI7h/ZpugtguZqRfEN1bP/zoGTp74DwLfHZ20ORzgTpSuGM8GyAGec3QP29JdFX1SXb4j3x
 ziFNs6sdA5gAWC/Ur+P4UUzPBDbdeoXcUnvDLSN90z0HBhjv58GOTqEeebcypOAFa+1k/EKPfl7
 ot0owPb2OqlTVNsmaxmwJH1eSUkqSCh1cfAkbn6EHwNxnLwEu1WvX1HCD64CZMhZVOPfpS1o/64
 M1OjHpjCgyCrCBcyFGd6+uMcB2tR6OmRVES6YiknvPzjfN4tCDtUmAr0yycUM7uWUmf4q76XF+/
 kK3u+zP6
X-Proofpoint-GUID: uNVu6f554-OZRsE9bgSiSSgmCIm_dvXV
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c39c94 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Anyone with access to contiguous physical memory should be able to
share memory with QTEE using shm_bridge.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Reviewed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_tzmem.c       | 63 ++++++++++++++++++++++++++------
 include/linux/firmware/qcom/qcom_tzmem.h | 15 ++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index ea0a35355657..186511ced924 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -109,7 +109,19 @@ static int qcom_tzmem_init(void)
 	return 0;
 }
 
-static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+/**
+ * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
+ * @paddr: Physical address of the memory to share.
+ * @size: Size of the memory to share.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function creates a SHM bridge
+ * for the given memory region with QTEE. The handle returned by this function
+ * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
 {
 	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
 	int ret;
@@ -117,17 +129,49 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return 0;
 
-	pfn_and_ns_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	ipfn_and_s_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+	pfn_and_ns_perm = paddr | QCOM_SCM_PERM_RW;
+	ipfn_and_s_perm = paddr | QCOM_SCM_PERM_RW;
+	size_and_flags = size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
+	if (ret) {
+		dev_err(qcom_tzmem_dev,
+			"SHM Bridge failed: ret %d paddr 0x%pa, size %zu\n",
+			ret, &paddr, size);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
+
+/**
+ * qcom_tzmem_shm_bridge_delete() - Delete a SHM bridge.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function deletes the SHM bridge
+ * for the given memory region. The handle must be the same as the one
+ * returned by qcom_tzmem_shm_bridge_create().
+ */
+void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+	if (qcom_tzmem_using_shm_bridge)
+		qcom_scm_shm_bridge_delete(handle);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_delete);
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	int ret;
 
 	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
-	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
-					 size_and_flags, QCOM_SCM_VMID_HLOS,
-					 handle);
+	ret = qcom_tzmem_shm_bridge_create(area->paddr, area->size, handle);
 	if (ret)
 		return ret;
 
@@ -140,10 +184,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 {
 	u64 *handle = area->priv;
 
-	if (!qcom_tzmem_using_shm_bridge)
-		return;
-
-	qcom_scm_shm_bridge_delete(*handle);
+	qcom_tzmem_shm_bridge_delete(*handle);
 	kfree(handle);
 }
 
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
index b83b63a0c049..48ac0e5454c7 100644
--- a/include/linux/firmware/qcom/qcom_tzmem.h
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -53,4 +53,19 @@ DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T))
 
 phys_addr_t qcom_tzmem_to_phys(void *ptr);
 
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle);
+void qcom_tzmem_shm_bridge_delete(u64 handle);
+#else
+static inline int qcom_tzmem_shm_bridge_create(phys_addr_t paddr,
+					       size_t size, u64 *handle)
+{
+	return 0;
+}
+
+static inline void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+}
+#endif
+
 #endif /* __QCOM_TZMEM */

-- 
2.34.1


