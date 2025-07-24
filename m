Return-Path: <linux-kernel+bounces-744195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D7B10954
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED465841B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFC23D291;
	Thu, 24 Jul 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT2QeofJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76B2741CF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357064; cv=none; b=K6bShHe245BH76HdJG/r+YqHi+lxS8UolwghLco0i6xjv63VE6kHRYjoLGR1SG9sFRdsM7rmTDbLzLCWjYQJjDORV88uaPjug1d16ZxZV3FEo5/gtJaS2/17Qr+3FALCacEFJ37EQmOnotG+Qux/KPE7JzvsAmFCbX4vLAz3WTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357064; c=relaxed/simple;
	bh=Ch+72Ib5bWBMgAR5Q8004SEwup2pKwdP0I1CdDoDi1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZV8KXLxCspfpQ+jR9nuvZH5YdWH8krvyJ18tIqWEVw6s250wAvUJp0ieWIWN8hSVw9bovytYhO/3/1obaogZfkyAbnRTmHFdvMvonGjei93YHAtBOpaIBMWPp2Q35zmru/iEUfqWypQY6cJePYFHw9hamCqbmFL1//zEyoAiZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GT2QeofJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a52878d37aso101207f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753357059; x=1753961859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4xtybOJlZhvvgGB62xy7eIqO6MbQRaDpwENuMio3qA=;
        b=GT2QeofJqi3QBArX0wqOtYkPbnTNNNT6F0WVq63FMPJRlf/KU+Mk7v1zMy6UT+TmMI
         BnBHuvStYLKr18zeW+JFtEtmYbh4LWn/AyFICT/3WRsIbliGsS/O/pHv+J0pPAZiKa/n
         XO+ugeVjs8DAZoO8ZLHXuySV158Z116FXxrD2rnfDUxxfR+PEpce48N3zsQ+FE6yFDmk
         YK+qO+eUiGTJ0+uqtnTHGXvS9ijGAQODTGp1jJ9ETJhgkpwJ7Ldmrb7rf2AFjOOc7RxL
         3Yso0fp1mOjxy+IayPg712I8QUqWHagSVMvgi7SWoMPX1S6jn2GFkHYq53SsWyXlb8b7
         H+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357060; x=1753961860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4xtybOJlZhvvgGB62xy7eIqO6MbQRaDpwENuMio3qA=;
        b=vzXHJT6a96thAopj8kG1XtRBaxPcsVgYSUuk7mTBeu8IKrgmBn1uP/S6uF1c6M9STM
         /r3kS4qAyTXTTEcGA1RNZ2xHbZUqch6pQPssGbMiE8ErPTBYPPhOHopqaHEBD4avy3tl
         NN8K9THg4oF1WRKsTYXF0E8htzK7T3NrA31dBcJ6Rh4XstryKrJ4fmEU9iQ1d+LKk7xP
         aFCYgvXRuPrtaPVU+CEVxDkf0mXI3dI9ImxsoTNwjoARDe+ohFtSgCMa7NCLKxV5/Zth
         Fw3632CjAf0JMKx9gQixZJ4LZhvQVR0brEcPBIyUMyR3qXuQ+GgufTqc57apLEj73qyI
         F+1w==
X-Forwarded-Encrypted: i=1; AJvYcCXqs+YWv8gzYMMW13D5ZP/rhTD6JYvp3ANPWlO+Ueh9Tp1L9HW1VfUzpwO1aRg77BWptcSoDqmCVkaHizM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3ow6tloWg8Qf4Fcs5wp4+tBcOGRIqRRQCw02MlUarnYbgohS
	yTgdtuf2MnOT4sd3oJ/aQ9m3UV+fItJgqydsslNfnJx2scZwAJWqyWNROBcIdXxYwHg=
X-Gm-Gg: ASbGncumUOaA5gHgi2TTrqeev52UWWhIOqi26K5v1/H9RJmdreIHz0mB02bsFBiQdrM
	/kY+mjgvThL9AFE3XPlYhZOWHa6PgJk3rZQri/6CsGpWZS14xnLhq1r4Bd6ptD+3GAXDVNOiQNp
	WbRHgvdd+Sa2WG40xmzpR59z8TQH1cv22kme0ef8K9eMgkIgEPb5F7rxTFAkpFmDATcXkzhd6ag
	XfIHUNZNuqIKTsX2TtcEIVjZ1l3scTbSV66EGulbqcVp6uDpvKzblwH9osjIiRUc8eJWZwHIuLk
	e2IThYzd0M5H4p4bSKrrRpvnpb9uMkRt8f+Yo8DgYyBlRB7JDVda20JX3NlOxFD5G70y3XAOYtz
	u5rkHO6AYhEO8YHNeJMvyFIXZNajr4VAI
X-Google-Smtp-Source: AGHT+IGaXCp3iXbFfvdzWjy19MkdsX0WMpXD1ostEPx4tu/T5Xn5vpatIkn/c6mAwYBFMlhrLBrFTA==
X-Received: by 2002:a05:6000:2003:b0:3a4:eed9:753a with SMTP id ffacd0b85a97d-3b768f1f1f8mr2202991f8f.13.1753357059579;
        Thu, 24 Jul 2025 04:37:39 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb84e6sm1872425f8f.61.2025.07.24.04.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:37:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: hwmon: Replace bouncing Alexandru Tachici emails
Date: Thu, 24 Jul 2025 13:37:36 +0200
Message-ID: <20250724113735.59148-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Ch+72Ib5bWBMgAR5Q8004SEwup2pKwdP0I1CdDoDi1Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghr/GnjXzvQ60wvCOq0vNu78z2WriA1n8XV2W
 gkstNWlfI+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIa/wAKCRDBN2bmhouD
 1yCXD/9REw52ljejZoRLYQ7RGRHhi307FZCvpUqHgJWF00hZpXNTMCEmEFGjekCaJnmkE+h/WqP
 ZEFgO5NRF5iWFTOxiqE+GY6Q+TZ+kIJ/ZJQPYOYPkG+UdN73/DFHAYHsE3uLwv62uTkw+AytxVR
 9jPvJOG/edKURpzOFtNNL0+ur24aMldu3Csm5hkEtSVf+l2zqp43J5YcZO/mgLd31VBBSUh4d2r
 bD2HE5uJCFTTg/xcL5yQ2Rlv9vNxPRmajXdHrLh3Mor5KaiBPhwNCxribQCqFCenGfTOQJh7q3h
 fj8VIlaeW7nopamV3/+mJ7bG8tiJxB5V/1SKXpXL5SUBuDLFNVT7gK1kSzFAAripp/XC/rYvM4n
 xv/6tHMVusThs00SDywSM117/JE4mNLlHuZFqUXiLeLn/aYGJE9gWcvKN6YrCtIUJNba9ZRKc54
 pts0BEHTfBJg7LeYxU+0clJ/kEJmwN4xnoCPnV6NB6naQm2sxpqKab4fS753oqxw5dg2nI+lk+i
 KADrjGMJP7nwjlAz9O/YvNp7UepqP2sndQ1N2NO/uyN8qePS2nnOOiWO3dLxVKMsrS60yJ9qU8p
 q542/LqB3c8FN0Ng64pVyvGpTAHznAvlP9n+zYGHQSSc0fljlSPFOKWxXbR0skY9t5+h5EflOar 1iNPaJCd8pnW6qQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Emails to alexandru.tachici@analog.com bounce permanently:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

so replace him with Cedric Encarnacion from Analog.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I don't know who from Analog should maintain these devices, so I chosen
author from Analog of one of last commits.

Cedric Encarnacion, could you confirm that you are okay (or not) with this?
---
 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml | 2 +-
 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
index 4f8e11bd5142..fe87a592de45 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
@@ -8,7 +8,7 @@ title: Analog Devices ADM1266 Cascadable Super Sequencer with Margin
   Control and Fault Recording
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
 
 description: |
   Analog Devices ADM1266 Cascadable Super Sequencer with Margin
diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
index 0ad12d245656..38a8f3a14c02 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Linear Technology 2992 Power Monitor
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
 
 description: |
   Linear Technology 2992 Dual Wide Range Power Monitor
-- 
2.48.1


