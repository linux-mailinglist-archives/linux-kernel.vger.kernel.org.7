Return-Path: <linux-kernel+bounces-776687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C43B2D07C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BC566942
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823C30F7FC;
	Tue, 19 Aug 2025 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+LQvu5T"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2623054E3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647333; cv=none; b=q1O3EgdAwr67rXRbYdmgjWX0LczaMmZOGlU9mTHaicEvzDB9yixHoj+81pmv7bBM6vv2w/X+eF09qfYZ2C27OjNxa1xz2uNM4vzjL0zv0R82s0WjUzI18rDXfNEOHeIw87X6BoJWZSOLONK3o2g9k5rk5KuVDdDmuQ8GeRCS08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647333; c=relaxed/simple;
	bh=lITnaRkjBJqY+s4uyQTehv1KV2HCpxGls0cZ6YtYGyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcjLVbdEy79BhOP5YTAeBmxrAKGQQF4m+dIyGn1HnTwuPU95wdL4/acKFvNQjkEh3XunPQJcqQoWBrxbpmI9vV2yV5WwoIJyycwx/AtSHlsg4R+hDNtLSd58/hJBTkdqTCs1C8ShSQ24UyQ9bJWy1azls/cqPnwLJqvPt3ckszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+LQvu5T; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e017eeso5743558a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755647332; x=1756252132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tth4gC5ORJ8LF8jN+rSvkEDxOuRgeyGlIIpPyPLGE3o=;
        b=S+LQvu5TEJaXSX9VzthtuWnAkoXsiLDWxX2XZQ3LVx+fRlJfePzvqWCR3BIkElBkGE
         oHLvY9iqDNWEZjE9MKb0uLVcXmiVqjJmj8WaLmAYSot0emU/aEZhXY6sgGtn+h0gqqxw
         yZ5vgid8yqEFizcmL/E9fYMAALpMgWXecxU6XTSm3KaMCqRDr/x+YVp6LfcihuV833dd
         OZ0JXFV+UTjfcpU/lQ3gYPw7rk8ll5ipZmpQ4dXJvcC7OiIDKFFWY0Uh0elRGWWXRd4A
         /80415ACmunSuPu6/GpU7W0xEUKzb4WL/+EkSLc7yqkRDOSyfSZDRC2HgvLwcyEqCkha
         DI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647332; x=1756252132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tth4gC5ORJ8LF8jN+rSvkEDxOuRgeyGlIIpPyPLGE3o=;
        b=XolaajHBT1NxKx4+RA5N0AOfx7ByAqeG2cBTtR+CsxNI70SKux298o6QeC8Lzs6MQP
         Pf6CaEKZ/8qJyv+TFMQSaIk3F2hPsXv7YXRpE0Jy+xKkjlebloD/dzWW+T9sJe57bzZz
         AATZB72Xc59N2nS8AmRZY7lIUX1/WTrzFBkcKsRBlAMW2JA3B+y8zoTp5uTgxG+30Lrv
         BkD7iDQTLYyOIbcXZ2TaMu3hpdax0+YiBx1e9H3QD151lbjSQjrrOeA2FB2yX4BDQn0F
         JyY8aHbt6RUMIKqFqFNDsY9Pxye5qF7dCy3TY+XxFjbK1T9Cn9yP9fKEeGBR2P5hlgMJ
         7m2w==
X-Forwarded-Encrypted: i=1; AJvYcCXdN8ZJ44BaPV6HOI6kn7NsAOldfobeRK6tIwADqFtEK51vbc5Qzhgk5WWz7cxBPzVbK4+Ysn6FvssZ65o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7kz+h7AkuBytG9iGbfpfnuFVjJMGYDrglZPXqszf1S/gplZt
	JpserMJYBJ9d3UHN3lsybZmlCVk11V3Jp9xnoOuufZqYrZ/PBtVzNwHoIIb3aE4mLqSOsEKDiDl
	3JQmbmg==
X-Google-Smtp-Source: AGHT+IG2cqgU08PbgqqndLfgFE9jwo7bEi262vS+JQXh7SdNHWZB2+dLGBX8Ek0J2Jlc79qXI/pkZvdeMdY=
X-Received: from pjbnc7.prod.google.com ([2002:a17:90b:37c7:b0:313:274d:3007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:584b:b0:31f:12d:ee4f
 with SMTP id 98e67ed59e1d1-324e1423ef4mr1131948a91.23.1755647331805; Tue, 19
 Aug 2025 16:48:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 19 Aug 2025 16:48:32 -0700
In-Reply-To: <20250819234833.3080255-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819234833.3080255-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819234833.3080255-8-seanjc@google.com>
Subject: [PATCH v11 7/8] KVM: SEV: Fold sev_es_vcpu_reset() into sev_vcpu_create()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Vaishali Thakkar <vaishali.thakkar@suse.com>, Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fold the remaining line of sev_es_vcpu_reset() into sev_vcpu_create() as
there's no need for a dedicated RESET hook just to init a mutex, and the
mutex should be initialized as early as possible anyways.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 7 ++-----
 arch/x86/kvm/svm/svm.c | 3 ---
 arch/x86/kvm/svm/svm.h | 1 -
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ee7a05843548..7d1d34e45310 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4577,6 +4577,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct page *vmsa_page;
 
+	mutex_init(&svm->sev_es.snp_vmsa_mutex);
+
 	if (!sev_es_guest(vcpu->kvm))
 		return 0;
 
@@ -4592,11 +4594,6 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void sev_es_vcpu_reset(struct vcpu_svm *svm)
-{
-	mutex_init(&svm->sev_es.snp_vmsa_mutex);
-}
-
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
 {
 	struct kvm *kvm = svm->vcpu.kvm;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8ed135dbd649..b237b4081c91 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1244,9 +1244,6 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	svm->nmi_masked = false;
 	svm->awaiting_iret_completion = false;
-
-	if (sev_es_guest(vcpu->kvm))
-		sev_es_vcpu_reset(svm);
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 321480ebe62f..3c7f208b7935 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -829,7 +829,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu);
 void sev_init_vmcb(struct vcpu_svm *svm, bool init_event);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
-void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_es_recalc_msr_intercepts(struct kvm_vcpu *vcpu);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa);
-- 
2.51.0.rc1.167.g924127e9c0-goog


