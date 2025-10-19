Return-Path: <linux-kernel+bounces-859715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D2BEE657
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1127240824A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2B2EA75E;
	Sun, 19 Oct 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyqw95y/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F01514E4
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760882391; cv=none; b=VCdn2iFd7HzKTA50Pc8ecT76xmF4fM1PKhVAJr4OR2org+KkTCl8nsAWf0AWDpmwXJSR2PsCLS3UYkGK9x1/riLQbf2yhvjvhtX84Ck94WMX0sLg19LJQvS7GcjYh2NXkj4FXOdt0TYM0sHGpNnrWNxrFKhVZ5koSt4W8EkJ+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760882391; c=relaxed/simple;
	bh=zUtbLDy2uvin1t6B5rhoy0/MeRjeuBSxqlz3kP0hk2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/jEi4NKbxtpXeEK4VZgzHSJHNJFhFusYCRVIk4nC06wmECrfQvTHFElE5iv88sV8IR/KrFyDvWCgBbw+w0EZI0Dj0HD2innP5HbQT2KGSTPVYMzVlZAHsnKs/F+Rc+kx5kVmo725j4TCdz8nk5zNBU1y2LsAIrWeZlX/NT8qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyqw95y/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5dfff01511so94648666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760882388; x=1761487188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpzQRX6WX639uhyZU+I8IkskcZk9DHNRhRlL05G9pLA=;
        b=Uyqw95y/4jnqkEsUUOYq2pXeAbuGc2WeU1L1MMC5U83Xm59dkGS5IVtk/jiRgQhYp/
         MEkmv13QffwTmBbN9S3/2EIU04e4yXlbAKk5Ujt7ya0u29NUJO3Dsp/5Ta8AJA493vdy
         Ve2MBMfCI4qbOjkLLPZVhMYlFtkyyr0oHyVT5uvAeaAn2o8iJ24/xwinG15a82hh1AW+
         AsAJSwvk4okXY5MTnhtxcCCN+RHrNGM0x81fDwBGgXHiTOwzZ589wdttCc59GJ6RAeSM
         VetopmYma1F1dxAgM3Oyj19rE7wEMlTPgbjeD1GcHFTQ1lt5A6YIRBi9eoEBbyyfS2lF
         td4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760882388; x=1761487188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpzQRX6WX639uhyZU+I8IkskcZk9DHNRhRlL05G9pLA=;
        b=l05ondre7pIgIIeo4r51UMOEIdwLiMf6zsbIfvyPj2iNPMQLVbAidkO/wAgi5hChDv
         N2SkD1nYYh6zySW3KzrmmwZQI+a4rgjvjIqkGYaixo+oebIlhXG7IbrlK083Tk3yHDPV
         16moJ+YBTXw5087RkLQLOawiu8QAG409GNJAiqjoTHfYmME64M56dUHcsXc3x9+mcUn0
         rZ7LrrQlumb/OSPwvNy6whFou9uUXR3QO2fWVWST1wuFk64Z7LvI8+4+UYr56LqkOI5J
         A8bBbDeVoYaHt4IUJAwiYeLtHyy2ZegYeNb375Tp6s+6ISPlo3fJrCJPnzD6lC3E6Vtu
         ih9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQk4DFwGGsp8hYu28wXTf3HBQedCGx2S3giWAJE5ExXs+0e6iEZKobudik0n9DVbfx0dczUB8XzdGihEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFH7qkF/nOQ9FRQ3ddhnL0kdkS5emhhAq9EGr0DfeM107Jni2
	KGPeHxY1l9154uL//NwDJlnDbhgj+VBj6Xiz2rgCfWrJoUP3eGLb74Nr
X-Gm-Gg: ASbGncuuuvVRhaDAhmwYNAR4U590818gXUiiWf4LuKEnSTptVl5nmyphspbYHNHABZI
	sqRzggZPlWfTJVGOKIM1YX47Aa5BOlhVDfaGPAv5qwXeJ7qIB74V7LVZ5018xWcW0anAVnjb2Ti
	330htFgYXmReCLfVQxn3z9np/ByeFRW5QNzCc5JataIZLtU+a/eMTERyimHxCPwONwEmgYMakpq
	4pojvs4MX1TJVLq+G9kYuZZB9LHBuHg0yvtnn0SqAz+W8xya/Q3w1HkIgzXXvxJmXFG/RkD1irx
	idrm4/XpSqGZetNC4nVsFIcx5tSADpFal1CFbGueENRJnOvsUW0iCZtehgLJR3F1ud/OofsZOTm
	/rE18yW9bfZEd4pAlJtfSUyenKwDqizfiDnG4s5f7krB2/mE/780xbf5nScLjLikCGmJcY3fqwN
	YWpDbN
X-Google-Smtp-Source: AGHT+IGKsrS2Ps3uAG4Ijn1Z/Ftl6Ae/MX6Mq06xwDMBoDY2q0splxnviYgwXvJO0FFabIICGi4lTw==
X-Received: by 2002:a17:907:9708:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b6475505d94mr636158166b.7.1760882387324;
        Sun, 19 Oct 2025 06:59:47 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25c9sm520425966b.11.2025.10.19.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 06:59:46 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
Date: Sun, 19 Oct 2025 15:58:56 +0100
Message-ID: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc() with kmalloc_array() in several places to correctly
handle array allocations and benefit from built-in overflow checking.
This prevents potential integer overflows[1] when computing allocation
sizes from width, height, pitch, or page values.

[1]:https://docs.kernel.org/process/deprecated.html

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index eec43d1a5595..0ce630861d34 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1498,7 +1498,7 @@ static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	ssd130x_state->data_array = kmalloc(ssd130x->width * pages, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(pages, ssd130x->width, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
@@ -1519,7 +1519,7 @@ static int ssd132x_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	ssd130x_state->data_array = kmalloc(columns * ssd130x->height, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(ssd130x->height, columns, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
@@ -1546,7 +1546,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 
 	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
 
-	ssd130x_state->data_array = kmalloc(pitch * ssd130x->height, GFP_KERNEL);
+	ssd130x_state->data_array = kmalloc_array(ssd130x->height, pitch, GFP_KERNEL);
 	if (!ssd130x_state->data_array)
 		return -ENOMEM;
 
-- 
2.51.1.dirty


