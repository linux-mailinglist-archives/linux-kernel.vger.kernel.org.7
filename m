Return-Path: <linux-kernel+bounces-811302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66699B52739
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13166883C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E2238D54;
	Thu, 11 Sep 2025 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeVnbJLw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4260239E81
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562095; cv=none; b=GI+BX1l8wxsky0dsl52mbXibEjMbOg/WmMnZPwi2QeU9nCCeILr2yYOXQ2Xr2DJacadualIvk7U8fhiFeQu93KXlFMvK58MPo1w3nRdpWuXllRKu+QkAZXHS9ZKgMAuT/7ZFQIajj2fak7x8QfAiz8di597YPkizyU/35RL8wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562095; c=relaxed/simple;
	bh=/X/slCEZNUYsN1/1Kb6qKCBb1SuAXT+Ssp2opHduLeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI8Kmo9Suq1lAEWv+iLAwkoS2iWK1Fc9FQ/LMmdG/LHfG5YdzSeN5tuR2wRCEXs1e1nybEC4EUh1C4wY6Wqi5+cPHhjiPD95ZK6c3tjBW9D48L6I15ROCq/bS/ByB2NJG2WN8WWOZt4YWfoZStkgbJo5OMK2mWRRgu9wfX4ZITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GeVnbJLw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IoKe026350
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=; b=GeVnbJLw5Qb6NLSF
	K+I9V5+6UJzRozu1AVPFBHRNBqFo/xlaP1Tun07LFpSzEWQZd+6eTTDHr5cvOZds
	OcoGnhLN4RRqeI//u/tzlMGRrFuCT/ZAd1PTTCPJJX37+sv2kQEjBzk7FlZxMrik
	CUNe/UHqQdJu8MWGN6vAQIiEtJI+v2zbsAdxQDunPPvnbdbkg0YXcHxWsX54gb4R
	HupxtCml0LK7/uaI/QqLMd4kzlFcUL9dKBV+qSwdSNswl3otScZYV1VrhBNnpISv
	gnBnjERXypPPCL7T6HaWIJ5eHjoM7g5Bx35bpGBN0nCqBtAyAfSJ8Ui0x7t9L+As
	9uoJ8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0x2vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24e04a4f706so2871985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562091; x=1758166891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfnro9xo+EarbMqRFrPWzRQwLLoVHW/MmAqB1i9xt2Q=;
        b=SPSKI9K5ytpX93iriTFgGOP1x5E3QCoiE+RVp1hy6vWOdXqtAdnLe0B+Pv1ajLqrtf
         XE6J2c9qJvwS1/iCiZ/yn0sjHSyLjhmnbIKg9ubFFJYPmePXvIyvcntdALXtejsEBQyc
         hk87BH8b/3kossLeEWLgMQuOylgJhk188vCO4+vxyD6LzRXKRww5Hc8ZMmXqznUfJEto
         jZwqdEs4goENMW64JWFpOpP6Tz+4R5KJablM0yzwdarCNlh3AGFajrKponI60V8uVp+r
         +mtFhWihbORUA69Dr0MzYjvZtfrAweXavc3w9b//vW0Dc0Zduvvn+QOaeVD2Y6nx09Qw
         vaIA==
X-Forwarded-Encrypted: i=1; AJvYcCXn2s+6pKCvnTUWXix9U7JV4fFHnmqmUgjLgXSI9k9nnUu6sSmZ0Eo76+ghmP3zhRET+XR0dgNBmhf2GTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZMMYmc5c4tz9bXoFl+Zrgp/OtFYxPjOHz3nuXWxias5KOEZ0
	Q8PPq6iNjJfPllddJm8ATtV7GET7/sKG27DvnRLatXFv+c6ZXSOR+xT/fc1RLeSPcqkV4kV+YtJ
	ycrg9gW+TdRW3+pnZ0WVai9m5vdlNwunWdTdaEz4txNW1J3zTZG9Tv9fCd2BVt1+/AA==
X-Gm-Gg: ASbGnct3yc1NVvTRfxBkFU3LNf03+6/eUpZi/sGBcb16fRV0NY/BT8Z9kc2AfgG8myd
	2EPIk7Wsp+IzMbG0BzrwNhQhvRFW0ef2C/ZFSeILS7r8aKURtzBTnOMBHWQslcAjLz32yUteZdJ
	+cn8/tx+lzGheW61NYBgouM3cwUhZyZZIfbXBpXaZtIpM6heJe5BS4CzlExBkdzBMqYYFKjKwLg
	HQdPOnMzMVEbXe6uzVCFfxDCY3Ymk8ixgquTBmg6we4fIHzoXu02Ri/3R3aU/Ict9ebDQCeVTUU
	/WbvcNRfsKKTa/TwZxgnL9JZ+0RPMHfCYqxOBLuBLHAjX5XCQcPPpXhyM122UiMTB3F3YQgCU7r
	TmarZsSb2b7knQ+NnJAq+ftY=
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr238752935ad.44.1757562090723;
        Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2b0ipDRDvZkbzduHPtXWYapgLH3UaQWL1xsBCUzaccisMS56SSp8yl7NyLyuUuiRKSMRPXg==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr238752765ad.44.1757562090085;
        Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:29 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:17 -0700
Subject: [PATCH v11 04/11] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-4-520e867b3d74@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: aEjSVoY2Me5yjPQWK5q8uWCelg7ql0GY
X-Proofpoint-GUID: aEjSVoY2Me5yjPQWK5q8uWCelg7ql0GY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX/ybCRPWMz7mX
 ATEQv0XOwjJTcYmvIsHa1WzvJtpi566sCuhWRAlZu64xYv2iBuq+7kshKRYdZYTP4GkjAiKpvoe
 pXWAGJl57Q3DHwHkz5Gdqh9yA9PDr/Bf/hVL8+MZ4aEWgDhdq4JqC2IiQWi9t+NhZjBhHZCNiMJ
 CiRIUmvbiMeVqdEzXlTgafNzw8p+tG6ULC6SjdvXaPds1STykDFwA+udfvh2tJ+Gu0SGNNV+cTK
 BHu7DU7nfXdbMqdmPxlxZ20cYXaOeuettFDIaXV/XjXlum1/nqNcLqJnoV0DYLlVZ/1Dcf+E/Wr
 TxGf0ROaeSK9jT8LD/nlfmAwJpwtjIbDr3smgcZqZoquWuGPsWtgK080fBAzv0+WbsqpSgKIeof
 ju3L4TfH
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c244ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

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
index 9fa042d80622..f8534a00c56c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -79,6 +79,7 @@ void teedev_ctx_get(struct tee_context *ctx)
 
 	kref_get(&ctx->refcount);
 }
+EXPORT_SYMBOL_GPL(teedev_ctx_get);
 
 static void teedev_ctx_release(struct kref *ref)
 {
@@ -96,11 +97,15 @@ void teedev_ctx_put(struct tee_context *ctx)
 
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
@@ -1075,6 +1080,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1087,6 +1093,7 @@ bool tee_device_get(struct tee_device *teedev)
 	mutex_unlock(&teedev->mutex);
 	return true;
 }
+EXPORT_SYMBOL_GPL(tee_device_get);
 
 /**
  * tee_device_unregister() - Removes a TEE device
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index a9b5e4a6a8f7..6bde688bfcb1 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -23,12 +23,6 @@ struct tee_shm_dmabuf_ref {
 
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
index 7b0c1da2ca6c..456a940d4710 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -76,8 +76,9 @@ struct tee_device {
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
@@ -87,11 +88,17 @@ struct tee_device {
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
@@ -200,6 +207,24 @@ int tee_device_register_dma_heap(struct tee_device *teedev,
 				 struct tee_protmem_pool *pool);
 void tee_device_put_all_dma_heaps(struct tee_device *teedev);
 
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
@@ -374,4 +399,25 @@ struct tee_context *teedev_open(struct tee_device *teedev);
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


