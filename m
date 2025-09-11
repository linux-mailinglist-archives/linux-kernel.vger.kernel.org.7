Return-Path: <linux-kernel+bounces-811299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71510B5272E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994C8688291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569823E23C;
	Thu, 11 Sep 2025 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIs45YAr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E42367A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562090; cv=none; b=E1V/pvBto8hiT8aTZh8tuzPvrO5oD/pEz4FmTGkcgD6fuFHAa36Whgz84OI03Q/MiDRLGOwk7OgOq1w/s6D07U+gr+zm63f5JM8Vb44DSzCC4hpj4FKMA3oDZaf1WF7N/TmXg+1ycmRXlRSII7vBPSxnigVSmECYdHldds+9j6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562090; c=relaxed/simple;
	bh=lgp1LOhLLp/W5q+GFi1cI9hy6O6fqjuRWo/O+rRQgWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si9UcxlAWtSbJwZvUmNJaC8RtENF7jYQmkPWgK6fR8+ydXuDQk/s+qQxip335yJt/r5jGx0g7u2PuIKZUS+3hXyxpd6CqYUmScHFtkkWPqU2B+JfyaUfyx9ubp6IKX7h1Mbk/pBF0+Q2qpg80tsk+/NvNYEgYy4sFmiiEQIZaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIs45YAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IuRi008865
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=; b=EIs45YAro3qEwEC3
	a49S8A5D3EncjdPj4pIvqAWDdUSLOmHG2HDZGjZuHSARbL6L6rSQhLJ91KRJLPg0
	vVLgDbfsziahyewB62mUcRNrkrKWFPciihRSbL10ktDRqQlC1mnzL+gPOwHVtB12
	dAiGsS/ItG3P2pXKFK2oRk1R6Qm2uA2ERieOcO3a0Nr4HvyWnDb9ba5XhHm6oNM3
	bfgpkEOMoOK0nuYdpgPdOUSvSCmq/pdWgRjWz7ZU+FxpFXomJEQZQBjObtHys6AR
	uignD4nLgz5sXiwtNIAnyVDI+7DP3Goxu/MCFYLDCAPt64nDzzU2C7LkOgdIONfO
	zCfOww==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aappd9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329e55e686dso426519a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562086; x=1758166886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=;
        b=kYRmDwBgYIiEHzRXcUIkXgaQxkF6cvJ6UhVN1Dub3Y5VWtuwxVAojSjdkQvlq/9tvn
         XH+uxA3mhCABCMZDB0hUSnmjhOO9Hs9N3JbQ/FYQfrb1hpdnRhfMEQ/OpYDw6fLOT2SG
         XFSOnxyKYCA6C8vLrfKPPlep2RTTTUU3SSyygYECxHnR7j33WYbYdViAJ5HUPwW449gb
         CXGt7HqKywTjVVToO5jXCJ5v2FDNsITb0SVwP660O5EMfdFD5R6CjnxioCnc6XkLuhxL
         w30RF7Gr6OoGEdcLvVC8V1pfgy7hY4be95nPLxnjZoOsInHP5Kzmsvf1vh5+bhh7/P24
         /IiA==
X-Forwarded-Encrypted: i=1; AJvYcCUdX5CbpFwuTVJ/wcQ8l5ZnrnJ02jV34dHVyyG6u1E3ScoIM19WhF0mxGojq9iwsKpbBJ0cA/OIK3//Ibg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgXXgHjT+MRcCmYi+yECT2gaifs/rCQ8uvvUB+UAgZYLK1F5i
	spEkHl7uClJhl/39ZzHSA/Fr0MKhcnGq8ZB5yRjzcAVMw5tDgj0mU6Avg3/O3dblNN+kO9EcI8u
	RWAHyUFEbsBbf6JKHvbpZz64BCGlJU+UsbER68f5N/SqmNEelqhGnlbzzRuyupUxHcg==
X-Gm-Gg: ASbGncuy5KCX046H0E1xYF+7sarmsjQpTxO7EuwCFbb3MweJljIi7CSCTmQDXic+tPV
	olC0JRiEPM0HtSDf3b3UNtGPFehRzChOMwRitugP7O8xsvz7iDpMnUk008uOjJjcD/XC974omTC
	5d0tc+SSON2g3tylnHeOSytTnpwJaIY0SpDfmPQHauMpIbTw01q47T965teIB6E1I8H1bp7dgqU
	lNpTOPSie5B3iIbPZTYpHQp3ioCTr9A+/Ngn9OR28npWNlPCJR05y1MUuq/J70DWhHlEXKy/3VI
	+TpRiRZmUSLaL4XF8lT5zF5UIgrt4S7nRufb79NBrFaGW3SqvkfCEeqBBTcb89wymavBtjwwENS
	JT0tyejZDpZgKazMNutzV6R8=
X-Received: by 2002:a17:902:d2d1:b0:250:411d:fa83 with SMTP id d9443c01a7336-2516dfcccbemr289529855ad.15.1757562085895;
        Wed, 10 Sep 2025 20:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNK+dvhXEwjPbidgExO5vSVEoN4mnn7hiDWFYTbts3RbLRlhWqysKV/H87BRXyKuni3VCG8w==
X-Received: by 2002:a17:902:d2d1:b0:250:411d:fa83 with SMTP id d9443c01a7336-2516dfcccbemr289529355ad.15.1757562085362;
        Wed, 10 Sep 2025 20:41:25 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:24 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:14 -0700
Subject: [PATCH v11 01/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-1-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c244e7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IWSb531uGe6dA92gSiG-PI6GSDaI1o-N
X-Proofpoint-ORIG-GUID: IWSb531uGe6dA92gSiG-PI6GSDaI1o-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX7jxkyjxXl2TE
 oOqTsLaq7VKodwfMJ32JeUfC7RlcXvWg96SuERjQu62lHUadHhBCrpM5FEG48B2L2QsQNgTomnU
 PPKnPKt0RSj4BPp1thDsx8Q+It8l+I5VtR8hBrylMbMANse5cfreqpiBK4RlZwo6HnbmGMzcbkG
 2iUzNkhfVYGGXjfIVCaJh0+0R2uzAkiYeIiUw2Bracu6rHv8AaPyiI7GPadElxg1gQKZQx5YUPs
 XXaK7zZvfb9TeSCITUj+ZXA3y9aPiTuqnE0reVRsZD9f//Ckz3Qvxr5+gxywidGu3AaM2T7dqi+
 7WQIgaMWtvRdp8zizwJLVL8JNEczbSDoE0QYlCOsWR01Ngp6EHEqlIMvfjYj2sBAPrP98nU226g
 RX/RqH/0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

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


