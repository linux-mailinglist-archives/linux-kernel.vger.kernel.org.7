Return-Path: <linux-kernel+bounces-809184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899CAB509C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FCF7BA758
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F321DA62E;
	Wed, 10 Sep 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLIlzMND"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B41A275
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463090; cv=none; b=dYZZRyKyAPiMNv2gwEUkRgJTm6u086xpade38XykDXd2uPytWOBmZ5wqHNCh0Z/zoFXHjga+Zn6jQLaLQcGm5QO6kjbsj69WuqIM+o5rvVsZ8phjkOodBBYiBcmQTot/oBbf1/TBjiyccoLLeo6d66rFs/ukgDvupTb2eZ/mnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463090; c=relaxed/simple;
	bh=sh07O4YZIr6OH/f9rqWASPPFkuLSDXmilsOY1U6tBTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJKjuIQ8PEvigTqdxRqsQ7RE0SfQsfIBjBevY5TFw5PN5nLiDR03cLYVpWGkv4sidR1QiFwCs2hjLjT0w8XkDOh+EoKyPwa8ul6kESY+Kach83tMG2Rfq/Mv3VgsIZ+5PyAfkEfmqTzlSHPJ08tJwweMO7jOeBr9c52bb7ACTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLIlzMND; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Hx69a030478
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exB8k5oMv8UirS+TCY7pH521pSkqtyclXWflYWec7IY=; b=dLIlzMNDYMfw44u0
	bCyKNp/VtMMkS7y9zBKLVjNvnj/66Qa2wWsRhbY3XBdrW69vWH1iRDWzuKlutlTE
	nnEA00VW9fAyDo5Pb9wBErftHOU9mZAthFOpXrCIph1DVWApyn2hhmPb46RZiN7v
	Luej5cb54EX6Lo0QdgHwIwAPGHMaGESqhf0VaknsuxwteDjPF84jW4uML6Gyp4xW
	a79hXYGkz/xdUpcjYaS3c7tXFAP/IPKy//o2MmVl9t1RqXS/Az6X1vkVWO2pf/c1
	6MkkoRp7zUop3RsHj8qrLFUm4QMdQzw/7aA5FGUfXNaqWapDdF4OA+8OZISO7B/d
	T7dR7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9ja3sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ce3e62946so86570505ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463085; x=1758067885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exB8k5oMv8UirS+TCY7pH521pSkqtyclXWflYWec7IY=;
        b=BowYhdwO7iL4fHykY8MbgOOxAn3KTa8ys8pN2cTnbcdw4dz47A2aGeQiUfvkdSp5CA
         HV9hnEbV9a3Hn3h3tZF4uq/c1LbuTycBHCKjEiQjCOSRXL8II1PGF0of6fIke0PNkVmA
         NNRyzE2snqy4FRcawmSG5ggxnAswK3BeV0IG/U78oyCV3JN0I/efgOrd38cMFhwJBeOK
         iUoQDt6Y5KYu21MKOrCVbDZzg06PGn31Mu4HhI7727MwClJg8GtByl6Qr8Ul19EsH3uG
         zJ16/Pur0s/aSUHtSk47LK3waCSUqxyFFEqbjmkacI0+o8sXa70q/NLtWJbghHjdfVvq
         QC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnjvOHgqPS5i5la5UO+rOh0S3u3vzsJFcBmYayTRg3DeofqptANX7ZwjgpWAJ4Mh393A4PhIQ4r6jkhqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+8Z3K3OeToYb8+8UU2zPN4fcLjs2bQRd7loN2I2SvH9cKE16
	hBgdHG+61cMu3vczq0sJqoDcVJOrcojrJFUZq+JeGHcCIpinyeRRNP8sH8yzzcMyOq2pm+YKVZ8
	E+oVbCev8DukYYUZam1Q1nK51z+zQnGcNLJ4bloj714yHzMm1okpTlLmfZzzb21JSbQ==
X-Gm-Gg: ASbGncuj/yO8r+tlJfPLBUwooyA81pEbqkzwg9MQVAZLftqzfDIWWZ7+ko1bo0KBkeL
	iLHn2KanlvuGLJ9JO0vaIiVTfRy1GIItszmxUmpdOvIrMT7DZsu7bIZz2+kTqdklkKSMBV1MzHo
	eTy/iNE4kJMYrh3/qAXtK1JLast+Pc6ZcgD7knUGd45TPPbEPYc/Ekh2FrTWBb2Bd6feegHPa2e
	53nTu+R11HiKReNaoYLhSgfcIjX2LfPh40fV5VgTDcNC1Vo61b1jxmfHiz/LYpsx0lUiYx+tu6O
	ESCS2cjRkR1UfPnpFmYsKEwy1xg/4E2kY7K8U9/IMnyouya7kITdC/pJ4r+W2VfJHcxRdXJnzRu
	djqlNAtz0dF+hvb979Dp943g=
X-Received: by 2002:a17:903:4b4e:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2517076dbf6mr186157455ad.25.1757463085166;
        Tue, 09 Sep 2025 17:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ54oL9cjzUzS9diW9LH0ekE8ynSMup+FS5e6hprfN+E8ItijM0s3AepbqZRGXsMgGRrJ9xw==
X-Received: by 2002:a17:903:4b4e:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2517076dbf6mr186157005ad.25.1757463084656;
        Tue, 09 Sep 2025 17:11:24 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:23 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:07 -0700
Subject: [PATCH v10 05/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-5-20b17855ef31@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX2Th1Pq/x/xx3
 mmJ396BzaypsJIldOHetfKbvHDAJTS70nxojrYpEs0seSCYmahpr4APXxzEowHsmXxDTQiH+SRi
 U7DQkGkPM1GP4zB+DS5w1FTFJ0lkeams8i8mOlS5IcommfaoMZo+WwwCRgc1Y7c+RC66OvkZRq0
 e5lyAUx6F8Cc51nV9kxJda2awa/8bMNP9IlpWNxS/iLiMpj7HFJY4dQtw0WAPtPpsQnbLitMoIp
 Ir5Lo96No5O7HW9/uBsu7FcRH95tzTVWEFglDFRwzznxyz/BesQoax8yTv9Wq4Jt5N3EDu6Oy5Z
 vasITHzdJ+85+WInPUxMvPTIrcrTx6cgErwn3YrKikF0t6T3xErPxTPg3WNBJT7eYTSG2oACoKJ
 9GmtULh6
X-Proofpoint-ORIG-GUID: ZKTXyBtvLvnhMNS5w5JE7f_6nHRFhoga
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c0c22e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZKTXyBtvLvnhMNS5w5JE7f_6nHRFhoga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

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
index 0b4c65dc14cc..c21f1909ed17 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -350,6 +350,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -418,6 +429,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -618,6 +634,13 @@ static int params_to_supp(struct tee_context *ctx,
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
@@ -720,6 +743,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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
index a54c203000ed..bec9a918b950 100644
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


