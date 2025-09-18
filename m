Return-Path: <linux-kernel+bounces-778685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA1B2E8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AB97BC26A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB432EB5A3;
	Wed, 20 Aug 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="orjJBiP9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4362E8E04
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733161; cv=none; b=oHPHM2mIoynqfdt5mJgxFNJxh/1IimYw/NkDoANzxA6HVX9ZzNdVADZDMdP2fSyjUqmrdBM6KOeJNPsp72PDst1TAQ96a8JZ7feLZvb3ex0Zp0LB2+rZsSvfuVXwv39cwp/7LN3UFpkd16lT6VxNyDq9ip7WlVRBynkgilMcc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733161; c=relaxed/simple;
	bh=sMilRBG3Tk7d3f5SkQaemDhz+O0XB9Atud0o1uSo9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfZHKHPxwNS468RTIMjVfqie7ERLGwIdizMJQXzsMwHeFmbJr4c7thkVGV1qW4B/wEeORY4zrbJY3aKZbcNfe/p4KI+X797raOyG7XaqjE0HVxAIKyCzmzVxXFDHFP4UHyXvPp0gHl2jnMSImpttpVKl7ZN11O7+IJZLjo6VieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=orjJBiP9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIqfLU009507
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dz0mBGv2PHp5SE7DcJEkU+TGFCx3X1aVUkyX8MrLh0w=; b=orjJBiP9yXOa36hQ
	b/w+2XCiy4xfGgyQ2rKW2a5+gusID18VKORZSbuxv8XRiCHtQa/Xdb0zMtDKsrwB
	ky2R17AhLv/s3qgIJs3e3Q+LMaoL6Q2On/qllXvS6/1Vnu1vKLzv+qda1ggXSSdd
	yChv0q1lANSZQKtfrIhsa4RaLWatlVGH7OpGCmJsdwj35/B5UDAjuiKKjnfUe0ih
	Lh/5m0B0umnCT2mr7Vqy70IpRL4Z8l9yEpoANHKEUtx0RVrr2LIWdSh0t+0RZHPb
	Ne4Entf1gWSuLuS2d7KOJc1c7oDtFoLGr6zM9t8Z7/bUPT3VAhWHnELHIMLKUJET
	ioRC+g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a3eab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e7ef21d52so905638b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733157; x=1756337957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz0mBGv2PHp5SE7DcJEkU+TGFCx3X1aVUkyX8MrLh0w=;
        b=C1TD2Bk05AiWdkEd0yiodrJonh7K1FqkN0BuBYhRDitK3owR/vSJ4bqNqMB4MpogVH
         7icuhn3Tk0Sxf42OhnVDWJ7rsgeuBTadQifAyZmfMQ8C0ar8rnpFtFeMSDGbBSFE0++Q
         ZUP9wkOcSCRreaEN8wJL4N3NNFeXRglAaYxRgRznTPd9ryqFZa41DEu9+kkg+YWYC2SH
         xxUNGFCfvhKTD4Siuc9PRfZeMIrd2ClL8OMjHl0p0VMPdq5ZwrnVD6mpybBPNl6dYxrU
         Tifx+FkI26UfewMF+rj8b4Gfl/KOPodiRDlz8e27OjvjuPOCHkBN/p+/3fR0Jjb1HGxi
         iWnw==
X-Forwarded-Encrypted: i=1; AJvYcCV4NaRc8bgbMGg/7PxMnbZKMAOadSMNPf9R8WVADVdXCYun55sTl8Yr8F3Bwp2KFkHX7l7l73cBukx4/g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBA1PJcxCqh2t6BSoXKI6zGmtmr4oDZf/4IzjdgXDLVTZ/IuoS
	ZL02B8jdxTnKBSgUZ1HC5HpB/DQeeI4+gpZ371x4YaDbZ7B+sMBADJ0MIOFRfAJ2JPgqmBi9QNe
	6W8F7xUuFHrANU2kF+zYVtk/RxWDHT51Me2MmdfWTa23098PFe4shismqbxh+6TS3mg==
X-Gm-Gg: ASbGncvzUyn4kyNhJecinJ9KVJ9wg2JXr7xdmVIjmaTlMsHfe/W+T+LhbKIUkBADh6o
	D0syiIN1sfYpqZTzGHgBVemjWGa6a7wzCEPA3j+DvraRAfDxpwn0wgbfHDZFvXXaGMYEoY49p8R
	11nUJNWp6NoKDIcDlTt4GEJ40ZSQdMSqMYkK41fyE++Gr5OIS9+AxHLHRV5jnt8RWBE6009w8g4
	7Z6dYW9p4mE0LMyHk/5KXNoWcZ1eMV5PDPc6mGUWsCb9cHvv5sJHQ3rFUTVkfVSkd0mTLMbSaTK
	eUn6VzE6N2J0lsgr1N7nJDX6LKoD/dHzdB0eo8FFUhlvL0C1KVSt/MpEWxWNbLbNU1k8t4xXDfO
	uspIa+uQd3exj0ifSnYOhWW0=
X-Received: by 2002:a05:6a20:2451:b0:240:2234:6860 with SMTP id adf61e73a8af0-24330a4dc33mr361262637.32.1755733157273;
        Wed, 20 Aug 2025 16:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRP83uq+av1QirSOCHtLMrAvlawsypEMgYxXq8vdz0y2llmP3CAjOQugjM66YafbhvcNksA==
X-Received: by 2002:a05:6a20:2451:b0:240:2234:6860 with SMTP id adf61e73a8af0-24330a4dc33mr361226637.32.1755733156804;
        Wed, 20 Aug 2025 16:39:16 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:16 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:56 -0700
Subject: [PATCH v8 09/11] qcomtee: add primordial object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-9-7066680f138a@oss.qualcomm.com>
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a65ca6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mlAXhTSI74d3Yk0_v9MKBi5sbf7osGbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/fePKF817cWv
 uS8KqKoY74b9aksoRffGom4HIRhgQwPmjB+jiGVHKvzJ978pTWHzOB/XDQbl6qJ+2l9jRd0b1Fw
 JvyW4kxj8WjpbcYAqJUYITYjbFEAJLC6GAKICK65PkFscyey3JRE5P7valGg40v7Dn+Gyh8LVj7
 QETFDMoSaS/vuUw7wRBahE6qwvp7S6Rx0qqd94BaM+UL8Jlsr1DIajC8oLoNvidF2sKb8MK3ZDZ
 Q3+6S3HcUaaFrLp3M02lyZc5JKQnkuxMaubEN7vl4S8XKbdxplYTwLlqfYFQM43FFV30OWxE+hx
 rSVgstySCecYt+83nN9hZAY99lObUNYL/079Em5GgD7yPHwY7O84h4eZf6yvA9P5iXsFciCSGg/
 FHB01V8G8hZHQjsQ434Ye49DgkJQXg==
X-Proofpoint-GUID: mlAXhTSI74d3Yk0_v9MKBi5sbf7osGbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

After booting, the kernel provides a static object known as the
primordial object. This object is utilized by QTEE for native
kernel services such as yield or privileged operations.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/Makefile         |  1 +
 drivers/tee/qcomtee/core.c           | 19 ++++++++---
 drivers/tee/qcomtee/primordial_obj.c | 66 ++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  3 ++
 4 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 600af2b8f1c1..78f8e899d143 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_QCOMTEE) += qcomtee.o
 qcomtee-objs += async.o
 qcomtee-objs += call.o
 qcomtee-objs += core.o
+qcomtee-objs += primordial_obj.o
 qcomtee-objs += shm.o
 qcomtee-objs += user_obj.o
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 578299a3eabc..561a48319f91 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -31,10 +31,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
 }
 
 /*
- * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
- * of the QCOMTEE_OBJECT_TYPE_CB type.
+ * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
+ * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
+ * set is reserved for the primordial object.
  */
-#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
+#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
+#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
 #define QCOMTEE_OBJECT_ID_END (U32_MAX)
 
 #define QCOMTEE_OBJECT_SET(p, type, ...) \
@@ -157,7 +159,9 @@ static void qcomtee_object_release(struct kref *refcount)
  */
 int qcomtee_object_get(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		return kref_get_unless_zero(&object->refcount);
 
 	return 0;
@@ -169,7 +173,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 
@@ -261,6 +267,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
 	struct qcomtee *qcomtee = tee_get_drvdata(oic->ctx->teedev);
 	struct qcomtee_object *object;
 
+	if (object_id == QCOMTEE_OBJECT_PRIMORDIAL)
+		return &qcomtee_primordial_object;
+
 	guard(rcu)();
 	object = xa_load(&qcomtee->xa_local_objects, object_id);
 	/* It already checks for %NULL_QCOMTEE_OBJECT. */
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primordial_obj.c
new file mode 100644
index 000000000000..df94fbf5f141
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+
+#include "qcomtee.h"
+
+/**
+ * DOC: Primordial Object
+ *
+ * After boot, the kernel provides a static object of type
+ * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is used
+ * for native kernel services or privileged operations.
+ *
+ * We support:
+ *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
+ *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
+ */
+
+#define QCOMTEE_OBJECT_OP_YIELD 1
+#define QCOMTEE_OBJECT_OP_SLEEP 2
+
+static int
+qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				struct qcomtee_object *primordial_object_unused,
+				u32 op, struct qcomtee_arg *args)
+{
+	int err = 0;
+
+	switch (op) {
+	case QCOMTEE_OBJECT_OP_YIELD:
+		cond_resched();
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	case QCOMTEE_OBJECT_OP_SLEEP:
+		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
+		if (qcomtee_args_len(args) != 1 ||
+		    args[0].type != QCOMTEE_ARG_TYPE_IB ||
+		    args[0].b.size < sizeof(u32))
+			return -EINVAL;
+
+		msleep(*(u32 *)(args[0].b.addr));
+		/* No output object. */
+		oic->data = NULL;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static struct qcomtee_object_operations qcomtee_primordial_obj_ops = {
+	.dispatch = qcomtee_primordial_obj_dispatch,
+};
+
+struct qcomtee_object qcomtee_primordial_object = {
+	.name = "primordial",
+	.object_type = QCOMTEE_OBJECT_TYPE_CB,
+	.ops = &qcomtee_primordial_obj_ops
+};
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index f34be992e68b..084b3882017e 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -140,4 +140,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 			       struct tee_param *params, int num_params,
 			       int req_id, int errno);
 
+/* (2) Primordial Object. */
+extern struct qcomtee_object qcomtee_primordial_object;
+
 #endif /* QCOMTEE_H */

-- 
2.34.1


