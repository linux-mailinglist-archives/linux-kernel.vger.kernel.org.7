Return-Path: <linux-kernel+bounces-760613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C100DB1EDCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6922A7A6342
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACC2882DD;
	Fri,  8 Aug 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh0tpPrI"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E042877E5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673845; cv=none; b=eweii20ZlmJcad5E3YkwMqmINKE96kjEHufITKDMxxZ/rat9RpSkHGTYaf3jKOII2yMMl+I+fmBP7eQE2ipAUiGfcLhqUL+DViM6nTH39tSuCWYLuu5NSdEtRQmM7/w8s68FU0HVmj0ioplJV/pcdzLcervhgfLbwNt1XiefTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673845; c=relaxed/simple;
	bh=/YN/5w+InagrtNfe2VTUimtRiLTRQc4o3EqFJVGVL/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gmMi7Ppmnsz+9a2BaVvqQNHXX/TJ7ySKRAVmiHciB85PWZyUJ6qFaqCcq+z9NdCA0tW2ObU6diEkHsKVEegeRk4cMX/6NHYyZ2r/ynfWKPZ6DfMHiAEP2EjPks3LZSL/CuVS+5E3IT3iflhfZ69J2xkor9yEj0+0uQADLABA/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eh0tpPrI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ecb3a3d0aso2324888a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754673844; x=1755278644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pB1EcNb3KBg7blVcooN5a03GwnYie6Kk8lSHEcDdPn0=;
        b=eh0tpPrIgwy6oagKKLVi48zvJKeBAxn5iwGShMOcaQLbeBqslNTvc53sfXH4//XQF5
         /0ic39Kt77EiG5kPRzxeumpYWjEldoCuelrf+pK9EAZoCLtvEKcM6VJNWOrxR6aGv5JM
         mpRSfl6iYmP5bd4qhgjwrvOvXnT1Y6yxufgXu33Y4Fk28aQdud5nva2KoFZq+fAHfL4h
         /DFZ+tr3zq+Ne+91ajlq/GtMUVdyTukhlGITHwGVX3OzzhyPY2zuI4af11IZUlH60Ry9
         6/locvL1DIxlFfKrXawM8cfOL78/ikEdQVS9TYeESWGnZoHrYYuwWY2Scan+C75x6ZQ0
         EgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673844; x=1755278644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB1EcNb3KBg7blVcooN5a03GwnYie6Kk8lSHEcDdPn0=;
        b=rN/EPwOpXgDfngxpku77DZbEploKWqYhKsqk3C1lyNPBQuIRkqz6rkMeL++Gz4aDPr
         ezUN/aQrgDKaScDpybDjuOz63FLe/1QRA+Q9HPjjkAKgKl6ub4/rNP5kYz1YQML7Tbgc
         xrE/QEqnAxhYJDxyoxQSP6o/zX4iMDs98bMDPM6zivA/3AqAII121tQgx+hYyBSMK1a0
         py+ZlMUSn4FHrfM528uh+oVYR51/R03BLYWEqqr1uFH8NlqdG/eN1zdEl9VEXliIvsux
         v9O5dk2Dc9j1emfelnwDwWd+mL8/5wzQVIBhMH0rrQZL9GHkdJCB6/IV1ex9oPDDRkLr
         k1zw==
X-Gm-Message-State: AOJu0YyWIRuO3lqx6ZRZvZk3d1QFkJnguQbAO1sh6IHRt8jB00QbkmvM
	t/U4M32Tj7B83ooqumTXSqU496+SZxIb7QSGonSkYl71WdqfN0VZSQ85RCUCqb5+T2H3RYyXuTe
	1h4qELQ==
X-Google-Smtp-Source: AGHT+IEjFjjMfhZPPZlc01YVLfSxKdz//nsPfi2oqtpaRzhKekVdgHKK1ALsC6KrXqOHGEGrOKnUYr4o84g=
X-Received: from pjbqb13.prod.google.com ([2002:a17:90b:280d:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3943:b0:321:8a3b:93c
 with SMTP id 98e67ed59e1d1-3218a3b0a45mr4749662a91.33.1754673843834; Fri, 08
 Aug 2025 10:24:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Aug 2025 10:23:57 -0700
In-Reply-To: <20250808172358.1938974-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808172358.1938974-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808172358.1938974-3-seanjc@google.com>
Subject: [PATCH 2/3] x86/umip: Fix decoding of register forms of 0F 01 (SGDT
 and SIDT aliases)
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Filter out the register forms of 0F 01 when determining whether or not to
emulate in response to a potential UMIP violation #GP, as SGDT and SIDT
only accept memory operands.  The register variants of 0F 01 are used to
encode instructions for things like VMX and SGX, i.e. not checking the Mod
field would cause the kernel incorrectly emulate on #GP, e.g. due to a CPL
violation on VMLAUNCH.

Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/umip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 406ac01ce16d..d432f3824f0c 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -163,8 +163,19 @@ static int identify_insn(struct insn *insn)
 	if (insn->opcode.bytes[1] == 0x1) {
 		switch (X86_MODRM_REG(insn->modrm.value)) {
 		case 0:
+			/* The reg form of 0F 01 /0 encodes VMX instructions. */
+			if (X86_MODRM_MOD(insn->modrm.value) == 3)
+				return -EINVAL;
+
 			return UMIP_INST_SGDT;
 		case 1:
+			/*
+			 * The reg form of 0F 01 /1 encodes MONITOR/MWAIT,
+			 * STAC/CLAC, and ENCLS.
+			 */
+			if (X86_MODRM_MOD(insn->modrm.value) == 3)
+				return -EINVAL;
+
 			return UMIP_INST_SIDT;
 		case 4:
 			return UMIP_INST_SMSW;
-- 
2.50.1.703.g449372360f-goog


