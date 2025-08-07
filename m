Return-Path: <linux-kernel+bounces-759465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2039B1DDD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA337B1C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFE273D86;
	Thu,  7 Aug 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMmx0oYs"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C42417C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597804; cv=none; b=kBswYOLweX1rVkw6mm6Ri8xpOiwrjTo0qmvFh+i+j1l0onmBJdVgZEo+7/o6HR5XXHUUnUdW9ppqAG9JxEic+LWf/7x+Dw6BQHO14boUabsB25GK2bNqlTeoWLFLSKAfxzRR9nFEia+szrL770azhMIaC47T+RUoUZlDAq48L08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597804; c=relaxed/simple;
	bh=KOoCqu20ck1nvt78qXS9AASI1nzd75am6SWO6mncJgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSOGXyeVYKZtHJj4tzyFRqctMXSwjNiPiDhHAGZOkqTrhV1WaZayuZZxASIRJhPNETmnHNhCBzda2kp7i/0UucPSecV81/45AsVlkxQIximWMMEDCtkBOdeO4aWS+VPDxHihyEoegO1W41NPryGvnmON0R3TiFIgBH9XkET+9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMmx0oYs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso1200308a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597802; x=1755202602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY1063A3eM4jRKn9Lwg/S7WLjF7eZucmIixEhnmKPCk=;
        b=hMmx0oYsdjn7KlMNcJTZeUkYVJbkfVI5BM4olXFkYdlYoCIyV/n6Wa11ABEHQlKlfO
         p+cntW22meeHlU9gZriYiRXwVWG3F8J6XFYriehk7rHoe4X8kafK0ATuXWwMbChgczt2
         1iCoEjOwiW6qSAxZwb/3xy4Fok3b2HsyjKMNu9c0kvK3pgf3b+9nGNTmJddJZ6+50GGJ
         uiWn6WWZQINbRSW+VaqU/UI3XYbk3ngh/M5bVSC6VJPEvDhu/q+0ZsYeBPrsRQ9Qtsek
         pHbQMikiEfZodnP5Q49oOQcZeS282ZyDL5b5JFSRHVa/mts5Jrx24MH11E8n08nzJCvR
         2m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597802; x=1755202602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY1063A3eM4jRKn9Lwg/S7WLjF7eZucmIixEhnmKPCk=;
        b=pnJI8uJRjpjrGuu+s1LRfyAhjgpGx/A4rkv+MQM+sQXhO7ge1k1Ac/mJ+xJZStstGQ
         4fofHsGn4+IkI2swmt441Qs3M3dtzVHG0kRXfWQRQ0Fec60/WIugqlE2TG9mv2PRhNvh
         Zd4FQE6s7f0GSTZvnOCOuC00GuJcdfoaa1XnnMR86qDgpPnTsdSb/6Pm8DapPClscFyN
         HR1VOn9CHUpotg0FwbtlGEgEyjPp8LR42mfNKgbflyf3p/ad2snNonKCcQyf6kEV5GNm
         /DcibiCPt+LuPwfmVsx7KwZMmh4RFq7PThFqt9XFU6I9ikh9FR1NIy1Asen3APCPuIoP
         QCdg==
X-Gm-Message-State: AOJu0YxmD6ij+yZHaT2rfFi6J8tjtOpxFa2EA3Nm8EVeMISsdC1FfQHl
	C4wpRv08iZszEYg0K85mrfP8MPHNhEwrpqgckTl/TjOj91ZRh62N980KfIUuISdUETcWaEtOpLk
	6yA==
X-Google-Smtp-Source: AGHT+IHr+KQP67F9tu5jX/oDeI0DglRUP8n3J9QXbxBj/BZFmCvo1Gke3fbBZ35nerS00VBumho8cM4uag==
X-Received: from pldy12.prod.google.com ([2002:a17:902:cacc:b0:240:2d28:e064])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b26:b0:240:41a3:8e0d
 with SMTP id d9443c01a7336-242c221775bmr4503185ad.36.1754597801923; Thu, 07
 Aug 2025 13:16:41 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:15:59 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-4-sagis@google.com>
Subject: [PATCH v8 03/30] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

Store the stack address as part of struct kvm_vcpu so that it can
be accessible later to be passed to the boot code for rsp
initialization.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h  | 1 +
 tools/testing/selftests/kvm/lib/x86/processor.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9994861d2acb..5c4ca25803ac 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -58,6 +58,7 @@ struct kvm_vcpu {
 	int fd;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	vm_vaddr_t initial_stack_addr;
 #ifdef __x86_64__
 	struct kvm_cpuid2 *cpuid;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 002303e2a572..da6e9315ebe2 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -694,6 +694,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	vcpu_init_sregs(vm, vcpu);
 	vcpu_init_xcrs(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


