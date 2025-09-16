Return-Path: <linux-kernel+bounces-819513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC005B5A1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E612B2A332D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C92E1F10;
	Tue, 16 Sep 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBSD+Wc7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD89284B29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053278; cv=none; b=g9CID8RJzbs3XnD3c6mKFCe7U322HiiIagtpEgIleMX0EMFRh1oeUifZtaT8Tnee99fiGXrIPMlaIw/zsZ8xPU4Rb2N0i+nV0DxPV+qbeKYtLBL5ehKd3d38ve2G94G/lmAenpGlccWI48OEEb39C7c5G5ZgCFAa6MWmzcY84is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053278; c=relaxed/simple;
	bh=FYWKoGM6K2ROxYHe23Iz+hHjqAHZKK7Ju7PsxtaCv+w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ceOSmrWWQ5bCuxl9Ju8/xU2KQ/zppZmKM84RhNxne+k8a2Fiwp9pYpvorNR6vRvPsr7mqM4V7NZPAMeLdPctdUpW/kiVj6GBQDdHNlt6sLB6HDn5KjU/bOSVzrYGbGSNpQYh1RtW9ZwQynvrfCSu6jeKhkGj3abgLwzjKNlJgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBSD+Wc7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267fac63459so3716275ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758053276; x=1758658076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVy9IJbUt8NSG5ndvXlAVaLeRJY3F9ksUD0wGwN4LFQ=;
        b=FBSD+Wc7JKa5dUO7U6qt09P6Uig1CPCDEfWftQuP0s0nMuMV5ZM5rzz5nxRLwNyzO3
         AUVIz//3+0tGdJ+xypr9klcBCGMDps8LOpqrkVQ6qy0g+kcJM1rSB2OVZvtGr3RUb/y5
         C5XMA6ikZi6e8aOc9pEymnXSDyT5rq8qYJtOyERLxj0/tG6A0ZE7WgfgT95TL8FrFnNI
         KHtqkCRjTqHTtZYCL+JajgynecDtkdleYlEr2AmxH+5Xlj2r0OShnValb89c1ngjI8mS
         DXqnvqQMjXO9tiP0qxZitkZgcrBxuN+hN8BTsyvbt7dLQl61+bUEKlWCFy19Y/bluahD
         cwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053276; x=1758658076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVy9IJbUt8NSG5ndvXlAVaLeRJY3F9ksUD0wGwN4LFQ=;
        b=hnsJVLXcOSyOoEfQErPXUPZ7LzNZ/AxR4AIBcMQuBoc8NtE2ClNgDFAmnxK88Ti6br
         RjM84hsoR9QBa3RGlHYiA4hJbNUY7NgBZLSKxaoXX51YeyKG+yP1cIW3rb1ii6TURqTS
         C+tjoYcN3Uo1y/iqv3Ne+Cz3yGw9BF8S2jZLjIngXsS3y37t1Y3SV75BalKKiiwj60Kj
         paZ2mezvtYh7bwNfbwruEcFBbzoA10zsl6srueQZ8tee11ZybSW5TgkGtFRebs7vpav9
         37WW9MhEzFsSkNZS5jgSfWoxV85E9pWAoC+ZWAJapQu6ztqhxvm8POUgRpXnYug/oYT3
         8xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn0TBsAZgi5LuZoayclHaycKdU7N/ntSyTJ1D3X4vPnLeTMH9Q7l9jtJbwG+tejos5vJknAE4G/QjaRO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxss18rgdscMUbgHcQTx8OsT1ragAtF9L4HmnJrHnd31ESJCC1p
	uPOo0mydsl8rnDvefOHSMdMFOnWfM0OZWKYBUkiaVzJfcCcX3ABNDWLQ
X-Gm-Gg: ASbGncshkeGZNvfKJHB0QRCpx0kqZh+Mlrae6wCjzbXkSd0TVjderFJLDHRjRmkW/fi
	UkEhhJmqotzkZ75xxVOGUh1UPTbh9kGaD7HRFKR1CP68mOXH9nrQ8JwS8eE+j9VTyCmzKyrufr+
	RisEk5H/2qJ6beIEOKt7VjYKAF/9LQjNXxR50MlDS5oGttmOaF4e7UWrTsL4yfkyijTen7pF7cF
	llCcqMuKewpZbkKHpUD6rfG9tOCDVZfW/YR8L7xhi/g0wg0SXhCupapjdr8U/I7zuIw7sm1ZOFF
	83JYPM/wLsMcxQeAWhw38/5dquqZlANOk6czP8mRiQzACmvpw7bns/g5jydU33bnoVDstRpSNQs
	Skrblh66aSjWqsYhl7eTUQZMjQX2QN/OzdZUp2n/LA41jFDByVEDs14H8/9Ec9DFmGowvPxtKcj
	y6I6qdR92daA==
X-Google-Smtp-Source: AGHT+IGhe7iEA8JDYWw15YUB8w09Fjtdaq1h4k0rGkJNG0xT/1Yl/OuAgfJg8eLoRX64JJKJCO9vzg==
X-Received: by 2002:a17:902:ea10:b0:24e:bdfa:112b with SMTP id d9443c01a7336-25d289e9988mr189662935ad.61.1758053275706;
        Tue, 16 Sep 2025 13:07:55 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25d9c3feca6sm137518715ad.95.2025.09.16.13.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 13:07:55 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: add query for calibrated timstamp info
Date: Tue, 16 Sep 2025 13:07:51 -0700
Message-ID: <20250916200751.3999354-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO provides a way to query
and calibrate CPU and GPU timestamps.

This is needed because CPU and GPU timestamps are captured separately.
The implementation makes an effort to minimize the capture duration,
which is crucial for calibration and not exactly feasible from
userspace.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

---
The query is inspired by xe's DRM_XE_DEVICE_QUERY_ENGINE_CYCLES and the
naming is inspired by VK_KHR_calibrated_timestamps. The userspace change
is https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37424.
---
 drivers/gpu/drm/panthor/panthor_drv.c | 88 ++++++++++++++++++++++++++-
 include/uapi/drm/panthor_drm.h        | 31 ++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index fdbe89ef7f43c..06da6dcf016ef 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 #include <linux/time64.h>
 
 #include <drm/drm_auth.h>
@@ -172,6 +173,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_calibrated_timestamp_info, gpu_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
@@ -779,6 +781,74 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	return 0;
 }
 
+static int panthor_query_calibrated_timestamp_info(
+	struct panthor_device *ptdev, const struct drm_panthor_calibrated_timestamp_info __user *in,
+	u32 in_size, struct drm_panthor_calibrated_timestamp_info *out)
+{
+	/* cpu_clockid and pad take up the first 8 bytes */
+	const u32 min_size = 8;
+	u64 (*cpu_timestamp)(void);
+	int ret;
+
+	if (in_size < min_size)
+		return -EINVAL;
+	if (!access_ok(in, min_size))
+		return -EFAULT;
+	ret = __get_user(out->cpu_clockid, &in->cpu_clockid);
+	if (ret)
+		return ret;
+	ret = __get_user(out->pad, &in->pad);
+	if (ret)
+		return ret;
+
+	switch (out->cpu_clockid) {
+	case CLOCK_MONOTONIC:
+		cpu_timestamp = ktime_get_ns;
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		cpu_timestamp = ktime_get_raw_ns;
+		break;
+	case CLOCK_REALTIME:
+		cpu_timestamp = ktime_get_real_ns;
+		break;
+	case CLOCK_BOOTTIME:
+		cpu_timestamp = ktime_get_boottime_ns;
+		break;
+	case CLOCK_TAI:
+		cpu_timestamp = ktime_get_clocktai_ns;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (out->pad)
+		return -EINVAL;
+
+	ret = panthor_device_resume_and_get(ptdev);
+	if (ret)
+		return ret;
+
+	do {
+		const u32 hi = gpu_read(ptdev, GPU_TIMESTAMP + 4);
+
+		/* keep duration minimal */
+		preempt_disable();
+		out->duration = local_clock();
+		out->cpu_timestamp = cpu_timestamp();
+		out->gpu_timestamp = gpu_read(ptdev, GPU_TIMESTAMP);
+		out->duration = local_clock() - out->duration;
+		preempt_enable();
+
+		if (likely(hi == gpu_read(ptdev, GPU_TIMESTAMP + 4))) {
+			out->gpu_timestamp |= (u64)hi << 32;
+			break;
+		}
+	} while (true);
+
+	pm_runtime_put(ptdev->base.dev);
+	return 0;
+}
+
 static int group_priority_permit(struct drm_file *file,
 				 u8 priority)
 {
@@ -815,6 +885,7 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	struct drm_panthor_dev_query *args = data;
 	struct drm_panthor_timestamp_info timestamp_info;
 	struct drm_panthor_group_priorities_info priorities_info;
+	struct drm_panthor_calibrated_timestamp_info calibrated_timestamp_info;
 	int ret;
 
 	if (!args->pointer) {
@@ -835,6 +906,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(priorities_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO:
+			args->size = sizeof(calibrated_timestamp_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -859,6 +934,16 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		panthor_query_group_priorities_info(file, &priorities_info);
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
 
+	case DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO: {
+		ret = panthor_query_calibrated_timestamp_info(ptdev, u64_to_user_ptr(args->pointer),
+							      args->size,
+							      &calibrated_timestamp_info);
+		if (ret)
+			return ret;
+
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, calibrated_timestamp_info);
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -1601,6 +1686,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.3 - adds DRM_PANTHOR_GROUP_STATE_INNOCENT flag
  * - 1.4 - adds DRM_IOCTL_PANTHOR_BO_SET_LABEL ioctl
  * - 1.5 - adds DRM_PANTHOR_SET_USER_MMIO_OFFSET ioctl
+ * - 1.6 - adds DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO query
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1614,7 +1700,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 5,
+	.minor = 6,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 467d365ed7ba7..7f3ff43f17952 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -243,6 +243,11 @@ enum drm_panthor_dev_query_type {
 	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
 	 */
 	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO: Query calibrated
+	 * timestamp information.
+	 */
+	DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO,
 };
 
 /**
@@ -402,6 +407,32 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * struct drm_panthor_calibrated_timestamp_info - Calibrated timestamp information
+ *
+ * Structure grouping all queryable information relating to the calibrated timestamp.
+ */
+struct drm_panthor_calibrated_timestamp_info {
+	/** @clockid: The CPU clock id.
+	 *
+	 * Must be one of CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW,
+	 * CLOCK_REALTIME, CLOCK_BOOTTIME, or CLOCK_TAI.
+	 */
+	__s32 cpu_clockid;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/** @duration: Duration for querying all timestamps in nanoseconds. */
+	__u64 duration;
+
+	/** @cpu_timestamp: The current CPU timestamp in nanoseconds. */
+	__u64 cpu_timestamp;
+
+	/** @gpu_timestamp: The current GPU timestamp in cycles. */
+	__u64 gpu_timestamp;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
-- 
2.51.0.384.g4c02a37b29-goog


