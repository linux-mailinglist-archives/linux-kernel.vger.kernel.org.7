Return-Path: <linux-kernel+bounces-667426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B39AC8537
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 01:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A075C1C007F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7351267F77;
	Thu, 29 May 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5P2PXIR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB7267711
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562052; cv=none; b=scwFn6iXFo3+p/9R9prVtTyOlYWGB5knGqW6BVHfixkZBtV0FjsAzrLBF3QpKCF3Fxj4zSnfxV0p5p+qTOoa34mEGoi6+K9Znv2rtSNdmvHFY1JxNpTNn+2PKqUGd6MlXH11z2GdRqHos4Lw1J/OJglO7jchSZMXS7RdPKTad2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562052; c=relaxed/simple;
	bh=3Ss96AAD1zcLzWkvW+r+tlN+q9wQb93Ov1S2Eah97js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOuHfdRVcEzf9TmwfrrBEiJoevAJ6qijM31i15zyM/BT4oTEYS0FY1WRJ+T5PzrTwAaWaRz+zxpwLEIlKvgRapXeEOobzCw6YIvHhJ63cG1Mb9rmuS5S16KpnBM05Rbdr1pt1ul8YUHREqavAaSy1VyLUYIp4r68RnmJLBFise8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5P2PXIR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7377139d8b1so1203493b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748562050; x=1749166850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ICiJiSxOLmQxtER1UTGYaICTPY0kJa+u8J+f2toknpc=;
        b=b5P2PXIR4MBjxB7N5X+3FxGdyNrCepmaT7/H3Ycn2Bv9xBuwMuEKXwAm+Mz0qT0m0s
         OI+oy6r71PTNn92SmJgmlOwttNr36wqKktwOyTUdu6oRp4hxTSVQzfb6gO/9h0j7r7R+
         a9olOEJwu25TvT4W6AyVSObotmNdnf86MSTelEd3ovkyIEIF1HvCv4kTC9oWsAAIqdpa
         F34vMwQdvoP7QTwO2E3TxVzKcVijJ1QGf3yCbrelWtqX1VHEXu5Gun0olJsMk02eHO1X
         jnlOBivi5TMLvaBmdqBO3qFKVgwMrcURj/Mkm3El9AhKZYYi42EyhS8Wzkmmwrh7HdGt
         4vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562050; x=1749166850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICiJiSxOLmQxtER1UTGYaICTPY0kJa+u8J+f2toknpc=;
        b=dfLui7S3KqXdYf6otq4BsItUibl7jE8KEGQZfsPtEfOOg4th3pMeSL+j5WKCe2Cfh/
         ttDmMt8L3jGTSTbifFEx5criZI3ryDZuvCkxVeuWoH4Pz9P454tENbDsRsdWiSVohXeh
         aBCjsFTgKNKRFsl4AD5thTGoofUdRgdsTlQsuE5vDzpKEoYVrHeN2CG8rWX0C+Lt7xjt
         nQTuDfPnpCmtl5PqZdLyGphh7OqazV00GcrfyVm5gWoRAYIajPE7WC5lVL/5ejzUhv/7
         GbdM0jOCJ1Et+xnett6XZRjwQvHHvBQwHIuj3Lzi3sRLkl8d6cDuP+Jr50DA4gY3/a3b
         3TsA==
X-Forwarded-Encrypted: i=1; AJvYcCXjzw6aTKpoFB5PhS+UlzUTEFiP00OV+T96UX7EsaOae1UbWA3WadOh/DXHhAsf6jxWOPfZ6Oz/hw/kxvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJr4btkPkpcuEWcA0pROM4MkMyANCCSRwh6FXf6+Qncj87ZUy
	BSEyKHYYTAzcB64Twzf2k1GX1hEmcbMcvS4JGaTE2mO2b64VI+f8T3hU3q727ty5NFgHZ2qm8bJ
	BA7UJbQ==
X-Google-Smtp-Source: AGHT+IEkzQv92LgC6XPOHAO80Xw4IzD4slJRTbmhAV7VxAG9t7v05ThV8+ubj9WSHvkwXXpBOx2W0zebT8o=
X-Received: from pgbdk1.prod.google.com ([2002:a05:6a02:c81:b0:b2e:bef7:3f03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6494:b0:218:c22:e3e6
 with SMTP id adf61e73a8af0-21ad952e37cmr2162295637.12.1748562049784; Thu, 29
 May 2025 16:40:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 16:40:04 -0700
In-Reply-To: <20250529234013.3826933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529234013.3826933-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529234013.3826933-20-seanjc@google.com>
Subject: [PATCH 19/28] KVM: SVM: Rename init_vmcb_after_set_cpuid() to make it
 intercepts specific
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename init_vmcb_after_set_cpuid() to svm_recalc_intercepts_after_set_cpuid()
to more precisely describe its role.  Strictly speaking, the name isn't
perfect as toggling virtual VM{LOAD,SAVE} is arguably not recalculating an
intercept, but practically speaking it's close enough.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a9a801bcc6d0..bbd1d89d9a3b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1107,7 +1107,7 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu,
 	}
 }
 
-static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
+static void svm_recalc_intercepts_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -1273,7 +1273,8 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		sev_init_vmcb(svm);
 
 	svm_hv_init_vmcb(vmcb);
-	init_vmcb_after_set_cpuid(vcpu);
+
+	svm_recalc_intercepts_after_set_cpuid(vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
 
@@ -4522,7 +4523,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
 
-	init_vmcb_after_set_cpuid(vcpu);
+	svm_recalc_intercepts_after_set_cpuid(vcpu);
 }
 
 static bool svm_has_wbinvd_exit(void)
-- 
2.49.0.1204.g71687c7c1d-goog


