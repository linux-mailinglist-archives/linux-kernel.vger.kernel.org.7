Return-Path: <linux-kernel+bounces-827447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE106B91C83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D34319041FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7F28152A;
	Mon, 22 Sep 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+1jOHYW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3C22D4DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552232; cv=none; b=pYPNUd72muPbhJjjH1ra6REvhMrjURuC+hO2G3BHTXOK3ualG1D0mwuzmaxWOl0ScElviStgtIRdBlAvX/G8BNCot9jKzPtAXEBZC97jHzEK9tI8Etq/gbLxlNtOI1u8vFoyT6NwEKc+mQ+PoZkABdUiWlNWHIS9k8EKzgwfXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552232; c=relaxed/simple;
	bh=9C4S0HqsiaXsxwEqJKTbtVPEuS8zFCQq76H/ap9HQgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5Pg755Hjc80GM9w7601umJq+eaUZ7pvPjB1vpEtqBPSC90uduMIoxZbggg/Rbyy6nc4MEnQQ9f3WpCDqRAnxmvLTeN4CTs7rV7McLObjOomcrLP/UYjQP7dPkYGiqOXXiu6Xr0Xje5BQlIdxx5YfjvjHLp4A3qxynxLygMGNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+1jOHYW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so1854705e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552229; x=1759157029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XeqFLg3di5BWF4+ZwuO795a3+ZuhvFgttiR6R4NPvc=;
        b=K+1jOHYWe24DHweBQX68QwAgiu9+ul5ni6jYieygNAJHuRl8avTEvttNIMhyUZB7lD
         MfdThjc0I45i1DHBMlFXTIxhOUc+x8G9y0zT+9rdgayds4ZYtmlEzfik0cU1+uDDtwka
         y32pBQRwWwF+G+1opBI5U6dE0cDwJpwLeZKe0vSK3KwqExPNLLqbBJKFT8hdpR2RKVJ9
         z3V7A+HfMWJqWVVziz/jGN82XOHNg0pP3xbkumwsgCU6Q3cBXfbRjyFr1aNh9OHJMren
         /u4wOfnLR+3qyLm/xSrTycdnaYjyiV2mxbugZvq5u0m4TaL/0DfXfu951aMshEJIhVWh
         Hn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552229; x=1759157029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XeqFLg3di5BWF4+ZwuO795a3+ZuhvFgttiR6R4NPvc=;
        b=smOSgR9XzEonKhWMBR0uwxvZNrabypXC+8uuF/L+jB+qS5E0kS3MD/L+27h2Gbab0J
         NUyFeF78LKOH/giWioug6wfcOyPBKvSxkHzo+b9tlmGf5SphBM2KczFr4fW4j50F7Pkk
         NZrnu0InN3RUfQ3VP082UWIq8KfFB75M6UtsAQar7n8S78bEG21PF0vCKXTpgFSMElFs
         KvREARJp06uPps5toygzDmXb0JO76S28NsHvXilOWX22lALd6lFnkX6nyYBIt1SSChjH
         u3KJbncq9MKASmvVbE1IP+6R9kMmsiyt44cQyRVctrvIbSXaqx/j2HxG6XXvvUMJ7E+Q
         wX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVsRyZCRFP8vqnQFrW8smRP7VD8eUNxZSRQOEHHftk/oNsmCfYC2vNeOGVQJ9EUS/MdYDsXGR2pbeeEtAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRWaufe3eZaBwUm0/XOflj67aS2/l7Qbde7CtFL3P4R5XJ0pg
	2en0AxnprfUSwVmRcnUD6AyrJgETJU4RSoFagc1FALSV2OiwRySuE5x7Hztft/IH
X-Gm-Gg: ASbGncuC3CQEYW8CvaulTf5wu3oYg7WPVf9JKS4mcjcJgMo1LMMDUXYS7MpO/C3D6BJ
	bF7QTTJeL6DeVFyirbqPHSN4xckUZPc75HcRtsX0iNUmVQIAJwMNj+kU4AqPK7uytIsoeL6RQN/
	oWp3lw/4+g8fc2jZj4wDOcnZBJcYcxLAjDBaIetjlsWK9sHRbsskrWf/TArX7iUGXf/3ho3njb1
	KPCm9mzuwHzFTTQeNX/1shOvEZLcrWLalOZO+aK1YJFjWEnl/t6+iTWHA9kMXklcJiES565ZcGw
	hB+UR3dU3CmxIjODLJn+Lt5OO0tJJPWWFYBqF9pAy8TxutPDLL9SIKU11v2HLLMAyclJxfKhqOB
	Yzqcgo4BBHPOdIqlpA6bP3IoSIung8xaEfLpmDkLJUzLJ9g7pFWm7jhCwpk1CfF5QzxcnL0PA8m
	RllXwqcEWMmni3wCTg
X-Google-Smtp-Source: AGHT+IHzYtEpfKcEprfpGuIP1MO4GWVytyEbGxSxTMCwGQRrh8Hl2fondVW+aeo1G/kVRwlHSYdpkg==
X-Received: by 2002:a05:6512:6819:b0:57b:a1d3:10be with SMTP id 2adb3069b0e04-57ba1d313f0mr2266689e87.8.1758552228118;
        Mon, 22 Sep 2025 07:43:48 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44b29sm3348282e87.24.2025.09.22.07.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:43:47 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] vgem: fix error return in vgem_init()
Date: Mon, 22 Sep 2025 17:43:41 +0300
Message-ID: <20250922144344.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

Return value of function dma_coerce_mask_and_coherent(), 
called at vgem_drv.c:143, is not checked, 
but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index c5e3e5457737..dc132dd44b9e 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -140,8 +140,10 @@ static int __init vgem_init(void)
 		goto out_unregister;
 	}
 
-	dma_coerce_mask_and_coherent(&pdev->dev,
+	ret = dma_coerce_mask_and_coherent(&pdev->dev,
 				     DMA_BIT_MASK(64));
+	if (ret)
+		goto out_devres;
 
 	vgem_device = devm_drm_dev_alloc(&pdev->dev, &vgem_driver,
 					 struct vgem_device, drm);
-- 
2.43.0


