Return-Path: <linux-kernel+bounces-776221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E069B2CA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC6216AF12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89102C2348;
	Tue, 19 Aug 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LdKA+KXR"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113920B1F4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622790; cv=none; b=NM6Eg8SGaPsRmlHk7PniRGRX+WY+Ow4S63rya+vPEf3+Gg90VCfcd8jiV0a6vCQsWxwFFvkvdPg6pcCtRpFPt1QgQTUComzFgWTpw2/lgjqDcYa7U3quXb8ljuriaQ2eSzR6p2oGiEtNGpFkINmTdtPjHGjXe4EOM7wyWb7F7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622790; c=relaxed/simple;
	bh=rX+rNY+IHuHP3S8qk86RqaUVoalZx1ZtIgryE9LSZE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1DKQdBEs6p5LPi2giAW54ZWqnY9iZCLqiDEBX7x1/CnFe8w7SS7z9VLFPqXx0gDJkLS6/HmQPaTbh+er+hEQPdkK/Z/Zfr/ve3Cwwi8p1YEHsPyLl8FMfHHPnOAk3l0TEe2zxThegFLL7HiWgwmBm/jIRXzHAOEvzIc4JOgERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LdKA+KXR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755622784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8cP+VflgCVNtVf3f9XKodv6qzOPG+U075h9FA37e9FM=;
	b=LdKA+KXRzXtZpB0v3KtcG8Gs6/M5Cg8Qdz8KMxGwO6r4rvE8A2EmKAGRDjUnNQkbhjyYPU
	Mby6P09sUzosolNNbCKMTa7aDgYFf0W4k04Tx6/FmP5JrRa/GQEogfsdAf/oVQshpUbXqW
	XciK4c4zf6Pvqw40hhxMRmetDTfLSNI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Use str_write_read() in ps3stor_read_write_sectors()
Date: Tue, 19 Aug 2025 18:58:29 +0200
Message-ID: <20250819165829.714344-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_write_read() helper function
and silence the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

  opportunity for str_write_read(write)

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/ps3/ps3stor_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index a12a1ad9b5fe..3d4d343ee0c8 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -8,6 +8,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 #include <asm/lv1call.h>
 #include <asm/ps3stor.h>
@@ -265,7 +266,7 @@ u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u64 lpar,
 			       u64 start_sector, u64 sectors, int write)
 {
 	unsigned int region_id = dev->regions[dev->region_idx].id;
-	const char *op = write ? "write" : "read";
+	const char *op = str_write_read(write);
 	int res;
 
 	dev_dbg(&dev->sbd.core, "%s:%u: %s %llu sectors starting at %llu\n",
-- 
2.50.1


