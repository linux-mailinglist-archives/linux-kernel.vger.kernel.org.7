Return-Path: <linux-kernel+bounces-737011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30343B0A69F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2425A237A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C444503B;
	Fri, 18 Jul 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2va5X1p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6091624DF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850235; cv=none; b=Ym/bUhTziS4zzIihvcxUd6COSLSdwk8HKTz8Gof6heYsdKF1kJ17Sok/NL8d8rQRjlYhQu1cLv3V7MiRpXBb4misxilPoYOaLGqrCQqA7MvYIiSYAD7pAjM0+4OsNyRyratqLbnNHpY+rhbjWDCYS4N06XrGqtjCmbpLy3q9xVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850235; c=relaxed/simple;
	bh=mQj/fZKUb5zwAXiAFE4TdP7dkjioGEkEXr0GDMohAC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Huv5fS3ABOvZVs/KYCc7Y1ZoSZnyQ9Ik36qhQRU9oStzQA3xFJxK8rC6p1mc6+B7WhEXUJj8KE75fsm8FjUkDUusMBLI0cJ5q3nAHaT0MQhK1AkIWNHwLWwBNuUBoJTE4ZEeuZ9GpUDRaIzXTy052xzW/h5odNr+ORVrw/8bAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2va5X1p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752850232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DXwgiGPomWe8gRzJNNZctpJkd683dk1nkWxQefrULi4=;
	b=B2va5X1pZM//Fem1ITcXyNyJ9BpgUohPwgHeFUsbyQwqfilm/6uOj0HTl3Cdk0I8yOduTV
	NF4TFDMH7o+9ayxSt3s9ERG8DqmANqDAPOGh/V6timcaYGp46sqk+zoVcaL8AMijzc4Pdx
	ysTD0OkEIXgthNdDWYF38UxF37xQbm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-CqVRg_x5OfO1-Zv6icfZ8w-1; Fri, 18 Jul 2025 10:50:30 -0400
X-MC-Unique: CqVRg_x5OfO1-Zv6icfZ8w-1
X-Mimecast-MFC-AGG-ID: CqVRg_x5OfO1-Zv6icfZ8w_1752850229
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so11227235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850228; x=1753455028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXwgiGPomWe8gRzJNNZctpJkd683dk1nkWxQefrULi4=;
        b=OdgE0kvMwG4UNAZn0TaVlrtzjP/qaI4+kMUR3O8effNalRc/mTaQiWymkL31wP6Jr5
         ER0SlNYeRpTkTbq5hsE7Y7LImxgbESfzH1BEWEjN4A8SctH3sJYKso6agDyW9Bi26cKk
         goj8/46/AUVWp04+07OkjqUkcRSs526T2d7oGfdGV2eWbksz112WIv6oqhpsiVimQQKQ
         dU+H9VW46l3hUOBtzsnLyVFd5Tpl74PleaqiwN0Bmp/b2rRi1/MMfx5dSXq9nFZVHhC+
         /hx2/vQ3DbGw2It8/d7998OJNesHcQnFp/75jhrdqWnajL3mGOcZr310I5+Z3f4Nes06
         RroQ==
X-Gm-Message-State: AOJu0Yyv1QsVDXznPTNLM5vlChbFcwouFbjrk55HnHxwLUGPiNcvVjMW
	6Xb8ehjrTtZ0ON0tzV17YPVFRihSM/Z+OdcvrFFpso059UacSR73nS8ImNmtoqXOAXJk5cxO6Ev
	nauymkLTVY9ZpcuPpERTqZCPRpu27q1msge0HnyVTK4o7GRh2BLvdxa5r9mQ8GkY3rt2Y1YPE8Q
	==
X-Gm-Gg: ASbGncuFbBbxldohp48l8/Ng4rgSVy/K8NS+efRr2L+2/+GR18CB9rfxOjpf86qNcwm
	kZSGOnLo5r4MDg/j2/lH4e5hP/P3l3sOOwV7fubL91Iq/Z1BZKFSXio/2hdFMrqpnnmAkbayYvi
	MkM+aB0+Bbd4pMZ25Oc6knG4VPTQY0i7KRFEFKZXjuDVkW6exrZCY5pmXbsELrJe/4cfh8KgXP+
	/7Q6LWfVMoO5iV9VLQS+wTj8rr2h54lHpoXyWKOtS8ajKfg+MnJ83/Vm/QNyiBhNUi4gWPMsJvg
	ePlXq9Djsd9ySvR8OBCH3hrInU/ghz+EJwdxwAn5dcw=
X-Received: by 2002:a05:600c:3488:b0:456:f00:4b5d with SMTP id 5b1f17b1804b1-4563a1f42c0mr37270925e9.22.1752850228475;
        Fri, 18 Jul 2025 07:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn6jKUOt8K/Agi87vQ3dTaTfuJ/qV+gjxJFYc2DM2F2MFJuTiVcpqNlnEBoIqgCLAIXlB+QQ==
X-Received: by 2002:a05:600c:3488:b0:456:f00:4b5d with SMTP id 5b1f17b1804b1-4563a1f42c0mr37270725e9.22.1752850228030;
        Fri, 18 Jul 2025 07:50:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.73.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740285sm22700915e9.20.2025.07.18.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:50:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes, and documentation changes, for Linux 6.16-rc7
Date: Fri, 18 Jul 2025 16:50:26 +0200
Message-ID: <20250718145026.179015-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 4b7d440de209cb2bb83827c30107ba05884a50c7:

  Merge tag 'kvm-x86-fixes-6.16-rc7' of https://github.com/kvm-x86/linux into HEAD (2025-07-17 17:06:13 +0200)

----------------------------------------------------------------
ARM:

* Fix use of u64_replace_bits() in adjusting the guest's view of
  MDCR_EL2.HPMN

RISC-V:

* Fix an issue related to timer cleanup when exiting to user-space

* Fix a race-condition in updating interrupts enabled for the guest
  when IMSIC is hardware-virtualized

x86:

* Reject KVM_SET_TSC_KHZ for guests with a protected TSC (currently only TDX).

* Ensure struct kvm_tdx_capabilities fields that are not explicitly set by KVM
  are zeroed.

Documentation:

* Explain how KVM contributions should be made testable

* Fix a formatting goof in the TDX documentation.

----------------------------------------------------------------
Anup Patel (2):
      RISC-V: KVM: Disable vstimecmp before exiting to user-space
      RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization

Ben Horgan (1):
      KVM: arm64: Fix enforcement of upper bound on MDCR_EL2.HPMN

Binbin Wu (1):
      Documentation: KVM: Fix unexpected unindent warning

Kai Huang (1):
      KVM: x86: Reject KVM_SET_TSC_KHZ vCPU ioctl for TSC protected guest

Paolo Bonzini (5):
      KVM: Documentation: minimal updates to review-checklist.rst
      KVM: Documentation: document how KVM is tested
      Merge tag 'kvmarm-fixes-6.16-6' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
      Merge tag 'kvm-riscv-fixes-6.16-2' of https://github.com/kvm-riscv/linux into HEAD
      Merge tag 'kvm-x86-fixes-6.16-rc7' of https://github.com/kvm-x86/linux into HEAD

Sean Christopherson (1):
      KVM: VMX: Ensure unused kvm_tdx_capabilities fields are zeroed out

Xiaoyao Li (1):
      KVM: TDX: Don't report base TDVMCALLs

 Documentation/virt/kvm/api.rst              | 11 +++-
 Documentation/virt/kvm/review-checklist.rst | 95 ++++++++++++++++++++++++++---
 arch/arm64/kvm/sys_regs.c                   |  2 +-
 arch/riscv/include/asm/kvm_aia.h            |  4 +-
 arch/riscv/include/asm/kvm_host.h           |  3 +
 arch/riscv/kvm/aia.c                        | 51 +++-------------
 arch/riscv/kvm/aia_imsic.c                  | 45 ++++++++++++++
 arch/riscv/kvm/vcpu.c                       | 10 ---
 arch/riscv/kvm/vcpu_timer.c                 | 16 +++++
 arch/x86/kvm/vmx/tdx.c                      |  9 ++-
 arch/x86/kvm/x86.c                          |  4 ++
 11 files changed, 180 insertions(+), 70 deletions(-)


