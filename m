Return-Path: <linux-kernel+bounces-802839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A63B4578B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EE47C6024
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05E350D7B;
	Fri,  5 Sep 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KuzPDdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6iSZp6e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F3352FC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074567; cv=none; b=czD+eXhmR4cKgER8UbJlKoKmmutj2NvDZ8FInUir48cDVkQyXFb0lPokRR9BqGj554wBTR7dAlk7zfAMy+76SvyOfzgnu6YCk8oAblM2IuCSWn3M4Poii/BpjvV5S2+EDwFXPJeHAMUjTPX1zH1nuZEJ1JMRJnSgA7hN02Xukoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074567; c=relaxed/simple;
	bh=wxRYS1wSWfVVXGDRY/WxGTafHuX3koQQP4WL7Xm05Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci4VD5p7LL3g7CwtqH135KhF1bJpSGqJtq9Yl31ZNp3BovyK1RzwZ4OIE1XGOpPSllU1Oa7BpDvwo4MuKgIX3+NUg5dObyd17grdCmrWS2lY1a76x8KiAGABCv3tPAzb+leOtN3AEgZr5dvaLzmpt9tIEpqC8I3F9b4lt/P20N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KuzPDdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6iSZp6e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIy4/xYKlSbEAWwZB7LbxZ9FECOWkxRxcaIrnJxGy2U=;
	b=0KuzPDdgkiITsWB0SO50RDoovlgl4She+dIzmIMBzTF5kQ66lVNF1ZJt8VhdugZrNwiu5C
	opDyfJFJmepT5g73OR3e/jQsmg8RZeAsJ7XBaNADq3MG4hkQAmcTMvorjoLAsj9W98RuDN
	DqFhAlV6fV5IYsOimHXT+ZOzDM8KfaO6oocOnnW38lsU7EKh3DUQY8FsOWBGPR61XlFdDv
	whAuREqJ3YFSJDLdDMj+yl4FRLMpaHfqNFv7bQRf4ovj9BsyBKYNocbGxeXUHB2B8brlJL
	aGzleTlm0NpIXYbmwsBwWrdBKpyOf7JhXgr5xfOz7BUB/6SiSsLwrlJTjMmK9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIy4/xYKlSbEAWwZB7LbxZ9FECOWkxRxcaIrnJxGy2U=;
	b=E6iSZp6e5TMVZrZTudWzUqkC1Dup7GbjwGm85O7EEzohJprdwq4fW1OlevsU2bpEgQBXua
	RfCjv+LOw+mLuiCQ==
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
Subject: [PATCH v5 14/35] x86/cpuid: Parse CPUID(0x80000002) to CPUID(0x80000004)
Date: Fri,  5 Sep 2025 14:14:54 +0200
Message-ID: <20250905121515.192792-15-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID(0x80000002)->CPUID(0x80000004) support to the CPUID parser.
This allows converting their call site to the new CPUID parser API next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 3 +++
 arch/x86/kernel/cpu/cpuid_parser.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index e57245ca6419..6f4da51126b3 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -237,6 +237,9 @@ struct cpuid_leaves {
 	CPUID_LEAF   (	0x0,		0  );
 	CPUID_LEAF   (	0x1,		0  );
 	CPUID_LEAF   (  0x80000000,	0  );
+	CPUID_LEAF   (  0x80000002,	0  );
+	CPUID_LEAF   (  0x80000003,	0  );
+	CPUID_LEAF   (  0x80000004,	0  );
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 39a361eed7ce..c56c3dbe39e1 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -112,5 +112,8 @@ struct cpuid_parse_entry {
 	CPUID_PARSE_ENTRY   (	0x0,		0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x1,		0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000000,	0,		0x80000000		),	\
+	CPUID_PARSE_ENTRY   (	0x80000002,	0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x80000003,	0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x80000004,	0,		generic			),	\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


