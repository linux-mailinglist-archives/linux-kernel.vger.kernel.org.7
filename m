Return-Path: <linux-kernel+bounces-610734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13184A9386D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38E61B643CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1F15A856;
	Fri, 18 Apr 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bk1M2hfI"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6C156C40
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985648; cv=none; b=OaJJChQwyeo1/jXcw0leKbsvKaG/Nc1k9GNFoGatPyOmKI7GKU/QRRLq2VYrfB/bIBX6DlfcR8mzuAL93dYtRCeY3Bq+8M9UiUs9J55b+6Bkm/HIBWrCeX66kMjTFAtBD5rMnHVAheZUnVuDJHcOoQcF8pzE8cr6tEyirN7cq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985648; c=relaxed/simple;
	bh=eoypHYFJbnhI3cM5jTMzcCb5/LQ1yyBLt8XZW3eJwoo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IjXj1FK2bjbxCqklOOkCHsQvCWgF/r4x+/cXQHcQpJWCk2izSJgRZ6UuoNla9OBnUkP1a+YGSE2ypO9W/+zjOVUvAD/fSJk/8Yfk6nm1QvN5DiN2zaAlc8pPSf9lGLY2ckj55cfcxv7/gX8cOSfZ0RP6+goVAm4RZFn6KLgRWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bk1M2hfI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so12739455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985645; x=1745590445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9IGVezPOkilLrKq9jah2asU3Ea63Qs7zBKDQ1lB5AA=;
        b=Bk1M2hfIHPB5qLNqwAb7CBC/7c2JQKjK4kx2eFGK+udquEvW6yJegul/nC6N0170xA
         XXsUidPCvGHUNF4gp7hHl/Q8gcWGHgwoEKTZAfoigsDiieT9O+aB3g0tj4eyptynuwah
         j5EicEMzPLWnAr5Encj72aY821vBzrPviMf0YBFVDwUslyPFs9DOeYMBkKh5LI66VWV8
         gyp+7Fp7O4ihuQCGInkGzzci/PLfB6Z9gTpZfDKVJjjQA0rRQHeUyrIke7kWfdG3h5fB
         UXp+p1GRmmEwDYJVWt/zK5AQm7oAwWDTgRbDHcf+CVyNtVSvlfxnVphHtP5Csz7se7XY
         wofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985645; x=1745590445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9IGVezPOkilLrKq9jah2asU3Ea63Qs7zBKDQ1lB5AA=;
        b=ftLfwj8ApJvRDs//KMM9doWu19m514SZu+0UDy8V+zJNtl+Hzcb1F0pgyBuUeHFMu8
         EA/agbpdq3/DZjSXzHjACFpfx8/HUIqz4DVIHdApytZE44EcVZujUrKfTvk4ZdOEbA+8
         9kNo/HIeYE+772Hx/GiJOW03TkX/lqwLEhrP1BmGB56msfhBzq7F2F5gTRz4xKhrDgxK
         1YOpGp46iBIXpfaWp7INA/zRmjLD+bASVb8xxXukfK7eGgllKvTJ1x8whVPxZ+Q0flmt
         H37XwYHnaMKyRpbuorzyc24juit+tvZlJygFad9+zRQQCK8yri1ud7ZvqMsmo93PllA2
         BGeQ==
X-Gm-Message-State: AOJu0YwCs4oVaxkdXGGF2l3zNCwy4XnMOXim9p8j2R0zF8r0R2/UEaZl
	QbndA+dVcXlJuh6pkbA7PYnn8Sb7p9VL9U5XIAcjNbPbh59EMX6Fp/v9v68/JuFBYUQqeyaKV2J
	q+caCRrin+3RDxW1lFz5Gyh06DDF0C7bh8n4cqosp4O+l2ssOpiyOsphn9ekw9QLt6I8JvYtGb8
	oD3ccnLc63yOEupisLW/YBPG3/1IdAyw==
X-Google-Smtp-Source: AGHT+IGeeboR9LNaCfFHJGSv6CTfOBZFSExVBWnjlZFq2lCEkiAbh1KlEcSN+Z1v0vWXDJB6+Fj+8ZjP
X-Received: from wmbbh9.prod.google.com ([2002:a05:600c:3d09:b0:440:68aa:44b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3d15:b0:43c:fa24:873e
 with SMTP id 5b1f17b1804b1-4406ab98740mr25460635e9.13.1744985645193; Fri, 18
 Apr 2025 07:14:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; i=ardb@kernel.org;
 h=from:subject; bh=EUs9Ho6X1BW2Z/6wKHu4GkQswolV9uFnsQmKgY+Uz30=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9umBw3F6zXO9erYui2MsOeNwo+HS7f9iEucf5mbnv
 ++RFpXvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRtGJk+CRwyfzc6qJXE6tC
 ln+t/bWCz8x/ldxPFcfsidc7k9/MfsXIcG+3dPBFXZ6E7BCWlizf3WZca5JnbDxfWtIvwKq0wjm JEwA=
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-8-ardb+git@google.com>
Subject: [PATCH v5 0/6] x86: Refactor and consolidate startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Reorganize C code that is used during early boot, either in the
decompressor/EFI stub or the kernel proper, but before the kernel
virtual mapping is up.

v5:
- add new patches #1 and #2 to address issues that were reported by Ingo
  for v4
- drop another couple of patches that have been queued up after v4
- rebase onto today's tip/x86/boot

v4:
- drop patches that were queued up
- fix address space error in patch #1
- add patches for SEV-SNP boot code - these cannot be applied yet, but
  are included for completeness

v3:
- keep rip_rel_ptr() around in PIC code - sadly, it is still needed in
  some cases
- remove RIP_REL_REF() uses in separate patches
- keep __head annotations for now, they will all be removed later
- disable objtool validation for library objects (i.e., pieces that are
  not linked into vmlinux)

I will follow up with a series that gets rid of .head.text altogether,
as it will no longer be needed at all once the startup code is checked
for absolute relocations.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (6):
  vmlinux.lds: Include .data.rel[.local] into .data section
  x86/sev: Move noinstr NMI handling code into separate source file
  x86/sev: Split off startup code from core code
  x86/boot: Move SEV startup code into startup/
  x86/boot: Drop RIP_REL_REF() uses from early SEV code
  x86/asm: Retire RIP_REL_REF()

 arch/x86/boot/compressed/sev.c                            |    4 +-
 arch/x86/boot/startup/Makefile                            |    2 +-
 arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} |  307 +---
 arch/x86/boot/startup/sev-startup.c                       | 1390 +++++++++++++++++
 arch/x86/coco/sev/Makefile                                |   23 +-
 arch/x86/coco/sev/core.c                                  | 1620 +++-----------------
 arch/x86/coco/sev/sev-nmi.c                               |  108 ++
 arch/x86/include/asm/asm.h                                |    5 -
 arch/x86/include/asm/sev-internal.h                       |   18 +-
 include/asm-generic/vmlinux.lds.h                         |    4 +-
 10 files changed, 1757 insertions(+), 1724 deletions(-)
 rename arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} (81%)
 create mode 100644 arch/x86/boot/startup/sev-startup.c
 create mode 100644 arch/x86/coco/sev/sev-nmi.c


base-commit: 433bf33adc6605f3798cbf2b2c42d0b499233c7b
-- 
2.49.0.805.g082f7c87e0-goog


