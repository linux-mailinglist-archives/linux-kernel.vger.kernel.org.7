Return-Path: <linux-kernel+bounces-814903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCCB55A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E293D3AF396
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A12E336F;
	Fri, 12 Sep 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dleISosl"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC422E1C58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719464; cv=none; b=P5uM6GfSDOKKClgOMgWPHZbQCJH05YYaaYQAHIWkb2qQDUBsF9cWyCN40ofhU1BVnQZphr1funfd1zhSpYvtqt2YdnX8OSnR8XPn4kDW9hSDxRS1Ihb3XZgq8l6se8VORV2CRBT3DymLpyplsXmuadHdfErf1vhA/bgsW/3Uv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719464; c=relaxed/simple;
	bh=oqfxEduhxDr+EMb4NgJ6QjjX4Eln5KqTEXpKlxdlRLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMrIjwfVAxZzzspT+jG4AKNGdey71+3SV+mFuerhj4u1t7aBcishUD+1bCYzzUGLWk91f0EisyFm6QURg2fgR1+2Tkg8H06n5Zj//3W0faPaHubE/gjW/fqXq3CtokbToc9HYdGy/3rAVxBZK5apyUvK/3B6njhHpDiB/yd/q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dleISosl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso29563895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719463; x=1758324263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oN2KOTjTaXX7Mn3Y30lree8vkKri8RC5m3orTfrrrD0=;
        b=dleISoslxIrA2H8b4AdUOHZCkSlLd8x6EvolG7fiRdfyavD5Y1198N7RitYQqiTH3Q
         QXs/gfcMPXyVy8o6IEK81Fy0M7NTm0iv++YAse94/ZEpT3BfXizl8VT4HQmBtAfBbL1+
         UheqbyoexQbjfpFquYAXytgVMAwHhlVA6dl6hOQvjQ/ed/SH/pd4DvebVaHJ1a2LSNBP
         h15Xrre74e9wqQUbpOBPHQpj/PXV5eowRoeCbglw7LtfOdLQDUnXa7ptOLnX5hjbHlai
         0hbLWCttwEDmiWiO4FkKIppGCk7mtRHcHdomNk1dNHc/chHLUzRl+5rGvWhar4hSuLsi
         bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719463; x=1758324263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN2KOTjTaXX7Mn3Y30lree8vkKri8RC5m3orTfrrrD0=;
        b=dtcMBFZFnH2iiIkIZQUYqGMmenM2fxnUhyorN//h2is1AtfR2qodAdgPOQgd6OcJvN
         uHyGqC+yIHs6iiX49HKcEML0GTsBixNaThG8MaR1mH6DAsbyUybBfBUKvIcZHOhTvI4t
         iI6pOua5BUjjSXcnv/fB2NREHoupnBPl1dk/c/cnpWuikZkc9X7lep/qM3UBCgRrGq0t
         xEMI4PPmojp598Np5xBV0aQoJMB1YBd6XvyeQWNRGyNxUprLmoLpxLlOUSDVFFHh2KrF
         xm+b8lRC6xgUsUenhHy2YA9Tm6G7vSeKX6Dso+Cogy6EBpD4/U6n1KT0Lfs8kzDwKaui
         YWcw==
X-Forwarded-Encrypted: i=1; AJvYcCXwJvAkkqLGAq58bE5LTq1Eiaas8z64pul4K9hSe/X8B28a+pjbTL3n0htdyfWM9YN2VIZV8G/KH8EN/5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrckQlWYnRAy9mINhosoo8fdU07N+1W1ANk9Wl2SZuMSa4mzIH
	C5+OYgu2b/jnYhY2Vyh08u1QK8uPHsMnvk9rH1ya/o6Zuo3GCI93naaAW0o6cB2QrmdHWAtY+wA
	uVdcAHA==
X-Google-Smtp-Source: AGHT+IF4ouXasakEIa4631sD0tHiSMgMdyeOf4Be425QMzhF4PkjL+dHALvyxn4cB9SRRLA42F0LmF5uaLw=
X-Received: from plblf15.prod.google.com ([2002:a17:902:fb4f:b0:248:753f:cb3a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea02:b0:248:e716:9892
 with SMTP id d9443c01a7336-25d278284a6mr52818135ad.59.1757719462726; Fri, 12
 Sep 2025 16:24:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:10 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-33-seanjc@google.com>
Subject: [PATCH v15 32/41] KVM: x86: Define Control Protection Exception (#CP) vector
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a CP_VECTOR definition for CET's Control Protection Exception (#CP),
along with human friendly formatting for trace_kvm_inj_exception().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/uapi/asm/kvm.h | 1 +
 arch/x86/kvm/trace.h            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 8cc79eca34b2..6faf0dcedf74 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -35,6 +35,7 @@
 #define MC_VECTOR 18
 #define XM_VECTOR 19
 #define VE_VECTOR 20
+#define CP_VECTOR 21
 
 /* Select x86 specific features in <linux/kvm.h> */
 #define __KVM_HAVE_PIT
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 06da19b370c5..322913dda626 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -462,7 +462,7 @@ TRACE_EVENT(kvm_inj_virq,
 #define kvm_trace_sym_exc						\
 	EXS(DE), EXS(DB), EXS(BP), EXS(OF), EXS(BR), EXS(UD), EXS(NM),	\
 	EXS(DF), EXS(TS), EXS(NP), EXS(SS), EXS(GP), EXS(PF), EXS(MF),	\
-	EXS(AC), EXS(MC), EXS(XM), EXS(VE)
+	EXS(AC), EXS(MC), EXS(XM), EXS(VE), EXS(CP)
 
 /*
  * Tracepoint for kvm interrupt injection:
-- 
2.51.0.384.g4c02a37b29-goog


