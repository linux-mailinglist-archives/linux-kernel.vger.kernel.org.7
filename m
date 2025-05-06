Return-Path: <linux-kernel+bounces-636507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B1AACC26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEAF1C041B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D9284688;
	Tue,  6 May 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhbUB/Y5"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A422222D5
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552259; cv=none; b=ZAlbm7FLlpDl3DD9KLi4N3fi46SKTYdeKMXcs+htRXImY/8TrvLS5tIBErzf9oCkETq9/yTK/omwtad96u5WdUMS2+Hx4Ev8J4NGSl1J6esM/6kVHRhmi4yKrAblGLS0JzdmaYFIz5fN6ddmd0vJvWmRI78cz0IAxWkFcPMQic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552259; c=relaxed/simple;
	bh=IdGbEdHyjZJT5C1oM6iM7xIhOv9ntyMqFaLBguLMXdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSMHgKXWZ8zayJNy/iqm+QRzeGC83NFqhNrEPiAZMJ29xTmpGbMtZoVSBDyL3Zob8jwOVO4XMJqCzYCUFfh+qIsR+nF8UWWe2TN5isspXzjTFV8U+Mgmcg/KJNg1O2FP2uqheEjLnKVJWDsAyXHPbGD4qD+ahu7FYrAan4/ys4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhbUB/Y5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7369c5ed395so6238167b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746552257; x=1747157057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGKfxtJyX20o6pj7ip5bOnBoDMJQyXMLqvh6rlBK1oI=;
        b=jhbUB/Y5VRPdUxbxXaeZoE/RzE+dCO5nkmPzJf4gkVh9tRyFfgnZnBCrwBrB9mH+f5
         IjjIN7aKu862cDwnzEPDHexKo1BoWRHD6lfxsZOQQ7UsrhFfxli41rzyfVuSJMVZAwEv
         ZGtnoJb++SmWjF/sTY7B/NrsyqiCzCtU0Ut/EBsD/aWCZwjZU3SVrvnMnZWEf4xkdkhL
         l/NQQCe/+aRWVkXEKeDt7ym4/r5cbU6/ONeZ7+wXf6MNDlMdChIa1VPUSX9mPAS3ZbhO
         DaQESnHvyWoBPWEBcYSHklal3yqfcPY89Icsgy2Shbc1et2ueHKpZgKd/t75i5KcLMiE
         8FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552257; x=1747157057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGKfxtJyX20o6pj7ip5bOnBoDMJQyXMLqvh6rlBK1oI=;
        b=uCb6OvTjwD/I0MDOXqAd4Lq7ASyozG218uQVTQO39f1GFjIwZ34kvJBrUzgjd1hWU/
         X/seBlT0Wc7ScgoTCAN1BMk50NeTq5ZOITvGNew+lYsKA4YL4EpifTiL3uXCyvGPL2ko
         OJllmulm9W0c0Vot0pFVZYYOQlq+uXXiZZIfhO+yHUst0iN8HX0iVyv8YMpp4FEdsxRM
         wswj+H8vHrWE6SRU3fPS8nSbFqQESP4scThPrEbB+3Wx1PeMXlYNXluhhR3dYBuNb3XF
         NP71sJ42cnqJt9+LlKdIAfWS1YS3y5RtwiZ7NYCtMZtk5JcqoGc33IaBvrpW+UZAwFII
         /Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCWq/Rt32GUbD1d6mA7SufMgrff15lAjSwALUIkl6vDaYXZfs8hUTBuGOIgzzU6wLFt1alvo3/OyYL/HsBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlalZpYvU1z4LmGUEQaqmlcKXOQSfcfsGk9UmPzJMHDvslLPg
	9txaIABdVX3oXHPFo094EOyowM8O5MKNnagUbGVT7b79+oZgr/qqv2ecCUyXQ7fFaxRz6N7AqW7
	oQg==
X-Google-Smtp-Source: AGHT+IF+R1eJ2tNQSsY9U1udegKSTqemCqTLk60z/7o6qErqmmDwOHQs9PxtXkJdMi43Y2kduHM77PYXBwE=
X-Received: from pfst45.prod.google.com ([2002:aa7:8fad:0:b0:732:7e28:8f7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:930b:0:b0:740:9a42:a356
 with SMTP id d2e1a72fcca58-7409ba29efdmr646596b3a.11.1746552257369; Tue, 06
 May 2025 10:24:17 -0700 (PDT)
Date: Tue, 6 May 2025 10:24:15 -0700
In-Reply-To: <20250506093740.2864458-6-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506093740.2864458-1-chao.gao@intel.com> <20250506093740.2864458-6-chao.gao@intel.com>
Message-ID: <aBpFvyITMc0WhlX4@google.com>
Subject: Re: [PATCH v6 5/7] x86/fpu: Initialize guest fpstate and FPU pseudo
 container from guest defaults
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	tglx@linutronix.de, dave.hansen@intel.com, pbonzini@redhat.com, 
	peterz@infradead.org, rick.p.edgecombe@intel.com, weijiang.yang@intel.com, 
	john.allen@amd.com, bp@alien8.de, chang.seok.bae@intel.com, xin3.li@intel.com, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, Eric Biggers <ebiggers@google.com>, 
	Stanislav Spassov <stanspas@amazon.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 06, 2025, Chao Gao wrote:
> fpu_alloc_guest_fpstate() currently uses host defaults to initialize guest
> fpstate and pseudo containers. Guest defaults were introduced to
> differentiate the features and sizes of host and guest FPUs. Switch to
> using guest defaults instead.
> 
> Additionally, incorporate the initialization of indicators (is_valloc and
> is_guest) into the newly added guest-specific reset function to centralize
> the resetting of guest fpstate.
> 
> Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> v6: Drop vcpu_fpu_config.user_* (Rick)
> v5: init is_valloc/is_guest in the guest-specific reset function (Chang)
> ---
>  arch/x86/kernel/fpu/core.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 444e517a8648..78a9c809dfad 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -211,7 +211,24 @@ void fpu_reset_from_exception_fixup(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
> +static void __guest_fpstate_reset(struct fpstate *fpstate, u64 xfd)
> +{
> +	/*
> +	 * Initialize sizes and feature masks. Supervisor features and
> +	 * sizes may diverge between guest FPUs and host FPUs, whereas
> +	 * user features and sizes remain the same.
> +	 */
> +	fpstate->size		= guest_default_cfg.size;
> +	fpstate->xfeatures	= guest_default_cfg.features;
> +	fpstate->user_size	= fpu_user_cfg.default_size;
> +	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
> +	fpstate->xfd		= xfd;
> +
> +	/* Initialize indicators to reflect properties of the fpstate */
> +	fpstate->is_valloc	= true;
> +	fpstate->is_guest	= true;
> +}
> +

Extra newline.
>  
>  static void fpu_lock_guest_permissions(void)
>  {
> @@ -236,19 +253,18 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
>  	struct fpstate *fpstate;
>  	unsigned int size;
>  
> -	size = fpu_kernel_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
> +	size = guest_default_cfg.size + ALIGN(offsetof(struct fpstate, regs), 64);
> +
>  	fpstate = vzalloc(size);
>  	if (!fpstate)
>  		return false;
>  
>  	/* Leave xfd to 0 (the reset value defined by spec) */
> -	__fpstate_reset(fpstate, 0);
> +	__guest_fpstate_reset(fpstate, 0);

Given that there is a single caller for each of __fpstate_reset() and
__guest_fpstate_reset(), keeping the helpers does more harm than good IMO.
Passing in '0' and setting xfd in __guest_fpstate_reset() is especially pointless.

E.g.

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d5f3af2ba758..87d6ee87ff55 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -212,25 +212,6 @@ void fpu_reset_from_exception_fixup(void)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
-static void __guest_fpstate_reset(struct fpstate *fpstate, u64 xfd)
-{
-       /*
-        * Initialize sizes and feature masks. Supervisor features and
-        * sizes may diverge between guest FPUs and host FPUs, whereas
-        * user features and sizes remain the same.
-        */
-       fpstate->size           = guest_default_cfg.size;
-       fpstate->xfeatures      = guest_default_cfg.features;
-       fpstate->user_size      = fpu_user_cfg.default_size;
-       fpstate->user_xfeatures = fpu_user_cfg.default_features;
-       fpstate->xfd            = xfd;
-
-       /* Initialize indicators to reflect properties of the fpstate */
-       fpstate->is_valloc      = true;
-       fpstate->is_guest       = true;
-}
-
-
 static void fpu_lock_guest_permissions(void)
 {
        struct fpu_state_perm *fpuperm;
@@ -260,8 +241,20 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
        if (!fpstate)
                return false;
 
-       /* Leave xfd to 0 (the reset value defined by spec) */
-       __guest_fpstate_reset(fpstate, 0);
+       /* Initialize indicators to reflect properties of the fpstate */
+       fpstate->is_valloc      = true;
+       fpstate->is_guest       = true;
+
+       /*
+        * Initialize sizes and feature masks. Supervisor features and sizes
+        * may diverge between guest FPUs and host FPUs, whereas user features
+        * and sizes are always identical the same.
+        */
+       fpstate->size           = guest_default_cfg.size;
+       fpstate->xfeatures      = guest_default_cfg.features;
+       fpstate->user_size      = fpu_user_cfg.default_size;
+       fpstate->user_xfeatures = fpu_user_cfg.default_features;
+
        fpstate_init_user(fpstate);
 
        gfpu->fpstate           = fpstate;
@@ -550,21 +543,17 @@ void fpstate_init_user(struct fpstate *fpstate)
                fpstate_init_fstate(fpstate);
 }
 
-static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
-{
-       /* Initialize sizes and feature masks */
-       fpstate->size           = fpu_kernel_cfg.default_size;
-       fpstate->user_size      = fpu_user_cfg.default_size;
-       fpstate->xfeatures      = fpu_kernel_cfg.default_features;
-       fpstate->user_xfeatures = fpu_user_cfg.default_features;
-       fpstate->xfd            = xfd;
-}
-
 void fpstate_reset(struct fpu *fpu)
 {
        /* Set the fpstate pointer to the default fpstate */
        fpu->fpstate = &fpu->__fpstate;
-       __fpstate_reset(fpu->fpstate, init_fpstate.xfd);
+
+       /* Initialize sizes and feature masks */
+       fpu->fpstate->size              = fpu_kernel_cfg.default_size;
+       fpu->fpstate->user_size         = fpu_user_cfg.default_size;
+       fpu->fpstate->xfeatures         = fpu_kernel_cfg.default_features;
+       fpu->fpstate->user_xfeatures    = fpu_user_cfg.default_features;
+       fpu->fpstate->xfd               = init_fpstate.xfd;
 
        /* Initialize the permission related info in fpu */
        fpu->perm.__state_perm          = fpu_kernel_cfg.default_features;

