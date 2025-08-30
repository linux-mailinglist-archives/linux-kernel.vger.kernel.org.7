Return-Path: <linux-kernel+bounces-792735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A628B3C842
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724541B25CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A00283FE7;
	Sat, 30 Aug 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHDGMKbd"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274471DF271
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532072; cv=none; b=CRVZ8m130aYrkkD+ynecV+8aPR3IYknn/HoFDeJmkLtOkp4rNUFvD2G6LJXakjDzmjVGXJN5HjAijXb4yWex+CIRDFcEGZCbRQ+7SOAOXHiN8OH67Q901rSMJcWbZnl5untE9HAVztFncEU76kyOItG+Um6Ybnu0WVJklh8UudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532072; c=relaxed/simple;
	bh=lF0476/H9flRajNwNUMu+J4BiKnBUSw/hl2khi4FgtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njikqX7QytDVy2iBsKhutAGQadAZPPWJR24maPCRMqy8TEW5ENAPB9TNz646yMqf6QjnBdjFp37WVVBUa8SMGlGr0BE0kl0ZkPitHRB5Crry0Ed1D19MY4cGRajHvSb0osKbJ4LwyB8JWOlNV8dtPP06N1G8vrW3bFGDIODZZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHDGMKbd; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61d2de72644so70901a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532068; x=1757136868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruxiuoiYNSxXFTVjh6/hB2e6UL45DZ+gVYdJkbnA6z4=;
        b=RHDGMKbdPzR2eiAwKVT7xw3OHb8hTGZths12TCt/fJWrD9OLJXMJ2zGT+4HMzBeVhH
         3liUhdoZe/kx2QZVyLpCxZF59Sv78urEZf8QQ9ZjkP3kY2gaT+PA1CNkZ9mhDbo/Wfs9
         ccmmr1L7GLBDt4vO+2sx3j6EZXriZJYZDpoZAyRYZoKdLCts2VJeiZM4ggYe+I16dy+O
         5cVAGXvSys/RV/Ze1++PM8K1q/OKcwIx8EMpD1VrGdEnqGHkqJH6ZI4ijtTofQdy5mcq
         Wj5q2QUC8RuuZ49l1lkF9noK/uAwwAlfIm2iSBBtta0xmZZ0awmUFL0d5PARDSCTkAy9
         Z+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532068; x=1757136868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruxiuoiYNSxXFTVjh6/hB2e6UL45DZ+gVYdJkbnA6z4=;
        b=FZThyUbm/8aUrIx0SurGD4t7Rb8FizOFwqfwrTHsf1+QmwNC27haFZ4TqXXefftjvu
         0hriQUyHOXddpgDQ41775lfeVAQghp2aOYyKtuj+gkEEWsIwH0k99rl445gOA3q+7/3U
         N+xse2UhXKackW39remEfKYOrJIPWw4odpg24AsdtHOg6VAmWtlxomcp3gkQetPkrheE
         aAKoCaEJmJhD0NLD1pvpBzHOAWnPlE9F5dlCnef6UO7bpyr4mbLnrpEc5a3jYKlf/2x6
         6AfqQkXO/fcu5AYbC4j3kfuCFRStsLSM0HUhZuSmsoiYjSa4OxW6KReooOtlWcfbTOAE
         X7cw==
X-Forwarded-Encrypted: i=1; AJvYcCVO2CIPy94nH30IXBX1EmCgAvBHDuhdUXmjQidAJomI87yFOCw/mtLUMC1ZsLh+H9KM8M3DA0TydPbv12g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJWFLoihCOACqPshwkoNkmwN+vgxYKl8x5FaGKM7g4KzVU+Kg
	CmL7T3DNr/lK3ii/r7DwIA4d5sWJUtL4Vrzi4Er/sni0UIuxOhj4uO9LzRCZM2ZvX+OYqFBGL2u
	+UurVOQ==
X-Google-Smtp-Source: AGHT+IFwzwayWU/+uFP6x7Bn2DFv2JnW4PJrUoj5Wt6TMt8fyCxr5sl8/Zoqe0uOghst/8UMpUvjBP0J1Fk=
X-Received: from edp16.prod.google.com ([2002:a05:6402:4390:b0:61c:68a0:dfb7])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4406:b0:61a:217e:884c
 with SMTP id 4fb4d7f45d1cf-61d260c98e0mr875888a12.0.1756532068376; Fri, 29
 Aug 2025 22:34:28 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:58 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-7-srosek@google.com>
Subject: [PATCH v1 06/12] ACPI: DPTF: Move INT3404 device IDs to header
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

The ACPI INT3404 device IDs are shared between the DPTF core
and thermal drivers, thus they are moved to the common header.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c |  9 +--------
 drivers/acpi/fan.h                  | 10 ++--------
 drivers/acpi/int340x_thermal.h      | 10 ++++++++++
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index f042bf22b664..be2299aadcff 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -17,7 +17,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3401_DEVICE_IDS,
 	ACPI_INT3402_DEVICE_IDS,
 	ACPI_INT3403_DEVICE_IDS,
-	{"INT3404"},
+	ACPI_INT3404_DEVICE_IDS,
 	{"INT3406"},
 	{"INT3407"},
 	{"INT3408"},
@@ -25,31 +25,24 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT340A"},
 	{"INT340B"},
 	{"INT3532"},
-	{"INTC1044"},
 	{"INTC1045"},
 	{"INTC1047"},
-	{"INTC1048"},
 	{"INTC1049"},
 	{"INTC1050"},
 	{"INTC1060"},
 	{"INTC1061"},
-	{"INTC1063"},
 	{"INTC1064"},
 	{"INTC1065"},
 	{"INTC1066"},
-	{"INTC106A"},
 	{"INTC106B"},
 	{"INTC106C"},
 	{"INTC106D"},
-	{"INTC10A2"},
 	{"INTC10A3"},
 	{"INTC10A4"},
 	{"INTC10A5"},
-	{"INTC10D6"},
 	{"INTC10D7"},
 	{"INTC10D8"},
 	{"INTC10D9"},
-	{"INTC10FE"},
 	{"INTC10FF"},
 	{"INTC1100"},
 	{"INTC1101"},
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 8a28a72a7c6a..4015ac56c009 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -11,16 +11,10 @@
 #define _ACPI_FAN_H_
 
 #include <linux/kconfig.h>
+#include "int340x_thermal.h"
 
 #define ACPI_FAN_DEVICE_IDS	\
-	{"INT3404", }, /* Fan */ \
-	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
-	{"INTC1048", }, /* Fan for Alder Lake generation */ \
-	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
-	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
-	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
-	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
-	{"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
+	ACPI_INT3404_DEVICE_IDS, \
 	{"PNP0C0B", } /* Generic ACPI fan */
 
 #define ACPI_FPS_NAME_LEN	20
diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_thermal.h
index 3b34b5338618..d1ffa9c3cfb7 100644
--- a/drivers/acpi/int340x_thermal.h
+++ b/drivers/acpi/int340x_thermal.h
@@ -34,4 +34,14 @@
 	{"INTC10D5"},	\
 	{"INTC10FD"}
 
+#define ACPI_INT3404_DEVICE_IDS	\
+	{"INT3404", }, /* Fan */ \
+	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
+	{"INTC1048", }, /* Fan for Alder Lake generation */ \
+	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
+	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
+	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
+	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
+	{"INTC10FE", } /* Fan for Wildcat Lake generation */
+
 #endif
-- 
2.51.0.318.gd7df087d1a-goog


