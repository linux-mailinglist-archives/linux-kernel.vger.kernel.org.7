Return-Path: <linux-kernel+bounces-770339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F2B279D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89489B60381
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084572D0609;
	Fri, 15 Aug 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wp1knzp5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6B/beOud"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137E2F0C6E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241588; cv=none; b=jNJzx92uZKqjaKvFeArwm/aU6xMAf3oTUnm3Al6O1eWoAVMsnuSv4v99hdqzecFyWAadPLwKE/dX+GKiPMm5HqduHkXeHOz+4yuiWlZDYg//aelj04O1+adWur5Oh+Pztk9cltiUbx9A4Frt1KtCQZrvt6kEQI1jbUKoHTlq+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241588; c=relaxed/simple;
	bh=gyZUptt2IsQjhqA3X3eQEHnOC/AsGsXLCm7Asp25vY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USpW4DrZmAf12+ewKaRb05idmG5OUxDHy5d4iTZmLZHdCR3B+6QN/aghTxIi5YdNC3yX7hJ54nt4iPtTZ+sA/Uo4FP36OFWAmguhHxBq7HRwGuVR6HZ372dUw7ZhWhqgrmdDilw+1A7bQ6UPZzTQqROF10QQHqUb1QN6hwxVRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wp1knzp5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6B/beOud; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/n8oqd98dT0SIV4CQd/E9sGuMKHx/eiHVyLEDEKobY=;
	b=Wp1knzp5SC3gZMfQZRtzyULH3xatJ1xYUkEoF9PnCIcBELrK/sTisO0CahW9g7M0bgFcyD
	DUx85f0Rp0MAJzw3AG/MrjFUtX8qbZbAw8AplFDTvxqrs1EHdhvlTFIY9WtZK9tIZg5rJ5
	RD2oiJkg9j+aZjXDZj6ihxxCM/JaT6EcxQlI/8wNBwQNf82EDIZfBi29aKuruznJDWSdZf
	L2xmY3GN6owZ7Z8dTPxH9zYPvMCPJz/hEj/CApUHfYPp39VtWll881cVPM1CckiKo6602Z
	8xbKbhu/NRrEIexczUZDXfvmfFSrqZtcHjbsY4wNOr/fA6JHyn2KswhWEND/Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/n8oqd98dT0SIV4CQd/E9sGuMKHx/eiHVyLEDEKobY=;
	b=6B/beOudd1S0F/26O24xl9MYB191U+356FZBeuYoOfZ0lXibog7VGZNJtGFf/xhU61Lw+5
	MwXSXeLPf6ZFsYAA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 26/34] x86/cpuid: Parse CPUID(0x80000005) and CPUID(0x80000006)
Date: Fri, 15 Aug 2025 09:02:19 +0200
Message-ID: <20250815070227.19981-27-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
index 89c399629e58..63d2569e2821 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -218,6 +218,8 @@ struct cpuid_leaves {
 	CPUID_LEAF(0x2,		0,		1);
 	CPUID_LEAF(0x4,		0,		8);
 	CPUID_LEAF(0x80000000,	0,		1);
+	CPUID_LEAF(0x80000005,	0,		1);
+	CPUID_LEAF(0x80000006,	0,		1);
 	CPUID_LEAF(0x8000001d,	0,		8);
 };
 
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 15ad37b0b3b2..1d0d1a3c2bb8 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -130,6 +130,8 @@ struct cpuid_parse_entry {
 	CPUID_PARSE_ENTRY(0x2,		0,		0x2),				\
 	CPUID_PARSE_ENTRY(0x4,		0,		deterministic_cache),		\
 	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),			\
+	CPUID_PARSE_ENTRY(0x80000005,	0,		generic),			\
+	CPUID_PARSE_ENTRY(0x80000006,	0,		generic),			\
 	CPUID_PARSE_ENTRY(0x8000001d,	0,		deterministic_cache),		\
 
 /*
-- 
2.50.1


