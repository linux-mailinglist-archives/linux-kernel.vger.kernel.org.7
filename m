Return-Path: <linux-kernel+bounces-680512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549BDAD4658
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 01:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6338E188FCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC22951D8;
	Tue, 10 Jun 2025 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Fqr/kR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCD260565
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596303; cv=none; b=uasWn1bnibmH8mmbmz3qLWaKLtDWPU8VjRviFUUjP3ZWj6rQMAMC052KobOAS8lU7qTOOHLR3gtHRWmFOs2An8Mwfe9iZ8+yGA/YVXU59KY0DssT9prOEZgiEPY66vhdJGoBCjN+HqFvRWWtlxb2Tb4gEZCLxhdIpSUTUGL3KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596303; c=relaxed/simple;
	bh=IB7MuUnuIgiPbLKi3Tq9cVagh02TXhUkYhDO6XH5nEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HKC5uyp4FopJJ49g16f6BjqJPYs5x5SkbJaMPB4h2QBsN6T0sVokM+Vc7mlgXC7pNe1WfmCQsyhgMPCc4kka2uZ8Tjha7iI8H23HwgKdpf+tgJb6oaGpln/ELwPgROKGQCXi9LJsZexrA530MNKWuQtXPjX730PS7vGs2Q+wRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Fqr/kR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so2290448a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749596301; x=1750201101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ruy+gu6RGSeT+f9/V4uicP7PXhGDQAcKPy/FYrm3WvE=;
        b=C4Fqr/kRJdqxMEecE2E0xEkGRqIwa7/i3f1wI9Ls/PqS5TLpkg6pYNYLBsh+YJETNz
         PgLKI6fb2rFk30KE5PorEv7000XAzg2ISa1TUYXopsZ7/dTSSpF8ZfJtxLsLWjjVOG9E
         qYiOwb2mIkRJtC3ay23JG9VQtnH7t3s1witPr8h+0Qml06vAGhCsD/WRz3GsEmxn/Vo9
         a79taufW/k6H7XVSzFg3nkGzIec75SEnBaqxO2+9Ui5N70+lZAWfEsJgCwvqbDhQf3Ja
         nkiulmK49vd9Gp+DoXvvM4GzewTkPTdnWwnsvoyIW5KHofdEw0XOhUxx1TLqDXkVmjgr
         Q3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749596301; x=1750201101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruy+gu6RGSeT+f9/V4uicP7PXhGDQAcKPy/FYrm3WvE=;
        b=JKcQvLNBdtFFDL9gnJyA5D28njaLVRw0Bb0aCg5XBUxc2LbVMyvwzoMfGSIJ70/SdY
         IuBHhNCFpjE13HZ1tVp3j13jPVFFQEXZEWZL4HBpXsAeLC4rrVSh3Lcs9p7/vnofhLzN
         Yi4V+DAXZ9OZZf0dXsICzbs0QnlKUeqKmhrSldWp22YccvnWLLb9Sgydvy3gekr6u6CQ
         JBJB8YzhFphVzDhSWP0p1F4VobnC2RC63+PvYVRQosNog/wa3Su97xavhY9xmmpWJW0v
         NgJidbEMzLxL83ZJ7HebPGksq1Hr1AtCZvDlV3ZUHAkU8xJrV3aPzkrG/7iXWSnl9Ljm
         v07A==
X-Forwarded-Encrypted: i=1; AJvYcCWzpATuoyuE1KX2wHHHA5jyGXUttm9BdPec57ov1YZTN7IxVwOiXtjs4TF+2mIx5jBRbpGLuI6y8DY/OAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERLsCItdjTww59A9Yi0P7gWaZKz7JvcF+6pvwYWOrNYpy2Nsj
	WLjH2ev5IBVfsieYe1qAxjFQbi/lFDmNo5xNrauqlqzJ3qkpOf0WBcmrLnPtZXxiyfYOc2i1M0q
	b4Im2Lg==
X-Google-Smtp-Source: AGHT+IFbea8RU8Wa7FlWpADnbF097Ndh4OlVRSMm3Srv7lWxi5ffWqJcVZoxQ6p+4c7SYNx97eTifIhcUmA=
X-Received: from pjz3.prod.google.com ([2002:a17:90b:56c3:b0:312:e914:4548])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50:b0:311:c1ec:7d03
 with SMTP id 98e67ed59e1d1-313b2011f52mr491202a91.32.1749596301442; Tue, 10
 Jun 2025 15:58:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 15:57:29 -0700
In-Reply-To: <20250610225737.156318-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610225737.156318-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250610225737.156318-25-seanjc@google.com>
Subject: [PATCH v2 24/32] KVM: SVM: Drop explicit check on MSRPM offset when
 emulating SEV-ES accesses
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that msr_write_intercepted() defaults to true, i.e. accurately reflects
hardware behavior for out-of-range MSRs, and doesn't WARN (or BUG) on an
out-of-range MSR, drop sev_es_prevent_msr_access()'s svm_msrpm_offset()
check that guarded against calling msr_write_intercepted() with a "bad"
index.

Opportunistically clean up the helper's formatting.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 59088f68c557..9e4d08dba5f8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2767,12 +2767,11 @@ static int svm_get_feature_msr(u32 msr, u64 *data)
 	return 0;
 }
 
-static bool
-sev_es_prevent_msr_access(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
+				      struct msr_data *msr_info)
 {
 	return sev_es_guest(vcpu->kvm) &&
 	       vcpu->arch.guest_state_protected &&
-	       svm_msrpm_offset(msr_info->index) != MSR_INVALID &&
 	       !msr_write_intercepted(vcpu, msr_info->index);
 }
 
-- 
2.50.0.rc0.642.g800a2b2222-goog


