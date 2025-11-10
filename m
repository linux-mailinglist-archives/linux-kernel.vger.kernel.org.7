Return-Path: <linux-kernel+bounces-893506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F390C4799B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D4C3B00A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EE279DB7;
	Mon, 10 Nov 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="XPBJ//qL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF4D260578
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788789; cv=none; b=t92HKfSSZ8EyJQzgDBTwKxZMuao+CP5xmgaD2pF9DXRhVKjLWxPczOOBNLfyvm9KiYCEomLsdGJxzIvyWewvr5LppPZL9g2m3ktgpZ2USxubho++5uSaiOl+eFXQ/i2pmOV+qx2t9gUa/nf+z/qAsCrPXas/ZWhpVTlKLdGkKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788789; c=relaxed/simple;
	bh=WX0BeKRqqoqX5Vz6JdrGMG9EsGgjvEElvI9dByZWdD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCIlFxcmwlqeTNdjW/polruEOPz6+v9wF5Q5eij4bWag5hEewMTSEA+qV3IPsIP54FBJOsspXNgyTLn+Y1y4rIXhwNnx2kGuOg1mETqmW8T5q9rbXkRGRB8poK1qQCyNOs1gBW6Y35L3l1dZMFNPbLw+zLkSIYfeT2ODn5Kn8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=XPBJ//qL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so5784807a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762788786; x=1763393586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhhZbSaUsVQtnfyfSsZMoa+Z0ZmaAqoEvexpVHXnJtU=;
        b=XPBJ//qLWIAuCdZW+XAErkgpONyXftJUvo9C1b6jN2PO3gyRJK5JAki/oaEFh0FFRp
         khjXEMDIScp78MzditPLZL1zAU5Etuq2zxzqmLhC/Casv4UqF044OHUinqHDOofcvXpI
         obm1AaRNtiYnt75GGfGV+HUDG/4gSki+HBzG2ATzWQV4P73vbwL+yuyYihlnMH/Vo9+H
         kwzUZwGfyG9jxC5U+6Miog8s/b6RAbSeR5DWELXmDjxQkEFn9qEfBju6vuCZi1TLmd/L
         i055CdSQlbp1AwpglCdnt8JVhOeFPqI82iQMV0OMHNLvc9ezdfK/mVTLAlAMBTuxckt6
         9gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788786; x=1763393586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MhhZbSaUsVQtnfyfSsZMoa+Z0ZmaAqoEvexpVHXnJtU=;
        b=LYvOJGMtpUk/xZK88OfF2ZI16wg1sCXP+hat3gGshSr4+Y89G7N1OM5MWsT+XDPfbc
         2Cu6+UxdjAiQqlH+EiXdNvk9MG9x2D+YzuJy4l/95yH91yP8sxnY32hHP+yvK8ZFtMNo
         aSFShDm397Ew6pbKrL0VgirxOKC5s9oQs4z6KDMEmQ4O4KPYbu4ZXG748G0yY1lowV8F
         k0+XAGxwl1x3P+bOCUMlDli38mnuMfOT7WV7520M8TdR1TRqUnPQsG2D6Jae4EkJtK4Y
         YiyyeO52wwZbPUH7Toy/BljkdcIH8KYfRlcTK4tUEgOZiwd1Npk9ucmuRYB+6SP7Z4zL
         ezgw==
X-Forwarded-Encrypted: i=1; AJvYcCVbmS03uPRoslxH09RBN/bfxtQ3TOOPOnudxiOcSJXsihFB18VkIG+wBa/qioQL6+NPzYgQPRb7AbppU54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BwabM1+u0coXpNHMijr7zeromzipTuZe1hXbktKxio8su23T
	IwyZFWanh6eeywZqbWgswoPqAZGqhC3msNSRz1aI+kI4B9r+8SwmwJ+lTuvDSBAyhYQ=
X-Gm-Gg: ASbGnctXWGwmJC27XUk/S0WThZX+zB16vFHo2Mdqk9aGiAkuEY6/v4QeIs2SCt1eV+l
	PrIs9C9u1tU7f9j14jAfKqRgN5t5ywp/t1Fo0p/VIMVPNsb1GJKtVfQUwZmNoWny8f1EDSnhRSp
	oU2XCMEN7YnDY5QwM9syjVu9zbqb3BLN+fet8cRrq25/87lHZ6i3dOGpr8j/TBPbaWMkR5c2kNZ
	lkLy2pGfKvPjru5RYkCTQhysgmd9yRNl1HYciKS9gu6d1b+jm4Ko+i60Et9uoaF9Bn+AqKU2kvO
	2NKKK8O37FGBrZpWVkIf3kmMv+gNH0mZeZw/4cU+vvsTuLbEQVRrr0b4rDhj6jvdCGN5qQxHCUk
	iTsmig95GqpSLDvYGFV+4AIMWH83TUKqoE1a1ZNErOiE664gUBgaHg7onqIeqJL8KQPSRrwW7y+
	/84bims6vLT0G2/tyCSNoHGNV0QVALuerDM61Bt3H00Ej20FBvE/GAhgmDRTP0
X-Google-Smtp-Source: AGHT+IGuCDl8/NKwayI0umUFRt4zezOzmyPdXdzg64sqFdiOt0b+BRNMtdKq/wRK1BA8tF9mTTYKDA==
X-Received: by 2002:a17:907:7fa6:b0:b70:c6ee:894b with SMTP id a640c23a62f3a-b72e055ffe0mr832947066b.51.1762788786091;
        Mon, 10 Nov 2025 07:33:06 -0800 (PST)
Received: from [192.168.1.42] (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1115978466b.31.2025.11.10.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:33:05 -0800 (PST)
From: Mary Guillemard <mary@mary.zone>
Date: Mon, 10 Nov 2025 16:33:00 +0100
Subject: [PATCH v6 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1
 to report new features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nouveau-compv6-v6-5-83b05475f57c@mary.zone>
References: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
In-Reply-To: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mary Guillemard <mary@mary.zone>
X-Mailer: b4 0.14.3

From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

The HW can only do compression on large and huge pages, and enabling it on
4K pages leads to a MMU fault. Compression also needs kernel support for
handling the compressed kinds and managing the compression tags.

This increments the nouveau version number which allows NVK to enable it
only when the kernel actually supports both features and avoid breaking
the system if a newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mary Guillemard <mary@mary.zone>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 84a275b06295..0e409414f44d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -10,7 +10,7 @@
 
 #define DRIVER_MAJOR		1
 #define DRIVER_MINOR		4
-#define DRIVER_PATCHLEVEL	0
+#define DRIVER_PATCHLEVEL	1
 
 /*
  * 1.1.1:
@@ -35,6 +35,8 @@
  *        programs that get directly linked with NVKM.
  * 1.3.1:
  *      - implemented limited ABI16/NVIF interop
+ * 1.4.1:
+ *      - add variable page sizes and compression for Turing+
  */
 
 #include <linux/notifier.h>

-- 
2.51.1


