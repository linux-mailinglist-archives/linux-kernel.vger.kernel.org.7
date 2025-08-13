Return-Path: <linux-kernel+bounces-765708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4708B23D25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9231A20AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019681A23AF;
	Wed, 13 Aug 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSrju8JU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D41547D2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045427; cv=none; b=X5LMpR0D4mZXdfMeAx8J8c30J0L9Hr6jgLzSzj92bxP9Sc4fAbkNFWNf0aeCllU80uXK7smOP4Dvlgi0YqeYUdHpokDtU7IJDz4005W3VoCDpgKOp68bpTqbRLk7HZcxyW4eUVJ7TzbEuTMyIm1n4yTABYA+bQ/iu3LRE3gyXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045427; c=relaxed/simple;
	bh=mt1SY7lqZqYnHX1E1eZtjcGPUdWHsqyRxnqhxA/coPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtzgypawNYRgoY3I6vyKQdHcvh6qxNjuAeJE9r2MurQ8gd4+X74hhMYQVXZKOHC4J3mopSTvkIjcUJnHsyAyN9N3+R1YuGrCHwH6TRcegk/8Omo6aqY8ClKr5wanclMk4MGT+9B2RRULHbNcGVxhzZI9KVij3n8KASFRfwZJVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iSrju8JU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKRD8Q029531
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dkpk3kW35s+rQ8xADVAl+s3707K3KzYCGbupLzI7XSs=; b=iSrju8JUSKSLlTzi
	i32ZJqSum2kUg6GDGgcVFyJZrUyfoDf7u1dMyiKpHZFKJvOdelWsqzi+1klf80y1
	HzJ1o9eeIlxAMFuXF9xPPxNvGrKCpxMW0fa+CmtKPcEBiMEz9nlGvgcvxowZXZ2b
	5559nNS6vYIinQUdFA0Xj3K97+dZvqck/YBwCAcbrGyFOHVAJERmdb7jyPOmww+u
	fdQ5aUSfGly083os4RzSPtfh3m7LHqwV4YldA4QidIS9aaqLywYD+NzDmC2iMGdF
	8VQFQE+gmJsRXHcYHGXtcfLBi2lQXdQw1IyDZtf/ihab3nQff8BXiRq4pQ8VRsIT
	ocue8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g9w6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-243049e6e1dso17612765ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045424; x=1755650224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dkpk3kW35s+rQ8xADVAl+s3707K3KzYCGbupLzI7XSs=;
        b=dX+qNLseCQuhx1lYBqdRxxubNQU4cRAp58jzj3lTlomug3enJWc9ngOJvU8nU/wEC2
         wtfQPx+I36sDGx227ZhemrfZ2Q2aUsw1ruuainNHeneGNXJ8GEIcr/UB7IqZHdf2hTHr
         kMpzmCdjnNXuWj6Km7/00DzsBTfP+b9tLvuV7p0in3kaZrS7T8U4xT5vq40AJX1Nx12x
         ciC6mqpaky+r/1eEF4KzCoRbOCmhPvnJJJUF0JUs77Ck75On0vIOgZ8S0C6g5HhB5Fjk
         mZhJENUKN1w55CDBR/y+JGYdyF3TVX4Tuiuu76i5W1V5PNidIxbdxjRYvE7Edq+RXSBr
         M9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVygvekwtwK7KHlc+UT3ZtS0/Q5eXcIrX2TSVMAKPWMGzdin4H6GpQe0JNfDX6aQQeUGCPPsVBRRvcmQvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDgIaCMm/cgVgA2HNXzupfaaMhYsR/XiHQYhphxl6C83OVSMt
	ZDPbFnURhZGIs0QRIKaW7FW5+u5a121iJQZDDpk8zI7jWus/HVLh1y4aAchL+z3rcU19dzL2lzE
	t2BsvXbFuRv8VPJnhYuYVDpMTUfZcDUJBGMIxLcHVkh0rSn4d+GSFUdVCGB3RxN/Iyg==
X-Gm-Gg: ASbGncvEH8LIT5qyej0ZfOpCjdGOwvmvRP838/rAGAgpxezM6qE2N8Yur2VvyHqq6ZS
	fvfPe4fAIBV9EUHQegoCrJUwewz1EFXjE+8V/26LEK4pwOJPGDzYuQ6WzhAoR0rSLPnMXJg/uE+
	1lVxwPQR8sJJvngtuUxESWkHVuNRjpUNhBDfdizhFoxID3RGgwcjLzg8eoFTx3c0zS/5oux2ohc
	piog0DkO45DPDdMb3AHaul/y8a7e9Uk4oDlUzfbyzTtm0y7etATTrvtUjDLIyTyDkT4wVTHHCir
	k+cYzXq/6UzqfDzYcClUJvyyuYT949DdqwlmrUMjhQ1F+b8bhcgG4B9z7stOAL/Lqd44fUITHgP
	wE9Vgkx8+d/BBzyguLtIaUCg=
X-Received: by 2002:a17:903:950:b0:240:1850:cb18 with SMTP id d9443c01a7336-2430d21d9bbmr14926825ad.53.1755045423883;
        Tue, 12 Aug 2025 17:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlF2c43SwSVVhWWTZ6CHor0ZMj81pLl/B1nnCfA8wdytLkLOsLfKHZLinf738/FTtKf4T0iw==
X-Received: by 2002:a17:903:950:b0:240:1850:cb18 with SMTP id d9443c01a7336-2430d21d9bbmr14926445ad.53.1755045423391;
        Tue, 12 Aug 2025 17:37:03 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:02 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:32 -0700
Subject: [PATCH v7 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-3-ce7a1a774803@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689bde30 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX5d75V0ygn1FF
 a+ZTQ/XZLzaC/YKwi+sj/Eb69CfzfiMRdRABFezH86LYd0dEdOsTzDGpSN8CSoqlZTX9C/y1C5H
 Mj3zVK5EbPYPKOmY2GAgTd4GAuGg5UfAiXKvbCIt/0zsxQn7/V40BCU80AllyzOKGTPrUB64PSs
 T2qSymwyFiPYD2RehKLeoafcIDSvNVvIV9rMNXE8J2pMuxmPiuFEUTRzrdCeMgNIZnGWa15TOi2
 IEsnq1S5vsk7crNZwY+YaelOyytOxA5Kwm2LkLVsdEneHUbjpQCK+TRCMRQ28E4/EdJazM0Db9Y
 XHFZQ6czAjWCutnM967puI9YnWLlw0zEr+71QmK1q4ocktShHo38Pt7RW17qNmYTOiOolV6mVDq
 FCZkqm9O
X-Proofpoint-GUID: HBCYfPRa-lybG-wuX5TuFmIAU4s8Q_Ro
X-Proofpoint-ORIG-GUID: HBCYfPRa-lybG-wuX5TuFmIAU4s8Q_Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

For drivers that can transfer data to the TEE without using shared
memory from client, it is necessary to receive the user address
directly, bypassing any processing by the TEE subsystem. Introduce
TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
userspace buffers.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 include/uapi/linux/tee.h | 22 ++++++++++++++++------
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a2b365bcee51..b84655b47256 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -387,6 +387,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 			params[n].u.value.b = ip.b;
 			params[n].u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			params[n].u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			params[n].u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -455,6 +466,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 			    put_user(p->u.value.c, &up->c))
 				return -EFAULT;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			if (put_user((u64)p->u.ubuf.size, &up->b))
+				return -EFAULT;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
@@ -655,6 +671,13 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.value.b;
 			ip.c = p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			ip.a = (u64)p->u.ubuf.uaddr;
+			ip.b = p->u.ubuf.size;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -757,6 +780,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
 			p->u.value.b = ip.b;
 			p->u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			p->u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			p->u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..78bbf12f02f0 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void * __user uaddr;
+	size_t size;
+};
+
 struct tee_param_value {
 	u64 a;
 	u64 b;
@@ -92,6 +97,7 @@ struct tee_param {
 	u64 attr;
 	union {
 		struct tee_param_memref memref;
+		struct tee_param_ubuf ubuf;
 		struct tee_param_value value;
 	} u;
 };
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index d0430bee8292..3e9b1ec5dfde 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT	6
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT	7	/* input and output */
 
+/*
+ * These defines userspace buffer parameters.
+ */
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT	8
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
+
 /*
  * Mask for the type part of the attribute, leaves room for more types
  */
@@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
 /**
  * struct tee_ioctl_param - parameter
  * @attr: attributes
- * @a: if a memref, offset into the shared memory object, else a value parameter
- * @b: if a memref, size of the buffer, else a value parameter
+ * @a: if a memref, offset into the shared memory object,
+ *     else if a ubuf, address of the user buffer,
+ *     else a value parameter
+ * @b: if a memref or ubuf, size of the buffer, else a value parameter
  * @c: if a memref, shared memory identifier, else a value parameter
  *
- * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
- * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
- * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
- * indicates that none of the members are used.
+ * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
+ * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
+ * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_UBUF_*
+ * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members
+ * are used.
  *
  * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
  * identifier representing the shared memory object. A memref can reference

-- 
2.34.1


