Return-Path: <linux-kernel+bounces-850471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4875BD2EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A17334B8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724526E6E6;
	Mon, 13 Oct 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDK0rKNf"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51C26CE2C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357424; cv=none; b=oJuWjOwCvekHEDyHvCkrk71RmpXV5vgz3F/wIWs1kRJG7x/mw/Xgdiok/JKwPN4Fd6qrlaW2LCOgKauNTfM9bgvgr5zQwcR3QJPyuRuRfE4ELB/aYZIUg7Bf1mxu83V86K3qtQs6H6oIDRJtPdgyC1raFN0U9xCpxOYIg4BOb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357424; c=relaxed/simple;
	bh=j6lVJFrPyJJ8NbHjOFGDAHtGTH2KhK2nNhBNdQd9e/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNxvq9uabSv4EmrodlR1DtwYvU0WFkkr80c8UFqmBwFfw43pa74QxjNh78X6Cu4R4+gkyskjVq/e3ex8DpFVa4WNBwA0ehOE2RDiU974EvDRECrxRFoAFrJAAtrJftxMs71Yty74Nn+yFCGwNgJKSgC5v36zhylz90kaGBfJLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDK0rKNf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78118e163e5so3842734b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760357423; x=1760962223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptp+XhuJy1JrRQJp8XVe+0uvAcAnkcqXGFxFSwzB3mQ=;
        b=NDK0rKNfIyKRdePH/rwfh/j6pLv3SJ61J9qbvPUi8c4UhBtZKUc1BdKUpTZ9rfl8ns
         DrBjxt4NkJQaMM+2oBK1Z/l3CfxiQU1M61rP7lNp8SD/zer7WmcaRerDoUVgtkXgwL8k
         UpV2upN8KuApsM/bkn8OZdZQMn34+YoVEfK1j82nPoakIgQkRFJaxWAzhVm/KJATCO7T
         PabHBf+hi2gTdblkNG79gW4vWdhnxfZncjey4FXIIjSDBHv9/Pt1RC4OyIj0FS8r8ehz
         +ty2Ef8xOVJMHGaUpCWGEm6nlJCr8wwF3CAR1gK3Kya06I93BHt2abXAWbG1FHaFTgH2
         Z2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760357423; x=1760962223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptp+XhuJy1JrRQJp8XVe+0uvAcAnkcqXGFxFSwzB3mQ=;
        b=Iyq0kR+KVIv6dZ1gGiGsXa+kXfIV4DMCEMx4Varm+8dS/cowVR9fg6i1pw7GMTVfRt
         XAQGCkPQuF/gue1Q8IsPfUnAVvn2tjIj35HVwBenJgJDimdsp96WSNuRafmIwrWsa1Ml
         m5cDzHAo8fMm7mu5S7MPbBT953pVbPcot5InA2RCnG8Tl38B8lrZjyRW1QScSauSq8vv
         oXmbMQHj+2n4JoZUY1P280uEl3ddSy+2IiKY/w0gURE/8seF2YQ/t2qAQn08QMn5nA01
         ymq2PNtzuAY4pDhryszarXYMxNlQCOL+yVAjwQUJ+PdWqnsBbuUZ12bXjiJppSx24umV
         vCjA==
X-Forwarded-Encrypted: i=1; AJvYcCWtqaIAJSM2WK4m6KiQZaW4X8LA7h/Z2msG43eS994WkNAuNmn0GlY58oCtp5JnRrcxM1UDw08w/13kMaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4u4O1rfniDnoRYjbli9u0mtLw1h68z9G2dSnEW0M4T6XLNaa4
	vsYqmzYxkQffF6h/5YHya4K6FTR5zgJJ3S7lQkStXGyW4cb6aLwABNNh
X-Gm-Gg: ASbGnctiKD9bV3ldGcsbOl/sAnNsfdX+yh9i9KWhAVTrlueUgnpiv92MPHWXHhyIIee
	CciKOKdEirtU5mzJ0YavFcGQJyhRiYoZdhXFtEtMJDW8c8GVCPrbwwFhpQeQ5IWJowk0PDmVK6O
	Ah18ucq3It+cu/HXS601DWKh55OTCPMEKrqgmbOvr/J9VdF2JIWtvV3avDrci6A9tdO6o+2ruoP
	xJWTlUq+trvnioly7hCejtAite7ppW6L0X5omYbm89E6W8s6MAFfACTd1r9ztjLMUiqiU7xRYnc
	86r6It6fEMrTbD880BqkWN2Ss0s9Ux4z+S38y/+c4gjvZFCp9F2tKJ5Z8+0iu35SCkqX5SfShz4
	iU1GZeqdx6MQbiHTht/TqISE66Ug6XGOeeOnIOzDRXQXdPL+5iDLa92btUVUB
X-Google-Smtp-Source: AGHT+IE5U6LXG54IWKr321BSkIm9AXP4fgYDqmfDF+EFI/tZ50VHmEfM/XrLkYSWkU02RLvDheWl9w==
X-Received: by 2002:a05:6a21:6d90:b0:243:fe1e:2f95 with SMTP id adf61e73a8af0-32d96d8d186mr38878732637.6.1760357422540;
        Mon, 13 Oct 2025 05:10:22 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.98.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm9633354a12.31.2025.10.13.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:10:22 -0700 (PDT)
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
Subject: [PATCH v2 0/4] leds: Add a virtual LED driver for groups of
Date: Tue, 14 Oct 2025 01:09:44 +1300
Message-ID: <20251013120955.227572-1-professorjonny98@gmail.com>
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
  dt-bindings: leds: Add YAML bindings for Virtual Color LED Group
    driver
  ABI: sysfs-class-leds-virtualcolor: Document sysfs entries for Virtual
    Color LEDs
  dt-bindings: led: add virtual LED bindings
  leds: Add Virtual Color LED Group driver

 .../ABI/sysfs-class-leds-virtualcolor         |   43 +
 .../leds/leds-group-virtualcolor.yaml         |  100 ++
 drivers/leds/rgb/Kconfig                      |   17 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-group-virtualcolor.c    |  439 +++++++
 include/dt-bindings/leds/common.h             |    4 +
 6 files changed, 604 insertions(+),
 create mode 100644 Documentation/ABI/sysfs-class-leds-virtualcolor
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml
 create mode 100644 drivers/leds/rgb/leds-group-virtualcolor.c

--
2.43.0

