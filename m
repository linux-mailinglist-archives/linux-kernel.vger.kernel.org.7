Return-Path: <linux-kernel+bounces-778684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28BAB2E8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989265E604D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F92EA468;
	Wed, 20 Aug 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcQwFpmQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADBE2E8B7B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733158; cv=none; b=NefEIaNLYxvAmnjC9eLnOJXteYXtcMKvyOk7qktow+61Onc1dRBW5ffSdRK5DLTD+VUkz+o0AmiGCVkxotTKKNB4hqAStsxZ0ucyZapLiqCT5/t0ENO0pnU0F+PFtYYo5q+BLRs/svz9BluNodRxTTJTM6EseAxoIltbo2DLsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733158; c=relaxed/simple;
	bh=14ZTHl0WyMlTosvSsdQcfG20Corab0amwL7v8YXssQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9vUPziZvbUtmKS0yxCN8k3cBMWxzNYEnGF7GUw6uhPQKtoefaQtzK7z9YEkjfGkxuBsC3tZBEDGFoHFJp/MGvxp6+mYUF3BnAo2+X6rz/xuxZl0qeMBibYcVyBamFvW8MaBp1zI6Ym5bqB2+/FgppjM5r689fYclcS6FIDKlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcQwFpmQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJI6qn002680
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=; b=GcQwFpmQUh+ANFj9
	i6RkIhJ+aaaYEb+jAR6fb78iuDMpROs+vUQIgpCvwGm7BX0pPYSJLGmwxIbxiLWa
	nDwxqVU+MQmWYUknqHrTq5+azZxufD8AIive8+q/pTVb/Ce1/NFDRMU7By7CRMtw
	7T1Q3BDWLbUyBnGYxQriuAwSvZc56KM1EMwt1Y0iFuduBuBdTYOGL+yo4iz6vW7u
	GVdMmj8jw0AXTANtYy3K8pBSFghTZXHbff+K/t5h9vchIoRqGdKXL+lh2ISgliZ0
	D8h3NOQ2n+zt6fxI5dlbyYA2FE5wB9o56glgAWQSx4hHjSh3wpQsEapSjuimrRGo
	5PGSsA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528uamn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471758845dso270728a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733154; x=1756337954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=;
        b=vWNsnsFFaQ7qqWFMwSvsW42IlJP2bomzwewKiHeJd+0PAe16GMyYk3JWmLGmbH4YuD
         HPUa7cK10LdBOxUmzt4h+NKbGaKDhNf2rEhRoqnQSrFMw+SP+LMucAkt+CFHKNZ5ioXb
         2zM2zxYa4+qbPO13126Ra7MgtW7yR0Y4EA2eljf3M6kHaVH2fUyJtKMifsf8qvQZFS+G
         4L7x25TXmPE3hSehF+ceu0YS7V0eS7ed/1LvyzWja0mbv1XmE4rShvaOrMpzHYV8l5+I
         0BkATVh9kg1Mce8LSfuyuqvlKyOr9t9QRQMarV/eh/RmqGJi/HxQPxlDinUFZjl2L0XH
         m47w==
X-Forwarded-Encrypted: i=1; AJvYcCX+NSWYfpq2MFz3+kp5TnQ0PofW97IoTLc3HvXYPS7XGEiHl9nrv62IU71J9SDcKNdYsCmoNSDCSX9kqrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4cndb9WDxReF5xy/i8OJyuNycVa0fOUZvb6ix7YY9/FXx6wb
	zXs0+2Qovfg6HQ+h1Imub8e++20BZTowKV2doSWKZV0FemmKDr5BqoRurNPE+cCIe/2I8MN4YqD
	J2//uIg4XZJ85jCID5F+RUK7uh2HCqEORKsg9YrSBoS73kthIQpw/MFx5wLUkQOWgpw==
X-Gm-Gg: ASbGncuVXPkXcbhPPc7mAS6l0V7rsI+JhB5hXt9T01nvBgmxmx2o8RcrYqn6oUWIZ1v
	Y+lSDsh53DZg/HJ4/+v4gLtyO8he2F+WDhiXVQ397H6YdsLhdyQu5H/IcwxWkADO34uo176on9h
	Wxhp73Li4LjX1ViFudDzE6gelCguxJD5u6RmiNHy0AsT3/6rQVGVNDGiJ0lr4DT+sZPQ3QDHpfk
	2qXNBZ0GoBGRcs49dyxUjZsq9GWNO5bWn1YtXVw7mNl3XzD4zq1DXTqUmeo8XkvSPkkUzmPGbzn
	qy24AAI9VWQ07d4gBSQU67nOJABFZJRkCMbr3c+mqLY2MQ6A4B3sTbNV86GG3KEjiJv3OeesSqK
	H6jRYlMieH6q1zo01yAFoCRs=
X-Received: by 2002:a05:6a20:7d9f:b0:243:78a:82b9 with SMTP id adf61e73a8af0-24330abb5ccmr362754637.51.1755733153930;
        Wed, 20 Aug 2025 16:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFO5ag3pP9Jmy1XnNqoDJrAVQY6JrjsksFuA5qgnNEDHF9eaBUcb+mKI+G+v8N1kvMmPm7Hg==
X-Received: by 2002:a05:6a20:7d9f:b0:243:78a:82b9 with SMTP id adf61e73a8af0-24330abb5ccmr362716637.51.1755733153451;
        Wed, 20 Aug 2025 16:39:13 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:12 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:54 -0700
Subject: [PATCH v8 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-7-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a65ca3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7dgirOW2FKBkFs6uBEVMrHeDFK10rAUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXy8xIt4spztVg
 nXHVGZUj631zKrSNNmiwROrdPVpA+dsVlknd73NvGfuxYDK8NoEzhmDKzna8GX4SM0JdgJ6BjSA
 hMCsIHdkOJvV4et+2gedS6CXIEy5rmXJpJiUGGnuGSdOHgP2nNrofOdEMwCzDmjphqDeH5IEaUM
 VfAX8IrOs68TN9LcUlTY+/RetPg5OpwEylg3R+MOHwV94QQ8jS2pHPiR37RjyWnmrrVgp/TG/At
 MkmY9ymZJ8zjFDWLvffSkSN1FwpTIKxf9C6f0of2C6DI7YhzPZ7vmvOpH97M+I2Zf8LUI/Ohnct
 6djpBQEShApy0mDNn+X4CgzSZTtWOh+ZvXuao+TNT8wKTGGZLoB4WWSgotTufXye8i/k2seFcnt
 06Yc6t/+xcBfMHqfHp/J1lPy/YGyEA==
X-Proofpoint-ORIG-GUID: 7dgirOW2FKBkFs6uBEVMrHeDFK10rAUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


