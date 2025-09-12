Return-Path: <linux-kernel+bounces-814881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A1B55A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6A73B6C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC92D46CC;
	Fri, 12 Sep 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6Ba/LOh"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFA2D24A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719426; cv=none; b=IaHNeTmf/4ttZcd/JHfZ2f2ZpT5fhdKFshvE+Uz8MrxTFa/LnOoOQ6n4HhtS7lGFOW5+6TxxLUmigDv8tQ9eBuezDq9NhQMs+VilL775THO/DnPgmgTHevoTWHxqZ9ENcdH84rLK2rZ74+XtsUmYFd7qQ+J5InzHkaZfio6gjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719426; c=relaxed/simple;
	bh=e1JeRGkKaj9TgfxxMHwrDucQg8WoISztqz9SDCyYcKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLjl1/CRUM7PVpoJSH6PCFAg195gEZLEL8oaxdqRRGUFfMm6VLpb9eZvPGfc/qJnGoW5uMZPOTe35iHv5sdA9fzOjvxuXPSob1ag8Mh4NfmC/bJG1vBJ1YcVaUq8qaf3Lzr3wrhrCSl8RL/qZyoOmXR+vk6iY5rDZvQRKyJiR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6Ba/LOh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b549a25ade1so3172775a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719424; x=1758324224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4hD6RqHRhoBQyAEPebACVdMiw3nYWEKr1GVCYwgXxlE=;
        b=F6Ba/LOhxXFIE45TEJx6ZNROg5MTzlBb9wKdwfnMHgvikaykMxC2WsD8LF5Ex9HBfJ
         w/idEuUTlyCmI0rKaT4ojXpJUbFxRGFrskXBH+LgOBAbcFGIN01SBKFpnyw1ZjWfth0v
         /XCoW6uVXXUq0rMYIYNaUiNI69O2BQYmxmcbUtWtRccJzZemxnM0W+40Y05qNghfPv7h
         uvq2grjH0cAyhEhQspskFhksPOf+tqu2ecyCJad8yvmTKGsP7FHckmYsPZiHJJLBAFje
         tcQOn747iUc9EYCLgc+p27BURbvw1uqaRcI/gIPtPn7yF3SFRq9z3JlOYvmq6B/doMfd
         IMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719424; x=1758324224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hD6RqHRhoBQyAEPebACVdMiw3nYWEKr1GVCYwgXxlE=;
        b=EGugLxc4Sq3hzTJlCMLyFg/vSGiHoTjGXEmSI1fPt7f0as8LQ6VmbECOhQ21hAxXMT
         XhGUzcOjWhg6dOzYTEtHXaqCLRPKhqFeOxa0S6XamA+Iv6u+t4F/pLmu6LJxQdljf4/s
         p7Lt+/vK8KvfkHv1cwkwpcUkhEwr/wb6ySyWmi7QffzC+4gat72PmACCwzmltXpDnDYK
         A/H6mCrv5VAq1kiJvtiHkBlwEkLckKaiST7BLs8KfTn+leubileYmeO1D1dxUCfAXKCo
         20X057GQyjb5Q5/qUAvZmetHJg0olNFrrPydqXmAzaKUNsYCegN2IYACATWEPJW5g3wv
         nX7g==
X-Forwarded-Encrypted: i=1; AJvYcCXUHpsWLBDiTKLvdrIWC5gqBqMoydDgw05PNHHDcTKzoTtv6PYJtQwT2HgtR1LSSO3aewHrvuQubTUBD20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nmo3J+1TCLOKabU4SSsGxw1Z7Sf/pfqyrddaBndiy9Orbc3l
	lNgSHEi7EzCm/xwvNmVJhmPDIv3rmqtakPTPYkWZSBoviAHBPWJ2OkD+sX/cQ0QHFeMyi2jOcZ/
	aHG98pg==
X-Google-Smtp-Source: AGHT+IGWLwsQU+dLejivzjWhZVlfpjqnxSofRQrCbAJJqAIc4rCqQN32hHX4+j9WegaCO61lPFy9geyAemo=
X-Received: from pjkk4.prod.google.com ([2002:a17:90b:57e4:b0:31f:b2f:aeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32aa:b0:246:d43a:3877
 with SMTP id adf61e73a8af0-2602a49da06mr5641736637.8.1757719424555; Fri, 12
 Sep 2025 16:23:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:49 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-12-seanjc@google.com>
Subject: [PATCH v15 11/41] KVM: x86: Report KVM supported CET MSRs as to-be-saved
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5653ddfe124e..2c9908bc8b32 100644
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
@@ -7598,6 +7602,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
2.51.0.384.g4c02a37b29-goog


