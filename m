Return-Path: <linux-kernel+bounces-749833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F14B15373
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DFA7A8AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B62566D3;
	Tue, 29 Jul 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTCJuEL9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CC24C66F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817628; cv=none; b=P5nXm0XDzS4T+2PWJQXUfpoamiBsw+k1ZN0yKi577C4sq9zQORMTIKLQqi/F4ufcvtWsmk90IGbO8BLKIgpNP7OvlcCcf6a3uwJpT1s1umexftcdcqws67XCCZwNum3CuYt3/z4tClmKk1qWwluUrItqCdX0lrgwr3lUwg1y8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817628; c=relaxed/simple;
	bh=uRUA1Dw0gwf9VF6IMVv4hpWTJUqHYnh2F1froOP8Hrc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TfkJ/8qOa2bGKZ1GSTdV8SKUJAbdXTKd9iTCw6JRvJBEcTof4DaGq8yVVm6/J6xAe7eQt0FIOdvkN+auZ2gDwx+sNbWxUy4xBWXxl7lBnVSYDy1qAADin9ZX+Q+9ek0NSVmw6eojtRgZNBfpS/gMfVT4DH/t0s3Uk7mazu1bycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTCJuEL9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f3cfdd3d3so820701a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817627; x=1754422427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr2NEPUlMUbu3MZ3j1bjKONtMkJFv/DS/JUFQy2VOuc=;
        b=RTCJuEL9f+92rDm2buaQuHMMJ67iHkIYX+w7AUGtBtZnpXIRTQXEmhmlHg2l+M5X1J
         Caud07uDbRM+9403SQKh5ScunyRzi9+72T1P6LtpdH91A3Wmi4nmWW2CVYBg8qyzahr8
         Y7VqdUq+lY/E4ptgLNH9mEPWuMy22+gW5QCL8CJmP0q3zl3reMryInccmb2zZMWwzqrZ
         Mui7+DyifxTDhDDXnMZVhc71Ef2H67S/30nECuxkHQg2DiGw1eSDS+mcn56v08uu2kiF
         PNbunFKg/SlQUUc+3Mu7eJB/4S9e25+BcakkgKUDHEvwXvCbGzSBhx4XN9l5Da/1yAgc
         5RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817627; x=1754422427;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr2NEPUlMUbu3MZ3j1bjKONtMkJFv/DS/JUFQy2VOuc=;
        b=gqMUd8p/l8tqc6tfBNYqJUPY69GY7OvgqOBhPPfIE3NXSViRMEDm8jdBPByEIUyvrE
         S2Wth7Lzy+GwWfyPvqz7r7SaBD7l/qiGmWPmekM/dtnNGcuuqKHP2Dgd3JjcSlE0aFwg
         RJXjweG3bziVsQX08ADuI/T69vpjamFxUJgOt3e5eKRSkni3z/B7bALeWy+uFmaEPCdJ
         KiQhDateqpTtt1tKFKHMeNK8XZp5gXXvsPHv+JjwcMTjGGkLlNDIReguVFistEpvZbqK
         QvpHHhjC7GQfoheXi8pbvfbw0/Vfzf38pRpYsRT++7qmcVwGOGjfRjLsgGzNw3Ivq+X1
         NNSA==
X-Forwarded-Encrypted: i=1; AJvYcCV7yjp3ckBdL6/OmWA7andoQm5r+GS2bKSnj5i0HBaly5DJ/U9E2GQSkHtDXTiventrj7YXX5WzIknxgps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1um1ZjTHqoOqDb0A1y7IidHkuc3gW3XDiKsvwFaKq6Je6a2Sv
	QgM1qXNSxtSWUotVufZxj1/YMm6K1o3dRUtaYxD9K43zGcSdSsSAsMWadaxw59RlRikJHEfIEaL
	kFqIMng==
X-Google-Smtp-Source: AGHT+IEpCUyIaefYP0YL7w8y1faaEZii0WVM++l9+v+mc/1ojeZtttZMEz40RX0OKzEWa3Hqy78BV9878sU=
X-Received: from pja11.prod.google.com ([2002:a17:90b:548b:b0:313:17cf:434f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:562b:b0:31e:d9f0:9b96
 with SMTP id 98e67ed59e1d1-31f5ddb6641mr902917a91.14.1753817626768; Tue, 29
 Jul 2025 12:33:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 12:33:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193341.621487-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: Drop vm_dead, pivot on vm_bugged for -EIO
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

Drop vm_dead and instead reject ioctls based only on vm_bugged.  Checking
vm_dead (or vm_bugged) is inherently racy due as it's not protected by any
locks.  For vm_bugged, imperfection is a-ok as the goal is purely to limit
the damage done by a kernel/hardware bug.  But rejecting ioclts based on
vm_dead is dangerous as it gives us a false sense of security, e.g. see the
race found by syzbot in commit ecf371f8b02d ("KVM: SVM: Reject SEV{-ES}
intra host migration if vCPU creation is in-flight").

This series was motivated by the last patch, a.k.a. KVM_TDX_TERMINATE_VM.
I applied a slightly different version of that patch for 6.17[*], but I'm
reposting it with the vm_dead changes due to Paolo's question about whether
or not we should have a generic KVM_TERMINATE_VM; dropping vm_dead doesn't
make much sense if we want to add KVM_TERMINATE_VM.

[*] https://lore.kernel.org/all/20250725220713.264711-13-seanjc@google.com

Sean Christopherson (5):
  KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
  KVM: TDX: Exit with MEMORY_FAULT on unexpected pending S-EPT Violation
  KVM: Reject ioctls only if the VM is bugged, not simply marked dead
  KVM: selftests: Use for-loop to handle all successful SEV migrations
  KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM

 Documentation/virt/kvm/x86/intel-tdx.rst      | 22 ++++++++-
 arch/arm64/kvm/arm.c                          |  2 +-
 arch/arm64/kvm/vgic/vgic-init.c               |  2 +-
 arch/x86/include/uapi/asm/kvm.h               |  7 ++-
 arch/x86/kvm/mmu/mmu.c                        |  2 +-
 arch/x86/kvm/vmx/tdx.c                        | 45 +++++++++++++------
 arch/x86/kvm/vmx/tdx.h                        |  1 +
 arch/x86/kvm/x86.c                            |  2 +-
 include/linux/kvm_host.h                      | 11 +++--
 .../selftests/kvm/x86/sev_migrate_tests.c     | 34 ++++++--------
 virt/kvm/kvm_main.c                           | 10 ++---
 11 files changed, 90 insertions(+), 48 deletions(-)


base-commit: beafd7ecf2255e8b62a42dc04f54843033db3d24
-- 
2.50.1.552.g942d659e1b-goog


