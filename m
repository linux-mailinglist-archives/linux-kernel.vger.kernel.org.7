Return-Path: <linux-kernel+bounces-732802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E9B06C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD0C1AA7E23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18F28D8D8;
	Wed, 16 Jul 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xOuBc35X"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAA28C2A9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636170; cv=none; b=mE6pIIq6VHrQ+9UzIoY6DmUollJmDx2+UX+og7HLpK7O1cJgef/9ZOc/7+JjBcTDAq+20hHVPGpLP7zsd9JJ9o3hknpofzyE7aQyfZDQxme9hAl0B3hdFGUvyAVzkymR4hWoNqsonHqMEGUvmloRL5vhC+/wWHZgOCDY5Nhixag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636170; c=relaxed/simple;
	bh=qi/XSlH/3m0Py+I72AmudGPp6EWjqjC8xYfnH6HfggU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKwVyjzPzhX+guomAAeOlFffhTOYnWIraSifEAQr8xn94Z7rhlJfIYoFO5fJ4F1kg/m0YjAdwvwcYvgzCi9VIhJBAXrGDkyIAXT66CVIVKy/aW7Bbvc/gP2Dr52PuY2pGfgFvHqintgxzUgijgQWBbqnUkJ7FIga8YkY4xFAxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xOuBc35X; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso1386582f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636168; x=1753240968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=xOuBc35XGEzrJ4irBCSoTluUfvzZvDp5+WZtWzvEPyZouqqg1dpo7OTswVnXnGNkJc
         pvrluKcgbAY9kChmvdlJ4cOvLM5Mh+gmhSpeMt1BCKs5KpCZIx4efSEtMY6Ek9InXh6o
         exDqOsVxaXG3sKtj3mVsvaAYWh9ZzSE+iwXuwHzclD7Vb7LWqkihRmZrO0FlydqdZcd/
         h9ckD/qlmRsL1+dZ1+Z0y8uXDtqBigKfcfAMY8NSzzEv6MzEWyTuIogU4r6S6sus9Bfn
         CHlnijzHCqhiOSvSzznhQMGwahWvupMNqKh4QBjvE8DDpli+YlJH8IkPMGT90yi1G9bZ
         oVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636168; x=1753240968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=e9p2PL7uFfkmlRxTwyIa5ZzwpC8bHnreNBSMBhFDLnpdteWaqT9jD5vo6IyvBSTgYQ
         1m9Tp8HK9TyHNV3ln8y8HskMGiDu8IQJcWcCQiZ0W/Q+yR80ojk1EchKRFq/tc8x84GC
         Y6gE7A1Q04A4+iW0HKxI0c9vQgNjuiG5c6i6EgDGmFC7XAnuWQvfqRq9nQnHw4VbQzyW
         bJK8gdm10SUrVw04JBVcz0gi+aB+XFlg8iFmLIboRyEFbIIUQm43yUSEmmInYKBUL64j
         BHSGl9+gJmNJ5rx71koGOachCg27gZa8KR4SsLSpGhvHAXSv2yZ+hW9TdlDMIit/jse1
         XLoQ==
X-Gm-Message-State: AOJu0YzT272EDFp5M4kQth+VgZzycqrdW2T7Xh/Nt+695WIvmr2XRVzL
	hU9pciUW1y75XFgxtv7xcqbjvUcs54Brxv8WDwLfNGqeilVxuw+0pSD1LX2WXgJbQxoFE2TXn61
	bYLavvzJYi08Z6WS6ex+ZxFi45+tlUUoSTJAfZTfwJxQPJvdhp8/ac2e4phecIo8tDaavNnjm3a
	Td5BF3yt5tZtXxYf8/b7CIeou1MQTYsW8FRw==
X-Google-Smtp-Source: AGHT+IHCDF28uhxLChWY201JTyXnDh+mV9s7xysG12xzVOaBfwcEjRnjq+G7EOVRHZSpSmIkxdVi1rSl
X-Received: from wrth4.prod.google.com ([2002:a5d:5044:0:b0:3a5:7a26:fcd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:290f:b0:3a3:6a9a:5ebf
 with SMTP id ffacd0b85a97d-3b60e4d0841mr609066f8f.20.1752636167659; Tue, 15
 Jul 2025 20:22:47 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:33 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=ardb@kernel.org;
 h=from:subject; bh=N6Uq2lVfV25Jk1mFXhfGvG4B+EmaRioUjXHyXI14Co0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKmL7jszVT6MOl35jqfwRG7FLI/js7ikfRZd9yti8S
 cRJo3xDRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIYjlGhmdpa/7fqVZafJ1n
 Hsu8nRI+OxKZLWp4lateyHxsSDMWFWJkuBXos8E0tt1npUfBC/4b3LslV3V+vMLIx3lbncko1kO IGwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-42-ardb+git@google.com>
Subject: [PATCH v5 18/22] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using core-y is not the correct way to get kbuild to descend into
arch/x86/boot/startup. For instance, building an individual object does
not work as expected when the pattern rule is local to the Makefile

  $ make arch/x86/boot/startup/map_kernel.pi.o
    GEN     Makefile
    CALL    /home/ardb/linux/scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[3]: *** No rule to make target 'arch/x86/boot/startup/map_kernel.pi.o'.  Stop.
  make[2]: *** [/home/ardb/linux/scripts/Makefile.build:461: arch/x86] Error 2
  make[1]: *** [/home/ardb/linux/Makefile:2011: .] Error 2
  make: *** [/home/ardb/linux/Makefile:248: __sub-make] Error 2

So use obj-y from arch.x86/Kbuild instead, which makes things work as
expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kbuild   | 2 ++
 arch/x86/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..36b985d0e7bf 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -3,6 +3,8 @@
 # Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
 subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 
+obj-y += boot/startup/
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d342969b..9b76e77ff7f7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -286,7 +286,6 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
-core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
-- 
2.50.0.727.gbf7dc18ff4-goog


