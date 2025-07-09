Return-Path: <linux-kernel+bounces-724441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D1AFF2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A63B8FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6424503C;
	Wed,  9 Jul 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnqnl2Z/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THNCGLgC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2012441AF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092839; cv=none; b=pU+ATAy7zDTe9R209bGfpN3ngOyiMJnBlCzJW5RQ4NV/TT6/BLLHt2GiopHjpHioanXO9inXvoqiTkMFncelYZUvz+tv2DoxP2eudzCKhV7voEVUfnOZzVhdbQs8JsMSj/ZnavtbQjG6PbqNCsRT+BOO95+zyXE9ZI1iG1a8nFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092839; c=relaxed/simple;
	bh=6Pf/tXMZzJo5FfKHir7iP/T7zDvDoWdK5wp07Bj9XFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2xyPXgFH9gGxvjj6ar66t1JgG30BB+9p0biwgRHqN/XMlEm0PSvRbnAx1YwCmfMxlweB6JAIoGnTX/ZvEWtd0tsB5lgqEzLGiSNZAhH8vRmSzpddGA9QeOpmnna1zDC9p1+uQLVZBAf2JvuiihsTkJgS8SNgbb5wMKEAIODyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnqnl2Z/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THNCGLgC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752092836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=cnqnl2Z/knFAkZ+/Ido1VcBVxiyrgPtaCzottgyo++LOv0HLZxPWBOj4txvZkVFT8O1KaT
	byZScfMap1As/EVmnjku01fjyVO4iDC726Fe8SQxusf/z/yIsAfJQWyRQ9yWfCgS36qNYe
	hPigymyV1P/510QFJaZl2eTMY57+Oc2lYvsYMz5DPrfJrLBKG0/LnQY9hFB48GPq5CMKER
	Lt4xPj1df19iuaS530uazYU8JGOXcGlj8YfyOqmXdbG1LTBhy9W+yNX0v2i1Zx3+/unHqW
	Xq76zY8gv/CArIwiKJh4c8bryQSfSaO7CQ466OsdnzGT6Oy7fO85WsRA+pX+8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752092836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=THNCGLgCGzdGPTjP8ZPTIiEgexODnawEGGOxlV8F88AGHM/Tnxd2NeMGyobLdTpVGf36zI
	d/qo1TWlsjF8gWBQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 1/6] x86/cpuid: Remove transitional <asm/cpuid.h> header
Date: Wed,  9 Jul 2025 22:26:28 +0200
Message-ID: <20250709202635.89791-2-darwi@linutronix.de>
In-Reply-To: <20250709202635.89791-1-darwi@linutronix.de>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250709202635.89791-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CPUID call sites were updated at commit:

    968e30006807 ("x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header")

to include <asm/cpuid/api.h> instead of <asm/cpuid.h>.

The <asm/cpuid.h> header was still retained as a wrapper, just in case
some new code in -next started using it.  Now that everything is merged
to Linus' tree, remove the header.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
deleted file mode 100644
index d5749b25fa10..000000000000
--- a/arch/x86/include/asm/cpuid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_X86_CPUID_H
-#define _ASM_X86_CPUID_H
-
-#include <asm/cpuid/api.h>
-
-#endif /* _ASM_X86_CPUID_H */
-- 
2.49.0


