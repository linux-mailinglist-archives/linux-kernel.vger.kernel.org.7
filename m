Return-Path: <linux-kernel+bounces-601723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D09FA8719F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 12:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC34E1894876
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BED19E806;
	Sun, 13 Apr 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dEnaLEKw"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F62AD3E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540908; cv=none; b=ZKhLfSRxV2KxAIDBj69e8Kv63whgG7ddYpUb6yXneGI2H2+nkU8l2Gu0IqEIOzWb6rO8tIZeJKFS1qfBFrJ7D6iRX6mm2SMDrRcgUW1DPBYripKVe6UHcdrVZNwwhbSe2xpIft3vJOZMj9bcxCfL0+1QHm09IKaTM0LGa6QS2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540908; c=relaxed/simple;
	bh=BOW3297Y41WyxN9o70I4jCToDIFMCjKP42skFXi6u/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6d3MTrfMsD4E0d4l4nBG8JmYyxi7JAAHTrR0qGq2Ql1/yOf580M3FZaDqnOx2d5qrekI6QA6rt/HZMSTyA4t3bd6uDy7fuLth57D79bSyW9B3PIkrH/z64njPlEyRpAx3SKZ3PgMBkCG4brxbrFzBZA20OPZCTEZt+Gj4eVgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dEnaLEKw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744540903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5sLZBXFz6J0J+lLlK+U1RjUTi5QPbTvi0740hkhwlw=;
	b=dEnaLEKw7bwScZNE7Vbbe6kNtooCh1O84DTQAOyJSt2KwWkSvx6lF+qYQgLF0YJHIn4bhH
	FHnAYkjfMA1LWLTrj2EdUrBWqsi/XIPJ6OtNE76+LKjzLs2xXmuTnix4sGIS5nl3/GqUJg
	6zoOnRukC0h6xKQKominrjBCKS3t6RE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/bts: Replace offsetof() with struct_size()
Date: Sun, 13 Apr 2025 12:41:09 +0200
Message-ID: <20250413104108.49142-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the number of bytes to allocate for a new
bts_buffer. Compared to offsetof(), struct_size() provides additional
compile-time checks (e.g., __must_be_array()).

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index da03f53bfa18..16bc89c8023b 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (overwrite && nr_buf > 1)
 		return NULL;
 
-	bb = kzalloc_node(offsetof(struct bts_buffer, buf[nr_buf]), GFP_KERNEL, node);
+	bb = kzalloc_node(struct_size(bb, buf, nr_buf), GFP_KERNEL, node);
 	if (!bb)
 		return NULL;
 
-- 
2.49.0


