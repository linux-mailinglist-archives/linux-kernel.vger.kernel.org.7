Return-Path: <linux-kernel+bounces-813171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E193B54184
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8411AA1366
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB58286D64;
	Fri, 12 Sep 2025 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWyMqAzc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644C284885
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650085; cv=none; b=BQIFGmerdDeO/M1suPo3SX3O4rqeeGeM3BvcuvdcAdZ4QoTt26i90vu3janY7S7fETf1kSox4pjTywyAZzaEX7QCqD4ZLKVeR1o9AYoRNidbyCxR/8h3AHcBknGVK63CrIk/2aW4z+hPr3DUNwRlO10bKsiChjf/dGwhUDCA1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650085; c=relaxed/simple;
	bh=+8dSfgrMG4eFIFtqJ20ROAswX13YmpqsL2XfyfUksAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAVhW2jlwRGjkYb35Wedf7b/xX+yUb+n2MkDuOhqwFG3wwRMt81Sw2GU5DyJ1cwqW3ttB/2kiLdiczmbkbSuMDc4xKjEqFySr1y2eJWLMOG7le8tDfZakKInhbgqQ7m0yGmDilYiozA1pivQt/z1KrEtJMLpIlzkIU0R3Jm0UzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWyMqAzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIp0Sr016304
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaTc6vdim5GJ1OsrX7tFizDxK1+T66nxGle441QICfs=; b=KWyMqAzciNjXlkhD
	M+/07iiOAN6B3DLDX1mNLnNGMffDDrffbGD6E4s2Hm90z0HWSuoRp9NcKZOS1pIL
	8WFRLGYYaIR+QD94vzsMi4FtE0enS9y7OqsyiOGxZCH2dxrW3YX3MHl+p1122CEA
	+VsrB0wcTWv7tNV6HNxZOVZ4sQiljCtYkASNUszdoRyaasO2H3luU9OKPTXDcxn6
	UYcB1mksxK3HYeYYbj76YwT+TI2fT71MmlzVjIGU0MB/kG2yf6cI9lRH7gD3XXeq
	GpNm3eRZXF9l3P8zHR8FU77G3EnX1EnzQgMJYV/NZJY35NVdhvRb5rvPlWnixjeS
	nMaCLQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t386jxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4dfb96c99dso993392a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650082; x=1758254882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTc6vdim5GJ1OsrX7tFizDxK1+T66nxGle441QICfs=;
        b=c3v5E83ZDJbZC8h4gX4ZBsNjH159J9qkfUhpLCq6G5HCuXOqGI/zBvqQdTeAWicv83
         iHyygY6gBKHDExYWrmxoRyF2atW12BUDogolUYv/PDGxgHqxbHyi6RSTg3kn0tZadx29
         o9AkD8IwGcI9u/hqbgvzrGDDVgxpv2yaUf03XaUeFQBMsKfM97+PG4Ys8R6+WolTYgqV
         skcrfFgNkeBKWoUw5s4ub3QUjiZDRENNQ46X37UF96bFV29EEbvd3esORsZT0KYw0yE3
         uysgVyV3YL/VW4TIjcDRJiwuJ+Tv+04bD50lM7QBtOz1bChLY7DsP5oVeAay8VpHdGZN
         oJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVyEY9s9RXOC+FNv0y2ENPXVJw3g/xbjb/25Gu5FF2tm2jPJ/njqMdOjK2RBx9YxkEwUuKI8niDz0BxNVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfndMQCiMGqdJJvL/dT39iltLVybj3d4Uonp/9WtdXIKlKR0Ms
	8ZzIG+Cs1esPn3nvmuW+8Jjn+0wvLVRuOVZPhiQWEYsVRjgRJYkeEq+tP17R0P11vl/dJbIRPan
	CH7vznd38koLZMu3NEyn9gxEfP6CSpZOZmFq8RCwZc03FYM4WVOyK0p08KHGIDq27Fg==
X-Gm-Gg: ASbGncsgnwpWwyPPVkxKhSohgluZxfQDO2hdpye9Q3/kQLlWLhJmbVyiCarMgA5FPtL
	VbKM79g8LjRv4wX6JSmxNL/OjI/hDsKwmGAJnmsDrErMV2F3R4m6JVeZbufcrj1R4UR0tNShAek
	+3KADCgMPV7Q5WJApeQqdwpjVY2UI11WVetiQTlfYucvhl7QKXdiBCp/h+sUIGVSmLRHFITLm+A
	9CBvgVRpmqU1/ybK2jOZ2rnf6kUILstJSC8j9PROwEw8m14WV0j8UXP8KrTN0FpWQwqWLeW/r6x
	f+Q7oQWNH4Ip8xEcrFWAA5JT3yMHYYm+mrS0GTvZamAfVN9PtbZHRplEBggd9dAZ5VjvZW3AkjG
	kCmAuwKN8EgiIdtYNRBsjZwg=
X-Received: by 2002:a05:6a20:939d:b0:24e:2cee:9592 with SMTP id adf61e73a8af0-2602c90ceb0mr1967986637.46.1757650082081;
        Thu, 11 Sep 2025 21:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6OG/5mnjJQYPbDxpKFK12IlfhWl46TZej0Vn5/G4+EVSGgvP8mYysplf1uK5zi0tFUMsB7g==
X-Received: by 2002:a05:6a20:939d:b0:24e:2cee:9592 with SMTP id adf61e73a8af0-2602c90ceb0mr1967944637.46.1757650081589;
        Thu, 11 Sep 2025 21:08:01 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:08:01 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:48 -0700
Subject: [PATCH v12 09/11] tee: qcom: add primordial object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-9-17f07a942b8d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YBSZCrRF5KQcX2VT7l813knWbpnokXQ0
X-Proofpoint-GUID: YBSZCrRF5KQcX2VT7l813knWbpnokXQ0
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c39ca3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXxN2Fy5fTrCIz
 AXTiCNwVebVUrgC6BefB15FogVltT6WbgNjikUSmk64sCQy47+6Tbzkl+ZumnB4rvPgcihgaMVl
 +pm+iwfmFW9HD/9NPraLt5lept3R1hzsAGamwvKGDatxf+gBuczzPx3xF6UzzLx2cfPGjTBl4Ey
 dpaCw68I0gH7rEORGEib1WBL7/ifRS7LnptBD40w+kiTVktNcUx3IZMfKI74zadBV2xDAgyRXhN
 TpCBZCoSyDNdFTh/EjlFfHAGDnYE8RMRgbHRKe/8oANbsLERZprOhfPaplrQEWoY1KEb1Cr4/jC
 62jicdZbAdgHVQxryUbUz/NCpzR1EJYbBhmHkgamdhZWQV1FLv5KhV2XcXEyoMZi0WDe0ghhGjC
 rtdDt2A5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

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
 drivers/tee/qcomtee/primordial_obj.c | 63 ++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  3 ++
 4 files changed, 81 insertions(+), 5 deletions(-)

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
index b6931ed6f200..783acc59cfa9 100644
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
index 000000000000..0e43f04493e2
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
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


