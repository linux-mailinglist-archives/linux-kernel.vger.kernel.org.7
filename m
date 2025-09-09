Return-Path: <linux-kernel+bounces-808286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0107EB4FD92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072403A6D08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF727343D76;
	Tue,  9 Sep 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzaxC4sU"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2534572D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425006; cv=none; b=K04B9wInkyPKKqB0ifVQz5fErMppd7YqW+k2dsrA4fjIXK26Q6ehAfy9lMU46THZxv4LfvaxmfjZgRBaJFXmJWyqKPcJpmNUN21zeJZex+zFCzOzYyc8YEJvQGzC6zBqPS++HabDrOvRikSrFnTO3xZcw7LG+Q/+7TuvriUhP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425006; c=relaxed/simple;
	bh=Sd1/eFtlqfVnGDzrsFftGX6iSgfIswDupnKqB8D3kFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cP/tFRwAXz01i6mNfEDgKj8+ky5w/c/BegWCCGgAtDsqf88PXIUmXhbTxerq++sViIe3rq0aKqQXzjF+wBKYAmjtf5JWji2IavqOLr2moUmz0NXu6C/mn0BALULu9fDDA+hW/TYC3Pcyiqtv4icYZOzuiblhhV0zeACnm6UIa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzaxC4sU; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b04a302fb7cso298183966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757425001; x=1758029801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KajtByV00Jiv7Lq5klOsW6LBWHVxcYTPd9aKtLeCCjQ=;
        b=yzaxC4sUhCIopFTcjHqXcGFNltYoiJe/tfdZe737eBOQpS+3Hp+iNN2JjfRldjgisU
         rSwH5RTwH5VTfQZ9pSlIvMRU4phLfQbsFCq4NCco43D0tBoND8mOcbDcQsHQcWnYmNDx
         JJ+0kK2il8Sin5RBcZm29tcvNWyDKGmc7FT8248NBZ1gSCKuh0woE+Rlxa/aJsUXWvn0
         wSOc2Kl7HUJq8J8glHl06wVzqSMVnqjXPwSj070pZ3lQc2Zy1Tu1OhuOD3kgxCk6oP2H
         iqKBzit0zzNXyvgpgF7N6q4angnv1R1IguRii4llEV7io2nlIV3cppj55Jl75OTuXCWM
         grCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425001; x=1758029801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KajtByV00Jiv7Lq5klOsW6LBWHVxcYTPd9aKtLeCCjQ=;
        b=v5lUBcRcuUku/33AVSFWVm65razGS6tLeSpub3nol3u+B9cPgNyiYWhW0wJkElKlVM
         f2jG/F7/NM/GWpELbhSDq2Molc1ImPNwUlHoGLk/lFrL4lo0LCsGQfePppmlGv7/3KDN
         d7zKmvW/zRzs3qdQSpAZq6dbIoCwvO8MQs88Rx6s8JyVtpoQVfAQIewZe2ATt/OlydKz
         xQwQc7JNWA1YOWDSwLTOvMqRi+L+GOIh/hQUc3/b9fWE1OjuEid6HxsBAoU9w3sQEnmH
         qLABAceAs8w6L5JjCY5XnajnjxWbCCP8E8U2X6RzGGWbhDebovQ4pKOyjV8ZvL/39Y98
         xAdg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ATVxUBG7xDSEQaBzXId3JLywJsmSca4QJ/Fa95dS+jsDKIebZzpiPFqtrazQ2FB5RDTPF4bD6u8lp8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4PlmbM7BAGYWwfKi4WArwvdngRaL6GHJ1+oXVNYzVlZExEej
	bdOg0dykx/2JKKTczZK+dLOxPyPrlrfv3jk98LUEBy8gLz4nQth3mcPa7f6tOTEQNdzI/giCTzo
	77UEYhrE+WETCgg==
X-Google-Smtp-Source: AGHT+IFqVLQR77jh2DKFIMEQIj5PFCy5tufvnMQYcv7fwo55KdSMKKQJ2x/wsNJRgC3/doxiiHv5VPKIl04qJA==
X-Received: from ejctk11.prod.google.com ([2002:a17:907:c28b:b0:b04:770f:8673])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:fd17:b0:af9:414d:9c2 with SMTP id a640c23a62f3a-b04b1403616mr1087102366b.3.1757425001267;
 Tue, 09 Sep 2025 06:36:41 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:36:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909133631.3844423-1-smostafa@google.com>
Subject: [PATCH v2 0/2] Dump instructions on panic for pKVM/nvhe
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, perret@google.com, keirf@google.com, 
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

Changes in v2:
- Harden instr dumping based on Will's feedback.
- Collected tags

Mostafa Saleh (2):
  KVM: arm64: Dump instruction on hyp panic
  KVM: arm64: Map hyp text as RO and dump instr on panic

 arch/arm64/include/asm/traps.h  |  1 +
 arch/arm64/kernel/traps.c       | 15 +++++++++------
 arch/arm64/kvm/handle_exit.c    |  3 +++
 arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
 4 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


