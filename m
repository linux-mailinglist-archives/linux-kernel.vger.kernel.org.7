Return-Path: <linux-kernel+bounces-769498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6858FB26F76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638775C22FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001FB220698;
	Thu, 14 Aug 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mcVqdLF4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CF10E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198283; cv=none; b=OsCDGrztAQoDUB43km4LuET9bmmfB2eDv/uB0gmV4r99TiYd/dslZmOn3Bq9Jjosvswduydo/ApNzoIc6tnhNH2pEth9D9hQjF82+zeF0DJGyIf2Ab8RG3O94qCsYAClCuaP8n78EG8+STypQGbBXbifJ5AIKc1stq64/GCSByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198283; c=relaxed/simple;
	bh=dEIQt6kmDhLzOdLuGCWU/Glj95VAXcyAYGEFF305EMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y81Bzy0sfhVR0WK5oID+xL2hnoqsDV4NFbxQCaFdxshP4sbTxxKQEY+1KVPHMyhxWfaJbSEnny8zXKgAY0GNnfsVIsqT1qDYH7AlHufrmv6X+FC4gzpHp4K9XRUErkCsW8Amffg+QRyejhSkAmbOCn355vAOyFr6YW4AuBWOfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mcVqdLF4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e40e27dcso1024453f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755198280; x=1755803080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2W+V7x/0ChG6b6E25lMOW9a0Z1CTCQGVLNoeGTZx4E=;
        b=mcVqdLF4WMiJlPFdp2Isl4hTb6CkWa5x840bvQ6C947EqFV6R4twGix2l7puBHmf82
         DotrZKZUsldLjP0r4RKZq6bKgewfo02vC1iTQ2AxArJxhlw2XBzqgme0nsPN5O2sn7zL
         LqkUU4Df2MtJbCbDdndUaf3RcDQoRtIf4GgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198280; x=1755803080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2W+V7x/0ChG6b6E25lMOW9a0Z1CTCQGVLNoeGTZx4E=;
        b=ZGgL3CQcOcT+Y2xA/6oECcGdbuVzR/NHSZVWUtawA8Vluc9RTzOFGQxl9p/F3jbS0t
         uzRGd2az1LmxObDls81eQMTEfBxw/Hsq9OsJlS8XHLzB65gEsLBEzJNWgx29lC20n8tp
         UotfkZUcXIhBzaCziOgXSuHUuf0PmNurTkm/ak2sztC9wuwQn2r6Ujzu47QHsoY3L0By
         99F3LVAHldKvSa+zic9D+zau5FuP/MWBXqjiqJYpVqNhdhL4RZWHCZqLTIeY7i1lH811
         iVzTyFedaUR8xK73kfywnXXX6TuOKQI7nxof+HhGq/csWme1gdFELQrtiiKtRGEL1W4f
         9spw==
X-Gm-Message-State: AOJu0YwOXsvRvnOh+Ab+VStDqz8PTvHVhpqBnDW/1SnNQ23DdIP2xS6d
	WgVDph60dSmg5obaUL0S0NOGXSHIKDft81Q2bp09sorzvq7FVnfWZrqUTA7xEu76i5fwNmHsvd1
	8unEZ
X-Gm-Gg: ASbGnctygD39BsiqZUd7M+e6egZogUWXrrQXyywylVI23eaiW0BqLB88hjnDT/Y6k1R
	0qdr7hyv7URhM8Md7eJ02SJzFCYv6nldkstAPFUCsSQBGvJgYdL2WrUqpND8KjN716lfzDcnc4O
	xuOGHhAD+/n6mIu2C0lRhn9/3+kKwXTX+evidPPpPNTDQ5/4MhX6YQNAY6HfLdtDWoqHec3cFU7
	QDUvmZnCudyTEKz3r5MM6QoETTCHHoMoivuFzBwDoYRgDs6zE0eYbQJuO0EpHLXrheCxCte9GmQ
	Dz4lb9mIUbWJJOe61ABUMrkkxBlyq3lQLIgNSKbuqD2v0C1zmRk/PVvsaGdISCFfQgmwcdm1ljt
	ywZUAOIV15ySFMkqgisLZt8xmJEw1oKQNzlAGabOSSMr44fk7JqSQLuPwpscW8TNcouUfar/7mE
	Oa
X-Google-Smtp-Source: AGHT+IGWOXmSUcHOeNRvZBTLjlnSxEfRPI2UEGsaj1rulFYm3HE1p/0wchehFi4YSDSgxGie5pQ7gw==
X-Received: by 2002:a05:6000:2c10:b0:3b6:46d:fb70 with SMTP id ffacd0b85a97d-3b9edf40212mr3913138f8f.25.1755198279633;
        Thu, 14 Aug 2025 12:04:39 -0700 (PDT)
Received: from localhost.localdomain (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c7a30f2sm32182435e9.30.2025.08.14.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:04:39 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH] x86/fred: Fix 64bit identifier in fred_ss
Date: Thu, 14 Aug 2025 20:04:36 +0100
Message-Id: <20250814190436.2555438-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED can only be enabled in Long Mode.  This is the 64bit mode (as opposed to
compatibility mode) identifier, rather than being something hard-wired at 1.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Xin Li <xin@zytor.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org

IIRC, this was wrong in an older version of the FRED spec.  I made the same
mistake in Xen, and I didn't copy Linux's structure.

I don't thinks this warrants backporting, but the fixes tag is:

Fixes: 3c77bf02d0c0 ("x86/ptrace: Add FRED additional information to the pt_regs structure")
---
 arch/x86/entry/entry_fred.c   | 4 ++--
 arch/x86/include/asm/fred.h   | 2 +-
 arch/x86/include/asm/ptrace.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..94e626cc6a07 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -78,13 +78,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
 static __always_inline void fred_other(struct pt_regs *regs)
 {
 	/* The compiler can fold these conditions into a single test */
-	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.lm)) {
+	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.l)) {
 		regs->orig_ax = regs->ax;
 		regs->ax = -ENOSYS;
 		do_syscall_64(regs, regs->orig_ax);
 		return;
 	} else if (ia32_enabled() &&
-		   likely(regs->fred_ss.vector == FRED_SYSENTER && !regs->fred_ss.lm)) {
+		   likely(regs->fred_ss.vector == FRED_SYSENTER && !regs->fred_ss.l)) {
 		regs->orig_ax = regs->ax;
 		regs->ax = -ENOSYS;
 		do_fast_syscall_32(regs);
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 12b34d5b2953..2bb65677c079 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -79,7 +79,7 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int
 		.type   = type,
 		.vector = vector,
 		.nmi    = type == EVENT_TYPE_NMI,
-		.lm     = 1,
+		.l      = 1,
 	};
 
 	asm_fred_entry_from_kvm(ss);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..37370c3b1ffd 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -84,8 +84,8 @@ struct fred_ss {
 			:  4,
 		/* Event was incident to enclave execution */
 		enclave	:  1,
-		/* CPU was in long mode */
-		lm	:  1,
+		/* CPU was in 64-bit mode */
+		l	:  1,
 		/*
 		 * Nested exception during FRED delivery, not set
 		 * for #DF.

base-commit: 24ea63ea387714634813359e2c8e0e6c36952f73
-- 
2.39.5


