Return-Path: <linux-kernel+bounces-813168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1EB5417B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F911C87575
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE727F015;
	Fri, 12 Sep 2025 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HDos/34I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C22773FB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650079; cv=none; b=mslb9oPIMTMuvgTVuCrU7QloWOxzIg8giKUDlLTjGZMKUipFHsZYSFOvHefrA3N8FG6kt+GlyIpolseJAy/qXSXNzuBzhUZCHKAsNnEI8TBxWRU7P+jIaubTz6cgiXLCTZO+eItBHumqBbEsVeksgiS3Vr9MyMldoEYuv2Jizqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650079; c=relaxed/simple;
	bh=0JhgAW18zDHm0BoGjWrA+FEp3ImGC4XhwsCQWuaWufU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfjuBuS07lxyqwvcv+pQhB0M86bKlVKmzI90PrvENhZrv7F13VS2AWRYkijfBBYKRAwwPSBC0ndjsniijEAMevd45iqqyOKg6OQ+CUOFZ2Inqnx1mQAoEhUJZxww9PGejmlYq8bedKH2ijwtFQ2zKPiang0hjgN0K1ueLu4hBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HDos/34I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BN5Su2001937
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZfcfgt5tkDE8WsfLwhw4yoKfImru//GWr+MWDVBGxc=; b=HDos/34Ip3sG+PrD
	XwJ2qySCUJTqJmQhPZtkB8DP5gSKdySdYDqR/u0JgrzAFDr+Vev7Q+vwW6lXqA9q
	N1gHe0tBVZnQx/oD6yTrib7rCyzXWPJSfUk21rK8kMmwIBG45LGIbE1i/P0WFj9p
	z3Tj4//3KHadv97ERUbLpk+ZqAsChNvs3MI5148N53H6mX9pORb/dtt5vWJvk3e7
	qzJiuyLUnuJlVTE5jNhKaszS3nC2NWg3AB9mATeDgwXGgG8P8ERdEISDLP8ozy/d
	GMGxRXQEqixFOSvVdDSlG3dH1B2PtK6LUxZgdTzzOLQwhXuqfBCJpfsH1wR/WV+y
	qTOJUg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493ydv2ayw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c99bd543aso25145595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650075; x=1758254875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZfcfgt5tkDE8WsfLwhw4yoKfImru//GWr+MWDVBGxc=;
        b=EptWWuBBfUM9wbkrOgXTNDsDmO68mfKWVHrafAUxN1VJfj2GdfGZnxo9ofz81E3vy/
         4SA5pHMBJK/Id4qTkHo1cN6mG2YzK+og7OVmGuKvrVxNChOzwF7fMgB8UwYjjYwn3o71
         adF6dMCBbqq5zzBhrQvQ1No/NIII67Ec//BHE6tNa5qmuZW96bHEm8YBfexvU+h+BnrT
         h1i7daGkQM6uVst+Ir0ZcepsZPhz4es3rOr1MKmevcfNPClZ3Pn5mqk3HCon25LIfVax
         1sd5PjRf1W/7f7ZgNnJ3By7IDa3Qqz9sN9MRJaQjF9QYCP8zZOFeK8icULRSaIoq2+VX
         fO8w==
X-Forwarded-Encrypted: i=1; AJvYcCWb6vlquvzCmmwZd1pwICNDiw6TH6HIYPFe7FD6GKq4npkjqBDuwNFvuEAW1GKDKiO/8Cc0/JEpVR6PPas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbzTkRbdGgW7MbJekzyOnVNDp7STRSgnf79KG/cXcDE7h110f
	lW1XjwjsKr7bOVyBXLmyMyDrPmKWBJ6bcutWzJnedpoCdonzjm8GO7xgzUu0aroHocWUy3OoGF1
	XRngZkZycwC/wyL0P1gPCEDVK7PtwBRsdFWpQHXBTvozKtIsk4Z4S0NQFdKAO7DYt4w==
X-Gm-Gg: ASbGncupb3+D5oD76LV67M2qJEbzoSRSRFxS3KTWlGsDNXBc2drqzCrx/h/dEka4e0z
	1Hgom/bxPQ4ASkspUYCuTGTM5/gIJ0HnSBKMIKAm9tsOBu2Pm1OHxslTPNZXukhuqBib+zaAQhk
	UPoxmXWlRA1zQJ3SonXG3kIVTYtsXReU58l2+IQk8A5k3nlxQtFh2vJQ8iTC7fAhVbHod2Gb0S+
	FxKCV59Syt5EwGBbZp9vLGFwQ5NjN8S5/tiW/Mhv3sjilluO+qbAR6MCWx5NG7tznXPgRWhsbNt
	TnSeOJrRjFh+d+/scRhqnFwIUYZV6aLHlsElMHzc73KsIPKg3Frsuy4Z+xDCE1l4EFtWLr6fzHy
	Q92/KMk/9apv0FEyTfzfPoXA=
X-Received: by 2002:a17:903:1904:b0:246:4077:455b with SMTP id d9443c01a7336-25d2675f896mr19178385ad.36.1757650075024;
        Thu, 11 Sep 2025 21:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgOznKQiW7+OP4d+FwxWDW8QfAA8M8JZokoKlbaWqHA9Mh3L7nYTbbb3jZvvrlBqMet+mMFA==
X-Received: by 2002:a17:903:1904:b0:246:4077:455b with SMTP id d9443c01a7336-25d2675f896mr19178115ad.36.1757650074549;
        Thu, 11 Sep 2025 21:07:54 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:53 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:44 -0700
Subject: [PATCH v12 05/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-5-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEyMCBTYWx0ZWRfX2RbWYmd0impW
 ugi9gZNGJrR7b4QQWa5zpp+pDA+ggKudwV2ewP74Uenyhp3sz0SJ/o92yL6IrqV18wQNqPgsTOO
 qebs7j7r2ORbTukGblA82GCyfvA7uAjJW3iqtrb0ZlP6OzUhMtpTbI4N7Nuuuz2DIfwvJd3dZ5+
 mq9kI+z1gMFupifeJhRJDA6oag0O6Ex6WT/BZVag0/jbfSQGNSOLltwu1GC3R2QR5e2LeCgx8+d
 6EWCWGbt2yahiYVdLNXTre+bq3MdTedui6Uzu7L7uXXThKoe//IFGhL+f9M7NI6bcwsiq5R9XtM
 D70Tp2YBpnIZ1pvRetib2WIMNdgNXPgXL1gLg//xIku7MFHhCgEkO3BhmlfTwgax3v1F0ZqGKMa
 uH5XmUeV
X-Proofpoint-GUID: Yxzik1R6fez3e3BaB3cCu7RHiT091R_W
X-Proofpoint-ORIG-GUID: Yxzik1R6fez3e3BaB3cCu7RHiT091R_W
X-Authority-Analysis: v=2.4 cv=LoaSymdc c=1 sm=1 tr=0 ts=68c39c9c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110120

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
index f8534a00c56c..2dc36b501ce0 100644
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
+			ip.a = (__force unsigned long)p->u.ubuf.uaddr;
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


