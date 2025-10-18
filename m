Return-Path: <linux-kernel+bounces-859032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3CBEC850
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42FA427193
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0328314B;
	Sat, 18 Oct 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="p/E7XPWW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6527C84B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766308; cv=none; b=jcXsp6Z2ihwUDscwS+J/TxgO1zgYNDWyW+EPIND8QwI2e2nNUzQSIhnwDTA7VoZ6Ij85QtHbKeq3qsmPna1BFuhoeAWxvNh/0w82c0Sm3k4uTB5Wj+pdk88yp6NLP1eLWiPZhF1sLJKZn3J0W73GTahggAUunOiBJLTnFBuQq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766308; c=relaxed/simple;
	bh=KaZzZuA8TQDpbsoSLk8AxZHwe5KtcN19DuSyt3eabX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvMv4OPBpeC/ky7T0/Ao8Io2iJAqPQ1MlsZczggqiLvHyqn+3yfNUKUADPgQclbdeHzLJyXScPRg9pX8xyk2cf1urtdcRI5DhZEW+RrQp+k+PauZNJyGKPkLzDJtSdJXVREGd164Bb5YJ+KYZPc+cGttDdQ+Hyf52925UrZHOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=p/E7XPWW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so3585323b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1760766303; x=1761371103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmUPjTR3yMW64aVQGfGVjFZpeabfMfYHxfBKINbWsBI=;
        b=p/E7XPWW8BWttLaorYfJX+11hAP1KMnLrFDlulaVl50/+p6e8SS0lEnMmDC95247Zc
         N3/AW0A1BsQ9HwHb3kHQHiIdafbgGNG0KYLL2EKbgevtY7Z/XHA77yotV8e94awgINM+
         ITBykGkHj6TAiHcbA/ZMTR2rY6fet7oes/Yqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766303; x=1761371103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmUPjTR3yMW64aVQGfGVjFZpeabfMfYHxfBKINbWsBI=;
        b=w+mo6vh6OLMYZclfR6FCqhjlC6bD5kK3P3J1K4XqG+QVPHmDn3nxDOzlQEQEWkr2GS
         /KC0JmQQPPpJMJyuyfMlcN4q5Xw4SENzFV7FWtNuZG1blSmssPxbrXEhEI6D/V3JMPzd
         /b3Tp2949Z5O4IfKEmRKjFRsOqbHwFXDIJVGzJqeKZLPZBEZJPu0LS0qPB7bMpumy2tY
         IFXXifbm3hX/Bpb6CxGO4+NSJh/UQctSelhtHpMOt2BzkM3S2XdCGhbhHl0yBfbVtIq8
         B+6z57ULOiQdJjp1zAx+ZVhifnBXMExhsMObhM3ZXRkSif+a+VeQaKBrdTi5J5iFB32l
         91wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo2bz+l48YOvVAfcAWVP+CzAHo8rooviFTqABzIGkRoZv7lXrWYpYQsnNzbEFkpp7aOqVYnlhxcZauPcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PU0JaH56PrXoMobsaRTQ7qweXEVYuGH+7a6sAhTfp/FTrGOF
	GjGedapS4BPcger/KNxRosM5jMXkdddJbXJx5IgnIUJ5bbQVOfPPj9FUj7JllVK0QPs=
X-Gm-Gg: ASbGnctbc+g2TG7rJayKuvauuju5YpuXBVTLX7FJVJ8gtrPI/XznZNIM2zmv38SwT1e
	z2nI3cGjFZa7RlxyGtD5gVsjLgw/wYGgWEw0LACMNbrr5JH8z68bolxVowWzqf/GJ70j3S1g2xl
	Lp1F1EzLunKrnUHEyH42UDfbDAgMuoRoi9fVRUror40AYwpi7XoHTKE9SxaHlTmrVquguSRMYY/
	D2JPPdwC4myWDt5e50k+8sWm1WbStHMVRJQRMkHjFlUQs8iCbW1fBnftVddGVlpUt0Bm3836vMt
	45Ejiwd3j2KwkZFdvqg42kDVBuBaj60XfAY0OkEG9Z51DdroIMy9nqF32EOcuPGZRsI1E8uoHwu
	wFKNFDEKB8nENTkBQjOA/WQ2e9h75pjztD4Th/0J20H7Tn2P7EPxTryAOsoKa71LszR9B6KY1gJ
	x/11f/Mhy64T4Gx+FSjxZEaai/NwOTmH3EwICW6kYg
X-Google-Smtp-Source: AGHT+IE0n5z7f/IMMhO8RMH8A+89s4jb/Yrjx1i30f1bpPQKuZW8GFOMc0cHZQNBYLb0n3r/GPAvpw==
X-Received: by 2002:a05:6a21:3e15:b0:334:b57f:554a with SMTP id adf61e73a8af0-334b57f5562mr3664489637.25.1760766302707;
        Fri, 17 Oct 2025 22:45:02 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.222.3.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:45:02 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] drm/radeon: Do not kfree() devres managed rdev
Date: Sat, 18 Oct 2025 14:44:50 +0900
Message-ID: <20251018054451.259432-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the allocation of the drivers main structure was changed to
devm_drm_dev_alloc() rdev is managed by devres and we shouldn't be calling
kfree() on it.

This fixes things exploding if the driver probe fails and devres cleans up
the rdev after we already free'd it.

Fixes: a9ed2f052c5c ("drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 645e33bf7947..ba1446acd703 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -84,7 +84,6 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	rdev->agp = NULL;
 
 done_free:
-	kfree(rdev);
 	dev->dev_private = NULL;
 }
 
-- 
2.51.0


