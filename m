Return-Path: <linux-kernel+bounces-790664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B721B3AB85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D067BA0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232A29A9FA;
	Thu, 28 Aug 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/ghq1QA"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDB286D79;
	Thu, 28 Aug 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412300; cv=none; b=IUIWbjzp7FBMlpUafMcBB2rpkIFPA+H8ONyD+xjzRx5D20gvMkg8OnEM9lCUCSvTxQV0CM21IADsw4rQ/w6/b5vGqWcJt0mGoVszXBcn6PBqP7jDPKiVP5hLdU8dBIG2dNXAvuTNaSOdDUplazKRAaZ8XHISIdE2JTax+BXLHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412300; c=relaxed/simple;
	bh=ZaVIRMJhXI1P6ksS9bfyx3rPniN7IpF9mt5jwQjmKC8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEF/PyFoWxDxZ/9K7uHf3oGBqnC4JV1vSZqHqYBrzOO/Y1bneFeIr0hIASpRczaR9FhMqAEmB4XIv1SNmqDtCsCkq5MtS5pu4o12aczWNje3QIfCWij7PcwhzXcdB685PMCAm1rOeb59XWpM9qJZsBRkTviX1ofE4IUMnYr+7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/ghq1QA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248ff68356aso3120355ad.1;
        Thu, 28 Aug 2025 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412297; x=1757017097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtNtHtpX6cwpdlCSf6IZNelTQKKXWtfsWOt1Fcnzscc=;
        b=C/ghq1QABMtVtyNcMRXdseawb6vScKdOv4wREjT6kdnnjoOczZtjiGAiGSj3en1AD/
         1iXXctrirl3pZzUfdkp0PDcOuzKc7839PUt/rpkNO/IKZ/kVsCqIFPqJmGi4TBUa+TYd
         QC0Mi7wxP5pO1D4TpmnHRXYDee3cNgTohhzgA/eM/sDT53oEqaNupLNizkeLIll74Dly
         TqCBFbVi06ABI9vB6GayHbVnrZURc/KEtSNUtdcNRgo2nFDv0h0L5pvtJjQDOtSiG5t4
         2Eg7TnEyNcmJ0Ld1x5+AQ727KUXMw/UYRstBr8gOO3H8z0tuD7CFaWrIwiuRzmSzcLA2
         GD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412297; x=1757017097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtNtHtpX6cwpdlCSf6IZNelTQKKXWtfsWOt1Fcnzscc=;
        b=JVCmmUq6qeWRU6FJKCKEYF15VT5W70RI0NW2LCG6cKb6bpzUlKtsNn7wc8O3xftw2g
         Vxy0PRWBkrNJfpO7pS0SiIKbSje+Ps0aHMg9vt+dHKqk/S+5zp+OauGUNj/VkS4abQfo
         B6npqnJwlweNvBXhjF4tEB9WxpSWMGfGIipfCBhODMbJbu7VVP9ZO9hJfWTDldQbxKWV
         T1VTAi0zIvyNe4WQcLG8qDZEeCAhL3pznofTcV70PGU7JwYfVEBk6pyp7GJd+6EJ+I8D
         Bxk6r6G3Wi/ecFvOc9ctTn8iK0hcGxHJp4UHHyj+DEfYjo6xcm1bgql6TWmYJDHtkwAJ
         ngNA==
X-Forwarded-Encrypted: i=1; AJvYcCViycBSQsdIsGLng+3slmjsnt1xWmPU4epF6KDqvFle0Ta9R5NoIojk64sogZQBC3VG3CMfuLnJtFmb@vger.kernel.org, AJvYcCWoIMvN/v3jd87xlsonG7fg7TkSWe6q62B0b89Hz//id7msD2K3G9vvLspAbdWByK7QikJVvYCdh5mpLzsz@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCBZWnOgYbX/pFrthjFl241ejfpJkeun48CX1vRZGAIQ2HWhX
	8C1oE4t91KOvVSUV9v+olx1ItQQvEyoAOoNF1HRgprT3fPRqdjMvJdUp
X-Gm-Gg: ASbGncsdaX3NCvxnsz5NYJncMQvx7zIF2eJYeo3MIYA+ii3rrjcR/FuHR9lqQd9RIPa
	dzQ+X0H9YANgNDhJg1SIjc3m/jd2OM+Q1UUG6XQZWDQKTd3S+6vUBtehu+ZYNV4nL7zr6bRYd51
	LKEMjKKeFgI49/hFUrLL4MdHtxIrvf6A3NHINW+2BOaVX2d7v9ic4mcx0KCtDTtynWJ3U9mzXxL
	HtqEa92Vp15SqjPp+GbL5rvt3GX8fvTc4rIT8eKL3YRbws/nBzNSE+OmtAuSQbYJZVQZGmluXWR
	vtJ6WPQmMs7ICn+UfH9gjIZnhJl7vDfAl0wbiZpdQfBa75dNhABLOtU2hbArQ3Mb4ZlyIjkb8iq
	mm2iiD5Afs4kpcTfbrxn79LrG4k9r4axrxkuVa7+GkIqmH3vl8W8BwA==
X-Google-Smtp-Source: AGHT+IHdvgZE9elNuilpdJmHAmrR9bz/FHuSwffSn4LpAt/hyDZky5BitNwDNYRDvRChN9DFOLrWww==
X-Received: by 2002:a17:902:c408:b0:23f:fa47:f933 with SMTP id d9443c01a7336-248753a2734mr142729945ad.8.1756412296801;
        Thu, 28 Aug 2025 13:18:16 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905da478fsm3754525ad.65.2025.08.28.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:18:16 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panthor: add asn-hash support
Date: Thu, 28 Aug 2025 13:18:06 -0700
Message-ID: <20250828201806.3541261-3-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250828201806.3541261-1-olvaffe@gmail.com>
References: <20250828201806.3541261-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse asn-hash and enable custom ASN hash when the property exists.
This is required on some socs such as mt8196.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  6 +++++
 drivers/gpu/drm/panthor/panthor_gpu.c    | 17 ++++++++++++++
 drivers/gpu/drm/panthor/panthor_regs.h   |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 81df49880bd87..19423c495d8d7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -41,6 +41,30 @@ static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	return -ENOTSUPP;
 }
 
+static int panthor_gpu_asn_hash_init(struct panthor_device *ptdev)
+{
+	int ret;
+
+	ret = of_property_read_u32_array(ptdev->base.dev->of_node, "asn-hash",
+					 ptdev->asn_hash,
+					 ARRAY_SIZE(ptdev->asn_hash));
+	if (ret) {
+		if (ret == -EINVAL)
+			ret = 0;
+		return ret;
+	}
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+		drm_err(&ptdev->base,
+			"Custom ASN hash not supported by the device");
+		return -EOPNOTSUPP;
+	}
+
+	ptdev->has_asn_hash = true;
+
+	return 0;
+}
+
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
@@ -257,6 +281,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_gpu;
 
+	ret = panthor_gpu_asn_hash_init(ptdev);
+	if (ret)
+		goto err_unplug_gpu;
+
 	ret = panthor_mmu_init(ptdev);
 	if (ret)
 		goto err_unplug_gpu;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4fc7cf2aeed57..6f8e2b3b037e5 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -114,6 +114,12 @@ struct panthor_device {
 	/** @coherent: True if the CPU/GPU are memory coherent. */
 	bool coherent;
 
+	/** @has_asn_hash: True if custom ASN hash is enabled. */
+	bool has_asn_hash;
+
+	/** @asn_hash: ASN_HASH values for custom ASN hash */
+	u32 asn_hash[3];
+
 	/** @gpu_info: GPU information. */
 	struct drm_panthor_gpu_info gpu_info;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index db69449a5be09..f9222b67f314d 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -52,6 +52,22 @@ static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
 }
 
+static void panthor_gpu_asn_hash_set(struct panthor_device *ptdev)
+{
+	u32 l2_config;
+	u32 i;
+
+	if (!ptdev->has_asn_hash)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ptdev->asn_hash); i++)
+		gpu_write(ptdev, ASN_HASH(i), ptdev->asn_hash[i]);
+
+	l2_config = gpu_read(ptdev, L2_CONFIG);
+	l2_config |= L2_CONFIG_ASN_HASH_ENABLE;
+	gpu_write(ptdev, L2_CONFIG, l2_config);
+}
+
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
 	gpu_write(ptdev, GPU_INT_CLEAR, status);
@@ -243,6 +259,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 
 	/* Set the desired coherency mode before the power up of L2 */
 	panthor_gpu_coherency_set(ptdev);
+	panthor_gpu_asn_hash_set(ptdev);
 
 	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index 8bee76d01bf83..c9f795624e79b 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -64,6 +64,8 @@
 
 #define GPU_FAULT_STATUS				0x3C
 #define GPU_FAULT_ADDR					0x40
+#define L2_CONFIG					0x48
+#define   L2_CONFIG_ASN_HASH_ENABLE			BIT(24)
 
 #define GPU_PWR_KEY					0x50
 #define  GPU_PWR_KEY_UNLOCK				0x2968A819
@@ -110,6 +112,8 @@
 
 #define GPU_REVID					0x280
 
+#define ASN_HASH(n)					(0x2C0 + ((n) * 4))
+
 #define GPU_COHERENCY_FEATURES				0x300
 #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
 
-- 
2.51.0.318.gd7df087d1a-goog


