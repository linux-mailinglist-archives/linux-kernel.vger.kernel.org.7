Return-Path: <linux-kernel+bounces-610735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469EA9386F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F25920449
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246C17CA1D;
	Fri, 18 Apr 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSpGRao2"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E170158DD8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985650; cv=none; b=F3K2YbhrmtV6guHD2rcRWYm0IPvVWHMDK6i0PelGtgspg1n6OZG5XdGJlwZ97KKLxkquLI/6sOgbT93V1WAbGNczBi2QqoUYAbDyGNzXrQaHb4v7l6S0mZMB3ybI9oYHxg/CjK/YuQp/6LSpc9SJ0rkWWBHmfFGK+HQ5vFOhjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985650; c=relaxed/simple;
	bh=x5hZFAmdpLomi4Hl2CWZukbtjttzroIxIKAfO1hPht0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kddEQzNCQLWJwjNo6CBM7hmHASdO09rATnGMtbTF1mJ62SA7YEgidL1u87O4RYAyW2mxsSeqLeV9phXWhWGtAWrugFRrK0B9NECuv5IPH9b82YQ4EJkX55ImKNF0XtChvqFOldsi9WQFQBEiZAavVrDY02HI9AWG3q3DfKJUQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSpGRao2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3913f97d115so771820f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985647; x=1745590447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dml18GkyTYMt2GD5r80xQ4Q5x7i+U6ozWSpZWU9Y5sA=;
        b=CSpGRao2IVak9PSC9J3MWmbq/iGAy9mzV6Wwu6ij3VpmyLuOOh+LFuZ11hQfTfx802
         KI2cVsVVgS3MtwIEajCmLZS7znM5IIyHsL3xUuf9aIssBbQNlwrrZsqwvLfkJVDX1o3x
         MDV6lkgrfBqIuTHcnkhK3WrQBjj0XrJ3cI4ggqjK1h3Ub24wVrM8+Yw0ObVLwx+K5r9c
         EtqAEWia3L7zoJp0OL47X0os7fPQe+Tf2LI6tvFscx/diXuYQaHAaAamRApUwVqImepc
         sB2aA2QfAz5vR7H9TufCF5ImAkEJKdBmsmpSurNC5dmS35KuZ5yYMNb9cGw/y58cLwmL
         9rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985647; x=1745590447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dml18GkyTYMt2GD5r80xQ4Q5x7i+U6ozWSpZWU9Y5sA=;
        b=AxNtcpR2O1ttSOyZTZ+HE3DnRaB2knRgu78iHXEF7rtRWgeRd5ynVpcYnqn2AwnxHr
         l/Ou8u9G2TfvLuffYYpmVOSXaDp0B1ManUJJc4sOakzonwYGD965THyiW5piKvRSLN6j
         NlsI+MiEp639ZfR4CitpBumF/a6dz/kXVJzxpeXpTa6YNx8YPuXtQJXn37MI8c0xjCHg
         LOgLSH7yNj6WKAwAVHWXRHiLln+8SUHoIp14NnMvISRTjsOxcKjG5ssKkw4WV6Ex/EM/
         yBHWSb+gblHBx+5zJ6pK82r8vaC2bGT8JE5t1mpfOgU2K5kxrZgFnPtrQcdFuvt+md47
         fLfQ==
X-Gm-Message-State: AOJu0Yz0akhzhVW3FE9WhbViawCwD9aDWyV2iwdcJ6jB4z24fa70XEqs
	EdQD6V9JbBtz0MjwTfyW/NIXLiYm5LhTqgZbJonPPwMiZsLF8bMzXEV7LvZC8/GeA5Zzc/Hew5O
	CJoa3MFSA+UG4Hj/mNtdQ6IW/kT1a3xOMO9HkYSR9pBKXSlqgJ3qLJbkYO3q1wmybHsqYUxhBDl
	lfNsHf/IHhCnHGhVlfzZW6cIvAotnR2Q==
X-Google-Smtp-Source: AGHT+IFlRMONiAbWqf6BCYlam6NQQUxc1dLLMFS1aQTn/j0UNpNFmqq9WDLulWHfLSY7Kty/M7Wb2noz
X-Received: from wmbek11.prod.google.com ([2002:a05:600c:3ecb:b0:43d:1ef1:b314])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:588a:0:b0:391:9b2:f496
 with SMTP id ffacd0b85a97d-39ef8f8286dmr2795934f8f.16.1744985647287; Fri, 18
 Apr 2025 07:14:07 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:55 +0200
In-Reply-To: <20250418141253.2601348-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=ardb@kernel.org;
 h=from:subject; bh=5EnPDi9uqoYQe2wwnjJM0/MMuLSFa2UCwz/beKU8A2k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9nnTI8Ust1ciuzxCLTU+zLzw/Yfr0WnurQrJaduyV
 l54XJ7dUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYy146R4W3c+eQXwb+TuThP
 eX1Icmna0VwR9rJmcYvnBrk5OVffFzH8r3BfetTjKPvKwrscNl0sH+Yd3t1z2q+pXLOG/wUrv9R fdgA=
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-9-ardb+git@google.com>
Subject: [PATCH v5 1/6] vmlinux.lds: Include .data.rel[.local] into .data section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When running in -fPIC mode, the compiler may decide to emit statically
initialized data objects into .data.rel or .data.rel.local if they
contain absolute references to global or local objects, respectively,
which require fixing up at load time.

This distinction is irrelevant for the kernel, so fold .data.rel and
.data.rel.local into .data.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 58a635a6d5bd..66409bc3a4e0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,13 +108,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_MAIN .text
 #endif
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data.rel.* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define DATA_MAIN .data
+#define DATA_MAIN .data .data.rel .data.rel.local
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
 #define BSS_MAIN .bss
-- 
2.49.0.805.g082f7c87e0-goog


