Return-Path: <linux-kernel+bounces-856732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDEDBE4F02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543EE188FC76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75E223DEF;
	Thu, 16 Oct 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP2bfQwa"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D289C19DF8D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637406; cv=none; b=eOWObOr7u4RNQEjPSYxWvxSQp2N9Dd7AciwmStS7pUesfsOLc11kRjq9DuRkzUaq1Rr8XAfhkaIw3RVCa/+7amb2W/QnzwlrZtFHJAxrfL1WE/u591D1FL6P3kFyLsYpsCKgHeOCb5CYXCOhLaNbPiK1cuaGCu6CwPLouc7IhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637406; c=relaxed/simple;
	bh=1ufYf8QmUfgcOhG5iILREkFndj30nopWTyHYdZGPzYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCJdaP0bJG7JZ/OzdDu8n3Bph+VuYUsmyew5D/vXRXu4bqKrofAtbuZLEl8zRzrW3guzTQAfSfZM3VqfRp5K2GYNG9zkPtbnPXdhkyA45cVyMH4bpceJtVMnoz+hZk8FgMuc1cXPULAfeTNvuBhMmTUVmEUOPj3YuisxkMdAxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP2bfQwa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so484882f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637403; x=1761242203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kmKem70jvZ9LoR1TdTHaGoDSxtiVxdO7P0NAM1Dmj4=;
        b=YP2bfQwa1eD82KGOluzjmgBVCsEK/qbMUVbOsc9kLA7QBXgvLkZegXu1bi6ahLxItn
         m/ysTPOj0KeJeRt+yPr76LQ/09tct6bfkaQIPV701HaWxvEbu5EESJ6Yi8fZcvu32hYF
         3pfgbgBq+4GRQ/ShcYSxsusXPJqUjQ9NQjO4nwNqVxUb5b7uSxk4J2hDfYKOB/XC6hM4
         UpwH2ECQf4lVIQ084sr6EvwFFAjIlKdcv+kAG2127e1/n3Flx86L0zD2vtNaMS0UEUaQ
         +8Y+8E9fLH+/CVyf1wCnbLvJWBFdZJaHs8A7NV5+mmpWZWQqM7ZiYAZ0/6EzByyCXjJ6
         /gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637403; x=1761242203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kmKem70jvZ9LoR1TdTHaGoDSxtiVxdO7P0NAM1Dmj4=;
        b=nYDvrQ8b/oa9KpGY+QR4zuzYevEiw/+Ga/Aq52jQ3IUHqWmd6LT8mwminHDboJeVQD
         iUbKLRXa7+LKMJsamPlzvS8kOifrzC0//MhrTrUIRFlIzlw2UG48Q90jliulGhIRlIRt
         B81/DrUPJ1CKGJmwITAgfURLmeMNPKXVphMEc64OMUSk8B2cSH4N764X17COPCM8jhIX
         fdA+B/gNyxKgdm5hBJdHqATEKEwXelxeAV6vByHa0BCkBEtLYiYK8snhneO3+AqsLa9+
         SeU42xvegpI4TabVt5rXkYNpEtFryNvKpFLBCY1cwGMMzwOQg1ZTtaEqPrT9Jp/+p7WF
         FggQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4uDDUGZ1MMejjsjJlC/u1XsKxfaXoZTD+P+WwcOdalvNGf4nQMdZ8qQXRpeh8Ex9S71v0TlvymJgKiTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4HvGCnrVcE5DsNeU12eKrIerY0ppr2aMyaeLE0k5DOghFYXQ
	Ey6lbof7ASG0P2/kqFwJOjoXe/SdQIBMhKl7trQ7I9E8ZaT1Ro5QApqQ
X-Gm-Gg: ASbGnctyVxQ3rNuuyJbHpprepjHsHjaP67S6n78vfvy9mJgkKYqsFNce4k8oNbp2Xij
	O+9oenHyySvcLC3dBZfybBBJsWTQl977lwHhJU3JDw/VWnSzpfFaSDCFOj/0wu0+d7nU+bdWr8u
	P9aiQyPfkQoVijvZ9ADWo96Fu7UhH66qM8SnIKq/eo9fu7uigoZBlR72TmShf1AgUty8QJ0chWu
	Vc/27UHvVyNhrq8tKrkBdccs0YG9tQ3HD3lOE0SKVPGpzTxfbxALRavzvTOU1ApapvRoH56Xb6Y
	Xvx5RYEe45T7P3OHxEipSxRnk2DNW5Sfr9fv4CVaY1b04xWGN7BxodYnKZ7WoEqIrISPvNIJl6a
	YJXW/K5Izli5MVjrh8aJApGaxS4WlTh64jrNd6xY105xUqLI7mIwKYOCydRQc3/IJBr2SLcZZ2p
	Q=
X-Google-Smtp-Source: AGHT+IGbJz7x6kWyeAzr1cqOyNqUZQkkfzh9jBeeJgGBUoiQ7xa+MKsRfzCNAV42+zCg/ujXdDEIZA==
X-Received: by 2002:a05:6000:22c5:b0:3f2:b077:94bc with SMTP id ffacd0b85a97d-42704d7e9c4mr686747f8f.4.1760637402823;
        Thu, 16 Oct 2025 10:56:42 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:42 -0700 (PDT)
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
	Mark Yacoub <markyacoub@google.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 01/16] drm/vkms: Expose device creation and destruction
Date: Thu, 16 Oct 2025 19:56:03 +0200
Message-ID: <20251016175618.10051-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175618.10051-1-jose.exposito89@gmail.com>
References: <20251016175618.10051-1-jose.exposito89@gmail.com>
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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
index fb9711e1c6fb..db260df1d4f6 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -256,6 +256,26 @@ struct vkms_device {
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


