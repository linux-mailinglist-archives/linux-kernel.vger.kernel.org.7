Return-Path: <linux-kernel+bounces-827254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31839B91490
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9D11648E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092730AAC8;
	Mon, 22 Sep 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+Xu+yV8"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2B308F3D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546283; cv=none; b=aSxXDFyYGITWHVFTe0rb2N2e0xfC/LIv/12VdOAZL96f3oB6j9U2in8tFt5xEULzNH0j8dBX0JLc4o2H90skA+XeVE6Uk/UShkpVaW9Vy8AFplIWCgGoDPGE7Jz97p/WczeZ7b4ACMMxSOqjZkKoE5rBVcqcwVpIeHuYS5eKPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546283; c=relaxed/simple;
	bh=DwWRtJ3rd/CdkhxYjHs4NtsDoNLv/YDE8+Xpp6baCpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9TLeQoJAOrKVJbZGRN2eht0JOjO+skVTzDTtD6sRE/4GQyzF78mgOCGI028y4I1uGgRb6fMP+8kz8vIMtwx0alJEOC+R5FHjvpHY8x/4ehVQgGk2ZkM7MssoMcruG4cHCwpO2QXj05Rh4JIYeSwKSI+DzLHHmtXsPu8nGiAUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+Xu+yV8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee10a24246so3019082f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758546279; x=1759151079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUR5XlhmBsWXkvLElhn0cMkxqmlD65gTww2Sp2iyBR8=;
        b=A+Xu+yV8/7w8DgZUaRqFY1goVbrnavDygpUJ8S9mwv/W+YHHy4ARHHIO+PTRZlO5LW
         Kkz3/KmooOcbArz2U+sokkckiIVcVpCihAyyIlVcWRilfyXh8UjQW0exCFYQXNDGNPq7
         Vst8X4OdvX6V2NUWmlcUnbBFBPqJtToX8vrKRRcmjXIDD8IMbNh1OHqd6nXTqRQQHh24
         BtrbMAscI3bd2JTcxj0lugKa+iCWab82J4lY+vdCVf1Dg8/rP7zhLd/sfKr0shr/uvT5
         agJQUumHTozmdzWMZK7byukCkPjN76vsWbnPLSkRcM4u9/60sB3L/L8GVXyh3hYdrqaq
         9r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546279; x=1759151079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUR5XlhmBsWXkvLElhn0cMkxqmlD65gTww2Sp2iyBR8=;
        b=mnarLwntKExw1lleLQgvHVrMtJV0kQ4NF2IDa2TWsob41KatENnuoQYGGNE9DIVN9O
         0IbrCvL+7Or+y6DR4af1cTe0ZnQ6Y3QBLXe1Sovf/BeHnUYOYnX4e0Xlstax9A0ut4XR
         pgxxGAeEcAY1ASadDmFk9ZpsAbgQ2EToThB1KN2DpXsrczI6mqdM0mkn/OJIxq/iFXwS
         26DiLf/sGXV105ZXw2NTR/TdpjFUIEPhowQmDhG8APCEINeqaoNWj7dNvgP0L3Mliy9/
         VrBOTx6p07AmlLJjNVv5x1qoC3sULfQ2PoMP3JcEOiKtmxan6pqxHsMAETF+NTTSVzVT
         KmFA==
X-Forwarded-Encrypted: i=1; AJvYcCVylwPkvBd2E/XX15ILou2mlGU8GAdQKulCNm20U6CkYRzKUvR+3GtISrUycc2G7et4YYXZLbt+VSfrgh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdjqt83xy43TIX8HTpBQTUlS9Waz4zAGDYmwtp1SBMNsVM55H4
	Sg0wvQr1DpGXvqENxjETuhzKNq4Mx4RiV8ZFKwuTfCwU+AwlfV2TAylhws3R7h/yi0ycEITdjaU
	m+t+2oq5awA==
X-Google-Smtp-Source: AGHT+IEtBKpSpcNG7WXoHemURXbK3vDWac5r7lnyDOiYg4Vglm5g7x0+IvtA9rmKqvE/dsv0G1maA9DGUunn
X-Received: from wrhb2.prod.google.com ([2002:adf:c742:0:b0:3df:3aeb:c0a8])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c05:b0:3ee:11d1:29dd
 with SMTP id ffacd0b85a97d-3ee83da00e7mr9797391f8f.35.1758546278683; Mon, 22
 Sep 2025 06:04:38 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:04:26 +0000
In-Reply-To: <20250922130427.2904977-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922130427.2904977-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922130427.2904977-2-abarnas@google.com>
Subject: [PATCH v2 1/2] arch: arm64: Fail module loading if dynamic SCS
 patching fails
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Disallow a module to load if SCS dynamic patching fails for its code. For
module loading, instead of running a dry-run to check for patching errors,
try to run patching in the first run and propagate any errors so module
loading will fail.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/arm64/include/asm/scs.h      |  2 +-
 arch/arm64/kernel/module.c        | 12 ++++++++++--
 arch/arm64/kernel/pi/map_kernel.c |  2 +-
 arch/arm64/kernel/pi/patch-scs.c  | 10 ++++++----
 arch/arm64/kernel/pi/pi.h         |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index a76f9b387a26..c59f6324f2bb 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -53,7 +53,7 @@ enum {
 	EDYNSCS_INVALID_CFA_OPCODE		=3D 4,
 };
=20
-int __pi_scs_patch(const u8 eh_frame[], int size);
+int __pi_scs_patch(const u8 eh_frame[], int size, bool skip_dry_run);
=20
 #endif /* __ASSEMBLY __ */
=20
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 40148d2725ce..d32ab7dd86a8 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -484,10 +484,18 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (scs_is_dynamic()) {
 		s =3D find_section(hdr, sechdrs, ".init.eh_frame");
 		if (s) {
-			ret =3D __pi_scs_patch((void *)s->sh_addr, s->sh_size);
-			if (ret)
+			/*
+			 * Because we can reject modules that are malformed
+			 * so SCS patching fails, skip dry run and try to patch
+			 * it in place. If patching fails, the module would not
+			 * be loaded anyway.
+			 */
+			ret =3D __pi_scs_patch((void *)s->sh_addr, s->sh_size, true);
+			if (ret) {
 				pr_err("module %s: error occurred during dynamic SCS patching (%d)\n",
 				       me->name, ret);
+				return -ENOEXEC;
+			}
 		}
 	}
=20
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_k=
ernel.c
index 0f4bd7771859..7187eda9e8a5 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -98,7 +98,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_of=
fset, int root_level)
=20
 		if (enable_scs) {
 			scs_patch(__eh_frame_start + va_offset,
-				  __eh_frame_end - __eh_frame_start);
+				  __eh_frame_end - __eh_frame_start, false);
 			asm("ic ialluis");
=20
 			dynamic_scs_is_enabled =3D true;
diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patch-=
scs.c
index 55d0cd64ef71..bbe7d30ed12b 100644
--- a/arch/arm64/kernel/pi/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -225,7 +225,7 @@ static int scs_handle_fde_frame(const struct eh_frame *=
frame,
 	return 0;
 }
=20
-int scs_patch(const u8 eh_frame[], int size)
+int scs_patch(const u8 eh_frame[], int size, bool skip_dry_run)
 {
 	int code_alignment_factor =3D 1;
 	bool fde_use_sdata8 =3D false;
@@ -277,11 +277,13 @@ int scs_patch(const u8 eh_frame[], int size)
 			}
 		} else {
 			ret =3D scs_handle_fde_frame(frame, code_alignment_factor,
-						   fde_use_sdata8, true);
+						   fde_use_sdata8, !skip_dry_run);
 			if (ret)
 				return ret;
-			scs_handle_fde_frame(frame, code_alignment_factor,
-					     fde_use_sdata8, false);
+
+			if (!skip_dry_run)
+				scs_handle_fde_frame(frame, code_alignment_factor,
+						     fde_use_sdata8, false);
 		}
=20
 		p +=3D sizeof(frame->size) + frame->size;
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index 46cafee7829f..220da972cce1 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -27,7 +27,7 @@ extern pgd_t init_pg_dir[], init_pg_end[];
 void init_feature_override(u64 boot_status, const void *fdt, int chosen);
 u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
-int scs_patch(const u8 eh_frame[], int size);
+int scs_patch(const u8 eh_frame[], int size, bool skip_dry_run);
=20
 void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
--=20
2.51.0.534.gc79095c0ca-goog


