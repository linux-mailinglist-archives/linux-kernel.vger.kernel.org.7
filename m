Return-Path: <linux-kernel+bounces-751625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA843B16B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1CE582210
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF623B60E;
	Thu, 31 Jul 2025 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcR9/lmh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64909EC5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940207; cv=none; b=blKritBYovekQST2dCvUz6g8XDebQvsQwxQ3PDVcBTWMuOlt/M410UpXjSUdMVeANPfLCn88BXvxJcBp58HTX8Zg7MRcT60/bK8E5TY8/bVnfBthvgOQcZ6vkICcj1OD06miXS/UzSllrwXCGPJnBQXWS1gTXeGeu/0WJhoaG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940207; c=relaxed/simple;
	bh=fN6vEglHge3xvbaTQluadgqvkoyGk/XiSgAP4VVyzsI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eLcz8QTb6XdsCSyTh50vKcdAheWdt1m4y5GeP/yYekkOIFqZzfcTtkGyicT+NuhLtpeGtZksYDT0FvfRl8ilZDAyVve+6IaoRhYBW2lafj3rdy1hGxbNZ+l118/6AmILF8V31a1PQvL5OcU7ujWrz4jvsav6x+BWN/VmZNa5w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcR9/lmh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso960142f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940204; x=1754545004; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wjzRFN4mNt2Ahno1y82ZVBSbr4UOHx9K5gFPebp1jI=;
        b=dcR9/lmhJM9p7r8iAUkIuKewZHAV5kTuqzpLjKPYUOBJ4PzZV4/x0DxMlk8c38QTdK
         /N8uQZKmVs+if5hdKsWp/uOa+P9B/p+IdXc4Dig/ktSGWHlMmkFyUBvwQuO0cRhkEX9/
         Tp+EHqzHdXr+SllA47K81dH/6z5uXmI8eTZ9ZbJ2kT86ZaMorQ3Dj9slXanydQHgqq5S
         fxOGlYBRethh0lSM0LncgJC/GfSvJRyWgrJPhEIN5ofTejgIu9lncAomNktZhmpi6qpI
         2VxlLF+Rl8gF80OFYaiBV5ipv27wvIlsuTQopk4Lwbjum1TfALOes5PJU6dvvVYo4ID8
         6ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940204; x=1754545004;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wjzRFN4mNt2Ahno1y82ZVBSbr4UOHx9K5gFPebp1jI=;
        b=fuEeZFB8f5B95hS/4AWVOGMnUzJCDyW9MOLkhattrFtwj8lOzy1W+vL0XRCaZoK74Z
         u6Nop2UGHgQMo0DFVbrnsR9m4AYCde4VAH3XzjJDEaCZA0DPJMgRx2G4rciNNf2lVtmf
         iij6VClW6rqt/fYnNot4YsPdNNKCviyKYc4EqRjDAVgKtFiege00jZBzTgaAxIK7eIC0
         g6uqclmPgihPL6ruU6BNuWB23fKGPhNHuHslkTHaMg5AmvFSBkDizTtNN3OJE5wZLms7
         gaEbeLmBBmIu91eBlKZ4U32FbZJgbQtTM20nIH+kvb4VKXdFYDYNItiErSmjnSwLggN/
         ACJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6S3fzQbdgF1mte0zrPzxMESYpbmXvMOFuwiWv96BJzmfV4eXeLQfPb6O5Uj+jFKxyjF6jYBchH+DXa8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrLkhp0R42LA17ei5nFRUYvupdlsu7Kj+XKhXYMLaQhqxS36R
	DP80JClXMZv3zC4+As8NsMg0cic3baysyH1MuJH44s517n4oGJjdjfju
X-Gm-Gg: ASbGncudFJpsbHj1qVNQsNoWRJoHTIODfsDWqabNhAlFJu3iW08m16hMSe1nYC51thF
	nJlRNSWxuBxFxuLhN2vdr/Uhz17wxdZmSKqvDixJRhOScaf8FmUhbMsS+CXgJRTYU0iEptO0idy
	eU2f/cGeqLjiV7ID4/lBbvyVIna3VaFINws+sG+6keid4KKApP/B2kdlfMI/RFb3zEyAx6evsVq
	LSgU6eIuLnBqlc7oGH+PTTEdOhl4v5TmgJ2NW89xzuMeeXq7+1v3pNxizoN2g/oX3wmsVJQGAEC
	nFYv24cuA9ER+Cczox3Uf3UoWnI6gxGk1yq+0io/U3OXD0snCR2HxLyobrb1mGm2S4IS4odYQz6
	KI3pnm4gWM/ZI2A1/7R7cz9dUbnq6PYdDV8aZTqFRWiv9IATQWsfRitP3ecj8
X-Google-Smtp-Source: AGHT+IHZzT2X7dcyUlKwCrocUxoHjRp8HDiN+RWizQinctQQjrI6tN9tQPybT24AfCWIZ5kXsrV/ig==
X-Received: by 2002:a05:6000:2dc2:b0:3b7:908e:e4ac with SMTP id ffacd0b85a97d-3b79d42097dmr494133f8f.2.1753940203459;
        Wed, 30 Jul 2025 22:36:43 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:41 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH RFC 0/6] amdgpu: Avoid powering on the dGPU on
 vkEnumeratePhysicalDevices()
Date: Thu, 31 Jul 2025 07:36:33 +0200
Message-Id: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOEAi2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2MD3SQT3ZT8vBLd8sTsVN281IoSXUPztGQDI0NDE2NjQyWgvoKi1LT
 MCrCZ0UpBbs5KsbW1ABBVMXpoAAAA
X-Change-ID: 20250730-b4-dont-wake-next-17fc02114331
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

This is an attempt at fixing amd#2295 [1]:

  On an AMD Rembrandt laptop with 680M iGPU and 6700S dGPU, calling
  vkEnumeratePhysicalDevices() wakes up the sleeping dGPU, even if all
  the application wants is to find and use the iGPU. This causes a delay
  of about 2 seconds on this system, followed by a few seconds of
  increased power draw until runtime PM turns the dGPU back off again.

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/2295

Patch 1 avoids power up on some ioctls that don't need it.
Patch 2 avoids power up on open() by postponing fpriv initialization to
the first ioctl() that wakes up the dGPU.
Patches 3 and 4 add AMDGPU_INFO to the list of non-waking ioctls,
returning cached values for some queries.
Patch 5 works around an explicit register access from libdrm.
Patch 6 shorts out the syncobj ioctls while fpriv is still
uninitialized. This avoids waking up the dGPU during Vulkan syncobj
feature detection.

regards
Philipp

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Alex Deucher (1):
      drm/amdgpu: don't wake up the GPU for some IOCTLs

Philipp Zabel (5):
      drm/amdgpu: don't wake up the GPU when opening the device
      drm/amdgpu: don't query xclk in AMDGPU_INFO_DEV_INFO
      drm/amdgpu: don't wake up the GPU for some AMDGPU_INFO queries
      drm/amdgpu: don't wake up the GPU for mmGB_ADDR_CONFIG register read
      drm/amdgpu: don't wake up the GPU for syncobj feature detection

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  80 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 137 +++++++++++++++++++++-------
 6 files changed, 194 insertions(+), 36 deletions(-)
---
base-commit: 6ac55eab4fc41e0ea80f9064945e4340f13d8b5c
change-id: 20250730-b4-dont-wake-next-17fc02114331

Best regards,
--  
Philipp Zabel <philipp.zabel@gmail.com>


