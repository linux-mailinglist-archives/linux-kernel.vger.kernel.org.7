Return-Path: <linux-kernel+bounces-856737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21404BE4F32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E715E2C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEC3176E8;
	Thu, 16 Oct 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CozlZmTu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A8235057
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637413; cv=none; b=YSZ0rI4qZgPb7n/5Z/wz4Fe42b9HW3BwTGU1pyCKKhGmBfLJKXElL/vsevRYFcKQM6IxomabqQz7tPSrgMe4/LIxg6HFUxhQ+qWIiGgcQI5kPh+XgC4o0cWaQ80QDqP33gsXUTt1253txfVVQormzU9/dSk91RcDU+a91L1gxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637413; c=relaxed/simple;
	bh=SY2foPLIcYHR71hn99e9tqmbB4iH/zgC4NTb6fg7Cxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5OrQ4AzS9t0awXWoHYz7TKgN+GNQIGRGYcr4UpppeRGF7RlJ1uZoGhC5kJuPRToXjoO2sWG0vnaHVbqDpU3hA74NvSnw/Kl2XjTCs+y01JN+hHH6jPY2bspvMehLNqa6F9/m1VnbVeR3x7GGo7eLOUz7WOuxtpqFGcoXpPlHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CozlZmTu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46b303f755aso11291285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637409; x=1761242209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtjodahfnBWK2idIHCN4z64kayvb9QbUktg8KpiV9BY=;
        b=CozlZmTuHPbp4gw418USOocHptGBYIp/qyYZlpNaWNFKvw/eHTFOkGZyGl8IO8QHsC
         0EN6aHVe1plBxunMyV5omz7KzpiXxhDnXFQqCxRIP+0Gw02+/rAM9AUnfr6NEqeJTilD
         ydJR+kzvU1RcAcQpERIn0VJ22SgKa+dNpqpfT78EU4gyK2UyOvFm3UPVaWuitKksf/+g
         QEJZLL5jHPJmonuuKpK9O0MwvbNq5+7xdq1wIoLCx6ghbw7Jd/+Axn1P2W1nqTSDSGX2
         T9dfOxBLersKD5RAAf9P6g6yv7FiNbOhPn5UXnAx7PiENBuqfA2EtsKScMhybSFUEfN4
         WPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637409; x=1761242209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtjodahfnBWK2idIHCN4z64kayvb9QbUktg8KpiV9BY=;
        b=eOlfQBdN8BU7jPsnJA0IUbWfKLPYrS3zLlwK0qWNiKf02EUG5etKqiSOuo9Wq9T/hl
         3xIxYc+aKNkk7AkL9YJTDSU9w3viBJ1vCQKhY6zAxA0034bJwXQovHPAd5UNKgzVl0Eb
         RacO5l/wboA3VPKIXkuNb2G9Ol77gPvJRs7CU2iKyLciDoGQ5oNZEVwOINB1RnvNvl3I
         t/ZSdcCUBjyDWwgxVKvPERcMGPzakf+ZvqI010c3NJI1hLOVb5l9A0bCUtbYfEihhoz6
         SbBfp0REqdf4lYLIxuH8RwaWex4JGwJLbmlqQHBuf96QXb9AOUuPm1IlOxN7t6SfJ4dk
         oGHw==
X-Forwarded-Encrypted: i=1; AJvYcCXVLSiTKJK6fz+UIgwXvXsvs/FNwyprQLZmrpT0H9JWj+EzNeqLvhHekU+OfB7Ouu82grvrM3hqOEaOKIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnaM423xVlNXgyOojzPcFPyC8yBMLLpi0Pb7Gv8eaezr9ovib
	K+f/hxxaOVaiLHdG2WIDlHGatqJm4POgJpJ0C959lKiGJC08rPMbbQBN
X-Gm-Gg: ASbGncu8mh1pkwm91MhwPydGv66CarJgKWioo4RSyI7LNuGFNoJs1fDgRAKASefPEtL
	lDZgpiZBm8lmajxOuiucoi79uDAm9yXONoZNucYbX/W2CYHv6x8sznDcBqY/aAtm7IfpCOG2EEm
	BaXqShPRGOtW0c36X89wzLxp8kbaTOb+YG9f5mYnJJW7yehj2KhT3/nq2sEnjGSKv57XVUNkFQb
	8DxVfRT5XVYCXP5PrkUkup+/a7ekChJNURcTXgYQxK/agy5f9zqktF2DCKueQf+w/beakAvJW4f
	F0hkGwO1rb/1DWFC1sCxOXDW0XWBaxMUyhHE+THWC8qrsvqSDn0d8xYZxjLWsiGSU5x+Ntef+zT
	BpZI3IRyIpfUpYr9xkqhStPT+5r9IroSraPua3ucu4b93Ki/bpC9g8A28/ksL+TajTumxDdRyoC
	Am2OWZWLdlww==
X-Google-Smtp-Source: AGHT+IFxXmdNOlcVtdvS4hUg321uETDeeRq45sSYgBzQdlmRPckXfQEInsx2sGlszYksJDQMbCl6vQ==
X-Received: by 2002:a05:600c:3b0a:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-47117917a33mr7518345e9.30.1760637409294;
        Thu, 16 Oct 2025 10:56:49 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:48 -0700 (PDT)
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
Subject: [PATCH v7 06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
Date: Thu, 16 Oct 2025 19:56:08 +0200
Message-ID: <20251016175618.10051-7-jose.exposito89@gmail.com>
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

When a CRTC is created, add a `writeback` file to allow to enable or
disable writeback connector support

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 42 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 7396447b5e58..9f76918bb1d1 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -94,6 +94,10 @@ Continue by creating one or more CRTCs::
 
   sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
 
+CRTCs have 1 configurable attribute:
+
+- writeback: Enable or disable writeback connector support by writing 1 or 0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 62a82366791d..e9f445043268 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -74,6 +74,47 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+static ssize_t crtc_writeback_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	scoped_guard(mutex, &crtc->dev->lock)
+		writeback = vkms_config_crtc_get_writeback(crtc->config);
+
+	return sprintf(page, "%d\n", writeback);
+}
+
+static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	if (kstrtobool(page, &writeback))
+		return -EINVAL;
+
+	scoped_guard(mutex, &crtc->dev->lock) {
+		if (crtc->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_crtc_set_writeback(crtc->config, writeback);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(crtc_, writeback);
+
+static struct configfs_attribute *crtc_item_attrs[] = {
+	&crtc_attr_writeback,
+	NULL,
+};
+
 static void crtc_release(struct config_item *item)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -93,6 +134,7 @@ static struct configfs_item_operations crtc_item_operations = {
 };
 
 static const struct config_item_type crtc_item_type = {
+	.ct_attrs	= crtc_item_attrs,
 	.ct_item_ops	= &crtc_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.51.0


