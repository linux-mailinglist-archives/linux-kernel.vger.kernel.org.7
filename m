Return-Path: <linux-kernel+bounces-766954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDADB24D16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6BD1757E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE632FE56F;
	Wed, 13 Aug 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcT6/WLj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477552E5B22;
	Wed, 13 Aug 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098006; cv=none; b=CoVcS2eT/0RQzbTKwR9JagxKPXrHAmVXe7icqHQhcsYvsSqvHZkf2WpEjkSlzSJ2bTJW8JLmikaEBdqlspI7qQIBMFN+gwO7TSO8l/vORUuwLDsjNlMvw0thgtUk6mffwRxW7WRkoRoolAHARM8ymRldKYRtBAdrVFXWgLg+cNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098006; c=relaxed/simple;
	bh=lyUeY1elz8Oa38aDMGQbLdoxHSZ+fC7TBWAPkNRLobg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qNN6U6UeBBQ8X+03uFrwbkfzPm2U8k8uIC5vwi3T2C+rvB4T9JNhi6a1PRyNEoPZ4CPFKXO9fl+P43k28212bTxUkufdwd5f1ePW4BvLefS/hvO97MWe7aI0bKsGCs+jSP3bOYkekLqkl2OFAam7tPovFBzunxhqzVRCbgZSsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcT6/WLj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so58460865e9.3;
        Wed, 13 Aug 2025 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098003; x=1755702803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXaG+nrbYg1bcSitJNL4gXYIE8J8lX8ImkkRSgEhuy0=;
        b=YcT6/WLjEAkJBGvEVCNZhRyerQLpg2xSoCRpMAJEa5v8nAbLymQyx5Dh6h9yLUfM9E
         8OQsHy+s2YZiz4FJFCGOriNi6T6/dFd4l9hmO3kx4KHIp2Jfrs2WBmH6w1+ahwH+rUjM
         OFfyKusGrCh04OhoMtY39r/eId+JDmCba2JXT4VixfeQ7mgE+MrVbIJlOhVFHlaTi3um
         +uOHR6LH+YMDfe577q/aeYnAOVBsCW7y9FoSkOluBbI8DR5/SJC7eOGlw5pO0KzbeU81
         DeOVLWrbv0jAq88Ahdq5Jv8ZuhX2tbAD7qPLvXv9br8LnNzpRSlwrCAbGTnbFX7KEe/O
         QbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098003; x=1755702803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXaG+nrbYg1bcSitJNL4gXYIE8J8lX8ImkkRSgEhuy0=;
        b=h1WkJXIB5hs1Z+9unGOMkWcu0o4yHquRnWZ0AE1rdyBy9Sr6Yli7cIp/riIDVcBCwf
         2s6yDoK+jJEcOo0RWopgsgPQwNHpG/MIDk5eXAgY0KnaUNLquACi5u8d2Pr4Bc1GSds2
         yvlI0hqg0O2vJGHAYjGYDD071uK/bciWyIOi4qdizXfDU/8MKK0DJVwqRdLR5DAh2NH+
         t0oQjffwEsqpSTsAdSEsbB0R2FLxzwxFhLuHIGoUf4dWJ2538iuDx+JzRMG/WAmJspsg
         zrw5BxvXe1IwJAlO4f7lrUnGWttcj4um0u5ffFQTgovxC8iFAJR1wOWY0Zn2Jtid27os
         6xDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8p9dxGr5gj61lwaiR2+OoEKgpohApv3GMxT8Vk/D+t0aQLKujW8VA1+Zm8qJvKW+N7wFFC4CogtGUSRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmevdjso1JmpScH1wkmj8YUFA1TKOtoEA2B1wNcCbnluT61Dlu
	o58C0/JgALJxhQ31pFEcTN8h/cPLr3TuqtzJvReupFc8n7l0UyicWzMb
X-Gm-Gg: ASbGncsRbb92sI2eG9ShK5m/601zdAj8aT8sAGggnB1F2ejQKCFepr16MYNBZxp42Dq
	U3VK2CNJsLSCmmXQxX7R9oJ00vxca6zrEbPFoUM2UbvdvwbCobyGgzxG9Lgz4o6OK9iovax5jT+
	i9mck1P30CszeAuyFmnIjY1f4Gw9xza7gOT9A9o1cICz4CcgSN2hQam9MjtUomUS6ZDC1prQ25m
	rLZn55+59s2uRlp9FZej+8QpMetcvBVpad4nGU4NnJMUtzWNXLP8Zkzx4ySKae43AQKODwiiLqY
	pXrC1G3XymL+5TMwk6UNitzEaMGJLp287mAOR78xpFQRDOot4UCTWghhl3LpgBjEXr2Sn1iDm03
	f9ZphhDfAv7V3zdf3g2+0
X-Google-Smtp-Source: AGHT+IEsPZFlG97saXVcQXUrRmXTyLn9RugilGXKIzGMNgbzqlIDl+eWbvR+L/17fz8ERclDq+F/OA==
X-Received: by 2002:a5d:5c84:0:b0:3b9:167f:7f2e with SMTP id ffacd0b85a97d-3b917d1d57fmr2898871f8f.11.1755098003262;
        Wed, 13 Aug 2025 08:13:23 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abeb2sm47954103f8f.11.2025.08.13.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:13:23 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/dp: remove redundant check on ret and return statement
Date: Wed, 13 Aug 2025 16:12:43 +0100
Message-ID: <20250813151243.2055798-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a redundant check on return and a return statement after
a previous return statement from the call to drm_dp_dpcd_write_byte.
These statements are redundant and can be removed. Remove the
statements and the now unused variable ret.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 1ecc3df7e316..ccae67abb8ff 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3594,7 +3594,6 @@ EXPORT_SYMBOL(drm_dp_pcon_frl_configure_1);
 int drm_dp_pcon_frl_configure_2(struct drm_dp_aux *aux, int max_frl_mask,
 				u8 frl_type)
 {
-	int ret;
 	u8 buf = max_frl_mask;
 
 	if (frl_type == DP_PCON_FRL_LINK_TRAIN_EXTENDED)
@@ -3603,10 +3602,6 @@ int drm_dp_pcon_frl_configure_2(struct drm_dp_aux *aux, int max_frl_mask,
 		buf &= ~DP_PCON_FRL_LINK_TRAIN_EXTENDED;
 
 	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_2, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_configure_2);
 
-- 
2.50.1


