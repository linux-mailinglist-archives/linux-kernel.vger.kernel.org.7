Return-Path: <linux-kernel+bounces-742247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F518B0EF20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A0A3B8439
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B02277016;
	Wed, 23 Jul 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="gpsLYH47"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782B284B3A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264936; cv=none; b=KftCyRcBZVQqBVPg/QQ72BSd5bSGe/cKcwbWdvRodYCvdUzAwSSpSOhzhkLSyaEJB9P5rohYTJIQJFtzulc0Zg4pVRB/06sFl5A3jCWtOOlIY2mbpKGXjd6GH/2IRRZBJz4Ra3IvfKG2tFq9c836yXFcPxXwAHx5Y7prwQTfuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264936; c=relaxed/simple;
	bh=M7k6HGHbLNDcfMt7ufc++GG0yZJCwUmbddAumfs7pI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hUKJKRA7Bf97zXqhuz1Kd1WQjH4rvUNWWZB213fvCuSIYe5ZkKpZ9haqsek/mf6j5p7sQAoW1XQQqytpKXmHgf4e+1hpXFWM71KlpEeozuJ0eRjd9kG5/bbQdtq0qW7Z4WdzaNSSp8MBdnpLIfGf3aoEgUnGHPJ542CtCSQQtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=gpsLYH47; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so446338f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1753264933; x=1753869733; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TI0xw4syhkkFFe0yGcn6l/WjLcDY0XkS8aZc6TEs3PI=;
        b=gpsLYH47q3EqvfV21eBwHrGmj+TKasSRGE6X/3uTF+2c67Za5bgS4tE6SR4RXevWdF
         HdlfLHfJmQSCcF6oG98H8zBzlrqxlVXo5YDTEX4Z67mmQwTzzdJ+pyzgLozRBDs5DFtZ
         bcwD81wmOHyEkeKo8Jor4EfV6K5b4FrruK4iCLU9MZcA/zz3j4bGo4MMkoXaCkJGKHxY
         9xNrHKe44pchsPrSasT/ODivFRQI4W+0UF9OWauJIw2NOw+LpCNC/dDId/gA8RN0isZ8
         a3HLIJ1obK3pGUuTHGjEVMObW8vHDTikqI11YH7miKf4toN+K+0dRmOcyBkg1iNtd/gE
         Wy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264933; x=1753869733;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI0xw4syhkkFFe0yGcn6l/WjLcDY0XkS8aZc6TEs3PI=;
        b=UQPiE+cckOuhHdKdMgHdpQ3JnqPjgfJgmaTFYO50DHPwyWb9IJZ1ZHhnRN7fZfaTeg
         IuNQF8vRo+EV7NmTkccdod535WkuSElkjuhokN9zfw7q/oYIHI0r+4VhYHtVR6sRsFZl
         /63WbiQAtPczeZpIFKu3UUzzC7ysH7wchPDEEs+CCY6UHiS8r/RShU1pNGC/5VV3zZgX
         swxNEzAiRDfAx7TBp20MNFQ6rz7G2SXJQxB7arzC59kH0aHOmq+dlkF8/D+FIiUnaT53
         pwrvgH5Cqm7TAQzb8wZcPgnggylHwqZkCRCUyBhhUz4egjCRCyH0B4ihGALAGAZVUKpI
         BQGw==
X-Forwarded-Encrypted: i=1; AJvYcCUC7gU5ZyPVmz6NWd8YDTw57PLL3+eXM3P7f8bm6VyjvW8QhLnpsLmXKwUL0PwPQ79sOkNJeCFrYXeBJuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+urQqTpjO29D8ReIFP+dFf2SrMTQN9KQ7WZQvJeZoEjonkkJ7
	9EFD17+Dqj7J/h9guCzpUkmAXDZ1cZtzj2WSYfKa/Bq0q1KfTU+/Q5qTJUluAIiLEVU=
X-Gm-Gg: ASbGnctopuJd4rc/aKgG3bNm7yqL12f8K2Xcy2QXjBABB0Xwl0vFOIVnp8lJZOhFt3Z
	ELMqH/DRxjDuvU8RF3NwFjmeFTe7hD6tJD1rmTJ/RJ0IWE2Cb+fUomDghgVsP4CSzGuyZZ4cQun
	MVz1BJPIRnjTB5Dd5BhDV8u4UEq656vk1YEy5Yo0tY8+Z6QRLFDHk5qF+An3cSKs1EdpI22masb
	jV80XKZLWD0Wd+37d1RXISklecJZLLWwJOq0aUK/4y7hbZ4XxmPhC6YZtj9ipKEE0W9dEHroNKg
	pTX6IOwOMR//dbfNvOHDVcKLA/rd5qjuXRKcyrp11SQS6IPNQlB1FBQV1lVkgegXg5ZoPMXzOFJ
	ggRxGZ435dZaC8EiGHrjTp5Hyq7AeWL9JvkH79w==
X-Google-Smtp-Source: AGHT+IHwIu9NK9Fy7AYJ/x5gw0hMAgzLL/HsK1x+k6KdZT67CGPw0RMLKSKFsCnrrSCZkCT3A7a/eQ==
X-Received: by 2002:a05:6000:1a85:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3b7694b7866mr1793071f8f.2.1753264932794;
        Wed, 23 Jul 2025 03:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:6066:6737:c27:90a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca31394sm15930793f8f.37.2025.07.23.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:02:12 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v6 0/3] Add support for is31fl3236a LED controller
Date: Wed, 23 Jul 2025 11:02:05 +0100
Message-Id: <20250723-leds-is31fl3236a-v6-0-210328058625@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2zgGgC/33NTQ6CMBCG4auYri2BoT/UlfcwLqDMQCOhhCrRE
 O5uNTGaiC7fL5lnZhZwdBjYbjOzEScXnO9jqO2G2bbsG+Sujs0gBZkqkLzDOnAX8oy6HHJV8tx
 YkkBGGatZPBtGJHd9kodj7NaFsx9vzw8TPNYXpr+xCXjKSSFpYaRFJffnFhvv6wH75uL6xPrkc
 mIPdxJvS2drloiWBiQjVEWVLf5Y8sOCbMWS0QIlsBAZibo0P6xlWe7NNyBzUwEAAA==
X-Change-ID: 20250625-leds-is31fl3236a-39cf52f969c7
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
 Lucca Fachinetti <luccafachinetti@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753264931; l=2948;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=M7k6HGHbLNDcfMt7ufc++GG0yZJCwUmbddAumfs7pI4=;
 b=IKeyu26nukZ5bUbll4mS+8EdNqiFIjwLknMhH8sVV3OddhmNTtVHBU2XoawGiWTIWuCS9N+Fs
 ojDgfYfRzq3CKzUgX8jaCDY8wG4pLVWVCzaGV8qIyLIi8lQumQSwExO
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

Changes in v5:
- dt-bindings: fixed typo in the regex expression
- dt-bindings: rebased patches to follow common sense
- Link to v4: https://lore.kernel.org/r/20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk

Changes in v6:
- c-module: capitalised kHz to KHZ in the define
- dt-bindings: removed capital H for Heartz in Khz
- dt-bindings: made pattern match the range [exactly]
- Link to v5: https://lore.kernel.org/r/20250721-leds-is31fl3236a-v5-0-264e841f4da9@thegoodpenguin.co.uk

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
Lucca Fachinetti (1):
      dt-bindings: leds: is31fl32xx: convert the binding to yaml

Pawel Zalewski (2):
      dt-bindings: leds: issi,is31fl3236: add support for is31fl3236a
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


