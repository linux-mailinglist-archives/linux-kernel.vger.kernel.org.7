Return-Path: <linux-kernel+bounces-854300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04BBDE0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849CE3A5727
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D131BCB0;
	Wed, 15 Oct 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqB/UMHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116D31B133
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524553; cv=none; b=D9Bz2PcRs++Brm8+ZDc4AiSAKPYeIHSQ37nDKDKcmAx0/ijywx1DHhVzSnjXtm1PutZk5RRubB76MRaJ7SlwkiSJtYP0valq6bZR9jF4UAIX8G0ckOHWO7XyHsU0yu8w/oSVbKi6TGTzJ2QZL1NqG6pjlWX6U04VliNT0qExcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524553; c=relaxed/simple;
	bh=saw1+ROpnzOyHfOAWSzAxo7Wj8jbDsllMidXckAW+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZRtGdOA5pH5pd0yhQqXX4+6aq5/Zc1vKgNvt8o/pyqX+GPc3pcDVIn4sCkLNGeo2byNPN5KbQcABmFjKii3KieJagw2kpQHBqd7mjeTYCg6ioR3utFR8bOUxLdPMnjyh159wQ++0YnB+E/nPA09PBLI9tGifTF2KQcykqKOrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqB/UMHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64354C4CEF8;
	Wed, 15 Oct 2025 10:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760524552;
	bh=saw1+ROpnzOyHfOAWSzAxo7Wj8jbDsllMidXckAW+KU=;
	h=From:To:Cc:Subject:Date:From;
	b=AqB/UMHbFNq/NDZaB98TaHQHpH+OMg6dwKurarKm9R7/Ire5JGFEWW4xlB91lVMiD
	 /IyZ+M85T5Siieq+MRKxjwYJCv/GQjKxCU/On/ZVlYRpRL527n/col8p1EXj0POjvj
	 7xM/QvYENCTyEkIffKcIzcsFPZHxUPrJ2zBf0BOOHgW2aU5PNNQcMm7SngYEhYXL81
	 OzhB4CQ5GLzZ2dle5RJ+U9dPJHGh3QxdktIsNS9VhlDE1X04kB3hhchsv6Z8Mnev39
	 h6zL8aq27th3gXSHdVuWZap5RoZ/363G/7h5NtZeI6iyGGTTaDwiMwHPqGNRE3gn71
	 8KWq9wAnXlV3w==
From: Borislav Petkov <bp@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
Date: Wed, 15 Oct 2025 12:35:48 +0200
Message-ID: <20251015103548.10194-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Quotation marks in cpufeatures.h comments are special and when the
comment begins with a quoted string, that string lands in /proc/cpuinfo,
turning it into a user-visible one.

The LKGS comment doesn't begin with a quoted string but just in case
drop the quoted "kernel" in there to avoid confusion. And while at it,
simply change the description into what the LKGS instruction does for
more clarity.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 80b68f4726e7..4fb5e12dbdbf 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -320,7 +320,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Delivery */
-#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
+#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE = GS.base */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPMADD52[H,L]UQ */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index bd655e100395..d5f091babf96 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -320,7 +320,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Delivery */
-#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
+#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE = GS.base */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPMADD52[H,L]UQ */
-- 
2.51.0


