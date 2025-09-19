Return-Path: <linux-kernel+bounces-824510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA33B896EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB101CC066A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D5311598;
	Fri, 19 Sep 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6/lpI0t"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0213093A5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284614; cv=none; b=eyjVuMMYdi8xhosAw3R0HlhWX0gT8uXCiBU0tfy1opzSUqMCrgG+kvMIYH5XAcsdeII6x6USHZFXwvVdblQ4o2RkvXVHpIorarwykoLeHO2GmAMWXmpgkj8F19Le9wSmyqpLfYTeR44kLCXrOSea06JK5viqtnYd32Ry4YxhmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284614; c=relaxed/simple;
	bh=PsO2XWHbF1yz3I3qxvPS4s5niHFvbCHeVXiIUEgUUwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJ8fF8Gu8wxO3q9HBx2oe7L2OIrriAtOVZeVaqclaSuQqLCUqcC5ISCMeasKgP5Ci6B2LvawNGQTifOoMBDsk0cJREWZ6/4//ZqodihiWiRycPdhiUB/g6B54K11isrSqdE/H7W1DucWDokj55AI/mtRlVu8tow6IPjDZsyIet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6/lpI0t; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so12996625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758284611; x=1758889411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2uPr5tRXP/hZXMndHpWASprs+At28VaxqR7vlo3oA8=;
        b=M6/lpI0tzIwaIdro2Frdmz7JJB6hDvGrvjgy7OnGG7n4XFZuByb+qOjdxN7rr9guez
         TQCXWZDK/swTa6/8XtNv1un6umO1APjhxDERM/SueRnp7WPU8qd893oWRukYdZhjgnLh
         n/HWi9O94ySo1x1duMv6phMv8O+xYCBpPXtLEPNwWc6Q3retM3Ni/CVwJ66l4uCaR8OO
         wXXK4hvZfNmyTfJAStOWK8xpSK9ullZKsPgkcZjp3u/vQoJ9hPtnDjQ8LYt6dGRwmfBM
         rIkdPQNhOQn4mg/7oem4O3I0AJLNMVgLhSnY3dz+4q+20912SAW30eCG3e/eiVBJv2R4
         JNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284611; x=1758889411;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2uPr5tRXP/hZXMndHpWASprs+At28VaxqR7vlo3oA8=;
        b=iam4FcBV7eBQmSmXAF6isDXivAkEqWbYPlwFSxJU2Gq8mI1rkJfNzoFRbpKCLUDU2y
         ndysJnDr0VBQ5ONnPeg5X03DcDdzQSAGrS7qpvUKl8AP5UOdS0nTGZ+RKogarfxhcfso
         PeiBbU6XMt+wTwKnPIvNCvliwK1WJIdg2KVw/NxGE4vw63JMMasEJqXfqh3DrVAkcU9Z
         YtSE66hKnsG+y5rGwYqTm7qiMwR3EQwKB1lgJrJDiLwFPFOGK1iaKrr4wNB6FAuMddTs
         yLv50IS0+jdeoto0BEuNIFXE7oDeWV/6EW8zNqgKPjSBIhc8TSkHyYdkhw2ZSd1Racth
         oUnw==
X-Forwarded-Encrypted: i=1; AJvYcCV5wXodbeWD3bc11eUk5mFEwdJfmmggBZv4bBD44oqw2A3hlsP45T33h+qEEnb2J5vDEsPuEzyWVe4Pq2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr5aV04yul7Iq2ChqBEHaWq6HxuxxdqPUsN+/sOlmYT1FpNwz
	10BugOJllzVtUe3BLiKGAB4+WhUP/cQRHAnDrUdWj6cnrQ1ftwP+99FrWSr9NSfiKmvjCWz3Gcm
	dXHwR7amP3w==
X-Google-Smtp-Source: AGHT+IG9GaXAZcjoq+ISPuOX7adIMdWJfDgiabm1SFO2WPOJbmJQLNLDFi21OpBUSrPr+CFdPSZdvz2oMtje
X-Received: from wmbbi11.prod.google.com ([2002:a05:600c:3d8b:b0:45b:7580:5aa])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4714:b0:45b:615c:cd2
 with SMTP id 5b1f17b1804b1-467e6b64fb2mr29795115e9.8.1758284611101; Fri, 19
 Sep 2025 05:23:31 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:23:20 +0000
In-Reply-To: <20250919122321.946462-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919122321.946462-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919122321.946462-2-abarnas@google.com>
Subject: [PATCH 1/2] arch: arm64: Fail module loading if dynamic SCS patching fails
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
 arch/arm64/kernel/module.c        |  6 ++++--
 arch/arm64/kernel/pi/map_kernel.c |  2 +-
 arch/arm64/kernel/pi/patch-scs.c  | 15 +++++++++++----
 arch/arm64/kernel/pi/pi.h         |  2 +-
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index a76f9b387a26..ffcfcda87f10 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -53,7 +53,7 @@ enum {
 	EDYNSCS_INVALID_CFA_OPCODE		=3D 4,
 };
=20
-int __pi_scs_patch(const u8 eh_frame[], int size);
+int __pi_scs_patch(const u8 eh_frame[], int size, bool is_module);
=20
 #endif /* __ASSEMBLY __ */
=20
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 40148d2725ce..5d6d228c6156 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -484,10 +484,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (scs_is_dynamic()) {
 		s =3D find_section(hdr, sechdrs, ".init.eh_frame");
 		if (s) {
-			ret =3D __pi_scs_patch((void *)s->sh_addr, s->sh_size);
-			if (ret)
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
index 55d0cd64ef71..78266fb1fa61 100644
--- a/arch/arm64/kernel/pi/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -225,7 +225,7 @@ static int scs_handle_fde_frame(const struct eh_frame *=
frame,
 	return 0;
 }
=20
-int scs_patch(const u8 eh_frame[], int size)
+int scs_patch(const u8 eh_frame[], int size, bool is_module)
 {
 	int code_alignment_factor =3D 1;
 	bool fde_use_sdata8 =3D false;
@@ -276,12 +276,19 @@ int scs_patch(const u8 eh_frame[], int size)
 				return EDYNSCS_INVALID_CIE_SDATA_SIZE;
 			}
 		} else {
+			/*
+			 * For loadable module instead of running a dry run try
+			 * to patch scs instruction in place and trigger error
+			 * if failed, to prevent module loading.
+			 */
 			ret =3D scs_handle_fde_frame(frame, code_alignment_factor,
-						   fde_use_sdata8, true);
+						   fde_use_sdata8, !is_module);
 			if (ret)
 				return ret;
-			scs_handle_fde_frame(frame, code_alignment_factor,
-					     fde_use_sdata8, false);
+
+			if (!is_module)
+				scs_handle_fde_frame(frame, code_alignment_factor,
+						     fde_use_sdata8, false);
 		}
=20
 		p +=3D sizeof(frame->size) + frame->size;
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index 46cafee7829f..4ccbba24fadc 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -27,7 +27,7 @@ extern pgd_t init_pg_dir[], init_pg_end[];
 void init_feature_override(u64 boot_status, const void *fdt, int chosen);
 u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
-int scs_patch(const u8 eh_frame[], int size);
+int scs_patch(const u8 eh_frame[], int size, bool is_module);
=20
 void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
--=20
2.51.0.534.gc79095c0ca-goog


