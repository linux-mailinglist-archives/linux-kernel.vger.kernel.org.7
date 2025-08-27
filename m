Return-Path: <linux-kernel+bounces-788093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D354B37F99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B8360324
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105334A320;
	Wed, 27 Aug 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Dzl19F0C"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F531E10B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289713; cv=none; b=IPrNNSe6ciPXRIe1fNBWJuvMb2g5G1OAFARPzHwUI2IVPtEHA1Ah03q3AXrBiCfO+jUxE9j0hg/wtlFPRPtgXXoWkwNEm4emg/EuXYUZX9ZFGF8AegcDP5nfNP/ngtQ58RtJq0ewgZTfEwEf1dieED7swckpqc9qdjWDrZEdFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289713; c=relaxed/simple;
	bh=Sg+pGRRA7q2AByf2Hlbv0gumGdBGdBqUUkqNm4+1Y+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVVW6QL3A7thv/vbB0rPPTYjgr896QeVtJFKyrb73XWlKXE4zKVld2Vz7GlrZ1kYmbRJ5ekjDcC8lU0W9kuXN+mRzqBQOsGGuL3biEFHh+CRkLWbxYAEXWLDhPFzLP77BlHGKJrB7mjeoHppNjRqtzh2qnHfzC+MmCJ5cE0JUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Dzl19F0C; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5333103f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289710; x=1756894510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3r2zvx+5YXF75JhFWS8o9+taAgLNyjY1vPNNGnu0k4=;
        b=Dzl19F0CjbJhEK0Tv3RFHbcpTW33XbFoEXIIkttawea21oNFlvae5+7ZoBoEjvgUZC
         FUhbg7t+waI9lSjmmP8VvSbibKR3yMrM79zMKNoXmX4v6+QCq6hOaOxr7IUq/uiHJ3v5
         D7rM+qGQzFGlCTQNYgcYCcN/QXS/QUmRZkfU1F4hoQkJDPFQgXps1ipmDM22b7vKlx7/
         iToN6UpiXQUWA8JQ0l0Vaaa65fZEqqJ/epu1ACPhgUnW5sNJs5tJiHWq302rxLUqcmP7
         dwJYqzEn8h8hV0MkgGwg5KpQyW0s1fLTqS+IOvLgSj3bBM8d6oE06O/89JV3zDU/sshM
         WfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289710; x=1756894510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3r2zvx+5YXF75JhFWS8o9+taAgLNyjY1vPNNGnu0k4=;
        b=GntpQLR+hnRhmWCSTnASuJSEFVSDntl7wgF6B5LIHOXTiA0qfNBnlsZ+qnre7CSrUc
         5JtM+ilUNgPfzNaFw3N5TvmBtQwqqzPg2wrTQ6FL5b+yCspdW1OcDyX7Yw4cQ6FKyp5G
         0+kH9Jy0pN7GgnAPmif8ZIaBcAYcq3RkZEvOHPP+KX7bz3TxhIcvxQI0i/Bw/FT5CTc4
         nghRt6bX1jBzrOzR6XZlvI0bIQJbhCfhUo46TMwBNDonFAMR9c/zFEzZfctnOrLd6uAK
         sIz+rwbQrvsyVbgPKUbhDs6HCbxZNg6aG9WxKmHcAayJtAD1Y9Su6UDcl1og/QUVXslS
         +1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUNp0IlaM7BY4rK8/6Aot8SxxX2CuMjP5eeH76tKg16dWXwjGJBKA5wT1/nL6dzOqwAMIULQhtXk9y3rj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyG0SwXB4O8N8Ry6Qt1w4TMy7tBS5g2/WvQ8a2H93+ILmCO5/
	WcKsh/RjM0pJ645KWjgkRBJHreQXtJSACTkGtvRVNu4aLzPgYrDoL88xJHy8lkJsFuI=
X-Gm-Gg: ASbGncuAtYahtVEzZFKy7TMEfSh/mgjtH8GmQqVxkuf/rbmqQY/peARnfMd5EsnxZxb
	aPDnEip3zZiLPfj3HCufMYnWU+UmxKZ8phsuvtNEQMsWkPsU6KnWwRO7d55C5JVkF9CTdG6E68d
	N4v3QxnifcunVKLAWvUrTPW5/wJPinXSbikMb6fy4ltam8J0DDoOuoLey6ZH9bP34mUGR+bOBGx
	YIdSj4VkitDWjykGm8dHSIKDiNLSCCi9EYXw/H06Jcuxqlrvjf3fz1WUg2LE0JO1C2F9vB/5VKO
	tI7tL00tmULFBaQ+Pl86W12OH7GWTOrZvUH2PY1xmQ9IXDslLdL2JEr6zP9PzrxM1jgjgwmSHYE
	czNUXAXcuZZr1FN2HLYfzTPGl2yLHy8Y9cG0DwErmbHUcLjcRGz0Upx7jb3ACjXb6y0l4Zbpb4/
	cYX5mNKMl5enuUCZSP
X-Google-Smtp-Source: AGHT+IFugYIwA+l4JVKOgLNNenAV9tWbVV+6SyjqknULzoWbKuNmfsapi7CzhBqr9zREZFpAQ20rfw==
X-Received: by 2002:a05:6000:2381:b0:3ca:d8b9:a4b4 with SMTP id ffacd0b85a97d-3cad8b9a55bmr5732389f8f.35.1756289710292;
        Wed, 27 Aug 2025 03:15:10 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f14372fsm19787956f8f.28.2025.08.27.03.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:15:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] soundwire: bus: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:15:06 +0300
Message-ID: <20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/soundwire/bus_type.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index bc1e653080d9..91e70cb46fb5 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -114,7 +114,6 @@ static int sdw_drv_probe(struct device *dev)
 
 	ret = drv->probe(slave, id);
 	if (ret) {
-		dev_pm_domain_detach(dev, false);
 		ida_free(&slave->bus->slave_ida, slave->index);
 		return ret;
 	}
@@ -180,8 +179,6 @@ static int sdw_drv_remove(struct device *dev)
 	if (drv->remove)
 		ret = drv->remove(slave);
 
-	dev_pm_domain_detach(dev, false);
-
 	ida_free(&slave->bus->slave_ida, slave->index);
 
 	return ret;
-- 
2.43.0


