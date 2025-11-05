Return-Path: <linux-kernel+bounces-887251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEACC37A87
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F58E3B3B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857B346776;
	Wed,  5 Nov 2025 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="moVWB3Mu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062593203A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373658; cv=none; b=faV3/3/wbysNbkJfo7Bvxv5HvFjlLMauCWH8LBRrdn7paWSOb3qUXII9gW9DiGXGJGxxIb6pBEDxMqAJ9e3MUaSlf5eit1+s/FWbxtZ0Oc2jxecH4mjX3WPaDRnU+hXXj1f8NKiuDbIfbE33Ga4NargOeE4qIpE7Al93wvHSyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373658; c=relaxed/simple;
	bh=eQJ0NUzQ4ouuCS/Q0tnfZ0GPptT7scZ1wPDzcolXdoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAZGIc2NoQXN72Iz1lQpfICUEut4TiG8ph3R4u+swuuNuqp2frfH0/XJS6/2Yjwu/3GZtVpIhMfzvSIzs1iEqFutAi0bp5CJ8BZBMRvYFD4JlT+z/m/ZUJY158AARiD0x09wtN3W9z1qNbrgMsMbwkdX04UpO9NrPpfsm2CvjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=moVWB3Mu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so3800635ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1762373654; x=1762978454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUOzNM4gKoG/nRwrmhCZsy6hSW9BT7KDwKYG6RCeAao=;
        b=moVWB3MuAbvIjFgmcK6v7CDE7VVVEnu4lfltQcA6iCLapx376Tccr80VOZQUHEwB2m
         C6w4TsgGxB4i9zdtnEEHq0WD7Xa+8+jePxG+WBg29a/fOZVKoiOAFKPneESrCBOrWKl0
         mNckgFBi1Wn73PTiQ7RWQGts2SVAgwWegkV08+IaOhvizkNfPoOnPvQWWkEHWJsp07Xn
         //MBjKTnNePN+cnDTR4XZA7JirtUtk7ujXrv6nPTYZ+frvQTuSPVRY7gjHe39HGRCiS9
         s5mGGbquwIkBSEsm5BWf1GyH/IaqCg6CPIXkyp9Qs4YACryFghstbcAspPMaq7Q/NKL+
         dolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373654; x=1762978454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUOzNM4gKoG/nRwrmhCZsy6hSW9BT7KDwKYG6RCeAao=;
        b=WcVtzD4XRJFpRPv6bWdjAPAC18Jaqx1IYylcWbs/DPO6ttxVRi32QElaxVR9MSCUjA
         EmXXDDFp+t4+gyBGbq5UiHVIlmuL16+kSRWR88kzlVnz2aaIflqxObZ2QtqZfeS6W4+u
         8qjVU031Cha9VY5RpAOT14aX2ohRjPVEsOYwqgWrnhovSXstiJMfJSe+x3tknxxoZDaO
         BknrJS/neuPNEsB3nzmhWT2J3g+ngN9soMVLeMUPHCnHedANq2Ibeec+eyMp8lODuIiJ
         PqLMUI5j6aTEaXbCmiF3NLzQm5teeQ8xfkxKs1vJrLQJeiXxC+4OE9RGLMlmoDG48HYn
         Rehw==
X-Forwarded-Encrypted: i=1; AJvYcCUKJytjwQQ1MJ+6gIzy5L07NnPlC9hYKPkewAIUjeJDaHIXLQ2DZfRAud4+Xx+G8GfZzq/CzT8RSqwro+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsS7Uerj73YiO/dO4HPH5Ay3LFrVfh5SvsuXcnSYiQDdwGZgZ
	NjI0BF8t39froSm5yQd5jIPSiJrMl5Y8Ru2KWhzkkcKgV1CMYG8AbiQ75jbimsh2bFc=
X-Gm-Gg: ASbGncujJpe5zNBXpxRrWanD3M27eGnD7tfNmPmZK2q5BUl55q6fqMEP4J5bX0wwkk1
	Vq0KG4XT5HOwbCNs/ORfyPp/RzrPZCSL/hYAxXms7qM6RMiAQVRgiREPp5DTgduAiuWQzuM8Wj8
	jY/mlDSUC3XhQE7iJScBi6Di413DM+lIFFtYBFZ8UQX8LbMCI2RoVXVHudpWIEMvc5mQ6xURBE+
	d+ZNUJULkAElbieWgUTFhCo+anjADh4uQ3DZ+i4Jk/m3KWR311fcuBIs8V5617BHXiMZyCUlzpb
	oOEVNsZn5oKENpBj8Ox2YQ1S/KmjErxCLE2uZz3DXrdo3Zyc3jSHdKbAM5hAwsFFa0dJJDK2+8t
	SSIkpjjFXH+WqFoXfO1ogOBtMaOzUZDmMHJy8s9queN882UXFhanwMErYPbiUXFxuHPhEirW8LN
	Oc7Dh3no4=
X-Google-Smtp-Source: AGHT+IF4VrvhJWTj6Cx0+TOg4nCOWZFwV6Zvxic2/HHaRzt0NXXm/XIrkK1LrIxEIQcrBWb29lht3Q==
X-Received: by 2002:a17:903:1a07:b0:295:395c:ebf9 with SMTP id d9443c01a7336-2962add6154mr64000535ad.55.1762373653983;
        Wed, 05 Nov 2025 12:14:13 -0800 (PST)
Received: from z440.. ([2601:1c0:4502:2d00:3099:85d6:dec7:dbe0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ddsm4039435ad.5.2025.11.05.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:14:13 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v4 0/2] hwmon: Add TSC1641 I2C power monitor driver
Date: Wed,  5 Nov 2025 12:14:04 -0800
Message-ID: <20251105201406.1210856-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the ST Microelectronics TSC1641
I2C power monitor. The TSC1641 provides bus voltage, current, power,
and temperature measurements via the hwmon subsystem. The driver 
supports optional ALERT pin polarity configuration and exposes the
shunt resistor value and update interval via sysfs.

Tested on Raspberry Pi 3B+ with a TSC1641 evaluation board.

v3: https://lore.kernel.org/linux-hwmon/20251104003320.1120514-1-igor@reznichenko.net/

Changes in v4:
- Updated devicetree binding example
- Removed unnecessary check for !current_lsb
- Added clamping to current val
- No extra calls to validate_shunt()

Igor Reznichenko (2):
  dt-bindings: hwmon: ST TSC1641 power monitor
  hwmon: Add TSC1641 I2C power monitor driver

 .../devicetree/bindings/hwmon/st,tsc1641.yaml |  63 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tsc1641.rst               |  87 ++
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tsc1641.c                       | 748 ++++++++++++++++++
 6 files changed, 912 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
 create mode 100644 Documentation/hwmon/tsc1641.rst
 create mode 100644 drivers/hwmon/tsc1641.c

-- 
2.43.0


