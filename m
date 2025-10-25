Return-Path: <linux-kernel+bounces-870152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E694C0A0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 00:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30BF188D81E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBF2D5927;
	Sat, 25 Oct 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtGPljA5"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B82D4B5E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761432137; cv=none; b=G4bKvRdR5Z3rwD00e1HFzkbm0r5tDSpjQWBz4nEECXFqYAaOBMzc1Twipf4GBxw9Ysnd5n0AbKpD0FQz/skB3hWxi3bEZNIpf9ak43WYv8Zytbqy0cxcCtfLATkh5vqi8JX2VUEm9FJ2ZkWbuAZ4ZZ9qYSCJ1zI1S6TsFLh+p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761432137; c=relaxed/simple;
	bh=4TeSUUQyzmjI+AmEM5j9GI7xFhPjauS254ia4GjX/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBRfO3pkynqzXspBEFrQH/V+bdMWuP0d+ncwBraI/2CNtJrpHxGK1nqJrUf6S+PJLN736+NiRmlpB0RijyIuWJU+9PSYWD4OvcvlR7UQ+BX4ioRw4rPs/OjEizdZoLpXdKGfDqGxHNGC3bqUsS9akDnp8FJfpGtDJoEvocvgLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtGPljA5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427007b1fe5so2782679f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761432134; x=1762036934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=YtGPljA532L3+1QTNRK8ucyMfbMjuy1X4EvYe7fZ9cn/Sf/vdvXVFXJ3eVPRmRCf79
         wsD++hhvwDxz8P0UrlzVVZs+0eJSfSZAFPd7uskAKPrZZBlIPrfM63qU12Rc/lbgHQYz
         ccj4DqwGnTj7lMuUbUoe1lfRT+jYLyvl2NdBABK5h14/NEklRqPk2p8NYEbdvuseB6rd
         /4SCEemylkOzoyMOO+pQNcaxRrxq3DoZB1XSSpI+zn0XQGkPl9VSegx76bUCtwyrU1Yw
         Mo9xL+BNqgDkq3lIGGQrVw8b0yUOoxqo4MNFHnH1SQsaGuUaa/jWeTkpY+ivKSyp34jW
         hiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761432134; x=1762036934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=isUyezvwkEkN4gcdPCtqjSA2E22hqMdXkUw/pFdrRN1dEwfK6Gt65kJEwTgzO4Tfj0
         Cnn5ZwC+amFpDUgPgYMRlyw8u5fobIpH5ke/NKopluzoYKlc3DldYF2MtwPr44tyXfsY
         ao+42K4GnAJLkLpsXce55k9HTJNL5yFqoOZau9Sg0twGol9WiylZIyIjxFryedVHggAv
         sdLXmrlyUQAJz1Dd8rYsjlWE47eUxrwbntXDmKmb6iItHVpOaHJTpYpkJgphQ6urC8ti
         k4AuKV5/EOObQUsb+Le0xj/BlgdIqN8qKTqazIqhIM2BTjoOTrbRpb9+xHrG0nkM0buc
         RvdQ==
X-Gm-Message-State: AOJu0Yw310LEaV/6g+y6eAv5wBrKjyyOv7AwQjFAjRHsFM4BZWWk/tsh
	EfR/wwNWSVjamzaxKmb+VmLEGX2MvOsLEnf0IFMXPAXgTyTzSFkKSqg=
X-Gm-Gg: ASbGncuqIUdaqfiVbbM+bIPyKEWjaHrjvXH8Y/9Y7O+RutrJt9DbijdO6PNhwmvS50d
	23ip88RMFhtj6g/IAuAU+JctowwNgk5t0z59lz0uvuYNUgyspvNCx1tf1s+BFfKp6JwPRwAHxy5
	Zcz11IK//9BKzgq1wWBWbpmQJARZftXBx4Kvp+0OjgM5PJzIW08s1jlv79HFbzDkR5cAIJ0t24u
	/eDleXM6JwuOqbQLVbO8Hqo9H6IauLkmZSINRyY2jGwrBVp06i90wS7JWxkxaBKDy/HsDUJIVes
	OJNn6jOjWLdqpKYlfFCmH15kOC97QdTWaJ8DEewFIZuIFaLtT9Wc7oL5omPJQqxnru46KKD7a+v
	oYmrwIMq9OTU9ooDyBKM7GpDAo8qB6Ai4bazXwRgvQo76EdDKjwOi79Vtt0rrwEGRT+xtqC1T2f
	/oB7Bar/So1e5YnM3EehmR9ACCkbarRm2EgHHWRZ76B2N6tuuzpPM6Jcrlg1w42aVesYQqfxy7L
	/uorxI=
X-Google-Smtp-Source: AGHT+IH5qEmI200tfknZM3nb5ovcfV9MSsErH9Gyktcj7nN/CQ7b7jCUO5zA24B4gpxH66kEW1MyEA==
X-Received: by 2002:a05:6000:41d5:b0:427:666:f9d6 with SMTP id ffacd0b85a97d-4270666fa57mr22253037f8f.39.1761432133628;
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:bad8:a439:d5f7:21de])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cb55asm5742091f8f.17.2025.10.25.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	fuchsfl@gmail.com
Subject: [PATCH] fbdev/pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS
Date: Sun, 26 Oct 2025 00:38:50 +0200
Message-ID: <20251025223850.1056175-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.") removed
the define ONCHIP_NR_DMA_CHANNELS. So that the leftover reference needs
to be replaced by CONFIG_NR_ONCHIP_DMA_CHANNELS to compile successfully
with CONFIG_PVR2_DMA enabled.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: The fix has been compiled, and tested on real Dreamcast hardware,
with CONFIG_PVR2_DMA=y.

 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index cbdb1caf61bd..0b8d23c12b77 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -192,7 +192,7 @@ static unsigned long pvr2fb_map;
 
 #ifdef CONFIG_PVR2_DMA
 static unsigned int shdma = PVR2_CASCADE_CHAN;
-static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
+static unsigned int pvr2dma = CONFIG_NR_ONCHIP_DMA_CHANNELS;
 #endif
 
 static struct fb_videomode pvr2_modedb[] = {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.0


