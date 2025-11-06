Return-Path: <linux-kernel+bounces-888522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6642C3B0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6083E504614
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF9033DECB;
	Thu,  6 Nov 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1M8DFEq"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D632ED3C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433624; cv=none; b=VUkXpF/SOgXO2IILq8wUtmea7HQxWVUQ5eYSKXvQUqUOXQRgvUP4iUx2v6yIpxt+67nc23ckil8dCv+K0NevPzRAvichMEL8rUmbzToA0ls/Spz0K/CzfNK1ngdDvPG3kK37XfANMq/taSG6ZYt+64EiA6loBxL9DNJUb7UmHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433624; c=relaxed/simple;
	bh=yJ5nI4Pj/e2l438vacBXP4YBnLRHauWN7FXlZehjs1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uflxk0WZ83sU7AF7Jz2sJR5C5KbC9D2z+Cc9oGWs6L3tK6n97b1PKeZ2qay91oK7VRTNM5CJm8NvraqJ3pkfYJhSJlQVWNIEznDbOdFNMidgxRwDpXoY2EvzRMb21jxtqgGlgshbQNAwVReuVzprO6nk4O4fcwcJzntU9Aum7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1M8DFEq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bcddad32so702271f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433621; x=1763038421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeQ1qQssRNVDy6SgVbDGPxE08ddX4PJBvQHFLhXifeI=;
        b=R1M8DFEqJCZQNRUjCVDryhHFk+KbSPp/UeHeOYMK/0OApOx3+K6WAuh0SAFowvafHM
         9y3tkfibNU8uQVw/GqI2XYG/V+CViA4IBiwns9LtV0ehBY3P99bSOL+9QPbAGi5tq/up
         +srnFNoutTJtEzRGmcbjoWEgCRglm/0IuTH4Iom4yKIfFjqFGs6pOX8miioZsCaxWNQf
         y9MzTneQQLrePWQRulg3HRtNvtJBrmzvzvooObwDssixwjbulUvnG0TJMrtgTCED3qKX
         COA4EmpyiprnpDYKLpys4vb1dW4q3pGV1OXcFH0AYrKEJx9NjccyXnd+Zs+1/Gn1agn/
         uraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433621; x=1763038421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeQ1qQssRNVDy6SgVbDGPxE08ddX4PJBvQHFLhXifeI=;
        b=JTIrVBKQvZeIV0hANR1r60g3wf3esmLI6hayXWI40wCBaeb+kHaNOGI+kHwIjk//Fb
         OYBAqfJOxY45C64x3GU95zh64JDG9HMZU1UWi6lj/SQ48aUFU16o50Oe+u2wekKEAtHt
         +Xo29z50/UxSBb2bK1qrgiofl+SAZAurHytfnWXO12F7HNteBrVY/I/iNTMR4SyYdtOT
         l40wH5JE1sPJZ6lPwbXZyIR5gOqPGkIjVICbblCQ9YRvSNCTKcE56sJtA0uWotA86V5m
         F3w84o7uUEyyKG6FIu4d31VNTsu8EdEWsAJwkVDD38lppDi3m2/CdnMpQIptDM1w51uu
         XIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHRiMnxpESKGjuCkan0YgNJwMIecRtnfyv+uShkRrs/6HwghGxz07Xtpvm1kgoeBI+Vaptqe3hZgn5AF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUxfp//+YzSmVZXIpDPrel9FOpXVLafz3pGK7PxYpq43U+rqd
	fvJ6t9Gh/j15NofmWkORA4UeXEPFDWSkS6r5lV2NQkJTNqPj+JiERDc=
X-Gm-Gg: ASbGncuncQu1EdcVbuZ4gSJa9bLxmlGStmRg6Kt7LC5NRu9YjRMYEkDIAt617ZP4xp6
	UfGvIUYBKEuYfGE0YIJkRuIrxa43wWNgu7pAsEjVExdlzHHWmQ64ye8hgNljg/HVDn0OxBiKk4g
	vK63NbmOoSVaUG27V8f/hWLfGgw5mIwI39hJYaL6Rt/+dySTrK61dRx8aZpzo0ZbZX/yMDMY+sW
	+eHDC9Dvmy9R6J5HYDRrcIcQhjvGAzkii54P4xQEKDU4ITZYHeLglN5hUiqa+WL2piPNFYkBcrZ
	zVg/1hfUe1F5GKyQvOUdKtYcGtOBOnxi2QbY+nz3QHrzLmRlBDGKjqPATYqjAqITZvCc2Eu+8CW
	3B4W57qFIxXzlw6kWp8j+kkoyadWTJFEnc9xHezl3sceTZWPGTKIlozV+tlmxMI6m8KXqozFGzl
	iysvdM/lgI4I8mrdJHvs5SbFb6ohC8/EJ0WIur7BaCTSlaKXvLRqsnJJwNAO0w7uRGCg==
X-Google-Smtp-Source: AGHT+IGmXXB3sYTtNVijmZK/dE1I0XwRMENPcN7ucBxdXqW1KCxYeITYB9d4TFOdh1oLXlDVTdzeLg==
X-Received: by 2002:a05:6000:2304:b0:429:c505:8cb1 with SMTP id ffacd0b85a97d-429e3333c80mr6684600f8f.52.1762433620557;
        Thu, 06 Nov 2025 04:53:40 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:40 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 08/17] bpf: Track mov and signed extension
Date: Thu,  6 Nov 2025 13:52:46 +0100
Message-Id: <20251106125255.1969938-9-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `bcf_mov()` helpers to model MOV/cast operations in `bcf_track()` and add 
calls into ALU processing paths. The helpers extract the source to the target
width and apply zero/sign extension to the final width as needed.

- For MOV32, build a 32-bit expr for src and zero-extend it.
- For sign-extending MOVs (s8/s16 to W, or s8/s16 to R), extract the sub-width
  and sign-extend to 32 or 64.
- If the destination is known-constant, clear `dst_reg->bcf_expr` (-1) to avoid
  carrying redundant symbolic nodes.

These routines are only active when `env->bcf.tracking` is set. They are called
from `check_alu_op()` in the relevant MOV/SEXT cases.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7b6d509c773a..4491d665cc49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15959,6 +15959,57 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int bcf_mov(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+		   struct bpf_reg_state *src_reg, u32 sz, bool bit32, bool sext)
+{
+	int src_expr, ext_sz, bitsz = bit32 ? 32 : 64;
+
+	if (!env->bcf.tracking)
+		return 0;
+	if (tnum_is_const(dst_reg->var_off)) {
+		dst_reg->bcf_expr = -1;
+		return 0;
+	}
+
+	src_expr = bcf_reg_expr(env, src_reg, bit32 || sz == 32);
+	if (sz != 32) /* u/s16 u/s8 */
+		src_expr = bcf_extract(env, sz, src_expr);
+
+	if (sext) {
+		ext_sz = bitsz - sz;
+		dst_reg->bcf_expr =
+			bcf_extend(env, ext_sz, bitsz, true, src_expr);
+		if (bit32)
+			bcf_zext_32_to_64(env, dst_reg);
+	} else {
+		ext_sz = 64 - sz;
+		dst_reg->bcf_expr =
+			bcf_extend(env, ext_sz, 64, false, src_expr);
+	}
+	if (dst_reg->bcf_expr < 0)
+		return dst_reg->bcf_expr;
+
+	return 0;
+}
+
+static int bcf_mov32(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		     struct bpf_reg_state *src)
+{
+	return bcf_mov(env, dst, src, 32, true, false);
+}
+
+static int bcf_sext32(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		      struct bpf_reg_state *src, u32 sz)
+{
+	return bcf_mov(env, dst, src, sz, true, true);
+}
+
+static int bcf_sext64(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		      struct bpf_reg_state *src, u32 sz)
+{
+	return bcf_mov(env, dst, src, sz, false, true);
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -16084,8 +16135,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
-						if (!no_sext)
+						if (!no_sext) {
 							dst_reg->id = 0;
+							err = bcf_sext64(env, dst_reg, src_reg, insn->off);
+							if (err)
+								return err;
+						}
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
@@ -16110,8 +16165,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * range otherwise dst_reg min/max could be incorrectly
 						 * propagated into src_reg by sync_linked_regs()
 						 */
-						if (!is_src_reg_u32)
+						if (!is_src_reg_u32) {
 							dst_reg->id = 0;
+							err = bcf_mov32(env, dst_reg, src_reg);
+							if (err)
+								return err;
+						}
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -16120,8 +16179,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
-						if (!no_sext)
+						if (!no_sext) {
 							dst_reg->id = 0;
+							err = bcf_sext32(env, dst_reg, src_reg, insn->off);
+							if (err)
+								return err;
+						}
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
-- 
2.34.1


