Return-Path: <linux-kernel+bounces-879971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7424C248AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27AF463A76
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC561343D69;
	Fri, 31 Oct 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHxr/7pH"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49267340D84
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907194; cv=none; b=GTu1QMuqChN+3JmKsSpUORpB2f22k+APSMhbZeEUoDAqkIvV+J0oZOnRGr1Z93OXKh4OOQafiPzCZPHmswf1Tk3yMUwBC61SsyACAeq7dBGPRbh5VlMr0vKjyjknGhJ5sD5sI0dcDAQpg8G90GAqUKODOXo2RtJz+7xds3egnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907194; c=relaxed/simple;
	bh=yBb3/AVwhx7HPzbiZpLBbPTW06U/K5ubRBiRHWSOhDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jtsh9qcHw/5Uk5ezzKgOfEkZ3PfAqCoF7hQOYCRwR0bnCFT3dEL6qMJD7hmJSBqnixNn4jnlOWCikpupYPYfWNsKZ/npiQ2kRX/+gNxXxM6qolxX60qgV/CE+zerbKZoHVa+ByEicpeO+xiT4/5/YMNSKZW/+ptQwcVmCzEYaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHxr/7pH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47106720618so18831795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907191; x=1762511991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/RaERATIracn7UtSwS5tFdTv/dEoSriJN9vedmIsxs=;
        b=jHxr/7pHlC7deWj6triksIHLQDXKJGZanrf+/iWeE1IDx4bjMK+DgByFBMCfPV7WvD
         GLGFqa44M853IiArTaN47M1kOZKjLB0XcgEg5hpIpCPBO5Fq2mCG7HQv3+jYWZxsNzig
         tOn171UzjmSsEEwcvj55bIHZLg6BKKaa8hB6xlEB7YtWHtuzxxuTAyZ6Jk+kjQSBlXQK
         +2XPUE5UB4IMUBlFSN3XAB9PLFM5Mrveb9VhwovNDhZ43JsKjol/vqoDIIO4nixQVw96
         zKf7Cppzk5GOEqtiy7t5td0Zv6acr/kxqRGmumHzll+FBgJyjccI/yM2CkeVIBYNAUID
         VDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907191; x=1762511991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/RaERATIracn7UtSwS5tFdTv/dEoSriJN9vedmIsxs=;
        b=h+b/+6fQmvDYzLGf/l9Oo3qrYTGcccsasPSLn/tkF2kuLy+Z6tTqeENNV/6DkLamJy
         kessqGWwblygZ3zb7AipeLFiYIbR6Metf4jSk6bbKuZBoEr4x+5EvqLL0q67av4mLgQR
         d3sT3/ejK9u90OiAnHnUOnJgAeI+opl4QfzAN9t/AOC2HPVjdCO8PyaMhEOH6bWNqFfH
         bpBbCsPqJi9AZg87omVSzdm81n5pPj677a+9k373KuB57F1WWW7gXpO6W2DpyodK2dtg
         hzPzaUuX7KOGkCppRNVcQ0JqD1FCucjWZHjpHAgHa0ahdrwadwIFXXEHlIPgw+RkKb0g
         akaQ==
X-Gm-Message-State: AOJu0YwB6nZdPxSmxnagW889IZ5K92lL+ukw8Agv8pYA+6yVY2RLP4yv
	g3kLqs58BYmCsA77UMnP1lV53Obiyrrugdi6YPCxBVogrg7HsHx5mKm5DropS9I08Ima+WgfQQ=
	=
X-Google-Smtp-Source: AGHT+IEhDOZqTYQN6JCsrWCZR21DjrXOlbXVaNqUWcCfWzjZpQ00/Tqc6oq9nYRZhpYSEno0TxL2X/Vx
X-Received: from wmwp6.prod.google.com ([2002:a05:600d:8306:b0:477:9e6:88bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3146:b0:46f:c55a:5a8d
 with SMTP id 5b1f17b1804b1-47730802df6mr26621535e9.4.1761907190616; Fri, 31
 Oct 2025 03:39:50 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:04 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=ardb@kernel.org;
 h=from:subject; bh=M/7s7wcn0cdKhOhqASUBxonxhz5yy2SsKjo9N/ZpQ7w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4qnyS8sPKb69IFY1+c0PRoPgI+G1QUYH3jPN7vrGE
 6knvD2no5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykLJHhN0tBTKn6F6d2/Y0J
 FcET91VJ/rMuz/7h8zTBUu/D4nWvvzP8U13ef0Rt2iy/1D9zLa/cenzYpJVfaIUx26dve6cuSHw YxAQA
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-28-ardb+git@google.com>
Subject: [PATCH v4 05/21] ARM/simd: Add scoped guard API for kernel mode SIMD
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implement the ksimd scoped guard API so that it can be used by code that
supports both ARM and arm64.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/simd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
index be08a8da046f..8549fa8b7253 100644
--- a/arch/arm/include/asm/simd.h
+++ b/arch/arm/include/asm/simd.h
@@ -2,14 +2,21 @@
 #ifndef _ASM_SIMD_H
 #define _ASM_SIMD_H
 
+#include <linux/cleanup.h>
 #include <linux/compiler_attributes.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#include <asm/neon.h>
+
 static __must_check inline bool may_use_simd(void)
 {
 	return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq()
 	       && !irqs_disabled();
 }
 
+DEFINE_LOCK_GUARD_0(ksimd, kernel_neon_begin(), kernel_neon_end())
+
+#define scoped_ksimd()	scoped_guard(ksimd)
+
 #endif	/* _ASM_SIMD_H */
-- 
2.51.1.930.gacf6e81ea2-goog


