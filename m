Return-Path: <linux-kernel+bounces-748211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EDB13DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F7817E1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AEC26F477;
	Mon, 28 Jul 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hchrV853"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF31F1517
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715398; cv=none; b=CDyMXZcip/4Y7czhV2THzWKtzIOueIaR2NAFVzU8VKc5pSQJhsumujm7iV6XqwmUW/PPcffT9NORo3A47yFcSB3COy8zAOE+4vIN/i+wIiOVx5rYFIi5kmA0FYXTejfXff3KaKKYjShFwQfiy+9XMemqsS7bZavpxFZsLvS3EwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715398; c=relaxed/simple;
	bh=vp0JalAeDbKwHRS57FGfWOJJUJkO6js6WSY8SYgYyP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VefuEG6MDkEjVRhZZzaVdHD/gN1zuavzMheR5jqnQhIx1kLxiM5LsCbjjtCwRMKfeb1qrF7uo4gtIwXJdJbW1um+xFf9GAk1knvNBkjoHSBvdMN6E3XSPXlS+xRxn01UY3bMWjWVq38KVjn9RFozL9am2MabvY5mdHFaYoRZMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hchrV853; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ce252c3acso18914541fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753715395; x=1754320195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJszQOndFuu7X55L0f8onIu967meyAt9CHoug67HFK0=;
        b=hchrV853i00111muzJGkhb/0a7yvQKYPKuWIkB9aIeR34NlMW3R9xn5pwSCdn0e6M/
         DIS3yBGb3dvfe0IXkng3AwE8ETTIZ757ilwfWxdGeLoJcntnhFKQPV6Uy5o/kyjerYTk
         M39ziYGk1FDjVnA3R0V/QdKfvfTXqjBlefJ07ppxMVuSR0CQvTp+rOG8kdhiFH+jDwh3
         rbP5u0c7HuR6F+Z1nLxrpGroxSehViIXS+wRVeHoP6V9qXYEOzcSKLa5EAXwVPzWHRlK
         TdwJt9k5ZxDEL7G0leVbbcjx2u2z0bwA3HrmfX3IsnbhzlwdN9m11MQAK15JIlM37W5J
         9APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715395; x=1754320195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJszQOndFuu7X55L0f8onIu967meyAt9CHoug67HFK0=;
        b=u9Pcmil5kZ8jny51s0K8vuf1iqzkpQaG7P8D17Om057oMEmddOXAgIyckGsUaRQs63
         FelaIyBVVRpFoYdIfKg7DPlScY1PZXOA6Tt/vf65awCNivGWQx9DNUWzl4JoiDwt6Tb+
         hcCOGHVkgftYwumRUzcCrQdLQ3Vkir35cVSrm9ImN/kXmr+E3NYW0N0bm1NEVZIN5x2O
         EB0oDQavoB+i+AYazBWK3GYcOT2tmMVysP887PhJLFVm8KFrmcYhRT/k5SsHfMeswx9N
         iMfGhQEsZltQKQIjy1xLtA4pnvzslarsWOJdTNeKKCMuedUr2SMxVTA8/zeUP6DpOoI2
         hAhA==
X-Forwarded-Encrypted: i=1; AJvYcCUS6w2swFUvnYA2iZufP38jltffMYk6xTwXtcDBDsyb0uWS7gjr/jV2AQ6xJeWWKKFaqqkiRbmO/YcVuMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzHZfsIDqprlNgtxA/s1dGDXgHMRzMYsZ9QY23mBJFfrwd/Kd
	km14GLl1XBIThwpwgf/JpkUIQKoW7G9tIzPTNzgutFaBJGAdnfaYeQTDkVYIrUzqNKC9DQ==
X-Gm-Gg: ASbGnct8/K+m80s59SoDSiUTuqqFAaCaQXnetTG9j/hTkwyBCnCQdSTDjzUKkbzfmkd
	UD+2hGoq2F6dlrVnGhcxNd5J49udSzBH5HRDdnt3/9x20UfX42mELSuV1xmLixmkXAr/kR1FEa/
	bBuNitGbHW86aObpJvzbn7TkJpYm8Ws7op5MkB6oC9CgNEn6ttDdyi4zBEZqyjxWmFliymMla1C
	ZhY4puQoyX8TEV5jiJeiAXmXbRcjenE4pcHCV5K0HaBfNbjpzbqj+dCEl8LREoerjZJBIfwi37y
	gqxJhK29J4vWKyZBl4rZC+x7iJBhhNFyUNO3eIs/16o41tprc/DvyB0UZyzciAFomFJdD1mxKJy
	/zrJKGtGr+5lIPo/iZvpifIZxhpFSZIJtXe70ME+MG6iLtbAKgnRKFDeYtaZmtKpxMsxrCPzsCU
	xy+2jv2cuDGICx92ZUnEZA9+FRK50NGol8Y8+2NBchSw==
X-Google-Smtp-Source: AGHT+IHTAGHnztb4WZkeLEMfCy8Eg7GH1Kw0R/ccfG9KJKsktGejCZ0Izyuxe5tETPnBfOl5dqnv1Q==
X-Received: by 2002:a05:6000:310a:b0:3b5:e2c9:fa05 with SMTP id ffacd0b85a97d-3b7765edebdmr8146672f8f.18.1753714907818;
        Mon, 28 Jul 2025 08:01:47 -0700 (PDT)
Received: from hsukr3.localdomain (dynamic-2a02-3100-4704-2d00-fd39-2814-e22d-3359.310.pool.telefonica.de. [2a02:3100:4704:2d00:fd39:2814:e22d:3359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f31fsm153973475e9.10.2025.07.28.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:01:46 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: sean@poorly.run,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Victor Skvortsov <Victor.Skvortsov@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jack Xiao <Jack.Xiao@amd.com>,
	Tony Yi <Tony.Yi@amd.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Shaoyun Liu <shaoyun.liu@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [RFC PATCH] Replace dev_err with drm_err
Date: Mon, 28 Jul 2025 16:58:28 +0200
Message-ID: <20250728145841.378172-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch converts  dev_err logging to drm_err, as recommended
in gpu/todo.rst for drivers supporting multiple DRM instances.

Before proceeding further, I'd like to confirm if this is the
right direction for amdgpu.

The below change builds successfully. I am happy to send this
as a formal patch if it's acceptable.

Thank you.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 13f0cdeb59c4..effffba39b5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -460,7 +460,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
-		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
+		drm_err(adev_to_drm(adev), "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
 		return -EINVAL;
 	}
 
@@ -471,7 +471,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
 		if (checksum != checkval) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
 				checksum, checkval);
 			return -EINVAL;
-- 
2.43.0


