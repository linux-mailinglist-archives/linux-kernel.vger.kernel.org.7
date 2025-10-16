Return-Path: <linux-kernel+bounces-856742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68256BE4F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56D914FF3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDD32B980;
	Thu, 16 Oct 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHMuK4e2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33ED328B76
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637418; cv=none; b=JxxZsIe3d7AX/+6Dy9yczoH+Dd6wuNioVtLIwSd+aSLSY7rt+mip3T+oNa/Xvuv3W9phvZ4OoUyFkVIbFIaCu21Ew38LTWNwwNvFOqZC3KwV39MRhAuh8RyZl2zGQUdW3TOHa3K1/BtUkqCa2qAdJzCIQbX9Frf3gN0EySQf82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637418; c=relaxed/simple;
	bh=Ptp2s6Px7TOCDb5vl2x+uUDYrRb12pqoYSwxZnX3e9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lceHBxqwvTRtrZTAlMMLF3MIhCAJFDnbJdlqNBLEMKkP4wbO3lEODgRLtCkXuP4Des4MBCXkRLoA3eHnyfFvzoz/dUkLwexpyW5Jk1BmFClLbMqYDp4J5f9/UZAC8d+A+JetRNdSKgHN25pZvB+h2tcjMKkPAcHeb3pHrQNL/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHMuK4e2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471131d6121so7987245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637415; x=1761242215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7w7rSx8/aFkCH550GdudR6K0Utw/IdDPjF/QW3Etas=;
        b=WHMuK4e2YXi+gl6kywXpK7Kq33FcQ/xT13v86+51H6cFhQ+N2Wa6Trq9bC9ur7EBjo
         nLbmTMj0VFGKoJJH5W0n4yi+31UM8zJLJFsu3AH+FuWyMi6zuGnEPaNNaX5505hp7zN5
         uPk/gW3rr2G9knz1hEeqncwNjSWsjGM0qbu6qQ9SjbSQQqBxuJ8VcbbTGr6cA4hc+vfZ
         YUyj4JxY2GkPIAFyQr6N0VZd77wSBpw9jBrzoC8SM0Vz4XpHS9/upl8aueBwZ8XBg7YC
         qkqfqCidNOSX9iYQstN0lz5qZUnwAGM5c8DCJSoo518mTiZiDu5w4cAtc5iOBKARmXRx
         egEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637415; x=1761242215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7w7rSx8/aFkCH550GdudR6K0Utw/IdDPjF/QW3Etas=;
        b=GLxG2lyb8WBdpPjVcytI3CZJDVWV5ne6BSocexNZYx/q9+XoLskTwZ8lSNmjWRLaZo
         H0HkTVamQK9Sqb0iXvEpae7GJX065zt/T6eRMZOOmCmh9kIUf5a6rT4gZxNje6gijnrt
         +/0MoiygqCPwtoyYG2joakkPsJiBYwS5rDKKigS84Q0hy+wfagro/YnyeeOLscv0FwmW
         zs0cn8qTSg6J+ErFDsPN+9mSwPbK+9QcUhLvXtuusIuV2que+ssmB/zYLOw2aNTPBEeQ
         XQxj1U4cNbpUMalcBdRHXyjmid7xG/oPL8MHFcCqR3cdGPF4uHbp3bn9H8MHw7JGQvfi
         kF5g==
X-Forwarded-Encrypted: i=1; AJvYcCUtu+DinswLBbplyT5mW75jUc5zEtqT41d1GipQA86cVbYPpPjBa1QWv3WmrgweTY8knL1KlUVVJl5Xv6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUiMHjKghWgBCIWv1hWmv46rdKZzPkP+vwnrTYZoCK/0kvpo8
	eKfP40TJ6BjWWS1+F8V5dyZvpoBE9kz3onnu7yYm+Ry5tONdJs3nmtE7
X-Gm-Gg: ASbGnctZVfIVEqLZitpa/Y5z9EeVN3m0Gmxxfgr1ssqp9pGdUXh0Q2FDp2R69eWEIEb
	c0J2JFHxIx4V3bTfDBrMcoXHjeWbzcsddjTWw0TBja5Wb9xEzsDvDFChO9YsbNl7svCbLHWqBdm
	hRhb1Eg/Qlta7AAkvX0Mgs4gW44djGjlKtDwpt1cZWLJeLMCNrHkXNj4nJSLyg/JQ53LucDQbSv
	oQ6q6cwefga+UoIn5wobq5tYaHAak5pYzHMNCTGlnQnr/8osaGnoYAz/0snGPlahkPMeUJQKlAC
	wWx3wm7xau2p4bTgB6z9NUiIPESOQuVjs7pemOdV/mOlarwdndISqq4Qc9XdeHZhWj6s4o35ltE
	AWIy3kGDtDP5+7OyfcHXndILhOsMUxRgrz208U9IUFdkwvCKTNl56SQOqOE5lHc11RfGIAY9R7H
	/bbS9p2qcPQA==
X-Google-Smtp-Source: AGHT+IECLJH3tyU8psXcO7Z3x88TzFB53y1mnPVi5423SNjlU5NpQAE5ErgxGxlx1kXh5/HNZN89YA==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr8220675e9.15.1760637415128;
        Thu, 16 Oct 2025 10:56:55 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:54 -0700 (PDT)
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
Subject: [PATCH v7 11/16] drm/vkms: Allow to attach connectors and encoders via configfs
Date: Thu, 16 Oct 2025 19:56:13 +0200
Message-ID: <20251016175618.10051-12-jose.exposito89@gmail.com>
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
/config/vkms/connectors/connector/possible_encoders that will contain
symbolic links to the possible encoders for the connector.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 62 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index b799102d54ac..31a3880ad83c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -112,6 +112,7 @@ To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -129,6 +130,7 @@ And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 692e1b708012..8e90acbebd6a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -88,11 +88,14 @@ struct vkms_configfs_encoder {
  *
  * @group: Top level configuration group that represents a connector.
  * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @possible_encoders_group: Default subgroup of @group at
+ * "connector/possible_encoders"
  * @dev: The vkms_configfs_device this connector belongs to
  * @config: Configuration of the VKMS connector
  */
 struct vkms_configfs_connector {
 	struct config_group group;
+	struct config_group possible_encoders_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -126,6 +129,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     group)
 
+#define connector_possible_encoders_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     possible_encoders_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -528,6 +535,55 @@ static const struct config_item_type connector_item_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_possible_encoders_allow_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+	int ret;
+
+	if (target->ci_type != &encoder_item_type)
+		return -EINVAL;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_connector_attach_encoder(connector->config,
+							   encoder->config);
+	}
+
+	return ret;
+}
+
+static void connector_possible_encoders_drop_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		vkms_config_connector_detach_encoder(connector->config,
+						     encoder->config);
+	}
+}
+
+static struct configfs_item_operations connector_possible_encoders_item_operations = {
+	.allow_link	= connector_possible_encoders_allow_link,
+	.drop_link	= connector_possible_encoders_drop_link,
+};
+
+static const struct config_item_type connector_possible_encoders_group_type = {
+	.ct_item_ops	= &connector_possible_encoders_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static struct config_group *make_connector_group(struct config_group *group,
 						 const char *name)
 {
@@ -554,6 +610,12 @@ static struct config_group *make_connector_group(struct config_group *group,
 
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
+
+		config_group_init_type_name(&connector->possible_encoders_group,
+					    "possible_encoders",
+					    &connector_possible_encoders_group_type);
+		configfs_add_default_group(&connector->possible_encoders_group,
+					   &connector->group);
 	}
 
 	return &connector->group;
-- 
2.51.0


