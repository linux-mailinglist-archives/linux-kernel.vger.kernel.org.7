Return-Path: <linux-kernel+bounces-786867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C8B36D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19C3986ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3526CE04;
	Tue, 26 Aug 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aDoG1otJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61291267B12
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220285; cv=none; b=j6uVhBD1Bnjret4BH6w+E0MmW2tTNpJjzsqoOFMNfb3CwTIRNLr6VnCa6ezwYZeg9nCePZQ57uUtd8knOag6xUkR410EGDSt2sQ4aEBsvbYey9smOAUfgRzrHSv/UMk97PTFy8vNfpDOKKmFRnZhXa5CAc96Qimzme8WZLYJMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220285; c=relaxed/simple;
	bh=HFpqts/W53QUbSMz1faFreS+L9DMcn6zulFxd1eY3xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lC0tAGg3OBrpPdjF3z0/edA6LXmB+Q8Cx6RuRjW/dOehXbxEfmIA8n/kFtmueZZCQtdGFs4cdIPwsBtHbsEEyya3fHPerCwrF2HWjICHSDdVQV1wh5k+fgjFZwtxshj2bmVhx9pZ8jWBCjrBLDQS6WhfdY1eIUNN6PTiRjJWhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aDoG1otJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266d6f57so6108897a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756220283; x=1756825083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=aDoG1otJVvdL7FA3oO9ZxYQ91W6tjqlUOSj7zhhJW38wsxoACZEQIFBeCiSQLsPZav
         d+YAB5jm+f5BG/eMlza3NAWx2vHmWEq29zbjpLxdR7C5lpLcBVnLznm5dVA39fRrOQNh
         quZOYmdRm+UeEjBtgvmSJGBdDBsggckkwA9148Zlt2hXNPRAMt5Y0MSzWRPjwqRgUfmm
         E+gPXfArLLHhDiphRHtsGaHS2GBF3j2wH+qSuKQmeZzY33H3UMTiKVEO4CzV7KNcuc3d
         7aKaACqJVp2wRCwNkPsrYSoA59ABsEHwIurySqnWf04bKY5Yh+2JuazRFIZNPXPFWftg
         egZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220283; x=1756825083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=baywVbdgbep4Cp8XSI8HP7GFUn7vlHaMoayCgRtmvKwDivanBa+m1RUEbEmT/ybe33
         fzLbYEP5iZZf+B4FKztrVppWQ57LlHE/oFbIua+BwxOUAQagVi9MCcKBqs14domKCv6o
         a1awitzpblEEZ/xl2P1Sj82HLet+AtceHSiXcXQvaEROd1C0fUm3hoExy350PWe+PJFh
         qi8uHmv03/WqoCVtbzf6PY9rYIFEJeqrrtNFPsL+CzdezdLrMYbeJrsWX4nOCHZKNRAe
         iYBHalYyjDBPzY7fbfNIZ1d7eUg3guJ61dRomduFxQUp3fVyQ6RKjEI6NLPR9UB9APfd
         5jeg==
X-Forwarded-Encrypted: i=1; AJvYcCXs/lUpDn7z8HzBfZeI4GyaIXLNUvkmJjNFxFUrBrLxYX7ili3CcXAJv7gbLBHkXYnHNPU5OU9UbgFV90Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScAhnqSQT6oTGldTld7wqUaPc1thzntXmO2tCvhNGtG+1bGTX
	yYsAVKZcdzb8WoA6Hz0uSF/XrDkVELbNr93tqY+YuMRV0GjufqicADPISYKffosbxGY=
X-Gm-Gg: ASbGncsZcwga3AI028mCxEEygUL63CL3pevF51s78Chc6Q9V4DRcd9Q0Jv9hW9zJ94N
	t+9qQZOu12sHTVIGD62n+3W11IF3nvORtxqmGc8XtALJolT6XlxPF6UrGHJKQOR7VuJ50U/s4Bm
	Bf2XMGZbn6lEG5PIz8+IpLpG1GzDLOsjXOjDntrpZGGGEbpY3w1YGHqxlenITknleJNt4/HPuya
	h9F1eb3e0Kc+uMkk5CXwZjnNw6tYA3XWL2HElYtmg0eoTIHOIAPWkqRu8krTT//bC0W7jYFQARJ
	NmV/1d4HKkiufKffwlCJ8y5GOxViukq2ZMdCO7EktkxEuqhS78ucnIzYPQLUzWVVZ2zElUyg6Oa
	zRguWjoWW+FAck6f8LZoUMOlivbTanyj44c7/YNi0mvv18AZAkKRodcXyOg8t8CjXjay66hXCsK
	ghhyGIB47L3glWFdok0McDLBoIMONF6BvlM0zRMAQuCeM=
X-Google-Smtp-Source: AGHT+IEK74/H7i+pm+ElxdqKUAWaljy20bQHmKN9LNI2P2UnYFqvX6w5e2Ez76kdAVKy0Zr9pixfFQ==
X-Received: by 2002:a17:90b:17d2:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-32515ef7240mr21352988a91.12.1756220282060;
        Tue, 26 Aug 2025 07:58:02 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7209799b3a.1.2025.08.26.07.57.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 07:58:01 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 3/4] riscv: Instroduce Zalasr instructions
Date: Tue, 26 Aug 2025 22:57:39 +0800
Message-Id: <20250826145740.92276-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826145740.92276-1-luxu.kernel@bytedance.com>
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce l{b|h|w|d}.{aq|aqrl} and s{b|h|w|d}.{rl|aqrl} instruction
encodings.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/insn-def.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index d5adbaec1d010..3fec7e66ce50f 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -179,6 +179,7 @@
 #define RV___RS1(v)		__RV_REG(v)
 #define RV___RS2(v)		__RV_REG(v)
 
+#define RV_OPCODE_AMO		RV_OPCODE(47)
 #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
 #define RV_OPCODE_OP_IMM	RV_OPCODE(19)
 #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
@@ -208,6 +209,84 @@
 	__ASM_STR(.error "hlv.d requires 64-bit support")
 #endif
 
+#define LB_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LB_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LH_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LW_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SB_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SB_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SH_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SW_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#ifdef CONFIG_64BIT
+#define LD_AQ(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(26),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define LD_AQRL(dest, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(27),			\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#define SD_RL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(29),			\
+	       __RD(0), RS1(addr), RS2(src))
+
+#define SD_AQRL(src, addr)					\
+	INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(31),			\
+	       __RD(0), RS1(addr), RS2(src))
+#else
+#define LD_AQ(dest, addr)					\
+	__ASM_STR(.error "ld.aq requires 64-bit support")
+
+#define LD_AQRL(dest, addr)					\
+	__ASM_STR(.error "ld.aqrl requires 64-bit support")
+
+#define SD_RL(dest, addr)					\
+	__ASM_STR(.error "sd.rl requires 64-bit support")
+
+#define SD_AQRL(dest, addr)					\
+	__ASM_STR(.error "sd.aqrl requires 64-bit support")
+#endif
+
 #define SINVAL_VMA(vaddr, asid)					\
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(11),		\
 	       __RD(0), RS1(vaddr), RS2(asid))
-- 
2.20.1


