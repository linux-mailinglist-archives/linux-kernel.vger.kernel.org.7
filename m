Return-Path: <linux-kernel+bounces-794428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D0B3E19A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4405171013
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EE30E0D8;
	Mon,  1 Sep 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AEDUchWI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73F3112B3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726253; cv=none; b=hFu3yC3Y7kpa59NisqvNvc1RYoeFw9ZU8kIplxIYV6q2d43+KsOJgJQG4fesN76cGCay+5TUYcRiuZw3Hk14FXY8JWi0q0RG8C0agv0SiufKtJhKN+wICfYvgBdE0Pje5sWQeuZUUJSQNCmHp/pTdbT1QwfQ/p3sezToy1g3Ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726253; c=relaxed/simple;
	bh=HFpqts/W53QUbSMz1faFreS+L9DMcn6zulFxd1eY3xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpCPybqM1Gq4FIkrgB3e39uGjXqAD28QRGrct+5ys8F1pYNfABuHlQelPsxAs2MTUlrvB+EcABVO90fI5eJUjW3Gnm7g6LzyetrECKbhljNrckH6TlfzD4ITCzR1DNhnB2uNztfj+ASB8J8bWvq3qQbCK747D1hEsJ+OXYhZIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AEDUchWI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1295526b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726251; x=1757331051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=AEDUchWIcCIGp5ys/qBvRdPqPBgUvX9Xsb+ecRHhysdxK1zV6M6vwP7NSK1WKzUeaH
         JnD1ZUgLLuvEshAiiK547hdh1x8zE8nEFQlMBZWwx6MXEQiz4XkSQBMdET3E7L+JJwJ5
         IwARxPBTXPYifr28f6P8cDzK4T/5QUFzlGKrVBIj3R5NZghyOM0vguZRzUPWbSyzA+j3
         TaE5jwfy29jmy5fkEJtDgOqNhjitAdPlZIiUxjykSG/+hTYHvfFxAeOksXYb1Gudq5KG
         dn5Tk0VGcxe2pB4xfRezGRMHqzV7Gd5lw6hiRJnXk24fm595lHDodbNZlBv6mmzc2zis
         FtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726251; x=1757331051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+193yncmANzEfIfweyuJi14B+CiP/3dMuVzUWsZjMz4=;
        b=t3KHdFUsNb9C5wVPtVUgiiLRLNk378JYP5Co204kTBb97TfiUTJKxikukQZxtms5+J
         76iROR9ofchxSeJzFNAxOf/nVb5eEFnLCQAilvtBDvWqmBqg8HYxu1ZHblJ4iYfZ/Yr+
         fbps3XssOTmKTEoTS2dHeCF5u8N5GlASPdAy7frcmJXAPhwxa4b3n7Fi4IKggBb5IY3U
         Bs4K1LaykWudjmFamTiQbQSLQS/dvuFNm9aUjwF3PoPzKfHZHomPllNRjOIomjOnvTei
         5br3LOnSJ/O2B4h0e1uciRlata27wgb3tWDfsM5cZFLrTgkdI+Ctr3MdPzNEgCxGIMGp
         G3xw==
X-Forwarded-Encrypted: i=1; AJvYcCWztdzg86vzUN39e/bwffWi3d5Vo9Aq/vwSPXZymOF1QU2CHUEm3NPNPNp4orMndKoGFSlgKwtoFi9syN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBUJSw4BIjtbw1WBvFsq7ipwbcKpHK7kCgdPubrgEnZwwfqG2
	sW3qpD0byNnsRU9gqzOgbOhYGXItgGd7pMwuElMkidB2uHyELNe9aGCMairx3gpyFoY=
X-Gm-Gg: ASbGncu3dqslDmHApOFAk6P/KKaLkMQiktR/X5LOgpMf1dD09OvLTt1+9w2DekrREDK
	DdzzhFHblrgG0vhHApghS1L+Jov87TfvZgWCx5hA/kYsAbGVpI2e8IMgw9SW8decRtEvhOkifP4
	nDQjyK66yf4akoDg5XdhaKMrSW4X/DCkErZMRrZM0+cJBot1gap6+//NNWlKrxPiwcVq2RQ434p
	zwBGTbEpynCM2Q+mW+6tBt6xt1tR7pRqNK3NwlkdXazans5OhWLnhct7ZZNBkGDP8G1E/EEGZR1
	OzSwnE5RzKfZ3BFAbEluqzbNbi1GLChax3IapipXbiWHVIV9BDGJAjBlGNxbh6TS/PHoPeb+xm2
	9b9pJ8wWyDtjgo2WqaDgZU9cuNolQrRSg1bTK9fnxM/bDRCOedcD3LlTMyf+fm6gB9Revmv/GiO
	+IuVxihaZeVEiPOH44LRp+jFfxJpWz0r/Wj2fEaSbe6r4=
X-Google-Smtp-Source: AGHT+IFCGJaLcCEzCVNOdtTW8pBozzJLUjah4C4TeBuR9DV82igkvDHYVTkOUw8Lz1MGfFCTLIHESQ==
X-Received: by 2002:a05:6a21:32a7:b0:243:ba10:66c7 with SMTP id adf61e73a8af0-243d6e02262mr11191065637.24.1756726251505;
        Mon, 01 Sep 2025 04:30:51 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm2911441b3a.11.2025.09.01.04.30.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:30:51 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 3/4] riscv: Instroduce Zalasr instructions
Date: Mon,  1 Sep 2025 19:30:21 +0800
Message-Id: <20250901113022.3812-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901113022.3812-1-luxu.kernel@bytedance.com>
References: <20250901113022.3812-1-luxu.kernel@bytedance.com>
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


