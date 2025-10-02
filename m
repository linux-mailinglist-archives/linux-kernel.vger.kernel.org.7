Return-Path: <linux-kernel+bounces-840184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80EBB3C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F5D19C82E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8D31065B;
	Thu,  2 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP2/bhB3"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C830FF3A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404854; cv=none; b=W7fokbd4NrA79pA5WOm2i+pzWg+59ap5LFULMPjno1YJ2oHM7ZySEsVjOy3hOmETYaOO2mwC5ihRLbqYbNFHNJ0kiIVImlZWnFWYyMKXQO9lmQrtfMnvIbHcqEXXzeIfajzxlgHVQF4jJ3a0hxup5uxIjZZjsnMQBrKD4Wjix4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404854; c=relaxed/simple;
	bh=joJFsmLC0ahfMOA1xiYAki0VFQaETHltvy6RAJznUm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fH3s1Pg264+BP4U2lbyjPBD4ZXsFV5z6M2D/3Iu7Mk7G5dj3p181Fbrp5/ILYl8IDRS4mAB74x2DOlt1a7F6K+eRtpXNput2opAcvk5j8IeJf7fE60phnG8KGtA9YFrujwgvJotEyVS8oXOQAFEo7ZyLsHJAYwjik8Eh5K4PsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AP2/bhB3; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-637edce76d5so274686a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404851; x=1760009651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE2gdnRWmdJaMiCXgFNZvZRGrqhmc689a8INpdeTYqY=;
        b=AP2/bhB3lfByuFHV3N1Q37yM0KeF3t1eDI2jm37FU4kncOL2xx9i/xlP17bEmMlljM
         t9LnD5kxizrY6xv2PftiAwcckPA+1AlTtzeplwwCP4nQzhpEnugREwhr86RsfBrF/DQz
         xWcHodcigTXCKscQPhJtb4ogrqO53mkZz3KlZSi0/oppXHHI6APB1vxiA2OFQqT/0KxU
         3cLzlGVGQpI/OOXfCGjG9uDoIJCVCrqdBdV7YtSqvbgGiLsC7+VALse5i3URXxNNQcuv
         WDt565QUtP+m8SXRUdMroJUuIqbpr3dUaudPN4iQy30cD8wQCqdkbd5dzfs9YAmY66ob
         38cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404851; x=1760009651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE2gdnRWmdJaMiCXgFNZvZRGrqhmc689a8INpdeTYqY=;
        b=kW0h4XV2icAwdETfCyMJaB/kGEiIXv+kBGGvNFXmF2SiZ6QabOy5vJuCnKDKe3Ay2b
         ejMzcfQaWGjLWGjNhY+alw9JXojaFqLl+NCfNUP5E457iirChADHIXpAL2ry04Z2+0Vd
         DYjO9bY2OAc0Z1ze6TW2iIG9ZVaeeofLgQCsFWOaqjvOVMRXXPkN+EhnopHrj4Ndm8SW
         rI8P/RXtRMfNMKhnuIb/I8mQkSZtBslbEH8pzCxy+p2WzbA8UrJ/R0H7Wtcvn0coStzO
         LG4oT1nsPOAoXpRHuWrNlidN4KY6sykDVb3R6VDNEycvap4cS+9VMaaL0ap9KcCWEDcl
         rygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcCBcYja+fSJizd26OfZFs54UBnl6cYNr0I4Tio/HwHvissfmVr1eSSGu1Z6RQg/GQWiEQDriJGKJTF00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkQ6blTlQMABAvDBPpyZBtqhfeERpyb9jaNaJNI/qiRQwX2kU
	AWhquXGl7E3gKU8mfnqWeCg+mFAv6XDgfVgqvCEr5N3jokY6qxZWHtqm8yX2aHjdyWlo7s2FmAZ
	biaFdXQ==
X-Google-Smtp-Source: AGHT+IFnNGWeUW+2QiI2DEf6id556ZD0ID7jFmIizNY5EI0PMeiFKJnPQbdWshUAr7O6MaAV/CyVGfRtTZo=
X-Received: from edqu5.prod.google.com ([2002:aa7:d885:0:b0:634:b46f:19de])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3489:b0:634:e004:76fd
 with SMTP id 4fb4d7f45d1cf-63678a9a613mr6778480a12.0.1759404850841; Thu, 02
 Oct 2025 04:34:10 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:02 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-5-srosek@google.com>
Subject: [PATCH v3 4/6] ACPI: DPTF: Remove not supported INT340X IDs
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

Remove not supported INT340X and Wildcat Lake ACPI device IDs
from scan handler.

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
2.51.0.618.g983fd99d29-goog


