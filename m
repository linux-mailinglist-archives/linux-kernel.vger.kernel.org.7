Return-Path: <linux-kernel+bounces-856740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FCBE4F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E13BBA56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F2329C44;
	Thu, 16 Oct 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzpZSHzC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99846328B48
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637416; cv=none; b=cCvf1iz2eorK6zjauglEjglqi4tsPRI7VPlgTbhPrdc22a298PcO0MP/cHT4xsgyjwOjSrcoGRmacCXYizfWW9cBZf0eUash0X4oumEjIItke9SNrCaQJtmAZx7aRmktMBM8rOohX34Os8vaylfTm4eQFWhqQg75gZFWMBVbRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637416; c=relaxed/simple;
	bh=6B/oEpusfBLPtnIDyQcbq+bRFZMCW8fd3DcHN6jIeto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1SZ3ubgu51vuH5AuMJahyDhSeqpK14fK1FWhr872b8n2gmEH2KrEJWBu4T37liOXjjNkPOLJ3WtVUNbkqboroQQZ39iEhtuFCkbDz2C36+aGOPSQjmp3w/G2xa0cZrs4VzmI0kPb8DInrV/MfmLLtXgKPxRb7yWwRiyO2EVpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzpZSHzC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117e75258so1319655e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637413; x=1761242213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+76MRDg5x75qLvTgM55RSRxFBkfbhy3lMLwDXf3nB0=;
        b=XzpZSHzC2rNn/bVjc9QRn1LoA6031CDTvxvhYXj2I90yH5tkdBn7TJoFGWqRFkQk9x
         AWwshzE3nrh7dhJbrTwUaeEo7hz7BiAp6fMvLWoBqW20stgYjZQCWv2o8HcYrRa9mfLh
         +c8O6qo88hCu/AJjLC7cXdSbk4jeXHM57zxRwCiHS4NTrm79qoqHVh8Kf5njPsDcuD+X
         VYXQpS6fMvyPg5zLRRdtLeab+I0qauMB7vLkqs7zOD3AvhjebrvCKq3h7hRr3VVJGuK5
         rnm3XK3tzxle3Q3+l2Sh3u22H2zWpkw0IgKfzsl6J1yUIXU89RcuKaHR2KRwQTHIZ1H3
         U3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637413; x=1761242213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+76MRDg5x75qLvTgM55RSRxFBkfbhy3lMLwDXf3nB0=;
        b=h5JU/Ng3fBeSq5F5CX9Z/v8ynviPzg5evvSgUHn5L7oEsDzvdWNQkJ+QnVNAx+Ymi8
         jQHt1YA8+DOTkij8wS3SenNITiuxtxtr/kLEFDKuXKM2qd9OsXmXTii/HyMWWl2cJAQ+
         W0qhITcp0LrneL23mlIp8XEitDIlFKsaa+u4QvBGsklwtvHxQFtTCkMeXtGeTUMThKrL
         Tr8rXKXTQc1YT/D05bls2qnZKpm9tSoei7GnOFp1pCOpx6T6e4PoLN0N5Fmuqa6M5n/J
         rSApnL2wjoSF+A0G+C3eiuBfBJaNDkJpom5a5Vq4lBWq/Ubz0J2FuMFb8FkcLJfd/qcM
         aHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS3nd1QMzYqfxhHMnIb1Mv9GpRrAoNAORzRj6eU9ASvKBj5wsIS3wmBQUjxWY0E6dkOi41jGH8+amxWXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkdvnoe9crNTYhp3wLP5xr5D2iP4DCrlapSnJroPHQU/Ns+NR7
	2Q6mAnX0HyyDJ2l5o3Ae/xdd/lhOiQAVR+Na2gpZySRDy4DVLfbDVwkW
X-Gm-Gg: ASbGnct/mh3bIkEYd5Re41E3bDQafEoGbZK+0FVlojFFHT5rn7fixZ/ep8oZaa5u1rv
	zumQHvf1WIXxc7um5cmSA387+YaQziPNyaIhNMgNjTCAViWOTMQBjMDRthTWGDqmfYTX7ccBHR5
	Y/JWAyjuKJU4a9lTL0P65mQuAZVeq9uveLVXMzfH9pYZecKapU69qJ/JKYbXQwIWyfmzD67JIrq
	L4GIqsJotktzeY0klHf11JrGiH21ZXX+i7TbeAEGWzmZGxpaVmVxUGZVU/DgwLEYHktmAdEXtRw
	kbX388lj2nK0wJiFQLQnZFV9HFR1H/MArjwTrUm7ICJsoO6/nNEsUKod4BHsvJydqHCbEjrWuJX
	MRFxzbKAVjlPVT8mANXMuY9cpbaHwc9VSEz0M02ebxLfoHdl7IyzJa8CeeOEh6iz78VC+9SS08q
	4=
X-Google-Smtp-Source: AGHT+IEF6nd3NHJ6Hz3jHyY6wSRTMjjKhpeimqR36CbQEX1fUeaE1iql6yjy3XpMlOobsyfjzfShmw==
X-Received: by 2002:a05:600c:b8d:b0:46f:b42e:e39a with SMTP id 5b1f17b1804b1-4711792c24emr6649585e9.39.1760637412794;
        Thu, 16 Oct 2025 10:56:52 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:52 -0700 (PDT)
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
	Mark Yacoub <markyacoub@google.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v7 09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
Date: Thu, 16 Oct 2025 19:56:11 +0200
Message-ID: <20251016175618.10051-10-jose.exposito89@gmail.com>
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

From: Louis Chauvet <louis.chauvet@bootlin.com>

Create a default subgroup at
/config/vkms/encoders/encoder/possible_crtcs that will contain symbolic
links to the possible CRTCs for the encoder.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 58 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 622fbfa12a84..585effe90550 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -106,6 +106,7 @@ Next, create one or more encoders::
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -122,6 +123,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 0df86e63570a..7de601e39d2b 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -70,11 +70,13 @@ struct vkms_configfs_crtc {
  *
  * @group: Top level configuration group that represents a encoder.
  * Initialized when a new directory is created under "/config/vkms/encoders"
+ * @possible_crtcs_group: Default subgroup of @group at "encoder/possible_crtcs"
  * @dev: The vkms_configfs_device this encoder belongs to
  * @config: Configuration of the VKMS encoder
  */
 struct vkms_configfs_encoder {
 	struct config_group group;
+	struct config_group possible_crtcs_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_encoder *config;
 };
@@ -100,6 +102,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     group)
 
+#define encoder_possible_crtcs_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     possible_crtcs_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -364,6 +370,52 @@ static const struct config_item_type plane_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int encoder_possible_crtcs_allow_link(struct config_item *src,
+					     struct config_item *target)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct vkms_configfs_crtc *crtc;
+	int ret;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &encoder->dev->lock) {
+		if (encoder->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_encoder_attach_crtc(encoder->config, crtc->config);
+	}
+
+	return ret;
+}
+
+static void encoder_possible_crtcs_drop_link(struct config_item *src,
+					     struct config_item *target)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct vkms_configfs_crtc *crtc;
+
+	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &encoder->dev->lock)
+		vkms_config_encoder_detach_crtc(encoder->config, crtc->config);
+}
+
+static struct configfs_item_operations encoder_possible_crtcs_item_operations = {
+	.allow_link	= encoder_possible_crtcs_allow_link,
+	.drop_link	= encoder_possible_crtcs_drop_link,
+};
+
+static const struct config_item_type encoder_possible_crtcs_group_type = {
+	.ct_item_ops	= &encoder_possible_crtcs_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static void encoder_release(struct config_item *item)
 {
 	struct vkms_configfs_encoder *encoder;
@@ -413,6 +465,12 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 		config_group_init_type_name(&encoder->group, name,
 					    &encoder_item_type);
+
+		config_group_init_type_name(&encoder->possible_crtcs_group,
+					    "possible_crtcs",
+					    &encoder_possible_crtcs_group_type);
+		configfs_add_default_group(&encoder->possible_crtcs_group,
+					   &encoder->group);
 	}
 
 	return &encoder->group;
-- 
2.51.0


