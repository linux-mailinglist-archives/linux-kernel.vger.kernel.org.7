Return-Path: <linux-kernel+bounces-814909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D40B55A46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4DAA03B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B782E7F19;
	Fri, 12 Sep 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9AD2Mek"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61562E7180
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719475; cv=none; b=D+QlFAqPmFfZjndpAXyt6P2Al+opUZa5BAdSuOqO6cdUW/nLFwcuNlX6GTRKdKpY09JrUNawyq7oUCRefydx56wASfhPH88gy6NasJVpUBaVZavu7KndOQHsm79FACFhs91Wm/Ay6bLo84wcOXTMaBauMdg6WiQbTymB+DCvhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719475; c=relaxed/simple;
	bh=bAvgZqDSKSZSgmY1Bh3aCmVMIAn3w0+mvtW8ENhAZxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OU02ocriRpyNAkwvWAxgYKUQ5apiq2rBQLSpMTmVQeo4E4BmpdHIQEEULuEo2r0ZCdMxxpTNoYgIsdEeTyoW7zauL9LusLvzn4Ep+VDOK3+CITEMdPwZKFQWCN6jZSISfiISPmmhu1EDVbXG+cBjwggTASoWcNviSA5rdnp4sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9AD2Mek; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7722ef6c864so2061387b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719473; x=1758324273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gImqUspRMTtFrNyNB/J/yT70FgdU10MOpzMgx8Aa2dM=;
        b=Z9AD2MekKLLqsMDU4I2LywzvUUexMUBpPad7GGj+M9bCqhUybPwB7hlpxEtwz6orDS
         9b3Qa9isVjkdL3+O/c0irCCtqFQpkGkfk/l5tIjTqzVjXiMX5Q2LKzJ9VevYJFXlHHXM
         XzQmoR/8nqxnWyoIqNIH3fgCvdvbOwMIowRecwiZtzR4yzfOr/Y9YbffUN/wa00QJI27
         MUVnZYHDsmeH+cSVF34I9c+UAYgxIzU5WralhPc3c1DeIeq12TUBGL+7SaYKxeI5RiGT
         DTAbufR4kLHGJFttKM0f5HCH0wuBncHMd55zIxoMOgSLWNrFVuMNMUeIRQY526YJH90v
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719473; x=1758324273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gImqUspRMTtFrNyNB/J/yT70FgdU10MOpzMgx8Aa2dM=;
        b=fd+0bYM32i+u2ebfjS9oZd2CF0Ni69CjScRYDUA1SyP1/mi8WHl9Qm0F16m0pIjCMS
         SkGkasJjS+3eKRCdzpdHxQxeuRGLbBCSHTqi2fC2JKtKi53oTzqxaWetLjTGSYXV9t1L
         vi3sewF9vOAh16MZnWpiVDQyFxY0VMM8IGzjsoo78qRTlN9pnDwhkWzAkpE0VfzqLAgW
         Rq58zGkHYU61JPCF/47DYCz2ds9+xz4Hl25REBP2FhNGPJ0p0ELxaazUMsC3g8fxw71S
         CkEckmJebfs+mX6oTHbh82WzwN41pQhk8rlVW0K1Ff9yZIde64WoFk/g86WKX9SgP9+x
         64HA==
X-Forwarded-Encrypted: i=1; AJvYcCURzpbAZo1nvMP4MLYZGC8X0bVPbFwODQG3lv28CnxnkUTur0zuShqUPdU4tzNm4oPiijnA4LCct/9MMEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1lvAPI9HHknJvCPjWjfkBeOoO5bVPo16DBZEwTGn52NkRCc5
	TDnC/DR42cV9jN9qZOowgHzN3R3MbFOCNh6e3F7Zt5Yb6WVw2JJVKNp9ltzDFqa5JOVdPL8M5fp
	whu3eXw==
X-Google-Smtp-Source: AGHT+IHRkUUjDiUAJiC1fpOe+Lr6xbhMzIbft4c1p/ekgTG9fgtV2fBAXwOEYkrIC3xU6auBXmeuJUM0C0I=
X-Received: from pfoo15.prod.google.com ([2002:a05:6a00:1a0f:b0:775:fbac:d698])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9150:b0:24e:84c9:e9b0
 with SMTP id adf61e73a8af0-2602aa8a513mr5926870637.17.1757719473102; Fri, 12
 Sep 2025 16:24:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:16 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-39-seanjc@google.com>
Subject: [PATCH v15 38/41] KVM: selftests: Add KVM_{G,S}ET_ONE_REG coverage to
 MSRs test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When KVM_{G,S}ET_ONE_REG are supported, verify that MSRs can be accessed
via ONE_REG and through the dedicated MSR ioctls.  For simplicity, run
the test twice, e.g. instead of trying to get MSR values into the exact
right state when switching write methods.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/msrs_test.c | 22 ++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index 98892467438c..53e155ba15d4 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -153,6 +153,9 @@ static void guest_main(void)
 	}
 }
 
+static bool has_one_reg;
+static bool use_one_reg;
+
 static void host_test_msr(struct kvm_vcpu *vcpu, u64 guest_val)
 {
 	u64 reset_val = msrs[idx].reset_val;
@@ -166,11 +169,21 @@ static void host_test_msr(struct kvm_vcpu *vcpu, u64 guest_val)
 	TEST_ASSERT(val == guest_val, "Wanted 0x%lx from get_msr(0x%x), got 0x%lx",
 		    guest_val, msr, val);
 
-	vcpu_set_msr(vcpu, msr, reset_val);
+	if (use_one_reg)
+		vcpu_set_reg(vcpu, KVM_X86_REG_MSR(msr), reset_val);
+	else
+		vcpu_set_msr(vcpu, msr, reset_val);
 
 	val = vcpu_get_msr(vcpu, msr);
 	TEST_ASSERT(val == reset_val, "Wanted 0x%lx from get_msr(0x%x), got 0x%lx",
 		    reset_val, msr, val);
+
+	if (!has_one_reg)
+		return;
+
+	val = vcpu_get_reg(vcpu, KVM_X86_REG_MSR(msr));
+	TEST_ASSERT(val == reset_val, "Wanted 0x%lx from get_reg(0x%x), got 0x%lx",
+		    reset_val, msr, val);
 }
 
 static void do_vcpu_run(struct kvm_vcpu *vcpu)
@@ -305,5 +318,12 @@ static void test_msrs(void)
 
 int main(void)
 {
+	has_one_reg = kvm_has_cap(KVM_CAP_ONE_REG);
+
 	test_msrs();
+
+	if (has_one_reg) {
+		use_one_reg = true;
+		test_msrs();
+	}
 }
-- 
2.51.0.384.g4c02a37b29-goog


