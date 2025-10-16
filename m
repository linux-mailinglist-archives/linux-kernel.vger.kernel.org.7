Return-Path: <linux-kernel+bounces-856738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A507EBE4F35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D443BC376
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C2328B56;
	Thu, 16 Oct 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKiLTLAf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10D23EAB5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637414; cv=none; b=Ioo0azv7cGsEPyS/XQadifaKYngo1YpjrxHmpqcOShWMsnmNeC4308X6XDIzIwg0IiinMeMM10tE8lQFr+UFGR0c/a0BSrTRrHRwOGGC1zAdU1bFUPLBmxJkPuFg7hQg1hZU6fUZFEMzyQOreKnNACjfDkKKiuGcuiHZENx56BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637414; c=relaxed/simple;
	bh=akNoVbp6l96BADli98DtbjqTcrKIsVMIoX9VpPaDVsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWBfsJTpO9DtclMXwm9VyPGkKhY3Qh1Jn5dVbsg5+ZZrtXT6o+7yh7tL0Hpt8XbogF8LPxT+WS2wewaExqAfs5hyXf9uSAfndTZ79FbpWwDZ5KBrf71tNbT7XPfHZdF44FbBJthvxTfMFjbJTIj4UChZ6bgq4it3CHxyfxpKOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKiLTLAf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117e75258so1319235e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637410; x=1761242210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Iw4dctPK4SDmV/YtpTKXRG3Xw3gr179LpM994cXNRU=;
        b=OKiLTLAfMDSe1nWxYTxPZCOkx60owNOBJbSAkpdFg8p2TB2OW82KaGGEgKqOcA6t4t
         R9qs9LihhnvLdaHfBKJXU8ymfScKCTnJYIsd0QJy+s3l16Uem1EFn2/6gZ4eUXB7j6Pz
         2uYb/dkiyi2aFEMkOLXl7OiYISUS8HSTeavSXSc4djaKt8mI7ojpi3Pu8NCLIJsXZ2yU
         4i8h7sdK1IH0xx525jsKMqgROsDcj1jjdkzxTE4ph1UCLdL1nQY0jQt2dL1pDzS5vndK
         O4vk7aC08d5lvkL8Hry182GYeBa6byfZ+WqjUVk0YZu13dJ1YA1oMymGYiJvDQpFJYdT
         nWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637410; x=1761242210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Iw4dctPK4SDmV/YtpTKXRG3Xw3gr179LpM994cXNRU=;
        b=i2Ndw3hrMqEpY4y7zfHktqsQ1RiYJfQ3Rh4orJ/22sw8fYqs1lze+GqmNSj498Nw8h
         eztIQfDs5V5Hexrzh1p9F6xoLEim3Yh7UEZ8u2qA0zcYbVcfU5ffQ7S/7e9Tb0lfortJ
         OTuEkcjOjyB8YA5oU5meEAn4bWWHUcAGvGsfjvpx0dMvoVyoaFA1art4EWBBqUMvPh4H
         8rx/7z2q7rYG2J0ddWl713lXT/HhDB+QCULCZppiFhAq+Qfzx7OX76fwUj5FCdMJRlej
         4d0aa60I8S2IrjobiM2mZsBfxldeFKz9/X8gcTWQBENOj9rtl6qf1q9A17s33BnDBd2o
         +41A==
X-Forwarded-Encrypted: i=1; AJvYcCXX7fbbubUGgrzBxfCvV2UQS+7ouhFe4+udEnzBEGt/I5/x/jtbP0P4qw50w/bNUkFASNgsrkL1R1K0UuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcW7GZUHZgEkKoL6OgU+T/vTizS390yOAeJDIlubmRlA7nxXgZ
	nnxr8lRnxt9Q2hg+zDRtuve6mq8u1fep3nTyiApW+B+pF0Ud3Wy4avf7
X-Gm-Gg: ASbGnctEDGXT56Uid4wn3PPvmj2Gh9pqok7p1gMsGhwadk4isZ9bGybUBu6sZ6I1Umq
	uIb7fgcehQx0eNHvbwHcnbkuRpICcSgmtTh+ZxE5E6OBH7dONW/PYv1/dwRrxdcYEHs14UvHO0e
	ppp6Cn/Ecl/2b89SjpBJ7cy7ULIURjWsvcfA/0Dj6DrZcmj9PW0rPpadp49qhr0nnWnqFtsJ/eC
	C8iri6uRw3nzhpkFOTBoDZRWkABKGKZJnB3npp4CiRdO9bZ1dXUTtF8oAH6hKp38hBwjSbjmN3X
	LY8Xk0eyM/TrrgfMazUOnYx+7D4C4ZdBKFbmAjl1WISe7fcXz8KB0aMGlVtBz/AAi662iz2hvtx
	HbuPGm9aOfYiRxJlwZCCh/pPc3c+fqxpRtVTgKBuNlk4cnWn5sJaMchl5n36UVS5fC/EJK/VSSx
	vUdmdzDt4Y3Q==
X-Google-Smtp-Source: AGHT+IFbOz3W2+G2OoxdcsQZgc8xrH4wObe7H+Oo9COB4yc/aLa7cjWM7GvW3Eu2iI/PG6oUer5LMw==
X-Received: by 2002:a05:600c:5287:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-47117874810mr6737745e9.3.1760637410421;
        Thu, 16 Oct 2025 10:56:50 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:50 -0700 (PDT)
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
Subject: [PATCH v7 07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
Date: Thu, 16 Oct 2025 19:56:09 +0200
Message-ID: <20251016175618.10051-8-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes/plane/possible_crtcs
that will contain symbolic links to the possible CRTCs for the plane.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  9 +++++
 drivers/gpu/drm/vkms/vkms_configfs.c | 58 ++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 9f76918bb1d1..c79fca3d3a11 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -98,6 +98,14 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support by writing 1 or 0
 
+To finish the configuration, link the different pipeline items::
+
+  sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
+
+Since at least one primary plane is required, make sure to set the right type::
+
+  echo "1" | sudo tee /config/vkms/my-vkms/planes/plane0/type
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -108,6 +116,7 @@ Finally, you can remove the VKMS instance disabling it::
 
 And removing the top level directory and its subdirectories::
 
+  sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index e9f445043268..2cf97c2b6203 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -38,11 +38,13 @@ struct vkms_configfs_device {
  *
  * @group: Top level configuration group that represents a plane.
  * Initialized when a new directory is created under "/config/vkms/planes"
+ * @possible_crtcs_group: Default subgroup of @group at "plane/possible_crtcs"
  * @dev: The vkms_configfs_device this plane belongs to
  * @config: Configuration of the VKMS plane
  */
 struct vkms_configfs_plane {
 	struct config_group group;
+	struct config_group possible_crtcs_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_plane *config;
 };
@@ -71,6 +73,10 @@ struct vkms_configfs_crtc {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+#define plane_possible_crtcs_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, \
+		     possible_crtcs_group)
+
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
@@ -178,6 +184,52 @@ static const struct config_item_type crtc_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int plane_possible_crtcs_allow_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_configfs_plane *plane;
+	struct vkms_configfs_crtc *crtc;
+	int ret;
+
+	if (target->ci_type != &crtc_item_type)
+		return -EINVAL;
+
+	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_plane_attach_crtc(plane->config, crtc->config);
+	}
+
+	return ret;
+}
+
+static void plane_possible_crtcs_drop_link(struct config_item *src,
+					   struct config_item *target)
+{
+	struct vkms_configfs_plane *plane;
+	struct vkms_configfs_crtc *crtc;
+
+	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
+	crtc = crtc_item_to_vkms_configfs_crtc(target);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		vkms_config_plane_detach_crtc(plane->config, crtc->config);
+}
+
+static struct configfs_item_operations plane_possible_crtcs_item_operations = {
+	.allow_link	= plane_possible_crtcs_allow_link,
+	.drop_link	= plane_possible_crtcs_drop_link,
+};
+
+static const struct config_item_type plane_possible_crtcs_group_type = {
+	.ct_item_ops	= &plane_possible_crtcs_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t plane_type_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane;
@@ -272,6 +324,12 @@ static struct config_group *make_plane_group(struct config_group *group,
 		}
 
 		config_group_init_type_name(&plane->group, name, &plane_item_type);
+
+		config_group_init_type_name(&plane->possible_crtcs_group,
+					    "possible_crtcs",
+					    &plane_possible_crtcs_group_type);
+		configfs_add_default_group(&plane->possible_crtcs_group,
+					   &plane->group);
 	}
 
 	return &plane->group;
-- 
2.51.0


