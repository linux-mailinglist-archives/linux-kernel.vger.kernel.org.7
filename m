Return-Path: <linux-kernel+bounces-855286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C433ABE0BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8121D4030D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034ED2FF64A;
	Wed, 15 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeXLlNlp"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9E2D5930
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562068; cv=none; b=uW/xF3TLkjoLbwNOddrVowMQxRNL5srndURuZcFjDbT9gC1FSCHEbVAyZbped+GvSalaZ1JrkaLqST/pwW0/wr/aCzojgORMRaIMbpx1y0luboL5WcPcY5ZgVBlTL1iaPEGw+sYVNSYl10lUJW5PE8tDC5BO6VJYANMflCNY5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562068; c=relaxed/simple;
	bh=OKkz72icLYW14imSSGsnJwZQIz4ZrV8RIoFMrz/DOHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/6tSdiFYUOOENy56rIchA5jJMBOgx71ImYHZBh3HYotIlpPQGSu1G8XzyQAdAePFw7W4aXw61QkL8RZey84ch8nUD8iwfaunHGJMq9aCQQT2jGmaBB3pF/8aH2sT+8OsgTmZ8Y3JBju7AvmIuwJgz7Ge+c0ehpclFW4iHiD9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeXLlNlp; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b5c4d76589aso2791866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562065; x=1761166865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl7DSFNXrvgC8fPiu6fPIF6OEEmMKscydyxcv7oyMcM=;
        b=LeXLlNlp4b5CawJnjlxgzI2sM0o6Rkxo2gmwphjX5/HO63aVLI8971cXQmnLgago7o
         5YJ8/N0Vw4pgM00+Q4oFJPkhL1tfYSwjo8H/d456arLYjxGPWFp3I8yyz1dCyVWXazjc
         N0NnzvA8WXFadgLQfVxv2TsXr3swEZfhtMzX5jhK7ilgWCcv5zo01p6jcrM7yIDrgacM
         bp+N3n8PO0tRh8GN545EDJS5y3zAXUV2TiV3sNXqYYKrq+I6Rix8hyPGG9Yrx7kBldEj
         HYZPVjG2BX+Ewi3Gl3e6Tl6cSOM1OBh37dgNJqKaOVnFC/2ZK4RM7istHOaVyVkU0q23
         1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562065; x=1761166865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dl7DSFNXrvgC8fPiu6fPIF6OEEmMKscydyxcv7oyMcM=;
        b=lvfOXtCbSYDSHOcFLhiZGWi/z1UUINWTVrqtMmnyn124+PuHtFUHprENiUMVuzYeix
         x3RPsU9m443OaZ2zLfvZU4oZ5sOLki44N7dG3mv1GzbgXB0tZFDi89yNZiGPOmZbiZyh
         nddv4CG9AVKYZo9wdZTTo+3XZm+ZCbRRojCJFCT3Nl+M9Awy5VT0qYysp+MIGGx0e/1+
         ZDC5MBVO1y1R5BjbjW1OsVwq4cFYZyuskvlPbnKQMFbskh2BWM/Sr9EhyldHQfSXPE/i
         4Iql+wBGgCoPdjTZaTswaiG8MtEPJ01RxOCxmTqNtm90ics5KZyNea7lHsZC3xm8vT7b
         V69w==
X-Gm-Message-State: AOJu0YznkUZs4yx3IiN3lNf701T91IUmXzbh91jQVDFH7A8GrwE4u7/o
	v4+vMtNKCHuhZ2Mwn6JgCnIFv2OPRcDuWiK0hGNWDqxMbfFnE9osJ6/fE7fj/vcxrIImJDA3RQ=
	=
X-Google-Smtp-Source: AGHT+IFbnpDjbsGYz+B5RZXbbX+lQAERWey19YRdHXPDBHHjm8WsWQOtc3beJ3/VDPI6WGbFnSNWq6W+
X-Received: from ejkf21.prod.google.com ([2002:a17:906:60d5:b0:b3e:d65b:d781])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:980f:b0:b42:9840:eac5
 with SMTP id a640c23a62f3a-b50acb0e645mr3264235166b.61.1760562064831; Wed, 15
 Oct 2025 14:01:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:38 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=ardb@kernel.org;
 h=from:subject; bh=3k3eAeRzb5JtIy3mWW+ubq7svhGC8mUZQWnX3o9AW0Q=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV/tegTVS5dfXu18UWPjk1eM+1663m/bMeRC4e7bqM
 +23r1njOkpZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEmOwZ/oqnmq6ITeacf2jG
 mnnzLl0RqJGM0Df8/FlHNOxjasSsf5MZ/qc/KH/84UNLpdyBY1qtf2/cjU7fssu6aWcD8x4784P vOjkB
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-12-ardb+git@google.com>
Subject: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI execution
 context is preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode FP/SIMD no longer requires preemption to be disabled, so
only warn on uses of FP/SIMD from preemptible context if the fallback
path is taken for cases where kernel mode NEON would not be allowed
otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e3f8f51748bc..3d848c89604e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	WARN_ON(preemptible());
-
 	if (may_use_simd()) {
 		kernel_neon_begin();
 	} else {
+		WARN_ON(preemptible());
+
 		/*
 		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
 		 * preserving:
-- 
2.51.0.869.ge66316f041-goog


