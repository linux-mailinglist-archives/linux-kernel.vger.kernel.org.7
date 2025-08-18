Return-Path: <linux-kernel+bounces-773475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59AB2A0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40AC2A7AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEABB2E22A2;
	Mon, 18 Aug 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Egfps0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD642E2293
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516965; cv=none; b=Lkq3zMdGe9frtNiFP3kBM5yrWDXoy0TU113AtB8dTAH1dr68YIdIRly4/h9d/APOFv/nfJF/c/M4C0KHv+dW5AxtqZnZMNygqW5iF0Rz+Gs/S+Q0FiUBg3dViVDpbxgN6rPc/rYDLYUqJUtLw+xRYErg0yNposlnukMP/KCbbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516965; c=relaxed/simple;
	bh=pJxE+OEQ5Wyzmel59Y0sr7fQRcSfIty8hGB+7BBVnAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJ82AujHQhTTA7qxGjuePeB2r68EDbAsFVrZzRoL6zWQS+g8qWLAd/J6CIlb1hNjJdNLfamlTEV/2OFZVl/qfNyRpA8vUQFiojDIBJkLbuxWQhCJyPHFMQCu+b+lqtz9svU0DfU0zkcT2qM5kaqhb7J2NKo4yEnlA2vPEqLCc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8Egfps0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so16446855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755516962; x=1756121762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDUdPZKNkg1iBDfC6ofC+qEV+2e3XCCr9Niar66w+L4=;
        b=M8Egfps0+l5Th1z0iltvhjUPGWWgmjpKtUnz0IEAzKbIqxnNdqPuYQgIjymvncgubD
         oEqHG3IxPl6CIUvVrba/5H49QhX/l2rWq0XeV7M12fWi7H/VtkKqSDkLMrTX7uQ/sU54
         4QNrc3LCU1VCmSj6j3vfyb8Uv6D1xu3wkuiYj62o35G1bjzrTmZ8O32KK5DFvbYU3vZe
         GmIk9wCT021prCMhirZ7Fpnb8f1AvqJqmUUZesH3YRyIKUoq4E9dsUpNtNB0vx6fxf3P
         8uDvvYwBIrTrBWwmfX/nGyTWYcjVQ5HxSPYsjiHSRorLyPgnKWycOyWLbuGzQFR5qYcz
         EA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516962; x=1756121762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDUdPZKNkg1iBDfC6ofC+qEV+2e3XCCr9Niar66w+L4=;
        b=FXF6JaXPrdZGEURSYI6eo624lYeN/v/ry9y2fYy5QFzj6QzJpM2NviGKs6RSY5XgcI
         lr+IPVUSDimSvlZo3S/oRdorHEReIvQs+hrsQF2y9DEfOL4TR9nT0SUudLuO/Nizmfl/
         heVPHFT78j7viUw4gqsXIUihA6dcQ3yYiYN+UJwQq0N0rJ6rkT88voXP5IkQvoWEEREJ
         sy9wyI6ntRxO/oWgx/vP/QwQoU/KGBMHi0UQSxBwisriyWf52DFABlTESSXGRHvO86+0
         lBgCJoa/FL5utSVQuSrwV4R+iWWIhZF5wYbL9oan7cqlyex7bkFEfRDinP8IGxQaZECP
         bQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsWgFXkwWMu8oS7pO4F1P0wiDn1jHhCE8nII8oQLo/2BIErlU+yFEW0j/tlPhTrLEK+DHmsfWJtEDdoeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbJoLrOY/Xp39qQSLhdmxEaA7tuVXAuLucTNeQSDZOHbunYT2
	1avNREIorCkRb2MzO3Vziby/kNY56B9iVuOcH1whPS1OasSGodWwFqnl
X-Gm-Gg: ASbGncsBAGWz8RsMFGFgDeft2hlGU9lqV/k0JThivkeFZ09ppRsSIfonDpbw8PMaLmK
	/M+hbMFpKclJZ0VgLjwPl2/watsFFtzSqk/aieaIdvfLTNnJWvdS4h2yDiqf2MCjXVRicG88QG8
	UZ9A9N74R+pV7p0OyhyDHfsUjEJYGjviUMnVyCQoB2mVe22TxT6FZdJr4QNsb6gP/sPrS5ozBdt
	64dQMjiwy5XLdKZ2jBIzylSU3isXE/tWQrUOn60CUmZoNpZHyXvPR3bp+gutsJwkbqFf6BytLUh
	30ywWd3tK+fdMOcdcXxRtNoFd54GShgpLt5c/QlPo7UGWjp6zZPIVIyhtH7VWr1oRo6kmhAtjv2
	bi3/zpe4VL905g+TrEB88MJsOjNzW3S1BFQWogNgP2Eifc0YCvYpwJQ==
X-Google-Smtp-Source: AGHT+IEvNQBZsuo8Hf7IiG7SsKJtDHqDwAW6SCT0x2vVEo9x1zPaztZ3dLK1klhGjAt39vstSNNDxw==
X-Received: by 2002:a05:600c:4f4c:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-45a27151246mr62315245e9.5.1755516961619;
        Mon, 18 Aug 2025 04:36:01 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm169135535e9.14.2025.08.18.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:36:00 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Leander Kieweg <kieweg.leander@gmail.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tiny/bochs: Convert dev_err() to drm_err()
Date: Mon, 18 Aug 2025 13:35:29 +0200
Message-ID: <20250818113530.187440-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DRM subsystem has a set of preferred, prefixed logging functions
(drm_info, drm_warn, drm_err) which improve debuggability by including
the driver and function name in the log output.

As part of the ongoing effort to modernize logging calls,
convert a dev_err() call in the bochs hardware initialization
function to its drm_err() equivalent.

This work was suggested by the DRM TODO list.

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8d3b7c4fa6a4..d2d5e9f1269f 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -252,7 +252,7 @@ static int bochs_hw_init(struct bochs_device *bochs)
 		}
 		bochs->ioports = 1;
 	} else {
-		dev_err(dev->dev, "I/O ports are not supported\n");
+		drm_err(dev, "I/O ports are not supported\n");
 		return -EIO;
 	}
 
-- 
2.43.0


