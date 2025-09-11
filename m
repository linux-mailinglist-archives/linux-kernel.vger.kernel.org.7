Return-Path: <linux-kernel+bounces-812023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962ACB531D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555245871FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1ED3203AC;
	Thu, 11 Sep 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYWNWnOy"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C930BF5A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592901; cv=none; b=u4tTrBXRFKoy7OndXHYg6y9H2DImPvUaLKUsGIJv5/mW6cBGdhNB5Y367sPRITQhvisITvaLLIKKYozo68rX/eOXZazUDkjCNqPsTl+hjPrVRd3jeOZJcyvVMy7mYjTyoPxvQ3OW1A9OzXjAbraiEcPhgOQWw+T1DVhrqmFTDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592901; c=relaxed/simple;
	bh=2sO+DVZXh/7ePgmsdKci7CudQiQa4F9VcP5LQIwNDEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ealFGxIIQaxTY3rjijVvLArDBQt0guhFiUyPHuHPHaM8Er+pUJNN1tDPSP3SzV6TEw0It83oCyI+fXeAOVVQfUBdYxSBG9UlNgQlJfSAEa9eaDDo9f3EInnbGxe88hAfIo1a6EtE8gmdZDIjzwN5uOkURUWRC60FTmzbtUgO5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYWNWnOy; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757592887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6jY+NSNeTG1AR6VFAUnjneRpFWvTY45p03yTsBUBKrk=;
	b=oYWNWnOyhcIl2n4JD9ChJ/OOC5sdFHBkU0lPggQSC4aN99Q4shUApo01da/F4xe/xXezhu
	j8rTNZIX0DNsr8cq0n0fFyDtwc5X5iwqThWdAYj+2TJ+KNTGr9nzd2vD9G64TZ4QzFpVzV
	m90V6Gnx5upnms1jAoipRfv4o6pnAGw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/olpc/xo15/sci: Replace deprecated strcpy() in xo15_sci_add()
Date: Thu, 11 Sep 2025 14:14:05 +0200
Message-ID: <20250911121407.1388703-2-thorsten.blum@linux.dev>
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
2.51.0


