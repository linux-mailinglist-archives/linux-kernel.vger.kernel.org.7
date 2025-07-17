Return-Path: <linux-kernel+bounces-736082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A4B0989B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162A04A82B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35924110F;
	Thu, 17 Jul 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giSwBrAT"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26521018A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796076; cv=none; b=sSCgV9lI2MWQiV6lKwcnsddlgFHgZ4jBYyZRj1tSGKlMu9JfFq4V7dAkeUu/k826aJFHVAfRB2TjqtkEU8m/WcHrxcy3VThz1OTis9F+5GtrNkPy2k5aczAroJWYtBKPDLpG723loqqmN1fDDUAE/cI8bqoAfK9ErlPl3keXp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796076; c=relaxed/simple;
	bh=YfBJwVkYLvQOLueRsR/wcaFjpSy+ELcV2uV+QwS3pJw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lfHVd2U7nRQCclQOOcMzeV/LFp6Nbazys2YI//Y2Y63cXdBQgHngjY7v5BD8bow6+k150bgsKLxtgIfM28NgjcYne/l5C0XSIA1+jXRel+fnUfk3dig6WhcIQny1Vn2+POZ302M3l3uzw+OqWEX4fomfj4xnzCvU4yxtpYiHKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giSwBrAT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so620520f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752796073; x=1753400873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmzLbnF2j6dVJaKPwtlQ/Mp9hl4jymVmhheF/GFsdMM=;
        b=giSwBrATtCKivQ6h7tL+lo6dydsID9V0pntkmxZcJnECAG+JXf9yBRK7HQGVPwDKCw
         aV5EmZ+V/8ZhY0QguoPxUKBcbnc0Y5j/uzfV71x5nYmFV/qU5l8/en/EsCPpKNVXqDbA
         3OX/j0OANy7EyA76LUr0HAAR8LN9qmQqOjJ0HDd8fTsOfPCqf/B9N1C22evoyabI8FI+
         9vJNg589rleszxB2+EDfxhD/IxkdWb66ronmvYaDqtXRTvmde4UGWJq66jQ6JuRSmM6s
         tQwOk13QYUrXHhUeD65cD1uq1CpB48QMM9GpziDUHCz5VPA75a/hhhkpsHV7oz0OENtJ
         kIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752796073; x=1753400873;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmzLbnF2j6dVJaKPwtlQ/Mp9hl4jymVmhheF/GFsdMM=;
        b=YzdxjrF0bu0sQBIqeOQw6nCtisfE2EYCRovIVYhqmemnJqPpqWsrM1kbRAWBKTMl/T
         tbXkFDBL/8+zmeytHW1E1M2d2rxKzm7mciyPEFa+WLcE1X243DQFrOvCSWo0ICH/1gNk
         gu/zxfEwQqzePyk8XCg7YvFPIEnV/WxJO9mJG5sZmgPULIvnWajO5fYVBret3TIozWbq
         MxH0/nsqQKoDSXpjBEIyNruTUuHdbpxGDnCVnTdgsoNDgekrF8MHvyvD++VaYbohghlj
         /+VaWIXTYRBuldQKxseH/ouwjKjvovZTUW1JpY6aH+/Q138ciWUS8kkFUQwMN1DuoeNy
         8PZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvFqSsolVc3Bh3T8N00cA1RH84/0MC/qqltEIastQajfnkGBa5ECY6wFygta070KYuP8njEKPiu3NrWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdaGgZCkugI4n7mZXwonV3sMvaVKaYJVcVfDJBgbPdjY99V6Cs
	9kTvrcPUdGrKVRQftUwdt7LbCbl//9E+iehcRvMDC2DL4pMy8SjJKEQkuqHFo1xztI4fH79wSiA
	ELjkdGlqmGThNGw==
X-Google-Smtp-Source: AGHT+IGZHRkGEI95lbs1FRrqgy+02r8k4XIFuVIZqzJTu8682nwwu/iFMxnvp6lbNsckQkII7hCCWDNCPJ+Z8w==
X-Received: from wmbhc26.prod.google.com ([2002:a05:600c:871a:b0:456:245b:44bf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e8:0:b0:3a0:7d27:f076 with SMTP id ffacd0b85a97d-3b60dd651d2mr6895573f8f.2.1752796072756;
 Thu, 17 Jul 2025 16:47:52 -0700 (PDT)
Date: Thu, 17 Jul 2025 23:47:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717234744.2254371-1-smostafa@google.com>
Subject: [PATCH 0/2] Dump instructions on panic for pKVM/nvhe
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, qperret@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This small series, adds support for dumping the faulting instructions on
panic in pKVM and nvhe, similarly to what the kernel does as follow:
[   12.012126] kvm [190]: nVHE hyp BUG at: [<ffff8000811c5f64>] __kvm_nvhe_handle___kvm_vcpu_run+0x4/0x8!
[   12.015747] kvm [190]: Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE_STACKTRACE
[   12.016044] Code: a8c17bfd d50323bf d65f03c0 d503245f (d4210000)
[   12.016082] kvm [190]: Hyp Offset: 0xffeff6887fe00000
[   12.016325] Kernel panic - not syncing: HYP panic:
[   12.016325] PS:204023c9 PC:000f8978013c5f64 ESR:00000000f2000800
[   12.016325] FAR:fff00000c016e01c HPFAR:00000000010016e0 PAR:0000000000000000

This can be useful in debugging cases of memory corruption.

The first patch adds this for nvhe and CONFIG_NVHE_EL2_DEBUG which is
straightforward as at the point of panic there is no stage-2 for the
host CPU, so it can re-use the kernel code to read and dump the faulting
instructions.

The second patch adds this support for pKVM, I splitted that into patches
as the pKVM changes are more fundamental, as now the hypervisor text would
be mapped in the host stage-2 as RO all the time.
An alternative is to make the hypervisor read its instructions on panic and
passes it to the kernel panic handler, but as we are out of registers
(X0-X7 used) for the arguments we would have to move that code to assembly.


Mostafa Saleh (2):
  KVM: arm64: Dump instruction on hyp panic
  KVM: arm64: Map hyp text as RO and dump instr on panic

 arch/arm64/include/asm/traps.h  |  1 +
 arch/arm64/kernel/traps.c       | 20 +++++++++++++-------
 arch/arm64/kvm/handle_exit.c    |  3 +++
 arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


