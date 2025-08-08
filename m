Return-Path: <linux-kernel+bounces-760612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB8B1EDCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8731C242E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D52882A5;
	Fri,  8 Aug 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVsA/xRt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A71DED70
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673844; cv=none; b=uQR9vmYvkNkI95h/ppMXZZ27kDuRxwCJ+5h7iXHdSwi4VRmTN80aquI0Resi/i87LCMQ1I3p8VgPKfojhNmdoPBcuXo/Q7VNK4FtR5kv4Z9FVSVYftNAoTaRQjrLSx/Cyu/3RZ1jKbz+C9MFn3lyEqHHkDjcMYcOrpgLZtMSaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673844; c=relaxed/simple;
	bh=gzqa0oYDTq4QSBhPVGrYOEhr4pVNkqqBjVSLygilPrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/Z2yHn2IVGAvnEpuA/dvIrAwh6O13o+MpvO18LxEVvczusc8mMlogh6F0TYTcwCPDMNsjz1qGRCRjDqcb7Eil4oEcQ491h31yb5nT8FNO7bSjEX8KQKkbsrhmH09kyvQOjp1J33zee4ZU2a5xYGeGDfxoiy1ZQ/s8zyYepxKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVsA/xRt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be4422a36so2787456b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754673842; x=1755278642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YR69daxWwAlMu324Pv5313yogBDr/+ov0IBivIzem1I=;
        b=RVsA/xRtg7sV7rrp+ASSYrsPj+tbIBXvvB0k0Vxbni1ldni/5M5hisdnOsuFadlkw3
         FW26ftvCCPIW4Sk3WgdEjIRJFfANsb2GArOsFaV2CW683971kCKI7XcU/z76+D4EAv8q
         uc2FFKt1c1y+ffDmhhLb/eVh8DxEL0QSKoBU/bnkesP979dcGr7loAMsjnuqgVz0sjsO
         Ljvj37Lc4So8wy3/x5zz23oLV2FROLQQR56/Wd6flqaDtzYcDQwAc4DM8MS2OyxolZLF
         s8RuJPiLNtBn5t5nv5TZ0lclYbqLtH3lC8pTCgm52rqAIzcdYSgZkGJkWMwyWs+kavy3
         CAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673842; x=1755278642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YR69daxWwAlMu324Pv5313yogBDr/+ov0IBivIzem1I=;
        b=m55oqCVtw1gSFPjwxNCTEoCGNBkliHyl/MHSpTLoOfhWl2GVBUb0GFXDEGmCI0f2hy
         HOe45txPWfcANrdDksQnqzLZuZdt8vnaSG5eTTrQ0SYEVxSc9FrpzYKJRvANPGCuQjlT
         RAaXRRtQXMcvU2zRLZ+sw/dPB1k+oZNpTAz8Q32/Uge2gm8pgrZCmxQpHb1rb0jMcKnL
         o6YgHLiZz3EaRE4vsdaM0ILftzogfrITo/3/dQE1liOJ2fUlgqYsFI70iNP5aXmpY7KI
         jCn9tMkykaXJjquT3hk+7f1BKVmj7j32lbZsipKLckxgrquimrhZpTCn6gfzuqBzr0X4
         /rlQ==
X-Gm-Message-State: AOJu0Yyimduipvph2JQKTJcj7PPVNcSZ6G8rJFzQcus4I9zGu9T9d/0x
	E/YSLcxk3hez24Jo4ESGyb4QNhJv5tiYWd46hRXs8etQ/ZlT4wwuA3UEgvNg31GafNFel3kOsqH
	19/+BUQ==
X-Google-Smtp-Source: AGHT+IE36pgE8cPg5q7Ma91rK5Y/o9PvbENYaPLhaJaQD/Ytgrq3X3ozdZzGnMgQB14BhjDKyLeZbwi5Fcg=
X-Received: from pgjn6.prod.google.com ([2002:a63:e046:0:b0:b42:99d6:6bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d06:b0:240:1e4a:64cc
 with SMTP id adf61e73a8af0-240412d422amr12429082637.12.1754673842081; Fri, 08
 Aug 2025 10:24:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Aug 2025 10:23:56 -0700
In-Reply-To: <20250808172358.1938974-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808172358.1938974-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808172358.1938974-2-seanjc@google.com>
Subject: [PATCH 1/3] x86/umip: Check that the instruction opcode is at least
 two bytes
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When checking for a potential UMIP violation on #GP, verify the decoder
found at least two opcode bytes to avoid false positives when the kernel
encounters an unknown instruction that starts with 0f.  Because the array
of opcode.bytes is zero-initialized by insn_init(), peeking at bytes[1]
will misinterpret garbage as a potential SLDT or STR instruction, and can
incorrectly trigger emulation.

E.g. if a vpalignr instruction

   62 83 c5 05 0f 08 ff     vpalignr xmm17{k5},xmm23,XMMWORD PTR [r8],0xff

hits a #GP, the kernel emulates it as STR and squashes the #GP (and
corrupts the userspace code stream).

Arguably the check should look for exactly two bytes, but no three byte
opcodes use '0f 00 xx' or '0f 01 xx' as an escape, i.e. it should be
impossible to get a false positive if the first two opcode bytes match
'0f 00' or '0f 01'.  Go with a more conservative check with respect to the
existing code to minimize the chances of breaking userspace, e.g. due to
decoder weirdness.

Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
Reported-by: Dan Snyder <dansnyder@google.com>
Analyzed-by; Nick Bray <ncbray@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/umip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..406ac01ce16d 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -156,8 +156,8 @@ static int identify_insn(struct insn *insn)
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
 
-	/* All the instructions of interest start with 0x0f. */
-	if (insn->opcode.bytes[0] != 0xf)
+	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
+	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] != 0xf)
 		return -EINVAL;
 
 	if (insn->opcode.bytes[1] == 0x1) {
-- 
2.50.1.703.g449372360f-goog


