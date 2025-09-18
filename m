Return-Path: <linux-kernel+bounces-809180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80DB509B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99C34416F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32B3D994;
	Wed, 10 Sep 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QeYwalUE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF01CAA4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463081; cv=none; b=g7HFeKArUBGvjx3GnPmhMSCStJlfy+s7ak8BBsc6PFf6O0bVo+xgCgomtA1dRWmBV8eiAERzPSbAHyqOrDsPAtDSedgCLLuR9USTDlz0dzAV/hYh7Q+EdKj+2YlMGp0ojUBlboIb/VZ2G7LK+OKdhsJKDYGLNa58XV1sGxXNH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463081; c=relaxed/simple;
	bh=14ZTHl0WyMlTosvSsdQcfG20Corab0amwL7v8YXssQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4d5pjqTmIxTD+Jzu1g3NzJqzskTqSBBKVOr0dM5ysAZMtgC2uUiA30XOTohmvwXVrQS+pKTOaunOTX8uVh6Z1IkvBkIMYNAeg9tRlIOQQSctZNhTgzvFfN5TrZzMNWQpCwvB9rVsXew5GxhsHhs+L0zhHJkNI8wb2Kyo280tKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QeYwalUE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HbRSM032042
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=; b=QeYwalUE9RS+dIeq
	zVZqu+TYV+H2TDSg3eaaY817tAMoGXTM8pWJPQh0KTeaw/Kzg7widV4Y7aU0XwVB
	CKW/vng6q9gPW8bs0i5wqWJv4iapO5uT0LfQD48HNx6h/uNc5ltYy6LmvKSMVkp3
	m+ePDUjnZvq/DFgXFJ/6QVUNF1dwrc/D5EDV3gfjcu768fEr2pYzyrzXmUx1RYjM
	RXOQSd1grQ9qGWpg+xrWgWYzPgNA19s829QodY20JXARHOoA0B4ftzYW8ucZ6Pc7
	3bo6rpD84O/FUglj4Y3Fzj0li04QKjYkGkBWfVkeVOcYUYG9c2i20IoQK0Nsxe2L
	PZjjBg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m1w9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-324e41e946eso13268440a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463078; x=1758067878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=;
        b=Swleitm1/ZvEjg5IGXtoyCFb8CWBzblfxxE3KtUVwjpDTItUvLxu4oTFiQdLFZLdkg
         DR/9mxR3MJb9hH4nezfOazzQSM9rHEMHhzWhuUtwrIPaUqLHk0Z2kLDQ6ubn2++TmnzP
         kqBTllc+Y1UIO9Q5N0bVexGRi3gcuGaplPOhdP4u/ozAGhMogcnGv3lU7mVjIsyQrX2v
         nYyUFd+QQWpBRkk5R92up8A5lVJU55H7gZBwmd1xq92t3OCBkATkSbP1E7Ta+sGClHQx
         AwQuG+HK+NJGBvdASHYgTWox2ateXzlHpM3Vrr/EuO1h3/phH7k6BH8os61CdWISYTK7
         1WGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxrSCwsHuskddLkLNrtNe6az6g1COznIH8B28f6WSUyGeMZoWC+hpTiGZIvKndAKVZO410AzDZ90CWAF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcIOgZ4Z/xQU83PBnlydZaC2Fh1GupZzCmhHS+IAR+yy9mo/Z
	98TAGFeEDYm4DqzYaEdjfa03ZlaBwSxT9zDVZabD+psd5/IB0bJEtki71PPT3TH1vFzEPQ/5wKz
	BB8riDKA5+CzvBWDSGBXf+cUXLgDuQ3FSvSQnAiwOvrxVa9Myym9vDSvp1OFhAA829g==
X-Gm-Gg: ASbGnctM3oJ+MI77IRXMtAUlSNXx4dQxlJL5eCNUF1dWqIlzOyjQZhaWtC1RtIcwNIj
	UNZQAJEDkNlmLnkcs1w0jvlBc850NXwJAp2GrqHygcySpcPyIk2QwXcQjtH9K2y3/w7Djv84CUE
	t40+tUGEboP+e+3jXm8wvY6ngyGSN12JWlJR3zlyZoVXeZnGbHuubCcJsnm+5fmv7wJWKmy8rOR
	lnWV/WcCoAv/5BVCGxFOLX+ZwgGImtTizkwRKrCOIKD3jgifuWgQNmQvNxGwIXHm/e3IyHxX+p3
	0DkTqzwixKmDa7ewx1g4bY9owdPuVPjR3eBYKNF95YC/rHKDUqvkBynKTkTnAkXMHOw8p1S7Hi7
	YWnMeNwNXnyeF6c87nNBBYXo=
X-Received: by 2002:a17:90b:278d:b0:328:acc:da37 with SMTP id 98e67ed59e1d1-32d43f04ffamr16696072a91.5.1757463077937;
        Tue, 09 Sep 2025 17:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIXpd0nyV+5W6CDzwhd16gTLrOkaPXC+72FYq1kyJ0evnvLYFejafDZfWoW96NTJmQ+vsCsQ==
X-Received: by 2002:a17:90b:278d:b0:328:acc:da37 with SMTP id 98e67ed59e1d1-32d43f04ffamr16696027a91.5.1757463077356;
        Tue, 09 Sep 2025 17:11:17 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:16 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:03 -0700
Subject: [PATCH v10 01/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-1-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX5nfj5RQdcG9t
 BELymGnTzdgEOfN4p1xQnWeAJkVclKhhZU9gQgLs0DKEwtbRGIBB5f8omew9rGsT5i1vAOBPxK1
 jw0BzzX4gFau9yoiu4Av+2nTLhTuLaaEmTHiXacSdDShMyEtkFokDceOr/ws1nGOH5WPapYGIAm
 Sp0CSkE14omJjQHImcvq0jvXnKBnpe/MJ/awnoh+HL1kvmxnV4jghs0osItxdKO04Y4na1wWnRX
 gA7iwRzWzVUDlfGKUscJkHsJthmhxOBASzL6APLz8F7vIwzsLK3TLgge4x46x8ZajMYAtW7fVn5
 Kjni6OjnViRXL3tfamieqe1DnxD9i6W1EcbwUSss2F4SaA1vWg9xMhtKB92k1acS/rU3RIDH5Kz
 dVUof6GL
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c0c227 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JRQfC3U2cQYA0VoCJYyoR6cgyta_xQrI
X-Proofpoint-ORIG-GUID: JRQfC3U2cQYA0VoCJYyoR6cgyta_xQrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

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


