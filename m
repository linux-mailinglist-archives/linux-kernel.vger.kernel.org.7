Return-Path: <linux-kernel+bounces-814898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0236B55A30
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107AC1899B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418FA2DEA8F;
	Fri, 12 Sep 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjZPEKI2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18A288CA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719457; cv=none; b=iyH884I/IT1vMr2H7zOTcjPfyLBzrqC0FQC8BFVCv5JprGkKDbGC21mt5ELmVGz+bjBDBYNSzqqe+8dP91J4GwImSVLQIYUYeCikZDIRwMjADvjSPlEPMMkG3In4rWyMZpe6vYa8in6wEhrhJzPsqlMkgt9kC39IRo6bUrWPdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719457; c=relaxed/simple;
	bh=fBM++utOUJHtYvpSjDE2iy0S74USVtNMtgRTB+NUul4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofE5AtMoEUEh47xeQb5IYJzjkJ2eBv+4ToyMUjfO8lepnNzQVeE8RwRdI7UP/ME9NJUi6QCzZIq6jmzcEbQdOWQhcaBCkkE0wsYGUHMzgMGpXYxaibQu7aDSNmmvZrGy+4FlOX8HguPNDjxAejMTSZENGJCncZ1hkKwj4P3qAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjZPEKI2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dd9854282so3680776a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719454; x=1758324254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xwixwi/pq7WJn2ZqYO6o3aXpIOBO0K9ZG0HFJymmGLE=;
        b=zjZPEKI2372tcAxov6mMsu5K+ENONtNKBkDbA8cNk4NOfsYU7EB93J9gm9XHAksUfU
         pvKH/gTQQhBCfHfqHF8MqWEps8l32ULSgxuOH6UGaEbJqaoqUehXNDHGupHpNCFlKjCu
         sZqQfER0TjuFgMOdMm7FBagYDo/lCmA5JsOqQjd0x2hcTbbvj4XDm8PkfDNdOTHekB3u
         QTtklgeiIxQNc9+daV+wGK2vxltIp6zD4BjenBBFyB1b6bO/AaX609CPdiouixXr2B1A
         IMcKW5aHxiEK/17y+/UzqqZ/hpgP1m3zctIsvN1/p1WaSkaxXJhno4xlAYd13RqRMqQ7
         7AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719454; x=1758324254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwixwi/pq7WJn2ZqYO6o3aXpIOBO0K9ZG0HFJymmGLE=;
        b=pzjFZGohIJgGaYTn+xBI6Nxmvyu3IBTGzUSckLhwCCCNnJgcNXuA1WeagaXfuBOsqv
         1BjBFO7FKd+5/bhLndFDsI59XPdhvaWqJ3n7+iL1puKHv14XX6vRvrpSy3qyKxMqPFlL
         481YsBHn0f3Ns/8cO2YuDP+34ZqR8+S86e/x0y2RVTNKJiFsArHXw0nyd2u2ih5aY3pm
         MtuobXuxPQ5RfaXXaLPQtytQCeIZ4z8Fc7FY7xOhp/AYjcK/NLv0YvRNclCaJnwp+VTt
         IbUzGNwKHJJ1kjuBaO+2PwKcvGH2NmjLMOZpnj8yo4WZgFkI3WLj3p9jlJmdGWazRwHS
         C/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcyqxCko7bpwuhrveJ1zlPxY+C2yqKk3e7yI9nUm3s10djCBu9E+P6BT9T/3AF/iq68Kxmj5D/zm3ObQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrtPuFOhcImq155zNQ5r53lc401yMQFOhP38N8Zb7RrXIR/UB
	9AkLTw2rbxF6kC/jgK4pDdkdtk4tGOoFVqTRYU6NS6mqABNVub0gl4ScwTxYFj9wbDT3mzMQ29k
	zkQX0Zw==
X-Google-Smtp-Source: AGHT+IEwe2z/CoghXdq5pw1tWeWTUfTaSNa0gKl/TqYG+LRtVUmBsUYMFAiW+9zgOymlGloFYvugvYSX/9k=
X-Received: from plnd12.prod.google.com ([2002:a17:903:198c:b0:24c:cd65:485c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebd2:b0:25e:37ed:d15d
 with SMTP id d9443c01a7336-25e37edd357mr33268295ad.0.1757719454481; Fri, 12
 Sep 2025 16:24:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:05 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-28-seanjc@google.com>
Subject: [PATCH v15 27/41] KVM: x86: SVM: Update dump_vmcb with shadow stack
 save area additions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: John Allen <john.allen@amd.com>

Add shadow stack VMCB fields to dump_vmcb. PL0_SSP, PL1_SSP, PL2_SSP,
PL3_SSP, and U_CET are part of the SEV-ES save area and are encrypted,
but can be decrypted and dumped if the guest policy allows debugging.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0c0115b52e5c..c0a16481b9c3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3410,6 +3410,10 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "rip:", save->rip, "rflags:", save->rflags);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "rsp:", save->rsp, "rax:", save->rax);
+	pr_err("%-15s %016llx %-13s %016llx\n",
+	       "s_cet:", save->s_cet, "ssp:", save->ssp);
+	pr_err("%-15s %016llx\n",
+	       "isst_addr:", save->isst_addr);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "star:", save01->star, "lstar:", save01->lstar);
 	pr_err("%-15s %016llx %-13s %016llx\n",
@@ -3434,6 +3438,13 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		pr_err("%-15s %016llx\n",
 		       "sev_features", vmsa->sev_features);
 
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "pl0_ssp:", vmsa->pl0_ssp, "pl1_ssp:", vmsa->pl1_ssp);
+		pr_err("%-15s %016llx %-13s %016llx\n",
+		       "pl2_ssp:", vmsa->pl2_ssp, "pl3_ssp:", vmsa->pl3_ssp);
+		pr_err("%-15s %016llx\n",
+		       "u_cet:", vmsa->u_cet);
+
 		pr_err("%-15s %016llx %-13s %016llx\n",
 		       "rax:", vmsa->rax, "rbx:", vmsa->rbx);
 		pr_err("%-15s %016llx %-13s %016llx\n",
-- 
2.51.0.384.g4c02a37b29-goog


