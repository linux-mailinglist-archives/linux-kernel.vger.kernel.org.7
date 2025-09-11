Return-Path: <linux-kernel+bounces-811303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EDB5273A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4906883DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87826280A;
	Thu, 11 Sep 2025 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+DvGnqv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7925782D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562096; cv=none; b=EptvqRcArKptGERWpokCDxlM3SyYXtMi1dOiiCWLNeFKA5Kra0hD2XmBf+Bt8sJbYku/lstAfZ7RYTJqe5G/BrDcdN8qooCR0UdvpvNRwN+qn1JwCd6nwPDfGgXmL0Rx8AcUxEXv4vHMMu8+E2IV60hlGB/Jkd7CjScIiUYuMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562096; c=relaxed/simple;
	bh=J6gPADf+14CBKS8ZXGs+hL1MfQTHtOtZsIKENSZL1/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgY9PivQSCXt+UjCPKHomilqvouCeAtdc0TpE73Feyk2cnEj92lEaomcew+NWd7wrGK0I+f7U2zaY1302HkLTKtlHyxx7OCXbRyjChN+yJ9dS5h2vS2ew1B4htcepw9eYlPFrLbAiy9w5cH1rWNF7LCP0kbkebOJ0kjbx/3TscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b+DvGnqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IWHA015064
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OMgYiwriuoaEgjuQdAgHOp5QH1z5K2+Oz1UIvw1UFeo=; b=b+DvGnqvnCv/bKgq
	grwBl8YCaRiLBk+eMJIJbaXRVS+ip7RQxm3mj2enZN7H5TikYWIbu3XXgRvbdQ1v
	gEMUeIUZvx9LM7i0HyckrOJ2otRTfPMaVWn2FeOqGHq16+00f+IAS9vyIVbpLiFe
	Jh24NsLSpXu6xTvAUhOu8usDgS8hHJKAUHoSpH+UnaAhoDBth2ONDo58S/AJRld3
	WiR4UE9g0L+4rMAxxblRGDTbpSWILA8VCdcr/sziaNlA4rhhpjDJWwF4QssBsN7Y
	NYtPmgLmAmG9BT0Xuf7CyVhkUipCnmJZoL1kaDrK1Te71UbyDWZH/Z+UYL8aR9ez
	aaE+fQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m61h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ced7cfa07so3043835ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562093; x=1758166893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMgYiwriuoaEgjuQdAgHOp5QH1z5K2+Oz1UIvw1UFeo=;
        b=voQMBvhdDS/w6ajtfgNa59LYRMQF0I3O6bP8YuHI5yaal5gSTl40T684EsEbMCb2SI
         XV0FtTA/fedhZ/2KBx4X/0I+1SHFMfTPJhXxvSPzgvQ93LEhfLr1NL/zUtuZoTA6g4Uv
         nD8oOULANJ4wPs6lr9RTHgLGZazWL2XDeU9eHrdD/77PaRBwkPMF1fQYnhnGkqD62MXF
         lJugtwONnNHNdXEy7UusU+gMMni1MiowhCs64vgwykbfsh+YeShFXtDyyCDH512TK5Kv
         lwH+jJvWFMl+E0e1uCoTFtvhkJjwON6MLDMMkm1nrMxOUT9iDGe3tPsMZSAg0D7Z/kuW
         l3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVoKD9xzxXU/UQrcNh/LjVeDW5UD1bCG7Pu6i1j0MwbBbNwlIvLHOL8c7hwjol+ZfHCyLZJvPhPb9TfRYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkvvyeT4QLrnSq8FmYYGpkGmJb4j1U/MTumPRWpSKlrojBMxp
	kYhQ8KbDpAvnhsIOJPFIXXti9+9T3bRsA2RaiOeg3Pvrew/q2Y1A1ufcry1sunQuKaOsXE76UPo
	MPWJ6LEn+4FSiBEEDUr64AIvh+11zM9QKNtQQIkIitB2mFsu3qaLCNIjhlAPWESaVaw==
X-Gm-Gg: ASbGncudFyrA/mUBgt8Pen4Iu8HZSascPLNLmFjHbbR+oEmn6mUlkBGldf0U1fxu5eW
	nQc+DdxFjNlcuWODoTASTcqzvtVkm2sH4ci6UbeHgN88ilzPRE9wsF9q03kanjTBTwYIiZNAuhy
	UfVDx0gvnLIZKt6EMg1RC8iG9h2+tvPsBzIDnqXn5kL2viCvo/V9xtREnz2+bHhLOFgpdGUBY4T
	Uoy6U4XaWLxiGDDXThe/QaaWxquVvB8Mqp5H4b4xS1L23XjyKT6lWoGzZcEXnPSxsydqLtox6Vz
	UQinr3/VJxMN3ac6+9bv1VEUYvNfYVOwkQMjC0qSyamjrNy8LIUEuTPrVJPBgxNBZYxN1Dw0OWm
	gifTJHhxTPhO9Kx9hFI3l/C8=
X-Received: by 2002:a17:902:ce89:b0:24d:64bc:1495 with SMTP id d9443c01a7336-25172e32f31mr234654895ad.41.1757562092559;
        Wed, 10 Sep 2025 20:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2XBrmFI7DZlf4E83+SRzoCLNep0uvy22/JAq8l7UDLF3EEcfP3TLMWQ4bKAYhHUdaEoQscg==
X-Received: by 2002:a17:902:ce89:b0:24d:64bc:1495 with SMTP id d9443c01a7336-25172e32f31mr234654575ad.41.1757562092083;
        Wed, 10 Sep 2025 20:41:32 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:31 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:18 -0700
Subject: [PATCH v11 05/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-5-520e867b3d74@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX0ID8/U6JN9HM
 iTGD5IdTPfbTfmNrTdCtRiBU0cC1A0T7S682nbvdfUA50C7TPb/1u7WPve38XC+w9oL3KK5Ff0P
 xbT/9h9l3ilZJyl0KG3UA3E2kk5+8pE3jIxPq65ScYXeVJKrsFeqYQYj1GcxVd4kRvVlPu7AB3+
 l3sGYTFYp5iZ2PmZcsQe2T37dW/e1jWFLU7oEvnma3lODHN0VqMw4QMyP+RtVms9AM6bVb5oaPc
 e/RSZ7a2OHgGy4zjkJkm0p+nJ6yXn3d5BHXzaQZVMBnIUCaZcS5ZSrxgnKF2rdxtAoeVlXiU4+J
 Us/KR7uWG8TTAlpAs7d/uOIkiKSRUoNBwvLLU7G7tUZsi72xf8r7MePiqCHddFW8716EVKK+j1m
 JRKcu9Gd
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c244ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DUvdZHwYGjlxdXM49qUB_NrZbPou-RXo
X-Proofpoint-ORIG-GUID: DUvdZHwYGjlxdXM49qUB_NrZbPou-RXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

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
index f8534a00c56c..bb2e3a6c23a3 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -457,6 +457,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -490,6 +501,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -690,6 +706,13 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.value.b;
 			ip.c = p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			ip.a = (__force u64)p->u.ubuf.uaddr;
+			ip.b = p->u.ubuf.size;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -792,6 +815,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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
index 824f1251de60..7915e8869cbd 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void __user *uaddr;
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
index d843cf980d98..0e3b735dcfca 100644
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


