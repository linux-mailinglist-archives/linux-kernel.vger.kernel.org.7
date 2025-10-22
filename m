Return-Path: <linux-kernel+bounces-864859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBBBFBB70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75418505DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635DD33F8CC;
	Wed, 22 Oct 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcUQ5Jq1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422E33F8C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133492; cv=none; b=DBiEI8l5/+iHmrHlP0HVGbI1O84agymWSJfxt/Zr4LGelhqE9CFcbiVYfOUA29o/2bnzXvoboDhQ0/iVT4NOmkG990T/BajviVPl1OitUpyfY8Lsy2kZCBqoBzE81+ci2Q3Tjsm+EdL2wOLNy7eoZOCC5Jv51EVbgcmgNTnYZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133492; c=relaxed/simple;
	bh=QMcBFIVhysiDwfVypM194suTaK7RnPDTjd6DwYRaffA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/oj4fsuUJzMKD8F4QtWXduPFGJsHwn8c0adP//bR3lzuPEwFAoH+sD6NKlkikoFSdmDiISMPtQWax14AFiJd2R10TZGDdgTWW7nXU+QzvXWypvEps15CnphGvLObe0DloGWoJMQnla/dvoV6hNeUSqDIzQw8WvrJu88+O/uVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcUQ5Jq1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781251eec51so5321072b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761133489; x=1761738289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onKFYxz3qx1mgItW1GE5HTsCNQVbyGrPrKl8Wr6AIZk=;
        b=hcUQ5Jq1MmtIJgwOq1jJx9QpUZpL0/NNmiQV3KPLFckGtOLImaWn6TlGZpU8jbIdNU
         FfbCe/KaDwzKLMBPqf574ipwXfOyi0OWbZOx/zVG3em3X48gOJlS+wXtBr92dvw9lQVv
         6LNWqLJG3xx1pWw1vKTOsRylMG485cyr6hm2IdKmEFPrE3Q6D/YE4o/8Rw0vnlOwHqD3
         H3YGQ1KxDDt3rjt8ITkuUaH0Gj3A8/siqQ9kSqnE8taJdU5TBiuJlZm96ktAh7Dlqb9U
         r4UdCYs+hpswR9S5ixpy7jWtuLgBiNpIkuSuTVO57qv66ZCvMV/mkqD4XQBbMJWgI1dg
         lU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133489; x=1761738289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onKFYxz3qx1mgItW1GE5HTsCNQVbyGrPrKl8Wr6AIZk=;
        b=gJhcB/SvAl6E7lCRIpYqOcdUFtUcEkvgxzKH2+J3zlHxO4s5u90nbYk5Nv0yRaKeqT
         3nKe2FgnGYW0a+2GRk7S98LcEcCKUB7grIP0yxDcl/Ol8heMLOTL5DCKBmN+Nga/tx9/
         WvAMdsev3od5kreYVCMHJmlUPk0p/AtdeDPcTQuhI+3wxM3iqi5R4TZ+u2XmJz+EiqN8
         Bm7N+SyXxEp2e8nNLVOYV44uD5wi557OVfsPGa40pYZyUaT8khbqhlyazvkHi1KukM6s
         NuIJZ/S5as8WV6MDEwTDwOMvs3q1KG12CfewFz7xoocwTXpmss12fKyEKHEHFbfORlky
         8sUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsO6PDf/15szrb3budo6WmlVE8cllWIROxdiDMQhpwuWcSzcgFX1oL9qVbdDoRwSkPbaum6jnL0YUTULc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaMJG3cGsPXw0ZsB8yOQqHgyVOD/HvejqiBPv1xnFPDvQgmUf
	ZtG+xG2t3JYKgfToX1jcV3tQPgWbrDiO+1q4moD1sJ1jAg0zJA1j1CPi
X-Gm-Gg: ASbGncs/wD7wU6jjyZe0k/zxFioRmSFmIh1piY249qxCBFoJO5PiF76ZP9TVA7ong40
	KYRQfbUj1ASJvxT9WOiG+xKRBZ6vURxg/BVcrAo3bOoEZPutMHQtYtuuIs0MCrSzRsVilb5x/xt
	eXFTsVkqbolh30/y9KGZwwpvGvND8TwXIZRYvdZO1CAcTZYpVsVYB4P5TcXMCjPD7RiwRqpvRk4
	drR6JzaD0PAHr8AOpAzVik/+UslNG3kD4oxzuX3eqEzD7LHOOMYVlfWSv/4tufywMlQdyrkEySV
	TXMT/9V5jXKWgP1lAI0RSDq6BWBzZA3MNMLfZDekdizhxCXwpxjVB8OtxDaqChDm+15MizeXIc4
	B/OO7axHctubW5o8Vcp8biWAvf5VTByiDXAsflgUFI6oeZ1tUWcf5YacUpa8fhrdlFcCDgrP077
	eQaqythzOykdkS
X-Google-Smtp-Source: AGHT+IF05o6So4ZzLzR4++1urqrBHzEM10If/mZEe/mvCz5HnKnXUFhx0Yvvtsc2+Pd9ilWbyJSVrg==
X-Received: by 2002:a05:6a20:1611:b0:334:7aae:c43b with SMTP id adf61e73a8af0-334a853985emr25489520637.20.1761133489450;
        Wed, 22 Oct 2025 04:44:49 -0700 (PDT)
Received: from archlinux ([36.255.84.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm2525521a91.2.2025.10.22.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:44:49 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: xinliang.liu@linaro.org,
	tiantao6@hisilicon.com,
	kong.kongxinwei@hisilicon.com,
	sumit.semwal@linaro.org,
	yongqin.liu@linaro.org,
	jstultz@google.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] drm/hisilicon: kirin: Convert to drmm_mode_config_init() and drop manual cleanup
Date: Wed, 22 Oct 2025 17:14:38 +0530
Message-ID: <20251022114438.1096382-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

switch mode_config initialization to drmm_mode_config_init() so that the
lifetime is tied to drm_device. Remove explicit drm_mode_config_cleanup()
from error and cleanup path since cleanup is now managed by DRM.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 1e1c87be1204..47f682097615 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -160,7 +160,10 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	int ret;
 
 	/* dev->mode_config initialization */
-	drm_mode_config_init(dev);
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+	
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = driver_data->config_max_width;
@@ -170,8 +173,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	/* display controller init */
 	ret = kirin_drm_private_init(dev, driver_data);
 	if (ret)
-		goto err_mode_config_cleanup;
-
+		return ret;
 	/* bind and init sub drivers */
 	ret = component_bind_all(dev->dev, dev);
 	if (ret) {
@@ -198,8 +200,6 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	component_unbind_all(dev->dev, dev);
 err_private_cleanup:
 	kirin_drm_private_cleanup(dev);
-err_mode_config_cleanup:
-	drm_mode_config_cleanup(dev);
 	return ret;
 }
 
@@ -208,7 +208,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	drm_kms_helper_poll_fini(dev);
 	drm_atomic_helper_shutdown(dev);
 	kirin_drm_private_cleanup(dev);
-	drm_mode_config_cleanup(dev);
 
 	return 0;
 }
-- 
2.51.1.dirty


