Return-Path: <linux-kernel+bounces-794511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A390CB3E2CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B811A83293
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07A334718;
	Mon,  1 Sep 2025 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cra7R28Y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063B32C30C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729569; cv=none; b=hfVCJuN1HZZRuGME2gOkz8j1Ha9Q22LsM9Vis06rW/ivJf3eomyW9Tuj+7XvrnaaNxwkm0ns5ax/3dxij2bezy0MjQ4NKwmf2oFpKfvWJL/LNcQ5VAJNWH+HcTeQgjmf4zbKi9d2vOKQRAmhGOmiyyr0yOlJQXJ0O20zfixSyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729569; c=relaxed/simple;
	bh=zMW6F7otXIqwAlRi4AAlq5UaUnv7suG2zVgsIwghw7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G91VEEjkoQ+KBO2fl5U3Oz3m1aDVCtCdHpYDSMobKHndOcl1DuRPhz0cTjcDp4AFv3h447QhXgTuODHytoBuvbIbLFR6SVnH7pnldt71mIKs+wrhfpUH8CTB/by9DCzSHfO6MFIpCPmw3rPLr/KvmFBd+4XGTEosDwSAk1PfeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cra7R28Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b86157e18so9948545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729565; x=1757334365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5emT1txqOTQl8l8EdMKxfHnYSU0tdBtClIdWbUlfFA=;
        b=Cra7R28YPw5dUU7wYcuakvS0RWeVaHWYMV9UnZAK3+ynpVeFOnIUQgyMUEqvgYepzu
         iO5oUMpGLU8T524PNgxUWfAID/JGGyy0B3UY9SyrdUkVTwexmVuwFDYsY/PUHVDLrjAD
         CtMYESeqX2+o8y19GErH4dWuy2LDq4sQArwg+v984bLTzJHOI+JtwMmw96RsfQMRhSrX
         +aBixYPGmiMlg96So3JM19cVBnk7OF08BsgaPghMYykpeTi8yuFm0WmwrK3gHj/wL0eH
         I2kWGzuCwrwxn9ONzsbn771pq6/xXoRvtP9kpQR72mcDTjEonQHFgadtGAHoOUNzD7GL
         zyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729565; x=1757334365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5emT1txqOTQl8l8EdMKxfHnYSU0tdBtClIdWbUlfFA=;
        b=d7Xv3Kb36GWgmpEfRluTQx/bsTdGWmi/JXUFgCRCDqNomnGo6ukxEQer9FzIsT7pmS
         ymatd3HN2OojyuLaoKX99vVdmm8SBMjWwqInkH1XrQVE2zfe5CdbsyWT5NyyW5jYJdsU
         K7d1jvRGiwjJcxkQvu1jFrIyFWCrmeuiy0HnLbsXc1AvRJdcJEmMzmYCcX0E6DCgKYDq
         wp3ckeULvDFZ7E0TEVejmcxwIfifLY+iliImHzAzhSlaqLWIqqs5XXh9lH350daHhGpx
         rBRsWY5zUugE6rPcdYN8jkW1KNJH6qdOZ76lHXNZ6H6lV3R/Pnkyup4vVSEmNn2NtFPi
         ADAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaqSARpHpTUkHszgAbWBIqNKJOBqj93/CnQOWOzCZ4x1eVqqW8Cyx4kIzXRc5QcH+xjiqiMWYvkbuRq7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oo/2LTtNUykx+ErjqAAPcuWrXeeaWGEWBiMsP7x2fHZNODXE
	LBac+n+cmfvjglLZLAPygEufZj3y4CYV9+v3D0YGQBRuew6sIsXT41+N
X-Gm-Gg: ASbGnctYHmKhD8baNhm0H7+7VCJzZZqLCrxxyHx9BVJPPf3i+7vj6S7qRRgAznNHX5C
	JrrYN75FhjC2ywI/tMDA54bPRwydurdNGZBmCp5x+FaVoAlXMjsDTm+VOgRNKNi6UwB/MABvCIS
	Bqx9Ho3DQkmYBq27WM7POORAqRVQPfmlA4ToO2MMdtRsiOsJe8E8rYfMOFPMxuMBYMmn/x+HThl
	P9yRhfg6QE+6dPyGVmDlFKGadyEW7YajYcidThPFfUBuDvM5ehkvveLvS0TMOrjC5vibbcbuZf1
	vaWKYdFceazhzknI5p0LOTpb84JyY3Bh9jJAJM39CQYjjY9X8/9zD/HA8aWnGXghIOqs8UGK0K7
	GG2N3uKJcgNqNlwHH1/q0fCgociX5
X-Google-Smtp-Source: AGHT+IH9OUHSYnmDvfNvwQVhN2EaEpCAmFC2+CVmXG8+ZkONOcCBzxF4EINwhVpS1L3JpXR2CwAlgg==
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45b855983cfmr53456195e9.27.1756729565277;
        Mon, 01 Sep 2025 05:26:05 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:04 -0700 (PDT)
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
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v6 09/16] drm/vkms: Allow to attach encoders and CRTCs via configfs
Date: Mon,  1 Sep 2025 14:25:34 +0200
Message-ID: <20250901122541.9983-10-jose.exposito89@gmail.com>
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

From: Louis Chauvet <louis.chauvet@bootlin.com>

Create a default subgroup at
/config/vkms/encoders/encoder/possible_crtcs that will contain symbolic
links to the possible CRTCs for the encoder.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


