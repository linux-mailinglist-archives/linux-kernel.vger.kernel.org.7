Return-Path: <linux-kernel+bounces-880083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D5C24D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D3B4F2CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00C33FE0F;
	Fri, 31 Oct 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bItUk9H9"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780922E6CA8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911199; cv=none; b=tK7rfmMaFmABaGaqIHDI7vo3446eFos2iNBSJ2m89SWeaeAqrWmHVBSzVTRnisnlEpyRElGa0C43zXkuUw0Fwk1SMJD1PBMWjwvWxif8fClP52Q4z/Yr6UzYTxU5SZId4cf9a1oIgfHwnGZTT9KM+T0yZZ7PI7T8jQBbzKXBxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911199; c=relaxed/simple;
	bh=XECehUmSI7TK5rOPKBoCkm+0nPhV+OBi+2SN6lu1Qhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQTkeeCktVw9cXF/dTCwSjMQeXTHItcZJn26ZaS5nUNerfeZyWBsS08joH/vRgMUfhof1VALKKXc4dDMgQdQHrdepbxUIqc6yKHr8Nwgn7kUE16ZPIeoYgACj7BZBy9xIpnh5/NzytHIpadPAe30E8lcxeZR6N0Tu6UbzKWRCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bItUk9H9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761911184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zbOtzsUl4rD3ykr6Of7jeUrXRsx4bYIw63wLmw7EuHM=;
	b=bItUk9H9Xfap4X2NlmME0KtfIs9oop+LJ3bjw3mlNZMn5Pk1eF1u/+JdUZIpEsucuCWDyO
	Ffa7mA9YacCxhRDBHFdFI2WPJxtbFzhW3LN26yijYo3f7W/8NJ/cshcOY/elFaXJqLQ64d
	LuuYnpYYfMKisMGYE5gX2dp4HSro9uQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/ghes: Replace deprecated strcpy in ghes_edac_report_mem_error
Date: Fri, 31 Oct 2025 12:46:07 +0100
Message-ID: <20251031114607.133523-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead. No functional changes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/edac/ghes_edac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 1eb0136c6fbd..d80c88818691 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,6 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 #include <linux/notifier.h>
+#include <linux/string.h>
 
 #define OTHER_DETAIL_LEN	400
 
@@ -332,7 +333,7 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		p = pvt->msg;
 		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
 	} else {
-		strcpy(pvt->msg, "unknown error");
+		strscpy(pvt->msg, "unknown error");
 	}
 
 	/* Error address */
@@ -357,14 +358,14 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
-			strcpy(e->label, dimm->label);
+			strscpy(e->label, dimm->label);
 		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
 
 	if (!*e->label)
-		strcpy(e->label, "unknown memory");
+		strscpy(e->label, "unknown memory");
 
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
-- 
2.51.1


