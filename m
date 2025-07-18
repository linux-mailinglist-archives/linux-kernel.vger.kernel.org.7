Return-Path: <linux-kernel+bounces-737076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D8B0A779
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7E25C2847
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204F2E62A9;
	Fri, 18 Jul 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOn+pqEE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655F2E5B14
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852366; cv=none; b=Gy4Z1WtQ6t+qRsidUxHqBAWrGhOsp/aeqZuqzwnAMOsjzKnMxpyYywD1lvZOeVltSXj4HwFmVNdGxjYKexGG1ECtkizRTn6NVrtaf3ZiVIG5Su8DmatzvlJaT6kPfgdq0bYDm9BttNzJ4G2r1+k519aCEyPPYxJRWJofOvLQoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852366; c=relaxed/simple;
	bh=ScLCLRIqg0D9AllcNOKN8LUxppc41hL1qONu3o/Rk/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1klFX7UQ/3MMcYzvsIt+Hg8O3xPZwO/VRfzvElp8P7BpAJzmEnUoNULMA7jgMzxAQmaDcYzyiP2h4wdAO2r2sQq2YIljoELbZYFLfOsCIibe0QNJ5VWAu4bB7kBy83An1jRd1COBangrGzMQOz+kXIn8jkZxAox526PyGVhHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOn+pqEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752852362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=npCFIvZD4nMWjQXunqvyJqz1L5WC/Eqwb8hbhzpP2gU=;
	b=jOn+pqEE7OQy5beAaSAfgx6k4rPvUiZDn+ISpP/9cjEMwmoxpnR8y7UsoMvy2Z7R0CBcFj
	dwHxR3+44krwxBpx1dZRyzLRy8YqUa5oaThmNjS+R2qS0CtMKDOsJ/0zdkJQb/UoCkdlBf
	cHteP9EV0ecFuWUcXE6zvdgaymhtvOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-a0cuKsUDP_q5VwKPSplpFw-1; Fri, 18 Jul 2025 11:25:59 -0400
X-MC-Unique: a0cuKsUDP_q5VwKPSplpFw-1
X-Mimecast-MFC-AGG-ID: a0cuKsUDP_q5VwKPSplpFw_1752852358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so18074905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852357; x=1753457157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npCFIvZD4nMWjQXunqvyJqz1L5WC/Eqwb8hbhzpP2gU=;
        b=UJrKsvmUI9B9iDfM08XF/Oaj3f+uNJuYYSvXCStaj0fUp9vDJLhSCJLXybV9xvQ8TX
         qN1Amp3q85ktu9eiIh7JA3Ga6oZWajLCvvAKobg3bDJHJPkwCjWA09jQP1e66orqmZpV
         lLjFR4sn+aBMyrm+Pfr7xEJgKLpoO3P4o0BYOxaK3GU+W1VNXIsPcLtqGDAe8JIU7zXx
         xvbFZe3bEV9+e0qkBsOgytQVwQOZcIcH3bKWSGBBgIgCvhtByoM/ISm1lalSD9J7pta9
         RdOQ7/TEWiHRJavPX+xTnwagwQfO/JfxO0I9vEoWPuSOi+F+chvPNam8iay/3nXrwfe5
         Lp9A==
X-Gm-Message-State: AOJu0YyP1VI7m/iWb6/+VoGidkBGGB+fO7Tbbdo2mr+uo0KsKbZfPnCD
	L9TSl29HP8wMLHS9vAU/ydLgtIhbzfOFsRmY0TsBmQUgqXyvSzarS7wgmCiGayYUfLxSwwsw80M
	VLFoLZmGq7IuylVLR6O2fSt814rfcCiefYFcGEEKANMUGixKGkfE0knpKSjulFnkraPFiUibRut
	qupCZYNteeqdLdTEDtpjJX9ReMzUc7HX9nMximw6xPNXoCSn6XeAQ=
X-Gm-Gg: ASbGncssBgu6q19JTFC5MUligDw7PTsRiGkeXClhEDmIR4V+r66yFjAb7wtznzTrAC7
	HDoVKymANIndWD5rL+cwCBoSzbI4bBeHEVwn1crTbftyjj/E6O7rv9O7U72MZ8mUHT8qIqP1eYl
	2tLN74y3Ld143Q/94AzAkhlD0RxoG1a+Y8bKtRp4fbyJ8rkn7Ec0kF3qzkkyDVmPq7loKuB35fa
	cE+BEcnhieMHkBbfirC8lCcnklFT8JkEdiR029I2PD3qZ1+zmJOHV4hpt9rAzGojAy6Wmh6jDLD
	A5RKWuxmyJ7rQ/L4qy68XKdVNk4YZixm
X-Received: by 2002:a05:600c:c10e:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-4562e4f7a2emr88271655e9.5.1752852357398;
        Fri, 18 Jul 2025 08:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDkDLlJBAwSABB8zF2zjkkMCkRRimlqeCwb5StQrZV+3hZCcSeEWzuXZzFurWyDVRxxz5NOg==
X-Received: by 2002:a05:600c:c10e:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-4562e4f7a2emr88271295e9.5.1752852356884;
        Fri, 18 Jul 2025 08:25:56 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e819e04sm82639785e9.18.2025.07.18.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:25:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	kernel test robot <lkp@intel.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/sitronix/st7571-i2c: Make st7571_panel_data variables static const
Date: Fri, 18 Jul 2025 17:25:25 +0200
Message-ID: <20250718152534.729770-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot reported that sparse gives the following warnings:

make C=2 M=drivers/gpu/drm/sitronix/
  CC [M]  st7571-i2c.o
  CHECK   st7571-i2c.c
st7571-i2c.c:1027:26: warning: symbol 'st7567_config' was not declared. Should it be static?
st7571-i2c.c:1039:26: warning: symbol 'st7571_config' was not declared. Should it be static?
  MODPOST Module.symvers
  LD [M]  st7571-i2c.ko

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507180503.nfyD9uRv-lkp@intel.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Also make the st7571_panel_data variables to be const (Thomas Zimmermann).

 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 453eb7e045e5..dda99cbe5372 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -1024,7 +1024,7 @@ static void st7571_remove(struct i2c_client *client)
 	drm_dev_unplug(&st7571->dev);
 }
 
-struct st7571_panel_data st7567_config = {
+static const struct st7571_panel_data st7567_config = {
 	.init = st7567_lcd_init,
 	.parse_dt = st7567_parse_dt,
 	.constraints = {
@@ -1036,7 +1036,7 @@ struct st7571_panel_data st7567_config = {
 	},
 };
 
-struct st7571_panel_data st7571_config = {
+static const struct st7571_panel_data st7571_config = {
 	.init = st7571_lcd_init,
 	.parse_dt = st7571_parse_dt,
 	.constraints = {
-- 
2.49.0

base-commit: a55863ba4c9ea9febe81ecf7dba36e7989a37b7e
branch: drm-misc-next


