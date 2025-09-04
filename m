Return-Path: <linux-kernel+bounces-800075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B052DB4331A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D174684331
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369A29B8FE;
	Thu,  4 Sep 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVd5SMVD"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71F29B8D3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968928; cv=none; b=WhBVnt03Os1c3cHGSbi8kBJaPayMBsxv2SmPPo4GodAfn5aE6cqtOIpDzn/nA/oDEw9XeCbDyCnblXXds3C5LUicB6V/gtWT77po6ypwULcn8UzR+adyIla14DvnOYCv24QLkwDiw+hhGnc7h32n/JFdvyUhpDDlkcOMFSqjCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968928; c=relaxed/simple;
	bh=jzB6ZNggPgXQrt5oRvtMpK/C1hmf8zACld+Ecgq9TtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YiEEPvVhbHP15dIKS1Ctl30C7EFQuTT1P5ZVV6gds6m9W7DHSibFYVg6eHWjFWTbQeRtJ7MBNQmkp6C3iwGqH17kjhxwnXu1INXfDL3Q0Mk7/q7xDQ0HEOjvFGADOCMD9CYO1F6zZCOJHRVpWg4Syjur/nmE5hUCBXi/Zfu21yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVd5SMVD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174bdce2so488144a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968926; x=1757573726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxE+Xj3ugJHUcqN9a7F7aAsq//VgXJ8T/JzaLukZcD8=;
        b=mVd5SMVDUybeFqyXNebGqCtiwpQjoRXMwjGx23FkKwg7GsJDWSGqlWDlMulTn1tDgx
         16F3Zyu1hhlUdOnzAjAnFX4ORerOUUOIi+0KspYHnuIWLZeREm6WkQ1WzPuW4c567s0L
         UzS5kObvn5/AcuuNL3sP1xmb8+RoVMSEkIgpGuJLHm5GLcktmjsCAgWJsN4bNHwQN0Dx
         zkorZMp87kdzvkfsVTI2qbYbQ3MtDME3i2russAzuO0ylVG33kPnU8SSvlrOzY3Q0/b3
         V5q5WN8tmu02ubD5jq9ade3cJnFh44j3bKaJfcemJ1/XxM1722KaXfDgzjhiTG7HZ60t
         7ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968926; x=1757573726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxE+Xj3ugJHUcqN9a7F7aAsq//VgXJ8T/JzaLukZcD8=;
        b=IIfm3fifx3/Jm7YMbVZucfHUa4Ca40zVb1QR6YnLEX49sR/WrNoEF7L4uLicqylQeI
         s62DCBxXlkPrCNil5xMU7l496gV1WhI3GhPNAU7sr0l/14X9sSKFCOXoOTPVNyPVJEGx
         ePmSFVTA76ef9XbNEZJgzKw7RA7lhHMXXy+BZmghl5GNLm7KJSXfBxZB4p7uksbkHXEG
         c7mAzdb4nbqIDezuty5AKyRppqZp33JBUfAIimelqgglZds2+iW2pOC9UfUrpQ6YdCCy
         /rdtYJ39e6Z395BRP9eK5RLzyfkve9KUvg/YeoqPAvj5phGANRRj7sCXnlDV88rSaPIH
         rM7w==
X-Gm-Message-State: AOJu0YyoKrSj0keHxO7vXjFEZUV+7SbEiv1JZQe+fiNV6uy0ft5ugBbM
	lgo2UfX/mABfp0HVaT6Du2yWVbxvv1KZmgmXkUujxgY6cz5kVGlMF8zdlx7MO1mmF4OUM1+0JTt
	TcA==
X-Google-Smtp-Source: AGHT+IGoSYrzfeX5RVnQxdwXezOdW2R08Qc3RSSjnfBqAMU0OXMTqtk5sU6FDVAGyyN96wJHsxaP6juUfQ==
X-Received: from pfbdh11.prod.google.com ([2002:a05:6a00:478b:b0:771:e00d:cee])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1c:b0:243:ca15:f84c
 with SMTP id adf61e73a8af0-243d6f0bc0bmr25910996637.37.1756968926069; Wed, 03
 Sep 2025 23:55:26 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:45 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-16-sagis@google.com>
Subject: [PATCH v10 15/21] KVM: selftests: Setup memory regions for TDX on vm creation
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guest registers are inaccessible to kvm for TDX VMs. In order to set
register values for TDX we use a special boot code which loads the
register values from memory and write them into the appropriate
registers.

This patch sets up the memory regions used for the boot code and the
boot parameters for TDX.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b4c8702ba4bd..d8a944b5ada3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2018, Google LLC.
  */
+#include "tdx/tdx_util.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -465,7 +466,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif
@@ -499,6 +500,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
+	if (is_tdx_vm(vm)) {
+		/* Setup additional mem regions for TDX. */
+		vm_tdx_setup_boot_code_region(vm);
+		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
+	}
+
 	kvm_vm_elf_load(vm, program_invocation_name);
 
 	/*
-- 
2.51.0.338.gd7d06c2dae-goog


