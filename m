Return-Path: <linux-kernel+bounces-735492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C197B09017
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A607B358D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831DB2F8C34;
	Thu, 17 Jul 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="HW3SepBV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C2287504
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764539; cv=none; b=PQ0X6i7/QqkUA2HDaCeHVgRYMRmVw+S/UGlKYuJlxWbzd9VxUP2d50i14eWmteb5YeR2dg2vh2ftbRwJu14fvbeTLf3uoZUKoX72yoTwGIJ4uLxUcNjP+fTAOJ8jXkPDsL0lm53AVaDB1CfubkyP9nTtdBFyG+zpMLTse4vpulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764539; c=relaxed/simple;
	bh=H4LIa626xEOLlaxsQS5X/nt+lLY+d/ck3xmY4NV9Ao8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OyBUUOr+J4B/Kj6gR1siSDtaUHiuVfCpn2mdvCGHmxvu6MhELq0jhR+U6QyGIFSc5B3NKSTNohW99mkeq9XTYACkFcQBxgetdiE6vLyP4Lq8fSLkozUlhVW/KJWEl5V69R/UXbRu2kcYFSNTXoAGXXomJPh5q6jY9NDQoxUsspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=HW3SepBV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so10875555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752764536; x=1753369336; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzrbU56K5IfJP3PpMJ1CGzGqrCG/8v9FE3MJTtmSMiU=;
        b=HW3SepBVb2jPHjk7wigB21HcDE9ZN63poWuscQDMPknvcYw7753woER4JlMdKQzeMf
         TXR6KhW8D17W0nt6pEAbKdbeVwuwANjE2SD2RWOVr8WPRnCJa3KGbB2Lis0PgadcLLnd
         mmQqUgSzpxtc7Ry4lm3NRiUqheaxdPo9KE21v8QIZprq6BAIxxLzn4KiF9pw+cu2AMUA
         JmpzblvRDLXs18g7qX+wxstlWH54IlwvbMYDKUQl6CXBidKEBG60rVHpeVzv1G2ss7H9
         6DGOPJIBhA/Jdc5uy/4GtJut/gZNQPN+3fI4SszDoJOF2IIhAIaPyYMNmTgmamacbeMf
         UeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764536; x=1753369336;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzrbU56K5IfJP3PpMJ1CGzGqrCG/8v9FE3MJTtmSMiU=;
        b=hMqDVbz3Raigoo7AZcSH7bus60pNREfPdf+LITP1F/sRHqaU6uWsbOc82o8fQ2HAIz
         XZiAi2MzW9GQIRd1KCXIS9FtB7MuDLMyWWlDC+7c67o9bKBJFsqMeKxSguXt1zlMa+6X
         Y771bkX3hVtyz0/p9p++g9PiPUvW0BUJrikSg2V7ncjnA0eLvf8JRhKRrGRQR6m0+R2m
         PMI8SJFBELlzpibSwOGPhhwocDVBrRcXsnH4WBC7/wfWE9ys//9aotqJWKLl1ncZSunR
         7gdncduzICOD62Fw84WlftTGYwcAOCDCGJszg1L3Yi6JxyklIOMrJbaePpPi1fH8X+r5
         3NYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7VblfqlqC4CKAYH2QzqPbalmXXpzEM3L5dF41lRzGpZOHArKn2k2o57vh9st6n46nnP+yb2PUfVV+H6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Z9E4XnRrPqG9+UEXa48BubmW4GioCVspDvtK6BGJd0Z8HaG8
	TgZM3vnMnUtzFNh+e3DXTUX71Pb+MI7JVYDPU+l/LW3rdztUN6TIwAgu8ZefWleTnMA=
X-Gm-Gg: ASbGncsfgTeJ1bv+MhLXY8rI7JBCBaE8/7pdR+5+Y5YKBaRn1aubuaUSTHyUr0DS3Qz
	QQRUqWqCTp+8W3ycr9++Xl9CYFKMUZfYi35X+GvhNTb5kEwKzT0goKub0q+q8+ggerWja+HJwRA
	fpmW42d9JVfFFwbkwg5TF2vC1JlOdVdk00DM7kLJfOU+ZrdcumntP1wT4kn5f/OUl7ehHUNGBlN
	y7Z8mzyQQ2/CXY2bmIUJsQgRRbPWop6b3r9o06Mdw7UDu/xMC+XaKyTorL93xqXb1nTcUbDVWgZ
	MsQsNPuM5VV21Yfd6H4IalwboZLQJ4c7+eDPLEMZdqC+Qt43Jx8p0KD9gOlvON+VbBmepEdKY0+
	bbGNwERh0Mv56imc2qIkSm+giJoXw/RpwGHCXmKw=
X-Google-Smtp-Source: AGHT+IF39igwziCAqdOnTt08sRDv6h+pXbJCOVP9ajX8pMoDL7itBz1HPlCLRa7pOM6cyKs5zI1mBw==
X-Received: by 2002:a05:600c:6097:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-4562e37a142mr63015855e9.6.1752764534621;
        Thu, 17 Jul 2025 08:02:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:ebc8:7ccb:ef04:4f83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5cb9bsm25321885e9.10.2025.07.17.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:02:14 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v4 0/3] Add support for is31fl3236a LED controller
Date: Thu, 17 Jul 2025 16:02:06 +0100
Message-Id: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4QeWgC/2WNQQqDMBBFryKzbsROTCRd9R7FhcSJDpVEEpUW8
 e5Nha66fA/++zskikwJbsUOkTZOHHyG+lKAHTs/kOA+M2CFqtKoxER9Epzk1U0Spe6ENNYpdEY
 b20CezZEcv87ko808clpCfJ8PG37tL9b8xzYUlXCaXFMbZUmr+zLSEEI/kx9W9qUN5fqE9jiOD
 x9nWVe7AAAA
X-Change-ID: 20250625-leds-is31fl3236a-39cf52f969c7
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
 Lucca Fachinetti <luccafachinetti@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752764533; l=2437;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=H4LIa626xEOLlaxsQS5X/nt+lLY+d/ck3xmY4NV9Ao8=;
 b=8nn0zcS3v07F3mGen051A6nfQgycEIbgF2T8tAyxDQOe1LoH+6QEjGugKFbGyrn4JvQGAMKZH
 1K9TNRZ81CPCnz2By2ZfgBmC1BaldFLuDs0gzCXwsHTKuA1058B5nQn
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=hHrwBom/yjrVTqpEvKpVXLYfxr6nqBNP16RkQopIRrI=

This series of patches adds support for the is31fl3236a led
controller. The main difference between this IC and the
is31fl3236 is that there is a new parameter/register that
moves the operating frequency of the PWM outputs out of 
the audible range.

To support the new register a property was added in the dt-bindings,
as this property is at the board layout level ie. not all
boards will have analog audio and have to worry about it.

To add the new property the old .txt binding documentation was
ported to .yaml format. There was a previous attempt to do this
in 2024 but the original author has never acted on the feedback
given [1]. So I have implemented changes requested in that 
review and added his Signed-off-by.

The new functionality was tested by scoping the PWM signal. Out of
reset the IC is in 3kHz mode, thus action is taken only if the new
boolean value is set to true in the device tree.

[1] https://lore.kernel.org/linux-leds/20240701-overview-video-34f025ede104@spud/

Changes in v2:
- Added cover letter
- Ported dt-binding to yaml
- Refactored driver module
- Link to v1: https://lore.kernel.org/linux-leds/CAA6zWZ+TbcHrZaZ0ottm0s1mhCLa8TXASii47WKSLn2_zV95bw@mail.gmail.com/T/#t

Changes in v3:
- Aligned/refactored code properly in C module
- Refactored dt-bindings yml file
- Link to v2: https://lore.kernel.org/r/20250627-leds-is31fl3236a-v2-0-f6ef7495ce65@thegoodpenguin.co.uk

Changes in v4:
- Aligned compatible strings array in the C module
- Addressed Krzysztof's feedback regarding dt-bindings
- Link to v3: https://lore.kernel.org/r/20250708-leds-is31fl3236a-v3-0-d68979b042dd@thegoodpenguin.co.uk

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
Lucca Fachinetti (1):
      dt-bindings: leds: is31fl32xx: convert the binding to yaml

Pawel Zalewski (2):
      dt-bindings: leds: issi,is31fl3236: add issi,22kHz-pwm property
      leds/leds-is31fl32xx: add support for is31fl3236a

 .../devicetree/bindings/leds/issi,is31fl3236.yaml  | 120 +++++++++++++++++++++
 .../devicetree/bindings/leds/leds-is31fl32xx.txt   |  52 ---------
 drivers/leds/leds-is31fl32xx.c                     |  47 ++++++--
 3 files changed, 161 insertions(+), 58 deletions(-)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250625-leds-is31fl3236a-39cf52f969c7

Best regards,
-- 
Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>


