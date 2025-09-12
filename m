Return-Path: <linux-kernel+bounces-814904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26EB55A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D3D3B2E50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FABC2E5402;
	Fri, 12 Sep 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfdofDby"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDE2E2F03
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719466; cv=none; b=vCf2w0UXqxwVkMjMrsVsx/X2hgcPMowkUajCT+sAcb04AYskbEn/gctFuzeuPYo55F4cRa02T+Pzbxc2a7QqbMZsLJorSq1pfoWLK2WA2/Z2CcjVf5mYOk+W1E6V5+0ACf5Cq7I8ykH3laT1SnFjQGMrx5//wI0zPxyFaJkVcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719466; c=relaxed/simple;
	bh=B3ANx1k9od/UZ7qHXd8tTlFRJtWLSvAyNQMMn7FyBMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKrVdHJGSG/F8G4fArrCV/WELzHdpMH224ZS/h+pH29vm27YrwJa60bu7JuHqfVh5sknvAFLhUXGFtS4Kwc1YAJFosi1/EFeRAzwZn9znMwPwXfVO1VNpanp7Pl/2MG7wqGh02btcBTUzR29O8j3pUEDJKMZLL8NXVCak4S3dTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfdofDby; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32d85208e3aso3307781a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719464; x=1758324264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DYEJvMQ+rPiHFwgy9hCCQpkWJu830ze1NI/y95RfWl8=;
        b=mfdofDby2+5WV3NKavsjHu4rpvQJVDO8YZ6+bokrZTXeXS+DpHCrFU/kdlCWUS0dj+
         gQsM/8FNGKPbrO4tkEEtbmRE53FqFwmsoazqihF83hHclfM1PaY0ag1S9lW8XsDy4Uk3
         vS5Xa9afePpdVaI/eAvxMk9IF1ccwKrKAjqcBfASVyReclVIvF7gxzlwXaQUE5PJTnV/
         IG5G+xDjSGcVA3mdyh/oKChUqydgBMJxJoSCPVh+hkkOhu6WwctdbhsuBzC4jO+IZJIL
         1JCWg33Cl2ChhV9QkcgJ4szD/QpOA5yFo0AmwvuoZwqXOk+r5eQxxSp4UYPUrXfgZFAY
         g8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719464; x=1758324264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYEJvMQ+rPiHFwgy9hCCQpkWJu830ze1NI/y95RfWl8=;
        b=P89otkp9JXmlHcKIaDzSZJKsJ8IPApdQa1olmkubT2nH+JtApLrflaPjbjWXKQxlru
         uqeJApQZXb8nJb2EjWCiBl5S7KeE8UY+QqDpxLwDnG4N/sFh8gM1L/qdRpBx8gbyDaYb
         kuJCDTRlVkbX0nqmyzNihq34UA5WdwkmYvHz94LFYmy8mS7w2c3VL+kACTt4qg7PWpv0
         W/NWyU3WXD0qWHMdqymjtd44LfvD3G0b3DUyioj3wy7nHdWhZ/GTMv147O36F23gyG0m
         4v43bZLSSKYzq+EwtRJpGzGhiBHP+NbJpi1koamn1NJBu20Ho3DUTBaZqwUiEga13dH0
         D0tg==
X-Forwarded-Encrypted: i=1; AJvYcCVACV8Vp0IFVCmkx/YqB98S7uYDMp7vsJVBo/8U3+scfGTd0DziWLvPkga+2/0Ply4DKSa8Z37Akbka314=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqvB6BQ1/WPuQrehN/HfYP3aeEYXwmGb3TqcF8yf+pF92tg4S
	PYf5OfvlkfhP+aGXEEiGscO8gOdZ29mQpM4FN+FcJQYGymAYJfH/HNWuf/8Ay0XfX/tg6qo848B
	BHcNZ8g==
X-Google-Smtp-Source: AGHT+IEzIYXqbBAxA7dJBbESi/lDxCUqXn+5yFgnBkwtiQzLwQEHV9BVSP3o5S9kbO68jEwBc/Vo/rYuLYg=
X-Received: from pjbtd16.prod.google.com ([2002:a17:90b:5450:b0:327:4fa6:eaa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8c:b0:321:6e1a:1b70
 with SMTP id 98e67ed59e1d1-32de4d4b240mr5033084a91.0.1757719464648; Fri, 12
 Sep 2025 16:24:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:11 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-34-seanjc@google.com>
Subject: [PATCH v15 33/41] KVM: x86: Define AMD's #HV, #VC, and #SX exception vectors
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add {HV,CP,SX}_VECTOR definitions for AMD's Hypervisor Injection Exception,
VMM Communication Exception, and SVM Security Exception vectors, along with
human friendly formatting for trace_kvm_inj_exception().

Note, KVM is all but guaranteed to never observe or inject #SX, and #HV is
also unlikely to go unused.  Add the architectural collateral mostly for
completeness, and on the off chance that hardware goes off the rails.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/uapi/asm/kvm.h | 4 ++++
 arch/x86/kvm/trace.h            | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 6faf0dcedf74..2f0386d79f6e 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -37,6 +37,10 @@
 #define VE_VECTOR 20
 #define CP_VECTOR 21
 
+#define HV_VECTOR 28
+#define VC_VECTOR 29
+#define SX_VECTOR 30
+
 /* Select x86 specific features in <linux/kvm.h> */
 #define __KVM_HAVE_PIT
 #define __KVM_HAVE_IOAPIC
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 322913dda626..e79bc9cb7162 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -462,7 +462,8 @@ TRACE_EVENT(kvm_inj_virq,
 #define kvm_trace_sym_exc						\
 	EXS(DE), EXS(DB), EXS(BP), EXS(OF), EXS(BR), EXS(UD), EXS(NM),	\
 	EXS(DF), EXS(TS), EXS(NP), EXS(SS), EXS(GP), EXS(PF), EXS(MF),	\
-	EXS(AC), EXS(MC), EXS(XM), EXS(VE), EXS(CP)
+	EXS(AC), EXS(MC), EXS(XM), EXS(VE), EXS(CP),			\
+	EXS(HV), EXS(VC), EXS(SX)
 
 /*
  * Tracepoint for kvm interrupt injection:
-- 
2.51.0.384.g4c02a37b29-goog


