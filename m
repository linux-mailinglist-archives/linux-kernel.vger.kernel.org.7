Return-Path: <linux-kernel+bounces-864208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E16BFA2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626B73B388C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA202DF12C;
	Wed, 22 Oct 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVon8IKY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BF17C21C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113474; cv=none; b=UZkRVRZ02TfKxwgX9tTzlhwSovvBDzpd8dI0FUuJiIHF+HP4Ac6WEfs+C2hZAG35M1Zd43aE3RMQ/0W3d9h6uV7veFcN3VcGqAfKukydorjPQH1u/F1vxV1VkcFTslLH8ARKeGYiI9Z0qMBQzy2Y8v4qm/EntqyDssnRpwVhz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113474; c=relaxed/simple;
	bh=ovaGz5LWbEQy3l3kBh4Ix3pVci1hLdFEix4Tpa7cZKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r11c7M+3ISx1JXh1Xn5hKJxljgRl00Pi4EMqV+wvdpFMLZKsgH+rCwCymgj7bpuSKGxDTppITtvqTToWNxjqzvIy0cAFThDZj12BNaKAXLn6Q8JpXG6BJobhQR5JOpeQ4cPQEG6LcwuymAXo9qybBGayEacEwjFy0hhmfKgYQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVon8IKY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ebf841ddso1840821e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761113471; x=1761718271; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0+BgDGfdaSQSOaQDhEvXyp9Ns3uPDwLDm/lWJtPZkY=;
        b=OVon8IKYk6QKQHo5JakCrWBBr6JgK/vsULFZV7IeBs83ypACZNTvhp7pM5XndCbjEf
         kjXQxGC2N9cBBXnlv83uRrkcozZLXtocc0l2bzTozkbtVFve/v4fRvOzcd7T4t890DBh
         lNjiGEKW76aiARckoznzvEPCeLjafh0z4Hswgm+kUFQ4VVYIDeyua7jC6JlKFHLnvarU
         FE6oqEJlHrE4wS9kopvj6PxVZu0DDOFp2eKhqvOFUzvCf7aY7PG682ZvkWT19Ty2XLh4
         FQtwbsgY5pzrEdcByLCy3wqzUuGUoJSHzdmDi5Ns1PlsHkOEbsThPCtqeThZ5JlgbLpV
         mbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113471; x=1761718271;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0+BgDGfdaSQSOaQDhEvXyp9Ns3uPDwLDm/lWJtPZkY=;
        b=n6O119icxXZLVjv5h2Ffr4tvZn6LJtmIz6jFtpIoILd7gPmssF+IgAs9LZBm8/1YPq
         ufsrtAuLz++0+yQ9a9xZTWE7HkzaNxZTRSLxE7U2V2794/H2hDrgDi9FweoVu7+YvheM
         2uCL5758cBEZ44JeT5jOUpkNzJoJ+YEpcEflnR9/j03o4Xf/IwNdBUDLwcY1sEldKP7M
         sLuhBCtACXY+21ryqzmS+jiCQKE6qbFw0TctkN+AlO0xYRsHmsCdPGmVKlsYoHKMZa8Z
         Q29iGmmrY48ai8bRi4ONKX6saVBgQfL9eEP2pJ3nFcvUEGKrxwSZw+WqvatbiaeJUtuG
         0Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvauAyogY9HHdx41qqDVGf+OvpO/LVY7PFgMKD6VAmUpa1UaNeBIREULyd1VVmUzhtvnw8T6Gl34L8xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHc2AD9Mv9dUZAemJBPkksUL8JyPYFBJs+zlcJ5mlkL7loKGJ
	u4+S1ah5CkIO+kXEu3q4Jm2xELq5MxKzlWbnJIva4y++iMbVQWIAfrmU
X-Gm-Gg: ASbGncv2T/CO21moB8l4x0OPgFjW217bl4TdqLu8nrAP4i/rUapmzxIuE1MjBs2GxfX
	SQhBur7NBj0tooDLual4KMcNOBU9LHgE+9SiM7YDtCEOKDFGoEPqmJPVXUpjXP24EwZvLTghCXG
	Ms6OQMd3dRG80UjZE2/yUTcKK4HC1b+FRJPnk1ulVk2KZNbHjD38kaFVRdCRQpGWlronYsu1Nrg
	TR1WuuQK8n5OLHqNvtTQckXuUsm3K+p9uMoDFkgDJZZG0iRUf33KMq+N94+0hx6XHnDbNZFot3u
	yXv2Esb++3QCu4cupApS2tHcELVOVUfioi6RAnDPeL1MMdbf5RRnsLkETXh1bs2R+y0Ko0mq+69
	WEdqjVX8SJoKJQjMzbc2WGT5nB+u4yzGwoGH31GCTCj73+T8KXiEbMVUYAKF9B10hP8CK93eW9N
	dYG6uq4tbpk6QzXjHxsSpd2uyHibmkYzGiMAu1bKE39KOG+4wLWU+0R6M=
X-Google-Smtp-Source: AGHT+IGDud48MYPYUyRNhPw1PG4OdE3gQrYlaeAVeQROu+jTZopngjWe2bD/jmGlNJeOxKzMvjADxA==
X-Received: by 2002:a05:6512:31cf:b0:578:ed03:7b87 with SMTP id 2adb3069b0e04-591d858a844mr5437023e87.33.1761113470564;
        Tue, 21 Oct 2025 23:11:10 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f039d766sm208072e87.71.2025.10.21.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:11:08 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 22 Oct 2025 08:10:57 +0200
Subject: [PATCH] drm/sitronix/st7571-i2c: remove unneeded semicolon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-st7571-semicolon-v1-1-83d322618ff4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHB1+GgC/x3MQQqAIBBA0avErBNyyIyuEi3KphooDSciCO+et
 HyL/18QikwCXfFCpJuFg8/QZQFuG/1KiudswAqNrhCVXNZYrYQOdmEPXk3OYGvdTNjUkLMz0sL
 Pv+yHlD5Yyop3YgAAAA==
X-Change-ID: 20251022-st7571-semicolon-bc5287cde264
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ovaGz5LWbEQy3l3kBh4Ix3pVci1hLdFEix4Tpa7cZKs=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+HV1DRQGPHoeDhzBWKzqI6DZcw21t8+YKDd1E
 gqDGfE/y2aJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPh1dQAKCRCIgE5vWV1S
 MnP2D/sFFHeJI+kLW2rsUU0mpvB6p3CxqSWBjzBb6IuKkkuoOz9HdeMTvLTR0GTQo+5GejvRsg4
 TjusQEmXW7XqGmYFKFZGnMtMB3G8jd7ffVGao5dzID7Xgf5JBuAha9z/U1Pzd1g1vOzxl8BKhKC
 681JdoD2r0hbr7f+9Lc4EWbAtGjeRZoP5Okdux+PBDd/J7uBUO8MvDEYpiog+D3yl26wg/No/vp
 XV2GESWyiQQ+P0GvnNk6P2YRM36DMj0x6mOIW3bsQZNyCgMDBnii/yaq8tFKERl0t3qI47wdOoC
 RM+QVfU0hBD4O+1zszaiaLcX0x3FwIKNZIaHHHZCAoZQeGkJlHxJcnh6W9Ri/U7LJcrsGfupRtP
 MkWAmLQZnt78B8r5aMVNAHdY4fSrPbLgcXNgm4NK0s+iPJQzn2XRzOVgznY3YqMkk7XdRUDAOlr
 JOQGQm4KmwY38NJcFEdG0qswbx/MeZnQg1obn68GVLaahbNRxRXzP6cti+hLcUfjBs/KDuSYvOH
 AhSk1amtbju3e0giCJngh9QTuS6ScpYghvK1rEAO+ZvF6kwVVV+75KHsF2FBZpC1pjwNpEaAbC8
 oT0aE3oKrNsDUYZl3Jrdou76yvKbluiMYY6vjLtepF3oxD+qt2WPJKAdfccUapbNjAxyWZfnrHV
 /VNiVwtDxHEmE+w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Fix style issue reported by Kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510221125.Cg0sM4xJ-lkp@intel.com/
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 32b91d65b768b26caa7dcef42a00d36f236fbc32..4e73c8b415d677dab5b421666b56f4bb3697b982 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -322,7 +322,7 @@ static void st7571_prepare_buffer_grayscale(struct st7571_device *st7571,
 		size = (rect->x2 - rect->x1) * (rect->y2 - rect->y1) / 4;
 		memcpy(st7571->hwbuf, vmap->vaddr, size);
 		break;
-	};
+	}
 }
 
 static int st7571_fb_update_rect_monochrome(struct drm_framebuffer *fb, struct drm_rect *rect)

---
base-commit: c1a7cc00cd412505e070eb4e62bc0b0ca85243e0
change-id: 20251022-st7571-semicolon-bc5287cde264

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


