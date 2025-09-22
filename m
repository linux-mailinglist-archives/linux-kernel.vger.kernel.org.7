Return-Path: <linux-kernel+bounces-827255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0EB91493
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184781889676
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D99330AADA;
	Mon, 22 Sep 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMRH8qs2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4C3093CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546283; cv=none; b=PsWtqGFiXYbZRD6M+lpCzjTginOhsyh6QUo1f7rU5PFBmqWVjH4pjeKYnngSXcCmA8QTXPQ18gT7DR9w2QBxgeCHF6F0P1vlrIxThay3pnCXjgyf/pXQ3DBf/H/0aOZlqVhEY1Wj3Ea2PnmYgVE+azwz3yYTs3Nff4LT7mi6dwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546283; c=relaxed/simple;
	bh=FMYoIbZiYa0DS1g8RqN8iMEHg5Ih56HvWTWA1nUUjns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dtZ7FNZLtm4y/jIRmhtYGU+kdnRmR5gCCgQuZ3P6PwcMD5a7gIyahkqmLBYDc9ROpeAl8DaWGG6o/kbrKYfsuQhYwXzVK8ws9WTTm8cs97zKZsrhKfyNmDZa3KA8xWzbg5qQ98rhfaK4hyv2rGzKZq/myYNyeyF9tMPaqncZ+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMRH8qs2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de27bf706so24218245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758546280; x=1759151080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwElNbtoU6ryjkvg9ptzkO1BXP1SQnPo2fMtx+HCV1o=;
        b=vMRH8qs2UGP1wU3xBEJ92i+Wuw4VAsCQcgypji8gA21KZCbOcYw4tKPj9cBGrAV5Nq
         FUgOkg2A2v8RLLyXMNm4vTixJiNYPlyRUVzzOg/CbVN5Oukn5nQUYCPMrwhczfMY2A0X
         wYKuZae8nRrRZPSWwLQ6D2eYI37N6IPF7NubbOcTkRQpobxM+7gasIeYBcag+mCe6kU1
         KZb7favcWFSLd6Kzba43UJ1k9q6aLOm1iDdkuJAyuafIn66ZPG/XN0L4nkcapNwO5+Ig
         LMk/D8zU4GDZ+6+4x8GUJwNg2e3sawV5JIudyfyMGlNs/p1REFH4m61hIBkmYlzi0B9L
         opjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546280; x=1759151080;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JwElNbtoU6ryjkvg9ptzkO1BXP1SQnPo2fMtx+HCV1o=;
        b=smE/5IolTHGyUPw1rDa3bq9TG/6AEUu8kRG5e2dEaqUhmokN0ouR5ZPgWldKQmFU1M
         qJhiQ0SQdfD9ycjnFogUQ/U2f1lxm8Z/oYec6XPA08NT2UqgGd//clGqi1WdeFXkMsDd
         HFr2sCXpQ3+AioOUM3rOs+5uYkLTCf+2zTmsbem+akYtGH7eYFcqygIbESNiYI3zbFVk
         BZOlCsPKyGDtv/vqrUU/5XOJbTgSH28ngcNJRqkqy1x8dJCDojcSzwmq5eKWIiEYfk5g
         NRM2cA/ZvoXRhzpYpfKLOb7H8nB3RmQQ3YFUaEs51w2I6aVgYJUkkEPwHUNkBbxxtVzt
         Vc9g==
X-Forwarded-Encrypted: i=1; AJvYcCW2G9AW9DEnl1VfGpltJRW+cihiAa0gwnJpYiOpC2ngdW6hy94hzwyMo5UNdUJrhbD0zi/vrRo66plbulk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhMgiUbsbPSwwRKUsWwCz6bzqwmHvhvVszrK+r+rJvep8wIep
	dkRSSsrRhCCZ6S5vhKA+twIUFsfOZfDQnTLB2v9EgGazwd7QmPtigxKD2t932pZhMQw2edL0Q51
	o8+6gBHHRzw==
X-Google-Smtp-Source: AGHT+IEDFD3rxKYHYkV6r/KD3nctDYqhuTTynS2EvYjFqxAQWJnCTSezVvcxkZmuveyS5xGnrwZ/qy15N5O/
X-Received: from wmbez5.prod.google.com ([2002:a05:600c:83c5:b0:45f:2d07:91f9])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:630e:b0:46c:9e81:ad0
 with SMTP id 5b1f17b1804b1-46c9e904ffamr39494195e9.0.1758546279719; Mon, 22
 Sep 2025 06:04:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:04:27 +0000
In-Reply-To: <20250922130427.2904977-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922130427.2904977-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922130427.2904977-3-abarnas@google.com>
Subject: [PATCH v2 2/2] arch: arm64: Reject modules with internal alternative callbacks
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Fanqin Cui <cuifq1@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During module loading, check if a callback function used by the
alternatives specified in the '.altinstruction' ELF section (if present)
is located in core kernel .text. If not fail module loading before
callback is called.

Reported-by: Fanqin Cui <cuifq1@chinatelecom.cn>
Closes: https://lore.kernel.org/all/20250807072700.348514-1-fanqincui@163.c=
om/
Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/arm64/include/asm/alternative.h |  7 +++++--
 arch/arm64/kernel/alternative.c      | 19 ++++++++++++-------
 arch/arm64/kernel/module.c           |  9 +++++++--
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/=
alternative.h
index 00d97b8a757f..51746005239b 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -26,9 +26,12 @@ void __init apply_alternatives_all(void);
 bool alternative_is_applied(u16 cpucap);
=20
 #ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length);
+int apply_alternatives_module(void *start, size_t length);
 #else
-static inline void apply_alternatives_module(void *start, size_t length) {=
 }
+static inline int apply_alternatives_module(void *start, size_t length)
+{
+	return 0;
+}
 #endif
=20
 void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternativ=
e.c
index 8ff6610af496..11893a0360ad 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -139,9 +139,9 @@ static noinstr void clean_dcache_range_nopatch(u64 star=
t, u64 end)
 	} while (cur +=3D d_size, cur < end);
 }
=20
-static void __apply_alternatives(const struct alt_region *region,
-				 bool is_module,
-				 unsigned long *cpucap_mask)
+static int __apply_alternatives(const struct alt_region *region,
+				bool is_module,
+				unsigned long *cpucap_mask)
 {
 	struct alt_instr *alt;
 	__le32 *origptr, *updptr;
@@ -166,10 +166,13 @@ static void __apply_alternatives(const struct alt_reg=
ion *region,
 		updptr =3D is_module ? origptr : lm_alias(origptr);
 		nr_inst =3D alt->orig_len / AARCH64_INSN_SIZE;
=20
-		if (ALT_HAS_CB(alt))
+		if (ALT_HAS_CB(alt)) {
 			alt_cb  =3D ALT_REPL_PTR(alt);
-		else
+			if (!core_kernel_text((unsigned long)alt_cb))
+				return -ENOEXEC;
+		} else {
 			alt_cb =3D patch_alternative;
+		}
=20
 		alt_cb(alt, origptr, updptr, nr_inst);
=20
@@ -193,6 +196,8 @@ static void __apply_alternatives(const struct alt_regio=
n *region,
 		bitmap_and(applied_alternatives, applied_alternatives,
 			   system_cpucaps, ARM64_NCAPS);
 	}
+
+	return 0;
 }
=20
 static void __init apply_alternatives_vdso(void)
@@ -277,7 +282,7 @@ void __init apply_boot_alternatives(void)
 }
=20
 #ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length)
+int apply_alternatives_module(void *start, size_t length)
 {
 	struct alt_region region =3D {
 		.begin	=3D start,
@@ -287,7 +292,7 @@ void apply_alternatives_module(void *start, size_t leng=
th)
=20
 	bitmap_fill(all_capabilities, ARM64_NCAPS);
=20
-	__apply_alternatives(&region, true, &all_capabilities[0]);
+	return __apply_alternatives(&region, true, &all_capabilities[0]);
 }
 #endif
=20
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d32ab7dd86a8..6e5b488a219e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -478,8 +478,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 	int ret;
=20
 	s =3D find_section(hdr, sechdrs, ".altinstructions");
-	if (s)
-		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+	if (s) {
+		ret =3D apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+		if (ret < 0) {
+			pr_err("module %s: error occurred when applying alternatives\n", me->na=
me);
+			return ret;
+		}
+	}
=20
 	if (scs_is_dynamic()) {
 		s =3D find_section(hdr, sechdrs, ".init.eh_frame");
--=20
2.51.0.534.gc79095c0ca-goog


