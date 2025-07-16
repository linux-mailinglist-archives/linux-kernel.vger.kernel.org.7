Return-Path: <linux-kernel+bounces-732800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B21B06C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136B81AA7844
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF728C2D1;
	Wed, 16 Jul 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F74jEc3w"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937F28B3EB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636168; cv=none; b=uFoYTbppzenzMk4EDTlfoGTat0KveBV/s/ei0fJDl9RaSCZ2g1aPz6HmUazIG5EP5YjtoEbHhdU1fj7Si2W4Kk3TbuXX7HkfVz4WtxALnLZOWYlF/9is6y4L0bMVm5ag2zrg1xkMDvvIO3nYxasGuuwq/GZ6L7dSzs+wwxD/OBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636168; c=relaxed/simple;
	bh=L0nuKM1iOS5J1LrRXwl6oFJ2k3UoNAHOTrQqnHSBepc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n60Hm8YaaI4Ljipi7Tsyt6dZUHfbhfu1sLUIXMJ1/LGB9zYLVs3XM4q6zQ+M7fTvkryXsPRjCSVc174P9EbKChyqbiygRbwh0xPR8QacX0Xi8OI5xd0nieP2KvBgl96X18uVqnG6lUg7iVqtoBRveGDGPVWMH6EyjG4sveYM1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F74jEc3w; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-60995aa5417so5104884a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636165; x=1753240965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=F74jEc3wcIK2N8yPXlxMSHMyuh6/puUCff6GWNtB9pWnLclBpFSBllM7rwPgd+e4b2
         X9ZVgBoVIyEY2kWxQzd4YKsHfsHJLIikKNLHldOEsOeVt5+R+MpE7noTVulT1VR/iXmk
         GIbgLrsaNTi9cBEZvmffn8UJL78/Y89fHCOS+qVU7gn+Rn2O7S1/ekgB7a1YFGa+go3d
         P8PyyPh+uabQ6YaSJid9OHfaKENIp5Wf0NMQ4DbX/Xks2T/P9Y56lnBDin0qi8URlvpT
         X1c3b7+dwB2boFCd9KCksKuMyarf09FK906pHKCK5KY+CRaZc+AfpdwwfdlxSkshi7wA
         wEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636165; x=1753240965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=KiYVd/XS4NgtskDYjyxEjassPweC25rjjNOxQMoSZ3QazI+nnx4xfyofJBEtaL1fGY
         iVBkgISgtQBbkoJ2aN/rI0Js9iyLwv4x6wREEk0LlhOqbaCoUkeFGKBBWHN7yc2vgRry
         FYi+coD1iy8upellWUexEZJtN7cL1Ft7OlW8lrj6ljWLhM3Sbonfnz5N3Ela4OsQA70M
         U0nn6qfAZo4l3ShphRk3w6DJ0T8advQxVuztn0Im923eLI7asSmHx2jRuIxe9UATKsp/
         6Z1tjfnWzSTESJZ9sVZdmV2ZgHLCr3R5gOInQ6mJdfcjPzNi4A1/wgnwWnQ/aXm9PWC4
         Mo+g==
X-Gm-Message-State: AOJu0Yy7UjXNqg1BIg4yV+DfFmQJnKWOHVFxP5nN54QucmaxKIZQVRf0
	g/0sIO64Ks6eMlVdxdS/z31lYMzKdsvatRMAfQ91yXwxiVxxrsWpUT4feQu+d6iQDnwuRINH1Qz
	dPPNLzGVCYa5/N/6x/Vv5tsRN/xupPTAg34/HZaeTvUb1WV8G32dyQ08lGa2Z22Mlo3qfkKj15Q
	8MmjaTRsDii7TjAuf88ynumnmV/InvmG97kg==
X-Google-Smtp-Source: AGHT+IHeuPRcXPW58c1Ou6hgXM4/t+lql3E4QuE4F2sGlkq0PPpS3a860Pbw1SAm5G7yBhLu8V/nGGFh
X-Received: from edjb15.prod.google.com ([2002:a50:cccf:0:b0:609:911:afb5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c1:b0:609:99a7:f051
 with SMTP id 4fb4d7f45d1cf-61285d039bamr816377a12.31.1752636165387; Tue, 15
 Jul 2025 20:22:45 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:31 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=L4jffg2+Vf1ZB+P16ZYKMMQDycf2VYvq95i2j0U/b58=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcyq/C0cXRztektL9ZcKnGo7JHEdd62vdf2/PO0vHUR
 9Une/52lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlkhDAy3FN2W9jEsZUx+1VJ
 14yt/m4vrBze3ah8v7As2XPuGcZya4b/bhtMXp/8n9JSZJida7A9i9dAb3VZm4tdFhvDioq86eW cAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-40-ardb+git@google.com>
Subject: [PATCH v5 16/22] x86/boot: Check startup code for absence of absolute relocations
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
2.50.0.727.gbf7dc18ff4-goog


