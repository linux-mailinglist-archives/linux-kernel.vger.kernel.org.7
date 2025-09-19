Return-Path: <linux-kernel+bounces-824511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C7B896F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD57B88F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233F31076C;
	Fri, 19 Sep 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsI8B52q"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDC273810
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284615; cv=none; b=UQNHI95x8y88/oNZToAEF1srK72JuZY8M2jD8aGwMNkTqp1jxr6UZVQApgVEdI4K2uQ+1VpdC+9YNl9wHPCtbjWxyJJ0DycgilFsnPkE+g/YEl8vsTUjCBUG/9NEqylxJaQkVU8exlUVV0HIDbbjLCJmkhT/J5qb7KCyH1q7Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284615; c=relaxed/simple;
	bh=tAoJj8QUNo3whIuZ6bjZkGG24LElC39BstV8LKgyEC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EcB1YqT9qFejh8sU6RVoGYyZr4TO0RcEtrA8TI+Nvh9PVBi4a5sNE4mBzXJi3do9w80QVXLIXLiLixrAtoaqN3vmPrc7WlM8hpcVS2eWycDhb0F+Ta94pLMAKRYDtHF5NLd2Tpmstv3ifjfVRccaf3I5wIdxOVuB99+0+V1bkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsI8B52q; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so763534f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758284612; x=1758889412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo/jsgLDkKISW5zIp48cnqAjqbEM5L00IhYTKUc6Zus=;
        b=xsI8B52qfF9P0WpAixog1ksyX7XkDEo9CV4UXq2sRSHaUhe66uH8NevoTXiLw+SaBS
         5Ud918uQ+YpPXgWqlkXYvNbB9sKCVoKZ+Ow+93vPO3r8OxE+jqpRIo6A0aZJGVJtspNY
         xvVyjeiuHa/BSRnNgw0ybWP75WMeQ4Yg1kQPdrt/puwsrA8UYEbh8nxy3XjCc1dFJc6X
         BdA3wPr6JCyUtMUNauNgLGdg431SuLzcqBuT8LUAM9XZbr8vEnFMjw4zg9ea+cl7w6Va
         HlGkAbqOm1ZPm7G5y9HDaKXBkiQa5fiIC90B3KC5vAp2Cism66Pr/4gLM6+OgTOFVRFO
         NpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284612; x=1758889412;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qo/jsgLDkKISW5zIp48cnqAjqbEM5L00IhYTKUc6Zus=;
        b=LokrtN4ytzFCiHpJXcqCQWr68kytBZKM1fPE+EaMcFtyobGdaAuEErXs7ilt8T7qrU
         6xySe888dqicaArvbkQtrUE5kbfg2uV9y5VAzNNzFGEQKsKL8X/DFmmHIm3Fj0bYOPyU
         A5L2bXXG5ZMePp7HZDlioOzSenw/56JRHjvYHgMPMPCWX8aGvT7H6YvPnnvy0ESHiGac
         YCjj9X+pLqW59Ie390JJx27iAZTbXdOtBB0dzuDZ5nGINyVuE4DFt51uyQengasY0kfP
         8aBTnfZ9sMRSAYZs8dfdoGZLPM5At+mdrEppahd001/IxkMfo36bpYld2B7USdhNFYF8
         r2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXGrPCQHYaTKqBz6o6mer+6OMJCzUj3lLyGDUHKv8yrXBH+QXHLJv8D4WLHf/WgoozA9m14Y7upP++tx1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IW9cd5TmGOAIH3FrKzxhggBM9vsetQjIwA76v62bINZ831l4
	y0UnJypnKD+4/LgNylPCFGL2AZDDg9FWI59DcOZHUCcVl+hCN5t8GD7o1btv86rczXV/KJ4Nqx/
	hynqsE2ixOw==
X-Google-Smtp-Source: AGHT+IGdt2aMsHWTbWqIY3RHkP6ROCYcuLniubso42syhOjvPfHbKaGtZwHfzgKMLU5xJCioFirjKtfTBlCu
X-Received: from wmbip15.prod.google.com ([2002:a05:600c:a68f:b0:45d:d39b:53ca])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2404:b0:3e7:4697:297a
 with SMTP id ffacd0b85a97d-3ee7e106157mr2318421f8f.24.1758284611916; Fri, 19
 Sep 2025 05:23:31 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:23:21 +0000
In-Reply-To: <20250919122321.946462-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919122321.946462-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919122321.946462-3-abarnas@google.com>
Subject: [PATCH 2/2] arch: arm64: Reject modules with internal alternative callbacks
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Fanqin Cui <cuifq1@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During module loading, check if there is a callback function used by the
alternatives specified in the '.altinstruction' ELF section and block
loading the module if such a function is present.

Reported-by: Fanqin Cui <cuifq1@chinatelecom.cn>
Closes: https://lore.kernel.org/all/20250807072700.348514-1-fanqincui@163.c=
om/
Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/arm64/include/asm/alternative.h |  4 ++--
 arch/arm64/kernel/alternative.c      | 15 ++++++++++-----
 arch/arm64/kernel/module.c           |  8 ++++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/=
alternative.h
index 00d97b8a757f..6eab2517c809 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -26,9 +26,9 @@ void __init apply_alternatives_all(void);
 bool alternative_is_applied(u16 cpucap);
=20
 #ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length);
+int apply_alternatives_module(void *start, size_t length);
 #else
-static inline void apply_alternatives_module(void *start, size_t length) {=
 }
+static inline int apply_alternatives_module(void *start, size_t length) { =
}
 #endif
=20
 void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternativ=
e.c
index 8ff6610af496..69fae94c843a 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -139,15 +139,18 @@ static noinstr void clean_dcache_range_nopatch(u64 st=
art, u64 end)
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
 	alternative_cb_t alt_cb;
=20
 	for (alt =3D region->begin; alt < region->end; alt++) {
+		if (ALT_HAS_CB(alt) && is_module)
+			return -EPERM;
+
 		int nr_inst;
 		int cap =3D ALT_CAP(alt);
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
index 5d6d228c6156..aeefc50229e3 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -478,8 +478,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 	int ret;
=20
 	s =3D find_section(hdr, sechdrs, ".altinstructions");
-	if (s)
-		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+	if (s) {
+		ret =3D apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+		if (ret < 0)
+			pr_err("module %s: error occurred when applying alternatives\n", me->na=
me);
+			return ret;
+	}
=20
 	if (scs_is_dynamic()) {
 		s =3D find_section(hdr, sechdrs, ".init.eh_frame");
--=20
2.51.0.534.gc79095c0ca-goog


