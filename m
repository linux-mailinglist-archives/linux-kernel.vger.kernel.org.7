Return-Path: <linux-kernel+bounces-729250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828F7B033DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8484E1898B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74751AA1D5;
	Mon, 14 Jul 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p09MScsi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA118C332
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454224; cv=none; b=t6riebsetqWi0wOycat0WpPKW445bzbeaGLdDNqZRu2s9067/WgKl297Aq/oTUNEGlMVFF9C3pcSvB/qBI+VZh0cs7pY4scZeBWz0eY573tzcYYsyHnOEKsR6+T/srx/MgLa+3ovRUQH+7GhPrSeZ4xyvKMlNjtVh29liTYGVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454224; c=relaxed/simple;
	bh=/7EXQJB73/5gvIoUTG6KNRo3AVFSgdFix2K94IEW4HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvU9Ox5UvY/BM2qTHR/8z3YNmIH4W5CYfhlo8/Y5aTIsOkZsy6pKwUvgOBIUQZWx0FurjqwF3Ga2XokG+YcDib9NS3h9p8yGI3OyG1md5qgTpb+Ln8hr0aAv5czdE512y0htYIWh1D0dtTSjsjMwHaGdoR3a02euz0/JwDFTVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p09MScsi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLwNLm022366
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=; b=p09MScsiKDK6DM53
	DAhUDQah5I2Tl5ACEoaNgdyS6NZ/0wIoRefyau03Qni+RzdH1KEER4tGq1nqa40x
	EbkkEk8Nwss6S7LhrSG8y5n4oN80pno/CHHeBJFBTT6FgthVy0nUvL6pZWU84vlO
	TllYBfcetWPomThXp/zDDvx3Mwv6du03PAaGpkL2USJhl5s9PNTye1lbwzLg4Ctc
	AuJro/wV5g4Ef+ugpqwnJuqrz2ARrzmpAdCMatd+IlnAXa2+BRfk8pJdc1KatU9x
	umOdGQ9sj7P7LcigSSYZXJDQ7gsJPHMJrx9e1ovA7w4dlFdRLqkFl7uxhMPFDXfY
	/Hryfg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvxaug9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23536f7c2d7so62442095ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454221; x=1753059021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvkKKmGa22ueSGt3EngA9F+r5r19tnVaQ1z09ewqLKU=;
        b=kK7wl8Q4D+6oC0/pKLchNPWvtWLduk1pA3tvElT9G42G1ncYFkZhA/Wpqprp4T0Uw5
         jfolRI48WPVg8GKDZnJy1G60CtWf+hFmG0hIMmkwSupxXD3pxElqoRpfxXKw6qh4D+iC
         nOhObKbcbN/GazonnnlMcgnClRjzEUI+dHVFM+KU42IGaJHGl02z86ef+sXgTk+Y6Bko
         qLnQlFZBduBS3lkTvYw/jHYRa1H42Uz2UKkW68ep3/kFxKLD0xJjqy9e5DeNBhttzcMu
         2laJV5RbC3nO1Ui58q8ElPFD+lI54R7mhR6hNNef7blYjckmc0Eyos7DyHWpBtbnGW0g
         Czwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTH4yl9J0RC83YUuLqh67E8EhLzaOOsi4YLWGXzYiyUdUI4oRMPPsilLOxAh/wWqPoXgFIWrDIuPk3X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+IZk+iX25+pqKTHX5Y1QEj6YDjeQVU+L6aeQwGPjWIjnEEMo
	UXcHcEpcjgZdC4Ll7PCjqHsUNpnfgZhnEdiYNS++hgl9PQw5nIkLXvgVfV0AkBlAzHJpeNmUc0q
	p6hW0nFhSOamXNX/Kod4uOyHkuUHd3rVeHG4QByV7mrQlEuyVdVLVhiROHGEDgTj94w==
X-Gm-Gg: ASbGncs6z5TP+eFaMJPrQa2wcME1vG6CpY9Cdh62XfytysCP875QF0xDBSSGhkx0fgb
	w18DgyyodNIvAw7ZoSYSCGV8jU4lyZJjuzHYV///lUE8rqTa6deamRLSFtnryypcQWy24Sucfi3
	+DvJaEMW5iSfjpdQFQtx52TtUvARUdxVPlanCbsQIQcBAzxoMjRdRYNLRxf/HIXw06PiMazrLh6
	L8khzbApK4JWTu2x5j8fQVA0edQxeri2MfATAq91W6AaaifmpKkHbA7YuMjhoDR8w5iSbH+l5/e
	MKcdW3PkQWpaG3VOn8uHUe8hTZqCH5lGG4xI1zdBiM5Tjab3j9AzZ1wUmWDdge7A59Vo5jhYVSk
	mzwdZlj81sL6W2LICGPkL09k=
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193358255ad.43.1752454221391;
        Sun, 13 Jul 2025 17:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5X0qUNlSCOYZOXc+6fFe7qW/RjprPxFG+s/k+fDKrAs5f5Q2JYKfn8YqH6S388QYdLFb30A==
X-Received: by 2002:a17:902:cf0e:b0:235:f078:473e with SMTP id d9443c01a7336-23dee262fb5mr193357925ad.43.1752454220976;
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:14 -0700
Subject: [PATCH v6 02/12] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-2-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: qj1m1kXlrYFy_bMfoEoQQaJT_HH9xmMb
X-Proofpoint-ORIG-GUID: qj1m1kXlrYFy_bMfoEoQQaJT_HH9xmMb
X-Authority-Analysis: v=2.4 cv=achhnQot c=1 sm=1 tr=0 ts=6874544e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX0rSmZYSn4tZv
 eUQWvFZYI+BmKX29EUsNGU3cr4jNyde56n4dknbrQnqHJ00OXNBoTAj1LGPaJO9PBHyEL1JXr8G
 a0QpxUL0P3lRh4ZIYRh7kmuf6Oxm6fQtkBTbQLOpJXF1n6qDftRyySt8kEPAGWb2Cbif7bqEifm
 ysTsqBBftXTynEAwFKT9h40IBKi28MkdRQU0egM4qrzlWxAfMEQrrr2kxPDsAcjPpdKdrrWHSgv
 8yPl4VvzTRXcJQoUqx2Qq0+zPmq5IgLWVEAcDM2Wh21UXtXG0+8KAt7UmltmAr3LSGiGuoTsA0s
 KPWle/dY+Q0b+9MexD1Ha4SK0YnOxT5kJU8Ts5HCCX1GBi6lBmvDgwc3zL5Szp49I6Rm9UFg9I5
 mu5C0wU87MKnZl1qfI5+O/Y+pWMbOtVmePXulEiM09DIWFx9S04xa7Q5ACAsV5lEEijj1wi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002

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
tee_device_get functions to tee_core.h to make them accessible
outside the TEE subsystem.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c    |  7 +++++++
 drivers/tee/tee_private.h |  6 ------
 include/linux/tee_core.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 133447f25065..b9ea5a85278c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -80,6 +80,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -97,11 +98,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
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
@@ -1038,6 +1043,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1050,6 +1056,7 @@ bool tee_device_get(struct tee_device *teedev)
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
index a38494d6b5f4..284ca6b3e03a 100644
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
@@ -154,6 +161,24 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
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
 /**
  * tee_device_set_dev_groups() - Set device attribute groups
  * @teedev:	Device to register
@@ -315,4 +340,25 @@ struct tee_context *teedev_open(struct tee_device *teedev);
  */
 void teedev_close_context(struct tee_context *ctx);
 
+/**
+ * teedev_ctx_get() - Increment the reference count of a context
+ * @ctx: Pointer to the context
+ *
+ * This function increases the refcount of the context, which is tied to
+ * resources shared by the same tee_device. During the unregistration process,
+ * the context may remain valid even after tee_device_unregister() has returned.
+ *
+ * Users should ensure that the context's refcount is properly decreased before
+ * calling tee_device_put(), typically within the context's release() function.
+ * Alternatively, users can call tee_device_get() and teedev_ctx_get() together
+ * and release them simultaneously (see shm_alloc_helper()).
+ */
+void teedev_ctx_get(struct tee_context *ctx);
+
+/**
+ * teedev_ctx_put() - Decrease reference count on a context
+ * @ctx: pointer to the context
+ */
+void teedev_ctx_put(struct tee_context *ctx);
+
 #endif /*__TEE_CORE_H*/

-- 
2.34.1


