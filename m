Return-Path: <linux-kernel+bounces-723046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9CAFE220
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547974812EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3C27BF93;
	Wed,  9 Jul 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXT1r9OM"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16027AC44
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048692; cv=none; b=pXD5OmqInNURdcG4GdEy58Ny4rmWkVPw5ivfF2/xulaZV0bBUrmRAWeICyDC2UuqGC3zYa3isg+0cXF4QCVD5C3efdXxgdwTdiZ2EAXRleNb38rDhKqqjmR3YRFR+mhk0vQN5PENUx77o5PvxheUhTiZw25a3b6YjalrHZNJsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048692; c=relaxed/simple;
	bh=88wIbnPP1a1dLhlXMR2D52W04CjhXmRtjIuSBBT1WeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=paCsr9CV5r8sctTYkc9iOzgw/IFiEYrRxpmw2yh0FXlSLOzwa8Fqm48fEjfxidKV0iTTgAVivXyz7m6IsnE4sTjwHJO/ALOLxheZuRA3V2jGYTT+Sitd4d4biAXv/Vx6i1T23ZzUCuMJjV3e2mff/HUi1bCh1JAou0i0/begcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXT1r9OM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450df53d461so41022175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048689; x=1752653489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=yXT1r9OM9XSmEey+sXhRWQbjTji7xFD6dj1F+NU4R3BSnm3d8+OKSKUYcCUu/woDb5
         WQmdiLjNGTcaiWcATUi48GAsVAmOovb9sT/sj6UQ0wzCqyFYYWsxumrLxktuMIC9vgLV
         OYxFOkhqplX+CDsLirpG75ikEXvCU36mx4TYuIk+J9DR8NtyPBlku+SxPB3gbmknzOWZ
         WpK8/XDrrdPKt5vMY1PQDfGB+uDfpkp4ua5dn/sjWFkwjnXWetRZ145RFeFZdKDbi8tk
         7H8j/kIAo28e4JhsZ820R5j0vw+V2lwzGx+SAN2m0taoHmkBXYX3ER+mS3Kjza6AWFl6
         sPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048689; x=1752653489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgqR5avhQu9i9Y4o0xvmYEmE5OaurZWopQxiw2YEL3s=;
        b=A4ghBg1/3rhuUUcLkfyZ6InfwtXQd8vtToLbz0IZKDD7UImjNVjlu+lb7ZEVBAIXNq
         TZkNZ14Pj6RmXEDUE7s5xnjULSmpmS5yHKqNsuLdgcAGlbeqMIFiODDvvZ2yx6IiaZRY
         b1YbjRA8h7s9yGT+vonzX/hPraZL0HfuIubcZMwUm4sURx5sG0/yyHI3jN5kd/asq1VI
         JnLxtESZYL56SXyypt2EOAbfC7tknIG0AWCo19aHS+i24i3fOQHX/iu0LEfvh3lPNJ/m
         bbzfxSOPsbmZsKCQ82C9Pkj56+X+tM2W3KYqpUuW+L67oekrq+KxkU+5VRP0CkCrNx9u
         uNqw==
X-Gm-Message-State: AOJu0YxqWv7WTGgCKRBkplGjZhQ2hH4olf+9LLiWnBLqCYV+o4oVAv2a
	0d7OpxEH6ya1uMixE2QvNQUrn8cabczzjqmktOgj34nRq4z+hXRcsZ7yHBkJmVAjvcLl5yDzoLp
	STDPBEZFnAhieZNsBrOAy7tHhKvlKOMgy4XZUzjErOGqHMRw7tSC04Uwv9JHKg9UlqAtOV17wBR
	eQyDYgkAIbbKmnbShMQ6WtOH5n9P2Ap05PIQ==
X-Google-Smtp-Source: AGHT+IGg6JhKIjYqWZjqpvcm0fMrhJX3E6RFfYQaE8mjB5Sp3xJAcUDn5PSDoCSI73gGlSa4MUaZwNiq
X-Received: from wmte16.prod.google.com ([2002:a05:600c:8b30:b0:450:dd18:ef0a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45c7:b0:43d:3df:42d8
 with SMTP id 5b1f17b1804b1-454d52d2dd7mr12749565e9.6.1752048689062; Wed, 09
 Jul 2025 01:11:29 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:54 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=ardb@kernel.org;
 h=from:subject; bh=/aZ0V2A8zhGGvGqcdFjf+IBZLj2TZ6Tesp02RBGOQMc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+ewksbCNoclTNQ+fOvXZTM6qdrb3jR4Rkz1MdzxSA
 yyvpR7uKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNxfMHwT3OFZuF//1O1Emsb
 s+V3MGeFJoSxHCzbeG3tB84Er/tmLxn+V2jdENFO4+Zij3c84F++xsm5TORQc47ulPh1bB0OjWs YAQ==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-39-ardb+git@google.com>
Subject: [PATCH v4 13/24] x86/boot: Provide PIC aliases for 5-level paging
 related constants
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Provide PIC aliases for the global variables related to 5-level paging,
so that the startup code can access them in order to populate the kernel
page tables.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 533fcf5636fc..1bc40d0785ee 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -52,10 +52,13 @@ SYM_PIC_ALIAS(next_early_pgt);
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 unsigned int __pgtable_l5_enabled __ro_after_init;
+SYM_PIC_ALIAS(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
+SYM_PIC_ALIAS(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
+SYM_PIC_ALIAS(ptrs_per_p4d);
 
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
-- 
2.50.0.727.gbf7dc18ff4-goog


