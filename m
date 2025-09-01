Return-Path: <linux-kernel+bounces-794509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C53B3E2CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCE8179DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56333334376;
	Mon,  1 Sep 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRIFKQS7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A532BF37
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729566; cv=none; b=O2TBn2AwBzJ1G/FhCDgtCVHPrYR53rByCTtbpwc5DlIcmcFFbX2EWyVWU+los/oTf4cdDMrJ6Z4+uajkCctMd+S5+CNtbsTDHYDUoAwoTs869SEdUSKSt84fNOhubU0cF9pcx4AmqDvqa4IaR1rx4kU/8snehLrNRfvVUwVe2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729566; c=relaxed/simple;
	bh=lpbBUhTCpDDk06PPeWfR8sE0UIN8opcNWrTbfE+/pMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLmuMsB9MKhywqneEZzLE8Dszd/nrNLkXDMOT/A879mJ9wfDwNki8gkzsQpgMCEnX/oYl4RP/aIt/3Rosm2bS2doOJzpJD+6khBZP8x31yLq8J1JDbV03CGDnfEl6l3PuLD4vQ/Kb/bbym6x8xqAeIxQs/fLOGFs8WEtlT46OCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRIFKQS7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so6072085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729563; x=1757334363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S92TFORdFpPvYJUBMVUr5Ti+IlOYwkoe/RCwplITijU=;
        b=IRIFKQS7n8CrQJK0LMzKCafCgyi0yyA+6UBLkZHFMgkEQK1qYwK8r4F/c8ecrTmYok
         5Nac5F4xpJFaBnfgqThyOJS3IruujH6O9r1dG2R0JZwzPVnBxWeZvrLTROAbp5qNC4c8
         gKaN4mTONyh/07p53afMV79aAhhgpL2LuAzlriiy7Un6g37mA1i9btsImVZXylOS/z52
         ztWEPIJr7gzZra0z0bM+KKNJhLgZ4DfwwbOkKiWWjcveTMOoM7MXa3pRz83OtcfzZoO2
         xr8QhXsFSEnYbxNSNPfIDTZeCUav/Ha/FOQhkq8QXNt+SYDd55KpNbHr/OZLYQ2Iv5lT
         o7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729563; x=1757334363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S92TFORdFpPvYJUBMVUr5Ti+IlOYwkoe/RCwplITijU=;
        b=BMci8MWfv8fcgj721dhLemxg4s9YSk1xjD5c7JKyJ1GuiNhe6xrFgAekArhj0vzGwy
         JampmfAP7dk3yFHnec2KYY8aHo1YcH2sHaPZ1MrFvV7aHak0nABo9LLy4AZx2c4hrWBW
         pnBGM3Wr24DJBxNyRakFN0vPdZSD8U3GsKq3bhbz3vUoWu5bOo/0zLVWy6PVEDCGdLBp
         jJrjOkcaIz2s2KxPfjWGaxm9p/KEml3T1Qnwg2IK6CENxQhl948Q4YA9GZPs4Ho9vjdT
         VBdSfdCHW7p9FzM7U11MP74XHmAbkj3KxXVcOtSLQ7KAch2qf5BE/086lANj9fr/EGW0
         xBMg==
X-Forwarded-Encrypted: i=1; AJvYcCVCAXL49tfYBOzd4EZyUBA2g8xC1k+SYURzZOGU6H/7DIaDdjPQvHyT2vJqPJyqd3p0eqJwQAvA+fstNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7BjJ03xHRrwbmSTGS/2ADUA9xIayIkAEDKSbxUrglm/4MILQ
	epMu8j9JhHbr40pPQ43g7/UdNfX8e/vjKiRCqza75mqbjlIWm26Fh3n3
X-Gm-Gg: ASbGnctyIZpDBeSlOHg34GTlfGbnuxfyKkG4Gi+4rfE9hKmKHafRR0CtnSfDqjwzw21
	3QgsCj8d1RZtYMXTqF6/ZFnxLBRk+K4uO05jvFi/QP2VEu/SlpBxYKLieDvNsuNSUhSNhB0J/A4
	72wHmgYyIr7nxtWcdUvTWcriKq0CJY8yuDIA7L1TDRceD+reqRNZUPSN7U4c0yPLcQi/laK+NqC
	+N6wGstyj7UMJaqFaGGhgCZyNh1oXmG89fB8u6/x6deQi3Oz/w/t75vt3g0Ija5OJNd9mEIHPU1
	JrF0UTy/ymMuai5mBcKeb8O9gLOaDAPw9y0u/zijMNAOsFB1bkqlY1W4iJPOSosBfpndwTnuhnE
	nsVUshZzMRcPMYgaKUQ==
X-Google-Smtp-Source: AGHT+IF8n8jun5wPEd0Tp7welazHHZJACkUZPP6YFYKmHpTRnTGqX90j4tqRwzGL6bHiiTUh4a335g==
X-Received: by 2002:a05:600c:35c2:b0:459:e466:1bec with SMTP id 5b1f17b1804b1-45b928b8bbdmr3288095e9.2.1756729562704;
        Mon, 01 Sep 2025 05:26:02 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:02 -0700 (PDT)
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
Subject: [PATCH v6 07/16] drm/vkms: Allow to attach planes and CRTCs via configfs
Date: Mon,  1 Sep 2025 14:25:32 +0200
Message-ID: <20250901122541.9983-8-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes/plane/possible_crtcs
that will contain symbolic links to the possible CRTCs for the plane.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


