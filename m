Return-Path: <linux-kernel+bounces-681696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19268AD560B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA251888448
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8A283CA2;
	Wed, 11 Jun 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XBQApjA9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616B2777F9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646459; cv=none; b=r8QIl7owr/chodGGdQg5o8Z92b09nxjFENuaJPcL3HLyW0ebFo5nESWGz8WgJuJllBU8e+wJx6ydGiyVbrkAaguhELc6uRf6APAQ8CMcsaJYus5N6C53MXT0a4WvN2gW4jjiiOWXpwimzFxAhOH+M+4klMsnBmf0/E8HCz58XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646459; c=relaxed/simple;
	bh=MwCg4L2h46PDOS0g7q2n/0TFp7dWTy5pPJdpMQqZbyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfSSVv8447b2ZS01ZK0zEMjRopNYWYLeQheYkBv7Xh4yfJ+Qw3GifSqGPkLm5JMY3xTF7fEZEMsYHW2jwOfn8cd6RO3hTJlH8AK/N0yI8Ug08aTXv7nYv5MHn5ZQDGnm47M5tBzmksY1bID2VRzC1ZuTZsp3NhLECyAmVnUacd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XBQApjA9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54690d369so3021969f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749646455; x=1750251255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hcVPfIPjKgnN/jxAK+0iuHy/Mp3frsm9eTH/rmctjg=;
        b=XBQApjA9RekG+xDMVRNFPp2xNja5Up/nP/YwFZRyqyXHHjF9i7dZWni7ctlNg1adR1
         j7KLLjS8rkziSQHvNl2S2dXMYvZdhmzb+52lxj5ybkpouwLpVrhheHi+ZQ4JxRNAxEq5
         evTWdkZ0zEwR7Ta2IKeAUFAI0RrZA/EUjKUTNE5vkpK55/woE4eIB+QRRny/DYPpe36r
         shDhpQ1+dVY0o0tURicTe6MH207nydo339rRWXk0uG06vK3NJH7kwap8vTq8jiD6g+dY
         cr29Q7Q0XSdRqq8broFa01XaR6Gf4mT86Xo5TpWyPrlwwlx3B7OhTgyfT0txU4NXyhwt
         OiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646455; x=1750251255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hcVPfIPjKgnN/jxAK+0iuHy/Mp3frsm9eTH/rmctjg=;
        b=BVZdnEEdHmc6ZtITLIDL4V47xQ9sJLA0TtapbhixBKtWEDHZAzFUzNco9dclDZfFNH
         R2YWEGgkrnSENvrES9C/4mpBzYRlEg7OfJ5VDEtcs7wRv4vPWs4q5AWhD3UBeXBML8OI
         yowZDoOJzygMkm7dfW8FmXtVvtYVy8ROElog99GhsxdcRjd8q3OpNZmWDFID0BX4BrxB
         jSWK7KFs4+YhjUbHXPhUKgwrU8qb4zsSdZxYVBKa+cfm8Mn3BH0AgoLBMtPjDJxzY3WS
         abfCcP3XsDRa+sZcL34frmUGjUUniJjnTEwJ8EWYEtiw42wi/0pxRtr6tNIXpdOtqEdS
         FSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVup6o6SpY1AbJJvVaQmjdZj8jcGKm04JbnMof3+buRI7hDVSVGismBXCrJ6KJ2wLoSicNoOv9OHBQXGCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaoY2xaOlYnXsAOISLitJtUelD2pxktIPd+6oLabxPzksdwzP
	7bx09de87a8FJ2lHjAr3PxVTR9cEOHTC0AL7+CJbVuBI+9oNK69xZf+vErdYxa6yAQY=
X-Gm-Gg: ASbGnculCAezv59XsEu5hH0YTw+efAkFSKp05duydgn4X21yHVXY3Ia/DuMEifqXkIR
	pwp3IrOT+oba0C2E7Xpv9RkYHgEovyccI+iWf7ZhNmUOVOll275npcJ5Th0g5gLJomONmBEf6wq
	nkcZXKu1uSZt1aL/1ntVEbPJ9IVbSTTb6CTvl04gKxwNo1Jqza3Zyf9pR/+U2o/HypkVGGPKzNH
	NbOEYEucLMb/j55OVPVie3tvhur4xyfP4WNP70Ni3mFNLY2xADAlUHh8MtKiZxi4/b6VPrdmgEh
	amqjfYTAXXh1KvkwZB6NpmuP63L2IlUlus2yY8j0x6Yg1avFxl6RRrsxMycD/govOGxXvChTkCt
	g
X-Google-Smtp-Source: AGHT+IGrOsdxa4zJCbGnTi4fEsX+7CHAps/JT+rDRqNsXkWOF1cXauuh0d8YfM1q6aZsNyF7ST0Luw==
X-Received: by 2002:a05:6000:1448:b0:3a4:f52d:8b11 with SMTP id ffacd0b85a97d-3a5586f1905mr2571117f8f.20.1749646454734;
        Wed, 11 Jun 2025 05:54:14 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ef3:a82f:ccaa:91b5])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a53245275esm15225486f8f.76.2025.06.11.05.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:54:14 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/4] clk: use the auxiliary device creation helper
Date: Wed, 11 Jun 2025 14:53:55 +0200
Message-Id: <20250611-clk-aux-v1-0-fb6575ed86a7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGN8SWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ND3eScbN3E0gpdA0tDs1QDMwvLJMM0JaDqgqLUtMwKsEnRsbW1AFE
 JXr9ZAAAA
X-Change-ID: 20250611-clk-aux-0916e0689b1f
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=MwCg4L2h46PDOS0g7q2n/0TFp7dWTy5pPJdpMQqZbyo=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoSXxt57wn6gj2MMaDJqXctxiVe/tEY4F+6WgSm
 BnehdmmFCqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaEl8bQAKCRDm/A8cN/La
 hV6kD/4mGMjR2Csvf4Ac7+0h9kIkcrt+1BCIsyu7vwlVO5wjBbzWtmF7BE6DQqByhYj1kk2WBcj
 y167kxXU9BFQ41uDY1MCnyPCp3WYUj3c+RR93vorROw+S1ly382yPWEBrE8uhY+rHiiBTrdOwsI
 h/SJbofzfUdCnCYA1Nzj8mbOnR/F0Le8LFdXtcHEjXvHu7tq9YJg64XwjXCQ1NBndkGclowoBQ1
 YXn9L/WM6qXhVilWbeMq4pDMMoE2EKP7gIuj93iNbtuHqqSyTPTJBCbrYCXSVaJ8KOwKRzf/4S9
 KoiKe+nPFlHxM7fCBW65F/BrfxwBqjPhp7epi9iZvqIFg7OlDW69nCy+UogWg1lb62tAIA5lEjT
 kf+omgPU5kR9UgjbG34eKbe30yHput+jherUVzyWZAWJENmL3uEOt4BoTV45navcvdaIBPdJ96W
 8qq8vlmjdnwPqPZDOBj6/tPBre4GYpgxDIwrhlwRiqTrxRKlHe0V8yGGewu5ARh3Zu6oTVZrRCv
 pPJr05s++w6148vJUMNhFcTkuyQpIKBg7Ca+Qyt2Bh0YxKw3m+KF3YCU6Lr14zr6RmYPD1S8pVv
 0+xW+vylPjCd8KSajuG7qkmLX2dzHXoY2NDlPGSG6DcicgVxfEMbtP7apQ358uzjYH1c6uSy0mn
 RNqdkBmE81/FQ+Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This series is essentially a resend of the clock related changes of this
series [1] sent a few months ago.

The necessary auxiliary bus support has now been merged with
v6.16-rc1, so this change should be safe to apply.

I've included the reset change from Theo. It has been reviewed by Philipp
and it is probably best if it can go along the eyeq clock change to avoid a
WARN() in reset.

[1]: https://lore.kernel.org/r/20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (3):
      clk: eyeq: use the auxiliary device creation helper
      clk: clk-imx8mp-audiomix: use the auxiliary device creation helper
      clk: amlogic: axg-audio: use the auxiliary reset driver

Théo Lebrun (1):
      reset: eyeq: drop device_set_of_node_from_dev() done by parent

 drivers/clk/clk-eyeq.c                |  57 ++++-------------
 drivers/clk/imx/clk-imx8mp-audiomix.c |  49 +++------------
 drivers/clk/meson/Kconfig             |   3 +-
 drivers/clk/meson/axg-audio.c         | 114 ++++------------------------------
 drivers/reset/reset-eyeq.c            |  13 +---
 5 files changed, 37 insertions(+), 199 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-clk-aux-0916e0689b1f

Best regards,
-- 
Jerome


