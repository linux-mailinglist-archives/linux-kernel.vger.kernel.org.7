Return-Path: <linux-kernel+bounces-814501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAAB554D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F4FAA1C82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DADD31CA53;
	Fri, 12 Sep 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8FOe4iT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0A2ED87A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695364; cv=none; b=iigXDkE6W4WIgo7+WVbsKhquWO0Me2/eqT0HCOUL9WVcwax3bWcCo2DDxmuFbQprKcDyZM7tIXYiBNcvZrNbQFY/H6Jf98UhwBODnV3ziWDuwoUJqtcJJ1UvJJTvOwsOiHM8M1E9yNeAb/D3Y6tWd+hSy6AaL2mJKGImSp0pPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695364; c=relaxed/simple;
	bh=y7Ft1pzhK4KYTHSAmSw6Bso+6cplQ6jkqO9FbU1IdHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uElKSIYpXtwVzhTSOvOsSnxadu/7e5tTrA4vCfd7B71zINpbpXI2gTQrrg8rpEIef0VZVzSrxVseC9ZlG9MvPd3HdCwNfszPZdpPsY56gJxrOrZXw2FbdNYcAvuTlUitSQHlMNuDgvwJRzuAVnxYInf/6Ahy9DiEQE+H3B2YM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8FOe4iT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dfe95bbb7so20160935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695361; x=1758300161; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWqbHcu30xqhsc7+J01h1Frd6Q/2FaMV7jjWv5Z2IxY=;
        b=N8FOe4iTth7B+a+sTOKSUidxUyeplE95stix/3Q2yCHzpDzM03wYJZRtmRLrkLaZbU
         smfV09KqS3TkoL/D4lOwSsCounOzW/KkrWsXJ6M3lggDTg1mCeyb6X+V4lxzGvC6AsIu
         Xd+LzHb0PK5YnwNc6EfWTVAaSQn0xS+5DtSxUqoy2lkgigsOS4JX1uy9upNzXXh5wujP
         AYIMZFMZ4sZCVbWnWd3hCpznrwwdKGXTjtujLOXxlq5EBNBvMMklUKzaJ47KeQgHx+nk
         Rnm1jW9bvvU2Bu3PWOWfOsI8XwyM6LdfIZIiUtJr8tG1V7lapOQiEJ1yIUU3u4GUS7Y5
         kaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695361; x=1758300161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWqbHcu30xqhsc7+J01h1Frd6Q/2FaMV7jjWv5Z2IxY=;
        b=m7sRra6zi3a+itAXwNbmxnfAYlcx//zsiQIj8bHhqJyb4YVql/DTAKb6UTE/wGYYdF
         TCL/N2Mr9ZoS71F4gP/AAuiNk4dpCmlnIfLFeaOw8WYmgye73edmjYGWQP28me2i/CvM
         paCvEGRKtukvDWlMcfhfYuAw3OZPFvURz2kCrgS6kqs6UAruj6y7/2BPdL3r5w9eJtGn
         N/frVCL617jUDPgOBVuSIIao89lusBT1KfCzOlTEmwhO/ljpm5zYw+Z0ws2YjUy2uU8g
         +jYMpQ8H4aGV7KsFptt+F7u2z3s+h8Wdj1uLzfigf4lt12Br2ROeWV6dQR+H34wR8z+/
         83Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXd3xaJp1y7FDVHqiNr9GmcX4ZRLiCFdADqPIWQyo51R66hc3cKdzUxFV1HgxkcJrjYYnJkOjC1c0GrgeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypO1W9Bei4uT2iem3N6SZhN1AxedtElK3Kv0WBbPCvxxhmlI1
	kpS7++1yHDtbRcWW0GMOaYG0zleEFKFw0yQ4vdu24f4/inkjLTic/Pht
X-Gm-Gg: ASbGncvXeG+3JdJPeYA/k8g/quMsPbfqYKx6wLCfiumb4Rq94CdklAbFwae+U3vcf/1
	EQwS0vl+6ptwCu9A/69aSLBo5ej8o/XqXFibH1oKEnUH7rumoh1u/jvzPZFg9qiGMsH6eIkWmkb
	9K4dSaFY/NGww++Vc+PH/xXeQSoXJjL0gR0EyinuMpmtHlfryiIzqnc47guT4FrV1UaS96wa8PK
	bGVzBy5dl0PZ3z1mQnUMgkIDWWshfxcXWep1gCmvAY7ow0LKX7jS/geIuQNtqBv+OlA/3CI/JoE
	zTXNTAHb3TdODPaWQVf6D0FP9Y0mqRMm3ub8QQ9Za5vCaRmxjGFqydOBbrd1VmOQj2d98fOx01x
	/IJX5PEbTuILjrgIrG6EpAlnFws5RlONMM1c6pmA76O0G0g4yE4RRtYKguDZfFv2P2PjDd397z4
	I=
X-Google-Smtp-Source: AGHT+IH2WqFFYwwZKcq2dDys6lYV3Y9NNnL0D9d/ETn6ueyPNEao8tuz1jm9o8gPdjUwlS1YqeaFbA==
X-Received: by 2002:a05:600c:2282:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45f211ca99amr27964535e9.3.1757695361061;
        Fri, 12 Sep 2025 09:42:41 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:40 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH 0/5] drm/solomon: Code improvements and DRM helper adoption
Date: Fri, 12 Sep 2025 18:42:08 +0200
Message-Id: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBNxGgC/x3MQQqAIBBA0avErBPUNLKrRIvKsWaRhQMhhHdPW
 r7F/y8wJkKGsXkh4UNMV6xQbQPbscQdBflq0FJb6ZQWdN7pelAwe9XJLFZj18GFYHrXQa3uhIH
 yf5zmUj6aX2o9YQAAAA==
X-Change-ID: 20250912-improve-ssd130x-b45b89ff4693
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

This patch series improves the Solomon SSD130x DRM driver by adopting
existing DRM helpers, improving code clarity, and following kernel
coding standards.

* Patch #1 moves DRM GEM framebuffer CPU access calls to make critical
  sections more visible and maintainable.
* Patch #2 replaces WARN_ON with drm_WARN_ON_ONCE to prevent log spam.
* Patch #3 adopts drm_crtc_helper_mode_valid_fixed() for mode
  validation.
* Patch #4 adopts drm_connector_helper_get_modes_fixed() for mode
  management.
* Patch #5 enforces one assignment per line per kernel coding style.

These improvements reduce code duplication by leveraging existing DRM
infrastructure and enhance code readability without changing
functionality.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Iker Pedrosa (5):
      drm/solomon: Move calls to drm_gem_fb_end_cpu*()
      drm/solomon: Use drm_WARN_ON_ONCE instead of WARN_ON
      drm/solomon: Simplify mode_valid() using DRM helper
      drm/solomon: Simplify get_modes() using DRM helper
      drm/solomon: Enforce one assignment per line

 drivers/gpu/drm/solomon/ssd130x.c | 77 +++++++++++++++------------------------
 1 file changed, 29 insertions(+), 48 deletions(-)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250912-improve-ssd130x-b45b89ff4693

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


