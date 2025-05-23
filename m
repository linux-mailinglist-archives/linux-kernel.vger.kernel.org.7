Return-Path: <linux-kernel+bounces-660144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C79AC1978
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B537BF347
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7612E336C;
	Fri, 23 May 2025 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQnuiBOm"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C622DFA35
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962100; cv=none; b=eBxgeNMI5VObPEfh3goTeDdgHk4/mPTxnMf/wiQWCWtADou4mu2ZhjMB7Q0UJN4USVlJ2HM7bg28jml7qaZQR/JZVPRWqlUxLnAFBhZrVpkQL+J0EdESpnrbRS8cUmXVHM8+gb6pBygAYFUKg4egvPSWVoVjEyIZE9FXKa6H+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962100; c=relaxed/simple;
	bh=NGIANfuyMzXoKJquKbW+ehrpEIHWV+x021PzJ4EknsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBzt196UQP8OWrdaFxgYaXK9zi8a143KnQXN8Nca9LMZuZ45WyrIiO5+b3vAzqyOsFcTWneyYN9XQ0GTAiXL4n7QBqkp7iM03JsxAGGWdK4ppLQXvVvR87nks90I0Tq38baoUb/KS/ALXOPtOIOxxtZxTtCqRo8tUpP88jNT3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQnuiBOm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394792f83cso6893236b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962098; x=1748566898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ExoOfw9G/N1sSoTRHxtPNhWhn4iA3dUD7FqrwsLiXLk=;
        b=QQnuiBOmRLCBMvJSvBLZ+OwB9aToIf8vUM8eei6KvtRbOTa4rUbo3S/G7ch1tGaqkR
         q7hXtFw3pJPKnT/9qhY8Wuje/m5vuV53N6FhSM6qkcopmYJjrumLnLpbdhlNyIK8AOYz
         luQ824DvDQXnPr09zy4MtmOwwy3BFCLKOuZLXePVZY0WyWY5AhmSvjMJkdCMgmLezJ3i
         kO43LBGzsALU39YgYLk2kk04jIc7pZPxwqhJFcuNXzfpQ7imeMvS4iQV3z7RKeMBZkn+
         ned33u0meiCi8EjrTBsHFeiPIBNBkbdEz2/qQGOjEMg0i9TnmVd1M2OnfqH2QfglOZGm
         yn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962098; x=1748566898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExoOfw9G/N1sSoTRHxtPNhWhn4iA3dUD7FqrwsLiXLk=;
        b=CWHPQQgXJhOlCpuQcp3htldFY44Q9KSKI/HlhypJ50bHPZHeaLIFoamwCde8kjiINv
         jCs+zpdMcLhdr9/X9Fgonrd6LhQyc+BuKeV6qYKne90L4wkIJGEOXntUMz+uOfFIn0iv
         lwM9fZa8/sbTEXHO454hFSZFgk4HUILqsCQvDzwEZmjccr8anveIjYoHCEBJ3Na+BkD3
         fAmO2Ef5SAj61s0aeYlKABQG+3qBnb5sC3+PyIdNiHVWNUnntmyRnDCHs3/j3y4Cz82Z
         1RnJjDULJIRO1iHxBqm35mkKr1KYPNml8ni+rlbSIM2P3b9VAgBXWnKMFG/w2dIPzmRW
         ZvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEt8/AU5Z+U52Kz+qPGfBWZoIHB/9t2QK+ITa4PrZloK+qg6ae4je7XQ/vsr5+SEJQBw4P2h1COaotOLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UqYBtT+knAI3H31iXAvXMCE0C/7lcQtHebCbUfumr1KSKBPV
	paqSaDufjd0LzTKwEMJDWhKVoRy06hIQTTm6leJPfNB2SvoP4A70UEuJ7UTUsyvvK/NH4OJvYxE
	u3P+tbA==
X-Google-Smtp-Source: AGHT+IHRskctku8TAbxqTc5JSLZa7cBf4pJ0pj9pJzlkOC6dQa0UxJjlReXD4jK1iH3OFzYeZWUC+JH7b6A=
X-Received: from pfaq8.prod.google.com ([2002:a05:6a00:a888:b0:742:a83f:bc0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198e:b0:740:91e4:8107
 with SMTP id d2e1a72fcca58-742a963242bmr38441580b3a.0.1747962097793; Thu, 22
 May 2025 18:01:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:57 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-53-seanjc@google.com>
Subject: [PATCH v2 52/59] KVM: VMX: WARN if VT-d Posted IRQs aren't possible
 when starting IRQ bypass
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to "start" IRQ bypass when VT-d Posted IRQs are
disabled, to make it obvious that the logic is a sanity check, and so that
a bug related to nr_possible_bypass_irqs is more like to cause noisy
failures, e.g. so that KVM doesn't silently fail to wake blocking vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5671d59a6b6d..4a6d9a17da23 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -296,7 +296,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
  */
 void vmx_pi_start_bypass(struct kvm *kvm)
 {
-	if (!kvm_arch_has_irq_bypass())
+	if (WARN_ON_ONCE(!vmx_can_use_vtd_pi(kvm)))
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
-- 
2.49.0.1151.ga128411c76-goog


