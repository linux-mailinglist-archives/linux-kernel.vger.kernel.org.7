Return-Path: <linux-kernel+bounces-777496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBAB2DA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292CC17BE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0B2E2EE4;
	Wed, 20 Aug 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IRvCZTiO"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A12E2DFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686259; cv=none; b=f+LmeoaxyVVBmJzT6UNzb54xrdHv1L/E1WiYI4fvdZC5rT1XHo2HWpjpdug+ef27SG4dXk8K9UkUgnYrZOICHacUjw1I0WcmsdMqhYAjTbeZv1awrsXbQumzMM842c/lwTZkdCiVA/io3JC8io96igq6gEf5zG0yYZEQeHZ2UZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686259; c=relaxed/simple;
	bh=PZ0ANrAaeOJ51xPAWONf3bHWi8i0ZupacEiZ4tBQFb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMJK9EAHHHPAN0l6WuqxYOFHA8/PqkzTsA4oTKCR6kHAyms9WwrD9f4P55eNPxQDXVFAkp6svK7j74llsyPvDGkaal9p/WdCRFdTl8L/dpgkm8H5uF/g+TvEh6tQ78SAtexxNkP73cTAqffzGwqOhtOSl5dHON+3oj4WQy5YEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IRvCZTiO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755686255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yFMqADKNB0MGRFxRqS2KXbYM9awsd3dLKq0MKvSGNig=;
	b=IRvCZTiOuIDl/3+uJFQfONmh3p/SAzrMQZPmbr+nrEirODERTeq1QEuI5Hgq/RGDLQ1345
	puKlSKyr8+6X1J+flOEq5qXYgGBPnKuyCBr435kUVayB2h5rlloTrmWlZTEsjp0yw1WuLe
	9gE5sVo19A7kyIExHJuA+TyoMjHhk6g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/olpc/xo15/sci: Replace deprecated strcpy() in xo15_sci_add()
Date: Wed, 20 Aug 2025 12:36:52 +0200
Message-ID: <20250820103655.761221-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 68244a3422d1..82c51b6ec528 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
 #include <linux/olpc-ec.h>
@@ -144,8 +145,8 @@ static int xo15_sci_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 
-	strcpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
-	strcpy(acpi_device_class(device), XO15_SCI_CLASS);
+	strscpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
+	strscpy(acpi_device_class(device), XO15_SCI_CLASS);
 
 	/* Get GPE bit assignment (EC events). */
 	status = acpi_evaluate_integer(device->handle, "_GPE", NULL, &tmp);
-- 
2.50.1


