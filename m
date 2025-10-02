Return-Path: <linux-kernel+bounces-840181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA1BB3C40
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7C3A8BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE13093BF;
	Thu,  2 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLlJpLf1"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED72BE7A0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404852; cv=none; b=MuukxRgL6CQ2tkxlXDl/eGECXUq+Ett8iOfIZMHh115VCQqYtzvDRCi4bYYjK22RxcEWmLjXt4oiB/rQWaOLIBayxKpk7zyyeY4tr4NGsmBCeEkQ/E/PPhEc2rSpPK9uFaOTadOZtWl49c9hrc34BYWBqtQHm3KSquKrk2gCvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404852; c=relaxed/simple;
	bh=OSzoS5rtTLi/B+hMV5Q0JgIBDtwwSwS8cCrabNTJlVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZklg3nbnBeXHaEVAW+BTpIMwASOY0YHsCASGsncUJ2Aql2oISo09e9POVLvS2BRQHCiLBwBDwFYs63CPF5kobmQ11/UW1znoSbq/VLlTPHy06KosY7oMs+qLLp80aLvK4DkZW91tgLmKuoRViwMKs4NxAzKoRFjRECesI8zBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLlJpLf1; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-63798d4b7caso882719a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404847; x=1760009647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt82+dwcyqqy/z3wY/WnDR+0tOJqjHYe0Y3q58yXyz0=;
        b=hLlJpLf1LBpyxi1QHdOwLXUB0LjIP5F3rOJbd4A+jwmBoL1PdHLmRBg0BYOmbykquh
         uGDNak7CUUS1dToS5LW3PU+iNWM+twOgH7ITW6xH/AgD3qmgph8H5Gfz+WEK8dHcsECc
         YHElEXWihUiBuPeeZQNm8CfkYMvQMzHL4bSWp6wMWMSI1Y3FgfSSQuiIRlyGFQ6lwARA
         2v4CnCkFuDAnls5n7ehtNmB0x6XRmi+k0zHRcaWRh0ushvU6fbHdCTOLllSbbEYI3QlO
         JF9tURnRyghVZefw6o97C4EWewyAEoQr7JphNoS5x2mohNwwdUsmx68k150O+gOenYnS
         c8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404847; x=1760009647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt82+dwcyqqy/z3wY/WnDR+0tOJqjHYe0Y3q58yXyz0=;
        b=Nuj3LyYh9OuMFAeJTjzHQ68LFu/4mudawkt3Updja+RdX+Cy8Vl1E2fQvf0Yk4Aqp1
         g/QdCi3SX1oJUh87JIO5oPBNdC4YXuB0/AsXGyjWzM3v+GYwYloM6BjcU0hsX1r/PyRU
         lWfiNvmkQIgETu4uWsXTDx6suMQQmnjng3APM5GlMn/2WYK8vYqcyFYJlOCo8uHwpnhg
         C9p8g4Lgz7mAf3JsZN7CUj+zui6VYydQJsWj33D0XM19xQHhYY+LGojUn6/KuIel/Eo3
         n9dm2PdXMGdcF4NI/lQcrKaI2dnnCT25qkswo/B2t4iA4RrXYSZRlsTXgsGpI1O3y3aQ
         h22g==
X-Forwarded-Encrypted: i=1; AJvYcCXBXYM4jT859IHfYL5fMYCZUikHxSKBLs6WRUKeMD4Mv5wioA2t0V5pSzEjJxHMGwAa/dlDJ+wqhN0bYbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJyXmoO6hQNxMDcKS3CiTsIdGUbbaBs2W7okFPyHI11PQTlfw
	ReYunslBq0ZWczs2A1utTNKsIVyvjYHm1MU5tgJDoGLXPbwlFx589CG+dqUolOQL6Ek8toCURGv
	Ou/PNjA==
X-Google-Smtp-Source: AGHT+IE+4068072UB8enIKGqreBK+V8kMqDIEgu9uXCRHP5CJrH3i0Dac1P6YuynTCl4M7Vi7LVvL4CfTWc=
X-Received: from edsf20.prod.google.com ([2002:aa7:d854:0:b0:62f:c143:5d77])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:c60c:0:b0:634:bc7b:440e
 with SMTP id 4fb4d7f45d1cf-63678c9f531mr6099293a12.36.1759404847361; Thu, 02
 Oct 2025 04:34:07 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:33:59 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-2-srosek@google.com>
Subject: [PATCH v3 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
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

The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
critical overheating notification. The IRQ 86 is described in the _CRS
control method of INT3401 device, thus Intel SoC DTS thermal driver
requires INT3401 device to be enumerated.

Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
is updated to ensure proper enumeration of INT3401 device.

Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel SoC DTS thermal driver")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 7 +------
 drivers/thermal/intel/Kconfig       | 3 ++-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index a222df059a16..947fe50c2ef6 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -11,10 +11,9 @@
 
 #include "../internal.h"
 
-#define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3400"},
-	{"INT3401", INT3401_DEVICE},
+	{"INT3401"},
 	{"INT3402"},
 	{"INT3403"},
 	{"INT3404"},
@@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 {
 	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
 		acpi_create_platform_device(adev, NULL);
-	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
-	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
-		 id->driver_data == INT3401_DEVICE)
-		acpi_create_platform_device(adev, NULL);
 	return 1;
 }
 
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e0268fac7093..f9e275538e29 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -44,7 +44,8 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86 && PCI && ACPI
+	depends on X86_64 && PCI && ACPI
+	select INT340X_THERMAL
 	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-- 
2.51.0.618.g983fd99d29-goog


