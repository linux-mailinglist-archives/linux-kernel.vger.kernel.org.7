Return-Path: <linux-kernel+bounces-794506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9FB3E2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC33D3A3357
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBEB327782;
	Mon,  1 Sep 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1dQ9gGC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82B322DA9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729562; cv=none; b=ENUqn7wWmHgM7S6Qc+m8R5GDwY9eSKXPlfKFTRp1CUC2XX03vVqlOj9tBLgn80pdxIQTnWFgzi12Ze/oIHcpP5p+0LbuODSOg4afCI+eHOA0BzHLRPi1VWaOLQeg9sHklhKzSO1t8qI7JT6TRIzpbkFoYBx4VW0gsdSQ5R2wDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729562; c=relaxed/simple;
	bh=Ys+5qi9VOUrGAW0zWU3HKDZTgVChzkJJh8Nl6xLKydY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+g5c3O+V2ThHMCb0dISupmDLWEZZS9hGN9eiPlsiC7fu2I7jgStEK/jRqZGfCR3oPFZNEZvxt6MeKkGrcMlEQ4Cvmatzd/HUVz5UhVX8zbHlXH3AJyAJ8X6aLd4jH57k3lLqA+o5ymQ6V/bzGTKrhr+4EaOxw/AMKDNWhpRKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1dQ9gGC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso10917665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729559; x=1757334359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pgFBa2DZZvz331tX1/wrGaAvtDbVvMgoXHb3q0CB7c=;
        b=A1dQ9gGCjb5mnyk5KnD9fr91EUZxThukDzxreZeu6SBgxQeogBL/6bCIa8SaPOfgsX
         gy2m2G/LqINp4tFFvQ6kEjY2yqTZllAF/S6f5GeQuFQGfrb6ofOGB/Fx0hqCAchgu+tS
         UlnTcY51Pl5GY/UGVJm0E1fIrkDyU5c8HeV1KmGDko8OkIgW69RXw/iCUSBZ5n9kI1D5
         wxkNRt3llHH/09GCBVM2n8zlCXlLRqkAB/qoZmEvIsqzS6EQyVK1X1GZDSB9YdF7Uv8h
         wLYCkdLutWCxlWteUdTUYdYQrLgLEGyX2iP3gSHceD/1knsKXiZxt5r/pLq7XuhooT/r
         VWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729559; x=1757334359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pgFBa2DZZvz331tX1/wrGaAvtDbVvMgoXHb3q0CB7c=;
        b=gEMIsU82Ju4dIdwKVnxzSQO9aU2+R+nu+nPzS7Y3Yb0NZBYgerFaSFu7yPHX3Q+e2T
         MHqzIKofilXZCCyoXk/e8FhcgKiTLB8mCoq1lf6wwuF+q0uthMHLyAXwycIwlNbGltnd
         nqDfsYt9NnNKqBn8IDX0wU3xC5iM/0+fNTAtBfiloeftMNRjNiYRDPlrom74CbDRXxVp
         J8hwI2b677G9jLWewRzTsae6g012zUQzMqcrwtMO45/kbzKfHpYbWYHQC+jTQAYctb85
         FH5yeOAxwrwIwgCbggXPtH3yJMsMppHFPFW2zNDcnsWwQsOSYCiysbsQ/KcgZ13rrIP3
         tZhg==
X-Forwarded-Encrypted: i=1; AJvYcCVLwE4gcWe/QmmrfCt4vGVzny6Bw/qt3ZjUyVdoKUIbqaxhK2xq7NeT0LnUlOK8PyTHlQ88k8zN4iiBl1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv0LP30qUpHkX3/u3ZglvhaU4z9FDDtY/yFlTO9jGnnFWjP2et
	eKgS13dax0HFxYPSp0lcsC1D9FFnpPM6MSmiLJ+Q7NFSDcLVkbKeRUWL
X-Gm-Gg: ASbGnctvb8G/EBfG7izxSUiYDE7xTELniHvJI17fVzvaXYAYSvWpOXYSKdczIFpSP1q
	M1unp10oFiK0fJrvARAVv4iF8jHdu0szTZHg7d3O+DQi4b6KOC0DwW+diTM5fmfGBMJqPd7h8Gh
	DIVv31DIO89kyjCs48xL0l2ou86SP5vIIg9/iCpntL2lwAylxgePV4IAKnf7Fxyci3AaZ0hal8c
	DFHg3rKOTRlizTNlJok5X45D8fUGhYQKeXVJoyfXFvRGqtqmgszTzaHoc50zIKw3lg1TUL8KDHc
	nUxcxVjn4q3w+nZS3NF91DqRhWzUR3c6c1fTF9pYeJZsGRJlKgJRKiMa//t7Uoc706ndQNj0GMq
	q6jrQszFHxlhZTgv9fA==
X-Google-Smtp-Source: AGHT+IFIQW8wGdqAahWA03USmO7rm9GTiSdBBhXJU4ifoMtia9kc/qorfnpam+G2efQI0Rxva99X7g==
X-Received: by 2002:a05:600c:3b28:b0:456:201a:99f with SMTP id 5b1f17b1804b1-45b8730d443mr57225815e9.18.1756729558342;
        Mon, 01 Sep 2025 05:25:58 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:57 -0700 (PDT)
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
Subject: [PATCH v6 04/16] drm/vkms: Allow to configure the plane type via configfs
Date: Mon,  1 Sep 2025 14:25:29 +0200
Message-ID: <20250901122541.9983-5-jose.exposito89@gmail.com>
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

When a plane is created, add a `type` file to allow to set the type:

 - 0 overlay
 - 1 primary
 - 2 cursor

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


