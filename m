Return-Path: <linux-kernel+bounces-769241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CEB26BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8178F5A18AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B2F23A99E;
	Thu, 14 Aug 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OPd0CK8Q"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305D204096
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186962; cv=none; b=IH+Ak+8En7lesiGZ/JdoeMCg1gpnIvpUD7MrTUeGHC9maS/vfCYWdBQNpRSDHGcAQsG7XW4z67J7y5BAy8JcFUEvGKKBRHS8OCN4pTUqqGuJ22zUfrhTCrvAG47wWj+VXpvcpOo2yg2aYghuFXZM+UWCTalMMhzIPtcERM+gVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186962; c=relaxed/simple;
	bh=70C+wR2OGyGwLPTOfQiAUvSVN2h1Wr8pPgkJs2xIVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQKG+s3FmawCtgQimFZhjlGxBpQYJ4Mi1ureqgK+WG+C827Dwt7X0Lf+XcrDPk1I1KvVsobG9O5YEgJYAfpKdvkZjzvq6sRieRn0s7i2Y733Uef5+itVhwg/aoku4brigMju2Q03w9UGp5dWarQgjcHfSS2dKPhNz9AtV8XVc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OPd0CK8Q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so690881b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186960; x=1755791760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbS0SnSfDCYNteBkAugCZAVezW6wYeQqbL6j1Y/9w2o=;
        b=OPd0CK8QfxBK+Iz6vzDibyRg7ZuChu7DR7rK//4Nv/RQ7qolecyzOubtoE0nRYJc+6
         0anEDeZUj1/te+RkxC7ZxzVPkywOZomjdMdVPfNRgnRyBKmve1A1/GlVbIgwfwWRu01e
         yUySYWUibjQyQJzjCbDjRm4tNXOinbAJEbrpyimTBWOBOddOSfrpvha/oGbLkQ3aBaMw
         zeG9BbhoCztB06JfUJ9XDQo6CSI1SNFaFDzS2SfEUb0QZYOeY6jdUP0DzHdsyID/J5WW
         QkhwxZ661DDUTWdQ4mUzhu02f/vfG5p1hdV5XYvemC2Dl6jhAyy+aU0bbnjXRZYjJl4p
         TltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186960; x=1755791760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbS0SnSfDCYNteBkAugCZAVezW6wYeQqbL6j1Y/9w2o=;
        b=p/1UZcq0WeT0RRo1L0ZMmp6Y1JxNuluD1LkKpaHmZiWCZO4EIcgAAjCE72cm4ntcaq
         ijuMGi0hioF3zMT9Xe4O5mqCxhUR4MR2ItLOGai98eV2ntoYiG9EusyUCOmxQVi+duv6
         kK8jv5tf7A4aM9p6ceZxadXo9JnDy6nW8AwOcH3ZaU17epJmBlCuQO3uf1pd4TlNGM1W
         XbOTYpLby4XC9KprV3v4Ku1oFH8ESY8/Jq6ckG1M620SYdKf0zyioFrVB9umRbNnYLQq
         u32i1GMRFlx6JCNz/sNtKGD/iXSsGnti4NOWP9cr/6YIrZZGh4TYguolNjLmuk03KD72
         UTHw==
X-Forwarded-Encrypted: i=1; AJvYcCVKsQ1K6DEme303FXmh7eQcB9baMpKGOBAImU8NA9jlqHKVqGEn0RHkg/18LXTvvN5SJr8t/mk441wEInM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurFuL0h6cPsvrPZ5tIkSErGLM/QCF1GsJAHElphVH/gHVl2ef
	xkKBcl+D5l2tUuLoTDqsRV+r4mZPGiytelwYiqaXjr+V058aJALJMg7eAKGKXQaTnFE=
X-Gm-Gg: ASbGncuf+AKZHiFXIWXnjxVuI+80LuFEgGthz1Cc+0m0H++9kMGOmHCwSzoq+jAjBsr
	KK7wmGs4oK2aphszYYZFcjwawCO9uHyIFwW65Kik/vr/WqMsGWpuby0Q1YNomm0aUTf75kWCzDN
	48ZF8ozgvXG5valk3Olq38/uDWSb5jERXrENghMlsDDL0TdFmx8zCummj8EFDw5YoChT/0GTYaP
	XQPcZZthpe+Qb5gzHlzbaa4UoaxIpxvm2H+PTmRYaGZ44Ix1lDRI9V09RaUK1gef3T4Vt4+64DV
	EjRIY4gl0tapsP2g5oa+hZA3dCmtZO9aun15WKFFAnVTdaWfEDuDEe8oANVUlIb3OiSRY2PB3++
	S0yAo+6XBLiaJxqFjQrWxIcGTnx9l7lD/b+EeeYLqJqU4ZB83XYXj9PVrlxSj5w==
X-Google-Smtp-Source: AGHT+IHiJ/C+iotNnCA3DhU4+fNK2fePBsmUyymIcxaNYom/9E0Z1/NWwsgFdX4eBUWW/qEOqDpszg==
X-Received: by 2002:a17:903:1a30:b0:242:fc4f:9fe3 with SMTP id d9443c01a7336-244586a18c8mr55450135ad.37.1755186959600;
        Thu, 14 Aug 2025 08:55:59 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:55:59 -0700 (PDT)
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
Subject: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
Date: Thu, 14 Aug 2025 21:25:42 +0530
Message-ID: <20250814155548.457172-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_kvm_fwft_one_reg_v1 branch
at: https://github.com/avpatel/linux.git

Anup Patel (6):
  RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
  RISC-V: KVM: Introduce feature specific reset for SBI FWFT
  RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
  RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
  RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
  KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  23 +-
 arch/riscv/include/uapi/asm/kvm.h             |  14 ++
 arch/riscv/kvm/vcpu.c                         |   3 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  60 +-----
 arch/riscv/kvm/vcpu_sbi.c                     | 172 ++++++++++++---
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 199 ++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi_sta.c                 |  64 ++++--
 .../selftests/kvm/riscv/get-reg-list.c        |  28 +++
 8 files changed, 436 insertions(+), 127 deletions(-)

-- 
2.43.0


