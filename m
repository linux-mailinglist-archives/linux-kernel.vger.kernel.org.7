Return-Path: <linux-kernel+bounces-788103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0082B37FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25E51B66D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189734A337;
	Wed, 27 Aug 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IojxMeFl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABB3469FD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289876; cv=none; b=Aw2dLB+3Ff44ub3AIDaPEthuItC9MRPhvPeZxgRR3YFFfINmFSN6o70052zMob6/bXM5Cu/BfDL7hrio8mhjFds8hJK9/nBRcJPfup+6twUij7jI0KKwSXTmIsQ71pgcwaEgp8wE+0R3yw/PmHfWmVgHP82wE2IE/1cUcgBggu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289876; c=relaxed/simple;
	bh=XiCyzRrxnhE3NB2OuwNB4t2/v4Wcgu+fsFnAZJI/iYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NF4tLj8ApP/8gTLqAC6UOgtHpTpr4iYeizrIwA59ySNbwMwzsVRkUIP24m82hArOXha7KEKxOxfV8wUobcaBvZPUs4q057Qjne9LiQ/0fnnDpb3LCZgsY4BDu4ZIhbl1DqJvP586XQsqXB4Oy8GEoK8VPK5YOcUZ2tKfnRqI2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IojxMeFl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso58004235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289873; x=1756894673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOwtzUYNEN4Yb2Ca5f0BdtO/R5WNfpNb+21iJrIdehs=;
        b=IojxMeFl1L3EroARozf11RIX8gposU+WCvZcQ+URehodxc0Tw49KPYCdGAMykPHDnA
         N+OOvMZZKgL7XoIqvJukOmwN9/fqRq+MOSRQEL68L4ZsPHXndCdo1DzdnQDOV+OzOFvG
         QyTwQzl9xw3DDtyMn74rNzOcB5LINBUQuTDiJtpnFcyG3ssrhxUWpEGs3a6osk7CYe9Q
         Ev3Z4m48IXuMne8Zivv0VTWfEjDBnoo45lKRv5fDUeeT11/6SlgIqMRKdydbP5oRHZuq
         GnTIV4MQGdYCaKVelgSAQdgYIBpyaDih6Imse85ucf8CgQYzXjBmTNvLrsTxBrLij36U
         BZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289873; x=1756894673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOwtzUYNEN4Yb2Ca5f0BdtO/R5WNfpNb+21iJrIdehs=;
        b=t0/DHSGnQE7ch+kLynDGdRobPlRSwwohkPSTEGq+82vuJzGx2k+dJMWIgTqtr4ZtS+
         dJ6L0LiqY0nihFhxbYJfP5NfLTkMhoc2pVxVIJm7opd+h+io872uKusrWJzcTO7F6KeV
         FxskqtS8Tc/oYR+BzKYr6cxtopmxouagzE8KIRjXHNCWSq97QMm4AIj63yKNgF5k+zWP
         5r8ImjKnCl03nJnZawcsn5Dnrejfa1/QylwdsvGQeJS1ZxrXEEr4oIN9TmXTBb0OZ5DY
         u6am8t84XzJ2eqvYWQjzHr/8F3/qy/DXhAe11DKr+uE0ZiDdPcelvS9Wzd2H/fcDpDw3
         mOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUGHhIiJCPqU2jMRWb5CmzQZRblBwx0VvtVZPu2vhcu8mw4vDJ3/xLliA5LwCcd9JMcIAW1Kn9ML1HEoNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJv965aByQ6xtb7pTs20kA5WrdQ6Vj3QyWWCR2R+/xiSRGKTMB
	HQbonUCKgBvTcnWronQ5B6jTJd+Wp+FVFB3p0ihnoa+gyGTGeSZ6P2wSg0qcUSyZYiM=
X-Gm-Gg: ASbGncvF4TpLf0YFOPbrq7j+Es/JH6bt8fewXwtKlUAwuPxY6VeSG8LCHUJi+Y/QNNC
	338zn/WTeuPyjdcyLnnT4UjAzpnn0iVdZnYVBsWejqYFGsLdXEEDMfwwwWPhPAhsjC2Ui9+ISgU
	S8VkeXG1pUfDvQeKYEcIiHhI6oLyhOmuYKeN2Eh6qdDjGeY05x8YLJuJkVFBH7uTebgQILNuowz
	+dXZaGmIU8z6pdQGeqKuA/jvW76ZzhTd4HCze5S+EkPOEUpPnF7VaVAxgUpBAUZzjFsuLiPviV/
	RGpx/uUWHPP3yZPowVR3dPDBQPFpdXNrQRlBRVKaJbJWaMqij8MWO9q/tknEPX8AsK9FPhcxILU
	xJgiQJSiNL1SEiEfUEOZgTVlivkCz9OyEvWaK0/kSfdEvFQI1akiFTHkfnaHqo45PVgGBSMdcF/
	R5azJQf6l7SVDjw8fz
X-Google-Smtp-Source: AGHT+IGgDVceGJ94gwXiT/IZjg0OTBFL6jcg8M6Oz/orNkYOgSyHMDwEfK7xO6wNc0Yvuz39hPXfyQ==
X-Received: by 2002:a05:600c:4705:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b517d49d4mr181322775e9.24.1756289872841;
        Wed, 27 Aug 2025 03:17:52 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ccac1b892bsm2293290f8f.67.2025.08.27.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:17:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: robh@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] serdev: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:17:47 +0300
Message-ID: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/tty/serdev/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index d16c207a1a9b..b33e708cb245 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -399,15 +399,12 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
-	ret = sdrv->probe(to_serdev_device(dev));
-	if (ret)
-		dev_pm_domain_detach(dev, true);
-
-	return ret;
+	return sdrv->probe(to_serdev_device(dev));
 }
 
 static void serdev_drv_remove(struct device *dev)
@@ -415,8 +412,6 @@ static void serdev_drv_remove(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
-
-	dev_pm_domain_detach(dev, true);
 }
 
 static const struct bus_type serdev_bus_type = {
-- 
2.43.0


