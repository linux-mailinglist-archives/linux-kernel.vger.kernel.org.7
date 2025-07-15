Return-Path: <linux-kernel+bounces-732609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D3B0697B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534AC1C20C17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21C2D1920;
	Tue, 15 Jul 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykAuxHoz"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C217BA1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620265; cv=none; b=oojpWrf9Jbuin180Skfqp3+BHRmLjeCOB0hG9r+m0pWhJP0dqDRpOxYNxkqFB3NMgSXbC3deWVI4slDgra2rG6JAn+L8kefsplfrz1Aa4gKX4ZhxhpB6HCYz83e+4FkS8EAjvAhotEWfAXbhJ3rPrlP9z08PKf3rooCAHcrAeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620265; c=relaxed/simple;
	bh=G1ncFmWqHiHwP7omxWzFU6wr0dg9BZPf3WQI0K2rUeM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VTuE66xPQAJKQbGonTnepUlOoDHRc6t6K9XJtx1nyCg72NfeyvyUm7cormTXlDbzJGm13vOryFNUyau1PeFOluQysutz4FUX3LuMGO5YB3zyXaRU5GtFP2WG82O3Gm1RIljS8MTR73LhTi9IHwGE/OE0vE9ZRBCsMS+G9bT0bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykAuxHoz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso5341989a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752620264; x=1753225064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02v14PG2SlJYKfKrfbG12osm5mwtOvoFMeYGogboA68=;
        b=ykAuxHozP6AdbLAH2fgdG/BIE42mvqrmgVWrjjCB3mMI1tnfJJrcDLRaFsCtggd9o9
         czPqwujiLSoBoWmEP0DW0k7zk7bg76l+tojNhea0/BVsngIwCiG070D/9uJJxVaZIi/e
         80TCjVarihp+2eASoCiZ6Ir5lJycDKj1JUmao0R3hzk3gie5VKDpUwMFtDOTgdNkX8pM
         6Gq5HnR9UfIz7u/AXWLGxyJ5GpV6BaI2Pln00W0nOMcUocnjLSa0T944Vp1Wg++VYmoe
         QiO/71PfzQGkFZODThrhlGmBlpt0fXehAKHjdu+YldbvxlE1MTw9UUfZ+mdCkeT5Vv0v
         2CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620264; x=1753225064;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02v14PG2SlJYKfKrfbG12osm5mwtOvoFMeYGogboA68=;
        b=WXa/MdQQzfMwo511OIdoIE93R1LzObDv8DCuAOevrn6i8gMgVD8iAOliTfGFHBEHve
         biWGsNh0/NXpSKQ/YEnsEHIIYcYLrrFxXun21pR0/PkjIGaa4gUMM8hqhKruJGuCgoYe
         TGKD6lDhCNnPH+euJXgkuqV/geyz/Oi8sHTHqBSR82K7gGrg4BN264k7tX+2GLFXWMBu
         Sj5l1Q1DswcFtrzgnuFC95QaPHnJKW66+ZNhkezgT2wDP5zFZBhYB9wSwNh5oit0+okI
         LBeegHgjXQK9W4v4is/DEyYAmuegPV2XdzcspQWP8AplQ2An3dKQTTcIDs9kwSuG0ClL
         Ua6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGG9/z+mbA5+xbkm/lCSC4YG8z8iTfmckJkEE+KAZ3PRhaG2GBiiZ6iX8Ps/ti6OEWPWA3TuRDnmXUGBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XmAvHcPgyMkPYjYOrCF86ACdUaUCo6+C6l3ammrvocvOVx1N
	AMUWzvcY2WG438FIEQj/cOhmqGJ2nLA7j9lqxjg82MKFxGMwyHHa41vL1ojDucQ03gmtwaSrq0y
	FgmiQv/EzTQiqkqDSDSHtSTZF2k0Mhw==
X-Google-Smtp-Source: AGHT+IFmKJQBRdaQUFmCTWk9rJ+t8UKoGImBBOF3tHsLyMLW5hYcabvIQuRaVHMmT0fhN+zjD/JrNn7PN0vOapR7eAc=
X-Received: from pjq16.prod.google.com ([2002:a17:90b:5610:b0:311:485b:d057])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57c7:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-31c9e75b966mr1351563a91.17.1752620263599;
 Tue, 15 Jul 2025 15:57:43 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:57:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=samitolvanen@google.com;
 h=from:subject; bh=G1ncFmWqHiHwP7omxWzFU6wr0dg9BZPf3WQI0K2rUeM=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlld+59uP5AfIa1edjR3s1vD+T5vwsrP5j1IL9s+9WT4
 evlvafu7ChlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQAT0U1hZJi2ZtrNywfe7dZc
 +775SuDe+ROv3bz+v7Lij5f9v88RsZuPMjJ8zEndNHVF9Wudz1NKQx9Mrtt2busPpVmHBfJjIix qj/zkBgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715225733.3921432-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v10 0/3] Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

These patches add KCFI types to arm64 BPF JIT output. Puranjay and
Maxwell have been working on this for some time now, but I haven't
seen any progress since June 2024, so I decided to pick up the latest
version[1] posted by Maxwell and fix the few remaining issues I
noticed. I confirmed that with these patches applied, I no longer see
CFI failures in jitted code when running BPF self-tests on arm64.

[1] https://lore.kernel.org/linux-arm-kernel/ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq/

Note that in order to enable CFI for jitted code, we need to define
__bpfcall in a file included by include/linux/bpf.h. In v10, I'm still
adding an include/asm/cfi.h header file for consistency with other
architectures, even though the file no longer contains anything else.
If you'd prefer to move this to another header file, I'm certainly
open to suggestions.

Sami

---
v10:
- Rebased to bpf-next/master again.
- Added a patch to moved duplicate type hash variables and helper
  functions to common CFI code.

v9: https://lore.kernel.org/bpf/20250505223437.3722164-4-samitolvanen@google.com/
- Rebased to bpf-next/master to fix merge x86 merge conflicts.
- Fixed checkpatch warnings about Co-developed-by tags and including
  <asm/cfi.h>.
- Picked up Tested-by tags.

v8: https://lore.kernel.org/bpf/20250310222942.1988975-4-samitolvanen@google.com/
- Changed DEFINE_CFI_TYPE to use .4byte to match __CFI_TYPE.
- Changed cfi_get_func_hash() to again use get_kernel_nofault().
- Fixed a panic in bpf_jit_free() by resetting prog->bpf_func before
  calling bpf_jit_binary_pack_hdr().

---
Mark Rutland (1):
  cfi: add C CFI type macro

Puranjay Mohan (1):
  arm64/cfi,bpf: Support kCFI + BPF on arm64

Sami Tolvanen (1):
  cfi: Move BPF CFI types and helpers to generic code

 arch/arm64/include/asm/cfi.h  |  7 +++++
 arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++--
 arch/riscv/include/asm/cfi.h  | 16 -----------
 arch/riscv/kernel/cfi.c       | 53 -----------------------------------
 arch/x86/include/asm/cfi.h    |  9 ------
 arch/x86/kernel/alternative.c | 37 ------------------------
 include/linux/cfi.h           | 37 ++++++++++++++++++------
 include/linux/cfi_types.h     | 23 +++++++++++++++
 kernel/cfi.c                  | 25 +++++++++++++++++
 9 files changed, 103 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: e860a98c8aebd8de82c0ee901acf5a759acd4570
-- 
2.50.0.727.gbf7dc18ff4-goog


