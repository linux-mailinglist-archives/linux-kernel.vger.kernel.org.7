Return-Path: <linux-kernel+bounces-765712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D414CB23D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4269584222
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDD1F461A;
	Wed, 13 Aug 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KoP9mL0+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AD1E51EE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045434; cv=none; b=rohe3S4hJAMJEwbn1YTQwwyxVuvlONCnMZ4V+6QpnYklmvKZiTzUM3cM3YwENOF6gvBKB+Si41gjoE0tNv2GBeypUWBXIbyxw56sPb+OxYEOoX0AR+7d/UnhgqkfpoA6taMgqU1813nPQNkz6U3WqpsY+zVCDWfZ31DlYeSQW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045434; c=relaxed/simple;
	bh=pKHQi5q0rF4Zjn7LuFjE5W8ncYtz1oBEEOgTdSaapz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lymhHEcb/wrkkZF27Gfdqx3IDAAeLbPa87p4nz6VtLbE5FcpaikeqbuCbaj/TM2+B87Hy0Ow58RaGTprDRo6Jw6+RoQWxJjAX8wMT4W6oSF7ECTHh+TbOZnb7V6o7gDQyUnfOZ+9BwzUcpZH1JxkR92vt6J2hOJV/X7qbZePRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KoP9mL0+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKNAZB020444
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+IO/mYYyn556/HWuKEpMTj/0Tt68TcQ9XKAg4TOT0A=; b=KoP9mL0+5p9sVY5g
	DB+MjLf0Ot0KNG+qSe3KtuAJNplE80NHP1+TMqGVmsHUGck7syVisYXR8IH28s1H
	WiRuZXFRqr60rH9Npqn6JVrO/C7Hm1kl/XjrtCLkxMWZrM3jgOpxHReTp+/vKWHg
	RL8lFgwJYj/EIJ33JFiCfQaqb0n0qbErhvvhClbPcS1YoqcFqmq0pXP3mLWeHCT+
	x+UqLi0ReH3XZM8tHJolPV/d2kYu63MOPaY5rf/edyfRBNRA2VQJex+G9nY3NXvU
	pRHuj8GCoxixxiMAku5PnqQFto+IjLolHKzGQlJ4u4Juy2z6U5s6Efwac/XKHXzZ
	BmMMxg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx82un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42218e4a59so4482850a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045430; x=1755650230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+IO/mYYyn556/HWuKEpMTj/0Tt68TcQ9XKAg4TOT0A=;
        b=JMLILRmrGtIUO3GjWbTlKoM06EywHRWU7kXFwBGwBlH7/vg0gpR1S+oPCVGgpD1b/p
         GLRvtDMBl0LqxNUhh6XybvZID3YpZBFVzHzv9vaIZ5Sc2CALESSUr45vRgoABfhjhyGg
         e7xRtXi1x1vqFiWcXakfChdN0qmugGsZbZvrSihr590ktC1F+1XQtR7LPYdYx3ChViND
         wKQ5yRa513udObCfxY1mhHpMl9FagRW1Fd/LaRtOrdEFQfAbQcJNxrI45YvOyZ5auOJx
         kfI4FUrlYuP+mBd4L5XO0a6lqQbsqddCmTUvHTsGAXxXmYqUw3ma3WVrihXU+LKaiRx1
         axJg==
X-Forwarded-Encrypted: i=1; AJvYcCVUT6ucznb16E0Y0Q+SIpSidowA0bLOCv83P3/oJednbhQ676bRXCSgnQ0fVKrxP8aJGpSr4dtlk01ZJgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5bF2m8y5aU2IHBNZhj3fbViHGFAwRb+P33NePIhowv4Gnlo6
	OLNOAlXgPzB6NOLwlzBeTERBdusvj1xlq7jsxc7Sv7LSsGGQ5LFSG6doEmK331aAxI/OKVjBoyj
	SY7xDZUM+JYHtSfkZRmbxzEyrho4KYHffRdI+urls+rPdSGrGbo24odckg+/KHgIdFA==
X-Gm-Gg: ASbGnct7zTgZdaxyGi0oJxXsdN+shzxldcviuXdGGvHTaRQmV5kYXc+ZYVzG6E44jYA
	qMX2xgES/DcMuE5LfFlBexvRDpbqDtOWjb6SwloPN0TWjQwi2800mJ5lhL3SE14+2jr+XuuaC1A
	NzMaNKGoOyA6KUu+p+WTomLPkr3YTYKc3bsy0EFdQFk7uzYW5WcK2wxvr8dPnVgK6nqq7T4wU46
	u0lyzAEhQEvnSSD9eHFJB7I84nFVOKK68nl3YnhiCAVH/TbrCxr38nEIXCiAqN4VqFOoxCSIBui
	3MGg9YcX3TIFgiYcegELxAJq5B5WTZMOWZd0Sz0M5d0mAztBZepUTNVQN3nhSXDeuGU2K/K12m5
	Nb/fVrsQr5uARSZ8BZ/179AM=
X-Received: by 2002:a17:902:db10:b0:242:86e4:3d86 with SMTP id d9443c01a7336-2430d10df6amr19174255ad.8.1755045430210;
        Tue, 12 Aug 2025 17:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqDrIPqSDRuMX+/u3XPMvQEItZdm1JDG7Hzxm2pbqkxQe9lDrS+2GxflzEd97bkgHKl+fEQ==
X-Received: by 2002:a17:902:db10:b0:242:86e4:3d86 with SMTP id d9443c01a7336-2430d10df6amr19173735ad.8.1755045429681;
        Tue, 12 Aug 2025 17:37:09 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:09 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:36 -0700
Subject: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX7SNyKkrHQ4xq
 TJD73D5+BOnVhEXpR2SjrGn5X/G67tNcbLmBzwE83ZcexVBi5AocDdpWDW8HouMJYCMc5Rvzosm
 O425Uw30DW6eK48jv1qRH5HMaPlbAjekxOhDMAwg6GrggUg5mCpFL2kPd40DW8LrukU5LjMhGgv
 YsGMffSFo/yG2ynOlS8Qv1XQ22UrmxZycmzFmIFIA+d6u2lkJT4+z6fUu0I9tsgGX/7ezDjXuNc
 tKeZGitlTyhVa24CW4unp9sdgQWJqWj9VXxyYCicNnva3Uve8zIByBH4gSFwLee+IShG81wEmWV
 9Yuagu90w7gFgbT0TAImLf4DJqMrWKDXj2f/A1reGVqBWcCWpREolp+Q8CttHU41J/6qZTbVoq8
 KXG8Edl4
X-Proofpoint-GUID: USV6RjzPZbloFQ8Oz_J23wx0vJ-TrgpS
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689bde37 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: USV6RjzPZbloFQ8Oz_J23wx0vJ-TrgpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Anyone with access to contiguous physical memory should be able to
share memory with QTEE using shm_bridge.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_tzmem.c       | 63 ++++++++++++++++++++++++++------
 include/linux/firmware/qcom/qcom_tzmem.h | 15 ++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 12e448669b8b..9f232e53115e 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -110,7 +110,19 @@ static int qcom_tzmem_init(void)
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
@@ -118,17 +130,49 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
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
 
@@ -141,10 +185,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
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


