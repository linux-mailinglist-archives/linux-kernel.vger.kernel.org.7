Return-Path: <linux-kernel+bounces-753513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F04B1840A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19AC1C271AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D226E706;
	Fri,  1 Aug 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShCwZM7W"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A7256C83
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059145; cv=none; b=B6a0KyF6zkc6JHg8Jm+AcwDf4J2vi3TYWZPkuuLUzViX3zYUYBfPDvy/xIbrC1ldHzfYAvpjYZrs8qlq9iwSVw07qIDNiDX6f1SccHI5hOJlUs7Y0CYS/9HEAkFs0jSbjZqAurK+FA9NPfucdO2y5uSrObwtwSNhcBxQtSnCk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059145; c=relaxed/simple;
	bh=U5Or6D3NRoBpN43zLbUnWGUOaGO74yjKtNGaeBv80m4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HCSzmv59r+GEmA0T3ayt0GnHLEG3WswtRtcZClIYnSs/VQssEPZWwKJVjbxaARrszh2sSv5RAtPlBfWIM44D4DaVmiZq461nWygJwxTebhbV7wheTSCnnrmEf8ycaUbOBfRIM0HYU3NmNTs/wV06BG4WmY1sU6Eo/kW9uh7QhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShCwZM7W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f2dd307d4so1050983a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754059142; x=1754663942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/evpTted0KWagPhW0zbnRzfoAFtjQ8q4sV9ifqmLIaE=;
        b=ShCwZM7W1mt+rC/XadZ5nGMXTGEh0HB4LE87txm1cYSR5ioVFAI16V5231VnvEroVC
         37EnqyC9tgDGAq+ONIaw0C8r+t687pIJhpy3pMGeQO1weKMUHVYEKnc0Gr25lPi5irpH
         fEuF2Wdf07vpE7GDkZnGdtEClSe+Kv1M8Cl0tTsbDy3XwlZAM9Cd1aReOX0IhqUq0JMx
         LmKeV7gfz8xY3mv9BX6FrvW8Jdiw/kF9aIV/jxtQGWPoPtxfyB4McL80iYe2Zcq2Eifv
         XbQyIfB1gSexJCSnLWiA32GjLX5+P9uZMgipzLd61uzoUNnfbzaJSsBc479sb7gtIZ4h
         zGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059142; x=1754663942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/evpTted0KWagPhW0zbnRzfoAFtjQ8q4sV9ifqmLIaE=;
        b=Wya7Kvlo3mcGBT+hzvHUqEjA+Egqhr+0c5ZPro9Xr0fxnZwmqfKTiGHYkmU08gj3fC
         C+NAupTM3i3AmpPq2KMi3hP/L3WQw3oUOsNDx8EQCLarWNSJ6bGtwuwz/MAe6kiRWPtK
         izXEYqyvN/RGkajWB5yllRSuEWZptc7EtxW4jz7QTLL5Es36kg41E1glydSYRfWcrmVN
         U5IgMkXrT3cpem47vF0AWH63lpuzezkZNDUKNZYHv5BxdAF4nAwAwhJxBSSgy+yc9uu0
         Ni/mUHwc5gj+snNKqC35Ie+DMO3A7xSzUswz1IbCp17odBSFrPl8fwQXQMscX15Y1dZI
         U/Rg==
X-Gm-Message-State: AOJu0Yyh5fYQb78X5qWJL7+C9I/sd5OwC9jfP0K/f3Haq/7UxIzv7Efh
	Pz97b+ogTjMa1sy3ObQPPlGpbe7Uceq6aRkxMcpi3tM6Ki7ozZgjlmIFaas/v2zm/2a37dHfLSh
	VPBY0gg==
X-Google-Smtp-Source: AGHT+IErf5mFW7eycP7uOftRa6st2gphx5ZI4tv3ZyVlCyQ+Y2NW756Z9s10ZU4KCEqSdtShOoUrIsBP/Ks=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:312:f88d:25f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c04:b0:31a:9004:8d36
 with SMTP id 98e67ed59e1d1-31f5de54abdmr16391258a91.20.1754059141926; Fri, 01
 Aug 2025 07:39:01 -0700 (PDT)
Date: Fri, 1 Aug 2025 07:39:00 -0700
In-Reply-To: <20250730174605.1614792-5-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730174605.1614792-1-xin@zytor.com> <20250730174605.1614792-5-xin@zytor.com>
Message-ID: <aIzRhGVgZXPXNwA1@google.com>
Subject: Re: [PATCH v1 4/4] KVM: x86: Advertise support for the immediate form
 of MSR instructions
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 30, 2025, Xin Li (Intel) wrote:
> Advertise support for the immediate form of MSR instructions to userspace
> if the instructions are supported by the underlying CPU.

SVM needs to explicitly clear the capability so that KVM doesn't over-advertise
support if AMD ever implements X86_FEATURE_MSR_IMM.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ca550c4fa174..7e7821ee8ee1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5311,8 +5311,12 @@ static __init void svm_set_cpu_caps(void)
        /* CPUID 0x8000001F (SME/SEV features) */
        sev_set_cpu_caps();
 
-       /* Don't advertise Bus Lock Detect to guest if SVM support is absent */
+       /*
+        * Clear capabilities that are automatically configured by common code,
+        * but that require explicit SVM support (that isn't yet implemented).
+        */
        kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
+       kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
 }
 
 static __init int svm_hardware_setup(void)

