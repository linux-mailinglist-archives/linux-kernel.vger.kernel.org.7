Return-Path: <linux-kernel+bounces-583537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B8FA77C30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB816A44F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0252046BB;
	Tue,  1 Apr 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3NJwlJO"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA42040AD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514478; cv=none; b=BOe+R0M7n4HJb4ap5327h5TvO0NA14dy3ghd+jytIi6N1izhaPSC1ajstAtCrzRmOrGR76bELwAiAhyovkikmtR7g1idzNhoGJqk0In/Is33nFhCbXInFkCpeiTbN8L94UZSjtxnonEkwOUvE4RjvwRcxRJr9ppEIbacnRt7/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514478; c=relaxed/simple;
	bh=jVv82q0VAwBPvYZ5/rIuosPXebvdrL2vHJ8IsDzi2y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ch2HvKQNXAKLVwzmcLx/vwxVc9X4JVJJ7TYha96ySjtr8BC15wHaHN7SKTO6Q3WYOywgNIHLVmo0aKrAdQ9UgYPtMx0bh3A4Ebneon3CXo5zVCJPrXNAWSo0ADUDJAzhwZ1TGgGHdE56G461N+xgYy0ZoqjupHGiV+gmkfhYjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3NJwlJO; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912b54611dso2979889f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514475; x=1744119275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkkgdoQS7XsAFt9UmFe68Xk/ys+reCGu9v6By+aRdFc=;
        b=G3NJwlJOSAQKohRI0zN9krFZa3FmDcluaJKAgvN1g8FyI0ApEtnH0LBhSZrGffrpea
         Tu0/n3UMX2doH+oIWFJ4tWXAfznTW8lms1NaXFQ6ld/yraNm+B/+EkvPMgytkUIjDvyn
         6SDKgV5Ru82mVumNNfVj6BXeXBZUXbFeRjxoYQYkdAS400Aut2hE6OzB7b3gs5xfw1Dd
         oe0M+HpNP1rj1vVZsHVwvDgO12DjJSfUMt4nBc+6ZbwYFiNi1yaif3imZhC/8I/XIT1P
         kdfh6MR1o25QdbPMKg/abyXJyoZOgqtcHZKWsPzc4HI3mgVxGka+J+McDzV9hcwWK3aw
         AQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514475; x=1744119275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkkgdoQS7XsAFt9UmFe68Xk/ys+reCGu9v6By+aRdFc=;
        b=bZRORK7N1RK1nNkIa5IlYmn32VeLGZD1i5WNPc5i5gJQZmrY3oxsvh4vHXeaRLyWLQ
         DhacbW3/7PWtRUSGb5mtCDM9pBhO5P00HJyCbhnN6CZ6HWZooe6mKGDYbRzhBFFym89d
         HDiPWXyDp5F5++Ts3eTB9OpieiWCzEMHpcdo2eHiCtNRrI++ZN1cevZQRYULMwmHz3Dg
         CXE+n2J8xBN7XmZtsv7UG2p3u7OAZioV2otghZ3Tt9M0Doj/nf88MvCww5TqTi7CkLnQ
         a1psbnsbT8aqyInNinNojIvM/02cRCIiSljkyIbtiUV3T6INRoD9Vv7ShUGxXtEgpFcy
         GHIA==
X-Gm-Message-State: AOJu0YzPXjytmo4hZqr/g7CFN1JavfwyLWY4KdQsSWCVrjlcAGtGoyey
	BnGkb2v2tgaTvL1mq5PO3J+IzL0efDgpXZeBxwIi3DU6tn6iyXEGT/3scoewmqou88gcgg==
X-Google-Smtp-Source: AGHT+IH1Rwf0SPfvTDMLTXKr8r2VF8laxDRTirFJIzh3OocUBKb+W0dll+mMOctsSfKR+qI/IAtXpqrI
X-Received: from wmco22.prod.google.com ([2002:a05:600c:a316:b0:43d:40ea:764d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:250f:b0:39c:1f10:d294
 with SMTP id ffacd0b85a97d-39c1f10d4e4mr4825842f8f.26.1743514475045; Tue, 01
 Apr 2025 06:34:35 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:19 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; i=ardb@kernel.org;
 h=from:subject; bh=Rg+9UesfDX7KMCl1WWKPr+VDxB1ApETGwnITWSbmCXE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3165iHHY4uD/afSnKPszOfHrj0WLV0h5/xr5jp/9fL/
 hfe86qio5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEOJmR4WbK2rN+i8pqm1+u
 5Ty+lHNTx/7ty24JfU27l7xzopd2+3OGfxq2ZvoFgR7zv5R8WvRAlHmLamzcifaAktn3uVdt0Hn iwgkA
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-10-ardb+git@google.com>
Subject: [RFC PATCH 2/6] x86/boot: Move 5-level paging trampoline into startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The 5-level paging trampoline is used by both the EFI stub and the
traditional decompressor. Move it out of the decompressor sources into
the newly minted arch/x86/boot/startup/ sub-directory which will hold
startup code that may be shared between the decompressor, the EFI stub
and the kernel proper, and needs to tolerate being called during early
boot, before the kernel virtual mapping has been created.

This will allow the 5-level paging trampoline to be used by EFI boot
images such as zboot that omit the traditional decompressor entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                                  | 1 +
 arch/x86/boot/compressed/Makefile                  | 2 +-
 arch/x86/boot/startup/Makefile                     | 3 +++
 arch/x86/boot/{compressed => startup}/la57toggle.S | 0
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 27efe2dc2aa8..c8703276e3e7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -287,6 +287,7 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
+core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 2eb63536c5d0..468e135de88e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,7 +98,6 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
-	vmlinux-objs-y += $(obj)/la57toggle.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
@@ -107,6 +106,7 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
new file mode 100644
index 000000000000..03519ef4869d
--- /dev/null
+++ b/arch/x86/boot/startup/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/startup/la57toggle.S
similarity index 100%
rename from arch/x86/boot/compressed/la57toggle.S
rename to arch/x86/boot/startup/la57toggle.S
-- 
2.49.0.472.ge94155a9ec-goog


