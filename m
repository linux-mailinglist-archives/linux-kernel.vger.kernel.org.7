Return-Path: <linux-kernel+bounces-794508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BEB3E2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36191A831F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478A3314A6;
	Mon,  1 Sep 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Gfril/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36A327793
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729565; cv=none; b=r0Ja6ah+c1O9uBRHYFiLRdX4Z7VGEZuGjPgmMTxeSMf2sUi++wrJ3CMQA2i54Y8098CKA5WdZjcPBHE9VoOjFBgndGL8s4zB7H4FPiWlHrk3b3oJl/pmcPg92ayb6cFVDXRWzc4JIOv/Le+X1jHKrDkOREyy8tbm3o+qPo+ZQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729565; c=relaxed/simple;
	bh=hsHIFMTVRSRDHWUv8g6T8LuLhM3imqVkRiHXF1j90Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuXzAGAjIsxrc9DJ17AMeByL2FeYfHdG32Bc/3UWQsR8lznfrMeYyfh6qe8z0QP5HSkj9pzZYSKmpMKpHln6yQHHpDaqIr/M2Bqt47H4GmXgyV+HSI6l3RAAxXmXxmRVYDTrXfq8LGPwDbdS6/m5xLkME6yrLDTiGLe1dhxjiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+Gfril/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so1754502f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729561; x=1757334361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhgkvBTCE0C0PpkJQl0fVQ7vOytz85QGtS9e86SU8oY=;
        b=k+Gfril/cZy4J92f5OJYt6M57MbSTQ2THCcwBvQBMSQYuS7k9U/te8as6sMGSC6M8g
         HkobC1ng9JxYavaawfdwdXAPjtNX4D6QrC7C8VnF3wFaD1LsxS2BN6V6yVVczbow6EC+
         glktJmh/dN+TPo0VPTOjx3F75GeSizLbXE3t/rdhAH2JvGxcEuqWyuNesQQGkJpl+JAI
         4cTtYvZ1Afi9uT45S0ArCJF979QXAchyrR5XxiSiMMCFju9bCXNmKmKKjIh6tG3c25Xs
         88AKZVwB6DidelXc55MBZ0E3VoyZvd3kksP2LPTlgPAb2G2baOvw7RHrXTg0T4bz/pE/
         HmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729561; x=1757334361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhgkvBTCE0C0PpkJQl0fVQ7vOytz85QGtS9e86SU8oY=;
        b=tKMIDE3h5XEytbJj28f9gWeg3gOgLcQNSjwR68N8N9S+iJzhhfEw7mitauyFi8quMK
         lRajmP7uiWsjvx+ECBxsJR2KIzT2iAh/h0dLOLZGPxeOoDrNKiOQgZYRY7iarmGtsQLR
         aL8kOEPaRz2zuVhMVtFZmDPH9XjqAw+XtVUbusPQdFQHgH23vCVyd0yoYMXg7nkUv/YC
         FWf3bM7ZuIsZZloQ3jQ74uij54/7TZykhzAF7lM4wO25edFQTmxIH1s6cyCwJQtgcxuF
         r4CMvWcuWL4aRsiYM6e2aILfe8oNORAXbpa3Tk+DD3LSchvspGxHcqY9DiEyh9UhrlvB
         1wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkLNVnuiL7p0+J5hk3iI1K9tBQiq/nfuAINxXPJQKVIAl9TUbKLo8nfGNWDncmSlUccR5B4s36pTclupg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdZ2W/0E7UdeSRtGL1P8TWKsIQcYym/tpUuvILuFzkk95kjL9
	vllW5h53fJHenXd9Xr0EAOuSKIVT8R2gxMMjWxheHz/c1xq8vJmBJIs+
X-Gm-Gg: ASbGncvamKtqQiRhY2VzmH9o7yu8Qx4e/2NcMYMQe7mGRjbCee3tPQy3wHgU6QMnIau
	b8yt7lBMW2BM+PMAJMfktJ/nrJCxTP3RCWGN9MseJWes41b8l2xJpZbBbNvYBokh6hmMMTwWazL
	f2mPkJhkZ5v6xpXkaqBUNmJFo7r8zuXKBj6NMKs/9xgB2DatX6nSBL564MDN10W2pLqPxXMhfHM
	diIrK2GXmsvbSAv6tK4nZmZDbbQs3zb4eoQ/VTWEJjEQ6+/HdcoHk0+Ep3C/awsFGgqENJyI2hI
	s0aP+/SofZ59WljBBkcMn02l/6UMMMGjTNWi2xgDjsmbOdykNiorZCvG/TKgFsymDzEWRj1vkyv
	HxxTcIvPMVPpI0FoT3fGuSxNR0hmt
X-Google-Smtp-Source: AGHT+IFyxCd/v1nUFUVSnKjpf2X7+zw+bdrPnqE3ZWLFkWIx3xO0PpowOJcQy9w6v5eXOmfgB96NYg==
X-Received: by 2002:a05:6000:2889:b0:3d1:61f0:d256 with SMTP id ffacd0b85a97d-3d1e01d549cmr6713622f8f.42.1756729561295;
        Mon, 01 Sep 2025 05:26:01 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:00 -0700 (PDT)
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
Subject: [PATCH v6 06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
Date: Mon,  1 Sep 2025 14:25:31 +0200
Message-ID: <20250901122541.9983-7-jose.exposito89@gmail.com>
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

When a CRTC is created, add a `writeback` file to allow to enable or
disable writeback connector support

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


