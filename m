Return-Path: <linux-kernel+bounces-688854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A9ADB7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 19:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979643ADB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54933288C12;
	Mon, 16 Jun 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="eOIHSI5k"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE051D5ABA;
	Mon, 16 Jun 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096088; cv=none; b=f5NSH2WhhSHXnNWjt4/GuY6A//9/Z18JHPOZLtb6Bk38l+Uuph2jJEHFdNfF1K82bCxKuRaortYSkDk69G7kAOCvjVTcPWeQm9+1wbiqo6m8cxpVj6uYdHuQKXDePHQb9nf6p/HIOzSDXKHQyZEg9lZmvA74vd4IbFB4Z3QeQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096088; c=relaxed/simple;
	bh=0PWGYuTB98rK0D4MwprsxXD2yJECWEas0ubLdOV/XhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4+X3hnVanTN849aOMyCRAdXYwDExYNJLd14dHU13gf3JSXODrN/MRu1CH6AnYjgO90wJPqBVdoSylG6SgLk/X58teXhviedRb77ruaE5hB7z5Yfs5EKcBb0Hn5NV8HGPBuaTR5x9FrXSesEEaQ31RzxqLrjr1yvLxpH5jIy9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=eOIHSI5k; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bLcst5LZxz9tKY;
	Mon, 16 Jun 2025 19:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750096082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HeRKymKpa0PS4yDEe9yu4PugcI3Jmnx2y84KkV52Ku8=;
	b=eOIHSI5k/6F3LjmHOCbBrOg1TDFRNTDwuXTSuXMiInjVvvE169MvsbdKLBgyfYqvZuc8dJ
	HPIvpWbuNVL5GwilsNJrE4JumHQ3Zj4aBsP16DxnPEV2ysflwMGS9gPz4058bHK1rQTN0n
	TKBP+9ketQcY5EsFw432ScPzejBqy0icjZ++dGBLl+Povoj4rKiIr3OinaWuEtxT1R59kf
	LxF79rt/V38RkYXowJJ5LzrRPggS3mXbQ3TQpXwciISrhpF9SIdsuFO3sv30lo+9T5cxlC
	UB6NpuegvYpqT1OCJ7O1B9VJvjirpQk9ddPtdPBVScQfUQzxiWVVETNkL11PTw==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lv.zheng@intel.com
Subject: [RFC PATCH] ACPI / sysfs: Replace deprecated strcpy() with strscpy()
Date: Mon, 16 Jun 2025 23:17:48 +0530
Message-ID: <20250616174748.2799-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bLcst5LZxz9tKY

strcpy() is deprecated; use strscpy() instead. Use strscpy() to copy the
long name because there's no string to format with sprintf().

In the else clause we cannot use strscpy due to padding of
trace_method_name with '\', hence we can use other kernel safe string
functions such as scnprintf.

I'm not sure with the scnprintf, I would like some commet/s on that,
hence the RFC.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/acpi/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..4005c9faf14f 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -181,10 +181,9 @@ static int param_set_trace_method_name(const char *val,
 
 	/* This is a hack.  We can't kmalloc in early boot. */
 	if (is_abs_path)
-		strcpy(trace_method_name, val);
+		strscpy(trace_method_name, val);
 	else {
-		trace_method_name[0] = '\\';
-		strcpy(trace_method_name+1, val);
+		scnprintf(trace_method_name, sizeof(trace_method_name), "%c%s", '\\', val);
 	}
 
 	/* Restore the original tracer state */
-- 
2.49.0


