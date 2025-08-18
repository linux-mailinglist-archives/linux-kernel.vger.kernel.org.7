Return-Path: <linux-kernel+bounces-773261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4EB29D64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871605E2046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252B30DEAF;
	Mon, 18 Aug 2025 09:14:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F630DEDA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508492; cv=none; b=d9ID+FOxN31ziYItrO8XPgfCoxmTKnCyfc7oFpBFIVpdwKnzIPWxZHmHBYT++GjoktN5p/cdifCPO8SIrQzEP2D8B4vhUoOb8twmF85bzUMphM8g3bJwkYjOEahOPCQr1DtZWoyCGiah063zCfyz1ctC640vSna42JGp3FISlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508492; c=relaxed/simple;
	bh=j0cJ6xJ3sisqIRuZ6cCe1f3gvZQGyLzDGzupo9fZRMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZNevr1/jq874gzEgHxpjhmCLCxfK7daEsc96dImQDXYk072Fd3iLapUdT0xWoJWDfXttUgBRe+jNSQh6Tm+5gDN6XteNooje9xZrYcPDo6uRWCZI1fK5ZqNlcgj+QfSYR3hJqepuaPtdZUH7MKAqtd5/DKLcWfUbJFQdwQHgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A996A1762;
	Mon, 18 Aug 2025 02:14:41 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D2DC3F58B;
	Mon, 18 Aug 2025 02:14:47 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/3] arm64/ptdump: Enable console output in pt_dump_seq_[printf|puts]()
Date: Mon, 18 Aug 2025 14:44:35 +0530
Message-Id: <20250818091436.938517-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818091436.938517-1-anshuman.khandual@arm.com>
References: <20250818091436.938517-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable console output in pt_dump_seq_[printf|puts]() in order to dump early
kernel page tables when required. CONFIG_DEBUG_WX enabled ptdump_check_wx()
already sets seq file as NULL to avoid any output. Hence just introduce a
special sentinel named CONSOLE as ((struct seq_file *)-1) which can be used
to identify kernel console output request for early kernel page table dump.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 7c42be62898b..c78e6b496dea 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -25,17 +25,26 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
 
-
-#define pt_dump_seq_printf(m, fmt, args...)	\
-({						\
-	if (m)					\
-		seq_printf(m, fmt, ##args);	\
+#define CONSOLE ((struct seq_file *)-1)
+
+#define pt_dump_seq_printf(m, fmt, args...)		\
+({							\
+	if (m) {					\
+		if (m == CONSOLE)			\
+			pr_cont(fmt, ##args);		\
+		else					\
+			seq_printf(m, fmt, ##args);	\
+	}						\
 })
 
-#define pt_dump_seq_puts(m, fmt)	\
-({					\
-	if (m)				\
-		seq_printf(m, fmt);	\
+#define pt_dump_seq_puts(m, fmt)		\
+({						\
+	if (m)	{				\
+		if (m == CONSOLE)		\
+			pr_cont(fmt);		\
+		else				\
+			seq_printf(m, fmt);	\
+	}					\
 })
 
 static const struct ptdump_prot_bits pte_bits[] = {
-- 
2.25.1


