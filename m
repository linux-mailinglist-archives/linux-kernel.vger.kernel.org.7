Return-Path: <linux-kernel+bounces-870019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0AC09983
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9DFA34DDB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7F3218CC;
	Sat, 25 Oct 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsGl6vNV"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1FA3126C5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409746; cv=none; b=WUsRFLKHvsGUt6QtaONfZyuitfr64n3e/KPQ/Z6evNJv0i3YhyFkhPqBe63P8X9tmau5GePSJrV5htaWlWs7oAItpOY+frGgYUDJKzZQ7DnTlxcsDmtZ4Fl9tv9rNwNB6hAVOQIfh9N0bNDH2BK9C3efy+2g4tgxq31379u9Btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409746; c=relaxed/simple;
	bh=GD9r0peLG2k6Dz8bSnVBhsVzehUcmhQIE13Y757qu+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3lGlmXM/IYfFgtrg5p43FVYuImMzCDKliqIvxXLrV0y3ZrpVjKMRlAXpkQxAVhf2SevYh8swjdYyiEqjhxd5QFcgZd+UkjuMd2QwZoiw45gZp3KSGt9JW4HKouVEyMADxb/J6/7WnQT2eZBXQNieROr4AuwbCMcULqNYV19q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsGl6vNV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89ead335934so135953485a.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409743; x=1762014543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww+ea11r2mZcngIR6hS8TfeQOLbyKE40FtRbqCbDFPg=;
        b=PsGl6vNV9PYk2X5uqMq0IiLez13P/2344KqCF95BJWd5Y/Exxa8KMXUKUnayJofwqS
         p+rpIoxesTyUqvoWO7cj0mJ7UPpRyyr2HfWYE+yOMbhqx/f/DaKO49xqSk1wt2xpDuEo
         YPUQkbQaYik+K8E55ThLxNNjm7oUyOQWI+6B/kwvGzswWSDpOrXob0kZHW2C4oCi3MoB
         L/V/YfQNqEQLj1exBnO5cPuN5I9kC4zvvR5c9ZKJtWk8qAvPtBJk16hhMxw5BknEjZsC
         HxbUaAzja2XH0DtnqNSyuMfeSwY/4WOobME5q+0+RgQJWzo1EmqG++iaWArZSABgbxys
         1YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409743; x=1762014543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww+ea11r2mZcngIR6hS8TfeQOLbyKE40FtRbqCbDFPg=;
        b=tNt3HVEzalGPYVuCOeaJAakERlAu0f/K521VxCPAyx+4q2krxNk7arjj7KUxGKtAGn
         b+4EL74UqOiLkoKJso3bV/8F41cUQJNYJAGXs5ERmZlDA1wEF9wVJKhPRwdjkmftpSEu
         dHJNzJsIuPxAMl71p/aiyzShfkjw1fj/yzgcRlOS1uCYY0PCWEqgvWqur+VxI4jO9Ybn
         syGQhlF+e46OJsRiTAylKWXHrSYnMBmIFmUelZdRJN3GBlGyq3SsKevni8VbhLv9pOx+
         Qn+DhXm+y80BCP2Gs+v/tCWQyjThYw2iuQ1nzNkwBOca+UthAaj89JhWLOBM1X7sIXiX
         5cNg==
X-Forwarded-Encrypted: i=1; AJvYcCXoQAouSRaOtfzfxPBB07DxhKfDhogScpKVb1+RAQsS1CuOvAbsrpcAzi7VCKBPP/podGE9TwCUCPFcBVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkShUONMTTlA6QOczvOMcP/c9yKMoYGpyTwnw3WX9CAaj0qkDy
	UwMfJ4TS98Hg9koVvUDiibyqPFEnqqGfmHk/SJSRqb152Qs0/dunw0g0
X-Gm-Gg: ASbGncttN5cpaV1uFxxJ/JpqIDCdUpmOamiXrW9lAxE5wA3+sNv6d23GSoEYR2iGny2
	hePDk3+7QS0ntMtmFocWAAQ6rbXcBqDyV7OL7PD2w2kjueeGjAqZwo1ZH6VuFiFuC9ofBX9t08k
	Yr0wg6y+bmIit7/CjFadFc1Fg1vH2DQonlDf75NlYvFWvPSp7EbTMh1/Vb9ws5XS18MFz0r9l3j
	Ax7JZUHYyTb6sN0a+I5QSl8snDJ14Kdc+sOAsqrKjM1FFvtG8ZOpFE1mTRW3YOcEYlnv22jv6DQ
	T9sXJXAGu75YMTyfnt+qsSVH/fNyds+ve2fr9gdMRQJdnKeKXUHeGG2w7L1YstkRu8y4zBn6aVr
	bIxBfmXSdKIWIG3doeelK4gLCkfvdwAqhDr4WEbPWG5afLJEvb2/IhuoPgk8S/+MfS/vm2rf+
X-Google-Smtp-Source: AGHT+IHMZ4dTmg9rBoFgf4k6Xv8Sl8LTQqiUABCpUVik33hBUWlLJwkT2aFro3ElO6setbLK2gCNyQ==
X-Received: by 2002:a05:620a:7108:b0:89f:3bd5:cadb with SMTP id af79cd13be357-89f3bd5d9c8mr332094585a.49.1761409743386;
        Sat, 25 Oct 2025 09:29:03 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254abccbsm171351185a.31.2025.10.25.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:02 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Vineet Gupta <vgupta@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 01/21] arc: disasm: rename BITS() for FIELD()
Date: Sat, 25 Oct 2025 12:28:37 -0400
Message-ID: <20251025162858.305236-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/arc/include/asm/disasm.h | 62 +++++++++++++++++------------------
 arch/arc/kernel/disasm.c      | 46 +++++++++++++-------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arc/include/asm/disasm.h b/arch/arc/include/asm/disasm.h
index 61fb4d7affa7..33a0e88e1e8c 100644
--- a/arch/arc/include/asm/disasm.h
+++ b/arch/arc/include/asm/disasm.h
@@ -29,44 +29,44 @@ enum flow {
 };
 
 #define IS_BIT(word, n)		((word) & (1<<n))
-#define BITS(word, s, e)	(((word) >> (s)) & (~((-2) << ((e) - (s)))))
+#define FIELD(word, s, e)	(((word) >> (s)) & (~((-2) << ((e) - (s)))))
 
-#define MAJOR_OPCODE(word)	(BITS((word), 27, 31))
-#define MINOR_OPCODE(word)	(BITS((word), 16, 21))
-#define FIELD_A(word)		(BITS((word), 0, 5))
-#define FIELD_B(word)		((BITS((word), 12, 14)<<3) | \
-				(BITS((word), 24, 26)))
-#define FIELD_C(word)		(BITS((word), 6, 11))
+#define MAJOR_OPCODE(word)	(FIELD((word), 27, 31))
+#define MINOR_OPCODE(word)	(FIELD((word), 16, 21))
+#define FIELD_A(word)		(FIELD((word), 0, 5))
+#define FIELD_B(word)		((FIELD((word), 12, 14)<<3) | \
+				(FIELD((word), 24, 26)))
+#define FIELD_C(word)		(FIELD((word), 6, 11))
 #define FIELD_u6(word)		FIELDC(word)
-#define FIELD_s12(word)		sign_extend(((BITS((word), 0, 5) << 6) | \
-					BITS((word), 6, 11)), 12)
+#define FIELD_s12(word)		sign_extend(((FIELD((word), 0, 5) << 6) | \
+					FIELD((word), 6, 11)), 12)
 
 /* note that for BL/BRcc these two macro's need another AND statement to mask
  * out bit 1 (make the result a multiple of 4) */
-#define FIELD_s9(word)		sign_extend(((BITS(word, 15, 15) << 8) | \
-					BITS(word, 16, 23)), 9)
-#define FIELD_s21(word)		sign_extend(((BITS(word, 6, 15) << 11) | \
-					(BITS(word, 17, 26) << 1)), 12)
-#define FIELD_s25(word)		sign_extend(((BITS(word, 0, 3) << 21) | \
-					(BITS(word, 6, 15) << 11) | \
-					(BITS(word, 17, 26) << 1)), 12)
+#define FIELD_s9(word)		sign_extend(((FIELD(word, 15, 15) << 8) | \
+					FIELD(word, 16, 23)), 9)
+#define FIELD_s21(word)		sign_extend(((FIELD(word, 6, 15) << 11) | \
+					(FIELD(word, 17, 26) << 1)), 12)
+#define FIELD_s25(word)		sign_extend(((FIELD(word, 0, 3) << 21) | \
+					(FIELD(word, 6, 15) << 11) | \
+					(FIELD(word, 17, 26) << 1)), 12)
 
 /* note: these operate on 16 bits! */
-#define FIELD_S_A(word)		((BITS((word), 2, 2)<<3) | BITS((word), 0, 2))
-#define FIELD_S_B(word)		((BITS((word), 10, 10)<<3) | \
-				BITS((word), 8, 10))
-#define FIELD_S_C(word)		((BITS((word), 7, 7)<<3) | BITS((word), 5, 7))
-#define FIELD_S_H(word)		((BITS((word), 0, 2)<<3) | BITS((word), 5, 8))
-#define FIELD_S_u5(word)	(BITS((word), 0, 4))
-#define FIELD_S_u6(word)	(BITS((word), 0, 4) << 1)
-#define FIELD_S_u7(word)	(BITS((word), 0, 4) << 2)
-#define FIELD_S_u10(word)	(BITS((word), 0, 7) << 2)
-#define FIELD_S_s7(word)	sign_extend(BITS((word), 0, 5) << 1, 9)
-#define FIELD_S_s8(word)	sign_extend(BITS((word), 0, 7) << 1, 9)
-#define FIELD_S_s9(word)	sign_extend(BITS((word), 0, 8), 9)
-#define FIELD_S_s10(word)	sign_extend(BITS((word), 0, 8) << 1, 10)
-#define FIELD_S_s11(word)	sign_extend(BITS((word), 0, 8) << 2, 11)
-#define FIELD_S_s13(word)	sign_extend(BITS((word), 0, 10) << 2, 13)
+#define FIELD_S_A(word)		((FIELD((word), 2, 2)<<3) | FIELD((word), 0, 2))
+#define FIELD_S_B(word)		((FIELD((word), 10, 10)<<3) | \
+				FIELD((word), 8, 10))
+#define FIELD_S_C(word)		((FIELD((word), 7, 7)<<3) | FIELD((word), 5, 7))
+#define FIELD_S_H(word)		((FIELD((word), 0, 2)<<3) | FIELD((word), 5, 8))
+#define FIELD_S_u5(word)	(FIELD((word), 0, 4))
+#define FIELD_S_u6(word)	(FIELD((word), 0, 4) << 1)
+#define FIELD_S_u7(word)	(FIELD((word), 0, 4) << 2)
+#define FIELD_S_u10(word)	(FIELD((word), 0, 7) << 2)
+#define FIELD_S_s7(word)	sign_extend(FIELD((word), 0, 5) << 1, 9)
+#define FIELD_S_s8(word)	sign_extend(FIELD((word), 0, 7) << 1, 9)
+#define FIELD_S_s9(word)	sign_extend(FIELD((word), 0, 8), 9)
+#define FIELD_S_s10(word)	sign_extend(FIELD((word), 0, 8) << 1, 10)
+#define FIELD_S_s11(word)	sign_extend(FIELD((word), 0, 8) << 2, 11)
+#define FIELD_S_s13(word)	sign_extend(FIELD((word), 0, 10) << 2, 13)
 
 #define STATUS32_L		0x00000100
 #define REG_LIMM		62
diff --git a/arch/arc/kernel/disasm.c b/arch/arc/kernel/disasm.c
index ccc7e8c39eb3..926b67c40346 100644
--- a/arch/arc/kernel/disasm.c
+++ b/arch/arc/kernel/disasm.c
@@ -100,12 +100,12 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 
 	case op_LD:  /* LD<zz> a,[b,s9] */
 		state->write = 0;
-		state->di = BITS(state->words[0], 11, 11);
+		state->di = FIELD(state->words[0], 11, 11);
 		if (state->di)
 			break;
-		state->x = BITS(state->words[0], 6, 6);
-		state->zz = BITS(state->words[0], 7, 8);
-		state->aa = BITS(state->words[0], 9, 10);
+		state->x = FIELD(state->words[0], 6, 6);
+		state->zz = FIELD(state->words[0], 7, 8);
+		state->aa = FIELD(state->words[0], 9, 10);
 		state->wb_reg = FIELD_B(state->words[0]);
 		if (state->wb_reg == REG_LIMM) {
 			state->instr_len += 4;
@@ -121,11 +121,11 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 
 	case op_ST:
 		state->write = 1;
-		state->di = BITS(state->words[0], 5, 5);
+		state->di = FIELD(state->words[0], 5, 5);
 		if (state->di)
 			break;
-		state->aa = BITS(state->words[0], 3, 4);
-		state->zz = BITS(state->words[0], 1, 2);
+		state->aa = FIELD(state->words[0], 3, 4);
+		state->zz = FIELD(state->words[0], 1, 2);
 		state->src1 = FIELD_C(state->words[0]);
 		if (state->src1 == REG_LIMM) {
 			state->instr_len += 4;
@@ -160,7 +160,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 				is_linked = 1;
 
 			fieldCisReg = 0;
-			op_format = BITS(state->words[0], 22, 23);
+			op_format = FIELD(state->words[0], 22, 23);
 			if (op_format == 0 || ((op_format == 3) &&
 				(!IS_BIT(state->words[0], 5)))) {
 				fieldC = FIELD_C(state->words[0]);
@@ -192,7 +192,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 			break;
 
 		case 40:	/* LPcc */
-			if (BITS(state->words[0], 22, 23) == 3) {
+			if (FIELD(state->words[0], 22, 23) == 3) {
 				/* Conditional LPcc u7 */
 				fieldC = FIELD_C(state->words[0]);
 
@@ -207,12 +207,12 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 			break;
 
 		case 48 ... 55:	/* LD a,[b,c] */
-			state->di = BITS(state->words[0], 15, 15);
+			state->di = FIELD(state->words[0], 15, 15);
 			if (state->di)
 				break;
-			state->x = BITS(state->words[0], 16, 16);
-			state->zz = BITS(state->words[0], 17, 18);
-			state->aa = BITS(state->words[0], 22, 23);
+			state->x = FIELD(state->words[0], 16, 16);
+			state->zz = FIELD(state->words[0], 17, 18);
+			state->aa = FIELD(state->words[0], 22, 23);
 			state->wb_reg = FIELD_B(state->words[0]);
 			if (state->wb_reg == REG_LIMM) {
 				state->instr_len += 4;
@@ -237,7 +237,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 		case 10:	/* MOV */
 			/* still need to check for limm to extract instr len */
 			/* MOV is special case because it only takes 2 args */
-			switch (BITS(state->words[0], 22, 23)) {
+			switch (FIELD(state->words[0], 22, 23)) {
 			case 0: /* OP a,b,c */
 				if (FIELD_C(state->words[0]) == REG_LIMM)
 					state->instr_len += 4;
@@ -258,7 +258,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 		default:
 			/* Not a Load, Jump or Loop instruction */
 			/* still need to check for limm to extract instr len */
-			switch (BITS(state->words[0], 22, 23)) {
+			switch (FIELD(state->words[0], 22, 23)) {
 			case 0: /* OP a,b,c */
 				if ((FIELD_B(state->words[0]) == REG_LIMM) ||
 				    (FIELD_C(state->words[0]) == REG_LIMM))
@@ -281,7 +281,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 
 	/* 16 Bit Instructions */
 	case op_LD_ADD: /* LD_S|LDB_S|LDW_S a,[b,c] */
-		state->zz = BITS(state->words[0], 3, 4);
+		state->zz = FIELD(state->words[0], 3, 4);
 		state->src1 = get_reg(FIELD_S_B(state->words[0]), regs, cregs);
 		state->src2 = get_reg(FIELD_S_C(state->words[0]), regs, cregs);
 		state->dest = FIELD_S_A(state->words[0]);
@@ -289,13 +289,13 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 
 	case op_ADD_MOV_CMP:
 		/* check for limm, ignore mov_s h,b (== mov_s 0,b) */
-		if ((BITS(state->words[0], 3, 4) < 3) &&
+		if ((FIELD(state->words[0], 3, 4) < 3) &&
 		    (FIELD_S_H(state->words[0]) == REG_LIMM))
 			state->instr_len += 4;
 		break;
 
 	case op_S:
-		subopcode = BITS(state->words[0], 5, 7);
+		subopcode = FIELD(state->words[0], 5, 7);
 		switch (subopcode) {
 		case 0:	/* j_s */
 		case 1:	/* j_s.d */
@@ -308,7 +308,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 				direct_call : indirect_jump;
 			break;
 		case 7:
-			switch (BITS(state->words[0], 8, 10)) {
+			switch (FIELD(state->words[0], 8, 10)) {
 			case 4:	/* jeq_s [blink] */
 			case 5:	/* jne_s [blink] */
 			case 6:	/* j_s [blink] */
@@ -367,8 +367,8 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 		/* note: we are ignoring possibility of:
 		 * ADD_S, SUB_S, PUSH_S, POP_S as these should not
 		 * cause unaligned exception anyway */
-		state->write = BITS(state->words[0], 6, 6);
-		state->zz = BITS(state->words[0], 5, 5);
+		state->write = FIELD(state->words[0], 6, 6);
+		state->zz = FIELD(state->words[0], 5, 5);
 		if (state->zz)
 			break;	/* byte accesses should not come here */
 		if (!state->write) {
@@ -385,7 +385,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 
 	case op_GP:	/* LD_S|LDB_S|LDW_S r0,[gp,s11/s9/s10] */
 		/* note: ADD_S r0, gp, s11 is ignored */
-		state->zz = BITS(state->words[0], 9, 10);
+		state->zz = FIELD(state->words[0], 9, 10);
 		state->src1 = get_reg(26, regs, cregs);
 		state->src2 = state->zz ? FIELD_S_s10(state->words[0]) :
 			FIELD_S_s11(state->words[0]);
@@ -405,7 +405,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 		break;
 
 	case op_B_S:
-		fieldA = (BITS(state->words[0], 9, 10) == 3) ?
+		fieldA = (FIELD(state->words[0], 9, 10) == 3) ?
 			FIELD_S_s7(state->words[0]) :
 			FIELD_S_s10(state->words[0]);
 		state->target = fieldA + (addr & ~0x03);
-- 
2.43.0


