Return-Path: <linux-kernel+bounces-630487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C387DAA7AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE754C5B46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A561FE45A;
	Fri,  2 May 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkwKjQ1q"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE171D6DBC
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218065; cv=none; b=BsPBEsXElj764/o4nSkveUX6dHaI3c6Uu1bX+f51qsstJW0KTnzIjqvbdbp/GcZaUfSc3uBwhgOHl0gibLuTJoRVh8l93PmhxyhpLxS8VPUPnHszAkm/VxDXxO+W2Y6j3kDErsFYh4U3ue+Q5gjg6PF0GnKk9Vyj3wReMDSjd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218065; c=relaxed/simple;
	bh=CaKUbVJ6LWsz4DrKyHvCa9IG5Ra0eMoLXyug3mvzalg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u/2ctkz8ueAAKkSSmvmyF1hvnZLEURZlRy19UMMxa3R5Yh4XwRjpJ9UVMAytfv3/y08tsMhxetiZ6N++zjWqYy0vFOKNhkQoMiTlVRtzzdi3pgYViofw36Gr4E7v6tNJemavOJuVSkBqLCkDS4g7h1u8PfTYnLS4uUz5pKmeXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkwKjQ1q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115383fcecso1547273a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746218063; x=1746822863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHy3TF8P9l5++35QdA7tiUtxMTsDtJ3zmrckj/mvrlQ=;
        b=JkwKjQ1qlsKkDM6XiuCpSvUfJ/Q5iX3tsSN0u5kGvup94iDllyiPqtmtJuQ9z4dTbI
         SDWkSwTb76JYAu71Au9ThXf2mvGsJY1ORuYN8aMYc4Z17/+yCzRPe1RGeqe/akLpkO+J
         J/VUIxeS5I6+QYMMVxo+NDPrMHd/JkO5nymRb+M03K5IkmR7br+3Zp7fdCVSz/cIehLl
         ywF5veYZWkPxDtXvmHyNhXqt8ODMEgWhClM89TdJGjT3EAcj0oHIo20GBfAxNL1Uc0on
         vFmnlNkvFiIrsvImbnX98GSSXc0aFFUPrmq1uUr/zO9DIhwfn2AcFD3lNsxkTfxVrnwh
         RETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746218063; x=1746822863;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHy3TF8P9l5++35QdA7tiUtxMTsDtJ3zmrckj/mvrlQ=;
        b=H9dn1aJQSpscgsx2ikgPQcaT9OkllZyDphx4rlt9ZLtEfLZppPbUCsL+I9RtNKyF6h
         F2AstHH6brSFRXEctcLZ1LIzG4Z00XSqmzPc0yF0c5TfH2rT+7ZlBiIYXpOM+Q/eXCUH
         zJiISF7tN8AmKFwwGZUmibFmrxZSOYV28iEpYiP0n1FiGTo/5UcQ4irb4qqVF0pd3gyy
         SLiOFhDke8EhFZDxmJfh6MVYGF3yGTCkXdNx0OZy1qxd9y1umBYA5k82Y9RKsSYilYg8
         SpjWcPXrYucgSW0fcJr60C9roRrYU2fGlKrw7HcVTeXHnE0Vap1a/KnlL96s+aCax3WX
         2K8A==
X-Forwarded-Encrypted: i=1; AJvYcCWryS4c39JNI/XWpCl5sCFAev2bj6pi8o++9Sz9i/JnUu0WoY0rAU6QRcggfqaX5ajo2tab3uwUKSMcwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWDCoJzV1LK02QQaZidVEBFGb2swOY9ti6ojVT0fgWgs0uxsT
	0ysjMksvQ1BPOaBEmjMrrlNWCYiKLoyVoG4GOukoCgrQAaEISAoj+8pdRg01JJpIyPx1pDLC42h
	K7w==
X-Google-Smtp-Source: AGHT+IGDnP/CedYQKruYoJdl3Oerv+wKM4eW4vcXm1yVbiGQf3MnEOYSKV8cB/8bhCW1cE6cRcunhZl7U34=
X-Received: from pjbpt18.prod.google.com ([2002:a17:90b:3d12:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc7:b0:308:5273:4df8
 with SMTP id 98e67ed59e1d1-30a4e5a57e5mr8002048a91.10.1746218063650; Fri, 02
 May 2025 13:34:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 May 2025 13:34:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250502203421.865686-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Revert kvm_x86_ops.mem_enc_ioctl() back to an
 OPTIONAL hook
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Restore KVM's handling of a NULL kvm_x86_ops.mem_enc_ioctl, as the hook is
NULL on SVM when CONFIG_KVM_AMD_SEV=n, and TDX will soon follow suit.

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at arch/x86/include/asm/kvm-x86-ops.h:130 kvm_x86_vendor_init+0x178b/0x18e0
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc2-dc1aead1a985-sink-vm #2 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_x86_vendor_init+0x178b/0x18e0
  Call Trace:
   <TASK>
   svm_init+0x2e/0x60
   do_one_initcall+0x56/0x290
   kernel_init_freeable+0x192/0x1e0
   kernel_init+0x16/0x130
   ret_from_fork+0x30/0x50
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

Opportunistically drop the superfluous curly braces.

Link: https://lore.kernel.org/all/20250318-vverma7-cleanup_x86_ops-v2-4-701e82d6b779@intel.com
Fixes: b2aaf38ced69 ("KVM: TDX: Add place holder for TDX VM specific mem_enc_op ioctl")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 2 +-
 arch/x86/kvm/x86.c                 | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 79406bf07a1c..8d50e3e0a19b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -127,7 +127,7 @@ KVM_X86_OP(leave_smm)
 KVM_X86_OP(enable_smi_window)
 #endif
 KVM_X86_OP_OPTIONAL(dev_get_attr)
-KVM_X86_OP(mem_enc_ioctl)
+KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
 KVM_X86_OP_OPTIONAL(vcpu_mem_enc_ioctl)
 KVM_X86_OP_OPTIONAL(mem_enc_register_region)
 KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f6ce044b090a..247d54de101a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7324,10 +7324,13 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = READ_ONCE(kvm->arch.default_tsc_khz);
 		goto out;
 	}
-	case KVM_MEMORY_ENCRYPT_OP: {
+	case KVM_MEMORY_ENCRYPT_OP:
+		r = -ENOTTY;
+		if (!kvm_x86_ops.mem_enc_ioctl)
+			goto out;
+
 		r = kvm_x86_call(mem_enc_ioctl)(kvm, argp);
 		break;
-	}
 	case KVM_MEMORY_ENCRYPT_REG_REGION: {
 		struct kvm_enc_region region;
 

base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
-- 
2.49.0.906.g1f30a19c02-goog


