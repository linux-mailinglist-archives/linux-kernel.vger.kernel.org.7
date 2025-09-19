Return-Path: <linux-kernel+bounces-824075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3FB88115
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E345E3A5F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221BF277C95;
	Fri, 19 Sep 2025 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gU6shx3"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7825A33A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264820; cv=none; b=r8NsCfPYFPMsDb7JdvxiD6vXXnXpdBP8k7uh226W+m6b+W7rxaJMaKn6di1ClZQjgC/lH/sXPgpoX+arl3r2rPr+nb+jvqRpvCol/+Uo5+6XbkQQfkVcMbY5CB3s9P1R+ERXQDCsrAyKueANwmqTjjerE5TYvC5JmRIeO2CVbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264820; c=relaxed/simple;
	bh=EJuDGoo6jTBxqpY/CS2DGrRN7pX5tg2s3F3ampi4QFg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SR00LagV8eIWooGoFyaGwYihtWDwmLz5QTS84k62iFGCGUH+dCDVgus0zQtrVwhbzNSRxcwevalG6tL61rG4fXlNDwYrtKsBs45HBsZvcUywgkog5IHV/v8HXDS+nZWOFDKPnTpAlpGrSrNF/dCiXXDYukQFs8CXAUe+rBYZTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gU6shx3; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso1305602f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758264817; x=1758869617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssjaRvEU66PpMDOr5QkEKKDcxWvxBo7C+p2vgB3nJ2k=;
        b=2gU6shx3jQWp5e19Qi/4v2lT6nmE16SwrQMb7ILrdLaoVTCvO3J5W6repiKGeIupeX
         MZQoSSLZ+lm1i332yfjTb+jWlFizDSHCrH6jGLL8YU4TZV2/Dd1h4x44JyqmHC7JD6Cy
         soT5tejTKDWhzLYMFWS7FM+Rndnl86dwr3ltKUw7v9eIHMNvXThjhgAQTWdAcmXPggm0
         s1WwrybUUlBih/rsXafVLeqALumk6rXzzA0Z9rIC9GvKOiiNuXOlHIaQhJs12Y8buTEe
         XVHchQ6pqeCEHe+y0ogeEQb2aaJV7oa7Gwd1q1jSod0CcpMTEXfizK/Csb+Q89ShnTRC
         6tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264817; x=1758869617;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssjaRvEU66PpMDOr5QkEKKDcxWvxBo7C+p2vgB3nJ2k=;
        b=gK8lbQ3NaWlCSHix4kEXBiWITDKXdazSk41Al57njC7bbEWcqFrdBdpnLki2XkwNQM
         LG88etibsK6ridBqeRjaOXMqD6YG72mhx3HxYPvGNI4EVItuZBFssoKhAfLbPOwq6Rcr
         im8n5Md2QET4MW5hmrKJ9ff3BSyHcv6QyqbT7mpXfVet31X2777TdFJUuyJERJthY27L
         /tQB8f/OpP4VIuNDX+01Syb/cUI3a6wDVzOUroWcVc4mytj2PqCw8BalIiN2Som0Agny
         JbzN+GU+Cn5Lg6vK+2BMGD+eSfPviimqSfjVTda9cMites6ievXeq9LfGY27GKmMq00p
         CZtw==
X-Forwarded-Encrypted: i=1; AJvYcCXRgAniGmrtUlMRECgZB9ynBR01gENVw9bO5kePS4Ru7A7dq3iYBXlbguNeWOFovX2esPAZqVuYaUFY9FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsH7+UuB1lvLCJy+AqKk++AL4nJOJrZRiSa/p+liQwBD6WEDTg
	1lQjKWE88DkS7mZJsVWgVc7US46s+v/uqkObV0CQsoVDRe2gpWeLL2JP4kByeIiQzqzlVNPASzi
	8pBXbr1Li8g==
X-Google-Smtp-Source: AGHT+IGGW4Cyr5XC0SW5kP9lRO92y+YHeoQBfTig/Q0irBhzN/dBVpUz+GcheHFoYon6PCq/83GW0nHxqnH2
X-Received: from wmbeq7.prod.google.com ([2002:a05:600c:8487:b0:45b:89e7:5038])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2211:b0:3e9:2189:c2c3
 with SMTP id ffacd0b85a97d-3ee83da0048mr1562510f8f.33.1758264817346; Thu, 18
 Sep 2025 23:53:37 -0700 (PDT)
Date: Fri, 19 Sep 2025 06:53:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919065327.672924-1-abarnas@google.com>
Subject: [PATCH] drivers: eisa: make eisa_bus_type const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Kees Cook <kees@kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the eisa_bus_type to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/eisa/eisa-bus.c | 2 +-
 include/linux/eisa.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index edceea083b98..bd76d599109c 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -135,7 +135,7 @@ static int eisa_bus_uevent(const struct device *dev, st=
ruct kobj_uevent_env *env
 	return 0;
 }
=20
-struct bus_type eisa_bus_type =3D {
+const struct bus_type eisa_bus_type =3D {
 	.name  =3D "eisa",
 	.match =3D eisa_bus_match,
 	.uevent =3D eisa_bus_uevent,
diff --git a/include/linux/eisa.h b/include/linux/eisa.h
index 21a2ecc1e538..cf55630b595b 100644
--- a/include/linux/eisa.h
+++ b/include/linux/eisa.h
@@ -68,7 +68,7 @@ struct eisa_driver {
 /* These external functions are only available when EISA support is enable=
d. */
 #ifdef CONFIG_EISA
=20
-extern struct bus_type eisa_bus_type;
+extern const struct bus_type eisa_bus_type;
 int eisa_driver_register (struct eisa_driver *edrv);
 void eisa_driver_unregister (struct eisa_driver *edrv);
=20
--=20
2.51.0.534.gc79095c0ca-goog


