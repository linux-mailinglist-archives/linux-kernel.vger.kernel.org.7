Return-Path: <linux-kernel+bounces-812642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F4B53AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C434C173095
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD9362998;
	Thu, 11 Sep 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTuzZz+O"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426B635
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613439; cv=none; b=GId4r/NSGfZPisd+cHSG7KZZwazFzb2t3syKz0yo7mdViKKB6WshUhpSE688IenDiOvaBDkdxVVYK/TX+VKHNxFUl0NLh7L0eI9ypOlKwmU14Obn6h8S1ae/1AmWcRTHA6K4LGOfvrzGoZo3YK9mG64Q7QFlQYo1uBfaGgSBDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613439; c=relaxed/simple;
	bh=Plmdu1fxwjxVp5gRnzqd0H2THbz1pc3AN+8geukbwMM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uv22ECI5oPi6Am38apcu6qyXeah7G9h9Lv3pjfM+8TGRgq2wHekxvG2pMNrHPrB+6/Q4AFYelSO6//NCMiiK894Z/q76wSvUWlKIkek6zt+R4QNVr6S4sPmDo8u3dTR7/w+SYMJMOC5w+sUqIvKCqvPuyyvs+yTmCQ6Z/l7XTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTuzZz+O; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so146454866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613436; x=1758218236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jz5ONOLYuuEKVIS5PKxv/MfvHRUbGH54YF0vEhe629Y=;
        b=gTuzZz+OZuXRqpT9Lkwbkcf+MxFDSGG5XXYV0WUUjRMY8wUtMUA9uiHrnlBy5bPexh
         q0i7auqZFzdpLM1xBxdZGTGXtdlnSHOir6DqAlf3e29ha/vcZtn1eFgha5psJEieG7gT
         L80VH0E5ez747bKb/if05df6g37DASbORVtJCHAr6uzvHsqcvlUult0J2OhxG5dRMEMP
         zZGKA0Q3F1R0AzRGQVI6LYBPsFZpS+htHUS483/t6zzMtLNSRHBdtUCYTmvdQbYFCcMa
         Lihw+OE/4PHQD9ZFpRJWOQSmMDSn8Rlb/so7VAvmQ2SYF34O1+h4i1CjWldNA2PnpGfR
         hENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613436; x=1758218236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz5ONOLYuuEKVIS5PKxv/MfvHRUbGH54YF0vEhe629Y=;
        b=gLMUTiwOvsBUokTngV9kl5wKXrBNrwjiKpNmqxVHLiiAOqTXzOUPUMV22Gg0Ol6ydW
         IQDyewLyJJtwYrPIwqOa5ABisrDUM/5ueDmdiN+koE71o5iWTwn8YqV+U660p/ByUabK
         732Ni1LwNHeKi7vDvj3LPjZ4otX2hKW0Sz4VENH0YI05Ao5UGxiBjURglAa7/V4xMWVU
         fqKkZdSSwTvITvCXYdkJVYNywxxROlOF+JWwo4JLu+M4D+ume10jgzEz11xKM+6e3fFO
         eIjcswWdSFWohFQzciMH6IdNKZhLyFKI57nsg7Yc//6GijEVBVVtvnKfCSuDFBvBJnJC
         Kb1A==
X-Forwarded-Encrypted: i=1; AJvYcCXuNZVbyTyhtIHMXPTPsf1sua3gx2mO+IlSarsgOf8c8/gkznVkKMaispesdYIcdII0a+RK6iO4iIa5aK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzf/6OGrDoESxjf9EOfeAlRdV64L/hs9vRYSh1hTwOr5E4pi99
	netgoc1yyO3bLYILGWnoEvZ0em14ivlId9WGVY46oW/LtMmhI+B9vnik
X-Gm-Gg: ASbGncsX+vy8tXRztv7ZWAPG2ProPZfrtAAN7xT/W3P0CPbtR+/SAzUhgtK1LIb02O8
	s5HxwT5BcMD32eO8fw0rogqqG6dbpHUWviVOzhePZ8etN6oAxEAjKWNezsrmTJflfzkL4c8uhdC
	nMyzHHgsixAG4MxaXy0XfnT8neo1FV3kM8WhxjJ6V1VcGgTDHtUl9xCyPf0Bs9/dakokeJzdun6
	G4jRgNoMXyH5bBToe+G46cGrSGpohTtpC8ztKTOiHZ19xL5kONhnwRBHzIlbUJzu5/6V0K1CN14
	TWu6tI/RzJQvHJkmYj2hRjU4/GMEBBnPLLiorH0TU94KnY1ELyeh5CgDEzX6uUT/bYFVv0vJo6O
	R7pAuDfCrCbEpm7TAJe3sExkIO6WyWIY=
X-Google-Smtp-Source: AGHT+IE6tG226p8U2j8J7QUEBsfL5Q4SzQz0JzTkVNSqDcfA3J302DZfTEABr71yEKF6aUpkT+tYMg==
X-Received: by 2002:a17:907:f818:b0:afe:d055:7531 with SMTP id a640c23a62f3a-b07c3841de1mr564966b.48.1757613435970;
        Thu, 11 Sep 2025 10:57:15 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:15 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v3 0/9] power: supply: fixes and improvements for
 max77(705,976) chargers
Date: Thu, 11 Sep 2025 20:57:08 +0300
Message-Id: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQNw2gC/5XOTW7DIBAF4KtErEuDwQ5xVr1HVFkDHmwkAy44N
 FXkuxe6aLtsl29+Pr0HSRgtJnI5PEjEbJMNvgTxdCB6Bj8htWPJhDPesbNg1MFdSsm6QcpenoZ
 yFCeMg3VrDBkd+o2iMG0jlQHoTqRAChJSFcHruVKqPaYN4tuyoZ798Ru8JaWHNbwXbcTFZowf9
 XuNaOz9q+L1teTZpi2UVW2cmzr9V7ncUEaxbEclzNgK/jI5sMuzDo5UPvMfsmf9n0heSDiP3Ch
 oZdP1v8l93z8BC4lkDGUBAAA=
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613433; l=1912;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Plmdu1fxwjxVp5gRnzqd0H2THbz1pc3AN+8geukbwMM=;
 b=Xu0hQXOl6rwFqcVQmgIv/BMndyYjvKAZ9DZIYi2N/YtuBjelB/hEfnfIoLmLIFWlI9soY06PD
 87zeasQ/iQvCNSn38ShMe9al5DYBU2SHvyk9hwnU6s8pbBwvwTETzl/
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This series consists of:
- max77705: interrupt handling fix
- max77705: make input current limit and charge current limit properties
  writable
- max77705: add adaptive input current limit feature
- max77705: switch to regfields
- max77705: refactoring
- max77976: change property for current charge limit value

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v3:
- move interrupt request before interrupt handler work initialization
- Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com

Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com

---
Dzmitry Sankouski (9):
      power: supply: max77705_charger: move active discharge setting to mfd parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: return error when config fails
      power: supply: max77705_charger: add writable properties
      power: supply: max77705_charger: rework interrupts
      power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro
      power: supply: max77705_charger: implement aicl feature
      power: supply: max77976_charger: fix constant current reporting

 drivers/mfd/max77705.c                  |   3 +
 drivers/power/supply/max77705_charger.c | 396 ++++++++++++++++++++++----------
 drivers/power/supply/max77976_charger.c |  12 +-
 include/linux/power/max77705_charger.h  | 149 ++++++------
 4 files changed, 355 insertions(+), 205 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


