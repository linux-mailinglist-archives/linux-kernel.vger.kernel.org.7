Return-Path: <linux-kernel+bounces-745776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73038B11E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831B31CC1B41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956F2472B9;
	Fri, 25 Jul 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20mdoutg"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A217F4F6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446353; cv=none; b=Kt91G2fiorRjK5Ir+G+IvAxkZC9vSfzMI6HvRCJZDO4tCsnmGYinU0WXcSU7Rk5NmDrxZ7SrQRq8M3z+YaIVMpFajbSeZAGay//LwETUVRTfkwIdYbs5h7WX2AJKStiyhHrc3uoYvEhex9ec45vWOKZ/Pb0hfUdqUlBoyjd2/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446353; c=relaxed/simple;
	bh=LOYLkjbXhcH+ilHZffi4sjyHur7OymnIgTTNEtoZ1k0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjzb/LZXdD6OQSYzo4t+mXhu31JlXNYr3jdehG+FEgfE15rctpMZoB+3xnsNOOe7b5aSjo2xq620aNxuCvQ+KC5fD6Ul8ry9WBwVXgDI/B8Pdvx32ZxXr9/SeRgZQgppr/ejl1si15su72nAdoM/mVRvZWfjiMK9K3JWcRRKfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20mdoutg; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so3296416a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753446350; x=1754051150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXj3Xdys3QrrKKgv1sa3/X9PqgLaz4asqSAvalf0x2Q=;
        b=20mdoutgifmUs9uc3Hd20LH1Fpd9RPmy7Monov9hgtJWvfhvwNN0E/m6UBTP5u1QDZ
         5PqOqHv9Xhg+x73oHoy0FUaYI103y85Mk1xagYkBIzkjYM0IFEDBcrx80yVJbjS1bxdX
         bxV4xWwIjgHUZhS687k1INajTkEJgIe8jnmCF6VpKitHHNPyt7kPOozVydUArCBm31rV
         T3MzAg6rqOrgWO7SL5bhL3jL/26hDbWqzNJLhzjxLt1/clVwI+0ZU11wRkUBeJ3HRGF7
         nobggw0t27eb4XpB+/KBJT+LkOCXwepgIMevl+OeVpjHGO0J8Bxknzmhcfja8nXgGR8E
         15UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446350; x=1754051150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXj3Xdys3QrrKKgv1sa3/X9PqgLaz4asqSAvalf0x2Q=;
        b=P576Lxowu4ZUx3KK9kqXDu/K03qrP+cH6ODvwIsv+jluAg+6Cz1IznNpuqXjAg9o9Q
         sm1VOAU4Z5lZTYLSgEok9CAzSSMLyYK5gbtW83BTn9fE0rX/3sLLov2wE6keEqBI1DEe
         3ECIRfb2wULBA5HG8Q7mUSlzk3ck/+Zy9IAXN2anTwAxxDXk2eESnq5R3jPqUK2K+6z9
         lH1ZNGDL79u11U9aQ1NrRwWzWoX6zbavubCoDx390AJ6JIeF4bwRvk21kIIBnZb/aAdo
         VI+j5UKU2YF9VwlV6WZT2eyf/sSWMnFV/9yFtMfWaZGlLkl0ja6KBBi+Q9aVG2b64Fcx
         Z5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUL32I4UeYtbxoAcTAp72IcIAWXPBsRjqi4vooJ29U4Q6gk05ZN21DOnJPocg4OYGhtY+Fl67NWOlqO7hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvywjebKrPPPN6GR9M68h5pmdTAdp6+kNFNDKNqxNTq5fY+Gb
	W/VId0RjiX3NHI0MCHVOQ9P+D/bsXcC44FEWYJrjtQ3kQFJslKuPKtq+cDkmPOqeCk+woqr9CU7
	tZxC0DcgZyA==
X-Google-Smtp-Source: AGHT+IFFSWIcFtjKAeMMISoRrrjPhKRBubbppj2Y6256RlC6tXLX6FooJI+2421lfUE9azd/4D6RMX+RCT/e
X-Received: from edbcn2.prod.google.com ([2002:a05:6402:ca2:b0:60c:3df6:79ae])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:254f:b0:608:8204:c600
 with SMTP id 4fb4d7f45d1cf-614f1bdda7fmr1679938a12.3.1753446349802; Fri, 25
 Jul 2025 05:25:49 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:25:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725122542.2633334-1-czapiga@google.com>
Subject: [PATCH v3] spi: intel: Allow writeable MTD partition with module param
From: Jakub Czapiga <czapiga@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Konrad Adamczyk <konrada@google.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Czapiga <czapiga@google.com>
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
v1 -> v2:
v2 -> v3:
 - Fix typo in the macro name.

 drivers/spi/spi-intel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 5d5a546c62ea..13bbb2133507 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -189,6 +189,11 @@ struct intel_spi_mem_op {
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+static bool ignore_protection_status;
+module_param(ignore_protection_status, bool, 0);
+MODULE_PARM_DESC(
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
2.50.1.552.g942d659e1b-goog


