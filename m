Return-Path: <linux-kernel+bounces-794503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C305B3E2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186D8189B252
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487331B11F;
	Mon,  1 Sep 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu1XcGXt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B74257849
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729557; cv=none; b=iIM0jGXjBz5C7dggDmWCBCCYcjiO4+EORzyofXINe6qyX/t1bVirKQTKm0yf5P6iBD/Zn/470ZkZUIWexyIx1IjHxpqU3JbNHTsbfm51RuDLR7lQ25aPkeNiG92M1ViuBNO9toW8iCf45QJW0WZ2dX3DV1rPAff59fUxfdo5CV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729557; c=relaxed/simple;
	bh=dxjIcW0hkmozpCxrs/k8CRpZXK4tF7OqQs5SqNceblU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjPuTYuvuMiymOa6h9gFbSDMGPMGC5UK2GWe1pbi34EWxhkpElQflTChedVOOnhIXsayYTe4kDDlHMVEyHDjGpilQwglxcoi3kklUngu6NCjVEMKP3gAJnt1+OWibSLhBbfivaxtncSe348U6fzvp5VOFHj/21SjnbmV0bRIFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu1XcGXt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so4757265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729554; x=1757334354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQmk72oHt5ION4ymwRgroNBMLcTWP/UF15XiNzL0gQU=;
        b=Bu1XcGXtAA/k/718edyxWRy1k/VD7J0Ov+bq+xJPwqptKee9m+MhJABu4fvdmRSRhs
         cUsvwHrzGAenRdn1IVW3dIfoEPLjrzSZlucJx07iJOLOC9vVxLrhgV/rN+ofl0pFXCAd
         Lo9t1Ub2QQCEI384mK1VSDFy97+fDvxq2BFiQVwFu7P1pFu2SM51onS4zTE5kS7kdZwQ
         gLzJrduBU1f6k2F8ow/Kh5D+ltpWPPJyS3HWb1Zti8D1eCn+eOHiFSeQGMwyVS1Qjlwm
         jOXJOtmBNeRSureHX7/WFhbuCPGcS8rhZZe/Y6WPrVRrl8oGcvoieXxzZd7LBJpxBVFl
         N+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729554; x=1757334354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQmk72oHt5ION4ymwRgroNBMLcTWP/UF15XiNzL0gQU=;
        b=wHqsvJuyq9GQRPzEG3tvHYAy0eSKwQuEqQiXit/CEITw7P0vBYXNEVsgeZzrKwrXNM
         1yL08ydlB9gTl6N9SzNPpN8ib82Jil2J5mU6vdjb30bBK9W71rpoSykVhHqabBEopSQ8
         qIyAPSCj89rDnCMQckFuiv4NwA9Q6YRvFY8y223XAf3JiuzcSbDr3/d2R8RnUzF7rfdQ
         DsGeHlr6832xFOvc4vMP/8tBydQw3/XiejVw1vnt4GWfEWEyhEmjKPQe6626SkIafLUL
         10Bdruy3t/5BMM2PZMENF0UCajGwp49m6qLaHaT1NUz/uoQmjB/UA8polN2tm1EHPazb
         JJyg==
X-Forwarded-Encrypted: i=1; AJvYcCXwBOmurm2opJimRPpL1RuDxB4hFmI+CNtuXVJ3EzN0BX7R+y9t5rCjIZDwca51pUX/hk/IoSBYNAh+Fd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7METhXAgWZuygjY39rouKUIURD14pKzCZ6KyMRw3BPPN0Mbi
	ny1TVGClXKyixbQ4r4XnQB+3PN+lT1OzbrbHJb3/at9H5J8x1FN0hbHl
X-Gm-Gg: ASbGncs/+JqP1oUazdbzeIyDSFj188rWYrXWVP4pIpKvEEf5K5jYfzc8XV9qf3DmqtD
	AscWE7sSsarpMrBM9NOUUkiLvdXQI29St6GZ8tPnv5gm3txE2s7WKQK8Sg5XmFqOKoJj/+r/3/1
	znvYWYVtgaJ8P96oZ0EGHX37nHSoEYo5OA/BfgiIpD8pi/A4AyKPjEXAKz6ueTgyMNSzCtuHMDN
	vsLO4z/9+kVxaBqabi4Fr+XozeDiqleoRjGPuQ5C18UMQeVBtl/OYGUc5agjzU43AU/ZrcF6Lzn
	jjmXQF3IR2eZ5wweSAyY+RG7kR13HuhteBivN2xUdeFddp/5JdlZaHHWLIhpPvH5r9XI9o+ZIht
	pcihW22aiRGIqG4tn9MQFRRXlW8dJHEDJoBEJlgw=
X-Google-Smtp-Source: AGHT+IFEiQV6jVjHGLuh7HirhS/szOCkjsWzzdfQvVe86dY/G1MwA8SAqZnmENKihKawgY3W9gXhhQ==
X-Received: by 2002:a5d:64ee:0:b0:3c9:c344:1652 with SMTP id ffacd0b85a97d-3d1af84ae2amr7349821f8f.6.1756729554177;
        Mon, 01 Sep 2025 05:25:54 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:53 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>
Subject: [PATCH v6 01/16] drm/vkms: Expose device creation and destruction
Date: Mon,  1 Sep 2025 14:25:26 +0200
Message-ID: <20250901122541.9983-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for configfs support, expose vkms_create() and
vkms_destroy().

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c |  4 ++--
 drivers/gpu/drm/vkms/vkms_drv.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index e8472d9b6e3b..78af37c7bd83 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -146,7 +146,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev);
 }
 
-static int vkms_create(struct vkms_config *config)
+int vkms_create(struct vkms_config *config)
 {
 	int ret;
 	struct faux_device *fdev;
@@ -229,7 +229,7 @@ static int __init vkms_init(void)
 	return 0;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+void vkms_destroy(struct vkms_config *config)
 {
 	struct faux_device *fdev;
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8013c31efe3b..959ab48fbb47 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -258,6 +258,26 @@ struct vkms_device {
 #define to_vkms_plane_state(target)\
 	container_of(target, struct vkms_plane_state, base.base)
 
+/**
+ * vkms_create() - Create a device from a configuration
+ * @config: Config used to configure the new device
+ *
+ * A pointer to the created vkms_device is stored in @config
+ *
+ * Returns:
+ * 0 on success or an error.
+ */
+int vkms_create(struct vkms_config *config);
+
+/**
+ * vkms_destroy() - Destroy a device
+ * @config: Config from which the device was created
+ *
+ * The device is completely removed, but the @config is not freed. It can be
+ * reused or destroyed with vkms_config_destroy().
+ */
+void vkms_destroy(struct vkms_config *config);
+
 /**
  * vkms_crtc_init() - Initialize a CRTC for VKMS
  * @dev: DRM device associated with the VKMS buffer
-- 
2.51.0


