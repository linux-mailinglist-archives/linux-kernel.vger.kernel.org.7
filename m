Return-Path: <linux-kernel+bounces-823840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B10B878CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC45815D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6CE253954;
	Fri, 19 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXo3+5uU"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D93244686
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243603; cv=none; b=ESJdd9RGCpf8+2/RUZVnApiUMKqdMlEqpweOhShVrfIixBZaQyFaiJ/QWKrgOo1XtmWGhjLp5hiJDo9VptDpgLLnaXLPlCvuNpPl1WS4zRSxurpLEAvVBf8JfK2GAn6h7Cuo2hsB6ES36h5BQYGruxWLvIqD8DMHxSIWIwu72b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243603; c=relaxed/simple;
	bh=KtmjwUQKEDaGma8aD7fkjztjTOgXgTDisEJmE5V5YC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHLnHD9SkRabHxaLWYyqnoLlpdnRLl3nr891yMvMQ5zzpoQzsS3oK7mhR+jlTcWLT1VJX29AZ/g3tf2mlTYUlxMm7rVzlYC0NBGJP+vH9o/8M8bYZCHJzlOgXBJPaR+vzoIUcnFzD7EKzhZSUVk3vWJgD/HztoY3K7MSXCo1jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXo3+5uU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so1518013b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758243601; x=1758848401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UWy3i2fp1q6nRdPbeRuCID8VdI7QyY4h6hWBylbyQSw=;
        b=IXo3+5uUYMbJkGwxfullqYznBYsGxp2pkMJENqwMov6kkdpHc37kAghpKXvCT4BxQ2
         wgG+Y3ZGJ4W3Z+1q38ngQ2J0ZTWN+erqt791Tm2O+J8jAtsOWZFZqZeVoS+lzMnFZoSg
         tTdK5JSzOoCTUigqCVDNL40f4zjtIMgFuzPQsvWazDppGgZA767C8W8O5NaQu6Xaovg/
         QGmIcfSemJqNP4yJPtLituXdmSXv0Nxp4TH1IXWyhaTC3xL+prJwktFubuVEKJCKyvgG
         BZ6TXMeX2r1TK3THhJZZHO/Ahgna1mE3DtTonk0QbRX0fTQdecbxCLynssQDWYixElqo
         S34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243601; x=1758848401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWy3i2fp1q6nRdPbeRuCID8VdI7QyY4h6hWBylbyQSw=;
        b=LFLJf901U7jDVoAmfn013W9rGYkCApyj1cNCt+C7cN9MCnoQuTaOq7TeuVpA1ITP/G
         SQkutBFxp6tjXfTPRBg4jHygiNSnqVbc2IJShuspeJebyLhjocc9LLYWvXDw5CJiB6w1
         LNj0/3n8dLoqThsu/Tr5Hib6cx/hy72J2E7JFL7ReimHMZ8JESN34sYeVgjImOiTXj+g
         4KY8zBTT+y6edENyqGHzvBS2tOm3ao+YDTclMasJoaY44WKiBLEfJ//TDaDJdnpy9Nbg
         uyj9TO0IbebWeR33mTk7xpFdqfzJS4lN4R71geC9jR/wh+aAaYReeXlfbTbXr9wNZl2A
         LpNw==
X-Forwarded-Encrypted: i=1; AJvYcCXqqOxYL9o+VYROJT+X5lgrOnQjmDtQS9quD5+YXh8wb19PzapbdKx+KJUwMCU6nIyoVmYdFHwS52AY0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ms5/55SWj7/8QFF6ZBTaz6Z0qj1zep0maXEzK3pH8omqy9TQ
	/JPHYIOQBzMkAR55xqBULkjPTxJAv2GO3i08qVjZeuA6uk4XE8kvS+EdDDxoIERgbL2JYszGZ9r
	NvpAdfQ==
X-Google-Smtp-Source: AGHT+IFnWENHzvN/NcFf/IxWJBYR1Ml2tRSnK0NlBzCXck73s2Te+54DEYFubEJyD7rnzsffuRVAm7qyw50=
X-Received: from pjbnw4.prod.google.com ([2002:a17:90b:2544:b0:32b:65c6:661a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e082:b0:243:97c7:a013
 with SMTP id adf61e73a8af0-2926e379d27mr1860284637.34.1758243600810; Thu, 18
 Sep 2025 18:00:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:59:48 -0700
In-Reply-To: <20250919005955.1366256-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919005955.1366256-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919005955.1366256-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: nVMX: Hardcode dummy EPTP used for early nested
 consistency checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hardcode the dummy EPTP used for "early" consistency checks as there's no
need to use 5-level EPT based on the guest.MAXPHYADDR (the EPTP just needs
to be valid, it's never truly consumed).

This will allow breaking construct_eptp()'s dependency on having access to
the vCPU, which in turn will (much further in the future) allow for eliding
per-root TLB flushes when a vCPU is migrated between pCPUs (a flush is
need if and only if that particular pCPU hasn't already flushed the vCPU's
roots).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++-----
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.h    | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2156c9a854f4..253e93ced9dc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2278,13 +2278,11 @@ static void prepare_vmcs02_constant_state(struct vcpu_vmx *vmx)
 	vmx->nested.vmcs02_initialized = true;
 
 	/*
-	 * We don't care what the EPTP value is we just need to guarantee
-	 * it's valid so we don't get a false positive when doing early
-	 * consistency checks.
+	 * If early consistency checks are enabled, stuff the EPT Pointer with
+	 * a dummy *legal* value to avoid false positives on bad control state.
 	 */
 	if (enable_ept && nested_early_check)
-		vmcs_write64(EPT_POINTER,
-			     construct_eptp(&vmx->vcpu, 0, PT64_ROOT_4LEVEL));
+		vmcs_write64(EPT_POINTER, VMX_EPTP_MT_WB | VMX_EPTP_PWL_4);
 
 	if (vmx->ve_info)
 		vmcs_write64(VE_INFORMATION_ADDRESS, __pa(vmx->ve_info));
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3c622c91cbc5..74dba9f1d098 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3201,7 +3201,7 @@ static inline int vmx_get_current_vpid(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->vpid;
 }
 
-u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
+static u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
 {
 	u64 eptp = VMX_EPTP_MT_WB;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 23d6e89b96f2..e912a82a1d14 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -366,7 +366,6 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
 void ept_save_pdptrs(struct kvm_vcpu *vcpu);
 void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
-u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 
 bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-- 
2.51.0.470.ga7dc726c21-goog


