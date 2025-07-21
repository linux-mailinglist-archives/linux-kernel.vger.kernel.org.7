Return-Path: <linux-kernel+bounces-739834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E63B0CBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4577C1C227E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43E23ABAB;
	Mon, 21 Jul 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1to6bqT/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59519CC28
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129226; cv=none; b=gEwpi0So7wj151i13V+xA3pNVzemMeww2KDLzfhNLqr4i413B0Kzbd3MnpE7ZggY1/WA+14jxPeG/fkVYHv6QmYwijDZspXcImIIdapGztwb45Ut160WS1vwtvoZZqdWjhLVEHX/TraxXWLc6AowqKLnEXLoMA7FeD4cLXc7D44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129226; c=relaxed/simple;
	bh=nmRM+/K9lsvx+cfQiTy2X6pWzToLBg2bXj292tXDDLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/f1E8TSH9AxQy39xyqS6vxZPotl63XK8AzpM6HWQGkJSf3yGtlVfdFo2yUBY7NFHrE/0OMADNVBqKBV4ybXUPmxKlHhpd83GQXOYIkNvXaGUG5xzdG7aqbeH7ACOgWbDuJQwIH+STApqQsYPCrYUrWbpjEiNZYNqSODQO5SMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1to6bqT/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso4031668b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753129224; x=1753734024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5URmPbI+yXwjAFPr5JsI+gON/lvzeGrovPf0DF9nF0k=;
        b=1to6bqT/eqIAfoCXekrDTVAqbbIcT/ydWWOXi6MjpWq5HuWOdkEbRawon3VAFvd6tJ
         G6G/ghaHYog1B7tSY+xye5vQltvH3UziIyxeW4op1DerXWkueae3LzrJGQLI0qUvw9Pe
         h+7kk2WH7ChMrG848NSyB/PZ62HVrqUl+weFP26fWhkRd3VHTh84tg3NyYTWwCpgcY23
         eWAYTSZtqGOTmhxxKcMeWfYdgCftlaYUKSf2VI/gOK7TaDtFKlg7Kyk6oeugYmUdYKN1
         VW/AjJnNNQgHuHiX48FelqsmM0XiAU+sJ8JMPA+Od+Pn2Fc+juGwYkRW6+V8E1/MC4tC
         vdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129224; x=1753734024;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5URmPbI+yXwjAFPr5JsI+gON/lvzeGrovPf0DF9nF0k=;
        b=Z8mIIhV/kf+tsbAQLBMF9GHR6EmAhsSGbbyfabwkNeKsT+0pzswDMcVIgCfHF1HPwm
         GsDtyVlwqoXRL7ldVQgKm4zWYzsHVflRnsp5gaaA6Azs6mcnpSMRMmPfo1XpqBxKMxBM
         1X/FgWzE+tDkxYmLGfikgW+kbw919Uz0YzpAgnKZGsC8YNPHCSvywZqzH3Ga6HGmPSsZ
         xoe7ryUuMNcE03+UZtanB5aulvqs1dfI8t6/BLlEbfUYM4JbL0fOpswwXuTl6lzfzFAi
         lYjVBNNkQS6R+ZD7zHvhzmF1/3LotyruSZeFKN/iAwJHmiNW2fXv1wHBTuVkrkD5MkdV
         7TOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/fT9YJSbalDSADAbCJbBpkR5UB+/jbxej34sbmM5OIHUeqcNANA2qq/Yxqp1mtPGFvI4YHmBSUiuVpJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAxuY0BCIZVdO/WxBGIh/V9HvJoWfDltP+46+UcNlqd6Pqq1H
	Yob4TIasruAg6/Jk0YIU48Ixe7fSGxM8x7bghDQR+EINPvFSiRw++kJfRM6A/3p13domlGCZysY
	hDaIwJYE3m2w+cw8MBX0dtKutUAQe8g==
X-Google-Smtp-Source: AGHT+IEYmVmBICKXXFbKLwFcHwvPfE4Z/rxChV+mTLlOehLzanW0f8Wk0LDYggKhH+apLrDCa8KwXOPPUeDARk0kl8E=
X-Received: from pfbhd13.prod.google.com ([2002:a05:6a00:658d:b0:748:f98a:d97b])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10cb:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-757242790admr26793970b3a.16.1753129224376;
 Mon, 21 Jul 2025 13:20:24 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:20:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=samitolvanen@google.com;
 h=from:subject; bh=nmRM+/K9lsvx+cfQiTy2X6pWzToLBg2bXj292tXDDLI=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBl1C/4LJ+fozz7Y9+jWl0v/HguWn86WDNBsXOxpabT6T
 VRaooVPRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZhIrxnD/8K0KX5p9vtz90qH
 3ivkFLTYGHz20v9nXTLyzVNYliwKvszIsFFn0tGn0nwLt2ok5kxdneSvpB3ZUxMWdmzJ419qTl0 fGAE=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721202015.3530876-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v12 0/3] Support kCFI + BPF on arm64
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

Sami

---
v12:
- Fixed sparse warnings and 32-bit ARM build errors.

v11: https://lore.kernel.org/bpf/20250718223345.1075521-5-samitolvanen@google.com/
- Moved cfi_get_func_hash to a static inline with an ifdef guard.
- Picked by Will's Acked-by tags.

v10: https://lore.kernel.org/bpf/20250715225733.3921432-5-samitolvanen@google.com/
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
 arch/x86/include/asm/cfi.h    | 10 ++-----
 arch/x86/kernel/alternative.c | 37 ------------------------
 include/linux/cfi.h           | 47 +++++++++++++++++++++++++------
 include/linux/cfi_types.h     | 23 +++++++++++++++
 kernel/cfi.c                  | 15 ++++++++++
 9 files changed, 105 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: 42be23e8f2dcb100cb9944b2b54b6bf41aff943d
-- 
2.50.0.727.gbf7dc18ff4-goog


