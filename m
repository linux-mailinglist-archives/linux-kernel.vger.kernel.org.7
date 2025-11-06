Return-Path: <linux-kernel+bounces-888516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F246EC3B0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048E74211CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545993358CA;
	Thu,  6 Nov 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKRJt7A"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491E32E75E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433620; cv=none; b=nNQfknR3QoF50k3mtuO7Kt7ahb7DlzJX2mxQo/ZIRnAdTRIOw5PECtLRfoaKOhQHut7zofy9MFNi/pvaLpkJzD/GmGJJbcBkFhS7Gq2mu+CXHYE0FYUwLFGd+mlPevtLFVGri7M617vjJzmG7du0se98wg9ltuLUXzx30Ng+MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433620; c=relaxed/simple;
	bh=qoilpeljCvPQlUDiBXIQ3DZYfxhU4fylmaiXskS/+os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBd+tjpqLFTCsWdqwoHRL2Nw/QQxLwgrMcdutxmv5PCdL0vk3ndDV6dxh/YvrIhwJGTy9sElqbYw6BL0MBh1QNMduMMEB8SQ14umDeNz+2rcGhPxApvydwL40/r+qaQnK+dzXrCO+1z/+zrha9krw6pALCeEOop71KQnb1TxM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuKRJt7A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso4068855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433616; x=1763038416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpM6NCHkSKQ5mxm/ZfH0Q/wE6qOhVyZUTPoMaF9H0do=;
        b=FuKRJt7AoYPcewJgxCxaz3rxYV98Q6NfO1Yxix2uQ3mF2uJ9FZT+wZuJ7t0wonYmRR
         GL0C1NK2xLwjX5GRuiVCyrfy57NkSRJt3AjbOLa3VCB4BD0SwlDSmaIXA7g65GY4z+tD
         DrRUBg34VTYT/m7TLJ0Nx9eVDrccfZoZnyFjqhmMtcm3agHyXWEKZ4Ii/1YcMt4upgTS
         Sz4rheXuGuS4CdRqQeys+/Lsrfa1fBE73iVfR0hHeNn2y0cJ2NSh15A+VtI7z0zt1jAb
         UrNl20WfPTpPQmkjuUDzDA3R0cI0d61t0yXvIg/DWgH1f6errUX1oJbSlOMuFn5eMJVg
         S2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433616; x=1763038416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpM6NCHkSKQ5mxm/ZfH0Q/wE6qOhVyZUTPoMaF9H0do=;
        b=CGEu2kedsc9n/oxHtbtTcNUyoist8REO8Fybay40K85/H63DPhXgl/ad+Pl25xFRjw
         +ssFXir+KTSuSYrBF8O/AQ4NWA9QaQJbnarUIjj+x2bxILlK3/0+EuBsq1j/z1vpW264
         xhxEYplzKUYfejkR3qxq7YPFgLLt96W8EP+LwULyR40bPvUXLWRmln7COr3MOAv887si
         mTiVnDCnwzGQ2SbFEvLEL5P+dJgpXIowbaBhK0jn6SPyrNQrjrgRlLxKWrp8NAHAIKKg
         l3XTtwX596YXrloDgjNaq57dgJGSjbRYsKpOn+kNZsVD5T5+Ok9Y63vm9klViR2e3qFR
         9KMw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gn1iAbQdQe5L2S/wCJFnpvRLUC+SpQ1qLWuGvrfEFAjSxPoRfkHn89jYPlHW6Rd/vpgCjmTQyltDE5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SxpXwRBYbsofhkOpdXupjyX5Y+gHYQd+AfjASS3A6xxBBF+o
	ZYBXfBb9Js+H6QXCBY1bdIb4mLW98X+J9Rm/RKykjSDxgcIxvSTf8XA=
X-Gm-Gg: ASbGncvdy+2Lhig4cFey2biXrLUxo5jfDRJznsBpTyYSbw3p+9HFzZaUX0c2TXbLcHv
	faAODfzpT/KaLM0V3NZAvwRK6XltSWlY5Gsp+V5NBIqM7uaYwIIHzNIMQQAfCV8WM+pMMQovIqL
	qUOXc0Tzp/K8prWXlMArD4HdTQax736ilG/ZAc9l87NHBvogzYXwFnOUaBCVMwzTKmz9LhgURlX
	fRVm8h8+Nf2hTeGMcJGgkxKaxT/4zk5JaLv4+mp7NnecxxgAEqy+6DjHjUYTRsZtDH4+g99ZVpo
	aQgVIP3ex20sVeiJtVrqOcs8DytZvHZnDJi01JWTemfP0wE/eKiJjgKp2W+Bg7cm7jOmN3qW5OK
	VNIcyMUxXFPRR0oZLXL7xo2t6u0iQrWlb32iC4uwIpXVkNmkWGFEaAvUd75YzVJ7r3KiPriXuJJ
	qAV9d655bRNY8xCNlkqdRVdxwVLEH1Jh1wlvDCWdBUVdwRZD0YW7BlDxk=
X-Google-Smtp-Source: AGHT+IF2FVn/XgqY2wbn9JXv1izwwwhwPAjKfxLHTcwdcdDDPlOnsWlzWAekdlibP7ZK/jVHh5i06g==
X-Received: by 2002:a05:600c:6219:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-47767cad1a3mr16460225e9.36.1762433616190;
        Thu, 06 Nov 2025 04:53:36 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:35 -0800 (PST)
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
Subject: [PATCH RFC 01/17] bpf: Add BCF expr and proof rule definitions
Date: Thu,  6 Nov 2025 13:52:39 +0100
Message-Id: <20251106125255.1969938-2-hao.sun@inf.ethz.ch>
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

This patch adds include/uapi/linux/bcf.h with:

- Expression node format:
  struct bcf_expr { u8 code; u8 vlen; u16 params; u32 args[]; }
  * code encodes (operation(5 bits)| type (3 bits)). The op first reuses
    all the bpf encoding, e.g., BPF_ADD/BPF_SUB, and then, extends it
    with bitvector specific ops, e.g., extract.
  * args[] holds u32 indices into the same arena (DAG by backwards indices);
    BV VAL is the only op whose args carry immediates.
  * params packs op-specific fields; helpers are provided to access
    bit widths, extract ranges, extension sizes, boolean literal bits.

- Proof buffer layout and rule ids:
  * struct bcf_proof_header { magic=BCF_MAGIC, expr_cnt, step_cnt }.
  * struct bcf_proof_step { u16 rule; u8 premise_cnt; u8 param_cnt; u32 args[] };
    args[] is (premise ids followed by parameters).
  * Rule classes are ORed into rule (BCF_RULE_CORE/BOOL/BV).

This patch is UAPI-only; no kernel behavior change.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/uapi/linux/bcf.h | 197 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 include/uapi/linux/bcf.h

diff --git a/include/uapi/linux/bcf.h b/include/uapi/linux/bcf.h
new file mode 100644
index 000000000000..459ad3ed5c6f
--- /dev/null
+++ b/include/uapi/linux/bcf.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__LINUX_BCF_H__
+#define _UAPI__LINUX_BCF_H__
+
+#include <linux/types.h>
+#include <linux/bpf.h>
+
+/* Expression Types */
+#define BCF_TYPE(code)	((code) & 0x07)
+#define BCF_BV		0x00	/* Bitvector */
+#define BCF_BOOL	0x01	/* Boolean */
+#define BCF_LIST	0x02	/* List of vals */
+#define __MAX_BCF_TYPE	0x03
+
+#define BCF_OP(code)	((code) & 0xf8)
+/* Common Operations */
+#define BCF_VAL		0x08	/* Value/Constant */
+#define BCF_VAR		0x18	/* Variable */
+#define BCF_ITE		0x28	/* If-Then-Else */
+
+/* Bitvector Operations */
+#define BCF_SDIV	0xb0
+#define BCF_SMOD	0xd0
+#define BCF_EXTRACT	0x38	/* Bitvector extraction */
+#define BCF_SIGN_EXTEND	0x48	/* Sign extension */
+#define BCF_ZERO_EXTEND	0x58	/* Zero extension */
+#define BCF_BVSIZE	0x68	/* Bitvector size */
+#define BCF_BVNOT	0x78	/* Bitvector not */
+#define BCF_FROM_BOOL	0x88	/* Bool list to Bitvector */
+#define BCF_CONCAT	0x98	/* Concatenation */
+#define BCF_REPEAT	0xa8	/* Bitvector repeat */
+
+/* Boolean Operations */
+#define BCF_CONJ	0x00	/* Conjunction (AND) */
+#define BCF_DISJ	0x40	/* Disjunction (OR) */
+#define BCF_NOT		0x80	/* Negation */
+#define BCF_IMPLIES	0x90	/* Implication */
+#define BCF_XOR		0x38	/* Exclusive OR */
+#define BCF_BITOF	0x48	/* Bitvector to Boolean */
+
+/* Boolean Literals/Vals */
+#define BCF_FALSE	0x00
+#define BCF_TRUE	0x01
+
+/**
+ * struct bcf_expr - BCF expression structure
+ * @code: Operation code (operation | type)
+ * @vlen: Argument count
+ * @params: Operation parameters
+ * @args: Argument indices
+ *
+ * Parameter encoding by type:
+ * - Bitvector: [7:0] bit width, except:
+ *	- [15:8] and [7:0] extract `start` and `end` for EXTRACT;
+ *	- [15:8] repeat count for REPEAT;
+ *	- [15:8] extension size for SIGN/ZERO_EXTEND
+ * - Boolean:
+ *	- [0] literal value for constants;
+ *	- [7:0] bit index for BITOF.
+ * - List: element type encoding:
+ *	- [7:0] for types;
+ *	- [15:8] for type parameters, e.g., bit width.
+ */
+struct bcf_expr {
+	__u8	code;
+	__u8	vlen;
+	__u16	params;
+	__u32	args[];
+};
+
+#define BCF_PARAM_LOW(p)	((p) & 0xff)
+#define BCF_PARAM_HIGH(p)	(((p) >> 8) & 0xff)
+
+/* Operation-specific parameter meanings */
+#define BCF_BV_WIDTH(p)		BCF_PARAM_LOW(p)
+#define BCF_EXT_LEN(p)		BCF_PARAM_HIGH(p)
+#define BCF_EXTRACT_START(p)	BCF_PARAM_HIGH(p)
+#define BCF_EXTRACT_END(p)	BCF_PARAM_LOW(p)
+#define BCF_REPEAT_N(p)		BCF_PARAM_HIGH(p)
+#define BCF_BOOL_LITERAL(p)	((p) & 1)
+#define BCF_BITOF_BIT(p)	BCF_PARAM_LOW(p)
+#define BCF_LIST_TYPE(p)	BCF_PARAM_LOW(p)
+#define BCF_LIST_TYPE_PARAM(p)	BCF_PARAM_HIGH(p)
+
+/* BCF proof definitions */
+#define BCF_MAGIC	0x0BCF
+
+struct bcf_proof_header {
+	__u32	magic;
+	__u32	expr_cnt;
+	__u32	step_cnt;
+};
+
+/**
+ * struct bcf_proof_step - Proof step
+ * @rule: Rule identifier (class | rule)
+ * @premise_cnt: Number of premises
+ * @param_cnt: Number of parameters
+ * @args: Arguments (premises followed by parameters)
+ */
+struct bcf_proof_step {
+	__u16	rule;
+	__u8	premise_cnt;
+	__u8	param_cnt;
+	__u32	args[];
+};
+
+/* Rule Class */
+#define BCF_RULE_CLASS(r)	((r) & 0xe000)
+#define BCF_RULE_CORE		0x0000
+#define BCF_RULE_BOOL		0x2000
+#define BCF_RULE_BV		0x4000
+
+#define BCF_STEP_RULE(r)	((r) & 0x1fff)
+
+/* Core proof rules */
+#define BCF_CORE_RULES(FN)  \
+	FN(ASSUME)          \
+	FN(EVALUATE)        \
+	FN(DISTINCT_VALUES) \
+	FN(ACI_NORM)        \
+	FN(ABSORB)          \
+	FN(REWRITE)         \
+	FN(REFL)            \
+	FN(SYMM)            \
+	FN(TRANS)           \
+	FN(CONG)            \
+	FN(TRUE_INTRO)      \
+	FN(TRUE_ELIM)       \
+	FN(FALSE_INTRO)     \
+	FN(FALSE_ELIM)
+
+#define BCF_RULE_NAME(x) BCF_RULE_##x
+#define BCF_RULE_ENUM_VARIANT(x) BCF_RULE_NAME(x),
+
+enum bcf_core_rule {
+	BCF_RULE_CORE_UNSPEC = 0,
+	BCF_CORE_RULES(BCF_RULE_ENUM_VARIANT)
+	__MAX_BCF_CORE_RULES,
+};
+
+/* Boolean proof rules */
+#define BCF_BOOL_RULES(FN)   \
+	FN(RESOLUTION)       \
+	FN(FACTORING)        \
+	FN(REORDERING)       \
+	FN(SPLIT)            \
+	FN(EQ_RESOLVE)       \
+	FN(MODUS_PONENS)     \
+	FN(NOT_NOT_ELIM)     \
+	FN(CONTRA)           \
+	FN(AND_ELIM)         \
+	FN(AND_INTRO)        \
+	FN(NOT_OR_ELIM)      \
+	FN(IMPLIES_ELIM)     \
+	FN(NOT_IMPLIES_ELIM) \
+	FN(EQUIV_ELIM)       \
+	FN(NOT_EQUIV_ELIM)   \
+	FN(XOR_ELIM)         \
+	FN(NOT_XOR_ELIM)     \
+	FN(ITE_ELIM)         \
+	FN(NOT_ITE_ELIM)     \
+	FN(NOT_AND)          \
+	FN(CNF_AND_POS)      \
+	FN(CNF_AND_NEG)      \
+	FN(CNF_OR_POS)       \
+	FN(CNF_OR_NEG)       \
+	FN(CNF_IMPLIES_POS)  \
+	FN(CNF_IMPLIES_NEG)  \
+	FN(CNF_EQUIV_POS)    \
+	FN(CNF_EQUIV_NEG)    \
+	FN(CNF_XOR_POS)      \
+	FN(CNF_XOR_NEG)      \
+	FN(CNF_ITE_POS)      \
+	FN(CNF_ITE_NEG)      \
+	FN(ITE_EQ)
+
+enum bcf_bool_rule {
+	BCF_RULE_BOOL_UNSPEC = 0,
+	BCF_BOOL_RULES(BCF_RULE_ENUM_VARIANT)
+	__MAX_BCF_BOOL_RULES,
+};
+
+/* Bitvector proof rules */
+#define BCF_BV_RULES(FN) \
+	FN(BITBLAST)     \
+	FN(POLY_NORM)    \
+	FN(POLY_NORM_EQ)
+
+enum bcf_bv_rule {
+	BCF_RULE_BV_UNSPEC = 0,
+	BCF_BV_RULES(BCF_RULE_ENUM_VARIANT)
+	__MAX_BCF_BV_RULES,
+};
+#undef BCF_RULE_ENUM_VARIANT
+
+#endif /* _UAPI__LINUX_BCF_H__ */
--
2.34.1


