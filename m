Return-Path: <linux-kernel+bounces-579375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93EA7427D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 03:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45593B7478
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 02:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A520FAB6;
	Fri, 28 Mar 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/Dwai4k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602C20E026
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743130106; cv=none; b=YUvJ1v5xkISQAXc1PdLDwaZh9YNsWIYu/eBHgdc4RScaGHUn+8J2bjgcolO36NjXU5JwFrhn5JP/6OdCMjaUqCHr9txM7CyaIwOFxz4EFARwKOBvztqvSngO8HP9lBOEuaVjYf5BRTOVfW3smfeGTtbnj+hSx3f17FcNfEChnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743130106; c=relaxed/simple;
	bh=25YyOD0cfvz2rwatBzUwwRFgfr5kKZXQGbY7cpF2WPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWSgDR5QR+Vgk/toxudO6TRnNT34AUet6V6K8WYnV7IMSnBc4E2eujUR/xqeOFqXXm0xEzyIXgniWLlskV6oOGrzRtpOlSp+hk9/Xzao9Gh4KZtDUvxKQe+uw4tw4ePw3yKnMlIYO3v53qP2qMgzjx6HV/BPzM9M+px+qxcAKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/Dwai4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52REssBb012426
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 02:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oD6ynMzgR/OLYypCHy4fR1UK3tNPy3Cnudnzps7TCgI=; b=T/Dwai4ktfD99Kjv
	tHDPn9Krmp2IkZvw8nr2se2MfeLkavK2CgO27HOcTqHOqZeRHXloKyCohDGgwAsN
	sKyeq00/ARIxfi+1mrCv29TMl/Uubv3xEfBQFsGZa+DkivoaOVFBSajLL8FblqlP
	1MXrRkbsH5GhO2Dv/icM8PbIePwhEBh4iQRPkRHaycJd/5MCY2QxVxgaFJcIe6WD
	JAIhSKkeh1JPb2VgrPeE73OXGenDKvrPKsBpzyOl1e4SG7aJuvvclbAc63wagmPD
	PKwObblCgehiYcpeDcAzIM5hfTIxsWsEH9ZOpCyyjUXRdlcnssxbFKQEJ/SiB63s
	/Hnxpg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mmutmugd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 02:48:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224364f2492so30009945ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 19:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130102; x=1743734902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD6ynMzgR/OLYypCHy4fR1UK3tNPy3Cnudnzps7TCgI=;
        b=bXg49jH73WdU+WbKCL8BhuJA2kxBTsAualPSnvHojZgVezY+Fk68g9/77w8WuVqJMq
         UfQGvIe45lcJJdd8I060yIhQjDauAUHbrmtv+bmIn798mqcNKg+3Tl9cDZFcRmF4pGn5
         wnzvkWpNLdGv2+OOo0ng0BHgg1oU5oxJ5LTsrPF9H/U3bqwYZcytEk7CjJUQYVoRvbFs
         RcKbxEVVmRarbKD79q8uLpMoIzzQKOsnfMrPRaH69yxWUK0eLX4FMbbDhYQCblkjxfWT
         8NgpAl+5vcpP1bGrABHJ+k+JPKn0v/Si71gbk/9u1xIKjeh3jBVsyCtewMcAwQEo8//a
         nZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVFqEqn15JgFA39FMM9AnMbVfCS/GWMg4TaM+gztSwKhfnEFhHA1PvLF5Xthf5OTBinum3jj77T+RrzpXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+UD3nY+EmEMtGlZA1uwlI336U6oy8xpHAcpe3QnNF+uHFqM/
	hBGv9rl6p3/t8YCYjAEBteypqjoX0zjzcm5AowxCdJqvA8FYV1V16cI3Mh/FFaGDv/jLHxz2QpH
	qnSmDGq8DXX2kgezCm8pv4uabbhcCRBRfEeW7olF0V/ZGSfs7OnIxplAtCfudkQ==
X-Gm-Gg: ASbGncsUbHS2+LyFCBo2zNWR7RYgd0T1l2EInVR6WXmrT7H4pOjcMM4p741TXMeW/R0
	5X5muuLu2ohc02b+bbM8LJ3vkRztwfGcNgFGGgP/+ZEH7FsQSV5LOUd8S5Sn/4QQ47comtL7TSL
	qEaEWSu/dWwy8ejA0S4hAHcXdTcZQ+lqAmbzaCSy3RNTJvDMSXUkUCx5YondTkThqRyhw9Vwjrm
	hR8Mu4ag9c1A+m8DYpDXjR+Mz91NHBHcU6VTAGx5VMch1V1ht/jGPF2YR10CX0ehjMzgcK4hnW3
	4jlkygB+w5g+1WiusZpUxzpfN7pzD0FRDkQIl3pIZxXzkSmNDjO//NExYxDyCVK5Z73YsRO4fxw
	=
X-Received: by 2002:a17:902:d2c6:b0:224:1c95:451e with SMTP id d9443c01a7336-22804931e26mr83064555ad.33.1743130101401;
        Thu, 27 Mar 2025 19:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa/X06QnKGsHD0pvPnbCq6SwMO4l+/pFqwaZI4PdfpcrY/9Xo+mcwIA8keQbf/3jNABJjSIA==
X-Received: by 2002:a17:902:d2c6:b0:224:1c95:451e with SMTP id d9443c01a7336-22804931e26mr83064095ad.33.1743130100800;
        Thu, 27 Mar 2025 19:48:20 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca203sm7317565ad.30.2025.03.27.19.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:48:20 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 19:47:24 -0700
Subject: [PATCH v3 02/11] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-2-7f457073282d@oss.qualcomm.com>
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
In-Reply-To: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: 28NVAVJKwWeCx9EagXzEDZGIoLQ6V8fD
X-Authority-Analysis: v=2.4 cv=MqlS63ae c=1 sm=1 tr=0 ts=67e60df6 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=JumTE-0YIu2s3acJSqUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 28NVAVJKwWeCx9EagXzEDZGIoLQ6V8fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280017

The tee_context can be used to manage TEE user resources, including
those allocated by the driver for the TEE on behalf of the user.
The release() callback is invoked only when all resources, such as
tee_shm, are released and there are no references to the tee_context.

When a user closes the device file, the driver should notify the
TEE to release any resources it may hold and drop the context
references. To achieve this, a close_context() callback is
introduced to initiate resource release in the TEE driver when
the device file is closed.

Relocate teedev_ctx_get, teedev_ctx_put, tee_device_get, and
tee_device_get functions to tee_drv.h to make them accessible
outside the TEE subsystem.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c    | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h |  6 ------
 include/linux/tee_core.h  | 11 +++++++++--
 include/linux/tee_drv.h   | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 24edce4cdbaa..22cc7d624b0c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -72,6 +72,20 @@ struct tee_context *teedev_open(struct tee_device *teedev)
 }
 EXPORT_SYMBOL_GPL(teedev_open);
 
+/**
+ * teedev_ctx_get() - Increment the reference count of a context
+ *
+ * This function increases the refcount of the context, which is tied to
+ * resources shared by the same tee_device. During the unregistration process,
+ * the context may remain valid even after tee_device_unregister() has returned.
+ *
+ * Users should ensure that the context's refcount is properly decreased before
+ * calling tee_device_put(), typically within the context's release() function.
+ * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
+ * and release them simultaneously (see shm_alloc_helper()).
+ *
+ * @ctx: Pointer to the context
+ */
 void teedev_ctx_get(struct tee_context *ctx)
 {
 	if (ctx->releasing)
@@ -79,6 +93,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -89,6 +104,10 @@ static void teedev_ctx_release(struct kref *ref)
 	kfree(ctx);
 }
 
+/**
+ * teedev_ctx_put() - Decrease reference count on a context
+ * @ctx: pointer to the context
+ */
 void teedev_ctx_put(struct tee_context *ctx)
 {
 	if (ctx->releasing)
@@ -96,11 +115,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
 	kref_put(&ctx->refcount, teedev_ctx_release);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_put);
 
 void teedev_close_context(struct tee_context *ctx)
 {
 	struct tee_device *teedev = ctx->teedev;
 
+	if (teedev->desc->ops->close_context)
+		teedev->desc->ops->close_context(ctx);
+
 	teedev_ctx_put(ctx);
 	tee_device_put(teedev);
 }
@@ -1024,6 +1047,10 @@ int tee_device_register(struct tee_device *teedev)
 }
 EXPORT_SYMBOL_GPL(tee_device_register);
 
+/**
+ * tee_device_put() - Decrease the user count for a tee_device
+ * @teedev: pointer to the tee_device
+ */
 void tee_device_put(struct tee_device *teedev)
 {
 	mutex_lock(&teedev->mutex);
@@ -1037,7 +1064,18 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
+/**
+ * tee_device_get() - Increment the user count for a tee_device
+ * @teedev: Pointer to the tee_device
+ *
+ * If tee_device_unregister() has been called and the final user of @teedev
+ * has already released the device, this function will fail to prevent new users
+ * from accessing the device during the unregistration process.
+ *
+ * Returns: true if @teedev remains valid, otherwise false
+ */
 bool tee_device_get(struct tee_device *teedev)
 {
 	mutex_lock(&teedev->mutex);
@@ -1049,6 +1087,7 @@ bool tee_device_get(struct tee_device *teedev)
 	mutex_unlock(&teedev->mutex);
 	return true;
 }
+EXPORT_SYMBOL_GPL(tee_device_get);
 
 /**
  * tee_device_unregister() - Removes a TEE device
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..d3f40a03de36 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -14,12 +14,6 @@
 
 int tee_shm_get_fd(struct tee_shm *shm);
 
-bool tee_device_get(struct tee_device *teedev);
-void tee_device_put(struct tee_device *teedev);
-
-void teedev_ctx_get(struct tee_context *ctx);
-void teedev_ctx_put(struct tee_context *ctx);
-
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..8a4c9e30b652 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -65,8 +65,9 @@ struct tee_device {
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
- * @open:		called when the device file is opened
- * @release:		release this open file
+ * @open:		called for a context when the device file is opened
+ * @close_context:	called when the device file is closed
+ * @release:		called to release the context
  * @open_session:	open a new session
  * @close_session:	close a session
  * @system_session:	declare session as a system session
@@ -76,11 +77,17 @@ struct tee_device {
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
+ *
+ * The context given to @open might last longer than the device file if it is
+ * tied to other resources in the TEE driver. @close_context is called when the
+ * client closes the device file, even if there are existing references to the
+ * context. The TEE driver can use @close_context to start cleaning up.
  */
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
 	int (*open)(struct tee_context *ctx);
+	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
 	int (*open_session)(struct tee_context *ctx,
 			    struct tee_ioctl_open_session_arg *arg,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..ce23fd42c5d4 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -96,6 +96,46 @@ struct tee_param {
 	} u;
 };
 
+/**
+ * tee_device_get() - Increment the user count for a tee_device
+ * @teedev: Pointer to the tee_device
+ *
+ * If tee_device_unregister() has been called and the final user of @teedev
+ * has already released the device, this function will fail to prevent new users
+ * from accessing the device during the unregistration process.
+ *
+ * Returns: true if @teedev remains valid, otherwise false
+ */
+bool tee_device_get(struct tee_device *teedev);
+
+/**
+ * tee_device_put() - Decrease the user count for a tee_device
+ * @teedev: pointer to the tee_device
+ */
+void tee_device_put(struct tee_device *teedev);
+
+/**
+ * teedev_ctx_get() - Increment the reference count of a context
+ *
+ * This function increases the refcount of the context, which is tied to
+ * resources shared by the same tee_device. During the unregistration process,
+ * the context may remain valid even after tee_device_unregister() has returned.
+ *
+ * Users should ensure that the context's refcount is properly decreased before
+ * calling tee_device_put(), typically within the context's release() function.
+ * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
+ * and release them simultaneously (see shm_alloc_helper()).
+ *
+ * @ctx: Pointer to the context
+ */
+void teedev_ctx_get(struct tee_context *ctx);
+
+/**
+ * teedev_ctx_put() - Decrease reference count on a context
+ * @ctx: pointer to the context
+ */
+void teedev_ctx_put(struct tee_context *ctx);
+
 /**
  * tee_shm_alloc_kernel_buf() - Allocate kernel shared memory for a
  *                              particular TEE client driver

-- 
2.34.1


