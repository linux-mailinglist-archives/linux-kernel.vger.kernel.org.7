Return-Path: <linux-kernel+bounces-825300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6EB8B833
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F15188CFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAEC2FF143;
	Fri, 19 Sep 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nqAvOya"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516362D837B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321238; cv=none; b=H32OKR2yb4ton42iM+D2c7+WX8G33PJ4ZewaxY0GWLyldHCwhUGE2dQkjXfpc2jXz5D3nK6XFn5EOzXyj5nXE2Q8awno+Hcjo3i1v7wYCuatAC+qI8OWO7DMF9QLZkNjfxTZR79Jub+6iiR0jnpP1UDKCSn6p0kI8n9ib4Ec4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321238; c=relaxed/simple;
	bh=81bLgs7WWEP4RHsG/996GiM8z8fF+N7LKbDI/yvDNY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i85/shFmjxtnXuMHo0AB+sfcffKDjP4WxBll1K2fyy3puuGOPiu3R9gJdLtNgb395nyEGiY3rU2pEUCYePLhnWg/nUJIPA1i5kH2rnDbdRGFTiStk6Q93AzrNThmFAFGZUbcDsg1vE5WvxFlDiWrOJJlMaXvSYzG/hDN8cNlYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nqAvOya; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b521995d498so2045413a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321237; x=1758926037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FWNNcPWz59Ty6udq/sKrbnnVGPaggW2BoAcUNvSRGEE=;
        b=4nqAvOya8oWkMwRW9lTWPdMGuzfUyXO6PohB5NwmPrY54YNaPnpNTGEhtu8OtWZQN/
         5HZEl6IrviQj1k6c/Hhu2RK5ItQk4T99C9+4RzmLhGi5ppkB7kRGS0P0tWOFByr6JI1I
         mw1zn4LhpI2IaatYLhqsoO9tdPnL0kkLYEZ9h73SAP/VC4eH+SGfzfdE462xc4R4nCmY
         ikasrDzcfA58qK1DwBBK/JrCxLulx8LOkp5LgLXxDOf3P9ovouNZanVj/bZQMNZo4IiW
         FVG6V+Zfi6BrxQOJ9mqKnDApGel1rTAABr8oyBo6/0PZYoryBqbsDbBEvubYcoczl0bR
         NaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321237; x=1758926037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWNNcPWz59Ty6udq/sKrbnnVGPaggW2BoAcUNvSRGEE=;
        b=VMeSMbj536eibdBwx1G8wnB6sXD1YLocyHS2Ga4N7QrTezXWf5F4D5f3igNIPZp7Ej
         opI5AVv2mP7fapEdvTmMjm9Eb6IQS7urRcpR2KHto3cayix+FV6DSbOLrEOPWIK2AoNv
         ewVryBV5wLycb89uzzOB3DR6otLJPr7GR8lvLsQO+UPVwH2H/d0sc4da4ccp8S0fJTXd
         pqoclJ6tEn1mmSP0JZ1d32fbQo6PTtYUArMmt2iB5gDwK/mO5DPkMG2gRG/+sdi58iCX
         WjHAv9YEVi67apdPmIKbuH08ocRnxy+u8CSeWvplizM54mEWrFlNv+lLLnfNDtymt2Fe
         tJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWymjdTZzKWoI8lWnxwDqs2VFyJkmep1y9mQ2XkVnwptf6poaBxVabgnkrC3okWZtsFmb8dVsxAVeMaiCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsLSJYIKjEBMaliMOHjG/hXIC8lv6SVZVpJKdLiz9ZOivILRe
	tFBJM/8AWCQsUM2OYknU9lzkkK46wpKoSKuPL2CywyWFRa9w2562ItNVFSHkHIAERLKxDSBovpE
	/ElJHGg==
X-Google-Smtp-Source: AGHT+IHcBUk+tK3zNAtEgLO3ydAANiXuYpE2t7HChEGpqmf2Wh2ALYrEVAwmFv0js2gMpqhaC2ppaWjmLHk=
X-Received: from pjbpd9.prod.google.com ([2002:a17:90b:1dc9:b0:31f:b2f:aeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9991:b0:220:10e5:825d
 with SMTP id adf61e73a8af0-29257e10c37mr7147586637.8.1758321236618; Fri, 19
 Sep 2025 15:33:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:36 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-30-seanjc@google.com>
Subject: [PATCH v16 29/51] KVM: VMX: Configure nested capabilities after CPU capabilities
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Swap the order between configuring nested VMX capabilities and base CPU
capabilities, so that nested VMX support can be conditioned on core KVM
support, e.g. to allow conditioning support for LOAD_CET_STATE on the
presence of IBT or SHSTK.  Because the sanity checks on nested VMX config
performed by vmx_check_processor_compat() run _after_ vmx_hardware_setup(),
any use of kvm_cpu_cap_has() when configuring nested VMX support will lead
to failures in vmx_check_processor_compat().

While swapping the order of two (or more) configuration flows can lead to
a game of whack-a-mole, in this case nested support inarguably should be
done after base support.  KVM should never condition base support on nested
support, because nested support is fully optional, while obviously it's
desirable to condition nested support on base support.  And there's zero
evidence the current ordering was intentional, e.g. commit 66a6950f9995
("KVM: x86: Introduce kvm_cpu_caps to replace runtime CPUID masking")
likely placed the call to kvm_set_cpu_caps() after nested setup because it
looked pretty.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 69e35440cee7..29e1bc118479 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8602,6 +8602,13 @@ __init int vmx_hardware_setup(void)
 
 	setup_default_sgx_lepubkeyhash();
 
+	vmx_set_cpu_caps();
+
+	/*
+	 * Configure nested capabilities after core CPU capabilities so that
+	 * nested support can be conditional on base support, e.g. so that KVM
+	 * can hide/show features based on kvm_cpu_cap_has().
+	 */
 	if (nested) {
 		nested_vmx_setup_ctls_msrs(&vmcs_config, vmx_capability.ept);
 
@@ -8610,8 +8617,6 @@ __init int vmx_hardware_setup(void)
 			return r;
 	}
 
-	vmx_set_cpu_caps();
-
 	r = alloc_kvm_area();
 	if (r && nested)
 		nested_vmx_hardware_unsetup();
-- 
2.51.0.470.ga7dc726c21-goog


