Return-Path: <linux-kernel+bounces-728021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28551B0229B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D2B3BF12E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393562F0E28;
	Fri, 11 Jul 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfUUI/I1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586E1B424F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254871; cv=none; b=WvQ5wqNrNkwJVJG1sNj1BFbVZh/rGs+mPdhWm8zs/6KoTyTa3aKGksmxOIJY+FqEaHP9q/17oZbzvTagbfWQQeQ5vjD8Ef7B9E8Goa4Q8FO8M2BYg/QP5l8ZXz7Tq76TZ549nWbctJeApQNg/bW9sIv4HsZjKf43r1EZ3G9EdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254871; c=relaxed/simple;
	bh=7BbUPB9TjY3KuvvQ6BbKobh16Cwwe89p7CDfJ7ken3A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LQT5H49ueL16e7t6nV1dgfpbNVb/TzWhPiaUoI8z43tkg6wA4G1c8wiBPpOjSc6XQw3rt71cL+ZGQr19DFr0e35R0F6+9y3lYMpc4PbQXTm3Hfy8ZuSz+gadLtS11AN9mhnQMVqReyhgTpBCwIQkrpf2B/K3pxu51bCbVzcZYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfUUI/I1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2820045a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752254869; x=1752859669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI5WZRE/XKn5RiXkAHQA8EKA/1nrWe3w//THUYOXiG8=;
        b=yfUUI/I1WCKPTuzkDu6rBVL3/ucbdoWXmlNch2ZBWD8OMGdy05NHIkPZ0sQWycqxD6
         XFodlKZQ98b8zuC/EgkAox0uwVuRrrdR/1Gh5+Lgpb7AnUf/U7A018dZGw+wqRVpwO/Y
         XbH3MgW8Fzb66fAJATUoWYBrD83ihYxgenAAuOmtTC/Tuxr6v5988VkV0oCPW5JXBV9V
         zt6KiSeAM5Qq0hf2s/ITw7u6mc0BghCMLIUR80fUZJz4FFbqgb9I9HLsAdX8xRGvMQ4H
         w9lRToVBnf5zEXc9O527W1ElQzhNiObjZo9sb6+gjQWURInAw0WUzh61gPve2NKroO1m
         +LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254869; x=1752859669;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI5WZRE/XKn5RiXkAHQA8EKA/1nrWe3w//THUYOXiG8=;
        b=g4yDFr4CEpqCxbQcUBUOOE8FQJPdCz9GeEpyTz731Uj3IziaxlGPIPCL1YeqXTZFOY
         +krYFjBNDT4zytkKVyqiSKlsmO3QQpI+gVCMw4HN7MRVm6P1ifmC5uqp0Png2Z/MyNt7
         RqbwT2gVjQPMYV7DrV4eafVdOgT0HHCHp2GHvsmTEGxI7Nj1TOcKXAGJXIb2nyqmR+Yu
         +1hv8/fi8DMEgIGjLcdovM5Hl9NzaUZrKhiRdVfxU1erwXyAWbOMN/w9R1fXwA4SlllL
         4OVhhcHtbqLTUgt7D0cJ0eb629xN7/0phEk9zL17dRFg5XSbT5Mx1mGqdBO7HyscBoUl
         JQSA==
X-Forwarded-Encrypted: i=1; AJvYcCWwDGiT/iE5EZb4JaQo/rFh/RirebqSl4XZezoARi1IaslWZ7bQDntCJonMANdV2l3WGXhfEPBGJ4l6Hf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1rIaZCBPcDMXeDKC1TomgR028KGffVbCHwRw/4yqY4BrkWgI
	Fpux9Dw98ZT7FFsjzsxLH3tanSisELT8uNqS13UXUD/Kj/B2yCFx59LDm8eFcqRak6AiQ1xW0/t
	Eh/X9aA==
X-Google-Smtp-Source: AGHT+IGxwIvpw9fUAW0Mwbq5ilN49YnbmM7rGv1RwroHtxVkw4tibaMArvZDoQXRDnjprNhgZh4DLVyTols=
X-Received: from pjbof15.prod.google.com ([2002:a17:90b:39cf:b0:2fe:800f:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4e:b0:315:b07a:ac12
 with SMTP id 98e67ed59e1d1-31c4ccc1c1cmr6694127a91.14.1752254869481; Fri, 11
 Jul 2025 10:27:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 11 Jul 2025 10:27:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711172746.1579423-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
guest, as the MSR is supposed to exist in all AMD v2 PMUs.

Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
Cc: stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/pmu.c               | 5 +++++
 arch/x86/kvm/svm/pmu.c           | 1 +
 arch/x86/kvm/x86.c               | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fa878b136eba..ea5366b733c3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -732,6 +732,7 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET	0xc0000303
 
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 75e9cfc689f8..a84fb3d28885 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -650,6 +650,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->global_ctrl;
 		break;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		msr_info->data = 0;
 		break;
@@ -711,6 +712,10 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
+		if (!msr_info->host_initiated)
+			pmu->global_status |= data & ~pmu->global_status_rsvd;
+		break;
 	default:
 		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
 		return kvm_pmu_call(set_msr)(vcpu, msr_info);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 288f7f2a46f2..aa4379e46e96 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -113,6 +113,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		return pmu->version > 1;
 	default:
 		if (msr > MSR_F15H_PERF_CTR5 &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2806f7104295..15c34fbac22a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -367,6 +367,7 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -7353,6 +7354,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
 		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
 			return;
 		break;

base-commit: 6c7ecd725e503bf2ca69ff52c6cc48bb650b1f11
-- 
2.50.0.727.gbf7dc18ff4-goog


