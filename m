Return-Path: <linux-kernel+bounces-825314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB1B8B899
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EAB1CC26A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6C3233EA;
	Fri, 19 Sep 2025 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9G6/JBu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C40322C80
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321264; cv=none; b=XtIXymmFsPj5ozi41v9PrLNc4myIE4G76FHLOP9rZlqxcKFGvDkepeoYbYWlELE3kSMWTEmpFbXj3x1mBrrpoVepYkjB+Irer+1sGmcBR+C+zyW0590FCvUPiE544ZfTa7hQ+ntVA9EG0hbb8lClug43IY0F0qyZUcgHgYzXq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321264; c=relaxed/simple;
	bh=BbYLHsW3csiw0LbMWNeOkvxFuLyf4OEeq83xGXs4iQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l1o4fBlHjIinB5sNRPcDi5Apvox0QWR5mopqukp36xXMt1+y9HuA8LapD/JLSFkGnBps7bzQ75E1PYOVKKYOPCm/QAJOdeJuuYGuSOd+Awc+FzTexv52krsNpl/IP7B8k/FWf708VWp8Gugim4wCxaC0ffbcz+NLNYmouuAPdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9G6/JBu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so2617588a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321262; x=1758926062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t9DiljcP0iTsaWICOGxOjswc6G6x9bV2xRiGmEu6SDs=;
        b=r9G6/JButLJxj5VBT6Rq1GCPjyjZzg2j3A97/8bQJPKX00CWn8+I2SKLpXJaAMXlIs
         mhnY8ZIc4bfw0wEguHCWksisq2t1jLiVrZkv3xe73ILPfUkjrpuBSXZSSDFTApjwH0Vj
         Z5GajIKH/SoXnwcafy6kMOL9Df1n8r29vXKG+sedxyiR6X8QBu1YRsgLMcOlzHh0WUAt
         cFyns0/63SwiRf0bRjfUCfScU3qwDh22Cne91LO33KJRHPa+LQdtVX1b1SbXjAA2kllw
         aJADrNwzImqYofhLBUTs2B+qo1g1QRx7/i7NuiLr4WDvhBZminL5HFrLzyxjFVtwkXn2
         lvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321262; x=1758926062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9DiljcP0iTsaWICOGxOjswc6G6x9bV2xRiGmEu6SDs=;
        b=WptJ0vaih5/ja0T+PaIaShsAZKCI99WehTwqHTo2iSk4wCx6BzIMalD5QdN3zAearU
         f6eRoM0EInh5vg38/JX2JutfLyFVaXdmR2Gr9tfaP8RpYS2MUXrnDOxCeOchTmjXWv6N
         EWF+ctKHP4p9SxMqqUOTSr9ghKZfP6sH769ImP9jcf0GG2uIaqjykx5hZ30uzEss/ywS
         0FcIbrzS9R3RxspNcVHGgsPdSVzmr5Z+mvBwKIoPyasrIyBPCQYGUILdGuMtyi4UgC+h
         Feq62FtAYiYb4TeHdjleQcHHi3XGD6S5Fopf7gR/D1SrN2l5QNA1PaSHdXP0BgjkYpLO
         /6gA==
X-Forwarded-Encrypted: i=1; AJvYcCW75l08uA1BcGwUyl9wJDZTuOzryP0lBtN93GCfKhVawGMzvYG5tUf84a/8RP+dP3if/Bss6ovi5tWBYms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWmywQ+/SPbd/PF0Ix/jZelknKzJKtfcLpXxDme75phqnYkff
	hebOlWNOvB0gV1V0VR/WWCv5s68HA6lBDXnfTXjCJAYvaxDGR4ZUtdSyVF+RhVP1GZyAxGD2vhU
	vougZcA==
X-Google-Smtp-Source: AGHT+IHbcuByYXlBMV424SmqxMjHViwJqwoLzp1O5KgSUSR2+NGgWTc1kN8NGOa0VSs5WkDSkAONWXGTqVw=
X-Received: from pjoo3.prod.google.com ([2002:a17:90b:5823:b0:32d:a0b1:2b03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540d:b0:330:bdfb:674
 with SMTP id 98e67ed59e1d1-330bdfb0910mr2400342a91.16.1758321262279; Fri, 19
 Sep 2025 15:34:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:50 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-44-seanjc@google.com>
Subject: [PATCH v16 43/51] KVM: x86: Define AMD's #HV, #VC, and #SX exception vectors
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
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
index 73e0e88a0a54..d420c9c066d4 100644
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
2.51.0.470.ga7dc726c21-goog


