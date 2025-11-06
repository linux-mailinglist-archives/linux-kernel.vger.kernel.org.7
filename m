Return-Path: <linux-kernel+bounces-888524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF47C3B10E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879FE188A0AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7433DED1;
	Thu,  6 Nov 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f85kQUa5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75F330335
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433626; cv=none; b=j2OOCzP0PVidCA74tbs+4Y3RX+JY6mR9nVx5aXdlLT9GnTTSoTC50QlE9ed0Yc5kUcNK21u44dP2jkqa8zsIQ34IqeVRi+dYOXguwp217O62ubmqgCKqTMwtO4oNXbCa7RTNCn9dolTIXi+jyb7KFSeTKtdSrlab6/ZjhFQUamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433626; c=relaxed/simple;
	bh=bcHRGOqbqzzhPFu+ojNR6wxaw6xjv4kXNLSndDc36ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua2oyyLnnojIuDbLqAc4FcCTuj6TM4+wKmjQtxmVEXTxoqvyF9hI4Hfn/R/NcTZ5Vv/+CoNd9Qs1yKppjyWRscRwCwfpMg1UfaK4cJIvnW3o1ALFrsIYeuazozsu3j1Uyo7rbaSBhcSXDszK7SphXP+3w5lBR4GfABu6YWejbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f85kQUa5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so651313f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433622; x=1763038422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjCst0RmwR8vxuLUXqKmfS8QPtIrCS1B+n9Hqasdjnw=;
        b=f85kQUa5iJSxf0Et/ff+m7JLvsgQzLhg2mQongDbZuAGXkCAUW//misPdEBKj4hOes
         kc5h4kTctIZBVISZ2MY7y2EOQLe0AAnu/VFSXlQhISObgOIdQt9V52zxAzVXrmJm+/Gv
         y2dlS/LSBB6SqaQhvJpd72gfY037Zc5oksQhJy+SdvOS53Fvoq4y6SFnkVHtw14lYFvd
         6ONOUcRXdLlWUrC/yWZhdbob5iaMBl+xDR7D/sh8hzR7gu2lMo8z3HVXI0yaQm3BW36z
         wiurrTWyqwzSBsQFZZP0f9lVxBM/iFDGN3Ca7BRw0yyMIhRDNLSdTAYvcWsx36c1gWCI
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433622; x=1763038422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjCst0RmwR8vxuLUXqKmfS8QPtIrCS1B+n9Hqasdjnw=;
        b=atY4In1PmojG+kQmoF6ze5Nxs1GJ2mj/9R+/EGEhpgbvs7d6ENg3tzqAo/g/85cJq8
         EWvFD2nc3iRX3BN+fSQ+cPvbG/B4Ikwl9V0kPVqzqr5yWeWouJSL5YjAIGzrulb03/oo
         0uEHKQLtI2tO/pKkMeuQ27XN+4nE2FLSaKLyWkcVh6bVTDFmgcdJDCF3C9Z1bBpcAVH9
         fg0rgw9YXY+nFS15IWeXcnFiXceKZwG2g7ndYc2EMfWCnQxWj/glPw3y/A9rK3buPb1+
         MmIWmU2mFbIczTyPne5KkkznzuNNUgodR1IWTBVdg6tm+5tU66yeNyAiEByQpmHXeZA1
         syzw==
X-Forwarded-Encrypted: i=1; AJvYcCUJCiSqUVXSzYU08PVslMDvM6+GLUmoAKGIXhQFG5pZKP+/kqyrUs7j/fMqrNqsDXA9J3mffKO0SEJsgPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQafqgcqt5Y9r2TTK+4QC/NSxCno4EyuRPgiO5IfIdgyxvWwYW
	1R+1Qd4xh5Dw3doIppYvoFx03y39IrJeXTLlwWqX1jnv7IO6/w27GKY=
X-Gm-Gg: ASbGncsdyuHwh6YX7Y243aBcDRZ2+ulXQxPLgSuK/uy1dEnj1SfmeOTm2+sFjBz66G3
	wWgoaNIo2bXOeJsSfrGrBzY6dlpG1zBn1nlsG/r5YFEEKeToZnlaVan+C3+KwkslqqjnbOr+Yq8
	XnNiYtaTJqK2+tak0gGmpBWrypAow3gQjx0HEvixMx3DK0v+BZE2/k6c1DyYeoNPz9+nPTcKsF2
	oULJIw3Hzl3BApBaMbKb8Hsbb6+QpBDoRayccIFAuPYeF0LhF/wi37Q+1XlYzXUZfnyoc4RqifY
	d6/4icDbzkCBCQFPoSjiw/KbRI/V7qEi16pOQmwoP+nZV34AwtrCHH6d+dZfFu95jXTqUqLT03e
	NyCW6tW163wSkmGTdae5kpCF9POI3CNUtp43wa83wkUQgHyPcAarwwPr5+lBKboktO2nmPRmaWY
	molIWsLO9WpbrzYHGuqCMU+LACP03lQbYekUUzd/EviloC2G5fpO7jv+Q=
X-Google-Smtp-Source: AGHT+IF59d5GYYpx4VOKuwUgzJ5BNLyqt4IadFejfqDnuxk1Y2oRGUxA032fi9ljWUpPNLgprK4b7A==
X-Received: by 2002:a05:6000:220d:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-429e32c8784mr7110253f8f.5.1762433621744;
        Thu, 06 Nov 2025 04:53:41 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:41 -0800 (PST)
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
Subject: [PATCH RFC 10/17] bpf: Add bcf_alu() 32bits optimization
Date: Thu,  6 Nov 2025 13:52:48 +0100
Message-Id: <20251106125255.1969938-11-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lower symbolic ALU nodes to 32-bit when both operands and the resulting dst
fit in 32 bits, to reduce solver/proof complexity.

- Extend `bcf_alu()` with `op_u32`/`op_s32` hints and derive a `zext` decision:
  when ALU32 or both operands/results fit u32, emit a 32-bit op and zero-extend
  to 64; when signed-32 is in effect, sign-extend to 64 after the op.

- Compute `op_u32`/`op_s32` for pointer and scalar ALUs (using fit_u32/fit_s32)
  before emitting the node, then mask them again with the post-ALU dst range so
  the final node width reflects the verifier’s bounds.

This shrinks many BV nodes and helps keep per-node vlen within limits (U8_MAX),
reducing proof size.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66682d365e5e..df6d16a1c6f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14866,11 +14866,13 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 }
 
 static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
-		   struct bpf_reg_state *src_reg, u8 op, bool alu32)
+		   struct bpf_reg_state *src_reg, u8 op, bool alu32,
+		   bool op_u32, bool op_s32)
 {
 	DEFINE_RAW_FLEX(struct bcf_expr, alu_expr, args, 2);
 	bool unary = (op == BPF_NEG);
 	int dst, src = 0, bits;
+	bool zext = alu32 || op_u32;
 
 	if (!env->bcf.tracking)
 		return 0;
@@ -14879,6 +14881,7 @@ static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
 		return 0;
 	}
 
+	alu32 |= (op_u32 || op_s32);
 	dst = bcf_reg_expr(env, dst_reg, alu32);
 	if (!unary)
 		src = bcf_reg_expr(env, src_reg, alu32);
@@ -14892,8 +14895,11 @@ static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
 	alu_expr->args[0] = dst;
 	alu_expr->args[1] = src;
 	dst_reg->bcf_expr = bcf_add_expr(env, alu_expr);
-	if (alu32)
+	if (zext)
 		bcf_zext_32_to_64(env, dst_reg);
+	else if (op_s32)
+		bcf_sext_32_to_64(env, dst_reg);
+
 	if (dst_reg->bcf_expr < 0)
 		return dst_reg->bcf_expr;
 
@@ -14922,6 +14928,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
 	int ret, bounds_ret;
+	bool op_u32, op_s32;
 
 	dst_reg = &regs[dst];
 	src_reg = dst_reg == ptr_reg ? off_reg : ptr_reg;
@@ -15034,6 +15041,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			if (dst_reg->bcf_expr < 0)
 				return dst_reg->bcf_expr;
 		}
+		op_u32 = fit_u32(dst_reg) && fit_u32(src_reg);
+		op_s32 = fit_s32(dst_reg) && fit_s32(src_reg);
 		/* A new variable offset is created.  Note that off_reg->off
 		 * == 0, since it's a scalar.
 		 * dst_reg gets the pointer type and since some positive
@@ -15062,7 +15071,9 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 
-		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		op_u32 &= fit_u32(dst_reg);
+		op_s32 &= fit_s32(dst_reg);
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false, op_u32, op_s32);
 		if (ret)
 			return ret;
 		break;
@@ -15102,6 +15113,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			if (dst_reg->bcf_expr < 0)
 				return dst_reg->bcf_expr;
 		}
+		op_u32 = fit_u32(dst_reg) && fit_u32(src_reg);
+		op_s32 = fit_s32(dst_reg) && fit_s32(src_reg);
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
@@ -15130,7 +15143,9 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 
-		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		op_u32 &= fit_u32(dst_reg);
+		op_s32 &= fit_s32(dst_reg);
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false, op_u32, op_s32);
 		if (ret)
 			return ret;
 		break;
@@ -15787,6 +15802,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret, dst_expr = dst_reg->bcf_expr;
+	bool op_u32, op_s32;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
@@ -15806,6 +15822,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		if (dst_expr < 0)
 			return dst_expr;
 	}
+	op_u32 = fit_u32(dst_reg) && fit_u32(&src_reg);
+	op_s32 = fit_s32(dst_reg) && fit_s32(&src_reg);
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 	 * There are two classes of instructions: The first class we track both
@@ -15887,7 +15905,9 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	reg_bounds_sync(dst_reg);
 
 	dst_reg->bcf_expr = dst_expr;
-	ret = bcf_alu(env, dst_reg, &src_reg, opcode, alu32);
+	op_u32 &= fit_u32(dst_reg);
+	op_s32 &= fit_s32(dst_reg);
+	ret = bcf_alu(env, dst_reg, &src_reg, opcode, alu32, op_u32, op_s32);
 	if (ret)
 		return ret;
 
-- 
2.34.1


