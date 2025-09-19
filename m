Return-Path: <linux-kernel+bounces-825282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE2B8B7D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D427165A19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050682E6127;
	Fri, 19 Sep 2025 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CdpEbhi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C2D2E2DC1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321204; cv=none; b=dKEevfHaPlUTOnoFLEKRu33D3YKAsAo0Dyqej3tYSqdCRREwHKIhDyxJbJzKeg0tH4/r4aOWgJiDfKENfuJIZ4leY68rJVf8SpH3Ux7+nmPhP7nxb6tQEaD2mXQXvlj41fINDkryZtCGVvnx2dQv5wzA1/jj5A6yo21X08hHcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321204; c=relaxed/simple;
	bh=XDTQ3tmfi6PZrBtBwIXn39EFZb7wdac6Jspf4/pSmcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rOipXQQGdZMhn7I7hCpdsVY3fCRGJqErsl2eeKCFtBZMkdrZILNEqLBtb8s0ErGXX9M8/b5IMGbckJBWvhjqY361eYJSDheIicN1n9JMIwsW2wqUsDtq1C75PhXeFziSEFBNLu0jcfcUmBr9lcdixuBqbnW8ElnXo/HyXCd/dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CdpEbhi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2665df2e24aso46236125ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321202; x=1758926002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vK7f/VGUWllVW7AxxNHDM2H0xPEmsYVTGx9qq6v/NuQ=;
        b=1CdpEbhiHsg9OTTHfstT6+UN5y9TLvg1ijYKBgZ6nV61eQVLxWAOf/sr+00+TfCEZi
         tjFY/GPtjUHU+48xAxzkICRE9xthzCuu58MprnBnbgEgHUYywExRJg2XtMquL3xj0T0k
         EPXeyK6kbSITJzk8oaXWJ+BSZQTPXe62B+ficmHFvmTBcpQ3HkVNiAHxGui2eCnOmOqO
         ABHJ+18Fv8m9DP9Ph/PCBaosE2YA7wl9qXtCtmuqvK2fTc/65zianMyKhDAbPyl0cQ/l
         EwqN2EZWi91Rnf+fenrNJ51MyhpfMUbtpuNcGp+HtRE/oWacYxSIGqPguZV2BQaXuTKB
         eiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321202; x=1758926002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK7f/VGUWllVW7AxxNHDM2H0xPEmsYVTGx9qq6v/NuQ=;
        b=j/8zzqOuKDK97eEmXXhYqahNlQBN5KOONDB3ApBn2CS3qixK6+tOauBJM41+obidd5
         yNR9ojgEn0U1AdpYzcfWlFk7XMgzSgjulKQGbA61XWaQXAqbJO+huaW8t0lpm0FSeyK5
         Skqr+4txa/np8tl+SznQXRghCz3nKhevPJ+4co7ImCWNZg10bb85pHgkFq3s0hMi8xLz
         LHomx2FIG+wOoS8Dpq/cinslgrotqGQmHDyGz2Kt/399mGNZBgXTHFRECK30MAWTvT7i
         5xIDrDeJEZTnWg3nIaOVl7gkNhaVTAlD7KtDbto7fjdLdvJABLEZUmjtXbsrInISejaP
         NeMw==
X-Forwarded-Encrypted: i=1; AJvYcCWdn9zY339iEGfNA9RcQW9WoMNrS8yJWeunDanGa05k+VT/ATKDoUMAtOrqmXIT0K0TccUH1UZ8bNazep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqsqXW5KBNspHCjyoFJk9fGj4QDl7epZVIIX52dGCshzlEYz8O
	BnPf5twWSoiJroD1XeI9+pB+BV8hywG9b8v0jNukiTC4dxN3HXW/sIa8Bz7qN8i1726A2clgfXb
	gPI6MKA==
X-Google-Smtp-Source: AGHT+IEhLi+5mQCpDa2G+QupkEqfe8Hp43V+hOTG8T+hU1K21FndSGDLtWyQBh5uTqjUPG6FYD52vqx9Sh8=
X-Received: from plcz20.prod.google.com ([2002:a17:903:4094:b0:24c:cd65:485c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:269:6c70:ee2
 with SMTP id d9443c01a7336-269ba5455b6mr73260355ad.52.1758321201946; Fri, 19
 Sep 2025 15:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:18 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-12-seanjc@google.com>
Subject: [PATCH v16 11/51] KVM: x86: Report KVM supported CET MSRs as to-be-saved
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Add CET MSRs to the list of MSRs reported to userspace if the feature,
i.e. IBT or SHSTK, associated with the MSRs is supported by KVM.

Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d748b1ce1e81..5245b21168cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -344,6 +344,10 @@ static const u32 msrs_to_save_base[] = {
 	MSR_IA32_UMWAIT_CONTROL,
 
 	MSR_IA32_XFD, MSR_IA32_XFD_ERR, MSR_IA32_XSS,
+
+	MSR_IA32_U_CET, MSR_IA32_S_CET,
+	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
+	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
 };
 
 static const u32 msrs_to_save_pmu[] = {
@@ -7603,6 +7607,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_caps.supported_xss)
 			return;
 		break;
+	case MSR_IA32_U_CET:
+	case MSR_IA32_S_CET:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
+		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+			return;
+		break;
+	case MSR_IA32_INT_SSP_TAB:
+		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
+			return;
+		fallthrough;
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.51.0.470.ga7dc726c21-goog


