Return-Path: <linux-kernel+bounces-837987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6218BAE2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868373C832C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6530E0D2;
	Tue, 30 Sep 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRrrNp08"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90D30DECC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253308; cv=none; b=erN3yyF28QMc2ZHTRZI4Ru/qS+BbLXql4AnjUprzudHXPGXLDVzZ8qxhuxfwgTly37HDpTr7GlDiPqjMy1D+55Sw7dXDzIb0UFXyzZz7ZeIfMUGq0w7etj7wqcUy7Qc1O4NRCpL5ZfvSNMELyn8RG+3yt8byhxSXzZNWPCB37e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253308; c=relaxed/simple;
	bh=KrTQB7PgRxp34y7cFtkblAYnQMqdb2JiLEULqBQSkCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPGcZZe2zQrfDyrufTcyDRGo5eaEoSdSS1OLlfNen0ye+NAHsaBtV9IKlYgynGdYg+i7P1jpJgTX5bTZb90jToV10b0ozIB2HvHBdYuVHqCig1zMzIxJD5lcKup+++oxd6CxjwvkpEyUjPjp1A0Pt0AimQQxLY3DqMMT/F48E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRrrNp08; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759253304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC4FyXfw0oGrhWfpjrh5qQ64FL3jW6VwW4LA8vLTtCs=;
	b=JRrrNp08o+mbjPWZu+3u11M198BzYWTGNtehKXhR2TpdbHNgG2YhWZy5y4pA9cOXHFp9wx
	AXPcGTZJOSskov+QgtIGvAXD3RScn5tWkgIfa8KCQijxe2T9/HG3EBOZhtG1eoZsjLUnaH
	LsTnl/116wRUNVbdLzG8zOZONPhC8Xg=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 4/6] ACPI: PPTT: Remove acpi_find_cache_levels()
Date: Wed,  1 Oct 2025 01:27:29 +0800
Message-Id: <bea1cab6fdff72bc703c40621de8a0b1744f61a6.1759251543.git.wen.yang@linux.dev>
In-Reply-To: <cover.1759251543.git.wen.yang@linux.dev>
References: <cover.1759251543.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit fa4d566a605bc4cf32d69f16ef8cf9696635f75a ]
acpi_find_cache_levels() is used at a single place and is short
enough to be merged into the calling function. The removal allows
an easier renaming of the calling function in the next patch.

Also reorder the local variables in the 'reversed Christmas tree'
order.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Rafael J. Wysocki  <rafael.j.wysocki@intel.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-5-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/acpi/pptt.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 1938e4778725..01aae0f203b0 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -286,19 +286,6 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	return NULL;
 }
 
-static int acpi_find_cache_levels(struct acpi_table_header *table_hdr,
-				  u32 acpi_cpu_id)
-{
-	int number_of_levels = 0;
-	struct acpi_pptt_processor *cpu;
-
-	cpu = acpi_find_processor_node(table_hdr, acpi_cpu_id);
-	if (cpu)
-		number_of_levels = acpi_count_levels(table_hdr, cpu);
-
-	return number_of_levels;
-}
-
 static u8 acpi_cache_type(enum cache_type type)
 {
 	switch (type) {
@@ -621,9 +608,10 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
  */
 int acpi_find_last_cache_level(unsigned int cpu)
 {
-	u32 acpi_cpu_id;
+	struct acpi_pptt_processor *cpu_node;
 	struct acpi_table_header *table;
 	int number_of_levels = 0;
+	u32 acpi_cpu_id;
 
 	table = acpi_get_pptt();
 	if (!table)
@@ -632,7 +620,10 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
-	number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
+	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+	if (cpu_node)
+		number_of_levels = acpi_count_levels(table, cpu_node);
+
 	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
 
 	return number_of_levels;
-- 
2.25.1


