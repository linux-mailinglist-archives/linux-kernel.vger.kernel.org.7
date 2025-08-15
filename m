Return-Path: <linux-kernel+bounces-769843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5FB27457
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097FC1CC013E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E01C860E;
	Fri, 15 Aug 2025 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqPGhqsz"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914B19D087
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219457; cv=none; b=nnSuE+H0042kS5ozAca7mK5rGfXpkJVqxwnFQBXS6MHH88bEtXfU5EidoyjB2apfz2vXA91sW4uarsmbRe8dDeFYEpCkK1XjbtsSvq/VGc2uuCDJoQvsZgwTWxezsdOtFXOrTEdkWgH+GjON+KxEhR+CQ9UjSAKSbONjOWSoMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219457; c=relaxed/simple;
	bh=TXJ2X85YFocPqa+0zEr21K2R3q6PmeINWu5+zoL0tCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uf7kAktFrqOa/Tj7/+fDSA1sIbIIwwWm/wyDcMzvhtGiRmRHqeSq7LREXHmJ6UIp19YprU+nnYF+xH5h/7LexwMakBJCJnSTBuVtsJKfAt5ORVlbvZoseVzIqIZMd7Z+jmQm15ocdSFqkbpKKOPe/89c0ezKp0kJZryHQW3bD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqPGhqsz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eac9faaso1290458b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219454; x=1755824254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IsZpbkhX5MqnYq0KyZ5GB4Mk6gnPhn07/9u1mPEC7EI=;
        b=vqPGhqszToW6NtcggnZokyjuSJQca/JdYn4DMsyRQvwZDJbZ4KUgOa4uNHh9/FAEyE
         WZFTkSUxT8s8nv17L54bHm2bIiv1BZvLKNTvPYHu20LudehH1iGFjXXc/s0SO3j6x1nn
         C/fWTy6sLkDK5VYWHTA8ybkgSczES8EitdLx5tS6jklDDVQOCPg8xq5goKVbIkLfoGuI
         HHZ4/Wz2dNjM3nsu02+jj+Hckuyxyutet5GxwN77YKsBNDaI0wltNqKwBUiUJxn1mqB5
         8+4sqCV3azDNllRHgdNXAix8gY9ZOLeP60tKZiiIkPZ/Uk8/Tn9Hg874TdLxl0zcogwF
         9nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219454; x=1755824254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsZpbkhX5MqnYq0KyZ5GB4Mk6gnPhn07/9u1mPEC7EI=;
        b=RhDPi+OzQ4rvHFO0R5APQ+oPL6LwUY3Q7tpO/PGBGcuqi2/4YRxhk83Ytl62PSPn0e
         hLvkabaLZE20wgef6BHdy468wbPLUYH6rLz7sO+wE2w2HAoOPWDD6Tmar23IR5A2MiMl
         U0yhBN06WT5EuPybfNTA6t6pRt36+2tkH+tMcd9P+RFphDz2sZ+fP0LZIqE212Mw6DYb
         /RQZayrzdmA1JRj0tR3sgfzdTlALw+LOn/EZOp/5H2Bd5/XVld1Huo3LZ3+XQYGHDFno
         mxsbbdqqxXexEsHb75DOF8U/TIVy0SMH/jsdCvSwHq4x36Uto4JU/sAXvwcnAwxvvAF/
         okcg==
X-Forwarded-Encrypted: i=1; AJvYcCUPmQCL7CXrqEv1w+U3S/lArsDALJ6+KqDX2SlGPCyb5CpOwD8sokEWrP/Sa+iwmJeOZGh3CEb1VRbrzwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4X6lq7ZyKYDVAuVxQwfwKi71so8fcLGUSI0M7cswZZtq2Zpr
	VPWDv1YqDV6qW2GXM8qQAHNS+965e27kcjV+gRdURbzeqxmiMe/7CP9Dim8p+IuUsPmf0iPBaUu
	uvlPs2g==
X-Google-Smtp-Source: AGHT+IH+or5YDIHHNrmIsvXJ1577coTnf6xAqbqWIbdl/OyYWkW8UyDl0dwXFEHdZ0O1Uralx54l0daxwQY=
X-Received: from pgbee14.prod.google.com ([2002:a05:6a02:458e:b0:b42:c74:a4c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:42a3:b0:206:a9bd:a3a3
 with SMTP id adf61e73a8af0-240d2fbf950mr418739637.24.1755219454202; Thu, 14
 Aug 2025 17:57:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:21 -0700
In-Reply-To: <20250815005725.2386187-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815005725.2386187-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-4-seanjc@google.com>
Subject: [PATCH 6.12.y 3/7] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if
 RTM is supported
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 ]

Let the guest set DEBUGCTL.RTM_DEBUG if RTM is supported according to the
guest CPUID model, as debug support is supposed to be available if RTM is
supported, and there are no known downsides to letting the guest debug RTM
aborts.

Note, there are no known bug reports related to RTM_DEBUG, the primary
motivation is to reduce the probability of breaking existing guests when a
future change adds a missing consistency check on vmcs12.GUEST_DEBUGCTL
(KVM currently lets L2 run with whatever hardware supports; whoops).

Note #2, KVM already emulates DR6.RTM, and doesn't restrict access to
DR7.RTM.

Fixes: 83c529151ab0 ("KVM: x86: expose Intel cpu new features (HLE, RTM) to guest")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-5-seanjc@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/vmx/vmx.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 7ebe76f69417..2b6e3127ef4e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -417,6 +417,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9c7940feac6..529a10bba056 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2185,6 +2185,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


