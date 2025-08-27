Return-Path: <linux-kernel+bounces-788088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E001B37F91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122ED3ABF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC330FC1E;
	Wed, 27 Aug 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XGKDRchi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71822E406
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289640; cv=none; b=Z6dXTmDGhyQD5GT1Zbwt3YkrVBC5QLhz6ytVwwjz+rQ+Y3JnQMR0LiM3N90kljf2WqpSy6AE7ieoO9WFdqPze3o+38LK8QXOj7oLNAipA9Goh8jn+E+m4RwmP4SWb/fzvP9/i5AOcgNeCeFb5l2fDjbCphCJbETi4FB11tSv4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289640; c=relaxed/simple;
	bh=7zvrItd6lF7DhWRHMFACpJHxtADzo3yZV9OaBF0xCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsK9SxFwpb22KTtkn6QEEE8h5ogQx3++28k0QSGr4h+TCZKa2mv4+M2/G/S4Y0p32v7b2yvZQ+bgxKxSEYCoHuMJPficxSp3PAMHkQ9hFn8CwEO3YPg46GC6ect5Bhu0wu1xW5i0DVRXg6UYsq55f7sbdd5UyqUtVjSJgg67r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XGKDRchi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d8921f2so48804715e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289636; x=1756894436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFHfv4BgFFf6UjrjZCzlbsHb0+jz7Jlyk/zxyT76xO4=;
        b=XGKDRchiy2N7qzjFIJSPjgHAUVf/aKOnuZFiZvpRpwuLrz79bOgFcFRqGHdG/g0lE+
         hj1iDsRZk5p5TzFZiV2EwLAbqIJAXcilODWYDoqhnoqNe5Dv1F2Q9duXMhN9oOJEZvrE
         1WI8biYKr0T8SPwESI/I8WOhxRy5r1UwkJdTvFFC7hI7wSRFerDfk0R2ceMIWSqAOcMS
         DxcZnGuoT81slK811cugw1xPoePaldpOKG00gvcXXMjHcn7YSuM3TI2Z7ki6Yi8zNu7G
         7UzyIDzQfCg1Zl0LVLLmDg8HDMMASnkDUR8V0p8VDGJfGI0yTXR8qwOYQvIalmm3ULwj
         juzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289636; x=1756894436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFHfv4BgFFf6UjrjZCzlbsHb0+jz7Jlyk/zxyT76xO4=;
        b=j5HGwz88C2YR8LgybqKHcYj9qcJE/tHOHO6P0pr0zL5grswNghWFN5CXWeLVoSY5Pe
         jSvOATGFywBq/uxFt+XVMSmG/+HvxHbbuvJjrFGYlkJrRKLGJjJ9JOZSKkywYrPgxSAG
         IwXjMubzN+5W/Jibr4rF/JhKJsxrEjz/JmF38J41UbFMZgiHBxUGGIjR1f4ZgDInyrHR
         E85oV1yMQyUL8x703HyD+2aPHlI2abDi9vrIk/8TNg07j3ZgJ3b+lKnMQy5K/pj2Ttf/
         om8xVYXDb6/Zo0o/k3NkBDS5JTwUUor5SfuRoLtaRq+Ogo40wg559hR4mDRxgyVFr3MI
         NA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWnkOCBhStOP7tPqhKJnVQD7a/qXzDUsqpyG+tLS/tG1n0taerD39kT0CdN9jjOJTTMpujgOqhsUcVx/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcn+2v3Z1aVfWvHSCo65nEEbfwpuGLEWfOLX5qK8u0etvn8rKL
	2xlWMOyTMJZi9JvL6eRwEn1RvBruWr/6+KWQ+8svk9+CjsqMkv+NmDWpxzG19s7YA2AR3oWG8DW
	u2evV
X-Gm-Gg: ASbGncsIoEDHGVomI4c2sKyhuCcb7iprzvFZ7xwQHhl6TsNyFhynHW0rDCN7C/yY3iI
	/TbD3SW3QWhT1RdzVnaXoSe3gff04QvIzvRoMo8cETPlNjba8u33XDo6xjl5vfj8RXiiwDbzzJC
	kYPQEgSIqjxdv+085ov+xurLzrb6d01eQTvFz7XApOk2meHjnsvjikNzz3y3Xp1weuWUQBal3jw
	8F6bjbeLQkNDKfkJy8syeeS30qcOD1PJ0TKYjidbGa8rHGUthGz3kz2NIuF2f50Fjre0Y0gQvtC
	jPw59a2JTA0i8jfDOZxjwdOTbZgMFDjIqhYjvpuyw0m2Lm/M3VmksANmV/6aLhKU1ePIcg9/FwL
	Mk9jJ8Fis2RPNOiBqsk62cfP7WXX2oZFRt7TMsCwoNSuclNqrZhUWEO+L1qZqsVpNteBb28OirY
	KIo02kFVvd044XBYfl
X-Google-Smtp-Source: AGHT+IHpy82kDFbawOUYQ7LQKwjjk9cJ9CSb6+MrqfxOmu2ab2pw0XNrTRDxvK7P/73HdRFHaFAj9g==
X-Received: by 2002:a05:600c:1f83:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45b517ad803mr163924265e9.10.1756289636196;
        Wed, 27 Aug 2025 03:13:56 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm2700425f8f.52.2025.08.27.03.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:13:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] rpmsg: core: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:13:52 +0300
Message-ID: <20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rpmsg/rpmsg_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index bece5e635ee9..5d661681a9b6 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -479,7 +479,8 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (err)
 		goto out;
 
@@ -538,8 +539,6 @@ static void rpmsg_dev_remove(struct device *dev)
 	if (rpdrv->remove)
 		rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
-
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
 }
-- 
2.43.0


