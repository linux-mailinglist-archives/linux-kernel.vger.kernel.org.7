Return-Path: <linux-kernel+bounces-859719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2BBEE673
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5055518946F8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4CF2EA47C;
	Sun, 19 Oct 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcX7YUcg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E52EAB6A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883182; cv=none; b=Wa8DWxG5MeCPew9FRzm+KgtS9dsfkvPLLJT4OMQRIW7igieSqA1VF4ZdKD4S/wjGXqdnIOPe0X/tYkDXs4dc9cRtNXaYUqMqhQGIGn+CY/J5TViC2BuJsJR6yIXZFpb3nlopSda5NwMimqh8cjEZhCnQEwtzJ7YiyufQPzDAFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883182; c=relaxed/simple;
	bh=OZvVTykIlBRbaETtgtNoTHwKA/K3IweojPWLke2286k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afvL2oPrmq4P6s4ChnZC5Ph6eOeVcV9NzOWN0OkN6PHvcwvsC+yOkjnMgLN2oDEN9OoaJrXlDa61xEzV5Swg1Gr5clf3QT7fBVF05K56SNU5k2ZO7uPLcKu0UlOLj9b7RcE8eDzlNeAODolqPi9ixD8Zt7jLcmywycfCYcj32eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcX7YUcg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5dfff01511so94985366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760883179; x=1761487979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLOKqWlJM+Qls3gDoxvAM4+OyQdsVVtIrTMnLe6+7Bg=;
        b=AcX7YUcgQKcN39VuQ44MW1z+n6n5TKL5PGDe6uGiUQ30jwBS6PnFkX2X1HiSF+fhx2
         fYQsL20mmKFi5tTXXHyJonKoSCwybgH/UmQwbHIbYZSzhSr/OFoN8/1aPjloS40N0Lnd
         V8/IJuZzPPrP7FRW90DZizCJdSCBwKpEGltQE9ElxfUiNdzua+M5d4Q5JSI1ToJS6ltk
         hM2TCe+r61H3bOHK7yFsi4CF2dhzxv56rIsl19ytqrtR/Z42XjBPoHCwL65KB/Lv3Cpz
         gIe1SSacnzTcBU/5jErLKSFWdR5ruaZ7gUaoCriWDT7pTTulS5zwYNLpe1LTYgiYcjkH
         5aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760883179; x=1761487979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLOKqWlJM+Qls3gDoxvAM4+OyQdsVVtIrTMnLe6+7Bg=;
        b=efvhj7B+hV+boaZJjVaXDKYEoGGMOP1CVdz5rwGZoOiM39T9gQGzGtJ0TxrTAw5zlz
         5V2dg2tc10laakGDRcb4+1f7Z1UJ/I/2g8HaUkXzUue4oxEUR4k+am+P/9S0yvZbfd6P
         40wJtCsox95fulWdYyPr+AQTLcw+/FWrewRH3Fcpt72/vPWrmcugKKgKhbqmv69pfqky
         BMMwf4JiGq/N96sPLByMB+UDpitaZu8vbV+3aBPsM8ZABgnoyw5b+CkKvBqDUs/p+PLX
         mqJ27XlNd4V7gD7iIg6T0FW2H2qaaeZ22ijmndYwCKSeuVJP/Xe7tVNsogtFzT/S/dMC
         60Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV5KLT1WS+a1QnKYF4DQSMEJflag6SPpHZYfrxuqHOZSbbeGt0ubvv8GuNPF+D7sEl8ni8oqntQZY/ysn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Tg2S7qoEa2hgtQSj108myg8kqgks6KWqBCIIB85gobmI474M
	zGOLei70ArbXYa/sVF+eFm+xRbDD7d+F3iojmkVREw+LxBnn+ek/kAty
X-Gm-Gg: ASbGncsPNsiDBeuF0F0nsLdk2i/y/8nBqIUZCjjGWYoAMmCO6THJsxbHa+MwDwZzr7i
	CS3y3ecDndOY+9j313U//9cHYjl3t+ZnTGpIipFY4tyULtnMmH+e8i+qHzIfC2B0SwlJqUxL8g/
	AQhP3SPAEwmPjK3bT0aqO/oeJOTuPnRlwFfeLRnFi/ulmA5tIsjpEM3JHw0cDu36H8BKYwCXA5N
	Wj3pUyPbv6JSdjgmQ8HRfs1LSiXmmn+D10FIRH0byqL8HoAEWOpwsiN9ziAmCMcDIrC+tQ04zDb
	yW0+gAjvUWEQmrehV1k9ouug0BT5rfZIgwU4aDSsb/zi6zlnczNbulfXc59Slic24joQNNgcStX
	DjWWsxjl2E/jzIGm3jSbW0IRqoUvllYmk14q6G9mcLHGrhq5OCtW8VofGh/zyWbbO5F3vzup6AR
	nyGRsc
X-Google-Smtp-Source: AGHT+IF6kFqxZjmdvkiQmumLp5yXtfBfsGWcBoAvxoX6/vIZKFSk3vlT0KQXPw3Y30vQ7ooRKt1BnA==
X-Received: by 2002:a05:6402:2681:b0:634:52c3:20f5 with SMTP id 4fb4d7f45d1cf-63c1f5738aamr5377085a12.0.1760883178967;
        Sun, 19 Oct 2025 07:12:58 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm4212111a12.41.2025.10.19.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 07:12:58 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: lanzano.alex@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
Date: Sun, 19 Oct 2025 16:12:28 +0100
Message-ID: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc() with kmalloc_array() to correctly
handle array allocations and benefit from built-in overflow checking[1].

[1]:https://docs.kernel.org/process/deprecated.html

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 4824f863fdba..290132c24ff9 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb, const struct iosys_map *
 	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
 		  epd->factored_stage_time);
 
-	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
+	buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out_exit;
-- 
2.51.1.dirty


