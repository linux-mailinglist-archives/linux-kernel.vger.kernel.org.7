Return-Path: <linux-kernel+bounces-660106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D754AC1929
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7D93A7A19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80E253931;
	Fri, 23 May 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="up1wemXs"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAF22B598
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962036; cv=none; b=jtpeERRVI+fc7WCo2QAaAbEECM7zuKNlBicQAZuGys0Trzb2bJ6dq9xidkY4jiYUYNXXUEzUq7CNbJiPsV/kBvlI5f/p51nXRm9q8OMuiczORSmhQ8ACvyfEVSQwoY88Hxw4KTsde0+YqKR6Ysqju9Wr5EuHcUFgY6xL4YFlQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962036; c=relaxed/simple;
	bh=dlp1owjlTB9Q2ZNdky6CeTiZTUsuxD6LWgF2OyRxR9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eySCka+/AmtmL/stmp4pr1yX6ciEULSxQbpAy1NjQneCo2TMjwlhhpTQurGc6lzDuOsLuwjV2KEZBrJznpMd+qg2ba/BdLid71mn+i8qotWlfsohhbM5e2K8qfttFH63fTAYUpLuXzZ6lDhUEzPNH1wYUob5YcEea4C4BqLzjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=up1wemXs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e8346b49cso7253355a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962035; x=1748566835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8hYW+M1uoR4gCkeYUzndz4aHuf/uvwQq+NXGlsnTPHE=;
        b=up1wemXssdVa41ki89XeT1Y+EkDpINGXeUNpQh/0fNDYt1Aoy2F4cE+ECOEWpRX2aN
         eqcfJelZyTGeQDmECmfkE4ne6/fYAnJ36ql9NMtbPenxaEpiTaMWmDfZsigNM1qBFIyo
         5cNZmQXEkNNYd3lOZMLmDR3hkto3y44U0ngqOjDIywrDwuYqZlRcaAIvP1gpAPGjidgE
         TMoghop0gOLOcRBsXuOvXZnwMHWdi7CTKcjFc75PNL2aO6FBBdrLRTwGnDeN9cvTqoM+
         XhizYwCh9SmVaUNthb7N68OibPb82Em5wTPCWbzETb+BnwafFLkPX9FXHt4XJFl54CkX
         DskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962035; x=1748566835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hYW+M1uoR4gCkeYUzndz4aHuf/uvwQq+NXGlsnTPHE=;
        b=AOCbDZK22kedIHE+c4EN3g/VWL4GBKuXVLkuympS+vCfIPSyG0Xz0mhMfY/iws+qab
         +ojWvCGnaNjBl9DG3VRlTtc6WmnUlCoYJccQytCwlEUatSvfp+smHYixF+DjXFk/IT1g
         SwTV9nRybASwEIDSqTigza9HI4+2UHks9c3JgGBbtZHDdEYfIjFE518fRczrqMOtkpLx
         vG66UYTq4yotO1Psy8li5Dy46ESg8HzA9UiLyH2XJcD7LJ62kwo36LGgIoHKlnKDtMD3
         2kOWfoUfFRgVRdRQSIiGArfddUr0Uj0Er0G83iTpbajXUkIWuHpcOVvVUvGDtitVfO4j
         e74w==
X-Forwarded-Encrypted: i=1; AJvYcCUaYw/pHZx6t27bvPv1sMUbLE14KvsgLoNH+sYcIFvIGM9tiz9w3Hz0X6wZ2Pu/51REeBhhYDeMFDLzLWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEiuDdGHDki0ASQWkUp54tCwmvI2Qs+4f3dPLBFddIPmqcIxU
	vi3+8ZxOTWtq5w4ooGPEu/Ib15Ix07eVK621HIjwRpWyod5uuWqSl/bXzbDU+p7Iw78KLXWA4wf
	kuxvC5Q==
X-Google-Smtp-Source: AGHT+IERiQoZPoEemihmVi9aR21C5+4ZWBIzokk0EnGUgkUK/kwxgXf2E6CpkLPTP/gednSgPST54I+bLEA=
X-Received: from pji7.prod.google.com ([2002:a17:90b:3fc7:b0:2fa:a30a:3382])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:a015:b0:30e:ae5:479d
 with SMTP id 98e67ed59e1d1-30e83216f63mr30402479a91.27.1747962034725; Thu, 22
 May 2025 18:00:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:19 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-15-seanjc@google.com>
Subject: [PATCH v2 14/59] KVM: VMX: Move enable_ipiv knob to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move enable_ipiv to common x86 so that it can be reused by SVM to control
IPI virtualization when AVIC is enabled.  SVM doesn't actually provide a
way to truly disable IPI virtualization, but KVM can get close enough by
skipping the necessary table programming.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/capabilities.h | 1 -
 arch/x86/kvm/vmx/vmx.c          | 2 --
 arch/x86/kvm/x86.c              | 3 +++
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a9b709db7c59..cba82d7a701d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1950,6 +1950,7 @@ struct kvm_arch_async_pf {
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
+extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index cb6588238f46..5316c27f6099 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -15,7 +15,6 @@ extern bool __read_mostly enable_ept;
 extern bool __read_mostly enable_unrestricted_guest;
 extern bool __read_mostly enable_ept_ad_bits;
 extern bool __read_mostly enable_pml;
-extern bool __read_mostly enable_ipiv;
 extern int __read_mostly pt_mode;
 
 #define PT_MODE_SYSTEM		0
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9ff00ae9f05a..f79604bc0127 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -112,8 +112,6 @@ static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
 module_param(enable_apicv, bool, 0444);
-
-bool __read_mostly enable_ipiv = true;
 module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8a4662bc2521..b645ccda0999 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -226,6 +226,9 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
+bool __read_mostly enable_ipiv = true;
+EXPORT_SYMBOL_GPL(enable_ipiv);
+
 bool __read_mostly enable_device_posted_irqs = true;
 EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
 
-- 
2.49.0.1151.ga128411c76-goog


