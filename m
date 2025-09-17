Return-Path: <linux-kernel+bounces-820609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0CBB7CBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B61328709
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55F31A80F;
	Wed, 17 Sep 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgAa6aGu"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0F37C0EE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110865; cv=none; b=NMRS4FJ3HsxZAXWNXRH36YpySQe5+ff1qC8eagaKiGLfJDuGwm+LfxPaZKNifGGxutXcl0g8wpndQmQJB5uxQ3ZjKH2N9FDh40ARWwdl+X+hybybMC7AGA6wRs/ufaPAiSGlhkPB0SZlOw/b2lE1MFENBb4QkOxKFE8zZ67bXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110865; c=relaxed/simple;
	bh=lS7uSOog8ynt4mAljbR1uTVazr99QgBpcuHJijrXPag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BjgNMZigN0PIvF+sRk4zqBhpH7/RTRhkrT2/wZOliAF/9kLHHchIQRuZJUP9iDMnvHxHbIrWKO9G8tPpPUUPYrrpanjMCE/BhejhyPevClahHTo89+NGt1bPa2tsGusmz8RwB+cG9G6naP51A2XxGpyqApckG2oVYBDLHry8KqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgAa6aGu; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b07c2924d53so417854866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110862; x=1758715662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Kw2BRYLs6Jf4HMAdqvkiMKQ9fATMhkMoyiFVJ9jgk=;
        b=wgAa6aGudbVEya+EtzknlCjDSpKO9nSPsAM3Bd++e+95Z69XzS/rlUeUer2RlMW8Go
         QivLLIfFJv2+J27RfZsCC+zrDmgPvukxUY0Y3lJgrKkhzEn6EuN01X+Ru8Y4slFuJ9vP
         UF8maigmZtEt8SVkxFUiyrv6bmfIs4BjyGUkWVY3EUaUZjdB3fHvRNGu8PIBouASuSS2
         mScYLDIXzfOLEjLJQ8FxeGvTqXdUe705tZF68FAEBmDdvkkhJq3Shhqn1gBb5j+bZDQT
         8rD27B6v1kFQ6vEbpDRHPXSwBJ2c/g3qH5X8OaUZ309nKSFWYdBobH3KOTl2jTvmnCoS
         TgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110862; x=1758715662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Kw2BRYLs6Jf4HMAdqvkiMKQ9fATMhkMoyiFVJ9jgk=;
        b=i6MBarfx0WoJY7jKndgs5D+bdvWeqDAKxpCMNj7mSSl/Rnz2DrZ9KWR0PaY6v2B5j0
         hnl92uZmsqorSCh1SW1fnvKScibTxJtBlwJ2ss9c+WP3Io4QWviqxsTBEu23imLOfJlt
         CQWNqeq0SoDUTjwpOkBal6SuwXLuXzOY7+QErSnccWoOnINMeuveEgcdbVgqqjHECxkU
         tKdIfVwGN4z4t9yjNX9WeteaXuPgyweAYEIlsdIQgjOPZqt5oNvz95qkCoe07ny5uMyf
         ra0IEn8kimi0luHI01uKkxZPPY2+/x6N+lKTFD8sCMqHkmef/sgwEycviXES88c6NaHF
         BKBw==
X-Forwarded-Encrypted: i=1; AJvYcCWvXJ7xOC3qj62Pu66CKA5RyVW3B7S99lu3rPDpfnsrdF7AHISUlL+GXxyp7EYQuIAIP2N9Ytpfa7AYqmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNNfpbpUhho9JVg7VSFktmRnZVLB32cMs51sOijfd0IRII4fu
	nj9brfM906EGDZgEAy+C/V/A4kN5t3JDZfZ/cZN10qCSQp7BEUQSbOMGaH9Agw6CueU4ICTjX9u
	p3hz4aA==
X-Google-Smtp-Source: AGHT+IEXCIHFNrzZ1iYEZnrwN3IyAVT8tvIT/ujeWiRXjj+rV/3PEHRamZPqq/aoS/HmYzWlsldfyMLOcV0=
X-Received: from ejcsl10.prod.google.com ([2002:a17:906:618a:b0:b04:2b56:f5ab])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:94d1:b0:b04:b981:8823
 with SMTP id a640c23a62f3a-b1bb08695aamr245223966b.4.1758110862243; Wed, 17
 Sep 2025 05:07:42 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:17 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-5-srosek@google.com>
Subject: [PATCH v2 4/6] ACPI: DPTF: Remove not supported INT340X IDs
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
2.51.0.384.g4c02a37b29-goog


