Return-Path: <linux-kernel+bounces-899096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842DC56C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E1934EF15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7E2E091B;
	Thu, 13 Nov 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btfqXuq5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50E2D7384
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028400; cv=none; b=S4SkjKd6k+KWjGYSQLjkh9ucAp5cOrK+UpVAVaBBJr9ogGNSxCClSF5JGjPfk2AspD09NZGU9O79MdCZ3+a5STuiPaYGqaDJJUO8p9urYlvWewck0f4dfBZAHm3eztQB38OgbJ/DeyloOGFlCFaWs3fqau9jEPlucm+Ct41Tsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028400; c=relaxed/simple;
	bh=mx4u8g/c46IzZC7uYDpt4M6Nc+hnTM9tkbowXQYir0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcbHsv+QDhTkoqcZtSw2uQulqFjPL/w1SVyHiibTaXRhlT54PBAFvh98YxUUJp+tFzxXHz5BVkc724ESzTdSwoERwth8664yeMRVlYdAVuqMbzuDeFNDuUcAO+TngPpcfEvmbg3fVUubwBv3sAvVzUpbGMSiL1vIIvKdHRsDILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btfqXuq5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297d4ac44fbso13145045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763028399; x=1763633199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYSrKGa1rNdgtFI/Qoa2b1aIEVZpmii09qZSfHx++jc=;
        b=btfqXuq5YMa6E8Z3ni39e1g6Lj+0XDp9KdwNZAZX5sEh9WHEN59XlFk1zdlexIzXhF
         pT/4kuApELIcNu+0FkQe39X2t+XNdamrnyWlVOWHvT+0sKZG2Sdm9d8P4fs2UtefWODv
         0DrEO6XxQQ37y+FRVKV/xQl54XLOibKO2BXomIR41CXdHNJj1KWESQnUZ8EvLMqvSjhJ
         APfJeuNmQF72Bf8Lk1Mp9xc+deK5ZLbtZqx40OYlA6aEIo8XPn7SiXXKpqALm665D7gt
         8xNq2mpm47BltC02/2wtW0SJEZpEXXzLeMcKbRO5lW8UQnowrJSNfQ9JdB1sLWlsrFMN
         lQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028399; x=1763633199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYSrKGa1rNdgtFI/Qoa2b1aIEVZpmii09qZSfHx++jc=;
        b=ZBwAYTAMOqpUFL/2E4eMKD6dkOFNlMMB4sunDJ6c5pykbzStXV+yag9LL8xTIqW+R6
         6QbUULg3ckIk2A2r6xKg0JbF5LSNPTofUrw9/w1wlLBTWlp7SMTf1tziLIMCffgOh6Jm
         tfTo17wHw5OAqvAG520pRQJdFeYvwQ4yYLVLp7I9hUxEDJvrO3G0a+n1VG5phRloKf3q
         Gp9120LJhw1GrYseT5NqSHRCGoF3QBk0TBtlLVJDTQLoZRaLcS+IuWzUEyKfCAO878kJ
         SDzKZ69NAmycyIXYTq2wnbor7qSGNzfv9oPd37Ki34Aigh3qtFRicIjTWHYHY+ZL6t3H
         nM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNwMWbk8hrYS4ANZ0NuMD1vyTt4IzlQWcZj35aUmtwvf+5LpG6sLsD1CH6rJlkz0N9OfA86iOI0dP3ZGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6pQUxME0+1IA1Fjye3IhRtVcVcgr1gPXBYOoLS+j5ujUBirE
	z1mB/ID/xIPscihrJgNqKd/yT6iV2S1r3/GqFf/1ntnOAEuAjXusADpG
X-Gm-Gg: ASbGncumHPrW6cqL3DOvQS23ZBVJtavuQd3SaqYjEgxVJWmZvLjMWdZVXHnGD1RmLau
	XVIO0hWF8DZE80gb3Aljd7MMwOY4JQwg+5N7eBLGQO4UpYQQQOySVB+GCMcPy+gFxaHlETd4bav
	+bwn8ec2Px9j6XDpXNmfuhjbjthG23FlfPbpuCOJQ0nmjRNPL17uvn0EGHxDNv3wFQ4fW05rTiB
	GFwbwGVO0PfGufQCuO5KgUgpgnL11epWJn5u7RTGFG1rCf24Xvuvco/Va/RU1jW70WwdWdOBKLt
	h1Jo0M9nDmuyZ2rT+xpHvXNBNKOJKKFp1sBis4teLW6MWkU59FmBHCfUoMgeBGBjpxRn8dJR5I+
	P8/90qQY+gWa+xVbOl8GAjxRI57pDawEfCLomQs2NsUbZAMJmD79GynTlVa8w3e8PXdqYMdU7MG
	lvfI50kjIdWpZwf/k3m/x153FpldDsoiX9klGTjSE=
X-Google-Smtp-Source: AGHT+IEEyMa9j30aX/mgMTS2wPaz/NVQWJWp+CviAg7X8u1EOXR8+UYWej9l4oKIwkJIk81gGTVEPg==
X-Received: by 2002:a17:902:d590:b0:297:e1da:6fd6 with SMTP id d9443c01a7336-2985a4ce247mr33677335ad.8.1763028398582;
        Thu, 13 Nov 2025 02:06:38 -0800 (PST)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed23sm20110235ad.87.2025.11.13.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:06:38 -0800 (PST)
From: Abhishek Rajput <abhiraj21put@gmail.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	abhiraj21put@gmail.com
Subject: [PATCH] drm/komeda: Convert logging in komeda_event.c to drm_* with
Date: Thu, 13 Nov 2025 15:36:23 +0530
Message-ID: <20251113100623.162327-1-abhiraj21put@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the DRM_ERROR() call in
drivers/gpu/drm/arm/display/komeda/komeda_event.c with the corresponding
drm_err() helper that uses the existing drm_device parameter.

Using drm_err() allows the DRM core to prefix log messages with the
specific DRM device name and instance, which helps distinguish logs when
multiple display controllers are present.

This change aligns komeda_event.c with the DRM TODO item:
"Convert logging to drm_* functions with drm_device parameter".

Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
index 53f944e66dfc..78a4a78d1fab 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -148,7 +148,7 @@ void komeda_print_events(struct komeda_events *evts, struct drm_device *dev)
 		komeda_sprintf(&str, ", pipes[1]: ");
 		evt_str(&str, evts->pipes[1]);
 
-		DRM_ERROR("err detect: %s\n", msg);
+		drm_err(dev, "err detect: %s\n", msg);
 		if ((err_verbosity & KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT) &&
 		    (evts_mask & (KOMEDA_ERR_EVENTS | KOMEDA_WARN_EVENTS)))
 			drm_state_dump(dev, &p);
-- 
2.43.0


