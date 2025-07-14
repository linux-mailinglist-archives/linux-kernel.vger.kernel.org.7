Return-Path: <linux-kernel+bounces-729257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F8B033F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAC73BB1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2C204C1A;
	Mon, 14 Jul 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxN63jZn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19D1FF1BF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454238; cv=none; b=GE6TWy/Yua2sPjYQjV6lS4kASmdM/tAxSFJHjvkpnEV+1jhG/zZI0DHQM554+Ji5g9j3L2QatxgKhzCS13DkZ8UZMTj3/8VemER6FS6ZzUC11xbSHhhbezpDBsEaHNeMOwC23EyQB2Ca0FnrhxLIQ5xJwwAYhhKMbp4Au9N85c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454238; c=relaxed/simple;
	bh=xyC4ljT6KHH2oOYe61zsOgJHkbSxs7nTcBkLYACz68c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLkIs4E2v97Mt1HtfuVfixJajZEtcsjynZNSh7NnEtlPkfE72Ep1IfN7vDF/CKeuGzjKllrkCGvtP//HTxdmklwN2DcO6PePC9uyWQUfAyabGW24vuabJu+FyDsAiLX2Fw3UZaV1M8SsmlPYu8KlByRoT2ziqzervkIsHmsuQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxN63jZn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DL03gp012224
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFKZ2Vv8rP8BW5x5RLW0X2t4wnUgLw4yB1fx44K8dqA=; b=KxN63jZncXng1ECz
	+Aik3IMs99j/hx2OYbL5OS+Jf5ExdSEVFS67ucHiPTAQ/Xb3tY+OmaH0Gn4p1+ef
	cCvkBKo9QyOUkL9YxZiIAZG3saqVUvw6lrp9SntR8qgDxEnr06O0adwSvQHDrEqn
	4wRvddDT2LYA8efFfNjG4tZM0X3IbFKCnk9aoozHRuFikHUAUUM5KTBhNag2F9F3
	zgiHsnMCDgPPFpUrXxwkLjHsziGu08bXfFCk8KcfjLre7xQfeYqqZohykOhxhyTj
	B78jkAzxANUnzZB64Uc8A//+4v/ULR3PMuW3l88aUCOd7NaUwAdwfLIcmLBc5yi6
	F8AQNA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhat7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-237f8d64263so37540345ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454236; x=1753059036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFKZ2Vv8rP8BW5x5RLW0X2t4wnUgLw4yB1fx44K8dqA=;
        b=rYil02a6mSmMaXN6vDdWnnHIQ86lTadSqrOGYkBh4apmM7Zlz0cSKv7WMZGm4YyTOn
         1ZjWbvEyC3HcEsoyOAwBwqKRoM6atbwWsgwjOTe0Z1Z2v2ra/NMkwLi0kdt6gW5NysdD
         av9mxD3SfmDcKrwCDO5jcjHCEr/kAkEobpQByfKtLP3I4UBgsUhEKZD10XsjXotO60+S
         uHqP0sZttPxaV3z9QbP44YbVduLo2xTyp5wgir6TS2RQnfjixG8K77uoh0zMjwwKhMt9
         +j5LUF/sW5O83zv1f6R1lWipUdbnSkHCqRJrDOineF9yOMhYjo3ZXuQQSGudcpctt4Kk
         a+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXLpn06n68U+21wcn4Mx7cxqCqHOK/nTXimPpNCdhMJ0py4v6+U/yqYZAOrqn52bVnL1XR6TsQSNlZ7rt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUjmqEzHvJD542f2MuuE4poEWqJQgewAXvO8L8Qm/hhbiCcFS
	ByIu0DfqT5NlgnIkMJeN+MPPWbpE4YTJS+vD5nTM2SQ9iG2peCA0n7TIhEYA5X1N9nRh3hSM0bd
	kZ2C4SadIQGXus1pSX0sOIYkwLAAcscczeQSDhkAc24Es5Y7zaLngbZa0FC6LmZxE7g==
X-Gm-Gg: ASbGncsRWAXbmmXU4vvzZtT+Xe4eWuphmNZv8vTUaNBF3HxZPYw3h/QXUxIcbcvhQ2o
	YSTZw6uXXIJQdheimmNm/TDoAMY8YJwCcsVOysFufLRTUQRdo8zXrxnKwJlfRWWwtanEkYArE8v
	B9yP3MWADOjLqwrEq3Awodqv/Owvyr/tnNctX+EwmOFxVosLbjylhtr7rILbQQIhNHZcKB87Udn
	SSBm8hPnjJbA9Zp0KqfRk3/0YZqhxOvLgWtlzoREi3UeSdNtx9ThIjBqwuzLTM1vUXlzLHX5Z0G
	CFjIrcEoN9HQ1g2rCeNeGCaAYQl7B5+OXmNtTISxcmQQh9lJIEKB+g7g5omTolR/drSoPaArueD
	glmCWKr0K5mgP6xR+Je4ZZPw=
X-Received: by 2002:a17:903:1987:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23df083b061mr146286105ad.21.1752454235566;
        Sun, 13 Jul 2025 17:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWE63CUT+mV4eFI/L/OI3mlg28dVXCWxHTZWUfahh4Pbw8pKLIOS3+I2QJimL01ku9B4lVgQ==
X-Received: by 2002:a17:903:1987:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23df083b061mr146285835ad.21.1752454235146;
        Sun, 13 Jul 2025 17:50:35 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:34 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:22 -0700
Subject: [PATCH v6 10/12] qcomtee: add primordial object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-10-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wWcsLsd9yrY0LTbz2BT3QcSjbjuUP9g6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfXyKtwLeGGw2Xt
 es8Htu+E8eq8Fo4ZYsu/Q+qwe2Z+GX5b3Qb5JYX0GXd3bOn4hTIFQ2+PoCaeHLhyHf+4eAJkZRe
 IW2WNNCyva5SIhC8RONvRxiNzEGYb109dwzUMndvafAGF3YdgbzyW5IhgoDHe4ETD1MnEoyTl3r
 549jBB2bs0amZblcxSbAuiDNnkwpQKOZ1qnApgFrqQlEXQetLJ54TaK9u7AUQLEz/EnfJdrhABH
 PX9/qBkfyKKXC5cL0JzkKOX87qcBRlTF+grPAvgkg6xlJ07tKhKgKcVsl2bHbidfcMPAlo2rwCg
 pGe7OX34bnQHzsuzMmLfi43981uGQUa77fjFj1oCWU5mAeMHrLE6ent6XWFQa4eHLrdH+O4NGlP
 +YBK/BafVM6JKbxHyBnw2nW2RoLEvn/wZuozHC/iM8IA5VYJ+628r/YH/Rwr4arFd5zYv5OM
X-Proofpoint-GUID: wWcsLsd9yrY0LTbz2BT3QcSjbjuUP9g6
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874545c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=6dJEewf6gjddJ4Qna_sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

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
index 46a5ca95b7a9..9491f5aae4e1 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -30,10 +30,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
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
@@ -156,7 +158,9 @@ static void qcomtee_object_release(struct kref *refcount)
  */
 int qcomtee_object_get(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		return kref_get_unless_zero(&object->refcount);
 
 	return 0;
@@ -168,7 +172,9 @@ int qcomtee_object_get(struct qcomtee_object *object)
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object != NULL_QCOMTEE_OBJECT && object != ROOT_QCOMTEE_OBJECT)
+	if (object != &qcomtee_primordial_object &&
+	    object != NULL_QCOMTEE_OBJECT &&
+	    object != ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 
@@ -260,6 +266,9 @@ qcomtee_local_object_get(struct qcomtee_object_invoke_ctx *oic,
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
index 000000000000..025346cde835
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
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
index ae82e7747c90..4253bf49f31b 100644
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


