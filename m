Return-Path: <linux-kernel+bounces-825313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43383B8B890
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6301CC25E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18C322C94;
	Fri, 19 Sep 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltguSTa8"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532032255F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321262; cv=none; b=atPlEOFJF5DcESzIhGLN4ClV8vXTdD3ogU+jDKYxKaXADj2ieSaFxA7EEtG/3oMnpGFe374VUe5N1f5UtobSog7OJ1cEHtVqrEBMuBrMP1EMGLDGTPi18bHYtkURUpA+rV9B0UnJstQDi4/vlqjMCr5b3tR+EkWsHMakuW/g2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321262; c=relaxed/simple;
	bh=ru0JYVAV3Ct14PRo0yhkc1rw1XsBhg8lkiA/37/obr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKoq3NU/6CjaH9KuzGvYb1rFEk6H4Adkbc8b1kaDZuITDWT99pCThl3/6QrI+Ri59DnccyDYq9ToST77apdj3PQO4StZlUI9dYeUz+1fAXKocsZakUzKekEzSUSUBElBCIf7QL5BxafvB5wkgrQRQR7oQatObWzKmCKQC0RX+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltguSTa8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso1950546a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321260; x=1758926060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3UrLhaFh6L8swjF0/uDrtKirTcJvKRN2dByplhxwnKQ=;
        b=ltguSTa8ZRV+fOUTjbV5DoiXTic2stvcJq0y/6Nx18hCXNsf1l7r2OOwmhuG3WT9hA
         4SmKExqGC5NEyNpJkrtRF/Al4M2hlPh8ASF2MNodJq9F6kIbFHeUxIjp7cl41RdgLsRr
         E6xknr+B939k17qOfWkyVnfRV9JO0rvKQU6Ay9aW1cEImeIY/QrnackBv1A2A4uf8gD7
         NgCYf82STlDt0L9LsPKn1qTjbz98BpxY7f3q/o2ZDfRxUQuPAI1ucJuu2i9Ucr06sNBJ
         0ZsqsKCdUeU4ev0BV+TYdrG26knGmNrVsF/aAx/UD2qo6rtp+7lDuHjHDHcSwY22R+8k
         AV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321260; x=1758926060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UrLhaFh6L8swjF0/uDrtKirTcJvKRN2dByplhxwnKQ=;
        b=rLrQpDLbIkibHxyvbPEIjr0wBePE7cjc9eK8KdGhWE7U8Z2DfMHAII5knSxlsMGh82
         KXimGvDnkmUwftYfyqVMjRVZvXFZvTxaVKwXgtt5u3eSJLClmtV+0e/CZu6gALdzLaOZ
         lFE8qHIoLokgDjsWbv72/oaqkx9tS2ExGtneLIg9LurXFN9S4iJUhWMxpYjSNOfOI3M0
         fYGD1l7pNGIJhT7HYoWgRqoQZuQkI+LB1XXC/7+vobbPJTgMTGCCltzwQM0ydJhECFgP
         86nORux/W3VpMdr2qrOS/5gZxDl4bORwCLRn7YmlaxPTMNARW/pNcOOKgtECAc+kXWXr
         Cd1A==
X-Forwarded-Encrypted: i=1; AJvYcCU5GbpgEZmiL240KCzSpag3ebi0c49T42OSQZZLmbpnPTz8VU22k+NthZcsrLhatmGMUTXMaU6oa0OVsZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vQEKkA5qEfkoZ0SBeEabjZGEtBkU9/zkWy2AzjOH2aVEBji2
	Gn+uakRJG9DSmCx1HGyhnCF1Jhg30taTYhy8Xfnmu9pZGddDPPyizMi1Wh4DE8aG6kX7tdNYQ5X
	COnPlCQ==
X-Google-Smtp-Source: AGHT+IEaCcswr+wNDrCLZXoy3UJxuDgsEZXAQm7svZ+GG2IWwDAE0RmNO1dN0FbIfLE202MemYISNotcQxw=
X-Received: from pji3.prod.google.com ([2002:a17:90b:3fc3:b0:32d:e4c6:7410])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a24:b0:24e:7336:dac2
 with SMTP id adf61e73a8af0-2926e378a00mr7751493637.29.1758321260450; Fri, 19
 Sep 2025 15:34:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:49 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-43-seanjc@google.com>
Subject: [PATCH v16 42/51] KVM: x86: Define Control Protection Exception (#CP) vector
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Add a CP_VECTOR definition for CET's Control Protection Exception (#CP),
along with human friendly formatting for trace_kvm_inj_exception().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/uapi/asm/kvm.h | 1 +
 arch/x86/kvm/trace.h            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 467116186e71..73e0e88a0a54 100644
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
2.51.0.470.ga7dc726c21-goog


