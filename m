Return-Path: <linux-kernel+bounces-839500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D434BB1BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B407170659
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B530F92C;
	Wed,  1 Oct 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PjoT70L"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76F30F92D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352637; cv=none; b=fftaKxU0C9O2HFGMVCM2uMDpek7+9aNrlWYOIEilseZWBkdKUhvjVilI4f4MCDI//kjSzby6+HVX0TazfpTQarUhxAHVUKbnj6kCZKToKgQMvT8UHRwHYZ+BtqHarDnxEfvsm+dnTWtrXZXBqp7zZy6cR9IT/YxqiH5CzBh3zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352637; c=relaxed/simple;
	bh=GXeASNEqmczwPiXD+TO0rYwiXLFqmUMdsycyCVMnj/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZGIQvqqUbuoAXh6JCeyjSnJ8kPAqQBIafkNvET3F1ifPxbp9HzTwyp0/t39uSPDNXOXsMYvFTKlEZ8bQWm+F/vr43NB7SoE+9aa/3NMRg6F1g7YTELlUBfucIsGpVLrziaEo27ouV3QlTFVvpFnJl2XBcRfovS0tijpgbxOgm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PjoT70L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so1081015e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352635; x=1759957435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FhWp47bs3reBDPv5Eo8/YKbhWPmlo11aWHsEN7F2Pk=;
        b=2PjoT70LGH0JnD3OlTa6+NIZvy1+Z5je/qye5U2evkAqywldrBCg2kP1HyQ+gP7bhQ
         93o3ZzHlcItKJkflVq3yOabrJAzJe92bQfZVdQyMQo6VDnbDduNFjdBT1riXObdNR69J
         0hmvLxvhchOGvbrgy6NjxtzzMpKWw6GqRd/seIsV8gZZNfmJgzMaJ6uvqLVd6PrkxGaD
         Ea/0RWO7Poh5/hoPZJD/ve5Ugo8qNcWYyHwAKqLbxvYXSNfdXHo+uCUGaU8naoRxyBnw
         suFQI5qmmvIZRtpykZictYcBDFfKDt3EWjMo/qeInmXbk8bjOMdAsy6VvYYxE2jtS1Xz
         fxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352635; x=1759957435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FhWp47bs3reBDPv5Eo8/YKbhWPmlo11aWHsEN7F2Pk=;
        b=PxhvmBKeIcfma6BmAwqxOJGVUDe8vs0EKalgX9UQuS60smt+++lqya+6AQjh6atpaR
         VkhIRusR3RGw6AqYLvfy6cJFo99F6j/wcETIfxA0uAlE5K3a/qKLPOMjUrItyNpXnL8Q
         wBy8mB7b0qXSCw+7AAC1Tyn+cHIoNu749ReOIkK5q+28yspLhGHMHH6P6gvpBbQKHoDU
         gn1ozbqAiv+zmg8YrxKTTXpbZaCzf5fR9fWOPMMpJpOb0v6DQuao2YeIKyqN+Ww2piQz
         ukiuolFelzFLN+DyXFcDECDLl8JSFINn8jgtexgeqeNjbZ+GCEFG9OskLFSTRGg/k3hi
         Nqqw==
X-Forwarded-Encrypted: i=1; AJvYcCWEJHy/iUWql+rbBGibFBQrrBSXvKK+4fhoVn6UF2d02MqRv5jhA4lZNbcSR7KRkHv5CYvpGdU+8JiMY8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4AQ+/uLD3/WcCl7cEJ8qAv6ffH19TW6TwZ6FEh8zfO6n778tB
	l4bLX2/917AcXlaD++mueDd/sgzuTc0PYTCgSINHCJ4KZrpuNA/odv/JrS52COie2tMJXxCUZw=
	=
X-Google-Smtp-Source: AGHT+IFI3zKtjw3viIN28FavI/x8N6Vmi9ld+eUE+6cV0FsK7qbWev2ZSe6+tyHLFwzSdNJeSUW5izog
X-Received: from wmpb25.prod.google.com ([2002:a05:600c:4a99:b0:46e:2f1b:4ceb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:198b:b0:45f:29ed:2cff
 with SMTP id 5b1f17b1804b1-46e613dd3femr38614835e9.35.1759352634802; Wed, 01
 Oct 2025 14:03:54 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:05 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=ardb@kernel.org;
 h=from:subject; bh=o8h5bq3OJmsWnm3lH4s7jaZZXCXhEjYAKa43aK/6n5k=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutOs8NmwfJZcsl/9bfHnC3QmpN39NV4vzcFjwbPfeO
 t3Zis5KHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiMzIZGX7UiG1UelXjuaJP
 p+dWpvAZjY/Rm7RvvhI8tKggf5JM6BmG/1Wqi6y/rcu5rndMTeJ40MRrHqvufL95KeRz6py6z7d PufICAA==
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-25-ardb+git@google.com>
Subject: [PATCH v2 03/20] ARM/simd: Add scoped guard API for kernel mode SIMD
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implement the ksimd scoped guard API so that it can be used by code that
supports both ARM and arm64.

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
2.51.0.618.g983fd99d29-goog


