Return-Path: <linux-kernel+bounces-792738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D1B3C84B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AF57C12E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3102C11FC;
	Sat, 30 Aug 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQD9o7gX"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF729BD9E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532076; cv=none; b=CVpvuywpU1TRPVrOSvjPqU476U89tOaUCul6z/DS8fXLtc71P2H+t8g5TIku0lAT3AQVz0bIoitb3kDTV9ddBtPbQXhJdmA45UUrumc85YkBYkQPLeLaUJxxgRa3hqd3KaAEig8dsLVRS8pZmhttgammR3mZh2yLQU57VqTYODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532076; c=relaxed/simple;
	bh=uO/ODjE/zYZVgbm1CU9iXym5pNf0yiWRr0Jb7Ejew9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HfPtRnFFP3K231EmzfJIh1J0ltIngxUhFbd1tOnC7ysiAwp93Xzn1An3LQETSNq+WC8ZK+TbNVqF4v2Q89sJaSNsuDqN2zZ1lImQO7H+mDemCIlstjdi2wtQ373wBAoKOq+RUYMZvViMvUtWUiOOwFkun+4Ht9dTlMG7H2IP6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQD9o7gX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61d1cd0051cso858196a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532073; x=1757136873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=JQD9o7gXpMWrnz1CQE2zJMTvayxDEvs9QKNoFxY7eUCLXYZL0IyhoW611ZEqdHn3SF
         Y8rq10tI56GNavGlaeFPPwwhto6qbhaPrwV6BvRhKw6xrpxELaY4i/6z1/u0lb8IlSwo
         FdYfk2QqJHUh2xuOFxocqNc5wEalPaDWx/KmPXXN4aSLb5U3DYRxidrJoOTYtCDdu6rV
         hTz7Lo09Ag7ueRrXEL3qHdTrfFGbi2V4P26aBq6jIh1qbEArNtAGsUhSjkAKmIGGvgFT
         cMtdlgaDMI9nZ/dGyaTKgXXYE7BEgIwVuefenjLfVwiqoEBgoOp52Woc0fzZdC22xi+F
         58Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532073; x=1757136873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=cKIs9RwwmqDo2+nbtE93pJmJEGsXcLsvHik57+wEEDGxfpg8+6FSMqMMOtfojnfj3O
         76fl+4U9UZjNY4lN0BXodfAYTwDss9CvxFTy/IwdWj8CmuZ30g8gUvEpvMGpTlb/3CY0
         4x1+zxbB9lTHQtUtBurnHnAajEQScFHZdmMeG3KdbYXs1w6+8KFNBXH01pKGkSjwbpIg
         iO32WxtfW7PX6FBgQWFBBnKhHZGUSrVCSkRtc4ZlrqGdzpUulEpthp573yzFu5jkkSlq
         c68P+T0XdBHd9i0fn9dmozEnH7f1gF5FiaL/FbKYhkbqe77+tKbmS011h91fM38fGA74
         Em5w==
X-Forwarded-Encrypted: i=1; AJvYcCVgjMVJ5TCqWAN1B3UVdyLHzY2QGcE2gbOzo0Ugw5p3SsWDpJi1adcVTZ2dW3g2YDb6ijZ7auHtWGY83gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzaltQFjjUm/bwq2lztxsbsUJ/VVnKnsKAFVvA+d6a8R/FQYI
	8w98J0gQVmyXmn0MbDgiFjKK7VD7IoDWCn/fM096ftCyplIaM9Dqh2yDEJ7wdbnmcKfoFm3qqyj
	J2enGhg==
X-Google-Smtp-Source: AGHT+IEt/4Q9x3GXVaT8543rG9eCaojjztEKwpl3WFkiLwBvUvkuJUh+sjRu8HQmFq7S5jcqpBu8z9GpTn8=
X-Received: from edeg15.prod.google.com ([2002:a05:6402:564f:b0:61a:56c3:d3d2])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27ca:b0:61c:5a8c:9a4e
 with SMTP id 4fb4d7f45d1cf-61d2699752fmr748665a12.4.1756532072715; Fri, 29
 Aug 2025 22:34:32 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:02 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-11-srosek@google.com>
Subject: [PATCH v1 10/12] ACPI: DPTF: Remove not supported INT340X IDs
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

Remove not supported ACPI INT340X device IDs from scan handler.

Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler")
Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 26522ddfcbaa..7d1308b1f513 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
 	ACPI_PCH_FIVR_DEVICE_IDS,
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{"INTC10FF"},
-	{"INTC1102"},
 	{""},
 };
 
-- 
2.51.0.318.gd7df087d1a-goog


