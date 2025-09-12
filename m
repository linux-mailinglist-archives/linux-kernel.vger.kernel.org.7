Return-Path: <linux-kernel+bounces-814874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD52B55A01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EE75670CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9229E0F4;
	Fri, 12 Sep 2025 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AD/w+J5Q"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38912287515
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719415; cv=none; b=BojHtYPlHk6nrViC1aUpYQTMgBjjmOVZGdipCsDAwHV//2+tgO4UsbM2Y3XUNAHoh1VDW/72NDbbIXoEOHp4B/8Jt1ucHz+5bEU7YR0cqGOvSPUhPN+sX15xZzfMk9ZW0YToMrGZNulu0hau3oeN703JUxUzgya58q13GcdcSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719415; c=relaxed/simple;
	bh=G1s+lgWJIgQwzcGoQ1PgYO8Z6+BWK0NfReWmhWVvjvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eaOKQKP6gJYdBkE2A60hRp5TskS/JTue8F0x0/MW5o1Y7n+nmIT1L0eshZGqkOS2AQVOOJc3BzHqrp0guwvaxyI0lfwme5n6Kr7jm6t8BH+NDg5YOrDwezqc1vrL+RqFJvO4g2mFMraFD2cUazQ/PNwcEsBT/LvI+4DO8K3Ptx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AD/w+J5Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248d9301475so35561105ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719414; x=1758324214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=chF3amFQqO9S23sbY27BFQPnaf3vHv1B5sQOjntR35k=;
        b=AD/w+J5QCZuITExYpNFvjdKiMjAHiWaCJbvxlqheufTJrjT6biKq5aCiMy8XDJtDj1
         2BnPORt3AbqaHlDF6r+r82q5Im66MHczQ0uf08N5puhp9TRKobjeiBeCOG0QpVRwhTFL
         XemdE+mXMIFzzWWKRuKiAHtZFZvzV8IlUwuaM/ieT/hEG7GQphjXyMsyDlytMRauMVSA
         dfplYdIMX7EBZPjXjTioRWJzBExoqcIyJQTuNYLlX9ISBZaykQv3aVb+cHcst2MJuVMX
         5yv6OW+QvkKzsHzpX9sYO5e3euTkMHT4M7HHob00CI9YImdvCpPXC+QOrcScvT3ul8gg
         Nf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719414; x=1758324214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chF3amFQqO9S23sbY27BFQPnaf3vHv1B5sQOjntR35k=;
        b=AtTjZxNGuN8u+il0RO8getUeznHkiWXSBW5RIyY3eScp2vkp4pNW0MeuclvMBWM0W8
         uq1VWBDkmSNZL4rHnxj1UD6Dcz6H72bgTzgYKwsqHtbdpj/3BRh7S/TJpwpa6UG/aMQX
         uGUfm87auzsSfsX7oj0dh5jMOT8aLq8EQQWraJvWcJWQLRJbl1qm8Pr0QjJjxV4BcX+R
         wcFsgD6o4MWjeH8xFPGT9iFGhQ6ePQOYl0q+Pu351ej3F0M7ys2CNd47hmcn9ArTUh9u
         NIlW2g13E8RsP6eUbwMMCnTIuEPLJ7RsMD1R5pU1lwqo87LXPAiM1bGui1l/7uIi7tD/
         jIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXICozJFMiVfP4T3M4VHvXreTQsymqFczypo6op3bzkeaV8Qm0SZghJ0eI8NtCS3mRr1U7U2kugEVEbv40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ieGQnT9IMXOKbheo3tW1vDfs+hCLLwUOYXHdAYSQ7kBKMbrN
	zQAWZubgOgJb90X9AioWZ6PhR2obN3JopqYU7lwWkz9H1py9l8EJdF/RI9gek3ge/e5pHLNmAOG
	0j5Y6cg==
X-Google-Smtp-Source: AGHT+IFrnFD92ng7tEsW/Py55ME1+YlpgRJlsBgfJ2OrgISj1HLtggF+Ec6syamaoACTlL+jqr8UrabQeAw=
X-Received: from plii18.prod.google.com ([2002:a17:902:eb52:b0:25d:510:6240])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:284:b0:24a:9b12:5248
 with SMTP id d9443c01a7336-25d27038e28mr51496115ad.54.1757719413616; Fri, 12
 Sep 2025 16:23:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:43 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-6-seanjc@google.com>
Subject: [PATCH v15 05/41] KVM: x86: Report XSS as to-be-saved if there are
 supported features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add MSR_IA32_XSS to list of MSRs reported to userspace if supported_xss
is non-zero, i.e. KVM supports at least one XSS based feature.

Before enabling CET virtualization series, guest IA32_MSR_XSS is
guaranteed to be 0, i.e., XSAVES/XRSTORS is executed in non-root mode
with XSS == 0, which equals to the effect of XSAVE/XRSTOR.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 771b7c883c66..3b4258b38ad8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -332,7 +332,7 @@ static const u32 msrs_to_save_base[] = {
 	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
 	MSR_IA32_UMWAIT_CONTROL,
 
-	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR, MSR_IA32_XSS,
 };
 
 static const u32 msrs_to_save_pmu[] = {
@@ -7499,6 +7499,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
 			return;
 		break;
+	case MSR_IA32_XSS:
+		if (!kvm_caps.supported_xss)
+			return;
+		break;
 	default:
 		break;
 	}
-- 
2.51.0.384.g4c02a37b29-goog


