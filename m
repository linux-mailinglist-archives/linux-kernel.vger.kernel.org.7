Return-Path: <linux-kernel+bounces-874730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFEC16F76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601D150607C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7E358D20;
	Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBjmAsmD"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBE357A4B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686472; cv=none; b=X8gmIhIJi/ZMlqPQqiMz+s6se8NQCMieKY/PFKGA+eela9jAaF2qfVDyBIQmVXAWMBcdK/cswyLRehflC6+unY74cO02UKLSp+mhm644jd92bOF4wSY3TE/rHty6SQIqz10ziIthE6ZF3oHBwm6x+v1jdguJSb3gUQSEj9DCzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686472; c=relaxed/simple;
	bh=GD8RpuEVFGCL+XuV4adFosheQV6HDq3yOqYf0EYNM+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKPH8lQWKNjCeFXvWwZgx8q6BZlW5KxC9l3qrdnIRaXaBgpV3sg3Ro8/WgAiJRfxbWjP8+mhpSllnAgtu9FIjwHy3uUsBle1l0/4h8NWHLhSyZ1jPG7YRneDxmlJyao2aSAyUdE4mMXHaZezYHV3Xd+TuNua/02IQ+5haXKKDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBjmAsmD; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-945a4849260so1050300939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686470; x=1762291270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmNxfYa4zbG7utcl3tEiG2lWhptjnWh39yF9cxazXJA=;
        b=ZBjmAsmDscIFPArqdHX5XLZBjP1LA8Dkw2kg5FCrNZea82FNTor1SUwDG8SSJ5iDw2
         8OSaPilvIpCG6IB3TsCmBLAC7wq5zWcfUWKOZtsZAd6iH1Aqo4odW84R1/y2VgmgNJ3j
         LGzBqfrgxKVxPx0ggejgpDr0E4IzpZkzoyfk4M2Q5HOiva6vC1/xZf8sxXq1QoLl831r
         CMZ2A9KhZsVEpfjQ4/j6SddzkY9m7DQHOOg0nYqRWUCuYkrpADuL9NHRplUgqixzffKZ
         99mlvkrsoChk1vye5MycPVOxtQwpeq9pLsotHGtnuSClZAM7WIesUFkScakenv3olaQl
         kYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686470; x=1762291270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmNxfYa4zbG7utcl3tEiG2lWhptjnWh39yF9cxazXJA=;
        b=Up6TOcZDuWFudouFe7frH4w4V51MSNrZ+rNRsn5NDVj0AvnMTJcb5UaeWfttgADBV5
         reZq0EgTmq0N2fHrgI6WlaiqKR6T/zl5aPROGuSqKE6K4wrZBAakNFiOqsBeTjWUJ1EX
         diEuRlfLjgaPWCvN/B6MndJ5uDFgUUtDZJw8aMrlvWyAMvELww7TLvJ1ekcHyLcxcvPR
         pakwj5d6qNjrHrbP18F1upNie5QdPaCO8DDqqi+81MD9FNUohcKUCtiJ6+ia9718FiHL
         qbtFq+Ss+EootS0MXbkh6FBbHImabr0u5Iaduk+ud6Y7EYKusTOn5QLQCQWJyAsbN2Vp
         yQSw==
X-Gm-Message-State: AOJu0YyIjMOHOLi1ej5HcRh82r9IOIHL3WZimkfC+uK/cSoxkBaEiGD0
	zTjjQl2zeMSCSJ35BMhdco7s3eHJ88AtkmzsHQ1DCai1t+zcmOisRJMaRIX1y9S+NbjljwZ2Uqe
	eTQ==
X-Google-Smtp-Source: AGHT+IENgvHr4RL1+a3zLcwxL/tyV+1AiIQfR4t+3Nsc1jQj6XZAwYUcTnvjsmwnZ44L3G0mI/LMYjwpkQ==
X-Received: from iobbi12.prod.google.com ([2002:a05:6602:358c:b0:945:ab36:29ab])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6d04:b0:93e:8bfb:726a
 with SMTP id ca18e2360f4ac-945c9898ab3mr141556239f.18.1761686470077; Tue, 28
 Oct 2025 14:21:10 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:41 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-16-sagis@google.com>
Subject: [PATCH v12 15/23] KVM: selftests: Call TDX init when creating a new
 TDX vm
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

TDX VMs need to issue the KVM_TDX_INIT_VM ioctl after VM creation to
initialize the TD. This ioctl also sets the cpuids and attributes for
the VM.

At this point we can also set the common boot parameters such as CR3,
CR4, etc. These parameters will get copied to the relevant registers by
the TD boot code trampoline.

Signed-off-by: Sagi Shahar <sagis@google.com>

---------------------------------------------

Changes from v10:
 * The call to vm_tdx_load_common_boot_parameters() was accidently
   dropped as part of the refactor from v9 to v10. I re-added it here.
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 5f75bd48623b..990f2769c5d8 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -676,6 +676,11 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
+	if (is_tdx_vm(vm)) {
+		vm_tdx_init_vm(vm, 0);
+		vm_tdx_load_common_boot_parameters(vm);
+	}
+
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
-- 
2.51.1.851.g4ebd6896fd-goog


