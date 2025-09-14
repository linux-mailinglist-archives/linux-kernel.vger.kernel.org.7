Return-Path: <linux-kernel+bounces-815732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7120EB56A69
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A0942143C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676852DF15D;
	Sun, 14 Sep 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olH83F8w"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FA2DF716
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865483; cv=none; b=XVxbeva4pne6bgk68RQEw/S8xhwU0Tph6yc26hFpZO+YaVCbWdYuShT9l+XFjn7aB7TXcW/ok043OKONYtowS2GOmHs+HwBArDIf/i73XsDoWOe6e+mqB1hHx7JSZAwk5sMDqJ7NMjaIjbEe4zY2Pretxtn1smYUAoVdJiJkg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865483; c=relaxed/simple;
	bh=hm46ej6Vrko2gXSPA8dx5Mt413MKshcRC/EPBjHNg1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dv8XbMeroqKzkCW+NM+ZTKFhDkrfWiDhuJdODLb4cFhj4uZ9gbySd5p1EIBu9v7BFNoUcb48ohiQpFuN88eRtdq9ZYZ6pbSpp/cVJsR68r2gG1Psl9t74RSgzD2hknQZJ7vPf7TMxrlfukiIsmQ7adl8gTLPRclicyUBUDPZKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olH83F8w; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htk5PcwaQftKiGsMJqYeQtYQUBUiLxMymGVv6gN7xZ4=;
	b=olH83F8wgczFIvV/zXwm9AK6p4yvB3IoUlY1wsnmb5BvFZJ5je1oYbt4xZEHYXobibzA9h
	EaTHrYdGcZ4CDfmfl029hwowEuCqhSOC1zapyHqJzoqbUEXAY86wZaLce2G+wB9A2IdHyu
	atWWAzdXObkVreIYQFdXQry1KnOlmtc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 6/7] asm-generic: percpu: Add assembly guard
Date: Sun, 14 Sep 2025 23:56:57 +0800
Message-Id: <20250914155658.1028790-7-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, asm/percpu.h is directly or indirectly included by
some assembly files on x86. Some of them (e.g., checksum_32.S)
are also used on um. But x86 and um provide different versions
of asm/percpu.h -- um uses asm-generic/percpu.h directly.

When SMP is enabled, asm-generic/percpu.h will introduce C code
that cannot be assembled. Since asm-generic/percpu.h currently
is not designed for use in assembly, and these assembly files
do not actually need asm/percpu.h on um, let's add the assembly
guard in asm-generic/percpu.h to fix this issue.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 include/asm-generic/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 02aeca21479a..6628670bcb90 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_PERCPU_H_
 #define _ASM_GENERIC_PERCPU_H_
 
+#ifndef __ASSEMBLER__
+
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
@@ -557,4 +559,5 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_GENERIC_PERCPU_H_ */
-- 
2.34.1


