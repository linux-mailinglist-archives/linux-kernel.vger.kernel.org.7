Return-Path: <linux-kernel+bounces-828810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13148B958AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A153E7A8F78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D314428032D;
	Tue, 23 Sep 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVTVWqqT"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB8182B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625250; cv=none; b=GLlqWJwyJSSz3qMy5xCEIh2jKUelzE9jnuyFIgbLy6gNojOUFas2rBKrPyxq6QsCLflh7nNpv0qIQ/xAsY9tIbVrvfyPIXkmjVA4muG+ARijZbmuyopE2Q+24fme23NMWfXCgihQ2ZY+whAVPkwGUqCvX3LncTZ90ApTDnX4qbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625250; c=relaxed/simple;
	bh=VOhlJp2hDQQqdHrgA3nU9HmR9/uEeMtfiVz263i2Fnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpqwDLgdDBBAeuNC6fM5o9DLFO5/LEhlyQobTPHzU2d678ASBT4naayPQyk3WFYYLvsoaXCJ2YCdQ/TnoUJIC5/9BdvZgIreaVQH9sgbWRgks510PGnH9QRPR9KlR37voETWZBWUMmrTXpXIOMDNIGjUWtv3rQEoYbbtnxHilNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVTVWqqT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so4936224a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625248; x=1759230048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+d0uNuVR4m+R+a1nNiakMPI+senyqQHCOr95TAfxeQ=;
        b=dVTVWqqTsTQ7peGmUgW+ywof7uw2PFgv4+lTUUltJicpss7Joep9f2zTNwyOcow1w5
         +67ngcYH51zRhBceVqLMiMDge0C5m0ZlOydN25Mfv6/0Ls8BUxCd59sgVZ4TzATThPbd
         SNryY8AGulhJhMqV6jfL7jNvZhgfWgHQE0YZioOKljLg+a/t7At8MMEtmekDLFcpc8PN
         GPziEj0WFocE5F81Un6HXTiVP4INotgz6AqWVPQax5+g4Ln9ZlLLRzrN47lemlHae4Zt
         UopZyb2b0tSL1wQIeavU/LH+k04JTbaLaEOG166tXq89H7VJ4Ev5GX8AHhu42BdMCJPd
         S1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625248; x=1759230048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+d0uNuVR4m+R+a1nNiakMPI+senyqQHCOr95TAfxeQ=;
        b=P3EITEqedc4cuHL74lhdzahILMupqRWUd9YQ83rkmhiXy3/mhXZ4PEgKALtk/ZwtCd
         9Ke40gBWhM+MRitQVMuuM50sgOOV8+uOre9JUB1t2T+AJ6slRQtrKvnbwTmwtJxZuawh
         OxxNg8pAIgCDYCyxHh8c50q99tn/rTNaoVEwry/ZgJZ1Hf5lS/yzhkBefjYIDByCjTWg
         5ZJz5MopV7GndLohhWeWHV6YgCz0kNZv1MLk1/c57SeRUiuLcEZwM9quv5lXU9wlSTBI
         uJ958/XUmwe1qjM0LXm0a544SKyMErDT5cTDFpaENnPqN2l/RdxfA5Fs5XBjTfCdGaKa
         6vmg==
X-Forwarded-Encrypted: i=1; AJvYcCXXDw+8HKT/2aFO4kp2bhyEZdgEr4nzv00trgOCnxlHOv1j6i3VVtFKVeNk74YHKfXR+5ZjO81JKb2Xh4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHsSNv32KTInuJFZl7QgxZnnCm/rZ39TmxiEZ047aiWGdbNng
	VMlmGC8YOVRhWLKm+YxqJnf4PLXDadCIlcRhJmXYhnpf4f3UI9n5FyZP
X-Gm-Gg: ASbGncuAqz8aRK8IMLdblamRcHvjSlhCjGCu2LYqYZoi9tnTvyQ8MxpBfBHFs9njQQz
	Zo92Tf845bUNKlfyo3w7LEckouFWVKpjhglXzuklbTy8cLYfdfTMOK3F7IucuTYDNtVvqry21yo
	DxB26jw7TLMbCXtTKN/P/Z4ynzIvtchmBHvxzFB4LcK6SBPHJdojW2DXjJXOagYE90DmnX6xic7
	UsvJih4R3EB+aCs1DM5wCdj/gA+GoO4W0GJOY8tvaBFYBZiImcSr6ZApYkColQwFfaHhhvrSwAz
	SqQy/C7uJqDWgYMaBgrgBMSJm7iPfaft9t/nbA9nmAEfH9HWfK0HWBhIUbctvlG4xNE83htNqHR
	a6xUS4gIPkmTgAZxhMbEwdlDURXGBTcuqkA3BRSqozcSsL7c=
X-Google-Smtp-Source: AGHT+IEYvec2VOJUIP0HzhEx0k08gqrbQ//jHK3lUuVH/vw6V0w+nLGE6iuJ0m4g0yvADc24CIGTDQ==
X-Received: by 2002:a17:902:e5d1:b0:274:9dae:6a6d with SMTP id d9443c01a7336-27cc5624d90mr26228805ad.34.1758625248034;
        Tue, 23 Sep 2025 04:00:48 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699363989fsm151910135ad.92.2025.09.23.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:00:46 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: lanzano.alex@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
Date: Tue, 23 Sep 2025 16:30:25 +0530
Message-ID: <20250923110025.1358920-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in drivers/gpu/drm/tiny/repaper.c
to make the intended allocation size clearer and avoid potential overflow
issues.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 5c3b51eb0a97..4d439a2d973a 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -535,7 +535,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb,
 	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
 		  epd->factored_stage_time);
 
-	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
+	buf = kmalloc_array(fb->width, fb->height / 8, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out_exit;
-- 
2.43.0


