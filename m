Return-Path: <linux-kernel+bounces-770801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C47B27F14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7841B563703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A421422B;
	Fri, 15 Aug 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ohXaVBMP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2924DD11
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256668; cv=none; b=J+d8DEkb1Y9wx+6AoJHgFZOgB8dXO3fgCB1Gj7GbBxR7efbyPYvLoIXLySCUuDPqfoWNTFnJ0NH4Bvd4cR+HY6IYvZsiiCNZW1flL9JL0VR8FyHOnWGVx6F9tb0SrcdULm5d+PZ7U6PMXgTyO4OCbeoR41LWIqDbcTRWQOyTO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256668; c=relaxed/simple;
	bh=cNJ/rNLToCZpWc/OoFeQGRqPtuVjPbFhuP+BjjGpzBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHc2xT1XSpauIcrYgBz6rog3B1bT68n91xhrCVb3IMQoQ70r9iy5aOk7XQ2Gud11V2qSU0J/ECnNw/Qd6tGLWrYJm43B6KtHTT4QNXinJthYQinWYEKwy5q+s+UjmwwcjM8+D4An77t8/V6cUKLftedWtYi0yQv2++b2/cB1Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ohXaVBMP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so1102032f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755256664; x=1755861464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik7xRaqOpkaG6bjW1AGJTmHUr0AVRjkRhCnWI3OR6Ho=;
        b=ohXaVBMPzQ7xYbsAq6yQra01lXtdR+oYHmr3R3MhrfYTCyMYE5eKDNkIoJd6xUNS9J
         lcmoBK2AI9gknr2FWuxud6R71cZv8ZEHArlDMiRXHQdDYkDE62Pmxhe7W6ZhaSb1mlky
         iyNoDzcG5Fk0Q6EVK1pRLcQyVdjrQjyf3grLeK5KPuNa0O3DDUTJtJEU0X2D93zmYlbm
         PzqsiDahvIzGEYZu8mLX4GKbMnUOs3iBgEf+G8tgjFR6HgN1nFZa5fmtVvcBLsNxMTW7
         w/vWHFU7svaWQKsbyWTiBrxH7ZqaTuF5qcz/s/28kdfnILdWeYqoGUstqUxBsEJwY5Wd
         Dugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755256664; x=1755861464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ik7xRaqOpkaG6bjW1AGJTmHUr0AVRjkRhCnWI3OR6Ho=;
        b=Bb3ONaUL0nAKT2Gudv1ATtKLH/HiwGcw8spAg0Mu4EbW131ZDbBn+ZRxBVa3ttgnZC
         EcqmE9aFlECqimiytee/LLk9UsvSsu9ifiIxd7jXfeOMpDnSpiJverTdwJ81Mmy/PQXY
         T0d9u2f4bKQa4w5N4cayhIJCf8RAd6E5jI5g2KPC1TNOhdXG9PHZyNY9Na5Bf4Tt/DlK
         6tAX8AJBed7JssXfsmNGH50JeUjjTkDcYJ3MFAP05KRkg723LB6rhwdT53tuvKYiT+CG
         lKBb5DG+EmojXzFBRdidfsI+S4WtM+xOeHKDsFaU6FtSrYO5XZL3IFN5qihgAOkdWCTQ
         PwaA==
X-Forwarded-Encrypted: i=1; AJvYcCVTRSS1HnSWapZMMtoUxdKGUdjnhdjI6ftZRm7U359OKiQu76x2BM0nARJA51D5qd8nMjfJ4DQSYM08D8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHG3vAkzp4oRFQfUMQ8v+myWaSZ/DHsCJfw0Mrb0cVSddyrWM3
	0eD0vFade916k4KX0BaG0iTTIRKvbpln8ePuYHlQ3ogpCfFqAP7bB9TcYePy8besNl4=
X-Gm-Gg: ASbGnctjejZM0JrL15vpxaFxeBYb6dCatDHHqx4z4nbX+8wsbiKY422eL7gliEmpLKR
	q2WWcbHhRXWdToWI6vrtNDHo4DXoDEFFlCd3RJz8Qx8fit6KgyLfsrnzL/NtchTqtnI6ZH4qFz9
	HkOZRWJ1G/4CQ6n6Nq8qOjbkLC2K5Z2qiZ/Po7GCOtTIjWEnFHIZarmkcGgwVoLGH9nwr/HyG3M
	bTdYLpkmsWcpTeJEb53wy/xZjto7kjUs4kVBYCbzQerDDfX7DLtKrgdMaRrANEpI9LqfPluC5zR
	xusFkPmdUdbQopToAqzpRW8hcuWon2OlI+doH2LmcEh71ZfStbgiwwIAqp6pk4Ig3fSCgiUvuz1
	v7kY8/KpDMr1WRrEUtBv62cv8
X-Google-Smtp-Source: AGHT+IEBgoZjDsFHLhuyxOxceb35Nmp9E6inGayR97K7UzkscW/Xbu5vh2RYJoclRMRx5WVToPqr/Q==
X-Received: by 2002:a05:6000:2887:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3bb690d31f7mr1308362f8f.49.1755256663780;
        Fri, 15 Aug 2025 04:17:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a125:bd3e:6904:c9f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475863dsm1616426f8f.5.2025.08.15.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 04:17:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: don't use GPIO base in debugfs output
Date: Fri, 15 Aug 2025 13:17:33 +0200
Message-ID: <20250815111733.79283-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're in the process of removing unneeded references to the global GPIO
base number treewide. Use the HW offset instead of the base number.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 050092583f79..a83f5238427c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -262,8 +262,7 @@ static void gpio_sim_dbg_show(struct seq_file *seq, struct gpio_chip *gc)
 	guard(mutex)(&chip->lock);
 
 	for_each_hwgpio(gc, i, label)
-		seq_printf(seq, " gpio-%-3d (%s) %s,%s\n",
-			   gc->base + i,
+		seq_printf(seq, " gpio-%-3d (%s) %s,%s\n", i,
 			   label ?: "<unused>",
 			   test_bit(i, chip->direction_map) ? "input" :
 				test_bit(i, chip->value_map) ? "output-high" :
-- 
2.48.1


