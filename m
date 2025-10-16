Return-Path: <linux-kernel+bounces-856735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBECBE4F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EA25E3509
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EA235341;
	Thu, 16 Oct 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJRJcG0A"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53412264B9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637410; cv=none; b=EXWIyx4wJ5oT6A9/WLI64yEGz9iQoOy/WWa6DtZJ7EqKRNdqMNY9Lh0auWNShtmFgwCaI92k1mCoTeQD0vYjXAIL83lP9agSs90v6zN6xM8UALz48PtPP8xOaNC7Jw8vM4rL/+wBrsJ7SqYOvr++kEw1cgT4ouVLhusIgRU+VNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637410; c=relaxed/simple;
	bh=tZb8+vJV45HIMONXYRpcUEhUUE6PySnKCieyjsCUCls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kt4aSdDmv4QQ+qyMQpHUVbtZlMFNjbQcbhCuJ8Wn94J4iZrF6GAtmelHkZsRw7Ncf63HUIMkQCS2d1uCNBuA/T5kZZnx+s/txj9wn6/nqEwZEAOKBoGa6r0WgBSZnSqOothBdt/EN5vbbvUiBzxQTPUoIsnI+lvwSVTpUHLmg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJRJcG0A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47103b6058fso7694365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637407; x=1761242207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs5dM47sF/Y4bgsvhg9twiO9ZwX955LLlWI9saGGMjg=;
        b=DJRJcG0A4iP0DNkMftEwJDxj6T4qsYbW3PV0VRFr4NodIx9KXOZvPlSOxYweUk0Byw
         OCMI21GlOWA3zWYDZ9T0Eia1YttLmAPuWATmrQTz7iKWnVBCcyODpmPK/52F1pXfTAyk
         O0tXpDbObnEcZrI/NCij38VWlERL6BO/lD2N4FDCjvch4P43c1yGJIYNxdNxwLKHOosA
         9LrlZauVDZ7QIH4nuwgjYGWnz762RkBnPY5KEAlKG8hZXWBY1xIOr3dqNNsC3AuLFPaz
         8wgm0dhNN5bFkpZwB+rPTL9FHHD1KyTSKIJOdwwVIR+rQ7qvW6XyF8mlK6CRHPeIIzrT
         s7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637407; x=1761242207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs5dM47sF/Y4bgsvhg9twiO9ZwX955LLlWI9saGGMjg=;
        b=I55hzq9NrN+iYDYxcXLcqN0RrLrwgUS7ZOBjNXG9Xv/t+EPjdT+xGEuVqZyPHRl8kq
         AE8CvYiYqKhTtmIT1H0WOVu5M6ei8sDpdWFnij/RCNM4GDvx2jw5tlnR1F1TFPkjXIz2
         2cDX0OT8YJ+uDaPxsMwR+jcAOsoQY+hsMmfQYQFr9SXA7kOMLCmi9O07xEkI5WU7/v9e
         qC4IXfTjgXLB1/aRo8O+9JMUmLj2sdU8OTSbxl6F9pVuVJ/XZ8eiikQaCuoLoavU/G4w
         xf/F4IGhMEpyqlT8omNNkUNxjf29rvG3BD77kK78Lc3yBwSsO1RL3PpQ4Q0GLPZ7D5Qf
         XKiA==
X-Forwarded-Encrypted: i=1; AJvYcCVUnGjHQasHqDGmGCIaAIesFSNu43doorEAByDcKKqhIb7vbRcLoCAgA3r8tbJX+8MLsc+SUhEn1STwN9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GyIXHi7ku4LSaXwlWB4ctcJgsOn7Us4uTBAgANCEsS8LjeMb
	iAmG68u3wvG3garzIkH5n9B6id1mOprGWWVcetg412qAFUeG3+HdhOnO
X-Gm-Gg: ASbGnctJq3YsdNfiuPKaI7LKWxYqLFCYVuWF/ZNtnSO/7YKnOi5sz70DdeFylArNmIx
	iHUqOK3PxShnIjp6RH8FK99rPneAN7gDKKBIxdRL+nTsvlACZeSSWl4i0pV5LZgw1a8degFZNKZ
	FJnIA6yKIkQKRZIJhJ5xd0NSWOmu7OUUWlXfch0c9Icmzpa/4GAN0y/SVsrFtTbhLVJSnxue2H6
	JVmS2DBoq+oZBP4TzKp+vUfqaRivqWpSBuIwQqIHN+TN1hY78HSiRDwOaRi8dL1MyQb0IJN/jM8
	0aDqgDinJ7CDoZNYrJpksKHsGuYL+QHl+QUS4Ks4VM63W6mSe870ZKu9xMmkxBOf14rdIj4/ulD
	kyPMOyhFwqhuo35Ec/oywtf3FcDdCCgOk3lVBiFS8I2adejkVp/BBv1+2Yl3+g5yw0YT/gfBSB2
	XXY4cy6Vbbpg==
X-Google-Smtp-Source: AGHT+IEj/8hmflX2zRse95tmGyeuygqLOq3b34S1Vq2F8xYfl/ZVNLq203bC8jvMr2KsaoiTtGRtvg==
X-Received: by 2002:a05:600c:548c:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-4711726289cmr10623405e9.8.1760637406877;
        Thu, 16 Oct 2025 10:56:46 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:46 -0700 (PDT)
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
Subject: [PATCH v7 04/16] drm/vkms: Allow to configure the plane type via configfs
Date: Thu, 16 Oct 2025 19:56:06 +0200
Message-ID: <20251016175618.10051-5-jose.exposito89@gmail.com>
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

When a plane is created, add a `type` file to allow to set the type:

 - 0 overlay
 - 1 primary
 - 2 cursor

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  5 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 46 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index c0c892e4e27c..dd880ce6811c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -84,6 +84,11 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
+Planes have 1 configurable attribute:
+
+- type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
+  exposed by the "type" property of a plane)
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a7c705e00e4c..398755127759 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -55,6 +55,51 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+static ssize_t plane_type_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	enum drm_plane_type type;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		type = vkms_config_plane_get_type(plane->config);
+
+	return sprintf(page, "%u", type);
+}
+
+static ssize_t plane_type_store(struct config_item *item, const char *page,
+				size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	enum drm_plane_type type;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &type))
+		return -EINVAL;
+
+	if (type != DRM_PLANE_TYPE_OVERLAY && type != DRM_PLANE_TYPE_PRIMARY &&
+	    type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_type(plane->config, type);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(plane_, type);
+
+static struct configfs_attribute *plane_item_attrs[] = {
+	&plane_attr_type,
+	NULL,
+};
+
 static void plane_release(struct config_item *item)
 {
 	struct vkms_configfs_plane *plane;
@@ -74,6 +119,7 @@ static struct configfs_item_operations plane_item_operations = {
 };
 
 static const struct config_item_type plane_item_type = {
+	.ct_attrs	= plane_item_attrs,
 	.ct_item_ops	= &plane_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.51.0


