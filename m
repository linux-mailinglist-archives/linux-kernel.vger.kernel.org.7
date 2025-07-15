Return-Path: <linux-kernel+bounces-731506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D9B05563
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7107A169C54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804932D46C7;
	Tue, 15 Jul 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WybPOzXk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DB2D29CF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569417; cv=none; b=mH0+feJ7UQC1P9rExwEcm6YrXg0PHmHsKZItfU3krYO9i493ABSunZ52Dhby9AgqlfCyPbZQ+hMg/FJr6HcFSicRmHPX8LDivn+eFUOAsBzY3pF9dgBL9dnCd4r2yZj9l2JJYQjcqLXyGL5k30NorCiG8P9kDWjSrPuIUTJuibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569417; c=relaxed/simple;
	bh=d0lPW1A5fBB4fVKDhlkux6p6Ga7DYrMc9g8pnwepm44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W6n4amYrUhZaQwsCG+UoLVRYc5rZTtCqL9nuJZIQhHyn13jQJULDWBEERXNmy1vsq5PCTUE4z+gydwNCOV+OshZAxWKbK+nwiH58zIVNQlJ9MkPQW2DQb0Qmg+2DeoNbziTYKEp1GwmT8ZNH1g/Phc5LiqOF+s3LLzr9FPHmqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WybPOzXk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455b00339c8so26179735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752569412; x=1753174212; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+nh6JxemvhPIP24kZ/vb+SGxVcCnNFMlQjgWa9fn3A=;
        b=WybPOzXkd2lXNZCmVvfeQPhPO+EcMmgh8ij+cE2OAA/KZlMvZAAxswihN9UrOv88GW
         Suyxy0ncyVNFlJU7gLE/4VQsWsPpKmYLNvAp/vkkWvcJm0yedAjC1EaWxKC48+Rot2Ky
         pSWFWTVe8w3ldkbrVFrazmOYhRRn4ihdJW1rrKHLQfOiplX1MbMgC4hZTZt/LOZnnlQT
         dJRWkeXlaXMaa7oqwcfvOUGlBAW9G566zerjSH7pJQuhNo7RdFRF9vWweimaWo0JUpGI
         eEFCdr6d9lcUOwVJQQWxfvnTvgpFyZa3wsJP3+CcubYS9N+ekT5YGVvmGKqkUOOsOCk9
         wQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569412; x=1753174212;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+nh6JxemvhPIP24kZ/vb+SGxVcCnNFMlQjgWa9fn3A=;
        b=TFZxiTbqsPKDucKoH6PgsQPnLg3ZkFpKluk7sV8quadncVBCa9+e3bj5n3mol0ucAq
         PyDEOEB3A1k5JFo42iacfzmapNUoHq8oAlyy2os3zuEzEuzcGOht2zyhfdNVuTgen+2p
         I2UMXQB9Whs2hREQJyo06g/GQwzbNCP7FBEpzPA7e8QddG5B5Pv+CGNwnsjKqLHWRBr3
         fW9jUFoIFL6DQJMibU3YwTl43VOLa647tPeCHfv19FrfN5MQit7YnugLgX6BsOsLyUp6
         6VlvBeG3b8iipLv0FY1G0qys4aFMs13n7g+lILW5oKxp77yUvb+pdX5Xhs94Dc6MpIml
         G6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Y2Sg7RMAUraU1LC2Zjrwkmz9JbcG8O2e7Dp4SoNloyKATIRijlLsZRxwxPWH6Ys0YCY9u78qtgQJsXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7qC5Kn7FOoRceQbFVV2cIveCLxLkt1lrdSum4dxJhki+qNJk
	B2yvKdSQ6NZgefq/TJjn5ciRWWzzfFJhRE9rQE4r9OG2AJCj/kzRwTt1Yn/c0Xd4VAw=
X-Gm-Gg: ASbGncvjB+QutXmGa974hpKezheTQLyMqZqELBp0c/waefwgNN8U78h/+wHYJsWFzuj
	ZGwE7owOoxr/h+ore8eL2pUhtWskmTz8uC2a46wd6skI/Cmkdtv1jCIFdzmCS/Rehnn/CH1bTc4
	c2axrwOlWsj4DydYzPu85tHH8PGd++GueZSmcewJEVwcZaL3QilH+HhYiFiCNA55SoiMYYteoaY
	IL3PNT1BZaEjwpmM51ZFZ0qNSmGGjlDhsdtlTAnqcoyXqWxTXdfPbLtFKcj9/GSdNxc3zbHYqg/
	/ShHzE2nOQlYVZyN42SAO76LED5YaQsMuE97WSiI8j6E75t9PlTOJ5KSiLnyUTgOnzwp6+b6yqG
	6GKhYMS/u7RbLGYW8Vn/Kc3znaw==
X-Google-Smtp-Source: AGHT+IFMmk/5rfMV1ctfylvB0nED4z6hP+M5t84uEkTcCAMiiEw2CTJ7Qjv4i3vnDPZtivHARzAKVA==
X-Received: by 2002:a05:600c:a301:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-455f187666bmr101086915e9.27.1752569412556;
        Tue, 15 Jul 2025 01:50:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:9f6b:776d:f95a:bf2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ceb1337sm92280065e9.13.2025.07.15.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 01:50:12 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 15 Jul 2025 10:50:08 +0200
Subject: [PATCH v2] pmdomain: ti: Select PM_GENERIC_DOMAINS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD8WdmgC/3XMQQ6DIBCF4auYWZcGJqKmq96jcYEw1kkqEGhIj
 fHupe67/F/yvh0yJaYMt2aHRIUzB18DLw3YxfgnCXa1ASVq2ctWOIo5ri6shr1Aq4e2b7WzZoB
 6iYlm/pzcY6y9cH6HtJ16Ub/1D1SUUIJm7JXUuqMO75PZXjwlutqwwngcxxfkdejKqwAAAA==
To: vigneshr@ti.com, nm@ti.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vishalm@ti.com, 
 matthias.schiffer@ew.tq-group.com, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Select PM_GENERIC_DOMAINS instead of depending on it to ensure
it is always enabled when TI_SCI_PM_DOMAINS is selected.
Since PM_GENERIC_DOMAINS is an implicit symbol, it can only be enabled
through 'select' and cannot be explicitly enabled in configuration.
This simplifies the dependency chain and prevents build issues

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v2:
- update commit message
- fix select rules
- Link to v1: https://lore.kernel.org/r/20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com
---
 drivers/pmdomain/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
index 67c608bf7ed0..5386b362a7ab 100644
--- a/drivers/pmdomain/ti/Kconfig
+++ b/drivers/pmdomain/ti/Kconfig
@@ -10,7 +10,7 @@ if SOC_TI
 config TI_SCI_PM_DOMAINS
 	tristate "TI SCI PM Domains Driver"
 	depends on TI_SCI_PROTOCOL
-	depends on PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Generic power domain implementation for TI device implementing
 	  the TI SCI protocol.

---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250704-depspmdomain-2c584745dca8

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


