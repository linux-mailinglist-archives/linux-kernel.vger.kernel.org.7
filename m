Return-Path: <linux-kernel+bounces-789731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46503B399B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A777B46826C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E930BBAF;
	Thu, 28 Aug 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVqRqJDt"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CB30F534
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376577; cv=none; b=LExnfgvx5mbjkbMvTfoZeSl0aSuGt/UNbZm/yH7oMllx6W/tdR7KJCHNeGIzXQqA2T8s59oGrWYrdKhCw4/v0RmV/TNNXmz795kNLEGC5lcBXE2+G1Ue5bVx460RCh37wAOgQqzzFT5NdGMjYQJMOC4E0mgruledz1s+y96pZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376577; c=relaxed/simple;
	bh=jGl0gAvgNJrYlOm1BG7IdxXVkPnYyxdeu5V2bTXKolc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SN6yITKCLDWwvOrKFn7ueW+80vG64Zfos3txXwMONfbYxSyt0P0JjzRRpzfhnGrR+WdGB5+KvJzuAiYQXgEajUxJHTWqATg+990e6a/aO/s5OSZvnvEDHV2yYr+1pnW9D6wwk9RcwDK5afhyOt9MT/EaU7+Gvo/uIw0+g+6o56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVqRqJDt; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cdd69ee330so303981f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376573; x=1756981373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vh/TMDTG9cWmYhJajg2zGWVZxEySWD6BQdJcoGY80U=;
        b=pVqRqJDtXJA9Tu2lmlbx7yhC4lXHreiNyuBFUip6aNGzPx7WKxyd8cN1KnnTSKlARH
         fNFqEENVkxM/Ref38q3Hnz6xvJF4E7H3Heg55spyZN1oBCOAXoI0+X644lBdQfdjB66C
         7S/4AeqOWWppHeHcsAjdnvL2eK0I/o7mTYkYl/oFvZG9yDx8jgwVCqt1NuPcWl/WXvtw
         K9wqy/oL0jzsVYeEZ1mvPnexWUbfFZSc51LzlA9angAHLBtUZt4c9kKGOn3qJ5UKzpDX
         DBA1+S/fIAoCVN86mR4foqg3v1aR6Pe3N9MjTWqYOLDNPDSbDGh1l9BONvO4HII5VR2Z
         gPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376573; x=1756981373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vh/TMDTG9cWmYhJajg2zGWVZxEySWD6BQdJcoGY80U=;
        b=ioaqhFvUYbdRdIbyxQde9rzk9fMzGbL255CLekoVqfEIaEYw2dX1aEikNibgsBP1wJ
         YBc7CVERCxmmPc7GkwrGI/fxbnMlxA4rrmaCkWXtAfXfE4YnWQsa1JlRJLE9/QFuazFL
         +motlmbUQ5knswzTrZoH71E0fuxftna0L9ToJ9KOf2YZw7dgYFvo9IjCev7ZnNoBTEBE
         aCcrHXoWCOzkzepcQ3Xznu5VV14EOppXjVAWfbHL9gcm/ppyoygWdYLj4P/VBNlWcyQY
         7nep3OgqkEyaYFDhPK539Iay5Ff14TWPBISM1L/PP7tQYdfE1qy/UIcaCEQKZVS61yeQ
         IdjQ==
X-Gm-Message-State: AOJu0Yx3l6bTxnhmPr+GhwK8mK0mfJ0zsJQC5Rry8lP1XqznJbKbdJzR
	GCyrd97WaTxQjw4btBUFq+C+1M/uvj06s43pkI0kPPA4XxCf3JiBGZBEvJWWPi8LjLrAffUFUlE
	LlBP/aNcIFqM3sDVS3bSA4uwQ0OmIJNU0+U64/odd2SScuChW4OoQj+jnCFZE8i6F0kLtrTIzQw
	pQ4aGFhYSqM5fSkqR46aw/D/DMNJ7Qp7nbyA==
X-Google-Smtp-Source: AGHT+IGzyo4w7scpy8WW+b+oQiX15LWbcXgloAUM3D9gllnCfISSdwtidehaTDvBCPJEUgcu3dLgGAFJ
X-Received: from wrtr9.prod.google.com ([2002:a5d:4e49:0:b0:3b7:840a:d99d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:402c:b0:3ce:a06e:f25f
 with SMTP id ffacd0b85a97d-3cea06ef81bmr429293f8f.49.1756376573602; Thu, 28
 Aug 2025 03:22:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:19 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=jra0AylJ/mojTBI+lQn1YBIXbt/4EEWUHxfw6HQw/JA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7j3Dcx9VOR8JWCkWaHScjZvm7TNpf7d/3YVeXmvPC
 9Gn/+l3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl8vcHIsEj8dfrzdatnzefd
 blCWL6ib+lnylSvr2aO6exgmli64dZbhD8+eovccckwVNge/qb36t5dzopHy6bBnj0/ndNwujD5 ZxQ0A
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-40-ardb+git@google.com>
Subject: [PATCH v7 16/22] x86/boot: Check startup code for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Invoke objtool on each startup code object individually to check for the
absence of absolute relocations. This is needed because this code will
be invoked from the 1:1 mapping of memory before those absolute virtual
addresses (which are derived from the kernel virtual base address
provided to the linker and possibly shifted at boot) are mapped.

Only objects built under arch/x86/boot/startup/ have this restriction,
and once they have been incorporated into vmlinux.o, this distinction is
difficult to make. So force the invocation of objtool for each object
file individually, even if objtool is deferred to vmlinux.o for the rest
of the build. In the latter case, only pass --noabs and nothing else;
otherwise, append it to the existing objtool command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e81332..32737f4ab5a8 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -19,6 +19,7 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
@@ -28,3 +29,10 @@ lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
+
+#
+# Invoke objtool for each object individually to check for absolute
+# relocations, even if other objtool actions are being deferred.
+#
+$(pi-objs): objtool-enabled	= 1
+$(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
-- 
2.51.0.268.g9569e192d0-goog


