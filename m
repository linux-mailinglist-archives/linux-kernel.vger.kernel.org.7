Return-Path: <linux-kernel+bounces-778683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F6B2E8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BD21CC3E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DB2E22AE;
	Wed, 20 Aug 2025 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHR1ahOO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798262E718D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733156; cv=none; b=WkUrjZpERd0R0ftq/k9sQ/yVqh2xlHBfGDyCHogDltKxPegfG50CpLMxtC0aeMc1pMn/avusVF2kQlNtz75INDutgaO0/B3lBvP8QxF8jodI6OwY3XZHjccioMwIVHSLRe+idXFJR7UxTvmGnxMUUe9f86ddKdGGSPTHbCi8764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733156; c=relaxed/simple;
	bh=PEWukFaXy+1/WLKHaH1PDIlHcz+rQFElehAYKJFpDlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8aXq0bd+aa7NspvDdcqrKiCOWdjpYp5+DA7RA4PMsQ21ZV0U2/NXK3rc1rZK6qaNc9JC+ioKAiLGSpIg7W29vEwf2eEYMVDXTKA505nCeZcgfZfDZF4KkQFjcMuhp9Rud2FeFinOrQFdTMQ9DtbKsRzZayfJ7iACPTyYzZQ0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHR1ahOO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KITqOi019724
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OziBg5QH84iJg7BEq37Vh9CRIDjrCtz/V2Xkbgr7kQk=; b=CHR1ahOOZL3s0phW
	GlDvp0xoP+b2gKld8599FfT29eQzGIFtgc1+IQHjw2M1EXy6SV3gEG/GVSwa6+eU
	E/5n/b+m0VZ7D3BXOpBh7qyG75R+jopkcZegWkpmdiHPtwm8cFoVyKVp/kp7LVcW
	Ol6PFhddDHaSzxDBNqMYa80FhjrxroU+N4HIY774eLVQ4SuOecZZoFx/73VqPkMS
	naBlgP/75YKxC6ICpKiJ7ZHlzKn0S0G736Y/TLXQcit0hX7FkA/HYPkFCsmlHeA6
	gc8SdewFuOuX9Wtr30ktpazy2Wup+W+4aKaSJaqFn4PLAsQVfv1mJTh4cxm/crP/
	hu5ZYw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293cte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so635706a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733152; x=1756337952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OziBg5QH84iJg7BEq37Vh9CRIDjrCtz/V2Xkbgr7kQk=;
        b=xTunxHFRAdrFXb/RTQqxMoooc3WlJlroL6n8huQmLJEXKsNe1sQ2aeu1V43O6Lm9TE
         FqzOH4eVHbDqCwHgN/mGXkGE6dWxttTylZZskxXd57KvjYqzNddn0370ApDQgEKdLi+Y
         1CXRXeLY9rfwGgd11MN9l22hKeTZn9OKDsh3Oc6gJ8LImtZW4IEvqzNOsBo51YfqzcCm
         H462RkS1Sym03sWvO9h47DJcv9dGgsAGZZnAjxgWr07jVYPa+0KRSu4vKOGfS3p5T+c9
         mxkLJl89vAYzwtXjqIg1PuMSJLLFbl02pZ2MV0eZB0dqf1EVxNAjAM3WZ2xXaGSVwqRr
         ej2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuZ0MpRSao1TBqawl76drHfMC5zVVYvdTL9P8s3pf14+9i7Ue/2PiXN7AdgBLczYpA1Iuak7iG0FDy+5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5v7Su/5uWPhKZ1aSaN9jl7HVHouODDnmIQnwS28H3j9Uxrx4H
	hCXJDpUqHIShr77MtD4VgGmgEzc2Ncz7lo4hClWc/lMFp3zBvWRwvUJMw9ZGZGd0sKRoimdCmvz
	4/Wl/9JZ9vojXJRK1Nb3SMzIwvp/nwvPQwY1YXTqqIkNloiA7HCBCJNNh7T99DS1kcbfR/maxJY
	Tw
X-Gm-Gg: ASbGncs5gBQmRW+u7sMdvA85amLQGIfGdbvPwLJAUSzvgA0QRHe2wOPpbhC/bKC5yzi
	6qk8NC/GkPogL7sMN4UO+1NKlee5wbT9gJPLNt8P3Gl7jKS2v7T9BOUMVqdvt39SN7Bm+Rh4/9n
	W8B98I6nBlUCUZ1xWPgZVWlJ6ZSzciCsqCms8EncfiI1d9+Dv92mBv2ohSX2xWcfMCVm/rX2nJf
	zSgZNeAfmcK1P/KG8yEybl5KVSF2eI/SjJLgdy7Hm42wJ41QgTBgZZDAdImhnooAsCm8SfQK4ph
	YLfnbd0qySMihPzDg+8A88hDTt4Oyt/tljRbsmR6Ko34xFDgmllSfom/B8/EC3pdfi23hbOjreS
	KHu4GY0bEavDbInFjtJ2M/Qk=
X-Received: by 2002:a05:6a21:99a4:b0:232:4d23:439c with SMTP id adf61e73a8af0-24330820b83mr436419637.26.1755733152288;
        Wed, 20 Aug 2025 16:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4q21snnZvza2gUYqCpc9oJGYRO5YgdC/ALc6CoBPyomPY8+z8b9F8o3aTa80p1Mx7zshEiA==
X-Received: by 2002:a05:6a21:99a4:b0:232:4d23:439c with SMTP id adf61e73a8af0-24330820b83mr436378637.26.1755733151803;
        Wed, 20 Aug 2025 16:39:11 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:11 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:53 -0700
Subject: [PATCH v8 06/11] firmware: qcom: scm: add support for object
 invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-6-7066680f138a@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: AV6QQe75g5lG9xbfScwUYxOhgi37AxP1
X-Proofpoint-ORIG-GUID: AV6QQe75g5lG9xbfScwUYxOhgi37AxP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyf2IcfPXuaV7
 XavK2MtvqEgtTYfPVop8knu8oMiwGQ0jLnVq1hsGq+hffyhv+MWYyDK0XKjaqQdzOkWzPef7RxK
 gMcn4qZPvbwwd26CElS156dqDSsGNX6tyUW/b4KGARWJZdEnVBXXoXcd0S9bdEnhMm4MKUYSAVP
 /7Ms5WYi0G6N7migFluAcWElOkRtZLcvVI3wBVthtHYrKK5LYVzOb0GS85fG6NU5uGwaG6174Zl
 lS+7XXaN/e8/7HeuVupqFcPxKEqR5oOLck6No53xR9sppVwpsj2w3uyZiOx8tjjzBHHycSNBuRr
 AnBpJSUEO/7xklsShvUP4Y8lUxhiUz/OMa3aX3QYWytEqtZeqCKho+IVERCvj3Fvjs/G33NV4m2
 EjRfM3rZP6a528BYjXlIBFManIDf8g==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a65ca1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dBYAKgxw8cyf2mnx-aAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
the secure world, accessed via objects. A QTEE client can invoke these
objects to request services. Similarly, QTEE can request services from
the nonsecure world using objects exported to the secure world.

Add low-level primitives to facilitate the invocation of objects hosted
in QTEE, as well as those hosted in the nonsecure world.

If support for object invocation is available, the qcom_scm allocates
a dedicated child platform device. The driver for this device communicates
with QTEE using low-level primitives.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 134 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   6 ++
 3 files changed, 147 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index edeae6cdcf31..65142fd31118 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2094,6 +2094,130 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+/**
+ * qcom_scm_qtee_invoke_smc() - Invoke a QTEE object.
+ * @inbuf: start address of memory area used for inbound buffer.
+ * @inbuf_size: size of the memory area used for inbound buffer.
+ * @outbuf: start address of memory area used for outbound buffer.
+ * @outbuf_size: size of the memory area used for outbound buffer.
+ * @result: result of QTEE object invocation.
+ * @response_type: response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @inbuf and @outbuf
+ * should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = inbuf,
+		.args[1] = inbuf_size,
+		.args[2] = outbuf,
+		.args[3] = outbuf_size,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	if (response_type)
+		*response_type = res.result[0];
+
+	if (result)
+		*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
+
+/**
+ * qcom_scm_qtee_callback_response() - Submit response for callback request.
+ * @buf: start address of memory area used for outbound buffer.
+ * @buf_size: size of the memory area used for outbound buffer.
+ * @result: Result of QTEE object invocation.
+ * @response_type: Response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @buf should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = buf,
+		.args[1] = buf_size,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	if (response_type)
+		*response_type = res.result[0];
+
+	if (result)
+		*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
+
+static void qcom_scm_qtee_free(void *data)
+{
+	struct platform_device *qtee_dev = data;
+
+	platform_device_unregister(qtee_dev);
+}
+
+static int qcom_scm_qtee_init(struct qcom_scm *scm)
+{
+	struct platform_device *qtee_dev;
+	u64 result, response_type;
+	int ret;
+
+	/*
+	 * Check if QTEE supports smcinvoke:
+	 * This will fail due to invalid buffers, but first, it checks whether
+	 * the call is supported in QTEE syscall handler.
+	 * If not supported, -EIO is returned.
+	 */
+	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
+	if (ret == -EIO)
+		return -EIO;
+
+	/* Setup QTEE interface device. */
+	qtee_dev = platform_device_alloc("qcomtee", -1);
+	if (!qtee_dev)
+		return -ENOMEM;
+
+	qtee_dev->dev.parent = scm->dev;
+
+	ret = platform_device_add(qtee_dev);
+	if (ret) {
+		platform_device_put(qtee_dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
+}
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -2326,6 +2450,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	ret = qcom_scm_qseecom_init(scm);
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
+	/*
+	 * Initialize the QTEE object interface.
+	 *
+	 * This only represents the availability for QTEE object invocation
+	 * and callback support. On failure, ignore the result. Any subsystem
+	 * depending on it may fail if it tries to access this interface.
+	 */
+	ret = qcom_scm_qtee_init(scm);
+	dev_warn_probe(scm->dev, ret, "Failed to initialize qcomtee\n");
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 0e8dd838099e..a56c8212cc0c 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -156,6 +156,13 @@ int qcom_scm_shm_bridge_enable(struct device *scm_dev);
 #define QCOM_SCM_SVC_GPU			0x28
 #define QCOM_SCM_SVC_GPU_INIT_REGS		0x01
 
+/* ARM_SMCCC_OWNER_TRUSTED_OS calls */
+
+#define QCOM_SCM_SVC_SMCINVOKE			0x06
+#define QCOM_SCM_SMCINVOKE_INVOKE_LEGACY	0x00
+#define QCOM_SCM_SMCINVOKE_CB_RSP		0x01
+#define QCOM_SCM_SMCINVOKE_INVOKE		0x02
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 0f667bf1d4d9..a55ca771286b 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -175,4 +175,10 @@ static inline int qcom_scm_qseecom_app_send(u32 app_id,
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type);
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type);
+
 #endif

-- 
2.34.1


