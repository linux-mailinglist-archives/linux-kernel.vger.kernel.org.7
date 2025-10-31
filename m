Return-Path: <linux-kernel+bounces-880501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF20C25E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB021B20740
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18F2EBBA2;
	Fri, 31 Oct 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="U1m8QEMt"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC226B75C;
	Fri, 31 Oct 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926081; cv=pass; b=NVur15bnAjhIKyoWlrF4tWzW75WyAK0u+bKfZm2PZyuEMXFZD9ukip2YcSi0rIXafOe4Z94KD1W3N+bjySya2SzLr9OB1L0t7u8rgyKnOWkQyRzTPQhGVJR1TGf/u9EF2xxKzsnhzNOvXMJKNOGdba3hfkuuPKj1Y8xw81MzKkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926081; c=relaxed/simple;
	bh=zOBsZHLcK4sIeeLybhkkbNOy6MSH7X/NcCLhwbvfl/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5PFUxuAb2UcWJphzKS38JnJ9AQLptB5Lqmt2wDxNLEiczqFvd6t42Gfk2zgGRuEdaesaWrNCUV/7sxSIRh0/fdcUQsommXg0CLIFLtvS23azAqGjvJAnKZRDSd6hD7hyG9qOvNws0xe5RGvs2c7Zh/IUc9t5DWQylTG9fPRIPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=U1m8QEMt; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761926058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JOCRlMtQ6HeTo8bhN489AUsLwrYagZn3cR4bVRyRjmXfOh8QzXg6+Yq2gWgk3FqTSVehD5CtpRPqL2gPTMD7D0htsvT5ghc0wwJiSDPz4yrgJoQyObS76p8THc7JzA0LAlgYz+b721aQTtxzihmYoqUBqmekToHN+ruXf8WRqxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761926058; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JiUC5h0HllfYs8UJFHYIQcNd1oUH7BBHMrdG0xZgEvg=; 
	b=ePcoj21tl7EMdMbmHhyDqNq4XkaHUUl2KdeWYvJFhNtDGI7UdkTgtvPmpwlfcol67f0+PegZPDCZpUXUVmH++gimXjB1AOTHIwnDCWQtphD28ZH2MMqsAw+OM5CH40V5BX9l2yhv35UbDeFKyD61aWRLObT7g7RE6niTRzITPO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761926058;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JiUC5h0HllfYs8UJFHYIQcNd1oUH7BBHMrdG0xZgEvg=;
	b=U1m8QEMtIA+6MuU6BKQnQbk7BiY66h0WCpB/9cuV76zXWCcrAD5Kpovy3lq9nfwC
	M5szUmh6JteLZ2P3QtKfgGlLPPSLGbv8hBoev1WFgxBmRINpSFtaIiDm3r7I793Z0y/
	a/qSK1f0Lz4omTAl7VDB1oBShLkLRItpEUWHPnuE=
Received: by mx.zohomail.com with SMTPS id 1761926056545830.0731351723878;
	Fri, 31 Oct 2025 08:54:16 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v3 1/6] platform/x86: lenovo-wmi-helpers: Convert returned 4B buffer into u32
Date: Fri, 31 Oct 2025 23:51:51 +0800
Message-ID: <20251031155349.24693-2-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031155349.24693-1-i@rong.moe>
References: <20251031155349.24693-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The Windows WMI-ACPI driver converts all ACPI objects into a common
buffer format, so returning a buffer with four bytes will look like an
integer for WMI consumers under Windows.

Therefore, some devices may simply implement the corresponding ACPI
methods to always return a buffer. While lwmi_dev_evaluate_int() expects
an integer (u32), convert returned 4-byte buffer into u32 to support
these devices.

Suggested-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/f1787927-b655-4321-b9d9-bc12353c72db@gmx.de/
Signed-off-by: Rong Zhang <i@rong.moe>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
Changes in v2:
- New patch (thanks Armin Wolf)
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index f6fef6296251..f3bc92ac505a 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -59,10 +59,25 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 		if (!ret_obj)
 			return -ENODATA;
 
-		if (ret_obj->type != ACPI_TYPE_INTEGER)
-			return -ENXIO;
+		switch (ret_obj->type) {
+		/*
+		 * The ACPI method may simply return a 4-byte buffer when a u32
+		 * integer is expected. This is valid on Windows as its WMI-ACPI
+		 * driver converts everything to a common buffer.
+		 */
+		case ACPI_TYPE_BUFFER: {
+			if (ret_obj->buffer.length != 4)
+				return -ENXIO;
 
-		*retval = (u32)ret_obj->integer.value;
+			*retval = *((u32 *)ret_obj->buffer.pointer);
+			return 0;
+		}
+		case ACPI_TYPE_INTEGER:
+			*retval = (u32)ret_obj->integer.value;
+			return 0;
+		default:
+			return -ENXIO;
+		}
 	}
 
 	return 0;
-- 
2.51.0


