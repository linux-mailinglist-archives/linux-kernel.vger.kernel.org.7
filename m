Return-Path: <linux-kernel+bounces-724170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442BAFEF65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6997B666C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9B233728;
	Wed,  9 Jul 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfTyIShj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+2xPt2E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF36224AFC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080777; cv=none; b=OExnDf0PNtO0brFy08BnerpgiLwno/I0jU7o2SMNrG97GB+ah6FeH+N38lx6oBYeoG2NNqB6SdMseG8s8L7kVW7KrvJ6lCRk3YJDZR+cUXd7fMlfHau6YQxvHEPkOI4x2BWr7Km5ltt0A/qBK+lhH3Vbgj6QXA+nLfspvxtpGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080777; c=relaxed/simple;
	bh=9uy/g7L+3Cv4tJSN6mmhFqinMDgYIzSRDOpxmCmPnT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj6ZU/JAUGGZd+gEvavty6t20GIlx76Bkg9vgSXz/BJ4D76RlDJY6H5YAWsIEQozQhzK0OgJahojenzAc/CSIr4oyFHAX1zeS0JaMyqkPywadkGFTkzH/x9JijDkdKiFkHtnVTbVLTpxR7g+xsRRl/Pe9vHbvxF5uDoRDnrSRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfTyIShj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+2xPt2E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752080774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQWs/yvwZcPLrNnawPJrh/g2JjW0m390/lOqwFLduNU=;
	b=VfTyIShjSoN2i/2/NsLseNnP7G6tU+ZSlb5hluvpBsu2uo89n74f7HhQ+LjVdK77baWdZ7
	zP6bj+vFY11mSBM+6h526VycDCXGOueq6e/CzfDU0lcZODlnCrKzLPhonkT1DSNIkW1NAb
	muUUfSm3SKSBRRfi2kOYJoKmaP4bxHplJJyqlHxob1dA5GZRNuzjYFP0VpzcwaBNpOXFbJ
	ujdiC4ox6gJKPSBkeRMFvqfYI1/DPe9gYVHjLgjBpVft76xYGDYSqKfI4hor2wApYFJAgz
	/T7jIVSxT78U1sC+cTjHsxa2D5WF4sQAf5ULwPNWzpKurRQCLRxCyIV3jLosXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752080774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQWs/yvwZcPLrNnawPJrh/g2JjW0m390/lOqwFLduNU=;
	b=p+2xPt2E8Cw1EjALFJ9gtmyDcBTxcpqASJoIfOaspeBB/MWCvseRkYZv8FAHX0RUH8wrKl
	kkeQjPO24zbDC6Aw==
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
Subject: [PATCH v1 6/7] x86/cpu: <asm/processor.h>: Do not include CPUID API header
Date: Wed,  9 Jul 2025 19:04:52 +0200
Message-ID: <20250709170454.74854-7-darwi@linutronix.de>
In-Reply-To: <20250709170454.74854-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<asm/processor.h> includes the CPUID API header <asm/cpuid/api.h>, but
all what it needs are the data types from <asm/cpuid/types.h>.

Modify the header to include <asm/cpuid/types.h> instead.

Note, this allows the CPUID API header to include <asm/processor.h>
without introducing a circular dependency, which is needed for the
upcoming CPUID model and parser.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bde58f6510ac..4d158ce3aaf8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,7 +16,7 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
-#include <asm/cpuid/api.h>
+#include <asm/cpuid/types.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
-- 
2.49.0


