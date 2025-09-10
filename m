Return-Path: <linux-kernel+bounces-809181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1F0B509BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9E7B9DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB3136672;
	Wed, 10 Sep 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqZ857Gr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77C35961
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463084; cv=none; b=S7tiRpw3KRyxfud/+hW/g3mnJw26kA/k6kYBnt6m/5dH3hQPywJnxgj7KsssDDbBlg6dTKkCpiowX1+AulDlV8161ob46KD+KWQv8WWusjR0rQ6GnNi5nlZeSp/pIeo29YbUE9Zj4Pe9vVAzeLAO6F9U7qG0aCfnZC60l0eiDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463084; c=relaxed/simple;
	bh=ZRS6JSqauRlryJc3bfvaAzYiMZgptSB3VgRLdbw/uJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUrVaOyhhM/KxCn5tMIZcnJIIHDUfmy5pxlikQDRJw6p85ThKajwtNPGmJ522UnehZ14qH8awukr7IKo85a7lz4UshXycoLi+4+HoAoFSUs/UPmaO6ZHwo4GYHBBfURlJbAloxYFQaibctGjRC6XLL6Sq/zVI+998WAVJ2yY9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqZ857Gr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HQYPw020625
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8jY2HwwgMRulTaAiPVsU/MOC8fxFx36a56qnT/3OybA=; b=oqZ857GrknySkiTP
	8OxQvZv7gcfyhtHQS7R2+iIUH5KQrb9FZaRkXoGFXed/+orxuB4r1BoDPrRBb/7m
	wjE5Q/ED/OKS2EbhGXfR/HVf1R6Xrh8yPpMraSGZe2BbtAp9nmrA/is6VG1RXILZ
	AISMbpB89/SqqnfklD5E2/C1PwMbEj3R5ya7+R2tl3U2hV2qF+PYQaGY/gyILipI
	JxjbEgoMuhd5HXEA+H/zHYMyvuzGE+n34Mteaa0JV8Bi3mRQnxIGO4SzptCtNpwC
	9nHgzoS7nX3XiYv3JO9wAqAuePCDFKzfI3WZhSGGzacVUigwcpBz5ynXP4+P/J1C
	hcxDVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a9x4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581ce13aso127491545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463080; x=1758067880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jY2HwwgMRulTaAiPVsU/MOC8fxFx36a56qnT/3OybA=;
        b=MbM6JUjGwOHeeq59rSFIb+ODpYeEzysZRXPocf9VajSfK1iORel5sluy9Edb20C1Cq
         /XdGSKC0DaB+/0BYm/5U/atgUq9tnzQOXtx/KYf8YfKqTEoJ/dlY2s8y+ZxZ2gzMi2pb
         WPM1KxA+NoF8hMqAlCivp2PQyxQ6mswX+NPEI+IkiRVYz5yW+OSBtFWATBQoCgshvuX7
         tIjUpL0F7odXhpe33i4CtDDf3TKrBsguZ4bUMiD/be4XXGSbD5uZbJ8a13fqNR878NB7
         szrcGyXsA4e/2MByVVHH09l0CZWyacifZSJzt3RBDLAAL39iyAhSoPDdQeCQpsagEH0j
         MkPA==
X-Forwarded-Encrypted: i=1; AJvYcCVwpDoYGPuX33CarFlTWAeeTdqxWsykGdn51lW2YjLw9GCGaq/R8dXwyprvzcjEM+PDJQywoLyKK9xlG08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oK0oefvjlNcpcV8RO46cFLQ0Unc/elqcI8E8DjjTT6sUvwoe
	tIlPQwoquGN2wMv/quNK28//gERAEo88ZZ4XnigmOOb3r8tv7y9jDKo0wToWeagF5flquTdWSJY
	uA3++u1LhBlcNx32Kp2lLP7NXK84NQ/DyIUcoXvJvZcXLVkmuuHY9llChNE+vADEvGg==
X-Gm-Gg: ASbGncvUAUxHUawY3haYdUJLfYhHJzbbwh9igSQM1AbDqD8iFvVPdQWBiUw3nGmrIYX
	EOpOWHd1w25+gbKKbngv9uQWgmdrRfR/SRhT+mZF7H6MLKjCgvpCBphoGGDmmU0GPaZd6iWtEse
	65tyxUPetzixqnevKHXXXj4bSPtJdLCDDM8SHbbzugGtKpWTMhCay/fAXljQmA+szWeryi61uj8
	Cg1NkdHC3pokr0cgpl5tQjjLLH6HslzgTl73I6CBLcHmlXhai1uUPPB/yo0Pujzv4u7pLQwkcMS
	+5tFuvDdaIpJOZr+WdCPYako6nmqhHkMy+QOMKwxIjS/qhG7Sr5OVSJCukdpV3TmPMOVux1A/8Q
	K8Xl8don9MUBKgGjzYA+7+qI=
X-Received: by 2002:a17:902:d490:b0:24e:13f6:23e with SMTP id d9443c01a7336-2516d52d43fmr148372385ad.8.1757463079810;
        Tue, 09 Sep 2025 17:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM6XHIQCW29yMyzTDh4Y1gyHfVNYY+raVtASU/ynhT5cDb+vK6J9J7gdFDyy+k6kWU/N8gtA==
X-Received: by 2002:a17:902:d490:b0:24e:13f6:23e with SMTP id d9443c01a7336-2516d52d43fmr148372075ad.8.1757463079246;
        Tue, 09 Sep 2025 17:11:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:18 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:04 -0700
Subject: [PATCH v10 02/11] firmware: qcom: scm: add support for object
 invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-2-20b17855ef31@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c0c228 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dBYAKgxw8cyf2mnx-aAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0c7sWn4xuZAgXEirVEJVXytFO0ZLrqTl
X-Proofpoint-ORIG-GUID: 0c7sWn4xuZAgXEirVEJVXytFO0ZLrqTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX7/W7/MiTCgz2
 kb9BovBh7FVhAuEvqr25jsGrAZGJ00SRzd8gzUceDifHbAcEv1Z6epazzz+tR6UkJ9lmBU8diK9
 w0l+F7WEH999uJgZDLqVubCuG6ubsI739+0yBGrlunf2jiW2pde5tF+4DKJ3ZwGMg3zaYweWvDq
 BsMcMjHzTvHsYvc4GpFCibpeN75bTNZ4VOxTicimuAKcjS1WPel8q+UKmHFthg9elLdWz+9Au9A
 03O9eDemMJ9/lRlxzjrHt2aVJNhcwcrXvYq+GkR1RdBJqBtcKN7HQYGRq0DlYKcGRKDggZrNGMA
 DaovK4MDEqaiEt8ce4EYwSK7chjx8SrZNg+tTilLQbZy9fuSCZZhos2N4JC2aiDPdoaQ+dZUg5U
 dLr+G1vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

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
 drivers/firmware/qcom/qcom_scm.c       | 119 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   6 ++
 3 files changed, 132 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index edeae6cdcf31..948f20125c8c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2094,6 +2094,122 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
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
+static void qcom_scm_qtee_init(struct qcom_scm *scm)
+{
+	struct platform_device *qtee_dev;
+	u64 result, response_type;
+	int ret;
+
+	/*
+	 * Probe for smcinvoke support. This will fail due to invalid buffers,
+	 * but first, it checks whether the call is supported in QTEE syscall
+	 * handler. If it is not supported, -EIO is returned.
+	 */
+	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
+	if (ret == -EIO)
+		return;
+
+	/* Setup QTEE interface device. */
+	qtee_dev = platform_device_register_data(scm->dev, "qcomtee",
+						 PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(qtee_dev))
+		return;
+
+	devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
+}
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -2326,6 +2442,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	ret = qcom_scm_qseecom_init(scm);
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
+	/* Initialize the QTEE object interface. */
+	qcom_scm_qtee_init(scm);
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


