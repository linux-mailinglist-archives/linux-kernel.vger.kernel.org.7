Return-Path: <linux-kernel+bounces-783156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538DB32A33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52891680CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FDA1E9B21;
	Sat, 23 Aug 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DAwdmn+Q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534F2E888B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964803; cv=none; b=MKc2wTce0jQc3hddiOCEBbIdSv34LTpUaxHo6Aeq+o4rMrYj6HHb3fo9juTUfasqqCS+fFEJUBLUGphDSEOnjJCh7sWV9M0o25jwQ+WMq4GZUvKRNGE3x2nVnbcXzerPHV8V+EUecuVrxpHCzR/yMAFI7Czh7SoiT2vFYcIKttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964803; c=relaxed/simple;
	bh=dK+CR3Hpw7kGgKQtXxubea1aCAm20tR0xK1kEUaSbEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf9fMxCWB6AWQ4i9a1Cry0b8mCCPHqFh0AVTeroPConB+dFeHFLt8PakpcIVHZybQnOts1AFulhPkRCYqWSgMXSGUcEaA1B+5GauuAHx2Xt+E5KRjQL4/4UaBNxyTLJH7yW8NucMGHkONaBTm52yq2WRJlDONLkpZ+iEOgAXaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DAwdmn+Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2744434b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964801; x=1756569601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H24QVG/T3cxixN5Hjl4PI98/BCvc+2mgYT4CjAn1N5o=;
        b=DAwdmn+QCIub+wf1aZmp/lmq0EDc+wYhJLul6JPZyMaV+fo5gzKKZHXq6UpLu7X2lk
         JDwMStIX87HbFPsASqH1M+k0s5uCa3NNbgKMLx/vu4cptnXAEYL6+v6y8sSOKdLSLTJc
         6jY3y4brA9v8TsLZeA0Xg/l4Yvce2yGtkVhhmOf47IY2S3WXkrHHAHP4OATI1Ik16rQE
         BVRtXDtviTvEjOVBEAHLMbH20EptaavlhhVbDr+kaaeMlYTP3nH9I5RptYHyx7iFxarx
         t933K4c7T7YYNhrUsyA1GSVJg+mlWDyuY2UshqHVds4/+T3jYEDpxfFggz7bzw6c9RLL
         8bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964801; x=1756569601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H24QVG/T3cxixN5Hjl4PI98/BCvc+2mgYT4CjAn1N5o=;
        b=SK2yR8rz+k47ssfciXwmi5DJ1NLfv3Mtsl9GuJszLXEbRA6cw0hsN91LvuSRmaAQPu
         0nWP7qYS0pFkRU/bLzKS+gg4+zslKFp4FoaTirCUZ1er0qXwMBcRmmk/erxsow0jIP2L
         RysDKL227g3oWHUMUxi0EODbghMHzMSG+JfsEgIy3UMsJs2Dk3WVcWbGb1tUyTfuNcFv
         KMNkMPVsvAJRejerUNWUYNbZk4vMG5ZeESOXjXcuGx33dVeqQJtF2evwuMgmvM2ukyoR
         jJqB4NjyPyRzMCesdVtQOymet6PwOrBqK5/G+kbq9DbGdt8zjeS0evXYRC+T3uoEDdLH
         DP6w==
X-Forwarded-Encrypted: i=1; AJvYcCUr2y21cS6wpqPDEZP2bdAibbgvJcdHxmSJ0/b800ntCwcUQWspNAObckSd2CqoX1+I2wuO3FPVQiywq+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAaQGwTPw3vlkb5LUG2Ip1oZWyEOo3wMVbq9NZd+TYN8n6gPC
	P7JAzUQ/Te8KdQUanC6rxcshXCarUEjoMtaxaNMWD+Id0Y3ySgYb3AbDJ9+ZT10Js8DwrISkNUu
	2aKmG
X-Gm-Gg: ASbGncsYx6E7+PGNTyYQSxL+37X4g2hpZd0jKqzzyK9RNxtVb66YMy35xA5Rww1OBgK
	4NkEPdIfhHKaUQw9+e6EQiCKh09SFsj/D/pFvEl9Y76vAZQT065efbAtajmuEjlyCw9PGQYs25Z
	sxgJVh11E/aRupWHxoda9p87gwL/+tQX/ea53QH6zYPNvLaLoLc8OX2hjNpBXjwq5iKao2RantU
	t46UFUDNmmYs2ThCqe2Yge15LnYSUi3syaYUvlQW/BO4ROL9Ee3rIehAgTfsN+GY2x5Fnb0SBBT
	I7N0QB6Wo8UkyZ3UZrITVpv+2TN33DYvooUoqcC9s7xRlye00BrHaqaq9OCj+Bl8+CJ1MwWEilY
	DvoRBwylVDcs+qngu6KyiTX4zH5JeWHCCxGadZY7YfYdO2TCLZmpc6zw3JXaBkm4XMsNmhEr0
X-Google-Smtp-Source: AGHT+IHHBn4yz0Tv2mtxye/b3d+njwhsYjSP/E2IAAVTTBKNql/cK/uY7eFReM62Y2BttpdFYMcwWg==
X-Received: by 2002:a05:6a20:1592:b0:23f:fe66:5d2a with SMTP id adf61e73a8af0-24340bce2c1mr9575921637.27.1755964800673;
        Sat, 23 Aug 2025 09:00:00 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:00 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 0/6] ONE_REG interface for SBI FWFT extension
Date: Sat, 23 Aug 2025 21:29:41 +0530
Message-ID: <20250823155947.1354229-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds ONE_REG interface for SBI FWFT extension implemented
by KVM RISC-V. This was missed out in accepted SBI FWFT patches for
KVM RISC-V.

These patches can also be found in the riscv_kvm_fwft_one_reg_v3 branch
at: https://github.com/avpatel/linux.git

Changes since v2:
 - Re-based on latest KVM RISC-V queue
 - Improved FWFT ONE_REG interface to allow enabling/disabling each
   FWFT feature from KVM userspace

Changes since v1:
 - Dropped have_state in PATCH4 as suggested by Drew
 - Added Drew's Reviewed-by in appropriate patches

Anup Patel (6):
  RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
  RISC-V: KVM: Introduce feature specific reset for SBI FWFT
  RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
  RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
  RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
  KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  22 +-
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |  15 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 +++++++++++--
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 227 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 +++--
 .../selftests/kvm/riscv/get-reg-list.c        |  32 +++
 9 files changed, 467 insertions(+), 128 deletions(-)

-- 
2.43.0


