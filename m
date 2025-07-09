Return-Path: <linux-kernel+bounces-724165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69ADAFEF5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987861C40BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F90B226CFE;
	Wed,  9 Jul 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHy3HkPp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMYjSaXY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FD2248AC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080761; cv=none; b=SYrBjS4CqdBUmKFqmZ+kV2zggCe6ZDdcjbScJzEOFUcbCbMkeMFpZaUB+elfMhgGS6SV2coJcgKla/cwVTWTCvELc2EuKw5dgpt2KCRLHQ/nDDgiYfN8uYKauXfpZzZUXreJQ3RxNKmI/spDFOhcTubkftzO4UQqXYrI6yRN6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080761; c=relaxed/simple;
	bh=6Pf/tXMZzJo5FfKHir7iP/T7zDvDoWdK5wp07Bj9XFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWT6IK9lm71X6rPTejR2yBHep1yJ6FJICjX2X2y47GcV5k/5G7FKOBsXwzUMaU6nHn13mGW4U4SjS0IotuUUKhd1IIguAJVeJJSqhVFtwUo74DGVngW90udWMQXVePQLn9omnchRP3aSTP7SzKW0ecM1zIxdNj1MYoNjkO8YiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHy3HkPp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMYjSaXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752080754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=wHy3HkPpIZOqqCgrt9h7ps5aUl5JHTtwBsj6ZCQfhbBmQBZpVu3x7+kE2eMlHjpHfBopTK
	Dhgwr4DBGQCg2ZWO2bBGfirYTEw0S2xD7vuAdCp85b5lEHaJGjSYGTDcT76Xr1bpOw9uCl
	V1q5Cq6k8EhYEzLgf2P2SSf/nWYAGtgOBjlUAXyUFiCngRuJ9DaRYaVcCViswH5cL1y3gw
	i24/jlIW09PcPCDPh3anpI55ZGfwbSDsQOkbHqkQ/+d7hTltRx5cIZvgMqRyBZDypbWjb5
	Ck3ZIZ0vpLfCEcwn60CVYC4Le1HcY37hDV/4t01y0K+6sjgpY7lmEHhTnIwDEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752080754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=uMYjSaXYFYpwP3+k5ONdCr07onyydaFp4RdjrsYhbuO6/JVXRZlQpHBqrQ+5qg8r1V7xMs
	xFupdtmRHGdiSzAA==
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
Subject: [PATCH v1 1/7] x86/cpuid: Remove transitional <asm/cpuid.h> header
Date: Wed,  9 Jul 2025 19:04:47 +0200
Message-ID: <20250709170454.74854-2-darwi@linutronix.de>
In-Reply-To: <20250709170454.74854-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
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


