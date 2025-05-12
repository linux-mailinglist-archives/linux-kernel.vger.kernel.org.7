Return-Path: <linux-kernel+bounces-644786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE7AB4485
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C307ADB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03829826E;
	Mon, 12 May 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fiouux9"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C769296FD9
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077096; cv=none; b=OKk3petIb3IHAvvI0I5YBH/jNK37gJ8PIJqVB4x7eloBo96ZaTmXhp7vmK6u8bEpUfUjumAFhwJ/OGT8KJgl5i9z6UCxXRrcU+44hnP5roVS4nvctOJQGRVuEoPiA4SU18QxpV3ZPel52Kg4Yoj93EaboqEeUa+xm27BavU4t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077096; c=relaxed/simple;
	bh=I5SM/OjkTaqmrFoOteeEj+T8sS36ewGWOKu41BU5ZU4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eUVEcGp3AaLNwaLU7Cxkg4xSrFiGgcgJP8yzqgebrQdMVqp0Ua876nVUQ7IV99EFGp9BTScGkv0qKXg2SDuJwJl9occ9SDp9mrbchi6IhqpQT+ZI6oD1SQs5pv82H2BCD+ZxC5G0SL6XtYC4F+YL7uWK7Ek9KeeWoseMnB49VPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fiouux9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so33687235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077092; x=1747681892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0HfaLIwQRuqjl+CfFGBKAwVwb5cvGxYU7Yz1EOXVDE=;
        b=3fiouux9Ake1lJXIZA/qtdgKbWvpJbYZxrgHfdBjnbtDEWuSEdtQL0h6baE7Lmm1gc
         z8SBhTAyV4KI4mFXugTgnWMml6bvAO5ChQ+w7u/wdkCqNUM519kQhj6ajgMksNgi0a6O
         A/vqJVGUsmEHPaPFUu75ovYUo6JHCMnZ+YKgSiuKQx/m29iRleOfWmcjV6xDTnOe18TO
         dmUVbgzW1I9wziK7evcxBLrvjX2RIDI5Lb521hFaOydyjkEe9/SvRGKpW3BuQPKFjz+E
         eaxfZWuhL5HrpykpkdXOZKfkYyZ/FQqM6NwoL2uDMv2TS7zJvLGMOvRE7xhCrtZhjw6M
         bkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077092; x=1747681892;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0HfaLIwQRuqjl+CfFGBKAwVwb5cvGxYU7Yz1EOXVDE=;
        b=P6RJlF2bgUlvT1WL23qZmF/t/690Ogjy6VLq3BjXagm03PUxGQn79T+zBuqbAeBkff
         oont5Dc6Hz46ebvIMLi109yyOap253PdRrvVtJh5FGp2lhsvMLSI84v6L9f7eQcq8ZJi
         CX+f+/h3qKWUzpar1DDUJX64SiHq+N7iIFD1ziZXifztLmdP7lNXLl69irQRlJEH0mWh
         Y880cQ5JPRaDmVmBxz6k+5D4begfy7+oWZOt/kBhzSpWRenDNN02FQn3lL/2+kYSlQ8j
         xALqWFpHiIMViIpmSx7sxngAhiWkkTOlxkVn+AOW/CBZiCe0ahCyPwQhGSCSpiBalKQa
         9How==
X-Gm-Message-State: AOJu0Yx8uGitudCy4Ea60Jr2jRGvrfnXcvyWIp21A2Dx+Gyt438/OvBF
	wTQjApX5B8U7gLvx03z2y+L0oWwLofqBT2R3rcYADv68yqc39au0lzQvJ76BH1UM1Enj4QUbziz
	WXBMo9yqbLvzb8M0ZRTlDW86lNnnAqC/tiqxuV0Xk7lhR4P3GPJCa6046hlKG1BXdQRpqetN0PI
	RGWRUxYE049RD4Ev7dLm/DnO/OJOwwPQ==
X-Google-Smtp-Source: AGHT+IE4FbYAQHBBFmvLUK6BTUOeKa/9kNR9XVcVUaCI2BCtZTNDmxUOUblHLmDUND1BYgJTzoywlNlm
X-Received: from wmbbd5.prod.google.com ([2002:a05:600c:1f05:b0:43d:1ef1:b314])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e08:b0:442:dcdc:41c8
 with SMTP id 5b1f17b1804b1-442dcdc420amr95056825e9.19.1747077092502; Mon, 12
 May 2025 12:11:32 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6196; i=ardb@kernel.org;
 h=from:subject; bh=lPLQ5Dr6uaGiCJRD4WVI92OSHp2RE+NHhWws6eRj9OU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3eSp5PZlgR8PFaY+5ZVYmFaZPf/O56eP5W3WTNYUV
 dh3YtWNjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRdacZGebvW8GSlHG2ScZc
 Wsdq57KPm3d73S7gnOP1afnUV8bPLlowMuyYZ1gWKsvizf9siz33wTv7p6muecCUIZ5x1WTSE8a jn9gA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-23-ardb+git@google.com>
Subject: [RFT PATCH v3 00/21] x86: strict separation of startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

!!! Boot tested on non-SEV guest ONLY !!!!

This RFT series implements a strict separation between startup code and
ordinary code, where startup code is built in a way that tolerates being
invoked from the initial 1:1 mapping of memory.

The existsing approach of emitting this code into .head.text and
checking for absolute relocations in that section is not 100% safe, and
produces diagnostics that are sometimes difficult to interpret. [0]

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
the use of GHCB pages and SVSM calling areas in code that may run from
both the 1:1 mapping and the kernel virtual mapping is problematic as it
relies on __pa() to perform VA to PA translations, which are ambiguous
in this context. Also, __pa() pulls in non-trivial instrumented code
when CONFIG_DEBUG_VIRTUAL=y and so it is better to avoid VA to PA
translations altogether in the startup code.

Change since RFT/v2:
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

[0] https://lore.kernel.org/all/CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com/

Ard Biesheuvel (21):
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
  x86/sev: Provide PIC aliases for SEV related data objects
  x86/boot: Provide PIC aliases for 5-level paging related constants
  x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
  x86/sev: Export startup routines for later use
  x86/boot: Create a confined code area for startup code
  x86/boot: Move startup code out of __head section
  x86/boot: Disallow absolute symbol references in startup code
  x86/boot: Revert "Reject absolute references in .head.text"
  x86/boot: Get rid of the .head.text section

 arch/x86/boot/compressed/sev-handle-vc.c   |   3 +
 arch/x86/boot/compressed/sev.c             | 132 ++-----
 arch/x86/boot/startup/Makefile             |  21 ++
 arch/x86/boot/startup/exports.h            |  12 +
 arch/x86/boot/startup/gdt_idt.c            |   4 +-
 arch/x86/boot/startup/map_kernel.c         |   4 +-
 arch/x86/boot/startup/sev-shared.c         | 361 +++++---------------
 arch/x86/boot/startup/sev-startup.c        | 190 ++---------
 arch/x86/boot/startup/sme.c                |  29 +-
 arch/x86/coco/sev/Makefile                 |   6 +-
 arch/x86/coco/sev/core.c                   | 179 +++++++---
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 ++++
 arch/x86/coco/sev/vc-handle.c              |   3 +-
 arch/x86/coco/sev/vc-shared.c              | 143 +++++++-
 arch/x86/include/asm/init.h                |   6 -
 arch/x86/include/asm/setup.h               |   1 +
 arch/x86/include/asm/sev-internal.h        |  29 +-
 arch/x86/include/asm/sev.h                 |  67 +++-
 arch/x86/kernel/head64.c                   |   5 +-
 arch/x86/kernel/head_32.S                  |   2 +-
 arch/x86/kernel/head_64.S                  |  10 +-
 arch/x86/kernel/vmlinux.lds.S              |   7 +-
 arch/x86/mm/mem_encrypt_amd.c              |   6 -
 arch/x86/mm/mem_encrypt_boot.S             |   6 +-
 arch/x86/platform/pvh/head.S               |   2 +-
 arch/x86/tools/relocs.c                    |   8 +-
 26 files changed, 621 insertions(+), 689 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)


base-commit: ed4d95d033e359f9445e85bf5a768a5859a5830b
-- 
2.49.0.1045.g170613ef41-goog


