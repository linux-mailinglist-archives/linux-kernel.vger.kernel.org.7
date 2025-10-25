Return-Path: <linux-kernel+bounces-870046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304BC09D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE52580D91
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611DD306B1B;
	Sat, 25 Oct 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJoM4DfG"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D683054F0
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410432; cv=none; b=cu8QWbOMxkf71J2yh6RO0xvDCURQQf5dxvpNM7HasmK6wj4gYBxxjhUaLyJB8U/PmQcOVRi6q72IXCM6BARUbU0Xhi8VuxIfHiKdFnkTkBcj3pGPIUetMgKVNYEiD6HnVn1E2C/hnfX6VlK7TvC5x2YIa/b5bLCvXK7aXgevKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410432; c=relaxed/simple;
	bh=GD9r0peLG2k6Dz8bSnVBhsVzehUcmhQIE13Y757qu+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtPikHNkzxlp6SMPyXQanhA6qMUlSuHLbbAaPPEDrBW28kuMp3U/xgzds7bYLWED+p8nb/MvCpgOU+Q7fUiFFd8f0KCxsrVGdp4p8SOhYygIwlW4WDHL7uTMiH7wG3SCj6AMcfC/Dt327fB13mxocdnJ/TeJ0saL24A1JH1Ztpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJoM4DfG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89f54569415so73511485a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410429; x=1762015229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww+ea11r2mZcngIR6hS8TfeQOLbyKE40FtRbqCbDFPg=;
        b=BJoM4DfG9wK31lFgLUsi57DMe3DhvVrSiAC+ylUk1oqVHKZvgCBHvJbRbW8lv2X2g3
         dlY5oWipda1XyIYgmjsCkT10Hg2+NuIKaAX6Lwp39PZbauNI4uA63k0PDrdOOFIsVUPS
         dfeXmWeEYqVPIV48IF7Rv3YccPyHioRjoHSnp2x5kwMrdji+GEQO6Z1kTA4AnyVgDcyl
         /vwM9KwRrdnQAhiDp/Smj+VwrQFyCm1luehyTQT6d62vVkZKPeVkRfxdnHZT6vUL4P0L
         YHXx+79yy2o1cjFlxbfqIbaNv4qph7VSGcKTmKCvM1qOt+3P8DiA0KtHg8ZCHWMkQK4i
         f4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410429; x=1762015229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww+ea11r2mZcngIR6hS8TfeQOLbyKE40FtRbqCbDFPg=;
        b=ZX4s6TnUsR/I2OBZCLKeCnIB7cAfeJorfa8LZFuVX8L9hkn06HakVCl8IylQVHjY6m
         L/Q3f9XHQGPu9BnfaCM5QpqxsttfSIG9T/ooVExqSQXEyV16neU08qdf0nRlMSpQOJCM
         Xk6/s8LEyYVLiQIvI7dPFx4sNFYKM6Dq80ru31pJwi0yh2MvpYxM1dFTk1/Ph1relilI
         j/2OAuRDWxoQQRBaw3Lp101j0nNCEgQmsrIyYllsXlyn/Zr9AbZ8QAaHgoPERRDYKm+1
         0RttWdtPCzDgY6iXnHJgHfdw1qwKEu53B4PzVeGm/SWgNXfT/3IybB5jag7WHLyYm+ki
         SnXg==
X-Forwarded-Encrypted: i=1; AJvYcCX5EyvRBht+RYvflaS+Vbezuzpqj/dlQj/z60Z8gDg2p9n/kcSaz7JSitOQfoh9Ior2cVGLs6w0GTMfiiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2ohQHBk0L7ReH+kc4PaEk7hrP4R+fUkJomDzoxYOZkXr6io1
	+WDsEOy7jGQhpSdVxTT96gxnP1shuPNFShdux8FUtSVD6EbQkbz5A/uk2TDGMA==
X-Gm-Gg: ASbGnctfZjIHOay9vh2KBIt5IjNtac0z9SJJ/Wd30oNx90kC979Tii3UD+xc+I9Dq5e
	Jfzc25tJxawjebud9Ib2i7oqQFEgpayZKi3aiAT1P0zw0GFavmNPR378I9FBfYxCIiDZ4oLmVSw
	Y2v1e9VFi7zdrqTGg5TAFFVy5jihaO4dKRZqRfnMFpc9oFS8UdNJaAGaUXBRsJIW8wrXYbd4H/1
	S30ule11zZ3eWGJpwnsrhrQIJylXWhwFFqrLKFpk2pSw40EIV4IcaRRVhUJ74aaCYudLQgj9fOs
	7jfTRwqDfTDMsK7a7ZZCum9rkzzto6uZmZqIP6XeKCQvD5lKqwSf7nAobT9Q6EHfGfGbChwmRAT
	rFHkofbbUc+3wkqgJlQT34sQ4KRZlStkbiGA30KEmkLm0EU0/ee6EsiUKY2Bce6UOLHfw1KQcrs
	naoeCzQfE=
X-Google-Smtp-Source: AGHT+IHMdqlFeu8BI7FJC9DYq4MkB7WRJcWrEHjGd9KY+lWmSJWGgFzsvJj5kc4aXjfAmRF+KHNOqg==
X-Received: by 2002:a05:620a:2550:b0:82f:10ac:450b with SMTP id af79cd13be357-890707f986emr3891276185a.65.1761410429030;
        Sat, 25 Oct 2025 09:40:29 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd592bsm175393385a.18.2025.10.25.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:28 -0700 (PDT)
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
Date: Sat, 25 Oct 2025 12:40:00 -0400
Message-ID: <20251025164023.308884-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
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


