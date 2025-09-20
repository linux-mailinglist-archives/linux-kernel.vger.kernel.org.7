Return-Path: <linux-kernel+bounces-825274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854BB8B7AB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3A75A269E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E12D94A5;
	Fri, 19 Sep 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGE0KS8m"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199712D77E6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321190; cv=none; b=d7wGqiCpDxg7GmbTKegDsMtrYdzsgXNTiyKLBUdRc+tC1OM6QgpJzHRW3h+0LN6JX4ZDRZluI4oW/V9NlR2b6BrbrSkdY20tg8JUm6LCPJvqudOA1MpbWNsVnnjz+/FBSi3FK0UeYF9V9PJaa/KAaot9I4MiVmKAVGh2mNWlB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321190; c=relaxed/simple;
	bh=UobUTzMqC05bXJMUZdQ8rImj8lRdVYmv6o009lR/JHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfhdplbJkEgXEKevPWhAzzLY9s9T6HKqKoyhW1Jk22zVumTMeUnXqohUUhP5jXaMgOhCujkMK+u31sayMPyh/k9I2UQi66V+Qg+XaOiYgz1QpK+5fsCzmK/E2pJ7gtkRQWfpIwbi8fv6WQqpPiwCPZausSmwv6mSm4oqU74YC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGE0KS8m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5529da7771so522351a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321188; x=1758925988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ixpPVdW6ymYR/Sgly9KQ3MBVVSS1q02WNDC+Rc0Qg3w=;
        b=zGE0KS8mLfJd3phMpZucwTUGzFNMxNH9F0Dh/42LNEPH5IPrkeytMfO4+S2be5/gDW
         IOdYcmrosJZb0HaYfbvbd4FYDTVO2231QKamIWhT9YvBtETprue1hSHTKww4Sm8D6jLI
         HL9vqetSDE14kV3EroGe6+m2mE2a3mW3XuulEZvwE2shhxXEcn3qQlDj1rseYoX9BmuG
         RfB++iXX/JCnXmvI2v3uKwQj8tOeFuH7Wm88awdDS+q4yQBljQa99LWkCncrgW5j8nXy
         OIoN9sy7Kvd88jmKvRGUaJm5PRvp/wiDbQ4wk5t7t4YG4WtsORbWeh7EW3e4qLgyBZSR
         cczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321188; x=1758925988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixpPVdW6ymYR/Sgly9KQ3MBVVSS1q02WNDC+Rc0Qg3w=;
        b=KpSM/uHmWia4o/Q51spXaeRVZod8JslWb4neAbWHZNqR9kj6EkLNgjvjU/USwLiZjN
         HOEZwhe8yDzW0wptC69Une4aPvWvbJtFLyuDntLSPJ+5fm3cG/miy0TMq89Imw91SwIz
         HMjtclrXbvTS1UErZTnsWKR1Y0G4bVwh5QhP31Xsu7Gty/dvaiRTSty2YCm70XZPaqrv
         46LF1svrXm/XuQ3nmc70N1Sx5QAGH67lMEIHzWLNhGjVTWBluY6nqne+gSHWi3s5NRxH
         wB8PHuiOqno8Ihj6m16At1PEMkwpnpxc4Fw21WUdFEYDNJkKm0X30K4E9IFHERMEC5Ck
         PwRw==
X-Forwarded-Encrypted: i=1; AJvYcCXZL+8+V8wSWMJtJtpLFxrITdW21Y5+Qom9x2yRpcXBiEbBDSfitzKNASqWWapWiRxwLPnyGmdLoIBOigw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26Vt9sCgVA7eS0GU96DrayZdKbGYGQkBKJROWnz0FnhrRbAEW
	ayNwnUXs+arIEUoJPUk6sqaxDsRNAOZUARd3+VSdQIU4oWVCO6ayMJJjIuAbJcSJZVyAOwZ1cGy
	iXww+4Q==
X-Google-Smtp-Source: AGHT+IHDIt3mGTg5sdY1TgXVXI8NfCXU6BVeF9xyfPXLCLsKgnEhjYnK38hGEGobV80rZKftecO+qVuofKE=
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:32e:c4a9:abe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9143:b0:262:da1c:3c13
 with SMTP id adf61e73a8af0-2925ca2785dmr5941880637.9.1758321188377; Fri, 19
 Sep 2025 15:33:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:10 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-4-seanjc@google.com>
Subject: [PATCH v16 03/51] KVM: SEV: Validate XCR0 provided by guest in GHCB
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Use __kvm_set_xcr() to propagate XCR0 changes from the GHCB to KVM's
software model in order to validate the new XCR0 against KVM's view of
the supported XCR0.  Allowing garbage is thankfully mostly benign, as
kvm_load_{guest,host}_xsave_state() bail early for vCPUs with protected
state, xstate_required_size() will simply provide garbage back to the
guest, and attempting to save/restore the bad value via KVM_{G,S}ET_XCRS
will only harm the guest (setting XCR0 will fail).

However, allowing the guest to put junk into a field that KVM assumes is
valid is a CVE waiting to happen.  And as a bonus, using the proper API
eliminates the ugly open coding of setting arch.cpuid_dynamic_bits_dirty.

Simply ignore bad values, as either the guest managed to get an
unsupported value into hardware, or the guest is misbehaving and providing
pure garbage.  In either case, KVM can't fix the broken guest.

Note, using __kvm_set_xcr() also avoids recomputing dynamic CPUID bits
if XCR0 isn't actually changing (relatively to KVM's previous snapshot).

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm/sev.c          | 6 ++----
 arch/x86/kvm/x86.c              | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17772513b9cc..8695967b7a31 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2209,6 +2209,7 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
 
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8d057dbd8a71..85e84bb1a368 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3351,10 +3351,8 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 
 	svm->vmcb->save.cpl = kvm_ghcb_get_cpl_if_valid(svm);
 
-	if (kvm_ghcb_xcr0_is_valid(svm)) {
-		vcpu->arch.xcr0 = kvm_ghcb_get_xcr0(svm);
-		vcpu->arch.cpuid_dynamic_bits_dirty = true;
-	}
+	if (kvm_ghcb_xcr0_is_valid(svm))
+		__kvm_set_xcr(vcpu, 0, kvm_ghcb_get_xcr0(svm));
 
 	/* Copy the GHCB exit information into the VMCB fields */
 	exit_code = kvm_ghcb_get_sw_exit_code(svm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e07936efacd4..55044d6680c8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1235,7 +1235,7 @@ static inline u64 kvm_guest_supported_xfd(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
+int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
 	u64 xcr0 = xcr;
 	u64 old_xcr0 = vcpu->arch.xcr0;
@@ -1279,6 +1279,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 		vcpu->arch.cpuid_dynamic_bits_dirty = true;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__kvm_set_xcr);
 
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 {
-- 
2.51.0.470.ga7dc726c21-goog


