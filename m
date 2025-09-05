Return-Path: <linux-kernel+bounces-802853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A1B45799
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945E75621C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB535A289;
	Fri,  5 Sep 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRzLLUjh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Onh9cHH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04B35A2B0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074619; cv=none; b=ERwLZWiPk2OFNvHS4EnC+Pp26nOrY1jAzb3XYI3RrtWsVfDbuWHYdHAUdS2pMghI2FoU+tFmfnKCO611mTaAEjVjkLT4zyRZ/Uy1a1cFZuXSGHRcakzPO3SV/iEEt8c2nWO02l1U3sDGH1I3EFk4GWb9HrLZYUE/LNsONLY1Fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074619; c=relaxed/simple;
	bh=yyoLGJdIQJ+uteloafTm4myva2llzw52/YQZvjzHUsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq598PFA+g/9rmapXHy90keS5+Ut5EP2ubwiX0oYrjhBl2WW/XBJrcgCTjnenjgDi8qDbh/CKY/2ncwWVD/fL18J/B3mVI8tLTFWAsIlJDnVE2yje8f4x/eOVD5QfnDTxAn2aMsppsCzeX8sI4tWEN/fLAIFliBOGNaAdTB1wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRzLLUjh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Onh9cHH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3DaCaEgbHSXI0dlH4MV/dgs7FEd82F2fVqQWxZutv4=;
	b=rRzLLUjhu0OdiJ64w5jfGeVPDxrFCYxglax1bBYNm6OT0Fhuew7SegmPOAdgZMmQEmgTmZ
	+2kVXl2WSpEWOLgYVbE4mlMEDq9pz0fPAvmFzY6DiwT9LfZMkxTCxDk/WrWu7gEfBfSclz
	hRh+vXzenRmmuUu4HENxPuDwXTZL78ywqvHh/NsTafkHWPEON8kbeLMCuQ9c/tkAPl9pJp
	t60d7CEYZ4/CUksgoopZNGzgSxCli5ypch5mJOfyF0mO3JIJUVmOS3HjBDwb0JZ/NZDPfm
	jVEAsgmv+9sqG/TMuaYqpg2EzSKmeqjYhqnQZS4jXGksdC3HQsWwLbhGbDRK4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3DaCaEgbHSXI0dlH4MV/dgs7FEd82F2fVqQWxZutv4=;
	b=2Onh9cHHfGbR8cQcTjzjkhrorB+h8AN11CzdSoSp9KCN5w5ozFrgznV9Vdq/xmlgn24zbL
	ZKpht4Id3AOkKaAA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 28/35] x86/cpuid: Parse CPUID(0x80000005) and CPUID(0x80000006)
Date: Fri,  5 Sep 2025 14:15:08 +0200
Message-ID: <20250905121515.192792-29-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse AMD cacheinfo CPUID(0x80000005) and CPUID(0x80000006), if available,
using the generic CPUID parser read function cpuid_read_generic().

The x86/cacheinfo AMD CPUID(0x4)-emulation logic will be swithced next to
the parsed CPUID table APIs instead of invoking direct CPUID queries.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 2 ++
 arch/x86/kernel/cpu/cpuid_parser.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 411a2a96e3ed..5a3a365044ce 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -242,6 +242,8 @@ struct cpuid_leaves {
 	CPUID_LEAF   (  0x80000002,	0  );
 	CPUID_LEAF   (  0x80000003,	0  );
 	CPUID_LEAF   (  0x80000004,	0  );
+	CPUID_LEAF   (  0x80000005,	0  );
+	CPUID_LEAF   (  0x80000006,	0  );
 	CPUID_LEAF_N (  0x8000001d,	8  );
 };
 
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 227ffac6b297..44a056a5a321 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -145,6 +145,8 @@ struct cpuid_parse_entry {
 	CPUID_PARSE_ENTRY   (	0x80000002,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000003,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000004,	0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x80000005,	0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x80000006,	0,		generic			),	\
 	CPUID_PARSE_ENTRY_N (	0x8000001d,			deterministic_cache	),	\
 
 /*
-- 
2.50.1


