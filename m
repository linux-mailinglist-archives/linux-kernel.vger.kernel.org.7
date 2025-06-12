Return-Path: <linux-kernel+bounces-682646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99046AD62FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4FF1898F41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB67257AF9;
	Wed, 11 Jun 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkNOWWkF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43004253923
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682019; cv=none; b=lh67i6DBdxZwaCSvxS7nFrn17rdnBsaZ7IdOSDy2L50ycGmBQVFivz9LAbXxmjXD+McaE8jon4GYLxMipiBeqoMLunmPa1yY3yQctaxxU5++Z81ssCf0/0WFsXSJKWfRn0ktMTBfjkfTWOvi/YfZT2uLjA3aAs5G9KYT1Lu+tM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682019; c=relaxed/simple;
	bh=982YzkJSuPJzcUJ59rC3v9vip8VboXzMkqDEQ2GpPws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JxJJzXkJZuIsizb13nBFx2/GHpSwpbo9hLsGJUY5uwYkhnUYOskyCNucZs9JucCJP6h28th8rLGWow9P6rq3D+7MCht54mFn92JkTVGEufegdQrYzfgHfvRZW7PLVBZL/mbKqA2R4/Z0AmhlPljowuVepjJmti6aRgEAbDBrzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkNOWWkF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e671316so213675a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682017; x=1750286817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xCMHUlDguheMk1DR0iSlAWm0OxNkDe+tjgoSc4700VQ=;
        b=WkNOWWkFpMLWKe6HNpycC2f2iF34FfKErlaU8Choku5q5eqM1Vy1M6clWQOz9/K7aZ
         5nWUm00+kObSGVOm21fPjEIJWY+1vrvEUdFmf1fHeHe6QNw2Xh92yWHWpULOV1aEWLsL
         pk0Ze/kh5Sft0yXeFmiQJMez89c2k1izUgTdRZnVkPx5ADBcigFQUMCURh/TK7/MiKdH
         WiVLnZMuIOC0+xsvBj766agFZAYeReK9AVyCezTsvZ5IwNBFZ2A5YO5hMGLqGKNCsGo8
         OiyXhQklXFmwKuBMYSLYSiTZHkbbilfRTxXbb/++goOMO+xZoHiingcjpRlFckuezeom
         y4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682017; x=1750286817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCMHUlDguheMk1DR0iSlAWm0OxNkDe+tjgoSc4700VQ=;
        b=wnm8TE1Kq+VZ4tPDCtKA4c/y5Vpgf+4N9u5cVMqQTWvlj1ob0VA5rV7PdgFFpYjtBZ
         ameFOwdlIEo7YFztvu+CkgKa7wCeR4DvkZEyc765X3y+kRfilPdpAsPJogNkyPFRZ/+v
         gFGp3F/Cn/Yi6P0DU/bx08e0W1xpOEPNBB4zUPwTwVAQDXqP0ZziVT2JVVp4Efd2c2o4
         KVsfEAZ8pqYPyj+c7ElDDWGFRvvsm7G2Tyadmwim5xxwFAHPM2O+WAlD4isl56FnRKTk
         6dqxJhuup0vPcdAR4pdGv7etPmooBMN8dFLDKtaSUbMRv8jc+xmmn6Q9Yr7e+coBNgqz
         4ZnA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGDP8uuFhcB//XXpkI2EQTd+0ycLOH6V9qcyDguYp2H/6bNx21Gem2ya9y2RDMwz40PqKpS6wrpSjEn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KHLhxUFg+czCu71Z50ydLwULqzjxPUbWRtfbKY3bQF8AXN1L
	h7lzZTNseFSwjqidhIB+ZkPThedBPC9w8rszG8w6R0DTfgSH1bHE4IkLn3R6Ycpo2L44XyFLx+F
	8+iEvgw==
X-Google-Smtp-Source: AGHT+IF9lRdjIaJMGffmVpoig7dkM1EZi9TG7goqvwtOE+A6AKDHS0ehZiZ8FiJ1CPYjTylPsun8hRe7S+Y=
X-Received: from pjbpv3.prod.google.com ([2002:a17:90b:3c83:b0:2fe:800f:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d406:b0:2fa:1e56:5d82
 with SMTP id 98e67ed59e1d1-313bfdcc12emr1459552a91.17.1749682017517; Wed, 11
 Jun 2025 15:46:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:04 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-3-seanjc@google.com>
Subject: [PATCH v3 01/62] KVM: arm64: Explicitly treat routing entry type
 changes as changes
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly treat type differences as GSI routing changes, as comparing MSI
data between two entries could get a false negative, e.g. if userspace
changed the type but left the type-specific data as-

Note, the same bug was fixed in x86 by commit bcda70c56f3e ("KVM: x86:
Explicitly treat routing entry type changes as changes").

Fixes: 4bf3693d36af ("KVM: arm64: Unmap vLPIs affected by changes to GSI routing information")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index de2b4e9c9f9f..38a91bb5d4c7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2764,7 +2764,8 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
 				  struct kvm_kernel_irq_routing_entry *new)
 {
-	if (new->type != KVM_IRQ_ROUTING_MSI)
+	if (old->type != KVM_IRQ_ROUTING_MSI ||
+	    new->type != KVM_IRQ_ROUTING_MSI)
 		return true;
 
 	return memcmp(&old->msi, &new->msi, sizeof(new->msi));
-- 
2.50.0.rc1.591.g9c95f17f64-goog


