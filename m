Return-Path: <linux-kernel+bounces-796811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E06DB40797
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B7580102
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA831A544;
	Tue,  2 Sep 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FTrOIoTy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FE30FC33
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824236; cv=none; b=JnBLLh3He5S3j0HqTW91vDBWfhtRH46Vocl4prtJ3hV0dksRDkRnYgeZT4ETlqPzn/CwOR2+r5XY5Qmcjb6RSRjrtdbarPOBX7afO0kfAWbCGxf1wGwE46Rb93KdZsNUwCSmA3acSXorFDeswNQhflY9ZiXWWXHpqtgfr24mD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824236; c=relaxed/simple;
	bh=xtnSmWEBlviExpB5Cp5+Un++wfPxj4bQsxnJXXQLPxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UOZFOZgRK1+k5/pap51Elur4YcZqXWrHiH9RE+figf8yoO+mYkW1ltBdY+YrEMxUrAIgACX1L6xcH7JTX4xNuqimcVU+C81aWwtMZw1cPPBthz7C2EATunuy+XRuGnCDSvEgDY+NjqoGe0RFG9FrTMKiM0z634fBt/S5sz11hsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FTrOIoTy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so23881685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756824232; x=1757429032; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90ocVc/YJC3isdTykofnEb+YfRvmtfJI6WUnAmF/m/g=;
        b=FTrOIoTy01ZfeEkhbXJfzSpI2PAEAkK2KMShh/NnmaO21E/C5zI0aSx8iRLBU7PNsw
         nf4H1fnF22yUwS0cnyj+TsZH3I/n6mvKcBAWUp81t9jYHujiFAt6ifrx4t8+QyoMtc3R
         JpUydjQmn/u9TcrulQ8LcY15fISJAeTIewSa9/sSN/FX9n9hE/T2BX2jVDvIyx8nZbsO
         jM+rLUgvEP8kYTIWo4vuhKx4UMRSOI1AZQBPLO72Xk1MFzzgRoWfOVJ4E8ncC9aVsPxl
         oOfyCC3anXX3BWamAFKZEPNoshwcvcy6WXehUn8L8CHnsnsSp07kToCFTSyrTBbr1ITQ
         GjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824232; x=1757429032;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90ocVc/YJC3isdTykofnEb+YfRvmtfJI6WUnAmF/m/g=;
        b=cZjf/SWuHDIppCurRSbznDb0uzivt+l9ZCW1AEU3PH+KYOf0ERDv/TSUCu1DXB53oh
         f5l3L5r37xpjBoaRypmCTko5Ni1qAdY0t5GsLa5Xbioag7qmbJOnLC3yhUSg+kMXdFos
         DOOtCtC/ppR/tiYz7Cah/pUrbi6l7TnUITPZy3zdDvmdbFml/5j7IeFnxayc8AxIni+u
         ahh+/yc5+g56bHf+bl61i+KE/mv3avZ+NezZ5wnbeWYkAaCahS0KKCSaqwQarAZKNFTh
         mLJiagEkKX+1z2LNOSU8FfoJRhN16WC0WaUZTxsNsZ89V99OLvt3HpjoUBP0e9RXbjfa
         q3bA==
X-Gm-Message-State: AOJu0YxK1pdrTlOy53noIvKsVzQ7tJlvAeR0noD9LkBlLpjApS1OhdP7
	1SDyQL2NOWCliZ3kxuUNTOyzBnp8swIKR8WjX4Jp5noyO9C+PGAXtg5iVOfJhaEJuE8=
X-Gm-Gg: ASbGnctkxiX3sjqapPGIsADJ1E3hoPlf3/48uL0OXqpVQQZHUpYb/+NiOfRQOOIBCoo
	IPc3pW80/fLxd4EnmUyZTmTqx/n0U8p4aulFXl8I/UWwNc7o6JizQm6eQias1fvOHEVBOY+PGNI
	yxejFI3x9ZtsI4NQvEVPz/ViUZcJx2DbdThARVvkRvHX+tgVX9PmA0LjPsS2Mqacizw7PcocmIu
	0FHZprR7kzvGnT9QUkjz6vPND9PJSSBZhOV5o+QVCMUxdsh4HzaqVP00LRQtVbIEmJfpO1LJ/hn
	dZmwC7wSgr+9uSWz78Jyvv/SE3g0eqbjrv5NAjdL0jT0uZdAtf5IeD7R4xaqFxFNVis717fpWRy
	psj+TBu2AQW6Bw2BOQRLjWGGB2vZAuw0VBihR
X-Google-Smtp-Source: AGHT+IFMkODIxexa64qaDsiP0rdu+jkcSKh5+xPuASKAkLpcnKLSE7yMQp/f0qku1r+x1P9TGQiZMA==
X-Received: by 2002:a05:600c:1d24:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45b8553d964mr84047225e9.1.1756824232406;
        Tue, 02 Sep 2025 07:43:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:5982:3242:38ad:8b12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm209604635e9.22.2025.09.02.07.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:43:52 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH RESEND v2 0/2] Enable TI SCI INTA MSI as loadable module
Date: Tue, 02 Sep 2025 16:43:48 +0200
Message-Id: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
- Export necessary MSI functions from the core kernel to support module compilation
- Update the TI SCI INTA MSI driver to support module compilation

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v2:
- Fixed patch subject
- Replaced 'symbols' with more precise 'functions' terminology
- Used function notation with parentheses for exported functions
- Link to v1: https://lore.kernel.org/r/20250707-timsi-v1-0-80ae43b2c550@baylibre.com

---
Guillaume La Roque (2):
      genirq/msi: Export functions to support TI SCI INTA MSI module
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


