Return-Path: <linux-kernel+bounces-765714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E70B23D38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 103224E4076
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D684200BAE;
	Wed, 13 Aug 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEcL9a7F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054171FECAF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045440; cv=none; b=UAU3sHQz9JwqaWjCbFymp0lyUGj+I1tNtlmNYpTLa/+FjzHOntasQv7/cGk8lfNDhlnemE1GD0/tjWart7rQMf0C3uMu+907O0YXcsfQkZ7uoxk7xL7hHgVpS4vdYVfD53TyGs7b7YvZm5RlnuPsmsMOaKSw/CJItt4Pm3NuCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045440; c=relaxed/simple;
	bh=HrbLXRD+gcEXr/5IvT5f+rEjW1/7m5fr8JiFrC15vpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWk9NjLZPAw7uEhxh3+T0wbVHu9tQa6y3EYuZPwhe1goLT0antYBrjVrD3/fNnO16bwfe+aj5OAkxdW1x1+co4TYqxYGFaGpyfirYQuNspDH4eSvXKhK9eODJN5r/biajyoVwqIS6EcS7lLb0SE9eUwntCk1SHGXG2I54agYao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEcL9a7F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKRD8R029531
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U20Qs50yW/Pa4rPiyjyyF7fykERDewmSsufWoa283qY=; b=HEcL9a7FGAgQNUeI
	wR+r7hGK3sqUexLcR7ER5EGkWkRLaDLRfO/AUHBtz0ndD9Z6lwaq2n7DoTSw9aPV
	S7CQDG/Iz0qpnJ3Dz7eqvAJFoSCvaGQSqT3f99ngPDlmYCjgzcrgVp7io8+pUvPH
	OFfiK7nmYj6+VQKCk6lcZdRkmct87jykBOVohDyiVhSOEyavHfj2d6cjjC6TjLUT
	8QHrh5ZHSchw4VWoAf8v/mf/5ogitiVZmqFrY/dd9txKON17oiDl76UYXyGUwKIy
	OezokLE0rZlEcuLm25ZhhTXnXGtyfaFrWNw/ArB+VZMryKyk19ZMdogcqFhZnwrJ
	Po4+dw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g9w7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24011ceafc8so48333815ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045435; x=1755650235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U20Qs50yW/Pa4rPiyjyyF7fykERDewmSsufWoa283qY=;
        b=Nf5m7ImcdNSGdOM1IUm0ktFIaooLpJ8rLVMaQGce05GYaJIU5WORn6DW3NCZycytGG
         uE3qA9KB+3+ZCwsJ8kavu47NuZKNSwNVqXW0kZ4SmcWf9GO7ZZprL2aCRYQcP3S00LeZ
         mXtxQ+rO7pE/QQbE770qTJT+7H0YYXCZb1s3a0n2Ho7rjvTYe0+0C65B4DZfeaHY4A28
         1eb3RlWJv52+ZlYsFpFujeYVGGhQJpQMmlg1Bk7px4ONRXJqwO4pDYLKnNn4x6YeevkP
         nOiG8wcMiaDiogWIWJaSpTIDCV65YlANQxOaEHKH9zCC8Xy1iHmNP0NVBlKVU2oVfFty
         +vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfhfHtDZGIraIBnHDCnB4iwLfLPt3rCJZPyauIyuzTGtaHf7j9b01k9xwhhCWBNUxIQ731JIsUdA7WxvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdbQXASkddJHN3GsC9jFWdw9mvzlJkggASvoBe5LsSFJpibh7
	k+c53P/Fq4WLcSYRhQ/3WPVUKHMZcRQTRNReqLUoKcbk48HPuf/I6LvSbL/tU4HLWlyCL3LR8L2
	JCH+MIyuE1vxKPuQ9ZiQtPIiWof1JcalrAPcItwxasht2UTrKZVPjoV/wggKpTqBpfw==
X-Gm-Gg: ASbGncsxMF+gKt3zTsBBUOEkbMaVM33UNmKREo1a7nFH5zK2Su7+BORQ5WEj20BOi0Q
	kvkJ4lSYQJCq8pY6KiwHymOLNYQeR9RbK0sbw282kOhMAiQta/7naraaUtYimJqOwvfoLJeJ5Jd
	//32gaSS6TzUhmA0HtjyUFe5oTVbtC5BDV3b7q8NQS5pUkn01QCS1Txbf77xCnnRc0csRS7gy/y
	/BfGjje2cXcnbETt7MsAjozay/JP1UVfuvrBO7p9aD9zCTWQOu25M2LIkvzDL9ETRwftYxqvUW+
	77mfELI8fMT3HT5+fkDBpJtXw2sgO7t5mvBLFw3jKpuz9JtILqbV5dEcSAt80sNzsM0uH+AagZR
	W6xyHzEf1M+Mab99xt604CaI=
X-Received: by 2002:a17:903:41d2:b0:234:a139:1206 with SMTP id d9443c01a7336-2430d21e4f5mr17901675ad.40.1755045435071;
        Tue, 12 Aug 2025 17:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ4OI36KQcXtJ2J8EuQnmVMSvQKy15tY8XFC+pWR83FD0bo+CHo+KechZjBGRzTrXnAPimsQ==
X-Received: by 2002:a17:903:41d2:b0:234:a139:1206 with SMTP id d9443c01a7336-2430d21e4f5mr17901185ad.40.1755045434467;
        Tue, 12 Aug 2025 17:37:14 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:14 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:39 -0700
Subject: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689bde3c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=OR1utrCcES5rRZ7Z870A:9 a=DPARgtBJioFDCh1s:21
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX9geTGCSWRPCh
 jnhp44u/sAMJCdqs1eDBJbkPpOr8Qbn6m0NPsL82CqZ8zU4g18ue2nOPg+KmEuUrKORIzbcUmjA
 HTZI1ZbWvYon894ZFONuBXg53qQWYY6KVc+cWeAGpjHHYjV1zRXeLNOeW467loPCEmukc5bA4+1
 ihv3RIf9K//6pr+ZUpmCXnG42l7T+oQsfdEpc2NRPhnL1abdZAIeVgfTOpWLSFlcEDQKE+dGeWX
 On6vpE2iK+LRxjp0sAwdVZV1vcTZ111KvH8rY55zqwj6CvrEQQhYCLr3+a3NkjzYBUTA1bCBPCH
 w58NOtG0jEfGwKsETrXvLNJAFX9vIiwxc7z9Qvo2/xIXr7y66n8Td31Qkh64JvczsDjWkKiSeDx
 Osx14hs7
X-Proofpoint-GUID: 2CKLlPvrUqHUWekgnYGN8r8qmjJIW7EF
X-Proofpoint-ORIG-GUID: 2CKLlPvrUqHUWekgnYGN8r8qmjJIW7EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Enable userspace to allocate shared memory with QTEE. Since
QTEE handles shared memory as object, a wrapper is implemented
to represent tee_shm as an object. The shared memory identifier,
obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/Makefile         |   1 +
 drivers/tee/qcomtee/call.c           |   9 +-
 drivers/tee/qcomtee/mem_obj.c        | 169 +++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/primordial_obj.c |  50 +++++++++++
 drivers/tee/qcomtee/qcomtee.h        |  39 ++++++++
 drivers/tee/qcomtee/shm.c            |   3 -
 6 files changed, 267 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 78f8e899d143..7c466c9f32af 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_QCOMTEE) += qcomtee.o
 qcomtee-objs += async.o
 qcomtee-objs += call.o
 qcomtee-objs += core.o
+qcomtee-objs += mem_obj.o
 qcomtee-objs += primordial_obj.o
 qcomtee-objs += shm.o
 qcomtee-objs += user_obj.o
diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 33daa4d7033d..cc17a48d0ab7 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -122,7 +122,10 @@ int qcomtee_objref_to_arg(struct qcomtee_arg *arg, struct tee_param *param,
 		err =  qcomtee_user_param_to_object(&arg->o, param, ctx);
 	/* param is a QTEE object: */
 	else if (param->u.objref.flags & QCOMTEE_OBJREF_FLAG_TEE)
-		err =  qcomtee_context_find_qtee_object(&arg->o, param, ctx);
+		err = qcomtee_context_find_qtee_object(&arg->o, param, ctx);
+	/* param is a memory object: */
+	else if (param->u.objref.flags & QCOMTEE_OBJREF_FLAG_MEM)
+		err = qcomtee_memobj_param_to_object(&arg->o, param, ctx);
 
 	/*
 	 * For callback objects, call qcomtee_object_get() to keep a temporary
@@ -168,6 +171,10 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
 		if (is_qcomtee_user_object(object))
 			return qcomtee_user_param_from_object(param, object,
 							      ctx);
+		/* object is a memory object: */
+		else if (is_qcomtee_memobj_object(object))
+			return qcomtee_memobj_param_from_object(param, object,
+							       ctx);
 
 		break;
 	case QCOMTEE_OBJECT_TYPE_TEE:
diff --git a/drivers/tee/qcomtee/mem_obj.c b/drivers/tee/qcomtee/mem_obj.c
new file mode 100644
index 000000000000..228a3e30a31b
--- /dev/null
+++ b/drivers/tee/qcomtee/mem_obj.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/mm.h>
+
+#include "qcomtee.h"
+
+/**
+ * DOC: Memory and Mapping Objects
+ *
+ * QTEE uses memory objects for memory sharing with Linux.
+ * A memory object can be a standard dma_buf or a contiguous memory range,
+ * e.g., tee_shm. A memory object should support one operation: map. When
+ * invoked by QTEE, a mapping object is generated. A mapping object supports
+ * one operation: unmap.
+ *
+ *  (1) To map a memory object, QTEE invokes the primordial object with
+ *      %QCOMTEE_OBJECT_OP_MAP_REGION operation; see
+ *      qcomtee_primordial_obj_dispatch().
+ *  (2) To unmap a memory object, QTEE releases the mapping object which
+ *      calls qcomtee_mem_object_release().
+ *
+ * The map operation is implemented in the primordial object as a privileged
+ * operation instead of qcomtee_mem_object_dispatch(). Otherwise, on
+ * platforms without shm_bridge, a user can trick QTEE into writing to the
+ * kernel memory by passing a user object as a memory object and returning a
+ * random physical address as the result of the mapping request.
+ */
+
+struct qcomtee_mem_object {
+	struct qcomtee_object object;
+	struct tee_shm *shm;
+	/* QTEE requires these felids to be page aligned. */
+	phys_addr_t paddr; /* Physical address of range. */
+	size_t size; /* Size of the range. */
+};
+
+#define to_qcomtee_mem_object(o) \
+	container_of((o), struct qcomtee_mem_object, object)
+
+static struct qcomtee_object_operations qcomtee_mem_object_ops;
+
+/* Is it a memory object using tee_shm? */
+int is_qcomtee_memobj_object(struct qcomtee_object *object)
+{
+	return object != NULL_QCOMTEE_OBJECT &&
+	       typeof_qcomtee_object(object) == QCOMTEE_OBJECT_TYPE_CB &&
+	       object->ops == &qcomtee_mem_object_ops;
+}
+
+static int qcomtee_mem_object_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				       struct qcomtee_object *object, u32 op,
+				       struct qcomtee_arg *args)
+{
+	return -EINVAL;
+}
+
+static void qcomtee_mem_object_release(struct qcomtee_object *object)
+{
+	struct qcomtee_mem_object *mem_object = to_qcomtee_mem_object(object);
+
+	/* Matching get is in qcomtee_memobj_param_to_object(). */
+	tee_shm_put(mem_object->shm);
+	kfree(mem_object);
+}
+
+static struct qcomtee_object_operations qcomtee_mem_object_ops = {
+	.release = qcomtee_mem_object_release,
+	.dispatch = qcomtee_mem_object_dispatch,
+};
+
+/**
+ * qcomtee_memobj_param_to_object() - OBJREF parameter to &struct qcomtee_object.
+ * @object: object returned.
+ * @param: TEE parameter.
+ * @ctx: context in which the conversion should happen.
+ *
+ * @param is an OBJREF with %QCOMTEE_OBJREF_FLAG_MEM flags.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
+				   struct tee_param *param,
+				   struct tee_context *ctx)
+{
+	struct qcomtee_mem_object *mem_object __free(kfree) = NULL;
+	struct tee_shm *shm;
+	int err;
+
+	mem_object = kzalloc(sizeof(*mem_object), GFP_KERNEL);
+	if (!mem_object)
+		return -ENOMEM;
+
+	shm = tee_shm_get_from_id(ctx, param->u.objref.id);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	/* mem-object wrapping the memref. */
+	err = qcomtee_object_user_init(&mem_object->object,
+				       QCOMTEE_OBJECT_TYPE_CB,
+				       &qcomtee_mem_object_ops, "tee-shm-%d",
+				       shm->id);
+	if (err) {
+		tee_shm_put(shm);
+
+		return err;
+	}
+
+	mem_object->paddr = shm->paddr;
+	mem_object->size = shm->size;
+	mem_object->shm = shm;
+
+	*object = &no_free_ptr(mem_object)->object;
+
+	return 0;
+}
+
+/* Reverse what qcomtee_memobj_param_to_object() does. */
+int qcomtee_memobj_param_from_object(struct tee_param *param,
+				     struct qcomtee_object *object,
+				     struct tee_context *ctx)
+{
+	struct qcomtee_mem_object *mem_object;
+
+	mem_object = to_qcomtee_mem_object(object);
+	/* Sure if the memobj is in a same context it is originated from. */
+	if (mem_object->shm->ctx != ctx)
+		return -EINVAL;
+
+	param->u.objref.id = mem_object->shm->id;
+	param->u.objref.flags = QCOMTEE_OBJREF_FLAG_MEM;
+
+	/* Passing shm->id to userspace; drop the reference. */
+	qcomtee_object_put(object);
+
+	return 0;
+}
+
+/**
+ * qcomtee_mem_object_map() - Map a memory object.
+ * @object: memory object.
+ * @map_object: created mapping object.
+ * @mem_paddr: physical address of the memory.
+ * @mem_size: size of the memory.
+ * @perms: QTEE access permissions.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_mem_object_map(struct qcomtee_object *object,
+			   struct qcomtee_object **map_object, u64 *mem_paddr,
+			   u64 *mem_size, u32 *perms)
+{
+	struct qcomtee_mem_object *mem_object = to_qcomtee_mem_object(object);
+
+	/* Reuses the memory object as a mapping object by re-sharing it. */
+	qcomtee_object_get(&mem_object->object);
+
+	*map_object = &mem_object->object;
+	*mem_paddr = mem_object->paddr;
+	*mem_size = mem_object->size;
+	*perms = QCOM_SCM_PERM_RW;
+
+	return 0;
+}
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primordial_obj.c
index df94fbf5f141..a334f9d65f07 100644
--- a/drivers/tee/qcomtee/primordial_obj.c
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -17,18 +17,31 @@
  * for native kernel services or privileged operations.
  *
  * We support:
+ *  - %QCOMTEE_OBJECT_OP_MAP_REGION to map a memory object and return mapping
+ *    object and mapping information (see qcomtee_mem_object_map()).
  *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
  *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
  */
 
+#define QCOMTEE_OBJECT_OP_MAP_REGION 0
 #define QCOMTEE_OBJECT_OP_YIELD 1
 #define QCOMTEE_OBJECT_OP_SLEEP 2
 
+/* Mapping information format as expected by QTEE. */
+struct qcomtee_mapping_info {
+	u64 paddr;
+	u64 len;
+	u32 perms;
+} __packed;
+
 static int
 qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
 				struct qcomtee_object *primordial_object_unused,
 				u32 op, struct qcomtee_arg *args)
 {
+	struct qcomtee_mapping_info *map_info;
+	struct qcomtee_object *mem_object;
+	struct qcomtee_object *map_object;
 	int err = 0;
 
 	switch (op) {
@@ -36,6 +49,7 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
 		cond_resched();
 		/* No output object. */
 		oic->data = NULL;
+
 		break;
 	case QCOMTEE_OBJECT_OP_SLEEP:
 		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
@@ -47,6 +61,29 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
 		msleep(*(u32 *)(args[0].b.addr));
 		/* No output object. */
 		oic->data = NULL;
+
+		break;
+	case QCOMTEE_OBJECT_OP_MAP_REGION:
+		if (qcomtee_args_len(args) != 3 ||
+		    args[0].type != QCOMTEE_ARG_TYPE_OB ||
+		    args[1].type != QCOMTEE_ARG_TYPE_IO ||
+		    args[2].type != QCOMTEE_ARG_TYPE_OO ||
+		    args[0].b.size < sizeof(struct qcomtee_mapping_info))
+			return -EINVAL;
+
+		map_info = args[0].b.addr;
+		mem_object = args[1].o;
+
+		qcomtee_mem_object_map(mem_object, &map_object,
+				       &map_info->paddr, &map_info->len,
+				       &map_info->perms);
+
+		args[2].o = map_object;
+		/* One output object; pass it for cleanup to notify. */
+		oic->data = map_object;
+
+		qcomtee_object_put(mem_object);
+
 		break;
 	default:
 		err = -EINVAL;
@@ -55,8 +92,21 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
 	return err;
 }
 
+/* Called after submitting the callback response. */
+static void qcomtee_primordial_obj_notify(struct qcomtee_object_invoke_ctx *oic,
+					  struct qcomtee_object *unused,
+					  int err)
+{
+	struct qcomtee_object *object = oic->data;
+
+	/* If err, QTEE did not obtain mapping object. Drop it. */
+	if (object && err)
+		qcomtee_object_put(object);
+}
+
 static struct qcomtee_object_operations qcomtee_primordial_obj_ops = {
 	.dispatch = qcomtee_primordial_obj_dispatch,
+	.notify = qcomtee_primordial_obj_notify,
 };
 
 struct qcomtee_object qcomtee_primordial_object = {
diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
index 084b3882017e..f39bf63fd1c2 100644
--- a/drivers/tee/qcomtee/qcomtee.h
+++ b/drivers/tee/qcomtee/qcomtee.h
@@ -15,6 +15,7 @@
 /* Flags relating to object reference. */
 #define QCOMTEE_OBJREF_FLAG_TEE		BIT(0)
 #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
+#define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
 
 /**
  * struct qcomtee - Main service struct.
@@ -143,4 +144,42 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 /* (2) Primordial Object. */
 extern struct qcomtee_object qcomtee_primordial_object;
 
+/* (3) Memory Object API. */
+
+/* Is it a memory object using tee_shm? */
+int is_qcomtee_memobj_object(struct qcomtee_object *object);
+
+/**
+ * qcomtee_memobj_param_to_object() - OBJREF parameter to &struct qcomtee_object.
+ * @object: object returned.
+ * @param: TEE parameter.
+ * @ctx: context in which the conversion should happen.
+ *
+ * @param is an OBJREF with %QCOMTEE_OBJREF_FLAG_MEM flags.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
+				   struct tee_param *param,
+				   struct tee_context *ctx);
+
+/* Reverse what qcomtee_memobj_param_to_object() does. */
+int qcomtee_memobj_param_from_object(struct tee_param *param,
+				     struct qcomtee_object *object,
+				     struct tee_context *ctx);
+
+/**
+ * qcomtee_mem_object_map() - Map a memory object.
+ * @object: memory object.
+ * @map_object: created mapping object.
+ * @mem_paddr: physical address of the memory.
+ * @mem_size: size of the memory.
+ * @perms: QTEE access permissions.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_mem_object_map(struct qcomtee_object *object,
+			   struct qcomtee_object **map_object, u64 *mem_paddr,
+			   u64 *mem_size, u32 *perms);
+
 #endif /* QCOMTEE_H */
diff --git a/drivers/tee/qcomtee/shm.c b/drivers/tee/qcomtee/shm.c
index 2aea76487372..580bd25f98ed 100644
--- a/drivers/tee/qcomtee/shm.c
+++ b/drivers/tee/qcomtee/shm.c
@@ -117,9 +117,6 @@ static int qcomtee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
-	if (!(shm->flags & TEE_SHM_PRIV))
-		return -ENOMEM;
-
 	return tee_dyn_shm_alloc_helper(shm, size, align, qcomtee_shm_register);
 }
 

-- 
2.34.1


