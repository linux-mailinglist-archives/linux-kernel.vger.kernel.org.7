Return-Path: <linux-kernel+bounces-879010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE1C22044
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB551885595
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048983016F6;
	Thu, 30 Oct 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="g1YTeHtq"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CE2DFA3B;
	Thu, 30 Oct 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853231; cv=pass; b=c269ceP+MoqStI/Y17HByomqv30Y3L8F/lBMvJlBQIsLGNQ+8kPbisCoz/u3WlT4wM116so52SZQlXvJYyFY8pNflmQU2RN64GfmzsEXPyY9UyPrWpT8WlDyIB8v+Q3Kyf6KBwFvwOJsuGEQxkvfB2eAzTT3MQnykVHxCES0n34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853231; c=relaxed/simple;
	bh=cv1ft3PGhct9I9WBvgDbAmqB37eNL740sjipSv70E6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU7Imq9iOltD94bgsDHaA1pbt+iw77XJ5tmAOYRudnDF0znhpLn9ZzYDsOaIeFof3V0mKAoIcDcLxMSkpFnJrJWIzRwnZhX/u8/XpM69jWRmLUoJt261VzX6Gzd4GAzPe3V85WBJ3+y3Bo8yqGnzaOkUa9ZPuB5BQJ9fRxiSLV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=g1YTeHtq; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761853209; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PrTuov8G3SZg+tCWd5Y4rTGXq1p/Yu8iFJR9M/nM2Xhne8GuSO6E9HMzBWBzqm6riknQXqXghG8Vi/BzKy/C+bsjMNxNCXnfr4gSi7l/jfUSCRLH6ilk1CgEPv8NjuVvC4cyghgYFP2sy1hQOwljKM/0TQfVpMH6j2PFrqYteDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761853209; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xHAE4Kgqjxf5Eh/f0+uiZ3AjA3NIwnCEMp2CLTXX03Q=; 
	b=fgGtgrUbf4lDEljaS7P7qrG3mavYbL/oKm0tm6diMSuk3zX/J6xpX3uZHVqd9nNoHarmsNviqjGLjhpAfMTxAIu9WD1kCkkLao1ozTk4RHjLLdaFwmm7tpOj9xcyd8MQQPVCJH/1y+zlc1m1YOAqaFwXNUQJw34IVMLhhKp27LM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761853209;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xHAE4Kgqjxf5Eh/f0+uiZ3AjA3NIwnCEMp2CLTXX03Q=;
	b=g1YTeHtqC8kMYP7zOkIm+vC3psC66u2EGmlNauhaEQzzemxghMwWKRhAb9Oda55E
	8ds6m2k5w2H1zs19GIDGIZ9Vc1rIKN/C+km2HrH0TC8/JdP4xMsEXnSVpDZSa5DZ/GC
	QXS8mH0sUIZEKzu0EfC0JEXxVMGIn+V8gvPmmtTM=
Received: by mx.zohomail.com with SMTPS id 1761853206712163.04637737631458;
	Thu, 30 Oct 2025 12:40:06 -0700 (PDT)
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
Subject: [PATCH v2 1/6] platform/x86: lenovo-wmi-helpers: convert returned 4B buffer into u32
Date: Fri, 31 Oct 2025 03:39:39 +0800
Message-ID: <20251030193955.107148-2-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030193955.107148-1-i@rong.moe>
References: <20251030193955.107148-1-i@rong.moe>
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
---
Changes in v2:
- New patch (thanks Armin Wolf)
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index f6fef6296251e..f3bc92ac505ac 100644
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


