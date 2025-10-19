Return-Path: <linux-kernel+bounces-859621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2FBEE222
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A0B4E7C90
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D6C2E1F04;
	Sun, 19 Oct 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzMaVwpb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965592E1EEE
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760865848; cv=none; b=W3OE7GruVvyOFewN513lbNOiUA5lf1Q3vieh7OQBHfv9/c2+n3DwCXWm9dIqtDv572R0aSfKRByn/QaQ4vg5nOleMPLpLZCn5rd+L3uFSoF5TbFEb+c7+Uyhl7sMtsKcrzE3N5+fnylPxB3h6uYa5JeQQPQS04ieZFAJgg2LHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760865848; c=relaxed/simple;
	bh=YjKH19Yq3Fp9AlljIlHbdYrwAgfw//vNWx0Hx8pBaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsvesxgXWgBRdknDIIKhXq0Flg9q8JCmfmgqddvVI7ugD7r/sAex5dKYASSgeRFO2/CpzIionVSTlKQJqascYMmesnFODOBt4oseh6kKa95GIt2ZkmIQ7IFFWb9ndKd0VWxpv1rn0WRZEPSo7xDggmwfYRIiEkmhJJ2ZvKzW0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzMaVwpb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f898fso48878025ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760865845; x=1761470645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ldueyFiuHDHfmUi6yqXFVlVFpGrU406mJEGOuagBkc=;
        b=SzMaVwpb2D17HeZ6iCGJLU+0P9FpslkEBSwDz/ZymA6/MpuZOETTHuUtCslTff/tdr
         oKViPqQ0OsMznSjcxB+C9j563IQrM7Jhk6AQmgQTgAvyW72recZiDWuJ8R21vw8ZK33f
         sG7eoyM7bhev3buD6ErV+XlgJOgs3CkPmG+fGjJabH4oI/ue0NCUZb9nR8PEtEQQ7B1J
         1vONNFgaCTbIlzwLfbMs3Dd8YL7MqUmJ+Mfq7hZdeh7npq/0tiI0tFl7CgaYKRKXYm9K
         ebhuD6aE68b4GdVvcSxxIMW2O/dL8RKAfxJwovV6h+7qnMSNKHhOBPsI+WhqSkWYfAYz
         H2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760865845; x=1761470645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ldueyFiuHDHfmUi6yqXFVlVFpGrU406mJEGOuagBkc=;
        b=loTKq/6osP/fwDu1aMvH554p+6H7qB0SOz7jnalZL5GlbDT24Shtfc8mAvg4feNRIZ
         MvmPhm8P1YyMlFZjRSdIXsA+GRZnGE0VTT2gsugA0f+XQr0EimEvuuW7WV+4gMf+KISE
         DKc5oVoP6XluPl9ZSGG87/o073cpDfmtIPBZcEaxHA/T2FOcdJ5CGo3fVm/0T4BdhW6L
         2DS78TOy0xj2lzXf3fEfVS4J9Fqa/Kh4hOTYeLkFVcRFszU+sHXmkxh5ju0eO4NCKinR
         qm+OIf3W5i/e4YV2eZsKrja/IJq6uTduk6v3lgvx4Rplgmiewkd9U5iAZr3mgCu8GIv1
         w0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVggFet38K7crIZMPHlXW0ffq4hey/FyTImscHm0vpjp/ZewVGhKzIVLKX5vy6ky8JNi7Zlt9VnFCQkQNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KLF7atBXQNAgLD/xJWe/2/LtfFqJCv47wfkaHrybISDG8ddI
	+Wgr1OOM12QKJoTq7W+GnG0NLI+xqUbnx7ftE1jntxNfnRYORMy1a9jW
X-Gm-Gg: ASbGncvPKZZEq2c9lMDB7itl6YvU7Bi66LHlEkjIgu262Ncd4RuvjjfHuTc4s1KpSji
	a9TM6ezzNDCPaO9xOtaeD8CzjRxVLcTO6bMKZdimGaIz4/yhzV75SsK30+f1wdW7WrLCIZUgL3y
	VRur+T1Zuu1vjD7jYn2YCVowJulpmvTlmM4+q7KVG8kFmO7usxBUO8vjKmU80WWdvvAQLzVtX+y
	c/+bLaYmdNrynmOybNrRgqBij9c3EoiTqfNELjosDbs83KTQN8d1GE8QQhWUJJk1Bwr3x/B/0Rs
	VCzE6ZFMAkxrahOFwzeSFiE2HEzuxB32/CDYIGsjni0A5k+clGdAr+E0IX1OdLZIWde8PMHV7yN
	VqVOzhE81jbRPbir6voAH7Qvjx+xvyyuWKTa+gOWsM9WhR/Y7I1r1iMSbKmDUbDZdp5NhEvJpVe
	4VXsGWcSPRUOIUX8QP0IzPPhV3NNMcrQ==
X-Google-Smtp-Source: AGHT+IEeXDzz0B3Eqj8HAvYF0QY4EuJNocnSfMyJANzR5gjTAyXUlR98V5VjK0fEW4mKbvUoBwTmMA==
X-Received: by 2002:a17:903:3d0c:b0:267:af07:6526 with SMTP id d9443c01a7336-290cb65c541mr124630905ad.55.1760865844691;
        Sun, 19 Oct 2025 02:24:04 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.99.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd215sm48313115ad.14.2025.10.19.02.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 02:24:04 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 0/4] leds: Add a virtual LED driver for groups of
Date: Sun, 19 Oct 2025 22:23:23 +1300
Message-ID: <20251019092331.49531-1-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Introduce a new driver that implements virtual LED groups,
aggregating multiple monochromatic LEDs into virtual groups and providing
priority-based control for concurrent state management.

Existing multi-LED drivers are primarily intended to group monochrome LEDs
into multicolor LEDs, allowing per-channel intensity control of hue and
brightness. However, they are not designed to manage grouped LEDs with
independent functional roles or shared behavior.

The leds-group-virtualcolor driver allows arbitrary LEDs to be grouped
and exposed as a single logical LED representing a fixed color, status, or
function. Properties such as triggers and brightness are applied to the group
as a whole, rather than to individual LED elements.

This is particularly useful in consumer devices (e.g., routers), where a
single status LED must reflect multiple device states via color or blink
patterns. In such cases, simple device tree bindings are insufficient,
as multiple triggers may activate simultaneously, resulting in color mixing
and ambiguous status indication.

To avoid this problem, the driver implements a priority mechanism that allows
higher-priority LEDs to assume control of the group. When multiple LEDs of the
same priority are active concurrently, the most recently activated LED takes
precedence over earlier ones. If a higher-priority LED is extinguished, a lower-
priority LED will become active.
If an LED is set to blink, or is controlled with an on or off delay, any time
the LED is inactive but still triggered, it will be the only LED in control and
will be extinguished during this time for best contrast.

leds-group-virtualcolor can also enable decomposition of multi-element multicolor
LEDs into individual virtual groups that can provide individual virtual color
LEDs, supporting flexible trigger assignments and precise status representation.

leds-group-virtualcolor can join PWM LEDs into the group with their own bindings
for each primary color this enables per channel dimming and fine tuning of color
of the grouped PWM LEDs.

PWM and monochromatic LEDs can be joined into the same groups sharing the same
grouped global brightness controls.

leds-group-virtualcolor can also expose a singular LED as multiple virtual LEDs,
each having individual triggers, timings, or other properties.

Additionally, traditional bindings can only control individual LED elements,
making it impossible to represent composite colors formed by combinations
of primary RGB components but this is also made possible.

Originally intended to be used with OpenWrt for controlling RGB status LEDs
so control of power, reboot and system upgrade cam mimic the manufactures status
LED mixed colors.
Often when a device ported to OpenWrt RGB status LEDs usually became a glorified
power-led instead of a status led because user scripts or binaries would have to
be implemented as additional packages to control logic.

leds-group-virtualcolor is designed to allow LED behavior to be
fully described and logically controlled in the device tree, enabling early
status indication during system initialization—without relying on user-space
scripts or custom binaries.

Jonathan Brophy (4):
  dt: bindings: Add virtualcolor class dt bindings
  dt-bindings: leds: Add virtualcolor group dt bindings documentation.
  ABI: Add sysfs documentation for leds-group-virtualcolor
  Subject: [PATCH v3 4/4] leds: Add virtualcolor LED group driver

 .../ABI/testing/sysfs-class-leds-virtualcolor |  89 +++
 .../leds/leds-class-virtualcolor.yaml         |  90 +++
 .../leds/leds-group-virtualcolor.yaml         | 110 ++++
 drivers/leds/rgb/Kconfig                      |  17 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-group-virtualcolor.c    | 513 ++++++++++++++++++
 include/dt-bindings/leds/common.h             |   4 +
 7 files changed, 824 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-leds-virtualcolor
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-virtualcolor.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml
 create mode 100644 drivers/leds/rgb/leds-group-virtualcolor.c

--
2.43.0

