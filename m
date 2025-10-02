Return-Path: <linux-kernel+bounces-839735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177EBB2475
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8953BA3A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11945038;
	Thu,  2 Oct 2025 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3nopgHj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D8442C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368804; cv=none; b=t5OSLLt2ftRtqBQ8o7M9yaHj5TtNuTFDziuxQKv61Y0r3eEsV/0g6wDa+Y7yhjuHrGU0UZudfc+E8axErgRE7NkSCihVTN0qQxv58FhmLb6EQRA/vP07tCvsOeGlsw+TBw4mW8fMZuNF1apLJczxBNVXIFRw5TebEoEg6AEf9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368804; c=relaxed/simple;
	bh=q1hY1mnC12g1KtRd75IAH05y6jDKKd01PVq8WO4mM3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cnn1DFZapbI9zItxVMJcpH5OkAjBH+eH92OhPcoH9pU1krdmrJkSjT/L7KWB6xStIkE3I5TT+2HPhIDFRNsV16BpSNoCrKyA+Rev7TxQx1zthIT51/AtocEi5pkk4libXfskG4WOKNc5HCfAhKZ5LT5BbqJ91Du+YdGR+nvAqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3nopgHj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7833765433cso846391b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759368802; x=1759973602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RaVli6Y6NQOLGiB1OtRJiZY2C9eKiJeUFKgxLfZ7xKg=;
        b=H3nopgHjeD2+hQa6t0oQ5T/2+MVCWNl6owpcciqiXFwhm+rba2V85GAr2dyHI+NguG
         Y0K5S2zKfWT3YUF7qqWa7rghGGSgPLsi4jnvMQdoFHTX+4yrzJ3IJq18bI2J4W0LUfhw
         m6o1ho5Sg3OGrtzaWUct+6tb81sH6CT8u4Xym//nB7xzDUU7X3B0sW7CXYAlvYA2ePQk
         o2KQfbarFytshiuNIGSPVswswa0WnaJnsiQqmw7SlnTWNbCVHVYEqdo3kZmJCaMdqEy/
         K/d7FO+uP7AZzn3RimnT75Gpeh0w/gBAq0uEXrVtYQ1goCD0c5WaW0A1oDoMF1DYVG9Q
         lSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759368802; x=1759973602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaVli6Y6NQOLGiB1OtRJiZY2C9eKiJeUFKgxLfZ7xKg=;
        b=ZFEq2yf7wURW5s2CTb8qGYwzntYayM9nRFerbTcR+5ztdcujyCp/e/UsUH7EKxA8aW
         xCR2Pd9dHtxAEoaVtSLrlUqp33x8SGuKlMNdXYQOTnBfZZwQe/3SPz6jVS1D0K96kpwQ
         Pxv/+1URS2MJVaVKGcWFX/Jb27qZ2uoPT2rggOdRkSKHy0axrP11kK4r03ZYYpIf7/jo
         Ar72gtf8heYfx1ucxSevmi+YjwsJQxymG5t7aitLcdYwcZgEqLHDx6/eqrVaLaaqv/2/
         dvdLNLVzj0EDM5PJ+F8zePXY2G6WH2s+lDlxMKUK6cYkOur18CiAlbnPazDdO3kn5R1k
         PJwA==
X-Forwarded-Encrypted: i=1; AJvYcCXU+4m9BxX23ibH+JVNyq5zcs/sFyWBZ6uKJgji5LFG1yfbeyhkKTwpaG18NjkqPArv6M+gkIX/VTzMDtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHGb3dDp2yR8po/hHoga/9A5j5LutxiO8ydQRtvsljOOa0FlU
	HLHF8TtnBkDy0e/omLztKLSNn0eCvPvsjLBQyQIKw1hc51t8I8/Pgp55
X-Gm-Gg: ASbGnctramLVkfgV6Vu/v1KXiu1dfgAVfb9QXDD4rKT1EVFf+DiRrLt24jGmQjXVFAg
	0411cbjxtYUK2OCE+L9QZRk1A+gxQAnIhps/Gfj8LyhjVMwwW/rgJQxfB3i6fuf2MDL8I0fVwvF
	9FtJL29AI/sy16N/vvgVXydfdjmZepKOpXvJX+sRXI6a3ZT61+Uit2rqYMxKV8f+QAVD43FmHIW
	1hmCVDDDk13SdKSp3dekf4ybkaRzD6NOWmGCy4AdAhAJwt6zMWlJNdXQZ8LSIYPfuqMzEKLcHDc
	xa6ghe6facePZZN1/M/vFH407BzreFXz3lNUdIcM2NvQSAybz6d6JSOWJD6m6aIZya0ifZNHSB0
	WQbOv6uFiMyIY4sXodLGHyVgCYLexNRjGP56BunTvCRuelWHbdZKM95D2USLwx602gi+17c5k3Y
	M=
X-Google-Smtp-Source: AGHT+IHy6EMUx48ZEgtNlsOfQJMXzUOSIEhbwLkoZVxOSg5RvomWwbNs2l7nDhzWak/dvpq2kvkchQ==
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-339a6e2821dmr6968345a91.6.1759368801843;
        Wed, 01 Oct 2025 18:33:21 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.91.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm1008832a91.5.2025.10.01.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:33:21 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: avier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Subject: [PATCH] drm/ssd130x: Use kmalloc_array to prevent overflow of dynamic size calculation
Date: Thu,  2 Oct 2025 07:03:12 +0530
Message-Id: <20251002013312.67015-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmalloc_array to avoid potential overflow during dynamic size calculation
inside kmalloc.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note:
 Patch compiled successfully.
 No functionality change is intended.

 drivers/gpu/drm/solomon/ssd130x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index eec43d1a5595..8368f0ffbe1e 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1498,7 +1498,7 @@ static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	ssd130x_state->data_array = kmalloc(ssd130x->width * pages, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(ssd130x->width, pages, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
@@ -1519,7 +1519,7 @@ static int ssd132x_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	ssd130x_state->data_array = kmalloc(columns * ssd130x->height, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(columns, ssd130x->height, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
@@ -1546,7 +1546,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 
 	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
 
-	ssd130x_state->data_array = kmalloc(pitch * ssd130x->height, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(pitch, ssd130x->height, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
-- 
2.34.1


