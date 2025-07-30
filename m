Return-Path: <linux-kernel+bounces-750225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E2B158D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DF43BE332
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F61F1505;
	Wed, 30 Jul 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="XdNq2uva"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC051199BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856278; cv=none; b=i9mX/XKLUGC49/2hnLPFmE+CTsb60FjN/BWNOf1/tiofs8p6/NwTbjg0K4qH5CawR/NwPY1lYcuEdhfNvEe5WwyXOdBN54+vgFJCJCe4jyuuxaPcPEBs8HE+SXoUQ8Gj3lnz3RmFjelfYa4zkp5H818nsmh8f6qak/ppfBBgx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856278; c=relaxed/simple;
	bh=XxMNf+s+au9pzXX5Y2tRQ2TxicTyQrqJ3gGr+HCCcZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqHbvqD+yXE8dif45CgQclP7X8qeUkJgUo9KEG7wcff/VPGlM/s6KAMJ127vTvy8pPiD32iLRD1+A4hBbCWgtk7+sYA/ewNQz1RpNLJ4Rkbiy8KNFyW8+8f9JEr/OGuqzAXQ7OCR67WjG3oj9sPlkAQDFe/2tbx0ESnpYcPs6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=XdNq2uva; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso5714499a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753856276; x=1754461076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98acdjAVPrJS4Gqdzmu/lk9sXTEBspyDUAMw8EWioqY=;
        b=XdNq2uvaIx23ZOo5+SV3Kkkj6ggfJoOFVH4m2lLzdvI86Xluy1I9WLmLSzUTqUrsiO
         Fq4v5BRgtCrXPEk8kPI70KIAYqq6VYYHnUjYp+cEstONkrfY1B7PfOvZ3zns8r7osekf
         hLk/0fc0FwgKjISoF7P64Qs/RNdVxwYkqJ0BjlNHAk1tl+iK+g6JTL7myoP0a1UcZkbl
         vYeOBMbAFY4NFss7zbMjOQR8npgo+4K6QqKiQuzIv05eG93Gt1M5PFD73vp0wXYbuZvZ
         NcsJx9tPf7vdsQLgKtQ6o6tTK+6oVuwYzHQ6bwuLCHPYbsh6Xk/5BQi1rZ+Jfaua9m9I
         WTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856276; x=1754461076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98acdjAVPrJS4Gqdzmu/lk9sXTEBspyDUAMw8EWioqY=;
        b=nLXIq0WpWwJp7fgOed3LY+gkFQsjzPAf7fFL0uEAjp0l7b6Tl9PHsq9Nfnrg9MSTjP
         IdgZ/rQM2+kgkl3z/HXZX7LTtKjpPyQgGCcRCRh04WCyrkT/r7QM5xuOs1uetFt2jFRH
         VBF1WpGVfktem9LYVc08lb2CKMXuG/2SuVm85LpBnKDsi0IbQ2KyIyzXNc3wQkCauncu
         Rdh9F7k2PuZJqPqxlQKtSg5AS3i/LQvv6U6adCpgIDbO8Ol7PsTdzTad2DAfJDf//8Cr
         2X54pkgusa9B3D9NjHVMAyFiz5FutY3SOoAulcIiuzb2RTWomgOWMJhOL3+B1wey2Gu3
         y5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNUaNClx7ZwBAY+J3u0M/HKARj0+72UVQX7We9/iK8RYFK7ABYyDsNvnh1b8gxK5UXD+2ynUz2zzLM1gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHX6kiYtlueYayTr0UWPyL0NsTw0dWwiwA/8BOfUB5Ul3uP9r
	dFzeQF/To2EyTJbFIp7yXx0AreKJmRnVm7EoqedafWex+IkLFbMVcF8n954ctLc9OgDdgOHbmw2
	luX/t/sJljA==
X-Gm-Gg: ASbGnctQ7S1c9Kpp1/JrFD8gCGFu25qb6QD1uHXkCjcy/zFxNmk1IneLUIGECFy+w39
	r9GWmhuThXKTfRZtGqI7+00IjVMMzRju0Ongc2/f2gIy8KdSWW4ehLg+KrXC8+hzh7MYnCiahrH
	U0BHoL4QyqKfKlsg8pLycSWKtGsg1JI/lgr+q5cYJgkcJYK4oAQh5crfEqSkElAwQOXfX8PR56X
	7D1qKcSuplrHRQv71/PU9BL7v1MOme8jfCLD5XsUb+EivpZvHVyrpu/3kRlmYebrM6U6/lloMl6
	wwY4UZuws9Zjmg2YK9Pap8vDSXCmSTO5GZCfiGUyZE/U3I0Be3n7WneAocA+HVE+1G5RHFg4nw+
	FnO6YpUiqRjvaEKBXVZM19zzSqidTVm7/rfftVvymVyRfG2sEWl/ZNQb38Gfp
X-Google-Smtp-Source: AGHT+IF2plv3fMP0uvyMA0WmAMrYR0uHAsvmRyjAdt8jIJYVnquEq1k4jegvH5HMZncHbb6PvKV5aA==
X-Received: by 2002:a17:903:2a83:b0:240:7fb:cb0b with SMTP id d9443c01a7336-24096a688b9mr25697995ad.15.1753856275969;
        Tue, 29 Jul 2025 23:17:55 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm75017815ad.115.2025.07.29.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:17:55 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 1/3] drm/panel: novatek-nt35560: Fix invalid return value
Date: Wed, 30 Jul 2025 00:17:46 -0600
Message-ID: <20250730061748.1227643-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730061748.1227643-1-me@brighamcampbell.com>
References: <20250730061748.1227643-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in nt35560_set_brightness() which causes the function to
erroneously report an error. mipi_dsi_dcs_write() returns either a
negative value when an error occurred or a positive number of bytes
written when no error occurred. The buggy code reports an error under
either condition.

Fixes: 8152c2bfd780 ("drm/panel: Add driver for Sony ACX424AKP panel")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 98f0782c8411..17898a29efe8 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -161,7 +161,7 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 		par = 0x00;
 		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 					 &par, 1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
 			return ret;
 		}
-- 
2.50.1


