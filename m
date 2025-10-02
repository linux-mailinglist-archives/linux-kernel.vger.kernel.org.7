Return-Path: <linux-kernel+bounces-840180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF1BB3C28
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591901697ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866830E832;
	Thu,  2 Oct 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3cP9siH"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286ED1F582B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404849; cv=none; b=opQuW5u1fwOddQzRU1CcavtCyi/VdpufBVoDLECZ4rQ0Yl8uS9+QKTInjktQFkLbwJI2dahO/PePqtHhEb4NbNr759Yd3XWJAJWh2Abor3hb79Es9UYaiGF74zgB/+VnU6GI3TBh1CkIe5D0bZT6ifwW43vVCDpRtq5c4/7o5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404849; c=relaxed/simple;
	bh=hQuybsL5mq6JNC3mjDtwdLC45MTOFDleuadVzyS5ZHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZZ74rn3pzMqWpINj7oG3NNUvBEFZk5TVpn9g4OHGKDNPObgmqEtO767KKWJ2OZdDPNAo6Q53Ej+MBPy7GaZffvhrqc8N3QtQ1QUML7lMHgqpJxsVoKrm5lQDeuwjMyva9Ha549D5vn2BqECuGvU08AHHYeEVZZWSsBp+Zrv/PHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3cP9siH; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6365fb32d66so949011a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404846; x=1760009646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KM5eQ6T8UyFEHWSzgjJ3Hgygo6yv0GW78oI1iwkhY6M=;
        b=E3cP9siHAs+q/VrZ0XuWMswGGeO+X4D15mmnh2u2FZ7Foo9LvBUnZ73ENlwMRZ4zVV
         waaquAMRqqK7JkK+zEZD7GN2/WthSxFrPrXTKLwEmem7iIHHrd4QRuKSaMBBj2ZvY78r
         A/zKTHY5hlWCxu2GeCNCe57mBQ53B/OFVU2wNqTZJHTV2Zc/897XOjAq+2RAtPOuIn3G
         OYtQSlbRoLjTf+dlelli7eh/hMW7SoDQ/3+BOaXqEewVrs7D9ekbgrmwhPYdjrETPNF5
         LSD3WCCmqN//ePwupsmH/kcdTP7iT73F3fnCM2KY0yZFQSC3FagQBQlqooha/ONbxfA5
         HULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404846; x=1760009646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM5eQ6T8UyFEHWSzgjJ3Hgygo6yv0GW78oI1iwkhY6M=;
        b=O2l1HzRKBfUnvdpsrrv52iYm/MjRGHDOiTBjXIsPEAiSweFauxo+RYQaYY9U01GOa0
         qSP75b3gJJPErv30wtm6Ocf9r+HA9V30KcVzXBAcdrCUMJiuMNmTeZbl5x8xa55K0w7y
         drgboxnXvvnB0mdkI3CBtlRyeBwvK2pkuQxLU4o7tyzGcK3VC46TmaYbJCYMcpif+DjJ
         S4hHjSpLAHoc4qUPHzDz+qaKITnV3sLqZloxvbyVPv5tgK5QTSzKUZLiHD12WShm3lDS
         UL1y829SQozh1byjpxeFPljkKA292fW0b/An+64hq5om3yaqr+zvTHh7ZX78/WOxeCgR
         nGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqJ062XzIH7OhkJ3kv4mfQeg66JFUvvRWss+GqHrU2ype2C35C+6nvz1MmbLVWRYABGcO8iB3lRioU+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ1BvLc/yjutA3pRUo2rqeB+IsZ+SYjSFU9pTGOixBIORD6dr
	azRpQzmTF/MHBtThAhxzBxRdvQ0YxejDm4Liwq39pKBCMtbecX4ma+VH6XHRH5o5pLLBGm8sEFA
	My3Glag==
X-Google-Smtp-Source: AGHT+IEmDFbvw6FyLQa1/XdlQWAwHZ5+qO0v5z1jGtaFkTjZBilCrTEGtxSBz1xgfUUU2N6aLbcU0hulMzo=
X-Received: from educ18.prod.google.com ([2002:a05:6402:1012:b0:637:ef5d:b120])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42c2:b0:637:ec59:3169
 with SMTP id 4fb4d7f45d1cf-637ec5936d1mr1180990a12.14.1759404846433; Thu, 02
 Oct 2025 04:34:06 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:33:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-1-srosek@google.com>
Subject: [PATCH v3 0/6] ACPI: DPTF: Move INT340X enumeration from DPTF core to
 thermal drivers
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The Intel Dynamic Platform and Thermal Framework (DPTF) relies on
the INT340X ACPI device objects. The temperature information and
cooling ability are exposed to the userspace via those objects.

Since kernel v3.17 the ACPI bus scan handler is introduced to prevent
enumeration of INT340X ACPI device objects on the platform bus unless
related thermal drivers are enabled. However, using the IS_ENABLED()
macro in the ACPI scan handler forces the kernel to be recompiled
when thermal drivers are enabled or disabled, which is a significant
limitation of its modularity. The IS_ENABLED() macro is particularly
problematic for the Android Generic Kernel Image (GKI) project which
uses unified core kernel while SoC/board support is moved to loadable
vendor modules.

This patch set moves enumeration of INT340X ACPI device objects on
the platform bus from DPTF core to thermal drivers. It starts with
some code cleanup and reorganization to eventually remove IS_ENABLED()
macro from the ACPI bus scan handler. Brief list of changes is listed
below:

1) Remove SOC DTS thermal driver case from the ACPI scan handler
   since its dependency on INT340X driver is unrelated to DPTF
2) Move all INT340X ACPI device ids to the common header and update
   the DPTF core and thermal drivers accordingly
3) Move dynamic enumeration of ACPI device objects on the platform bus
   from the intel-hid and intel-vbtn drivers to the ACPI platform core
4) Move enumeration of INT340X ACPI device objects on the platform bus
   from DPTF core to thermal drivers using ACPI platform core methods

Link to v1: https://lore.kernel.org/all/20250830053404.763995-1-srosek@google.com/
Link to v2: https://lore.kernel.org/all/20250917120719.2390847-1-srosek@google.com/

In v3 the SoC DTS thermal explicitly depends on X86_64.

Slawomir Rosek (6):
  ACPI: DPTF: Ignore SoC DTS thermal while scanning
  ACPI: DPTF: Move INT340X device IDs to header
  ACPI: DPTF: Move PCH FIVR device IDs to header
  ACPI: DPTF: Remove not supported INT340X IDs
  ACPI: platform: Add macro for acpi platform driver
  ACPI: DPTF: Move INT340X enumeration to modules

 drivers/acpi/acpi_platform.c                  | 27 +++++++
 drivers/acpi/dptf/dptf_pch_fivr.c             | 10 +--
 drivers/acpi/dptf/dptf_power.c                | 20 +----
 drivers/acpi/dptf/int340x_thermal.c           | 76 ++++---------------
 drivers/acpi/fan.h                            | 10 +--
 drivers/acpi/fan_core.c                       |  2 +-
 drivers/acpi/int340x_thermal.h                | 76 +++++++++++++++++++
 drivers/platform/x86/intel/hid.c              | 33 +-------
 drivers/platform/x86/intel/vbtn.c             | 30 +-------
 drivers/thermal/intel/Kconfig                 |  3 +-
 .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
 .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
 .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
 include/linux/platform_device.h               | 17 +++++
 16 files changed, 164 insertions(+), 179 deletions(-)
 create mode 100644 drivers/acpi/int340x_thermal.h

-- 
2.51.0.618.g983fd99d29-goog


