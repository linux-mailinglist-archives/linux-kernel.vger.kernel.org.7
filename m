Return-Path: <linux-kernel+bounces-739087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA00B0C19C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D12189221B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A85294A0B;
	Mon, 21 Jul 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1f5vlR0"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7D28C862;
	Mon, 21 Jul 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094661; cv=none; b=KEwfEQ4K/85zR5c1gfoucOdo/kk9Lj7iXiCaCj6wLSV6B89fgmoLndRCKP4naZgkW8qKu3sR4QVFIaAvpv32xp1FPy627bPii09l2KYbzpXrzRJRQsvwsaqRhy0NRVp40kIu4M/ZqZm969xUGeTGHPL264BkCEshTEdfeLUFLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094661; c=relaxed/simple;
	bh=XXw5Ljs40nuD+6Xw/IEzZjAPPPvss4V5WiaBhIEjKmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioR9tPR9dqK3q5ig7YRsqFe0mr3MYVNJAvh3G9B1VDg5KMimgHkmLIcs8ku6ToVFP2deOBqQWK8SKZ4gSb/5jjn1W4i6UXih5nSjKV5voOPwVHmcrGC4UPo4BQvLSeO5WezDw5xlakZrqCJQla9ZcuGk2XdyhXiUfS64LypWjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1f5vlR0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55a25635385so4844111e87.3;
        Mon, 21 Jul 2025 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094656; x=1753699456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g94RElh8n5FdWhINQBgf3TM1P9IZtqRvM+lGnJwdOEI=;
        b=M1f5vlR0xVKB6BHHkJ3yMUM7VcmJZTJf90/2l5j6tBXyP7TA6A8AN78HD/PEHm8Bz6
         15O0zxzQxE/LSYWifuDxnrtgLmFM6KJWItGsFq/0D6d7aGlUNI0bvNFPfRpUUr7p6120
         GyHPwYPqecQywozUxbVWK4xDxajWFXGRs46FnjbZuBZmZ/6pgVYKY6UEEyhh87+W2amc
         xaWhdYtr9wQCy57HaQkc8IMiu/QgMsUaNAlS8h9xpJ5xMO6a7t2HPvK9u3hs3YWgADaT
         i5pMIUe7oL9W0Qd9FHIIyRUC3i2HS0Z6UnkPAulEh3sE1lEip2MhDMf5aR55vmVlCl9F
         ETlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094656; x=1753699456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g94RElh8n5FdWhINQBgf3TM1P9IZtqRvM+lGnJwdOEI=;
        b=vXlIQVzokk95FL4mxMVK67wUOsrVCWcL0av4F05CY4Yb4L2J8fel+NxpVZVHsU1wq4
         Z0gEPaMbCX0kTKVbOU8/gEslr9OfGN3ZE4/lUR1WznLV6QBzX0Lqb2sgK1/VV1BIi/G0
         eQHPMlpMO6Wo14wBCw964zqsg+A4NMKmuzEkDtn3aJW5N0uaFNFSYKdyhXbuyHjpIeNa
         x//MDfeja5ueyL5ET+/pCze9MGogi+RFZ7s81mZFplJSnV8ziL2ne6kMzrAHgfMfhZjt
         NNUFEduvonVgfLxsol76RGIbXVT7FdqgljDniwfMVc3m3RNKbhHifZIiPNAZH/CB7gwy
         5Y1g==
X-Forwarded-Encrypted: i=1; AJvYcCUF94sjC0RryUYgfJHcGQELny43kR8PL1iTxu3HRRazDKNjcW3ckXUWhqqmamkhRS7PqgiWDf8PVzeId/W0@vger.kernel.org, AJvYcCWsjdZagu2CpSUDUa52CV0Hr2B2yZgF9+a+dvuwcWITrkE3RyQBcFrye8MDO8Ap/Qhq4y35mm8yjRDg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxk8iXJDVeYB+2zONNoQESR7B2zVRsac+U3t5ffB6i9iPuUIGk
	fIJfwJmhlp5Dy3M7AELiItoBMJQDPJTtq2tdhRHOOecGqRdsZV1BxUsgmYm+3eLA1uM=
X-Gm-Gg: ASbGncviRk5Ia0GioYRSOTrZcMAeFUjdh+H2VvTaYNBn93F0y4bhTDc+SY0oZ/UhyyX
	hFHvPuV3mPYcX2GRBj70Gcm+Ie2kayPPwMHLfigm2If8UhsDxKPNfheLeUhvNphWQzn2TjtKD2z
	wZmg7QW/9CHh71hfMdQ+b40IPnzjQFODueeVZcl0RDvocZlo0YF0wVegPBAyCpK892GM3R3SEbZ
	Nd78gHd94Efv+PBH2bH9WaOuGmZ/WnjZJn/GYyuy2Bg3BoxNg2h1RlCbpieR+Zog2+Iqe6wThCc
	laMTnd1T12jsEtBNXjQNGqOPMbj+t6pEnc5pGvWIRZoFiQ5Cut6p8kpfugHgfyLpF26Jc/9BkyJ
	DAvrzVs1nhbyrnRY0clkXNDdJ8YQaFcL19DntdQ3/K6qSqgCJuUFQTn2V0AhXplZj6uI=
X-Google-Smtp-Source: AGHT+IHkGSC0km51BD6ZF4Mf93uahDRHJELprcnQqkqQ/veK9u3GssP0LAfbM5e/0BcP+puuCr3y7g==
X-Received: by 2002:a05:6512:3d02:b0:553:510d:f470 with SMTP id 2adb3069b0e04-55a23300e4amr6363513e87.4.1753094656252;
        Mon, 21 Jul 2025 03:44:16 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:15 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:34 +0200
Subject: [PATCH v2 4/6] drm/st7571-i2c: add support for inverted pixel
 format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-4-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
In-Reply-To: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=XXw5Ljs40nuD+6Xw/IEzZjAPPPvss4V5WiaBhIEjKmM=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnoXeJ5E1rL0wCRLER895ZymN6j36cstqv2u
 RpuZEaFDjGJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z6AAKCRCIgE5vWV1S
 MonCEACA0O2iGW1ogh59ZdknKyjz24l/VRyP5T2CXUH073SIz9mlwGnd2KV5VvDbkID0c0CbRMQ
 Po+hscDGzVgk+p5ml1yzX1TcG6RF/EIL4pP3HLr4yLhu7KcEGLxgAoUYbp6U4p1ymmOgyXlj673
 ZZUHs0yVw/E49bfNnrg2tcTFC6frf0IyJN+ADrZVIsyvQDF00smM48V38BxPQFoRLZAGB0jcB3Y
 oH8kV9LfkbELthvvlYX4MUMvdowjQw4qBu0bNO1Ek8E64u1pruat8kO0HhF8B/8nHtHBW37B/dA
 /uiWpIuBDGn0EEr+NOMDWn71otV0+3SB+tDYZbnbmVbPFKgFOppjVh7su/N+drgcwKFr6W3S+VP
 km6xdnY47b1j5YgQgEqJQCKgYpFMYyZNHtf5Y8ViuN6PeEmUliPr865Ct9QuOv0FHKcaew3HP27
 hOja8noIRsN/ZxnqEXsFVyZvQclXU+Jr0X1utlzU/p4lwpHtMt5YQG73X3kgLp2QV/JYC4xLID9
 0OrGcPDIIwdtHgxKBICTELJzr7m9gpBJE3c01akRl2moohTKHwW6or0Ee4nA6MdVD8BdRtfsePq
 laA604TFpnPVepLMNc5gcCeHTPbobvF1Sk1sDkdBwuG+aqk0oLOXOLAMKlDeyAdWox5c971k27m
 QATuWptg+wz7ESw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Depending on which display that is connected to the controller, an
"1" means either a black or a white pixel.

The supported formats (R1/R2/XRGB8888) expects the pixels
to map against (4bit):
    00 => Black
    01 => Dark Gray
    10 => Light Gray
    11 => White

If this is not what the display map against, make it possible to invert
the pixels.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index dfdd0fa4ff24090c3cbe7ab162285be45464d6a6..9f2de057ce9d990fdd77e395a6c32ba1e2f36137 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -151,6 +151,7 @@ struct st7571_device {
 	bool ignore_nak;
 
 	bool grayscale;
+	bool inverted;
 	u32 height_mm;
 	u32 width_mm;
 	u32 startline;
@@ -792,6 +793,7 @@ static int st7567_parse_dt(struct st7571_device *st7567)
 
 	of_property_read_u32(np, "width-mm", &st7567->width_mm);
 	of_property_read_u32(np, "height-mm", &st7567->height_mm);
+	st7567->inverted = of_property_read_bool(np, "sitronix,inverted");
 
 	st7567->pformat = &st7571_monochrome;
 	st7567->bpp = 1;
@@ -819,6 +821,7 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 	of_property_read_u32(np, "width-mm", &st7571->width_mm);
 	of_property_read_u32(np, "height-mm", &st7571->height_mm);
 	st7571->grayscale = of_property_read_bool(np, "sitronix,grayscale");
+	st7571->inverted = of_property_read_bool(np, "sitronix,inverted");
 
 	if (st7571->grayscale) {
 		st7571->pformat = &st7571_grayscale;
@@ -873,7 +876,7 @@ static int st7567_lcd_init(struct st7571_device *st7567)
 		ST7571_SET_POWER(0x6),	/* Power Control, VC: ON, VR: ON, VF: OFF */
 		ST7571_SET_POWER(0x7),	/* Power Control, VC: ON, VR: ON, VF: ON */
 
-		ST7571_SET_REVERSE(0),
+		ST7571_SET_REVERSE(st7567->inverted ? 1 : 0),
 		ST7571_SET_ENTIRE_DISPLAY_ON(0),
 	};
 
@@ -917,7 +920,7 @@ static int st7571_lcd_init(struct st7571_device *st7571)
 		ST7571_SET_COLOR_MODE(st7571->pformat->mode),
 		ST7571_COMMAND_SET_NORMAL,
 
-		ST7571_SET_REVERSE(0),
+		ST7571_SET_REVERSE(st7571->inverted ? 1 : 0),
 		ST7571_SET_ENTIRE_DISPLAY_ON(0),
 	};
 

-- 
2.49.0


