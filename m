Return-Path: <linux-kernel+bounces-723033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7AAFE202
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D48165661
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D92367B8;
	Wed,  9 Jul 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0BDy4EQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505321ADAE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048665; cv=none; b=UuhTxtXYLoaTXnL1KczQ5dIhIJkvz6BpElrxV9JVzQlTNh6/iRI+37cHguAijKeb9SmrnXX83Jc8fuDOF4SVpclhBk6sy99QjXynCR1TNyEOzszSpnqwUgdAkBoB+Kol2NU6VFIxXqn6oNWSdAkM4BTlOA29wCjXCc4QxsNidwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048665; c=relaxed/simple;
	bh=KjSASj9ZfsWXtJmCUSDj9rwnKu/A9EPjjLfueAKfOY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sZxQe8YFHNV9bymyXGdE4xWSiOjjRjmsXhh2QjP8mVoHqfkvN45s/mxecQy4NWiHv9SyJrxrOmuE7GQlp5PuMV499BV81NT+/ClLbkg2yQjLSx3iies0l0sQqGmm2X8ExhbLdAcJb3vrxhJMli4AlYbHPSGBrNmQMukw4sRnWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0BDy4EQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d30992bcso38478615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048662; x=1752653462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31/PvKLzqd7EI92cHr+X5IlPuKryr+LZx/u+muhVhNY=;
        b=U0BDy4EQkL0kno5uKuP3Bq8l5CQg6abgPpDqmY2TrjcEfhR6x7XdxA5Hg6iEY+8Z00
         ohVrpmBi1Il+Re2Z5JOYC4EBmwoxpc7Dkbo4TcV9oqdOth/c2oKaS8C5yba1bdqsmIRr
         ETCQ/ar9yTXtdIpEeLhq8r1c/cGI5G9SNxikjy3e+i3tFO0XO3Tqmr8gfBjdvOZjXShG
         sxuPyfHnaQqk6/xNclinAxemXlhg1o4EsBYUlYCDOEpMQOYarfjmHL1cbNX2ppVHvPBe
         u6z7wVjgcYRqsWGxpZ/BjU8CjEYKp4zxz4pFTNlnGYu1BKj6Dc5rgeoujJk8HVgREUlV
         AnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048662; x=1752653462;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31/PvKLzqd7EI92cHr+X5IlPuKryr+LZx/u+muhVhNY=;
        b=cB7a7xaU/wqn9+f1Xqr9i02isd299Q1U8ljTT54cwYqXvPcTGL9d8uxmIlxkWgC+Hd
         0M6wPpZFcIEVj+ulfe71eZcP3ya9RR7q3lv2/GqrLSerDsmc8AXOdmdtNtFMF/C2ny53
         eURBa5lDsM/Io1npcJuw4bu1z6GA22N6AC4oBkYqNr5EhXS/EPfQ6aHITr7gsFd04mt9
         4y7NQcrJr9lm7/BjfhLEjkgKtDlfBRCm/08/VLLMZlu1kCCkAZMlt+l8FONSNxmYpIo0
         hqjRjyNlBa7FV799hwgpQdajAGxFEuuiYI0eRQ5+DjyBsjgjLoXHDCqa+WVXAtopEkil
         tTow==
X-Gm-Message-State: AOJu0YzUy4ekecQELKDW5x6qHVGM4s6S0B2UwOngoaP2JaeM3TV77szZ
	Bqs5TUTPv7maEtFbL3FrqodJJQbNU7WW/S9Io5127F5P8ydrbuTaNsDDvMd2sDauIl89HW+WMRa
	7fZX5KBcn6tGnkwXosSs18q8YQq9NgMWV5AlYNkIkNcywGTMMYWZOIU73IAkTD/vYMnoM9KW7n4
	yA3ukA+KMbBkPJqPSolZmddJuYnX+yg/etJQ==
X-Google-Smtp-Source: AGHT+IFOu9EZpx8fcWBTeCvJmziWlJOrJsIZYAsl7X+HgcT1/Gdp/PSGEzgE2jt7KJwE9ZMibr423BVi
X-Received: from wrad5.prod.google.com ([2002:adf:a405:0:b0:3a5:8a59:e17c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2008:b0:3b3:9c94:eff8
 with SMTP id ffacd0b85a97d-3b5e4537eb0mr1050338f8f.27.1752048661644; Wed, 09
 Jul 2025 01:11:01 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7401; i=ardb@kernel.org;
 h=from:subject; bh=VuwLfYbTlAuktsTY5TEVVfMqiy6yq5GIka73gzMx1ko=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNPuaf+8LnH+dfmVpayvu27vVl6df3xtorfdxLrDJol/
 bV29V/tKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP585Dhn8a3+ZmK073//FBn
 T1/SIpN++6kbt7Dnw+cLd1gwGN3Xuc7IcHzP3o+aXfv0dWS3b6y8nnXpy8SH4kGKnYX28grTVim 1MAMA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-26-ardb+git@google.com>
Subject: [PATCH v4 00/24] x86: strict separation of startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

!!! Boot tested on non-SEV guest ONLY !!!!

This RFT series implements a strict separation between startup code and
ordinary code, where startup code is built in a way that tolerates being
invoked from the initial 1:1 mapping of memory.

The existing approach of emitting this code into .head.text and checking
for absolute relocations in that section is not 100% safe, and produces
diagnostics that are sometimes difficult to interpret. [0]

Instead, rely on symbol prefixes, similar to how this is implemented for
the EFI stub and for the startup code in the arm64 port. This ensures
that startup code can only call other startup code, unless a special
symbol alias is emitted that exposes a non-startup routine to the
startup code.

This is somewhat intrusive, as there are many data objects that are
referenced both by startup code and by ordinary code, and an alias needs
to be emitted for each of those. If startup code references anything
that has not been made available to it explicitly, a build time link
error will occur.

This ultimately allows the .head.text section to be dropped entirely, as
it no longer has a special significance. Instead, code that only
executes at boot is emitted into .init.text as it should.

The majority of changes is around early SEV code. The main issue is that
its use of GHCB pages and SVSM calling areas in code that may run from
both the 1:1 mapping and the kernel virtual mapping is problematic as it
relies on __pa() to perform VA to PA translations, which are ambiguous
in this context. Also, __pa() pulls in non-trivial instrumented code
when CONFIG_DEBUG_VIRTUAL=y and so it is better to avoid VA to PA
translations altogether in the startup code.

Changes since RFT/v3:
- Rebase onto tip/master
- Incorporate Borislav's feedback on v3
- Switch to objtool to check for absolute references in startup code
- Remap inittext R-X when running on EFI implementations that require
  strict R-X/RW- separation
- Include a kbuild fix to incorporate arch/x86/boot/startup/ in the
  right manner
- For now, omit the LA57 changes that remove the problematic early
  5-level paging checks. We can revisit this once there is agreement on
  the approach. 

Changes since RFT/v2:
- Rebase onto tip/x86/boot and drop the patches from the previous
  revision that have been applied in the meantime.
- Omit the pgtable_l5_enabled() changes for now, and just expose PIC
  aliases for the variables in question - this can be sorted later.
- Don't use the boot SVSM calling area in snp_kexec_finish(), but pass
  down the correct per-CPU one to the early page state API.
- Rename arch/x86/coco/sev/sev-noinstr.o to arch/x86/coco/sev/noinstr.o
- Further reduce the amount of SEV code that needs to be constructed in
  a special way.

Change since RFC/v1:
- Include a major disentanglement/refactor of the SEV-SNP startup code,
  so that only code that really needs to run from the 1:1 mapping is
  included in the startup/ code

- Incorporate some early notes from Ingo

Build tested defconfig and allmodconfig

!!! Boot tested on non-SEV guest ONLY !!!!

Again, I will need to lean on Tom to determine whether this breaks
SEV-SNP guest boot. As I mentioned before, I am still waiting for
SEV-SNP capable hardware to be delivered.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>

[0] https://lore.kernel.org/all/CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com/

Ard Biesheuvel (24):
  x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
  x86/sev: Use MSR protocol for remapping SVSM calling area
  x86/sev: Use MSR protocol only for early SVSM PVALIDATE call
  x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL
  x86/sev: Move GHCB page based HV communication out of startup code
  x86/sev: Avoid global variable to store virtual address of SVSM area
  x86/sev: Move MSR save/restore out of early page state change helper
  x86/sev: Share implementation of MSR-based page state change
  x86/sev: Pass SVSM calling area down to early page state change API
  x86/sev: Use boot SVSM CA for all startup and init code
  x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
  x86/sev: Unify SEV-SNP hypervisor feature check
  x86/boot: Provide PIC aliases for 5-level paging related constants
  x86/sev: Provide PIC aliases for SEV related data objects
  x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
  x86/sev: Export startup routines for later use
  objtool: Add action to check for absence of absolute relocations
  x86/boot: Check startup code for absence of absolute relocations
  x86/boot: Revert "Reject absolute references in .head.text"
  x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
  x86/boot: Create a confined code area for startup code
  efistub/x86: Remap inittext read-execute when needed
  x86/boot: Move startup code out of __head section
  x86/boot: Get rid of the .head.text section

 arch/x86/Kbuild                            |   2 +
 arch/x86/Makefile                          |   1 -
 arch/x86/boot/compressed/Makefile          |   2 +-
 arch/x86/boot/compressed/misc.c            |   2 +
 arch/x86/boot/compressed/sev-handle-vc.c   |   3 +
 arch/x86/boot/compressed/sev.c             | 132 ++-------
 arch/x86/boot/startup/Makefile             |  22 ++
 arch/x86/boot/startup/exports.h            |  14 +
 arch/x86/boot/startup/gdt_idt.c            |   4 +-
 arch/x86/boot/startup/map_kernel.c         |   4 +-
 arch/x86/boot/startup/sev-shared.c         | 313 ++++++--------------
 arch/x86/boot/startup/sev-startup.c        | 190 ++----------
 arch/x86/boot/startup/sme.c                |  29 +-
 arch/x86/coco/sev/Makefile                 |   6 +-
 arch/x86/coco/sev/core.c                   | 180 ++++++++---
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 +++++
 arch/x86/coco/sev/vc-handle.c              |   2 +
 arch/x86/coco/sev/vc-shared.c              | 143 ++++++++-
 arch/x86/include/asm/boot.h                |   2 +
 arch/x86/include/asm/init.h                |   6 -
 arch/x86/include/asm/setup.h               |   1 +
 arch/x86/include/asm/sev-internal.h        |  29 +-
 arch/x86/include/asm/sev.h                 |  19 +-
 arch/x86/kernel/head64.c                   |   5 +-
 arch/x86/kernel/head_32.S                  |   2 +-
 arch/x86/kernel/head_64.S                  |  10 +-
 arch/x86/kernel/vmlinux.lds.S              |   9 +-
 arch/x86/mm/mem_encrypt_amd.c              |   6 -
 arch/x86/mm/mem_encrypt_boot.S             |   6 +-
 arch/x86/platform/pvh/head.S               |   2 +-
 arch/x86/tools/relocs.c                    |   8 +-
 drivers/firmware/efi/libstub/x86-stub.c    |   4 +-
 tools/objtool/builtin-check.c              |   2 +
 tools/objtool/check.c                      |  39 ++-
 tools/objtool/include/objtool/builtin.h    |   1 +
 35 files changed, 632 insertions(+), 642 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)

-- 
2.50.0.727.gbf7dc18ff4-goog


