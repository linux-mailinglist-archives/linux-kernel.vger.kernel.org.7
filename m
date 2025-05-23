Return-Path: <linux-kernel+bounces-660029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77AAC1826
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEF3A40B96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 23:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885272D29AE;
	Thu, 22 May 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeE7hTOb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646272494FB
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957071; cv=none; b=IKyfLjXrstiX97UtRbtCb7ZXEN2/8t1k8MrtmhN/aBePKg6fkpKPI9WYBrwzaH5Tt9m1p+1UeCzCC4ftNmQ8GTe3aw0FXSX4a8PAgb79wyMnEfC/toJpyv34TELONspob2017lZV5nihOCQq2IZf1Ceh1DEVcM2WhWRQHaAYhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957071; c=relaxed/simple;
	bh=rKtp5xfoIimuXjCjQBqX07AVfylVXbINV44Xdk84ous=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K7f+LNg0V27fmfa+gcbeumpdl3Mp0Zruh4cI9YPIyEiLSV22pWEp6dbvAyQKfuDgerWdaU9uQyPiyzHAfQNFyT3N5CdhX8PZCQEXeXYBlmBnqZKB/q6dvjhVecHIH2JuU5x5PHofrYFXR7g4bp/F2DdgPFhIe/pMXfrFpZaxfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeE7hTOb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ec5cc994eso4767408a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957070; x=1748561870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DbY8RCgDJTqdxQLDkHfni+7ks/LJfloWj75h6P2Hb4U=;
        b=QeE7hTOb64D9guwsXs+QkxPqYqYyi4tckCb6dBIQCy/QwDk3F3zWNriozymP22c87p
         esHTVkdLqxi5iK1L+g5FlfwBhstHQiQulee1DtNVui1J9q5F19l170gzDd4gIwfAYtS0
         qpqI21bdXIJ5BQvfGzsq5EU6/SVI8EWAr9mKea1SOxdbPHnUFjQ+crwtSHmXyufQtePA
         0WXfyxc8QD1l1g16s3Vkb1rVR6WjChtrPNYAcOiNNwPVSW/khx6L34+P7gw9TVs3zyyP
         xobfBwCARAQSh67DCUGiqXxbF/H8OC4l2stYu4YsdqgB9baPa6bKWqP5T1x8MYLCq8Ke
         oKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957070; x=1748561870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbY8RCgDJTqdxQLDkHfni+7ks/LJfloWj75h6P2Hb4U=;
        b=LnJGva7pxuKOawzxoVXV4Dviq4N5z18wbmvAbtH/fJoPsLPB/Ri4F3bJGP6tzjY3OP
         CFHFacn5FSTzhrEJcosum25d26SRChPDnhXqkgLp7kx0xjQFJYzP3O9+Y8uyB3GDMNZV
         MfZRto6BhsBK4Gw1Ofa3eMIGP1mRVGgzWeIYdSG0Z/AuboOqJN42xY7oCvkLUZAvYY+7
         Q2S1xWCfSMVc5GCupIqClvRxuA/saiDVI0zfXYqQFzGJUEYstgpMxdD+4dLhFLU20kwg
         sG5tn4uk0u9JtifnLtdfQBnHiIH3IEW5HltUsAk3VvKCCY1Jxx5Qe/vnyKYXmKAbAXqO
         yUDw==
X-Gm-Message-State: AOJu0YzB9BCZEQnwJvX5ewUafqQhJv40r3yA3p6Xk1o1C+LMLNxMBIL0
	mg9UQdUNVjiT3G61CM8Cv6Suulouh/7o+gO15f1PZdxQ45fkv16jboEjLo/xT0hDTx+6Siw32td
	0m0hbnQ==
X-Google-Smtp-Source: AGHT+IGjzBQd6j4J8ysyd/Avsyzv8cw/ixuwdZ+zXrYI9Hkoyaw+vaTqL9WLjC62S+SSSB53dg47wGK8xzs=
X-Received: from pjbpt3.prod.google.com ([2002:a17:90b:3d03:b0:2ff:852c:ceb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4e:b0:310:8d9a:eb1c
 with SMTP id 98e67ed59e1d1-3108d9aeb4fmr12062419a91.21.1747957069850; Thu, 22
 May 2025 16:37:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:37:29 -0700
In-Reply-To: <20250522233733.3176144-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522233733.3176144-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522233733.3176144-6-seanjc@google.com>
Subject: [PATCH v3 5/8] KVM: x86: Use wbinvd_on_cpu() instead of an open-coded equivalent
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Zheyun Shen <szy0127@sjtu.edu.cn>, 
	Mingwei Zhang <mizhang@google.com>, Francesco Lavra <francescolavra.fl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use wbinvd_on_cpu() to target a single CPU instead of open-coding an
equivalent, and drop KVM's wbinvd_ipi() now that all users have switched
to x86 library versions.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1d0e9180148d..d63a2c27e058 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4965,11 +4965,6 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return r;
 }
 
-static void wbinvd_ipi(void *garbage)
-{
-	wbinvd();
-}
-
 static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_has_noncoherent_dma(vcpu->kvm);
@@ -4991,8 +4986,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		if (kvm_x86_call(has_wbinvd_exit)())
 			cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
 		else if (vcpu->cpu != -1 && vcpu->cpu != cpu)
-			smp_call_function_single(vcpu->cpu,
-					wbinvd_ipi, NULL, 1);
+			wbinvd_on_cpu(vcpu->cpu);
 	}
 
 	kvm_x86_call(vcpu_load)(vcpu, cpu);
-- 
2.49.0.1151.ga128411c76-goog


