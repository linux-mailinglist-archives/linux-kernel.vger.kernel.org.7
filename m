Return-Path: <linux-kernel+bounces-772463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B0B292FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C91B22592
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8E1EFF96;
	Sun, 17 Aug 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Oi98nZUz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12B1CA84
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434023; cv=none; b=lBqIxUUwPEFhzhLxOMTAgBzEcfBVbFs7Tkzgsp8IPQWTTdis+/mOgInPCh2P49BJy59TTRk9BIP2VLjI0xsJZwOZ3n29WE7RK0vLEDjbgk6zwU1znM97lRXDRM/+gVeZjTd4gz6VbCMhVLeWK86F/HfH+phXWGNkvyvYwU3gHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434023; c=relaxed/simple;
	bh=ECKA1N0ozZJky6qyb2l/wy6+UK0bWtlFcU0qrSDIIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UX5N2Tz3e0qPxrsYZKZ3DM1CVRoIRMR8sAFD+qicmCYKZUthuKOs8yJ0EXLuijsgBdl9JVRMkedVKRFnQQD44uJ/7safy3lBKiisZoiHmtbVek28JFlya1vODeX8e3L9VSP1xVU8FfmiF+1pxrtQtUZRNrtwJ5QQ4cqeSN/V6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Oi98nZUz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso2916393a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755434021; x=1756038821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WbiJIeRAyXPasTR+StFJQvgx7M5MTQOS33x2RRGox8=;
        b=Oi98nZUz3eFNu6StdJOhD12R2OhNoCrURlEhYdQkxKC5OaV6aV8jhT0lr32WEx11DA
         UQOZvYVP/UkMFehC9ZosdQN9Uw4U4V0ccpvZyL0jxJfo0Fc60By5nB3pEysZTUq2U1o0
         LUDOowDwSPNSjlqrefxDghYkSjijpxTa/xpmigKWZqTr7WnuLFn806/6eLoGveWO2bTx
         cGbda4Wl2Wa0nuA/0s/vC10J2WPluqlYxoI8Sp095mXdnzR02rWXY5SVJ2Hg7oi/FgmP
         hATlvHirGYWAtH4BFJWCOKZrFWnJrx1iVhFbPf3Vc2OiY46yCxSekMcU3nmlCKC1u3FS
         vOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434021; x=1756038821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WbiJIeRAyXPasTR+StFJQvgx7M5MTQOS33x2RRGox8=;
        b=NROlXHUwnDKuRw2S5cVpPirnG8UVj7r9pEhUET33M7bionJsQazOjqaa22zFc/mCxq
         NrVjPnRPV9+gNydmxTTW9N9G3T41P6yr77OdZsgDOJB8eVJgJ9sef+qeiZbDmYss+vS9
         GGE7PIX6+ARir0NgR/8alyts40f/GFCUwpA+ScSFcXC00It0H+nPJJ0TjiRoL6A+JBs2
         mCrkFem/2WbFh9jR3BMM6brpmsAjMv3dn/hDprcERdXAvys41L7XTuEcE4Iri+v5oqYe
         z0X3PnuYoXTmFTefw/O/w8tmtebiFhONe+19L0fnCO7SHM6Fzzka62h28JNGftLSTUxF
         Yepw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5oHsX3XH5V25Z//hDQIMOizzNNCeY2ZivwlT9vt6CKf+0dCn6tgbYcJ2QvbujnApRPHEI6inXCRGNMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmqZVJPrmYjcq4j7BbP/tXbG/m3Id+JTN6H+V4I7f9F/G8skv
	H0ZI4rfa1zU09+5bXOfebVeHHynSU7HF3D/vb0pOLo5fhGYnDaohwJ/NJYHnstniJzohbLgLLXy
	iZ3Op
X-Gm-Gg: ASbGncvStH7nZAM6NqGUC/ylPem2a/svFnCDxGzVyNrIo9EN5QsbZXJe6E2tH23Gz/h
	cwjkY9tJix+aiiwm3VtCnlF7UJ3woTBWx41PUBdLLBkZ58KdQYf4UBssXZMblqgQ4QeTPTAJV++
	AQGoX7hjQ5zFheSi3Opm69HqUiDNYXzwYsCpf1vCiPqG332urOWwxhFrOa+RXotwM2GDI0PjR5N
	h4YqbAOOCDS2AjQTPuMkIh+e7PFQ5vyY8/ULmx36j/Q+xcyrbfkXRUWJm7zQVN1h0cjxck0SMKl
	02JjpJvJ8SV5kwU5NjxUw5jO/tWCxScStRV+xDxwJj0kbItKZ7IBd3hNXId2zFN+iw4mAbrPQEE
	jVcZpgjlGbrX5smpoaFLAij3bLMjE9ocw8A0+qmrQc49vOr9dJaLZ4NnR+4RMb+fBwA==
X-Google-Smtp-Source: AGHT+IFVbDDjII11gSvR9Q4jewkTQtbKL3ViUFZFZq0yfpKxvIKgRxHNfx519E/5M9iV986Io2UJ3g==
X-Received: by 2002:a17:90b:3c8c:b0:320:e145:26f3 with SMTP id 98e67ed59e1d1-323296f24bdmr20313460a91.8.1755434020703;
        Sun, 17 Aug 2025 05:33:40 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm4480912a91.0.2025.08.17.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:33:40 -0700 (PDT)
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
Subject: [PATCH v2 0/6] ONE_REG interface for SBI FWFT extension
Date: Sun, 17 Aug 2025 18:03:18 +0530
Message-ID: <20250817123324.239423-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_kvm_fwft_one_reg_v2 branch
at: https://github.com/avpatel/linux.git

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
 arch/riscv/include/uapi/asm/kvm.h             |  14 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +-----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 ++++++++++++---
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 198 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 ++++--
 .../selftests/kvm/riscv/get-reg-list.c        |  28 +++
 8 files changed, 433 insertions(+), 127 deletions(-)

-- 
2.43.0


