Return-Path: <linux-kernel+bounces-825233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E07B8B5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C171C81F74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F92D3745;
	Fri, 19 Sep 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UowpauNc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901B1EF36E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317890; cv=none; b=RigcUr46DlXZGC+tOCRfUE1Ha4H29RX5wePhAB/baYLPYLaLkG6xrrXyqrgPGBa7h0fvHwUa3OGyQch8QGURzvE/Av51j+3XSEmICePqFGvXzzlTuJG00zrFya56q7CooNjBz1M8Kxsx0zt2LdLcqXHwwcT6ApBR0FxMy/brwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317890; c=relaxed/simple;
	bh=ybuee/CP+3Nt4h2RFjOT+11CdhkSUVkIl5rA6kLLIds=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qQtxkMvOKeV+Uu/4wOKX2BW1zT3+0J6j3M/7BWVLKFPHQh4eV1jQ8aCM7Qum25wKdXo/NovbsNIDLTTfxUO9Ve0316u8e42SSzzgcsuTLn1lE7yiedtHZ8WtMEYxyqG3toDbJ3lmgA2nsCNIFtRZeUPpqtZ7Wqr2pFT+SEuUCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UowpauNc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so2589755a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758317888; x=1758922688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKdm3Xfs0ylrgXhnYW7dHs94H/PnNzvnxwBxGG6khr8=;
        b=UowpauNcyPTWPlNDVFF/gi4qEH85CksgIJsl4i4wvzLorlqcrj3ClHw78z1wcyJMjS
         U3ieUOE4kasNThXIc8NHn7v9xz8FVIjUSFZZcbfDsAFqu7Y7Gf6aZV6ijppOIOKmBJ9m
         2h9QnVn2M7oHoq33wQ9A3Eg7CKKX5UaEW5sy6PabXP3Av8KOoDBi7kikMM+NnFlZXpVQ
         qVNiY6KA00MJ3K70rf+dA8EcP95mzbmQW0jjpWHqe1KZ3RotK4Nys+/9vkTjUGQKQ9si
         /RJIWrG0SXFFJIZuy3z3xhBFMcw3Z517xV02hqhQyh/7Yjmt7c4KFpBhohh4nKxRodjS
         3/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758317888; x=1758922688;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKdm3Xfs0ylrgXhnYW7dHs94H/PnNzvnxwBxGG6khr8=;
        b=InY/3Hu5T32tsjdGQsdSgf2ZBpIIr64OEa71PmWhJacVm39ZejDGzb742sfJe9o7cp
         mHIXpXwrpjZNe3nmmEoM6v+4warpvh567tlLmDUWojziFMQMrwZHsouwpc9f2OtW1bel
         ntDgvFYIx+l4BPcz0sLKPZ0Bmu+dK8ZDaWvcpokS7YIwCK+y8Hu/JHbwZPT5Ob1ECIUE
         H58FgZ+n0JtlKS7c2Dkc5zAvvCRmZKAgB3prfnDq0NrHIol/G+IabI6x53Evqa+eXkq5
         ubmJAcqIuW6ZtJ0qLHGmPIVOsYZNA/YW4BH4nQgm2UrGRDZijt/ZnAJWq0gzgJ+N9/OO
         lRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3LDATm6bXZFYvUih0iB6Y29evmP8PlXnTv8i6dU3Edu0WC0bvP9A9bws5sLbQ8utXLz/cBdcJVe5l/ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sw5iQGmWDPAWcAX8Ttj5XBq+zwPdjdS3HMm7X7aIZZzXBPgJ
	69zDzV7V9+w9p8o1tylw7OhdzJ6/UHVGc/csy65wZaHm+dvHfoQQZEXCVBtSRmZp6TpmgfrDsFu
	6sM/N5A==
X-Google-Smtp-Source: AGHT+IHdw5gzWTwCMexEJ/dleQ8GOPJny2l/qK7IrByLrSy2Hz4TbX3exiExZKAkCKRcDH5LA0g2eAFCMQc=
X-Received: from pjtd17.prod.google.com ([2002:a17:90b:51:b0:330:6d77:9a83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5109:b0:32e:96b1:fb80
 with SMTP id 98e67ed59e1d1-33097fe9687mr5567412a91.11.1758317888145; Fri, 19
 Sep 2025 14:38:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:38:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919213806.1582673-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: SVM: Fix a bug where TSC_AUX can get clobbered
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

v2 of Hou's series to fix a bug where an SEV-ES vCPU running on the same
pCPU as a non-SEV-ES vCPU could clobber TSC_AUX due to loading the host's
TSC_AUX on #VMEXIT, as opposed to restoring whatever was in hardware at the
time of VMRUN.

I tried to test this by hacking sev_smoke_test, but unfortunately I don't
have a machine that has SEV-ES *and* TSC_AUX virtualization.  *sigh*

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 77256c89bb8d..73530a01a3b5 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -16,6 +16,12 @@
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
+static uint64_t guest_sev_es_get_info(void)
+{
+       wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+       return rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
 static void guest_snp_code(void)
 {
        uint64_t sev_msr = rdmsr(MSR_AMD64_SEV);
@@ -34,6 +40,10 @@ static void guest_sev_es_code(void)
        GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
        GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
 
+       wrmsr(MSR_TSC_AUX, 0x12345678);
+       guest_sev_es_get_info();
+       GUEST_ASSERT(rdmsr(MSR_TSC_AUX) == 0x12345678);
+
        /*
         * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
         * force "termination" to signal "done" via the GHCB MSR protocol.

v2:
 - Drop "cache" from the user_return API.
 - Handle the SEV-ES case in SEV-ES code.
 - Tag everything for stable@.
 - Massage changelog to avoid talking about the host's value and instead
   focus on failing to restore what KVM thinks is in hardware.

v1: https://lore.kernel.org/all/05a018a6997407080b3b7921ba692aa69a720f07.1758166596.git.houwenlong.hwl@antgroup.com

Hou Wenlong (2):
  KVM: x86: Add helper to retrieve current value of user return MSR
  KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES
    guest

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm/sev.c          | 14 +++++++++++++-
 arch/x86/kvm/svm/svm.c          | 26 +++++++-------------------
 arch/x86/kvm/svm/svm.h          |  4 +++-
 arch/x86/kvm/x86.c              |  6 ++++++
 5 files changed, 30 insertions(+), 21 deletions(-)


base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 
2.51.0.470.ga7dc726c21-goog


