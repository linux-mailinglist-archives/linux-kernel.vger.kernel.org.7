Return-Path: <linux-kernel+bounces-825610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888CCB8C502
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBC5626E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4A2EB87F;
	Sat, 20 Sep 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW8U3vR3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5E2D6611
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361582; cv=none; b=SUiL4X7LBhnZJ4DY2MeknyYhY98rIvfFhNiST85SrS2pcCD9nRFWdKLXtIC8UcRTHfpBUwS/Sydrm5YqyD6r0M2omfby/Rvce9/Qyo0vxYEsW7GbzVrgusmk/hnhYbDpaWKUGgZaV7gBOX0Gda4gnJYSxlEfsyIg7WU12k7Cg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361582; c=relaxed/simple;
	bh=06WkZlQp1hApWMQfU4a2TnIBkA0+msj+U8y5ce57UNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoXK7K2fvMNPo1HupsVpVuRVi4IQXmABdQlyGFAcitZHlGigWM/h7x+xYyEFpc6BuZWb4yj8V6+sf0BVF8cwLVxo5+Eia/EQEZMTH/0jMMxQNHTJneSON4r4K56AeT+6KIm6c0nnBuf2EU1Ke8enzFRY70xNWVigIjF7VamRtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW8U3vR3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2986862f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361579; x=1758966379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq2teog4gIQygb1gH3aobDn756RO8w24JG5dF9G4uFY=;
        b=cW8U3vR3Koxb8F0qzhUQ4obiW7JDTCq7A9hSCY0nVG13vq1mMQLSOUMPEnQaTxh1XQ
         9XNqxeLzPB4ugBzMhQF+NtK0gwUYTQSR2cKV9VaM5YGzsEec4mQXKJyRJCKu3S14Gtlm
         N8/vmV5E0OnRF6nOGA+l6G8EG98KXKldKeCbLMd2jBh2LjEF9EeGaKYQ51knSsAVm/zr
         YXcDJ3xyT/i9HJvDyczQkx0Dimewz/m0nS8Lxoqv833s8clUXYCsmbJns2+TKpevBVy/
         +IpOg1rTVGcYyEoHBQh2/6g+7tS3qVtzl3Jp/uCmLK8Ut7C+fO2t/V0SkbWTEM9ueKi9
         fkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361579; x=1758966379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq2teog4gIQygb1gH3aobDn756RO8w24JG5dF9G4uFY=;
        b=WEQkA2dKs/WF7E6dXPA1DTAJ9xmmy9t0lLVmHBJ5PMqZ9+SHTcCyXCT7ofSv+u0E5N
         Pl+T1jMX2D6ut+gLdxKWseRmKH3Fsq5q1ISAslz3hKlIRm4jBQGBvr+HfhukdXJN4kxp
         2Fj+F1aprObavoCu/2cW50HvH1LcV9b4pULjXduiaG2mbIitL7OC8/R5qFQD63NqV9/2
         NKkrchvDdL74zfXMzgnIRzJn+rdkp7KCZ8nImWB1idldQafGTRFlgiHb4uvKXIOLmfoc
         A/5y/fk90jSorVRlmKcEGaUqA2rYCTBEN9a31lIXTRAFYe8I/QZxFLrGjM3ilvNEYSqj
         UecA==
X-Forwarded-Encrypted: i=1; AJvYcCW5ev9TZpv4d9BWu27ehTzKznH5I1CirFzQCOYG3BcYMMb57pBCmgLUf5WQ4ovf2xCx9Z/y3PbzhHbuW4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtAHwpjIskp9+dldNV66esvjWmpmfm8vQgXiHdGH7VAMcteJF
	qcXBsSLWqxJf86qtWOXB7RxqGy++ISI/ZTGyO6poT8ef58dBK/5efSL7
X-Gm-Gg: ASbGncvc7Nf10HfR21srNwvPWoQ6c0voeFey1fRYh+uTzQYza/P2WUzghmfvmN52tXx
	bbPIdRAP0L3fGketrFYEYcqTIYPbjr4/sNejXwFw5ieDqGgUlTtggxqQCA3ZgPePKpGNMlRkDVA
	S+9BX7s3ESHpfVkc/njRuBNgQshA3yZGwrw7L6+xgokNaFIqYq5ZgHgsf7mJheUP8i6sv7m5ulG
	g7AOOTBTakr1/iI0i47zTjHkODjccPtMlXW7MQfzeQc24SFYbYfEhLHKC4O4k2VUsvX879iqUP/
	U5ieGL2AqcYZla/VJwQ73IqWeAJL0zCgqN34Qle3RD1YqQ9AxgFF/bmdK+kR8+yNSGv8S463IWZ
	T5ls7ZMBqoSWkeU/U7rw78ao8cP9C0woCIXkA9hNsrQTpIDqFByxKV3kLdV951l18
X-Google-Smtp-Source: AGHT+IFl+MC1nDaVLJuiZMNJ7+rEO5Az3pzwP23zFiHFFh+Nl5JFajqsTQQ43BuBBoBZUolOBfA1hg==
X-Received: by 2002:a05:6000:1862:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-3ee7c552978mr4924011f8f.11.1758361578687;
        Sat, 20 Sep 2025 02:46:18 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:18 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Sat, 20 Sep 2025 11:45:45 +0200
Subject: [PATCH v2 5/5] drm/solomon: Enforce one assignment per line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-improve-ssd130x-v2-5-77721e87ae08@gmail.com>
References: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
In-Reply-To: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

The code contains several instances of chained assignments. The Linux
kernel coding style generally favors clarity and simplicity over terse
syntax. Refactor the code to use a separate line for each assignment.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 50528a94cd3bcfa46517c6ffccf3f458e17cf816..f3dd6982b293c74024f7d70a6ef1ebfb5889b0a1 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1867,10 +1867,14 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 
 	mode->type = DRM_MODE_TYPE_DRIVER;
 	mode->clock = 1;
-	mode->hdisplay = mode->htotal = ssd130x->width;
-	mode->hsync_start = mode->hsync_end = ssd130x->width;
-	mode->vdisplay = mode->vtotal = ssd130x->height;
-	mode->vsync_start = mode->vsync_end = ssd130x->height;
+	mode->hdisplay = ssd130x->width;
+	mode->htotal = ssd130x->width;
+	mode->hsync_start = ssd130x->width;
+	mode->hsync_end = ssd130x->width;
+	mode->vdisplay = ssd130x->height;
+	mode->vtotal = ssd130x->height;
+	mode->vsync_start = ssd130x->height;
+	mode->vsync_end = ssd130x->height;
 	mode->width_mm = 27;
 	mode->height_mm = 27;
 

-- 
2.51.0


