Return-Path: <linux-kernel+bounces-720140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D749DAFB789
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019D33BC332
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44A1DE4F6;
	Mon,  7 Jul 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cAkQ8RKA"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7791DE887
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902563; cv=none; b=K3pnykS9qb5BPSSLcnBLhWwWYALQfGUHT3j/L+iCUzpRY80asUrushLOvzP6WHfppdaUOXLLbwAUmc8nxRBKBmP/Ahm4ugAELGGa0TfsNSEWxg9JZJqeAgks30mABcDFTTTac9GgWPOtuQcaEYAiIGItDtHO7hYTOB+KXhO2QFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902563; c=relaxed/simple;
	bh=ZA04moigYcljOiC8KACl/JXqopOZwaWH9JniPZqYBVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MQ/b3u2kTZt0DtVQCB0S+0kPzLx/QupHhp/sHXnKvgvrA0o8rB2kEDD3HMyoe+jnqwmn7cQI0Ayl5lyZoMwo5hjHGSwHKfzF/xxtzkwHocLaX4ozHDHWeDYxTGqFJtp2AmmZUlCr9QkzqPrpamaM9Da+8dWKVn33RJT85PDh4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cAkQ8RKA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2722212f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751902559; x=1752507359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/l9ZtZZtpv5TdHCIxJYxYTLPx5NrF8lUAqMdxgF68/c=;
        b=cAkQ8RKAIxLqiWgYKKseE8SB/6qeds+Xy0BGRsxDuyfDVOEgt6oQrreuY/Bg0WMtm1
         2MIDMzy+XKxTrd2yfd5SEA9XLX+cdVSThgjj7NNyQkVRDkjRT0jLYZep8qo6YUd/ET4/
         GubkNWYtai9NPvok26u74GVVSyJFFzpR78R5rsQApoEhcLSaccEiy6CBr4WQSZcOqCUP
         3bQ3XTaNGxQ807IMeMyp52mQTCqfhfHKOuzdYg/62hdNOXB/9Hts/dP7CES3vsbLCAV+
         fo2J+k1HBgSwaI8jbCWahf6bAMbvULrTH7a+3Rwa9Np0NaGgxKTDYNKzbIDGAyqiogXl
         yFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902559; x=1752507359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l9ZtZZtpv5TdHCIxJYxYTLPx5NrF8lUAqMdxgF68/c=;
        b=jLjbJXfaAFBu+NeXP3FQraEjzbuikj8ngwiwf0bF/tgsa3hyX0sMXzW3Y2Sq7Okiyw
         wBoWMRFVml+J4paI9ZPFyUkw5g6i4dnDmAUpzim9ZVvx4n1YHMXENHXK82G1nEk2qcwL
         rJRyiBKkbmiYKedYLeLtQqrUd3bZwW4+UiSpy+zzy7ec7qQgvr9c90fdFuPl4kzDwG+u
         4UwiqW6pv6tqPZr3TPqcVHE4f+DjBw6TiGLmo60MS7Upjvnsyrwltk9AqZcwCA62TC6V
         jYeZUEYnhnDAx58E3ySIJ2c2I0iRUwmkch3QRn6KIktJ2J6lMf4eZof0WrgZQOru5TNs
         eG1g==
X-Gm-Message-State: AOJu0YzRdcAhC+of9J4NhbcvsODwVB4htdyNOdHbc5bYXQxadTBUTPzD
	Brkv0oGQoFE0LprfkI0CVsCGylOrJzZGW0V2dGjSeL0EH+huErxYjr1ZX+9okcWxk0s=
X-Gm-Gg: ASbGncuhzPN8dLKnpTuB1HTYfsVFY/8hzKF9dGXOrY1W6Zpbv7RhuAUOJQ4w9FBfHAG
	zPSBxowu15qKSGmV5uDj6WUYxJ5hLW8+lGnXEPGDs0vbK0cU6PqNnuxLn8nu6szYBXuY0yG6teL
	kQQ8QQ9jLysKjgLa0xrhKvkLbWYfrWu9c1wXltntN5hcBUsRpHNb9TrsZ4+SRvz4EXDoPJUpEbn
	n1N65GSD2HiTt1/RNnGqR64DKI/tUMlOqMcflvuOJUx4v2VmCvotrwGDcxHWVPFlnxWZIklFMO9
	x+FuU8QWn55UdTQNd9g8KD6atX5QRiTHdyoHdHvxcAHp/P60BsDZIkD2aA074I2LZA==
X-Google-Smtp-Source: AGHT+IFOqLs3rtH7O3Gh9y3XbwlbxGcrr4OrTjS1GR3bH2LIxoZE0mcQMkU1Plw3a2J1R3ML2aNxVQ==
X-Received: by 2002:a05:6000:41f8:b0:3a5:8a68:b81b with SMTP id ffacd0b85a97d-3b49703e3c0mr10826505f8f.44.1751902559317;
        Mon, 07 Jul 2025 08:35:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:43f7:96cc:da3f:e6bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm10409968f8f.7.2025.07.07.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:35:58 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/2] Enable TI SCI INTA MSI as loadable module
Date: Mon, 07 Jul 2025 17:35:56 +0200
Message-Id: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzpa2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNz3ZLM3OJM3WQzs0QjC0OzZAuTNCWg2oKi1LTMCrA50bG1tQAUC7g
 0VwAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

This series enables the TI SCI INTA MSI driver to be compiled as a loadable
module instead of being built-in only. This provides more flexibility for
system configuration and reduces kernel size when the functionality is not
always needed.

The series includes two patches:
- Export necessary MSI symbols from the core kernel to support module compilation
- Update the TI SCI INTA MSI driver to support module compilation

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (2):
      kernel: irq: msi: Export symbols for TI SCI INTA MSI module compilation
      soc: ti: ti_sci_inta_msi: Enable module compilation support

 drivers/soc/ti/Kconfig           | 5 ++++-
 drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
 kernel/irq/msi.c                 | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 666f6d7e7fadd8132f310a87d1f8ae08c3966e4a
change-id: 20250707-timsi-c66a2816c84f

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


