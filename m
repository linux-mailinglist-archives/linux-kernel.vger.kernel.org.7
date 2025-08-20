Return-Path: <linux-kernel+bounces-778679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3FFB2E8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFE7B5371
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D72E173E;
	Wed, 20 Aug 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUohvgVA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE12E174C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733149; cv=none; b=GrtZnNON73AncQ60i5fcLl53aBdz/sNjhu9A1tMQ5ePpiM5BNozF/6JzaJIrxvzZBdt8TNqI2gP0HSfbSjl9081CSQz/sUKctW51JSUII0U1XaciUXKVN83j+i4w5XNzmZzMMK744eCuHhFyX1vRPXZsRuBA3/I0tHgqZnDUYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733149; c=relaxed/simple;
	bh=8TSbhEgUPN9kdxwy9KCMFyUVP58G/S0fhvuvLlT55sU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ts5tpH4gFCIvAbEeibyDCMlZmivuJVcpDmr/rB0q8vQHhxYYn3Vk0x3bFDcqqr6m86OnHXkdsaDAP+6lkSpfCskp09aw7BXjxJa/q00rjOlZn4VZWY/w6+WHXlT60oO7F7IW/W4jEIVqVdita8n3J/n1A6wP+DcCwwAPE8e6hqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUohvgVA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCwa4021506
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=; b=UUohvgVAC6/xeBx0
	nF9dddAlvTdXBpQPclk9dzrpmCD2+oqqo+Uo67Zyci1m042Roh4vvXjEphIPRCnC
	xBo3E3WdSEXGrSAnumZwrMm7+emvHFW3xNMfV6j9JQcJPlqClFdBpK6OvPohHK6a
	p3BUYaTRLQoC2gkQ2+ZzKP9vU2idHGb5wDD72/7MemqPsjOb8OzD/jwQYWuGiFh5
	wwOFk6XMKScxpgWJGRiUlmOh5RG5DjuU8PQZW43DWCzfULV+1x3OfmTKIxNIRWoS
	71beTJTVz2hNxW8Zx3ixgME44f21ENFxquT8QZa/G8Z6mldeht3oAu7y+EM3sfGD
	8vrEAw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdh7k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e8bb2d2so399263b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733146; x=1756337946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjXvseb+vxS0ErbDImEwiyaXgCwIyoxRM6Sfo6q8WkU=;
        b=UriK2qUr5mzfhLRi/az6nzJdW3evZVhEGaq8B7fbaLwjQhzUslpVxHk05Gnm3huX7a
         HliF57KMSDj9b1Xilrx+yBoLYesvTRsX8ttPDRzjW5Xln2vfSdlNjJKlUtLfv9wCux0L
         GYkYpM6ym40OHXb+Xrk+uIucM9GhB2ZrmSjjgpAKw0naEqLdDTkOavSSxuFI8jnaF7EV
         nxdEh5ftqTd3qAP5malI+woVWabLaZp6gxg8JzoXjrLxG/K1J97pK5IEMMGij6D6SCuW
         gW4Gg8f8+kKIG9ehg9HQJPQJES3WmoWRXKDesp+qi9lWik0H1dSqz/P18bicL59O9uju
         6beA==
X-Forwarded-Encrypted: i=1; AJvYcCXnUqjtSvMZmG2IBc0rRwklR8W+KgL+ohCU2TOu+7vhLnFwguYsFwCNx6XotY4EeVcmgwuXe3TTj7lB06A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqNdezUo8iR8roeJPlk8P7fZNS2T92W4dYgy1/DExM/5Ypswz
	Cn77QVlRwcLdkkH8YwWpGoR2SGmrmbw0rhNmrIyry5tGBVzcgu93lQah7ol2dBfr6c3ZafwzszO
	554j5C+nZB7PcJHQ57ksDankSRg8MvELXnSm1Og+pwie63y348/S+ktkAeFX6Mq703Q==
X-Gm-Gg: ASbGncvmhBZBPNPVU9LkqT3CX8RvjOr4L7Mx48uocZjRjGEAwr36icM5hoGCUdQzyV4
	285BO9oOvLbyf1e0QDkd0ikzS3CE2lyxbMViFrKUspuXmbOnRLbI/tzuD3gOrsUq+gbNCeGesby
	NxIHv4m9RZXb0y14pTjTlTKYNxsmog0b1rJ26C5A1Yu57laLqupFann6By2yOLjDKCYL558rOfq
	UIFrBdGYOByjyXAmBlHnsTfsuKCH2GhrXNZRxx9CjtMMYQ0GRaguM56GbWzr6j41qrnc1rDwqLe
	lIqqbOV8KSst2ryURG0pEbJtQn6AZ+tQHKpO/P7G2Lspy4iikgMsS3gBeUWiD2QR4oC7HQyMGho
	nUvtSrJgKnqFL17zI0UtkAkY=
X-Received: by 2002:a05:6a20:3d88:b0:243:78a:827f with SMTP id adf61e73a8af0-24330b8dcbamr357839637.55.1755733146271;
        Wed, 20 Aug 2025 16:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW+KaAV/nBrLnv/qlXOwf4dct+JxrcsmBBWHr84rfokHUyeJCKYtrKukW6uPfBBauTFRM8aw==
X-Received: by 2002:a05:6a20:3d88:b0:243:78a:827f with SMTP id adf61e73a8af0-24330b8dcbamr357794637.55.1755733145802;
        Wed, 20 Aug 2025 16:39:05 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:05 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:49 -0700
Subject: [PATCH v8 02/11] tee: add close_context to TEE driver operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-2-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a65c9b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=0l_YNDiMcOfTHwIteTYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fqPZvrqRcKEPVARs4YCVNpB55Jz_RIsR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX7A3E6Ov7RQMT
 DIVp3BhqP4QdY7w/pyDvDa/M9hwQ3/vAU3a9jfv3+DjGsDYD11f3Wa0zWfQByOpyisSSa0pg7ru
 51ssMCtTyjVIG7/KIEtFMTsvXo/qrKydXYVFOkLzzYZN5YNlH/jMvxmH5n+AVKu8TLQjcj4p+Bi
 uG6G0Fn1XrZv/erSKlac38e2Q7oVuNJGXAgaqj8Wqusxe0LBK5NKxcyzqDY9wa2tx+CPOF57AdB
 qPtjK0gk2uyCL4Bv/CYy8MBPkDVlVWdMWd/wXOf5zuhb+bhQ8MA1BwVWYUv81MIHVboLqiR5RRK
 vj9iWESPYnYX+3A3GoiuQEnNoXN1/VJNldhoIfdRTXmInyCvZ+Iaz22lQUOAxKQVEtYmIMHfHIk
 7nJK4HkhbqYbKVacNMRgVXmPg6r/7g==
X-Proofpoint-ORIG-GUID: fqPZvrqRcKEPVARs4YCVNpB55Jz_RIsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

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
index 33091aa21be0..0b4c65dc14cc 100644
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
@@ -1001,6 +1006,7 @@ void tee_device_put(struct tee_device *teedev)
 	}
 	mutex_unlock(&teedev->mutex);
 }
+EXPORT_SYMBOL_GPL(tee_device_put);
 
 bool tee_device_get(struct tee_device *teedev)
 {
@@ -1013,6 +1019,7 @@ bool tee_device_get(struct tee_device *teedev)
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


