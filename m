Return-Path: <linux-kernel+bounces-729251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6FB033E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81CC3BA3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19F81D5170;
	Mon, 14 Jul 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJs0HsEt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58218A6A7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454226; cv=none; b=sogIeYXOH6/z9jje6raX4sxMDhcnthz/HybAGFlC5Be7tGd2+pJ/7ohlMhieopNyMVVaMVkInN6PCkiwh/MarGp5yH0bVEACt9npbzCWj09hORyU/mTeK94N9P0ySyRlHlGZve2VMoRKjUHnriDyEsVuqQ1oEiMODC6Oqboibxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454226; c=relaxed/simple;
	bh=yjYoGAD9MyX4aHdTmPfeHHWvzzmNNK3os0Di5d6Z2VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oIrPJO2sa3IEBqp7cB4/wkjMSB/ejs1l5bN6HGXsIKPEnxn7zROIdHUclDD4PdXIIIcNBL3Wqjy+odN8d40Zr0RNqwN1zicHvs5Yo2kxsR1B324LgYM+HVGgVn9ISAeYTQiRqkYatNm6LgVAGIg3kwjDXHFT8ANOvAsi4QiRvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJs0HsEt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMmOco011638
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=; b=PJs0HsEtgFHbJ3/s
	1Gn9ZT1UzOQjj8RO7IiM20BHTgn/ySGtOPjNW8uGY5zAQGQEY6Pvldv32IoPHh2U
	Js+7k40jxZFRcVEs4KJvzTFBh/EUiOuxVyLS4wsgGZKsCtYrB5fopLoS3GcpNBEh
	soQpDKZEhBolnEXk43dD3JWrt4Nc42Tv3FEXzytBUHJ0FEr0XyIV6BDB9Aw72THk
	0Br4pVCqOQlczXE5jdySd/IpdFWuudp8995zBgJsGgpCX82CxFCAkzOgzVb/WAC3
	rV3f8vnPJM0SojOH7Oia9IQvy07dmwoYcRvf8X0IXi18kO3odQf4HdBlZasHjbfH
	Omx6iQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a1b45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so2641658a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454223; x=1753059023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=;
        b=Og2koh3IOwMmX1qYmqDtpqxtvrCXkqZ/LRvEdGk86NWWHenPIS551BrJvPYy3k4bGN
         Zok2WHOldz9NjbfKUgQCJernMLAsQE1wMimEq7yi2Qc13/np1gUQD+TBuC4EH1xHrbYj
         DPF0UOzUyUKYwmWk6zqTi1Qd7sGBX3JA9ZZ7im4OKP1FlN15de+iCF0CfkZzdEXR4LQb
         jXxdIYsu27xMPGTH5jTu6ecboJrKoFv2QqTOWx4nBCc2jj/+fx6Kgp30aDAnTbX9f+vv
         3fnoA9O+19Is5FnAfYoMIdMO5n76HISCR5d3WZN+Z9eXme/VJXm8oXVkxWXkAT53rdjI
         CKFg==
X-Forwarded-Encrypted: i=1; AJvYcCXBU80P4f79lC+LSiGliQuNjj1CfbG0I/7wP6EP/RF65ZUrkwotJ3tV9WaKhmWg2zBXFQzVG/l0+gFGdcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSRjxOaTRfB2fzGbuBkVPKGZ9jBdZOrU1ZVQ8FaC6QYbPW6yl
	dc17Yd4W32Iszod3mwvPJwf3RP6a0JfdzQbF7YSCT1/68P7IMCup06gyDhy8K0yxbaUMA8Zb3cf
	OW0CwYvXn8J4C8vdESTStwZ7rW7zhEbs/Yaw9mwRyrSVObmDQ/UlGa2bduIPikZWjshkSme50Ls
	Of
X-Gm-Gg: ASbGncskqoBKu8O6ZCD351q6bNUBqbrDahiVO4hucnx982U0TAD+7Ad5xMzARAjOVAO
	gW+O5+pWmAo/mWldjQ4cq4ynhDyMRT2DYSkgzXApK8Lv8l/p6Bp8o6RZQZ3+nwSiW0n7cHAQKw/
	ckBkrYxu95UxblazlgaeHia5lRU1S1gmLRqZ18U1eZ5kdapt5Qczf/2EQ6UkUWfQs63xvidwiff
	q3H/lJDAGSdi4FkUXY/T+Fs2BoVHZpSh52WcHx6TlRScS3dz5B6d7M0nrtm85ahHiSSluiSzqUl
	KSl8Aqo2Ag5NeifzRAbtjCOaQkVkTUwoCap2UCkz2MKsoJ7GKMwT279R+kDtud4Kk75jo6O6YTD
	wo2YOODSyWaAGshy9bSO4d8s=
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639555ad.33.1752454223094;
        Sun, 13 Jul 2025 17:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRvCzZx5+d3JANtyF1yGNZHHvelXYTT1n9iuGKmxng2HkXNTyORmuj/a9u8CgR2vAWn3cpxg==
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639265ad.33.1752454222644;
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:15 -0700
Subject: [PATCH v6 03/12] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-3-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: IktZOO7yGV8ZaRt-HZg0QzJ2k6jVozFY
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68745450 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IktZOO7yGV8ZaRt-HZg0QzJ2k6jVozFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX36XMRl47mUeQ
 nFcWuj88QvVyLfqkNTmPb7bHcMqg2D8iqu+jlaM7DwulGUyz9Ih5ThJSgx9572uETsBqYFF7l9X
 KnFtv3bwghy22bZ+oW7coxEN+EMabVErIQXoX1TzE+JqxmUBjvoEXnKvPmp42bVmtaZ0X82tMr4
 MqtfO8YsEdPJo2ZiVWpJYJKuVH7LMqPsz8Lt20t6dxwqawuOaxwQCafWUGyXzw30dtQWQgbfQzN
 3STbSli1KFBwf1mEpvGI+nc7waki0e6HS3//l1R6QHyngotflB8VEJe7KdzrLCTARpIQFOt0IIC
 e/tViiX0kP5qPVMjMkYwuA/31E/iD6Bgga1wqpaB6wvkgy24LN7A/5pRIxeaC/RG2p3p8RuQTBd
 W8KPiCiaXnvA3jjyzLF+tl4lEEnK434je/OreHwxKBq7FSzs4mrU6TQ1tWH4YYgI1irx4Egi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

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
index b9ea5a85278c..74e40ed83fa7 100644
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


