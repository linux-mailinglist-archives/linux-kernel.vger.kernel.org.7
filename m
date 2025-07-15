Return-Path: <linux-kernel+bounces-731602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A215B0570C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2926F3A712F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2F2D4B5E;
	Tue, 15 Jul 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vov71AGM"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27B238C1B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573013; cv=none; b=DSOzYuaBMIMA6FTdDteVdR4tamscqWa2m6+mMSJnFI6kpUWtJJnvbKUJL++xHILEx4XTyw0exOaeWiJxa4zi9Y80vp5soJKKxUM2tirCyqLu4jCmpQtCB+SttO+kTjzFQR1R7+ASa5K1CLqr+irVupsyqiu7ebQgpMy7jZ7Zczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573013; c=relaxed/simple;
	bh=wruxt6W1EKNfHqctolzOd8XLuzn06vOEl1Dk62z2TiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bA/ZcQpHK/TKFgZ8DFADo5U/jn3D9FMKK3lrerCL0vErDHkXoP1Bio/+sq1Ix2bCAdtLSb2KZ+mym8MtVy0vcbd5oCpYqX2CkFohIrikiU/CmWnEZ5mEuo233VLuHnTVyoeinZd5TFnwmBfHUG9lbOVzd1eiGfQCidu4RGZAWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vov71AGM; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6105794dbf6so4182408a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573010; x=1753177810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHTlVUx5DqZUsuPP7cnXeDyrD2T4mRFc4Wtv3aKjfJ8=;
        b=vov71AGMZp296PYtvAGaTUlWZzqfLnj6hnhCrncGcCDwuwh1TmImZHe+9okpv2hgNj
         ZCMv1K41quwDqQRKbrgZRkvGWeyRRmfAZKFIcu2IRcuaUY9jvo3xTexC35BjflAaDDQ+
         jqZKKfkJApF4BrocjuYM99G25gD9fz3Sg1DdirH1RAL1GuTbuQAkRK1eFS56uEe21ist
         ub0j/KPCTvgOiIzj5nbvarYV0kMyFdpN4I7j/2kuSma/7bMYFA97h3QTpegNkUV02D9h
         rcsL5Fg4NhGqOQ83thuv2YhCCR9Jhkuw8ajfO5kN0yotbh3Wvw3/a19GDodMSH6E0ftN
         4vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573010; x=1753177810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHTlVUx5DqZUsuPP7cnXeDyrD2T4mRFc4Wtv3aKjfJ8=;
        b=TBqUi6/uo0PRdhyhbZ5urysM3DbwliDaTtUyLqFxDKpJhhLT/gPdP0Y/xi8jKg3qLl
         V26lPfFtWy2qyndAQWQkYx4Z5nrFKPKT5sN4jbXa2as53zS8gZ9UEaFC9y+JxABknOOI
         Bfo+uQyQSps9bvSKiEZIuPMTmEA7+Q1GYK62vO9COt5g+LrJ18tylPcollrbv/btot4l
         ChDazE2fONpfb/x1FpfK6pAWeqP51stFSDly9+QMRatEDYIFIWb3GVAMN7nsZGMiuTrO
         wxL8+b7rkVQRS/dA4krKsiMvM/nHqfeMGi6llC+mz1QQQG8hqyifYJOnvlJagZTOxuFS
         ZAag==
X-Forwarded-Encrypted: i=1; AJvYcCUHBUkRHRQht5HiqhckCwPmnwPOkntTp/RgcxTnoPwqiDKQhw7XyCXVho1c7/nQZ+zZRbGkE/hYJDOXOmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6V1HA29RuQKizEy2GfL1NaUtXeE+K7DDS8mtS5XEUE5rLYrCf
	spbbfhO4iRnpmH3DX5rksMBKm/ET1T/7F41ohP6ACefpZd5iH4t4LnmgqtO9pay18Ef9U3T1TGO
	SbiUW+xko4A==
X-Google-Smtp-Source: AGHT+IF4xTtuN4grGlrf2ySduGrYS9dG31ff9QUW2wnvANZDmyWQD/+00BdyXJv1mNjORwS5oq/itc7fML37
X-Received: from edaa8.prod.google.com ([2002:a05:6402:24c8:b0:611:d3ed:63ff])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51d4:b0:607:2a09:38dd
 with SMTP id 4fb4d7f45d1cf-6126b6923c7mr1800812a12.18.1752573009965; Tue, 15
 Jul 2025 02:50:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:50:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715095007.896620-1-czapiga@google.com>
Subject: [PATCH] spi: intel: Allow writeable MTD partition with module param
From: Jakub Czapiga <czapiga@google.com>
To: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Konrad Adamczyk <konrada@google.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Czapiga <czapiga@google.com>
Content-Type: text/plain; charset="UTF-8"

The MTD device is blocked from writing to the SPI-NOR chip if any region
of it is write-protected, even if "writeable=1" module parameter is set.

Add ability to bypass this behaviour by introducing new module parameter
"ignore_protestion_status" which allows to rely on the write protection
mechanism of SPI-NOR chip itself, which most modern chips (since
the 1990'+) have already implemented.

Any erase/write operations performed on the write-protected section will
be rejected by the chip.

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/spi/spi-intel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 5d5a546c62ea..9b41cf9caa5b 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -189,6 +189,11 @@ struct intel_spi_mem_op {
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+static bool ignore_protection_status;
+module_param(ignore_protection_status, bool, 0);
+MODULE_PARAM_DESC(
+	ignore_protection_status,
+	"Do not block SPI flash chip write access even if it is write-protected (default=0)");
 
 static void intel_spi_dump_regs(struct intel_spi *ispi)
 {
@@ -1248,13 +1253,15 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 			continue;
 
 		/*
-		 * If any of the regions have protection bits set, make the
-		 * whole partition read-only to be on the safe side.
+		 * If any of the regions have protection bits set and
+		 * the ignore protection status parameter is not set,
+		 * make the whole partition read-only to be on the safe side.
 		 *
 		 * Also if the user did not ask the chip to be writeable
 		 * mask the bit too.
 		 */
-		if (!writeable || intel_spi_is_protected(ispi, base, limit)) {
+		if (!writeable || (!ignore_protection_status &&
+				   intel_spi_is_protected(ispi, base, limit))) {
 			part->mask_flags |= MTD_WRITEABLE;
 			ispi->protected = true;
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog


